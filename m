Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76178C433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 03:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D62EB400C9;
	Fri, 18 Feb 2022 03:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAo-uyk9ffF7; Fri, 18 Feb 2022 03:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32DC640022;
	Fri, 18 Feb 2022 03:15:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB034C0021;
	Fri, 18 Feb 2022 03:15:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD9CAC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 03:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC45083F48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 03:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GMLBYaDE-VB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 03:15:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2824C83F38
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 03:15:42 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id 75so6706307pgb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 19:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cvti9DbyWYs8dMjlWXIsVfLl8mOEd5qxZxKU5ZS8qhM=;
 b=EnqUrDW/nfup+NhWajLnkDWhSOvmFoQK+dIo4ycSZlbsaVZJQ3toa0sV/8PDtLpVtc
 Ua0hdYljmfKvlJdq+WpMj2cGgilXh8rXHSlRESdUebGxMXfw/A205qgyBOIEVWv+4brN
 NG9GiLi0ZFqeHR/zxleMZYNtBDRe15bxJfg3g6yujkyJ6YLRflwF2dEv+AXmhyQvEDPx
 iaqI9kaMr1J66C769SPr6XBkLO0cER66YfEcxLJ/YbkQLScKp1HiLAfpbDFm2hc6/00x
 Iij4aCq5PBkd0bXF/fU869XzGKcQR0BoA78b38hn4VifEuBUufctF3qushtC1R+qGyZk
 9N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cvti9DbyWYs8dMjlWXIsVfLl8mOEd5qxZxKU5ZS8qhM=;
 b=TIuwoYpnMURtG2ccT2s6vDyQgM8XaXsEONQS5/XaOqGWziPU30Roo1OpYcdqHAgtMv
 8kdnu1w5kPcoatupO+qM8LBx8T8dyImL2if3rn8S19EGM54RWDldcDDA3kWJaJxjXB/M
 Xza0qvV+bizrxPS3COgt5FMVoevhyyO6bP8X5mYdVEkMbLqTc9U1gX8FmC4tDrOtaPtS
 8UHWuj75jOUVbGJO3G8q8GXAKkVaeHYjTMiM0VCL8A456xhYra26zdcvtut5WIj5LDBx
 a61FylZKVutXHA4t880EBBBTuDqFDBZV9gP4LCCjXe63N9DyK7j9Q0ktCUCJFJgzRIVs
 JG2w==
X-Gm-Message-State: AOAM530MlsU5AEnTP7j5V70A11aNjJ1kw0OCxIdhl6eqJIuq8IJRTOku
 D2kbpSa9kfsWKaslmjlUmlHaYQ==
X-Google-Smtp-Source: ABdhPJxR3+NulIemLCe52Otg1HdG7AnjP7K5Epp9CJhpKw23x3HRAJOPywscd3ggEHJRYfc4lVgE9Q==
X-Received: by 2002:a63:f90e:0:b0:373:da89:c0bd with SMTP id
 h14-20020a63f90e000000b00373da89c0bdmr462001pgi.135.1645154142317; 
 Thu, 17 Feb 2022 19:15:42 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id m19sm929643pfk.215.2022.02.17.19.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Feb 2022 19:15:41 -0800 (PST)
Subject: Re: RE: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
Date: Fri, 18 Feb 2022 11:12:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c9144b0d82e34566a960f210ddc32696@huawei.com>
Content-Language: en-US
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, kernel test robot <lkp@intel.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
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

>> +void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
>> +*vcrypto) {
>> +	int i = 0;
>> +
>> +	mutex_lock(&algs_lock);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
>> +		uint32_t service = virtio_crypto_akcipher_algs[i].service;
>> +		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
>> +
>> +		if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
>> +		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
>> +			continue;
>> +
>> +		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
>> +
>> 	crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
>> +
>> +		virtio_crypto_akcipher_algs[i].active_devs--;
>> +	}
>> +
>> +	mutex_unlock(&algs_lock);
>> +}
> 
> Why don't you reuse the virtio_crypto_algs_register/unregister functions?
> The current code is too repetitive. Maybe we don't need create the new file virtio_crypto_akcipher_algo.c
> because we had virtio_crypto_algs.c which includes all algorithms.
> 

Yes, this looks similar to virtio_crypto_algs_register/unregister.

Let's look at the difference:
struct virtio_crypto_akcipher_algo {
         uint32_t algonum;
         uint32_t service;
         unsigned int active_devs;
         struct akcipher_alg algo;
};

struct virtio_crypto_algo {
         uint32_t algonum;
         uint32_t service; 

         unsigned int active_devs;
         struct skcipher_alg algo; /* akcipher_alg VS skcipher_alg */
};

If reusing virtio_crypto_algs_register/unregister, we need to modify the 
data structure like this:
struct virtio_crypto_akcipher_algo {
         uint32_t algonum;
         uint32_t service;	/* use service to distinguish 
akcipher/skcipher */
         unsigned int active_devs;
	union {
		struct skcipher_alg skcipher;
	        struct akcipher_alg akcipher;
	} alg;
};

int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
{
	...
         for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
                 uint32_t service = virtio_crypto_akcipher_algs[i].service;
		...
		/* test service type then call 
crypto_register_akcipher/crypto_register_skcipher */
                 if (service == VIRTIO_CRYPTO_SERVICE_AKCIPHER)
			crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo.akcipher);
		else
			crypto_register_skcipher(&virtio_crypto_skcipher_algs[i].algo.skcipher);
		...
         }
	...
}

Also test service type and call 
crypto_unregister_skcipher/crypto_unregister_akcipher.

This gets unclear from current v2 version.

On the other hand, the kernel side prefers to separate skcipher and 
akcipher(separated header files and implementations).

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
