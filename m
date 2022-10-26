Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6008AC38A02
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 00:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D404060B94;
	Wed, 26 Oct 2022 00:53:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D404060B94
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=K/1DQamF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KzJR7_teawTb; Wed, 26 Oct 2022 00:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E8A960A9C;
	Wed, 26 Oct 2022 00:53:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E8A960A9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3363EC0032;
	Wed, 26 Oct 2022 00:53:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB21C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C346400E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:53:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C346400E1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=K/1DQamF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LW4ImwkPAEWb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:53:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CB5D400C9
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CB5D400C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:53:26 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id e4so9800253pfl.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/BeIQrWdV7ri3khplWK2ZiFNyIA9PB6YDg0bsV9xNWQ=;
 b=K/1DQamFZf1Pl5aT14H8LDRCBmSSq+yZAyfo3rhIrcJZD4yMeD92bLzbtl7sN4+2cI
 mr+mwLfjO7w7RSF9MHv3AWRKbQZbdQVBMif3WS/jtYNRMaFuM1wL7IFVxIqLqA8VokMb
 iVsG4OGo7JYK2Qlc2sNetp7M3ZgduBwQ20hLKI3C2uI60baFHHtYHEqOQ/gr0J8FypmW
 Y9F9Xfol8f9+9Ja40Ymzi1jeg4PXdy/Ben53UConU4/qVlMzUV6IvqVJvB5D7dbxNHSJ
 3jGxvkLwdECK53WFEpN4bIR3eBUoweHtlaCYaof9PX11UQ1IoNTMhGVexfxHD3jJ8Q/T
 xSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/BeIQrWdV7ri3khplWK2ZiFNyIA9PB6YDg0bsV9xNWQ=;
 b=RrpzNTygN2K669ubgNpZAgCxqaDIpvg6ShU3o3LJcyl23PLESIQuzfG5L9j6kJTV5T
 kWKqgveYJY9ZLjXjlntqU7XHqaTtVtIZ7qMZ2AHiUiS8FTCAqp/kDPsWH+okIcVzFhhk
 yVDvuGNQdncfslqaGg3EXAufEAZdFZ4Kup8a5tc7XlEw82v9RvS8sK11luj2XQRnf7wE
 wpqFZLyPQXRlluWaWtvD/zSaroOVZm41HjKBoCspVcJaTdPRFsAyHU3c4prWEQIPMbDj
 rTGBYz/wZkuhDnxfNVBP/BaBZZHUOhSggWwydJLjZrj1hPEfuf+KkKoDdszKHXzKwBtM
 nh0w==
X-Gm-Message-State: ACrzQf1sfPLnjZGiel/qu/gxR2lHj2CyuAyCnbiDU8i20qlEepTtgfVR
 /ZybvbzgBjys7IQeeVjeqN7wHA==
X-Google-Smtp-Source: AMsMyM6lSF0wma+b6hQ9iTBOfapH6Y9ERDVrz686bQsT/qUuGRIWkfXEHJMO2x0vtYbCrHhkUAYwlw==
X-Received: by 2002:a63:66c6:0:b0:46e:c05d:b8d6 with SMTP id
 a189-20020a6366c6000000b0046ec05db8d6mr20927251pgc.474.1666745605460; 
 Tue, 25 Oct 2022 17:53:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 r26-20020aa79eda000000b0056b8b17f914sm1931421pfq.216.2022.10.25.17.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Oct 2022 17:53:24 -0700 (PDT)
Message-ID: <6af0ad92-8e31-d79f-9655-8819c12082a0@kernel.dk>
Date: Tue, 25 Oct 2022 18:53:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early timeout
To: Ming Lei <ming.lei@redhat.com>
References: <20221025005501.281460-1-ming.lei@redhat.com>
 <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk> <Y1h9fiY8TYD8HK5v@T590>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1h9fiY8TYD8HK5v@T590>
Cc: David Jeffery <djeffery@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 10/25/22 6:21 PM, Ming Lei wrote:
> On Tue, Oct 25, 2022 at 12:11:39PM -0600, Jens Axboe wrote:
>> On 10/24/22 6:55 PM, Ming Lei wrote:
>>> @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
>>>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>>>  		return;
>>>  
>>> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
>>> +	/*
>>> +	 * Before walking tags, we must ensure any submit started before
>>> +	 * the current time has finished. Since the submit uses srcu or rcu,
>>> +	 * wait for a synchronization point to ensure all running submits
>>> +	 * have finished
>>> +	 */
>>> +	blk_mq_wait_quiesce_done(q);
>>
>> I'm a little worried about this bit - so we'll basically do a sync RCU
>> every time the timeout timer runs... Depending on machine load, that
>> can take a long time.
> 
> Yeah, the per-queue timeout timer is never canceled after request is
> completed, so most of times the timeout work does nothing.

Yep, it just keeps going, that's the point of the rolling timeout timer.

> Can we run the sync RCU only if there is timed out request found? Then
> the wait is only needed in case that timeout handling is required. Also
> sync rcu is already done in some driver's ->timeout().

That was going to be my suggestion, if it can get done only for when
there's actually a potential timeout candidate, then that would be
orders of magnitude better.

-- 
Jens Axboe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
