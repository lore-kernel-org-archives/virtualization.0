Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE0C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 08:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E941E82446;
	Thu, 10 Feb 2022 08:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5sKKfZAwkglm; Thu, 10 Feb 2022 08:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80125813A5;
	Thu, 10 Feb 2022 08:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E931C0011;
	Thu, 10 Feb 2022 08:21:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E28C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 279B982404
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iN-jbrhEATHA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:20:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D42D813A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 08:20:59 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id y8so6201755pfa.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Krb0rzTOGW2eoN3LEJWPKbRX68tZZeijjPHmNpJEiuw=;
 b=X4RptU//lXEDz6B2GaWL43her2cGYbE8ScvsaqQ3JDFxx7ikqIOgZzJmDbrBWJYIH5
 qFWOEB6GALcHvoB9kXYuJR5deJQVuDVhdvONH8VdK58lVe8RJJ2CzniSMQ1IT643zYW3
 PN6gZCJ+G6BNsA4cbPKAjvuqSwBnwSOnQBKnoHWK9neRlFGmQHS9sscwrzLpDjmqa+P5
 FUlmw9/4CLC4p9yw8X3lg4aFSRFRPZ4EbOESz6GaPBadEFPM+5bEuIrlN0ioqc3YgVm4
 1Klc4wADjbs44eiQkPkkcIcqBJ7+CDOGUnPiLqXW+ynjBDI23rBhQQPAaQd3wWK2OTkO
 QWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Krb0rzTOGW2eoN3LEJWPKbRX68tZZeijjPHmNpJEiuw=;
 b=qV5MBGa66fInr9wq0syjyFnB9ZaiCjX7K24CIOTL/KID2JaI201YkyPyr5loppVQjd
 6X/c44+0/Z3lO+v9lZWcJ0ndnykXCnLgbFKVWSZLl7RAKVl9MkEpCH9UrcK6ePFYo8Nt
 /9/VJOGDd4DKICPsywlJdgRaXX6tOo+FRanc+mL8NBfYt8bjMgu990sP8mqego0D+C+O
 5vO7UtlRn3pAIpAtHqz+wQAAtLGgfXYc3wYJ+2Pdyj4tNyMPH+pkn80TFozPWk9ZTXtm
 mL4AS9IBTpxF8LtQ656eFR4ayt7chis9Kv+18PAicD1o07zLuhF5dP+i56xi4XiLpODw
 Jgeg==
X-Gm-Message-State: AOAM531zCo7+QRWgXnwcdQqsgsDFlT9mPAJt/uZ6occboT7GjIgh6v+c
 Bp4r6oNSNpFv90Px9lnSWxUp0w==
X-Google-Smtp-Source: ABdhPJyK+1a3UQV6u+LP1EI1H/P04vpG2Owo6ZPLmkdSsqC12revmFlKMy2HiNOC46200H7wPK8xIg==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr5242468pgd.321.1644481258472; 
 Thu, 10 Feb 2022 00:20:58 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id p4sm21374590pfw.133.2022.02.10.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 00:20:57 -0800 (PST)
Subject: Re: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <20220121022438.1042547-3-pizhenwei@bytedance.com>
 <15e960491a684b649e5d0179a32848a2@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
Date: Thu, 10 Feb 2022 16:18:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <15e960491a684b649e5d0179a32848a2@huawei.com>
Content-Language: en-US
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

>>   /* The accelerator hardware is ready */  #define
>> VIRTIO_CRYPTO_S_HW_READY  (1 << 0) @@ -442,6 +520,7 @@ struct
>> virtio_crypto_config {
>>   	__le32 reserve;
>>   	/* Maximum size of each crypto request's content */
>>   	__le64 max_size;
>> +	__le32 akcipher_algo;
>>   };
>>
> You can use the reserve attribute. Keeping 64-bit aligned.
> 
>>   struct virtio_crypto_inhdr {
>> --
>> 2.25.1
> 

Can I use the "__le32 reserve;" field directly?

struct virtio_crypto_config {
         /* See VIRTIO_CRYPTO_OP_* above */
         __le32  status;

         /*
          * Maximum number of data queue
          */
         __le32  max_dataqueues;

         /*
          * Specifies the services mask which the device support,
          * see VIRTIO_CRYPTO_SERVICE_* above
          */
         __le32 crypto_services;

         /* Detailed algorithms mask */
         __le32 cipher_algo_l;
         __le32 cipher_algo_h;
         __le32 hash_algo;
         __le32 mac_algo_l;
         __le32 mac_algo_h;
         __le32 aead_algo;
         /* Maximum length of cipher key */
         __le32 max_cipher_key_len;
         /* Maximum length of authenticated key */
         __le32 max_auth_key_len;
         __le32 reserve;            -->    __le32 akcipher_algo;
         /* Maximum size of each crypto request's content */
         __le64 max_size;
};

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
