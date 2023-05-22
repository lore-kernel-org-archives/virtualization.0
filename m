Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3A0C77B75
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 17:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2939F408CA;
	Mon, 22 May 2023 17:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2939F408CA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fe9S92bw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwqDNba1TzA7; Mon, 22 May 2023 17:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 51398408C4;
	Mon, 22 May 2023 17:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51398408C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 311A6C0035;
	Mon, 22 May 2023 17:48:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA8BEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96664408C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96664408C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUR6zi47ujPB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:48:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E1AD408BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E1AD408BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7LSkGuXeXqte2Z5Adf2PWVtK/h6XyI9Wqw3/+z8Mgw=;
 b=Fe9S92bw4lb0phNnSvA29psaM8TsE1afHolDYUDexdsjgcnLvhjTHnwmAtlDeeQlsCU/hc
 qQYuZrXvcruviIncJssXll8iUb9ftO176IX44DT/zV9MvtK1M+W5+4k5rkhsdslPG3BzFJ
 BmTGKv8pfCUQweiyjN0myZTxsQqUuc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-Z9dhIrpdOzKq_gulj_8cBw-1; Mon, 22 May 2023 13:48:19 -0400
X-MC-Unique: Z9dhIrpdOzKq_gulj_8cBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E2B811E94;
 Mon, 22 May 2023 17:48:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
 by smtp.corp.redhat.com (Postfix) with SMTP id 42E2A2166B25;
 Mon, 22 May 2023 17:48:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 22 May 2023 19:48:01 +0200 (CEST)
Date: Mon, 22 May 2023 19:47:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522174757.GC22159@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 05/22, Mike Christie wrote:
>
> On 5/22/23 7:30 AM, Oleg Nesterov wrote:
> >> +			/*
> >> +			 * When we get a SIGKILL our release function will
> >> +			 * be called. That will stop new IOs from being queued
> >> +			 * and check for outstanding cmd responses. It will then
> >> +			 * call vhost_task_stop to tell us to return and exit.
> >> +			 */
> >
> > But who will call the release function / vhost_task_stop() and when this
> > will happen after this thread gets SIGKILL ?
>
> When we get a SIGKILL, the thread that owns the device/vhost_task will
> also exit since it's the same thread group and it does:
>
> do_exit -> exit_files -> put_files_struct -> close_files -> fput

Ah. thanks. I confused CLONE_FS in vhost_task_create() with CLONE_FILES.

> > Also. Suppose that vhost_worker() dequeues SIGKILL and clears TIF_SIGPENDING.
> >
> > SIGSTOP, PTRACE_INTERRUPT, freezer can come and set TIF_SIGPENDING again.
> > In this case the main for (;;) loop will spin without sleeping until
> > vhost_task_should_stop() becomes true?
>
> I see. So I either have to be able to call get_signal after SIGKILL or
> at this time work like a kthread and ignore signals like a
>
> if (dead && signal_pending())
> 	flush_signals()
> ?

Right now I think that "int dead" should die, and you should simply do
get_signal() + clear(SIGPENDING) if signal_pending() == T , but let me
think tomorrow.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
