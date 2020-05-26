From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 26 May 2020 17:24:03 +0800
Message-ID: <321c79df-6397-bbf1-0047-b0b10e5af353@huawei.com>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-3-longpeng2@huawei.com>
 <0248e0f6-7648-f08d-afa2-170ad2e724b7@web.de>
 <03d3387f-c886-4fb9-e6f2-9ff8dc6bb80a@huawei.com>
 <8aab4c6b-7d41-7767-4945-e8af1dec902b@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8aab4c6b-7d41-7767-4945-e8af1dec902b@web.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Corentin Labbe <clabbe@baylibre.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



On 2020/5/26 17:01, Markus Elfring wrote:
>>>> … Thus release specific resources before
>>>
>>> Is there a need to improve also this information another bit?
>>>
>> You mean the last two paragraph is redundant ?
> 
> No.
> 
> I became curious if you would like to choose a more helpful information
> according to the wording “specific resources”.
> 
> Regards,
> Markus
> 
Hi Markus,

I respect your work, but please let us to focus on the code itself. I think
experts in this area know what these patches want to solve after look at the code.

I hope experts in the thread could review the code when you free, thanks :)

---
Regards,
Longpeng(Mike)
