Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B4FC7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57A69820EF;
	Mon,  5 Jun 2023 13:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57A69820EF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCFKA51H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 48WTiP7IlH3k; Mon,  5 Jun 2023 13:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8C288208B;
	Mon,  5 Jun 2023 13:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8C288208B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2CE3C007A;
	Mon,  5 Jun 2023 13:49:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB3C4C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4117416AC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4117416AC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCFKA51H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzZsoW4Fh0We
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD2CB41620
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD2CB41620
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685972962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IqsADGawig/9/SjdL9ZrsH0XLB6JFxW+8nvjk2vu3gw=;
 b=jCFKA51H5qPO6zhNGCe08ac9I328xMHXl4r6ZiPT+Kz7vSKna4hinngkTfD2rlO/v68rMI
 5gzH59hkR+IItMaxfHXUvEuaiIh9nnR1Gsf8I1XjzMXYKaAY+bed3U68PXSErjDOe5ZKqL
 +lmWd3eeIASeUQVvgYQIVRNmVk6MkOg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-RYn07942P1G8GApkbqT0gA-1; Mon, 05 Jun 2023 09:49:12 -0400
X-MC-Unique: RYn07942P1G8GApkbqT0gA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2279328135C1;
 Mon,  5 Jun 2023 13:49:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
 by smtp.corp.redhat.com (Postfix) with SMTP id 10A47401470;
 Mon,  5 Jun 2023 13:49:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon,  5 Jun 2023 15:48:48 +0200 (CEST)
Date: Mon, 5 Jun 2023 15:48:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605134844.GC32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux@leemhuis.info, ebiederm@xmission.com,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

On 06/01, Mike Christie wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1368,7 +1368,9 @@ int zap_other_threads(struct task_struct *p)
>  
>  	while_each_thread(p, t) {
>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> -		count++;
> +		/* Don't require de_thread to wait for the vhost_worker */
> +		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> +			count++;

Well if you do this, then you should also change __exit_signal() to
not decrement sig->notify_count. Otherwise de_thread() can succeed
before the "normal" sub-threads exit.

But this can't be right anyway... If nothing else, suppose we have
a process with 3 threads:

	M	- the main thread, group leader
	T	- sub-thread
	V	- vhost worker

T does exec and calls de_thread().

M exits. T takes the leadership and does release_task()

V is still running but V->group_leader points to already freed M.

Or unshare_sighand() after that... If nothing else this means that
lock_task_sighand(T) and lock_task_sighand(V) will take different
locks.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
