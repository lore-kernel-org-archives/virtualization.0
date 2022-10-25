Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A31C38A2D
	for <virtualization@archiver.kernel.org>; Tue, 25 Oct 2022 18:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82ED840287;
	Tue, 25 Oct 2022 18:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82ED840287
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PhNYwqa4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YaO0rAogLFN9; Tue, 25 Oct 2022 18:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D104240277;
	Tue, 25 Oct 2022 18:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D104240277
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84AF7C0032;
	Tue, 25 Oct 2022 18:11:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9626CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 18:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69C5740286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 18:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69C5740286
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xvtnyqL5BBn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 18:11:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AF3B40277
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF3B40277
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 18:11:41 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id l6so7293491ilq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5n6c2CbsfFvTIF5f5Nr1n+MOOiDbqRcJ5kDbT7Gyebg=;
 b=PhNYwqa4350GNU7w/RQHZjfqgljm2DtvGwka7LtEaVaRGxGV7CwU4q2MtMzDrB3ZKf
 zYnk+DwOzk0KDcC00sV3UqYW9L7zr4rFBfQRPIukX2yXfTJtUAttimK61Vj4yQ+O5zfP
 +Vgs33sUB5Gia0l/B1nOxu8/a9M6LaBML41/jvUbC2ASihOy18RsjS0JcHYf5jGcmay4
 WUEZ7Tq1qWbiQBGyRHed8Sr14+E2mzMzyfg2WQs8ZF08IZMfWs3SexVJmxMiP1jdewIc
 n6S6g6+o/NK29g2ECoR4a2ol7SJJZ+Bw6eI2iS2qxTTa0FBg4s4T/fdCpOYgJGQMNPyZ
 dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5n6c2CbsfFvTIF5f5Nr1n+MOOiDbqRcJ5kDbT7Gyebg=;
 b=R/ixuQmu/h5qhTlsbqGz17DnHS31107SqbovU85xFr01Zyy0PkqHNZn2afTrZPGNmQ
 Hmkp5Ln92JXY3qG9V06yP+pHPcL6YM4gGT71/OuJZyMiTuFxx2zkRLaOc0L0yGEtwLFV
 5BVIRW+Mtk3zuGAXL2zJAi/86KeDELcLSNvgJv7RNQ/t2d6QbbWGHQ1O63T37/nIo4Cv
 +uVxRrh8ES1LUbfo+dMUkMxoun/M9gk/KCcJHXunfNKTaYX8QgA8Zc0HN4OSiJ078ux3
 XdS/qEeSIiFhVRq04UhDs7NmsxBgVEK83zVKBbe7SQNBSbgC8G+uLyP5inukitmtjnX0
 /vqw==
X-Gm-Message-State: ACrzQf0rUNsb++tJsXy4/0tsDnV7LfVihb3ACsEO34sNnHJxz9owFzHk
 aarC/p2mPNVeWj4APHDJXaG9Dw==
X-Google-Smtp-Source: AMsMyM6iQvEkBnwDvjOLmRsECOfUrlA8ckX7bc/+yUy/pp2OhtUfxF+2FZAi3DhyPFiBVT+lAXhGYg==
X-Received: by 2002:a05:6e02:1bc3:b0:2fa:c3f4:30d6 with SMTP id
 x3-20020a056e021bc300b002fac3f430d6mr23611222ilv.43.1666721500991; 
 Tue, 25 Oct 2022 11:11:40 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a056e02131100b002dd0bfd2467sm1260796ilr.11.2022.10.25.11.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Oct 2022 11:11:40 -0700 (PDT)
Message-ID: <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
Date: Tue, 25 Oct 2022 12:11:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early timeout
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
References: <20221025005501.281460-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221025005501.281460-1-ming.lei@redhat.com>
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

On 10/24/22 6:55 PM, Ming Lei wrote:
> @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
>  
> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> +	/*
> +	 * Before walking tags, we must ensure any submit started before
> +	 * the current time has finished. Since the submit uses srcu or rcu,
> +	 * wait for a synchronization point to ensure all running submits
> +	 * have finished
> +	 */
> +	blk_mq_wait_quiesce_done(q);

I'm a little worried about this bit - so we'll basically do a sync RCU
every time the timeout timer runs... Depending on machine load, that
can take a long time.

-- 
Jens Axboe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
