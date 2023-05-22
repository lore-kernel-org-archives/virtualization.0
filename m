Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB262C7EE26
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 13:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6309F83B23;
	Mon, 22 May 2023 13:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6309F83B23
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1NHnuhu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cIMfUEm8aH6; Mon, 22 May 2023 13:31:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6C7883B36;
	Mon, 22 May 2023 13:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6C7883B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2467C0035;
	Mon, 22 May 2023 13:31:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72BC3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 380906143D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:31:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 380906143D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1NHnuhu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rENxITTsvsvE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:31:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59B6F6136C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59B6F6136C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684762263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eVGdestM+Cnm6kFHfPIOnEQEMlw4AVJx205w2cJUeL0=;
 b=J1NHnuhuBwAbK1SGMAEhHRWMP+/G2ve9txZgPqmyXuNCwlaMOTUKR+qsLJhD7EqM9K3Yw/
 yduEWTK9/QbHejLhHIcuHctaqyb5CyDkPWoFiGb2y3k1bIoWhuk8lFs4Y0P20CAeTdE4pS
 hOFjqhVG5BSlxgcahwCptgc8RzZS1Ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266--2m89qsxNIu92Vw5yGFyfg-1; Mon, 22 May 2023 09:30:59 -0400
X-MC-Unique: -2m89qsxNIu92Vw5yGFyfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11301800BFF;
 Mon, 22 May 2023 13:30:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
 by smtp.corp.redhat.com (Postfix) with SMTP id 2ABD240D1B60;
 Mon, 22 May 2023 13:30:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 22 May 2023 15:30:42 +0200 (CEST)
Date: Mon, 22 May 2023 15:30:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230522133038.GB22159@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
 <20230518170359.GC20779@redhat.com>
 <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On 05/18, Eric W. Biederman wrote:
>
>  void recalc_sigpending(void)
>  {
> -       if (!recalc_sigpending_tsk(current) && !freezing(current))
> +       if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
> +           ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
> +                   !__fatal_signal_pending(current)))
>                 clear_thread_flag(TIF_SIGPENDING);
>  
>  }
> @@ -1043,6 +1045,13 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>                  * This signal will be fatal to the whole group.
>                  */
>                 if (!sig_kernel_coredump(sig)) {
> +                       /*
> +                        * The signal is being short circuit delivered
> +                        * don't it pending.
> +                        */
> +                       if (type != PIDTYPE_PID) {
> +                               sigdelset(&t->signal->shared_pending,  sig);
> +
>                         /*
>                          * Start a group exit and wake everybody up.
>                          * This way we don't have other threads

Eric, sorry. I fail to understand this patch.

How can it help? And whom?

Perhaps we can discuss it in the context of the new series from Mike?

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
