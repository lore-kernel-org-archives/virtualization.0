Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57607C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 12:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF8C58208E;
	Mon,  5 Jun 2023 12:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF8C58208E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cr0B7AOW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_b2e39jbTz7; Mon,  5 Jun 2023 12:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 76D7F820BB;
	Mon,  5 Jun 2023 12:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76D7F820BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4962AC0037;
	Mon,  5 Jun 2023 12:39:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3175DC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BCB6820BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BCB6820BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3JDrGmle2BDP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:39:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 495548208E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 495548208E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685968756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loD/IvJicWPVfDfE30xF5JqbJYTs7N6XfWy0yCKcLAI=;
 b=cr0B7AOWMIkOfXSgpOMUriHELvR5IAD/J67ioTc30tpBRPBbIHwigMM+IMFKorgzABGZnC
 LQj2KHxhPXAd1twfF+xUjMDGSWnaQHiV8/ekZ39a1ALM7tpp4KTPG4G/qn1ZOBibUFGFxv
 QQQLgWBhfVUS4oiEL+T2Rv/ZfVDhh1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-k8chz8YbNdy6_0epECbSSA-1; Mon, 05 Jun 2023 08:39:11 -0400
X-MC-Unique: k8chz8YbNdy6_0epECbSSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73A44802355;
 Mon,  5 Jun 2023 12:39:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
 by smtp.corp.redhat.com (Postfix) with SMTP id 6D63340CFD46;
 Mon,  5 Jun 2023 12:39:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon,  5 Jun 2023 14:38:49 +0200 (CEST)
Date: Mon, 5 Jun 2023 14:38:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605123844.GA32275@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal can block in SIGSTOP,
> +			 * and the freezer.  Or it can clear
> +			 * fatal_signal_pending and return non-zero.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
> +		}
> +
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		did_work = vtsk->fn(vtsk->data);

I don't understand why do you set TASK_INTERRUPTIBLE before vtsk->fn(),
it seems that you could do this before the test_bit(FLAGS_STOP) below.
But probably I missed something and this is minor anyway...

> +		if (!did_work) {
> +			if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
> +				__set_current_state(TASK_RUNNING);
> +				break;

What if VHOST_TASK_FLAGS_STOP was set by us after get_signal() above ?
We need to ensure that in this case vhost_work_queue() can't add a new work,
nobody will flush it.

In fact, unless I missed something this can even race with vhost_dev_flush().

	vhost_dev_flush:				vhost_task_fn:

	checks FLAGS_STOP, not set,
	vhost_task_flush() returns false
							gets SIGKILL, sets FLAGS_STOP

							vtsk->fn() returns false

							vhost_task_fn() exits.

	vhost_work_queue();
	wait_for_completion(&flush.wait_event);


and the last wait_for_completion() will hang forever.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
