Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5F8C433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 09:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF96740204;
	Fri,  6 May 2022 09:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ITHwlj6kCjQu; Fri,  6 May 2022 09:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68D8A40127;
	Fri,  6 May 2022 09:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D220C0039;
	Fri,  6 May 2022 09:59:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6E7BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5DF140127
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yIeYQvWSXs3e
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:59:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D16CD40025
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 09:59:27 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id y41so1026862pfw.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qkYBPtwwXh8wrjml5xjZWpmnyYJc8bz2oezaS0TP4h4=;
 b=yhN7HQkibzNKkcborAKfIJZ1+KFI5v7ka0JP/YFaO15M7iM5JCX3y28qvb6yrz1Qm+
 tsZzBSDZERZUoFnpycq2P8Gv8LylAFM5wybHMOsa26wbefo5t8aY5EF7nPp4hBwBGoKJ
 WeaxwleR2hasu1mCnXJ1eHbEprtWOiowLkefXtZGcDB8f+Yb6LwivSXUXWG85ve/qV9d
 RnGIzxJq40E9JIQsAjAIucr3YNMxnBfLL23bvh5Gr6zC5dU/CMeP49CeUEiTNfFktIZN
 xUve1G3ty7FkdL2P7bww2ONlixR4c/z1MErH2hnRyOVQicRhg5a00l+OEfpFrGLzkyeK
 T43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qkYBPtwwXh8wrjml5xjZWpmnyYJc8bz2oezaS0TP4h4=;
 b=DtRV36wElxpqrmoGohrdf98MR9n/p5PYpY1/XTeItRv4pnSaYvTBIfsEH0X53NlyUR
 cv5pGQUJg1lSuqw8pPhF4OPo5RlwQOUMr+eNw53O3A+pGfeKcHIOcLuT1uIaNiKSa25t
 rreHCVxdceRA74dczb4Nl7bRZ3p7weh58bR7cWG9emMao5aPmj0ajeYYO7iECxpGw3fH
 z60nRcUb9zALWYjfR/sJf5/Ej4XAFSPOod4QleOBRJXeM1DpwbTckuGWJlF2dB6m/Mgk
 B1Hpq34MUW2N1DzfGLo58CQdZl7ACfURBX+7dBtdsptjFCF0uT00SmwfpzXZsHkc2mgR
 UM+w==
X-Gm-Message-State: AOAM532LIBWf/PDPaUebIjFYDJ7YxW6Qs4+dWeRfYW3vJeriX2Slp46I
 UHW4PShb6n80n7o35tzuHJu4Gw==
X-Google-Smtp-Source: ABdhPJx1UzxZt5oKWOW8EfeuMSxPFYdmNFuHrO7gIAc3jSJG3YfatOtyNZDK/sM/J50XFzYZ7hQiig==
X-Received: by 2002:a65:615a:0:b0:3a9:f4ad:68a8 with SMTP id
 o26-20020a65615a000000b003a9f4ad68a8mr2168328pgv.108.1651831167259; 
 Fri, 06 May 2022 02:59:27 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 me16-20020a17090b17d000b001d26c7d5aacsm3300603pjb.13.2022.05.06.02.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 02:59:26 -0700 (PDT)
Message-ID: <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
Date: Fri, 6 May 2022 17:55:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: RE: [PATCH v5 5/5] virtio-crypto: enable retry for
 virtio-crypto-dev
Content-Language: en-US
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-6-pizhenwei@bytedance.com>
 <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 5/6/22 17:34, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Thursday, May 5, 2022 5:24 PM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
>> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
>> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
>> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
>> pizhenwei@bytedance.com; davem@davemloft.net
>> Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
>>
>> From: lei he <helei.sig11@bytedance.com>
>>
>> Enable retry for virtio-crypto-dev, so that crypto-engine can process
>> cipher-requests parallelly.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: lei he <helei.sig11@bytedance.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
>> b/drivers/crypto/virtio/virtio_crypto_core.c
>> index 60490ffa3df1..f67e0d4c1b0c 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>> @@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>>   		spin_lock_init(&vi->data_vq[i].lock);
>>   		vi->data_vq[i].vq = vqs[i];
>>   		/* Initialize crypto engine */
>> -		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
>> +		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true,
>> NULL, 1,
>> +						virtqueue_get_vring_size(vqs[i]));
> 
> Here the '1' can be 'true' too.
> 
> Sure, you can add
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> 
> Regards,
> -Gonglei
> 
>>   		if (!vi->data_vq[i].engine) {
>>   			ret = -ENOMEM;
>>   			goto err_engine;
>> --
>> 2.20.1
> 

Thanks to Lei!

Hi, Michael
I would appreciate it if you could apply this minor change, or I send 
the v6 series, which one do you prefer?

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
