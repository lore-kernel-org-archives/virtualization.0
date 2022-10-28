Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00402ECAAA1
	for <virtualization@archiver.kernel.org>; Fri, 28 Oct 2022 21:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 715C640185;
	Fri, 28 Oct 2022 21:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 715C640185
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_C4HMCsbR-3; Fri, 28 Oct 2022 21:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B55F840151;
	Fri, 28 Oct 2022 21:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B55F840151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FAE3C0032;
	Fri, 28 Oct 2022 21:38:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D43EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Oct 2022 21:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E959D81760
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Oct 2022 21:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E959D81760
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oa2xDa3Z2Cs4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Oct 2022 21:38:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62EC181757
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62EC181757
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Oct 2022 21:38:42 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id g129so5909718pgc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Oct 2022 14:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eky2t3lMAw0VhuARbfpVlAH47cho43zllPU1dSPRjcI=;
 b=JLEKn8IYcsy9Vz50fzjRGzMqpK3ZFHZXUE9chMEYsejmHpDKQUa/zMNIFi4gDTlCOI
 op6umA8VnIx64RlL4vEL2Y1Pf8s+2DH3BrDSKWL34Tz/2zRMC4SMVuoeqlaA7lXOLYl/
 H4d11KvxU4t/GiE4N/B3SO5LYtJNy8aNiiunmzhsThQIE5C7v+SkQdTC9LJclQDIatYs
 jAfhm4B4tY+RR499tgEnQeyxtFXhDhvtWuKbkrj7YVnOyKh6x727FOWRuAlh/swArmu7
 DgY41ptdWH45/ntmZ9ar9WD7jh3HUoJeuG5DhJnEWaNp0llJlhBWt02KkkJIXmmxinp+
 POkQ==
X-Gm-Message-State: ACrzQf3JS4FUgi2ENA7vEufeX7J1EfhjZ1G9FKNy1qVjAWWxbGwdKkMq
 vABhG7git7VaCUD7k1qpf4w=
X-Google-Smtp-Source: AMsMyM7G4OpRRlAeBhKXsyVEfsbt9daJUy6FUDU8+CfUsTGkGCX7KnGpg9wo0ciEvYDmjTTxImVGdw==
X-Received: by 2002:a05:6a00:1810:b0:56b:f29d:cc8e with SMTP id
 y16-20020a056a00181000b0056bf29dcc8emr1419218pfa.33.1666993121599; 
 Fri, 28 Oct 2022 14:38:41 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a170902e48400b001784a45511asm3452026ple.79.2022.10.28.14.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Oct 2022 14:38:40 -0700 (PDT)
Message-ID: <b7bab0a9-999e-3c88-1add-7f52642873f4@acm.org>
Date: Fri, 28 Oct 2022 14:38:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of early
 timeout
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20221026051957.358818-1-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 David Jeffery <djeffery@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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

On 10/25/22 22:19, Ming Lei wrote:
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> So far, it is driver's responsibility to cover the race between timeout
> and completion, so it seems supposed to be solved in driver in theory,
> given driver has enough knowledge.
> 
> But it is really one common problem, lots of driver could have similar
> issue, and could be hard to fix all affected drivers, even it isn't easy
> for driver to handle the race. So David suggests this patch by draining
> in-progress ->queue_rq() for solving this issue.

Nice work.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
