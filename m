From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [PATCH v2 1/2] crypto: virtio: Fix src/dst scatterlist
 calculation in __virtio_crypto_skcipher_do_req()
Date: Tue, 26 May 2020 15:21:05 +0800
Message-ID: <e1864c6d-6380-831f-9c2f-85611a78779b@huawei.com>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-2-longpeng2@huawei.com>
 <d58a046a-e559-55be-16ba-64db43a06568@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <d58a046a-e559-55be-16ba-64db43a06568@web.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Markus,

On 2020/5/26 15:03, Markus Elfring wrote:
>> Fix it by sg_next() on calculation of src/dst scatterlist.
> 
> Wording adjustment:
> … by calling the function “sg_next” …
> 
OK, thanks.

> 
> …
>> +++ b/drivers/crypto/virtio/virtio_crypto_algs.c
>> @@ -350,13 +350,18 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
> …
>>  	src_nents = sg_nents_for_len(req->src, req->cryptlen);
>> +	if (src_nents < 0) {
>> +		pr_err("Invalid number of src SG.\n");
>> +		return src_nents;
>> +	}
>> +
>>  	dst_nents = sg_nents(req->dst);
> …
> 
> I suggest to move the addition of such input parameter validation
> to a separate update step.
> 
Um...The 'src_nents' will be used as a loop condition, so validate it here is
needed ?

'''
 	/* Source data */
-	for (i = 0; i < src_nents; i++)
-		sgs[num_out++] = &req->src[i];
+	for (sg = req->src; src_nents; sg = sg_next(sg), src_nents--)
+		sgs[num_out++] = sg;
'''

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)
