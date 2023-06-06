Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDBBC7EE24
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 12:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F36A81C38;
	Tue,  6 Jun 2023 12:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F36A81C38
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iai/Ant0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vp0pI9MQCOVj; Tue,  6 Jun 2023 12:17:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3EFE81AEF;
	Tue,  6 Jun 2023 12:17:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3EFE81AEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB7F7C007A;
	Tue,  6 Jun 2023 12:17:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CD0C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35FE4611D6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35FE4611D6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iai/Ant0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZ6AHPNZngEa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 717A960BB1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 717A960BB1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686053838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74VXFziIGlb0EFirVt9UAam6d4dNRVT+zKk4op/B4kY=;
 b=iai/Ant0DZDKnSMuABwTEL0ZRZ/gJHXijQRXLEHOfkHtH1zrcXEq8u+YyJs90lRmU2wkwg
 yC4gHvup3yTyR0PIcdr1SyYCPW15WTr2f5WRNIATUkQjukp3XKv+Abby4y+1OdBCyYGt5n
 rIjR+OpfH9wtWEaloCupX2lNA7BJgFs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-LwxI2Q6ANXKrf3btlqee9g-1; Tue, 06 Jun 2023 08:17:16 -0400
X-MC-Unique: LwxI2Q6ANXKrf3btlqee9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C23938149A4;
 Tue,  6 Jun 2023 12:17:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.222])
 by smtp.corp.redhat.com (Postfix) with SMTP id 9295E40CFD46;
 Tue,  6 Jun 2023 12:17:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Tue,  6 Jun 2023 14:16:53 +0200 (CEST)
Date: Tue, 6 Jun 2023 14:16:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230606121643.GD7542@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
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

On 06/05, Mike Christie wrote:
>
> On 6/5/23 10:10 AM, Oleg Nesterov wrote:
> > On 06/03, michael.christie@oracle.com wrote:
> >>
> >> On 6/2/23 11:15 PM, Eric W. Biederman wrote:
> >> The problem is that as part of the flush the drivers/vhost/scsi.c code
> >> will wait for outstanding commands, because we can't free the device and
> >> it's resources before the commands complete or we will hit the accessing
> >> freed memory bug.
> >
> > ignoring send-fd/clone issues, can we assume that the final fput/release
> > should always come from vhost_worker's sub-thread (which shares mm/etc) ?
>
> I think I'm misunderstanding the sub-thread term.
>
> - Is it the task_struct's context that we did the
> kernel/vhost_taskc.c:vhost_task_create() from? Below it would be the
> thread we did VHOST_SET_OWNER from.

Yes,

> So it works like if we were using a kthread still:
>
> 1. Userapce thread0 opens /dev/vhost-$something.
> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
> create the task_struct which runs the vhost_worker() function which handles
> the work->fns.
> 3. If userspace now does a SIGKILL or just exits without doing a close() on
> /dev/vhost-$something, then when thread0 does exit_files() that will do the
> fput that does vhost-$something's file_operations->release.

So, at least in this simple case vhost_worker() can just exit after SIGKILL,
and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
rather than wait for vhost_worker().

Right?

not that I think this can help in the general case ...

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
