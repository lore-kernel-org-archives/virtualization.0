Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF6CC7EE2A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 13:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE731415D1;
	Tue, 16 May 2023 13:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE731415D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e5lSW+BJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5O8TexxLQY6Y; Tue, 16 May 2023 13:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3779B4149F;
	Tue, 16 May 2023 13:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3779B4149F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 110DCC0037;
	Tue, 16 May 2023 13:18:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11018C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 13:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED2094102E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 13:18:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED2094102E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e5lSW+BJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkpPJbaG2S8m
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 13:18:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45C8A40576
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45C8A40576
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684243112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WVPatnC3k+2YTCrqOtx9X1ykWQAM87umCcg4LBsYnSs=;
 b=e5lSW+BJwT5w2Z6g4GesmWtgICJqbC36EQS4hraScjYOowAOxr+hVt88JNDyFr3zbiTTH6
 uZaLTMjiMPLIrDIaMYorBinAGfh6YtfQvJCM9Ej/TZYAL6FEeJzfM6+V3+0ck7oUkHf5Qw
 7y3FIEs+WRWlPxXTx3zGsyIKxW+CILc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-IkGvywwTPW-Lif-CGKEy7g-1; Tue, 16 May 2023 09:18:29 -0400
X-MC-Unique: IkGvywwTPW-Lif-CGKEy7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A14B29ABA24;
 Tue, 16 May 2023 13:18:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
 by smtp.corp.redhat.com (Postfix) with SMTP id 0EFEF40C6EC4;
 Tue, 16 May 2023 13:18:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Tue, 16 May 2023 15:18:14 +0200 (CEST)
Date: Tue, 16 May 2023 15:18:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230516131810.GA28890@redhat.com>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <8bfb7d1d-f7d0-94ca-4777-e31a2003027a@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8bfb7d1d-f7d0-94ca-4777-e31a2003027a@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On 05/15, Mike Christie wrote:
>
> Oleg and Christian,
>
>
> Below is an updated patch that doesn't check for PF_USER_WORKER in the
> signal.c code and instead will check for if we have blocked the signal.

Looks like I need to read the whole series... will try tomorrow.

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2336,8 +2336,15 @@ __latent_entropy struct task_struct *copy_process(
>  	p->flags &= ~PF_KTHREAD;
>  	if (args->kthread)
>  		p->flags |= PF_KTHREAD;
> -	if (args->user_worker)
> +	if (args->user_worker) {
> +		/*
> +		 * User worker are similar to io_threads but they do not
> +		 * support signals and cleanup is driven via another kernel
> +		 * interface so even SIGKILL is blocked.
> +		 */
>  		p->flags |= PF_USER_WORKER;
> +		siginitsetinv(&p->blocked, 0);

I never liked the fact that io-threads block the signals, this adds
another precedent... OK, this needs another discussion.

> +static void try_set_pending_sigkill(struct task_struct *t)
> +{
> +	/*
> +	 * User workers don't support signals and their exit is driven through
> +	 * their kernel layer, so by default block even SIGKILL.
> +	 */
> +	if (sigismember(&t->blocked, SIGKILL))
> +		return;
> +
> +	sigaddset(&t->pending.signal, SIGKILL);
> +	signal_wake_up(t, 1);
> +}

so why do you need this? to avoid fatal_signal_pending() or signal_pending() ?

In the latter case this change is not enough.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
