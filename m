Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6FFC7EE24
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 19:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DBC08089E;
	Fri,  2 Jun 2023 19:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DBC08089E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dDibgMqJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5NB6RpTedo5; Fri,  2 Jun 2023 19:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF10B84581;
	Fri,  2 Jun 2023 19:23:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF10B84581
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E5FC0037;
	Fri,  2 Jun 2023 19:23:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C507C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 19:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A05084581
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 19:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A05084581
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDzkrDjLyMk0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 19:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8429B84582
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8429B84582
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685733804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hl/Yio++/nUxex1lxp6/0KZZRVMOQifT21+LBrMdJ5A=;
 b=dDibgMqJfHY9EacCDw9HaMdM6UMfkAAp8zCrNvBXj9IQB+EhzjdJ5IeQsYP5h29a+qqLYg
 9UgRrvTZWwKyTeEgzxVVgNGRYFkRIfBNYB6Hf1n6IfvzyYzBwuHSE+uGjps+Gc9nVJw6US
 Cd7+Ncj1NIvl/hGEF4AtzLgAlSOcXHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-s9DeVHr9PSiNgf7LjKdAhw-1; Fri, 02 Jun 2023 15:23:20 -0400
X-MC-Unique: s9DeVHr9PSiNgf7LjKdAhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD4BD85A5BA;
 Fri,  2 Jun 2023 19:23:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
 by smtp.corp.redhat.com (Postfix) with SMTP id B8E9CC154D7;
 Fri,  2 Jun 2023 19:23:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Fri,  2 Jun 2023 21:22:58 +0200 (CEST)
Date: Fri, 2 Jun 2023 21:22:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230602192254.GD555@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Hi Mike,

sorry, but somehow I can't understand this patch...

I'll try to read it with a fresh head on Weekend, but for example,

On 06/01, Mike Christie wrote:
>
>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		/* mb paired w/ vhost_task_stop */
> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> +			break;
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal will block in SIGSTOP,
> +			 * or clear fatal_signal_pending, but remember
> +			 * what was set.
> +			 *
> +			 * This thread won't actually exit until all
> +			 * of the file descriptors are closed, and
> +			 * the release function is called.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				clear_thread_flag(TIF_SIGPENDING);

this can't be right or I am totally confused.

Another signal_wake_up() can come right after clear(SIGPENDING).


Again, I'll try to re-read this patch, but let me ask anyway...

Do we have a plan B? I mean... iirc you have mentioned that you can
change these code paths to do something like

	if (killed)
		tell_the_drivers_that_all_callbacks_will_fail();


so that vhost_worker() can exit after get_signal() returns SIGKILL.

Probably I misunderstood you, but it would be nice to avoid the changes
in coredump/etc code just to add a temporary (iiuc!) fix.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
