// The 'shamir' program.

//ensure privateness of the shards
//and records owned by addresses that has the shares

//the process of restoring the secret. 
//we have to use mappings

//5 people have shards, I want to get back my secret

program shamir.aleo {

    inline calc_poly(secret: field, c1:field, c2:field, x:field) -> field {
        return c1 * x*x  + c2 * x + secret;
    }

    record SecretPart {
        owner: address,
        x: field,
        y: field,
    }

    struct Share {
        x: field,
        y: field,
    }

    transition create_shares(
                        secret: field,
                        threshold: u8, //for now only 3
                        seed: field,
                        receivers: [address; 5]) -> (SecretPart, SecretPart, SecretPart, SecretPart, SecretPart) {

        //check the list of addresses. The count non-zero addresses should be >= than threshold.
        let zero_address: address = 0field as address;
        let receiver_count: u8 = 0u8;
        for i:u8 in 0u8..4u8 {
            if receivers[i] != zero_address {
                receiver_count += 1u8;
            }
        }
        assert(threshold <= receiver_count);

        //define a polynomial (thresdhold = 3, we need 2 coefficients)
        let rand1:field = BHP256::hash_to_field(seed);
        let rand2:field = BHP256::hash_to_field(seed + 1field);

        //create 5 share records (secretparts)
        let s1:SecretPart = SecretPart{
            owner: receivers[0u8], 
            x: 1field, 
            y: calc_poly(secret, rand1, rand2, 1field),
        };

        let s2:SecretPart = SecretPart{
            owner: receivers[1u8], 
            x: 2field, 
            y: calc_poly(secret, rand1, rand2, 2field),
        };

        let s3:SecretPart = SecretPart{
            owner: receivers[2u8], 
            x: 3field, 
            y: calc_poly(secret, rand1, rand2, 3field),
        };

        let s4:SecretPart = SecretPart{
            owner: receivers[3u8], 
            x: 4field, 
            y: calc_poly(secret, rand1, rand2, 4field),
        };

        let s5:SecretPart = SecretPart{
            owner: receivers[4u8], 
            x: 5field, 
            y: calc_poly(secret, rand1, rand2, 5field),
        };

        //return the tuple of SecretParts
        return (s1, s2, s3, s4, s5);
    }

    // restoring a secret from minimum amount of shares - for 3 shares only
    transition restore_secret_from_shares(s1:Share, s2:Share, s3:Share) -> field {
        return s1.y * (0field - s2.x) / (s1.x - s2.x) * (0field - s3.x) / (s1.x - s3.x) + s2.y * (0field - s1.x) / (s2.x - s1.x) * (0field - s3.x) / (s2.x - s3.x) + s3.y * (0field - s1.x) / (s3.x - s1.x) * (0field - s2.x) / (s3.x - s2.x);
    }

    // restoring a secret from minimum amount of shares - general solution
    transition restore_secret_from_n_shares(share_count:u8, shares:[Share; 5]) -> field {
        //linear
        if share_count == 2u8 {
           return shares[0u8].y * (0field - shares[1u8].x) / (shares[0u8].x - shares[1u8].x) + shares[1u8].y * (0field - shares[0u8].x) / (shares[1u8].x - shares[0u8].x);        
        }

        // quadratic polynom
        if share_count == 3u8 {
          return shares[0u8].y * (0field - shares[1u8].x) / (shares[0u8].x - shares[1u8].x) * (0field - shares[2u8].x) / (shares[0u8].x - shares[2u8].x) + shares[1u8].y * (0field - shares[0u8].x) / (shares[1u8].x - shares[0u8].x) * (0field - shares[2u8].x) / (shares[1u8].x - shares[2u8].x) + shares[2u8].y * (0field - shares[0u8].x) / (shares[2u8].x - shares[0u8].x) * (0field - shares[1u8].x) / (shares[2u8].x - shares[1u8].x);
        }

        //TODO: implement for higher coefficients
        return 0field;
    }



    // unfortunately, restoring from records couldn't be accomplished - can't have records with different signers as input.
    transition restore_secret(s1:SecretPart, s2:SecretPart, s3:SecretPart) -> field {
        return s1.y * (0field - s2.x) / (s1.x - s2.x) * (0field - s3.x) / (s1.x - s3.x) + s2.y * (0field - s1.x) / (s2.x - s1.x) * (0field - s3.x) / (s2.x - s3.x) + s3.y * (0field - s1.x) / (s3.x - s1.x) * (0field - s2.x) / (s3.x - s2.x);
    }

}