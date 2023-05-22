Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6585EC77B75
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 12:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C275360E82;
	Mon, 22 May 2023 12:30:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C275360E82
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DvCtZIU4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pfbPKiGNu6rB; Mon, 22 May 2023 12:30:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C99961136;
	Mon, 22 May 2023 12:30:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C99961136
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BCF5C0036;
	Mon, 22 May 2023 12:30:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF93AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 12:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B39EF61136
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 12:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B39EF61136
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrfiqGatk0Tj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 12:30:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B0FE60E82
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B0FE60E82
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684758653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XLKVwpsofT3fO0KfbhEhMNwUy6j+Hh9Xz3u/5JzJISE=;
 b=DvCtZIU4wtlWL4DGHYmeTSFze0CrdwreZTgfezDsIVW44ab6QO2EsRGPB+iL5eTnlFOiJy
 uqhri2l2nW0HQEmocbw6CsAZy76GEv+RxFsYnxFnJNifAbLEqxi2AW/AtWLR0Y0cFF4PRg
 5MI7TJaOMTbSdFvyVVQl76sGeYMIx+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-y0yXY8u3NEe6cP21B_llfw-1; Mon, 22 May 2023 08:30:50 -0400
X-MC-Unique: y0yXY8u3NEe6cP21B_llfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D051B185A78F;
 Mon, 22 May 2023 12:30:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
 by smtp.corp.redhat.com (Postfix) with SMTP id BD2D7407DEC3;
 Mon, 22 May 2023 12:30:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 22 May 2023 14:30:33 +0200 (CEST)
Date: Mon, 22 May 2023 14:30:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522123029.GA22159@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230522025124.5863-4-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Confused, please help...

On 05/21, Mike Christie wrote:
>
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> +	bool dead = false;
>
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
>  		}
>
>  		node = llist_del_all(&worker->work_list);
> -		if (!node)
> +		if (!node) {
>  			schedule();
> +			/*
> +			 * When we get a SIGKILL our release function will
> +			 * be called. That will stop new IOs from being queued
> +			 * and check for outstanding cmd responses. It will then
> +			 * call vhost_task_stop to tell us to return and exit.
> +			 */

But who will call the release function / vhost_task_stop() and when this
will happen after this thread gets SIGKILL ?

> +			if (!dead && signal_pending(current)) {
> +				struct ksignal ksig;
> +
> +				dead = get_signal(&ksig);
> +				if (dead)
> +					clear_thread_flag(TIF_SIGPENDING);

If you do clear_thread_flag(TIF_SIGPENDING), then why do we need 1/3 ?


Also. Suppose that vhost_worker() dequeues SIGKILL and clears TIF_SIGPENDING.

SIGSTOP, PTRACE_INTERRUPT, freezer can come and set TIF_SIGPENDING again.
In this case the main for (;;) loop will spin without sleeping until
vhost_task_should_stop() becomes true?

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
