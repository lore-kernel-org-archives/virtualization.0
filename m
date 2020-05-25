From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [PATCH 1/2] crypto: virtio: Fix src/dst scatterlist calculation
 in __virtio_crypto_skcipher_do_req()
Date: Mon, 25 May 2020 14:46:25 +0800
Message-ID: <7b2ac2f8-7d92-1bd7-8ad8-9866d9b1d634@huawei.com>
References: <21478291-9191-1da3-a7e5-65e87c743a3c@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <21478291-9191-1da3-a7e5-65e87c743a3c@web.de>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Markus,

On 2020/5/25 14:05, Markus Elfring wrote:
>> The system will crash when we insmod crypto/tcrypt.ko whit mode=38.
> 
> * I suggest to use the word “with” in this sentence.
> 
OK, it's a typo.

> * Will it be helpful to explain the passed mode number?
> 
> 
>> BTW I add a check for sg_nents_for_len() its return value since
>> sg_nents_for_len() function could fail.
> 
> Please reconsider also development consequences for this suggestion.
> Will a separate update step be more appropriate for the addition of
> an input parameter validation?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=9cb1fd0efd195590b828b9b865421ad345a4a145#n138
> 
> Would you like to add the tag “Fixes” to the commit message?
>
Will take all of your suggestions in v2, thanks.

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)
