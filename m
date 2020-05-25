From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [PATCH 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Mon, 25 May 2020 15:13:24 +0800
Message-ID: <a17850bb-f70d-1f77-3823-afd70816ce57@huawei.com>
References: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <a5ef5d51-e35c-983f-8e7f-5f19552abe9e@web.de>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Arei Gonglei <arei.gonglei@huawei.com>, Corentin Labbe <clabbe@baylibre.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Markus,

On 2020/5/25 14:30, Markus Elfring wrote:
>> … So the system will crash
>> at last when this memory be used again.
> 
> I would prefer a wording with less typos here.
> 
Could you help me to make the sentence better?

> 
>> We can free the resources before calling ->complete to fix this issue.
> 
> * An imperative wording can be nicer.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=9cb1fd0efd195590b828b9b865421ad345a4a145#n151
> 
I'll try.

> * You proposed to move a call of the function “crypto_finalize_skcipher_request”.
>   How does this change fit to the mentioned position?
> 
The resources which need to be freed is not used anymore, but the pointers
of these resources may be changed in the function
"crypto_finalize_skcipher_request", so free these resources before call the
function is suitable.

> * Would you like to add the tag “Fixes” to the commit message?
>
OK.

> Regards,
> Markus
> 

-- 
---
Regards,
Longpeng(Mike)
