Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC90C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 17:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1483441553;
	Thu, 18 May 2023 17:04:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1483441553
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z4vsiFUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4ZpfSMJPAm2; Thu, 18 May 2023 17:04:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E37C4094C;
	Thu, 18 May 2023 17:04:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E37C4094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D05FDC0036;
	Thu, 18 May 2023 17:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C45F9C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 17:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B8A941C66
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 17:04:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B8A941C66
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z4vsiFUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgDNWcNzm6FI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 17:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7402409F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7402409F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684429463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ7Kv25n2l/rgGBMQe8NyD9v4RBua/FQCAYmOFizbRM=;
 b=Z4vsiFUSG9gfh09i/6uDv/3kAvSl+LVNIK58l3QfWjqudCy8/dSry3VdKZBnl81dMmHW1J
 9NXjSAf7/Q91x15x5xuhN7IDUdoYlrznXMDNVAuAD1zpZ93AuDC9k+QMtmC/vPXCghS0zr
 N73zbmH5C5LBquxnrr8Y680UIfBf1j8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-oX24YEzFMHeZcFcVgyOA3A-1; Thu, 18 May 2023 13:04:20 -0400
X-MC-Unique: oX24YEzFMHeZcFcVgyOA3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865E73806633;
 Thu, 18 May 2023 17:04:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
 by smtp.corp.redhat.com (Postfix) with SMTP id 4FC7440C2063;
 Thu, 18 May 2023 17:04:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Thu, 18 May 2023 19:04:04 +0200 (CEST)
Date: Thu, 18 May 2023 19:04:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518170359.GC20779@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On 05/18, Mike Christie wrote:
>
> On 5/18/23 11:25 AM, Oleg Nesterov wrote:
> > I too do not understand the 1st change in this patch ...
> >
> > On 05/18, Mike Christie wrote:
> >>
> >> In the other patches we do:
> >>
> >> if (get_signal(ksig))
> >> 	start_exit_cleanup_by_stopping_newIO()
> >> 	flush running IO()
> >> 	exit()
> >>
> >> But to do the flush running IO() part of this I need to wait for it so
> >> that's why I wanted to be able to dequeue the SIGKILL and clear the
> >> TIF_SIGPENDING bit.
> >
> > But get_signal() will do what you need, dequeue SIGKILL and clear SIGPENDING ?
> >
> > 	if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> > 	     signal->group_exec_task) {
> > 		clear_siginfo(&ksig->info);
> > 		ksig->info.si_signo = signr = SIGKILL;
> > 		sigdelset(&current->pending.signal, SIGKILL);
> >
> > this "dequeues" SIGKILL,

OOPS. this doesn't remove SIGKILL from current->signal->shared_pending

> >
> > 		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> > 			&sighand->action[SIGKILL - 1]);
> > 		recalc_sigpending();
> >
> > this clears TIF_SIGPENDING.

No, I was wrong, recalc_sigpending() won't clear TIF_SIGPENDING if
SIGKILL is in signal->shared_pending

> I see what you guys meant. TIF_SIGPENDING isn't getting cleared.
> I'll dig into why.

See above, sorry for confusion.



And again, there is another problem with SIGSTOP. To simplify, suppose
a PF_IO_WORKER thread does something like

	while (signal_pending(current))
		get_signal(...);

this will loop forever if (SIGNAL_GROUP_EXIT || group_exec_task) and
SIGSTOP is pending.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
