Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 11:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F09FB4063F;
	Tue, 25 Jan 2022 11:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLtfESeJqvPR; Tue, 25 Jan 2022 11:14:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39C20403B8;
	Tue, 25 Jan 2022 11:14:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8CFBC0039;
	Tue, 25 Jan 2022 11:14:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEC9C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF2A283F9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQbDDd2oZ9uy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:14:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0824A83F9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643109268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rvvfbm9DdsitiqMaGToeqN6bn83eZm9ryJcgfNBtuTE=;
 b=iqnIRjWq82deHBv9kQWCm8DBUiqwWrgE050tBdianh7qzhq5WUwdlDYNskpVz2h3AD65Iw
 /01qBKBQCZkJuberkglCVaCPnMKZTQNVaekkDxxNLo7UM3SNqH41YQYqZpTTQvCxq4yLtx
 q31TxkqQfBdbe7ABhwxZUPLQN4YR/lg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-lwIUc8qrMBCnrpLjnd-uHg-1; Tue, 25 Jan 2022 06:14:27 -0500
X-MC-Unique: lwIUc8qrMBCnrpLjnd-uHg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l20-20020a05600c1d1400b0034c29cad547so1084303wms.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rvvfbm9DdsitiqMaGToeqN6bn83eZm9ryJcgfNBtuTE=;
 b=ot9ePEbe4Cio54q0fd4RHqSg1KGdMfj4IlMX+oNRM4NycGl0FmRWAaTXLxR5gEBgKZ
 nPqxupMSH+pJ1ChCCpW8c+LYHEM1ARsQcllnOfSuKQ5xaxsXRkMonejpmDz7sgxi3uut
 awYaFz6WUwm4eKBJiQmugjMTjJM6/DCNsJs208dd3Ubro6YMSHhsg0GyqYyAU+c53nB+
 F40pmKEM08kGfVqQwUHTwJV6DQMhCLDXoMCINpML4drp7w+h3kP1k2qoiUxnTy17pTWM
 4L9wrYG2lmiOBq1gNZSAK5Bef2O5Hi2IzZIqOsewy4KT5znEeu20kTwJGz+MXnVVdVhR
 xDvw==
X-Gm-Message-State: AOAM531A8ysq/Xphe7Y5m6Hlkyz25VTRbW57GQSUu3f9IzYz+MhiX85q
 p/8mFaxMSp6zSewBrp5tXJiwATcjW4f+Q0PJ9HAcSs5nM3HQyOrZLcOidz3jgfmdyHpyJuFfCkv
 xYUv+E90BwgyaZs5SMHkgv+jxiWzK57+z93aVjZL9RQ==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr18147958wrn.502.1643109266376; 
 Tue, 25 Jan 2022 03:14:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe9f8UE+t1HaCGIVAqAvlkesdvDMkIgGHznqy4t0x7dqgJcd7Nmt776tM9Ir7lrl12OgiLkA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr18147939wrn.502.1643109266078; 
 Tue, 25 Jan 2022 03:14:26 -0800 (PST)
Received: from steredhat ([62.19.185.119])
 by smtp.gmail.com with ESMTPSA id t14sm60428wmq.21.2022.01.25.03.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 03:14:25 -0800 (PST)
Date: Tue, 25 Jan 2022 12:14:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220125111422.tmsnk575jo7ckt46@steredhat>
References: <20220114090508.36416-1-sgarzare@redhat.com>
 <Ye6OJdi2M1EBx7b3@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <Ye6OJdi2M1EBx7b3@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Jan 24, 2022 at 11:31:49AM +0000, Stefan Hajnoczi wrote:
>On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime.
>>
>> We are not caching the avail index, so when the device will call
>> vhost_get_vq_desc(), it will find the old value in the cache and
>> it will read the avail index again.
>
>I think this wording is clearer because we do keep a cached the avail
>index value, but the issue is we don't update it:
>s/We are not caching the avail index/We do not update the cached avail
>index value/

I'll fix in v3.
It seems I forgot to CC you on v2: 
https://lore.kernel.org/virtualization/20220121153108.187291-1-sgarzare@redhat.com/

>
>>
>> It would be better to refresh the cache every time we read avail
>> index, so let's change vhost_enable_notify() caching the value in
>> `avail_idx` and compare it with `last_avail_idx` to check if there
>> are new buffers available.
>>
>> Anyway, we don't expect a significant performance boost because
>> the above path is not very common, indeed vhost_enable_notify()
>> is often called with unlikely(), expecting that avail index has
>> not been updated.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v1:
>> - improved the commit description [MST, Jason]
>> ---
>>  drivers/vhost/vhost.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 59edb5a1ffe2..07363dff559e 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, 
>> struct vhost_virtqueue *vq)
>>  		       &vq->avail->idx, r);
>>  		return false;
>>  	}
>> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>>
>> -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
>> +	return vq->avail_idx != vq->last_avail_idx;
>
>vhost_vq_avail_empty() has a fast path that's missing in
>vhost_enable_notify():
>
>  if (vq->avail_idx != vq->last_avail_idx)
>      return false;

Yep, I thought about that, but devices usually call 
vhost_enable_notify() right when vq->avail_idx == vq->last_avail_idx, so 
I don't know if it's an extra check for a branch that will never be 
taken.

Do you think it is better to add that check? (maybe with unlikely())

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
