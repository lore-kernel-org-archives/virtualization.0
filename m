From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [PATCH v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 26 May 2020 15:38:52 +0800
Message-ID: <03d3387f-c886-4fb9-e6f2-9ff8dc6bb80a@huawei.com>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-3-longpeng2@huawei.com>
 <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Markus,

On 2020/5/26 15:19, Markus Elfring wrote:
>> The system'll crash when the users insmod crypto/tcrypto.ko with mode=155
>> ( testing "authenc(hmac(sha1),cbc(aes))" ). It's caused by reuse the memory
>> of request structure.
> 
> Wording adjustments:
> * … system will crash …
> * … It is caused by reusing the …
> 
> 
>> when these memory will be used again.
> 
> when this memory …
> 
OK.

> 
>> … Thus release specific resources before
> 
> Is there a need to improve also this information another bit?
> 
You mean the last two paragraph is redundant ?
'''
When the virtio_crypto driver finish skcipher req, it'll call ->complete
callback(in crypto_finalize_skcipher_request) and then free its
resources whose pointers are recorded in 'skcipher parts'.

However, the ->complete is 'crypto_authenc_encrypt_done' in this case,
it will use the 'ahash part' of the request and change its content,
so virtio_crypto driver will get the wrong pointer after ->complete
finish and mistakenly free some other's memory. So the system will crash
when these memory will be used again.

The resources which need to be cleaned up are not used any more. But the
pointers of these resources may be changed in the function
"crypto_finalize_skcipher_request". Thus release specific resources before
calling this function.
'''

How about:
'''
When the virtio_crypto driver finish the skcipher request, it will call the
function "crypto_finalize_skcipher_request()" and then free the resources whose
pointers are stored in the 'skcipher parts', but the pointers of these resources
 may be changed in that function. Thus fix it by releasing these resources
befored calling the function "crypto_finalize_skcipher_request()".
'''


> Regards,
> Markus
> 
---
Regards,
Longpeng(Mike)
