Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB21C7EE37
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 19:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27A494175A;
	Tue,  6 Jun 2023 19:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27A494175A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dab2CEdf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwSuc7Y5vt6S; Tue,  6 Jun 2023 19:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A031341736;
	Tue,  6 Jun 2023 19:39:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A031341736
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77E39C0037;
	Tue,  6 Jun 2023 19:39:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16456C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D179041D62
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D179041D62
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dab2CEdf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHrT4ZSxl8Nm
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BC5741BDE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BC5741BDE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686080378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JwoXBtrJnmo+pBf7jYnvlWnPa+tCBA8O3lKlFGoTwY8=;
 b=dab2CEdf/tx0+sB5e+chKL/j4DHx2hyNdJHrPOY2ycHPY6sVZCGaRzPwbmR+TNDZ/Qlit0
 gPi6eVtLg6kKZnBqlH1182wxw9Ns6dRoR1RrTk0hVcdkvBry4AFwoEP23FJnvbKHZA9ub0
 ne0agFKaTkwfIi0jvHRenIyAQjr83M8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-evnAV1KsO8-Q6sc1uO10KA-1; Tue, 06 Jun 2023 15:39:34 -0400
X-MC-Unique: evnAV1KsO8-Q6sc1uO10KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42EE3801224;
 Tue,  6 Jun 2023 19:39:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
 by smtp.corp.redhat.com (Postfix) with SMTP id 2F0FB140E954;
 Tue,  6 Jun 2023 19:39:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Tue,  6 Jun 2023 21:39:11 +0200 (CEST)
Date: Tue, 6 Jun 2023 21:39:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230606193907.GB18866@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux@leemhuis.info,
 "Eric W. Biederman" <ebiederm@xmission.com>, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

On 06/06, Mike Christie wrote:
>
> On 6/6/23 7:16 AM, Oleg Nesterov wrote:
> > On 06/05, Mike Christie wrote:
> >
> >> So it works like if we were using a kthread still:
> >>
> >> 1. Userapce thread0 opens /dev/vhost-$something.
> >> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
> >> create the task_struct which runs the vhost_worker() function which handles
> >> the work->fns.
> >> 3. If userspace now does a SIGKILL or just exits without doing a close() on
> >> /dev/vhost-$something, then when thread0 does exit_files() that will do the
> >> fput that does vhost-$something's file_operations->release.
> >
> > So, at least in this simple case vhost_worker() can just exit after SIGKILL,
> > and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
> > rather than wait for vhost_worker().
> >
> > Right?
>
> With the current code, the answer is no. We would hang like I mentioned here:
>
> https://lore.kernel.org/lkml/ae250076-7d55-c407-1066-86b37014c69c@oracle.com/

If only I could fully understand this email ;)

Could you spell to explain why this can't work (again, in this simple case) ?

My current (and I know, very poor) understanding is that .release() should
roughly do the following:

	1. Ensure that vhost_work_queue() can't add the new callbacks

	2. Call vhost_dev_flush() to ensure that worker->work_list is empty

	3. Call vhost_task_stop()

so why this sequence can't work if we turn vhost_dev_flush() into something like

	void vhost_dev_flush(struct vhost_dev *dev)
	{
		struct vhost_flush_struct flush;

		if (dev->worker) {
			// this assumes that vhost_task_create() uses CLONE_THREAD
			if (same_thread_group(current, dev->worker->vtsk->task)) {
				... run the pending callbacks ...
				return;
			}


			// this is what we currently have

			init_completion(&flush.wait_event);
			vhost_work_init(&flush.work, vhost_flush_work);

			vhost_work_queue(dev, &flush.work);
			wait_for_completion(&flush.wait_event);
		}
	}

?

Mike, I am just trying to understand what exactly vhost_worker() should do.

> We need to add code like I mentioned in that reply because we don't have a
> way to call into the layers below us to flush those commands.

This tells me nothing, but this is my fault, not yours. Again, again, I know
nothing about drivers/vhost.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
