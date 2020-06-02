From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
        <longpeng2@huawei.com>
Subject: Re: [PATCH v2 2/2] crypto: virtio: Fix use-after-free in
 virtio_crypto_skcipher_finalize_req()
Date: Tue, 2 Jun 2020 11:54:04 +0800
Message-ID: <a0701427-92e2-5695-1b84-88d356253a76@huawei.com>
References: <20200526031956.1897-3-longpeng2@huawei.com>
 <20200526141138.8410D207FB@mail.kernel.org>
 <20200531052126-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200531052126-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <sashal@kernel.org>
Cc: linux-crypto@vger.kernel.org, Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Markus Elfring <Markus.Elfring@web.de>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



On 2020/5/31 17:21, Michael S. Tsirkin wrote:
> On Tue, May 26, 2020 at 02:11:37PM +0000, Sasha Levin wrote:
>> <20200123101000.GB24255@Red>
>> References: <20200526031956.1897-3-longpeng2@huawei.com>
>> <20200123101000.GB24255@Red>
>>
>> Hi
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag
>> fixing commit: dbaf0624ffa5 ("crypto: add virtio-crypto driver").
>>
>> The bot has tested the following trees: v5.6.14, v5.4.42, v4.19.124, v4.14.181.
>>
>> v5.6.14: Build OK!
>> v5.4.42: Failed to apply! Possible dependencies:
>>     eee1d6fca0a0 ("crypto: virtio - switch to skcipher API")
>>
>> v4.19.124: Failed to apply! Possible dependencies:
>>     eee1d6fca0a0 ("crypto: virtio - switch to skcipher API")
>>
>> v4.14.181: Failed to apply! Possible dependencies:
>>     500e6807ce93 ("crypto: virtio - implement missing support for output IVs")
>>     67189375bb3a ("crypto: virtio - convert to new crypto engine API")
>>     d0d859bb87ac ("crypto: virtio - Register an algo only if it's supported")
>>     e02b8b43f55a ("crypto: virtio - pr_err() strings should end with newlines")
>>     eee1d6fca0a0 ("crypto: virtio - switch to skcipher API")
>>
>>
>> NOTE: The patch will not be queued to stable trees until it is upstream.
>>
>> How should we proceed with this patch?
> 
> Mike could you comment on backporting?
> 
Hi Michael,

I will send V3, so I will resolve these conflicts later. :)

>> -- 
>> Thanks
>> Sasha
> 
> .
> 
---
Regards,
Longpeng(Mike)
