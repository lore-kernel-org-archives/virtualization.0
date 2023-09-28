Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCC9E82CBC
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 01:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C772040116;
	Thu, 28 Sep 2023 01:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C772040116
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fxsS+ox2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNgZu3Mi5P9L; Thu, 28 Sep 2023 01:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70B8640439;
	Thu, 28 Sep 2023 01:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70B8640439
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D166C0071;
	Thu, 28 Sep 2023 01:28:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1B78C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 01:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAD7A837D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 01:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAD7A837D3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=fxsS+ox2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id utt4zexrFmNK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 01:28:45 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6150C81409
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 01:28:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6150C81409
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6910ea9cddbso10807544b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1695864524; x=1696469324;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQKk85Afi4z+yWQXqNio3WhLlSbvtWaq2r8uxo++06Q=;
 b=fxsS+ox2aAQO0eQq2QPQGOH8GEg0wu7s74sS7dA+QLe/q/rVTbKqMxEVfv+AOpDYfG
 +Kv8Gnj8DvnbXVyHyKsC9krFNAdWF9zl/o2JyaEux1VlLJzcdp+0AxypUIcCGNNViOHj
 ICsdR2tvftd3G+o4RomPd3CzAlIddgAH9HHVCWFBFW/SOxnazzPONHqu7xbADf2yFcvq
 iTwGNGu3/5vmu7GP6FfsQfY90rSebD5C2obg1M3WyuYCrmrykrSEZez/bfKmYb96AIIZ
 tDNTTs8rPQQm38AeflCCd/Ghji/vXOiDARIfnL8WtpOoNPGc1TbmAG8sY0UjEgTJf+uU
 4SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695864524; x=1696469324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQKk85Afi4z+yWQXqNio3WhLlSbvtWaq2r8uxo++06Q=;
 b=XuMlto6QPVtkr8NdPmQOJ5WF8sA+ikO6W1Ec5Dc0GtXNWf+iPEM2I/ohi7DyuJZvIs
 EuT9cJdH1tD9QAcOyhYzIjDC7JpEgtteZK2lOAuwrF0aWFilAkrbYAe9osx1qBL+MneM
 aIftOb+REIc5r3hdcOA36mDKAPvW+gtIdjSrqhLRCvaUPjeSlpMgrV0DUb8TKQOu/h+C
 QbI3Rqcg58IILNujm71B7qOyWPvFPg1o4EmG/TBGNJKK3n89Kz/QbgBZOuPSQxPalyMa
 G2RK75iYRYrX4Q7zELWbLdcMPgVsxxYzzDOltysXld26xPvu+7cqozuhYxjPRhnuQ5Z9
 3cJw==
X-Gm-Message-State: AOJu0Yw2sE0MURBoHYvcEv8C3mim3QD4PX7/bUPBy9rF+4JY5TkReeOF
 XoDUC6JMlWzeQa2PE7b/eLE4bQ==
X-Google-Smtp-Source: AGHT+IEb77pxF1A4zuog0Pubtnz/Y+v7YIq8Yjvf89gpA0u8AEh8k4dTpPQZEdA3uoZ+glEhfmQuZA==
X-Received: by 2002:a05:6a21:7988:b0:14c:7e3:149b with SMTP id
 bh8-20020a056a21798800b0014c07e3149bmr2971085pzc.62.1695864524647; 
 Wed, 27 Sep 2023 18:28:44 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a170902b7c700b001c61073b064sm7916471plz.69.2023.09.27.18.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 18:28:44 -0700 (PDT)
Message-ID: <829bc434-89e6-b17e-b832-d0d83480c80f@bytedance.com>
Date: Thu, 28 Sep 2023 09:24:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <20230926130521-mutt-send-email-mst@kernel.org>
 <9564c220c8344939880bb805c5b3cac9@huawei.com>
 <20230927152531.061600f0.pasic@linux.ibm.com>
In-Reply-To: <20230927152531.061600f0.pasic@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael & Lei,

I volunteer to fix this by workqueue.

I also notice that device drivers use workqueue to handle config-changed 
again and again, what about re-implement __virtio_config_changed() by 
kicking workqueue instead?

By the way, balloon dirvers uses 
spin_lock_irqsave/spin_unlock_irqrestore in config-changed callback, do 
it handle correctly?

On 9/27/23 21:25, Halil Pasic wrote:
> On Wed, 27 Sep 2023 09:24:09 +0000
> "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> 
>>> On a related note, config change callback is also handled incorrectly in this
>>> driver, it takes a mutex from interrupt context.
>>
>> Good catch. Will fix it.
> 
> Thanks Gonglei! Sorry I first misunderstood this as a problem within the
> virtio-ccw driver, but it is actually about virtio-crypto. Thanks for
> fixing this!
> 
> Regards,
> Halil

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
