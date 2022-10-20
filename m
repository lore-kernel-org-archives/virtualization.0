Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4CAC433FE
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 20:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4590241BDC;
	Thu, 20 Oct 2022 20:26:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4590241BDC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUOehC11FI65; Thu, 20 Oct 2022 20:26:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FDD341E6D;
	Thu, 20 Oct 2022 20:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FDD341E6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54C09C0032;
	Thu, 20 Oct 2022 20:26:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B79AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 20:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CB7441E6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 20:26:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CB7441E6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id if8LFgQNPHUT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 20:26:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 360BE41BDC
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 360BE41BDC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 20:26:52 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id 3so613764pfw.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 13:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcVdsVpWTg1bqp0DssZWEbQWVHACMWpyZ0EkSPZisAw=;
 b=5Ul8Da2yLrppFCwYdy935qWOOyLa+E1T8G+toxXty0Rm1ERsi+yxoHU0xYTXhBavjK
 FB0K+CtYFE0wJRuHGcXYzm2O4Ek8ZRX57Ey38cqc6UQfN5V3nw7jAonv8BVWIxJSRgGt
 DDiZj5ZN9oaSbRkKyqKLniGZ8cxEa8ohiFmLUF0mcjaH0FH9dG/AfXrraEBve560nmcf
 Ah7ZYlu9lwa6TpuIqYlU16d0OJTp+xCpYzwKHqBuqQ+SwT+LUu7vaDhfwoRI2PUp6JJX
 eU8XKPDzFGD83g+Bk27FrUTLW/kEtX2Nf3mBE24EqIivM8h0LyP8B5BvQrtLeV+vFgTY
 serA==
X-Gm-Message-State: ACrzQf3LOs3y9NMMKBPt2PK8uZC+vOVUSg1cLty5cQjaZJJqQYUeMosM
 I2RCYTPrzr+ayKYVa++ZngM=
X-Google-Smtp-Source: AMsMyM6xtAkA3oCIoi3Vof6+mOsYN/mliGzKF84BTGsSAugy3LveMr0HkCXlNJtYd8K7dP3Swvmh/w==
X-Received: by 2002:a63:5a05:0:b0:434:23a5:a5ca with SMTP id
 o5-20020a635a05000000b0043423a5a5camr13281708pgb.515.1666297611256; 
 Thu, 20 Oct 2022 13:26:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e10c:786f:1f97:68bc?
 ([2620:15c:211:201:e10c:786f:1f97:68bc])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001752216ca51sm13285395plk.39.2022.10.20.13.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Oct 2022 13:26:50 -0700 (PDT)
Message-ID: <7d5eae39-3a56-df7d-eb72-3cb910c2b802@acm.org>
Date: Thu, 20 Oct 2022 13:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, djeffery@redhat.com, stefanha@redhat.com
References: <Y1EQdafQlKNAsutk@T590>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y1EQdafQlKNAsutk@T590>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
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

On 10/20/22 02:10, Ming Lei wrote:
 > [ ... ]

Hi Ming,

Fixing this in the block layer seems fine to me. A few comments:

> +	/* Before walking tags, we must ensure any submit started before the
> +	 * current time has finished. Since the submit uses srcu or rcu, wait
> +	 * for a synchronization point to ensure all running submits have
> +	 * finished
> +	 */

Should the above comment follow the style of other comments in the block 
layer?

> +	blk_mq_wait_quiesce_done(q);
> +
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);

The above doesn't look sufficient to me since .queue_rq() may be called 
while blk_mq_queue_tag_busy_iter() is in progress. How about moving the 
blk_mq_wait_quiesce_done() call into blk_mq_check_expired() and 
preventing new .queue_rq() calls before the timeout handler is called?

Thanks,

Bart.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
