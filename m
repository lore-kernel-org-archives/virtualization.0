Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F23BC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74416613D2
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74416613D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3539860610;
	Mon,  4 Oct 2021 20:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XDuRHRPDVSC; Mon,  4 Oct 2021 20:04:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C777A605EB;
	Mon,  4 Oct 2021 20:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98DB5C000F;
	Mon,  4 Oct 2021 20:04:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D713C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50C68400ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_NhCkFijf33
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:04:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37BAE400F3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:04:14 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id d18so21708158iof.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=96yyMKyGyUXRTH3hvSKjxri4j4LEUV+D4xGuayE0ULY=;
 b=R4PZZbRDe1Uw0SmxR3E8GPWXAreInX1lv2ZIKVssmww5RKxP/i6bs48K8i625PrlcK
 v3/1B96x39zNBmJMKIvj7XnJyU9OFv94037UqaND5h9qIoYwJd8ty5oA1RubUIgzcytM
 8g5c5pXRGigNTCh1occRUAPDvk1rD8uVbOFPrI3GNotUqTus7Nk1kNLkFxFQ0BCHurgK
 DyQLARneICjD66JOhbmBThUz7vruvvlG5LG3zyLFEbkH+19E/i98pGGZour1wRF4ARZV
 oq9zP226hUgKzF1kGWWwzTCvsWwJLpDV2Dvf4tyHnYv4ydzzxoUQQWrFzslIqZIWgVa9
 d2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=96yyMKyGyUXRTH3hvSKjxri4j4LEUV+D4xGuayE0ULY=;
 b=a4XqhdkVSGj9TKhl2UUTAR5P3v9Ro7C6JlfEOVxsw4Ss+pLMcRR7GQ4Jl6KBqFccJJ
 qb15f+WWLluLhkcuobZw+HFgvXvbbM2Rn8yxy3uqTOmy0bJEaOMtU2LR5e9BJhGiwDB2
 fMcp1Ec6PIqP4yGMEF3QAMasRE+jTUTRlfNs1HyF1/snYqklFF4JSVy9iaA8YGSaq0I1
 JtCxMVCPNRq9uhMLY+vcsKSlE33ho0UsPyqtm1qalKr1cAYYphL3Wq92y2wsKwVZnF0M
 xzlPM/oawEMtuCxlJGQEp63yrw0CPdFe9Qi7bMQf92TmMBlR+Xd01ZrYTWIAC6k4V0Uq
 YjGA==
X-Gm-Message-State: AOAM532NdW4k7gyfQPT8paTmaktn+N2F6RSWQFNroXszSU8MThYxd6vD
 bDv5zCZtoB3u5DcdUvEk8h34pw==
X-Google-Smtp-Source: ABdhPJwqGVbJHLIwYioAw9M5x3CpwVjc7UxpxfUJlIy43+T/BugL8BjkE91545zKhwS5ZZO/nyM7rw==
X-Received: by 2002:a02:9542:: with SMTP id y60mr7599122jah.133.1633377854091; 
 Mon, 04 Oct 2021 13:04:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id a11sm10070213ilm.36.2021.10.04.13.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 13:04:13 -0700 (PDT)
Subject: Re: [PATCH V3 7/9] fork: Add worker flag to ignore signals
To: Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
 vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-8-michael.christie@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e3840acc-09c0-01bd-ad64-54e9d2dfb888@kernel.dk>
Date: Mon, 4 Oct 2021 14:04:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-8-michael.christie@oracle.com>
Content-Language: en-US
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

On 10/4/21 1:21 PM, Mike Christie wrote:
> The kthread API creates threads that ignore all signals by default so
> modules like vhost that will move from that API to kernel_worker will
> not be expecting them. This patch adds a worker flag that tells
> kernel_worker to setup the task to ignore signals.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/linux/sched/task.h |  1 +
>  kernel/fork.c              | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 781abbc1c288..aefa0d221b57 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -21,6 +21,7 @@ struct css_set;
>  #define KERN_WORKER_IO		BIT(0)
>  #define KERN_WORKER_USER	BIT(1)
>  #define KERN_WORKER_NO_FILES	BIT(2)
> +#define KERN_WORKER_NO_SIGS	BIT(3)
>  
>  struct kernel_clone_args {
>  	u64 flags;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3f3fcabffa5f..34d3dca70cfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2555,6 +2555,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  				  unsigned long clone_flags, u32 worker_flags)
>  {
> +	struct task_struct *tsk;
> +
>  	struct kernel_clone_args args = {
>  		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
>  				   CLONE_UNTRACED) & ~CSIGNAL),
> @@ -2564,7 +2566,14 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  		.worker_flags	= KERN_WORKER_USER | worker_flags,
>  	};
>  
> -	return copy_process(NULL, 0, node, &args);
> +	tsk = copy_process(NULL, 0, node, &args);
> +	if (IS_ERR(tsk))
> +		return tsk;
> +
> +	if (worker_flags & KERN_WORKER_NO_SIGS)
> +		ignore_signals(tsk);
> +
> +	return tsk;

When I originally did it this way, Eric (correctly) pointed out that
it's racy. See where it's currently done as part of copy_process(), not
after.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
