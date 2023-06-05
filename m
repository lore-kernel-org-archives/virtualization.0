Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DC2C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 006CA40590;
	Mon,  5 Jun 2023 13:26:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 006CA40590
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bqIQy3Vq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNoMDQ-piI5L; Mon,  5 Jun 2023 13:26:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64645404F0;
	Mon,  5 Jun 2023 13:26:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64645404F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44EBBC007A;
	Mon,  5 Jun 2023 13:26:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77087C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4505382212
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:26:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4505382212
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bqIQy3Vq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9b8KjVfw7iU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:26:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 854F782210
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 854F782210
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685971607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE6eT97yzH12os5SZGHmyPIjNlvh5xRQLosLvxOHz80=;
 b=bqIQy3VqSRKwmj+b2STkF1uouBZ3tM/Up0QNmZHxqPa2URmp8hm/CB/Zr04CXTD3PVcplc
 CTIHSM7IlyhGVVH2lBH8RqN+tKX0KLvT9/YE2YGTXpBULPYKUFQVyP4l8hMvxFg9cRnGJk
 9YNvWpLasjH86mkKjmi1tiDY7BH6hao=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-NUiRjT3UM7GVO2knb6Tq8Q-1; Mon, 05 Jun 2023 09:26:43 -0400
X-MC-Unique: NUiRjT3UM7GVO2knb6Tq8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 686E91C05EAA;
 Mon,  5 Jun 2023 13:26:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
 by smtp.corp.redhat.com (Postfix) with SMTP id 1D7D81121314;
 Mon,  5 Jun 2023 13:26:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon,  5 Jun 2023 15:26:20 +0200 (CEST)
Date: Mon, 5 Jun 2023 15:26:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605132611.GB32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87wn0l2or4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wn0l2or4.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, nicolas.dichtel@6wind.com,
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

On 06/02, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Hi Mike,
> >
> > sorry, but somehow I can't understand this patch...
> >
> > I'll try to read it with a fresh head on Weekend, but for example,
> >
> > On 06/01, Mike Christie wrote:
> >>
> >>  static int vhost_task_fn(void *data)
> >>  {
> >>  	struct vhost_task *vtsk = data;
> >> -	int ret;
> >> +	bool dead = false;
> >> +
> >> +	for (;;) {
> >> +		bool did_work;
> >> +
> >> +		/* mb paired w/ vhost_task_stop */
> >> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> >> +			break;
> >> +
> >> +		if (!dead && signal_pending(current)) {
> >> +			struct ksignal ksig;
> >> +			/*
> >> +			 * Calling get_signal will block in SIGSTOP,
> >> +			 * or clear fatal_signal_pending, but remember
> >> +			 * what was set.
> >> +			 *
> >> +			 * This thread won't actually exit until all
> >> +			 * of the file descriptors are closed, and
> >> +			 * the release function is called.
> >> +			 */
> >> +			dead = get_signal(&ksig);
> >> +			if (dead)
> >> +				clear_thread_flag(TIF_SIGPENDING);
> >
> > this can't be right or I am totally confused.
> >
> > Another signal_wake_up() can come right after clear(SIGPENDING).
>
> Technically yes.

...

> Beyond that clearing TIF_SIGPENDING is just an optimization so
> the thread can sleep in schedule and not spin.

Yes. So if another signal_wake_up() comes after clear(SIGPENDING)
this code will spin in busy-wait loop waiting VHOST_TASK_FLAGS_STOP.
Obviously not good and even deadlockable on UP && !PREEMPT.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
