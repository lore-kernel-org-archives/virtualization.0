From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Mon, 25 May 2020 16:03:00 +0800
Message-ID: <c81e5d74-b664-8941-149f-8b916986e8cf@huawei.com>
References: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
 <a17850bb-f70d-1f77-3823-afd70816ce57@huawei.com>
 <cbd8ab27-71c3-2fb0-2fa3-263901596773@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <cbd8ab27-71c3-2fb0-2fa3-263901596773@web.de>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



On 2020/5/25 15:36, Markus Elfring wrote:
>> Could you help me to make the sentence better?
> 
> How do you think about a wording variant like the following?
> 
>   So the system will crash when this memory will be used again.
> 
Uh, it's much better, thanks.

> 
>>> * You proposed to move a call of the function “crypto_finalize_skcipher_request”.
>>>   How does this change fit to the mentioned position?
>>>
>> The resources which need to be freed is not used anymore, but the pointers
>> of these resources may be changed in the function
>> "crypto_finalize_skcipher_request", so free these resources before call the
>> function is suitable.
> 
> Another alternative:
>   The resources which need to be cleaned up are not used any more.
>   But the pointers of these resources may be changed in the
>   function “crypto_finalize_skcipher_request”.
>   Thus release specific resources before calling this function.
> 
Oh great! Thanks.

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)
