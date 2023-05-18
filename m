Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54041C77B7D
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 18:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C73318106A;
	Thu, 18 May 2023 18:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C73318106A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NepfBqdV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iuUYJLaGy-4; Thu, 18 May 2023 18:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5418180005;
	Thu, 18 May 2023 18:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5418180005
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 324AFC0036;
	Thu, 18 May 2023 18:23:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 964FBC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D2E084412
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D2E084412
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FJFiMe1YCoGo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B96E1843FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B96E1843FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684434204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJi9ZlLdcLDeLRUcrDXyTC7zgfOSpkMfpLKIfWFhcvU=;
 b=NepfBqdVRNCffsLGEEH394sX4uGfAi8+RIOvm8cThpNWyXbdQDHpL8mQybTklU9xsKbyPz
 mV+cA9O4NB/etcLfPhKeTvZvYCDTD/MphL1zAR0sL6lGril/EhBoYcGu+nV54LZtXMQIe5
 7RcB28LDQ3yp8MdAb5ImY1spWyASiN8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-xNxDOZS-O3yjF8lhA3tZ7g-1; Thu, 18 May 2023 14:23:20 -0400
X-MC-Unique: xNxDOZS-O3yjF8lhA3tZ7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 294E029AB448;
 Thu, 18 May 2023 18:23:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
 by smtp.corp.redhat.com (Postfix) with SMTP id 2CF7EC15BA0;
 Thu, 18 May 2023 18:23:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Thu, 18 May 2023 20:23:05 +0200 (CEST)
Date: Thu, 18 May 2023 20:23:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518182301.GB5817@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <20230518-kontakt-geduckt-25bab595f503@brauner>
 <7412912a-a470-bd3d-fb1c-54c094cc01ee@oracle.com>
 <20230518-ratgeber-erbeben-843e68b0d6ac@brauner>
 <20230518180809.GA5817@redhat.com>
 <20230518-fettgehalt-erdbeben-25587a432815@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230518-fettgehalt-erdbeben-25587a432815@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: axboe@kernel.dk, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
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

On 05/18, Christian Brauner wrote:
>
> On Thu, May 18, 2023 at 08:08:10PM +0200, Oleg Nesterov wrote:
> > On 05/18, Christian Brauner wrote:
> > >
> > > Yeah, but these are issues that exist with PF_IO_WORKER then too
> >
> > This was my thought too but I am starting to think I was wrong.
> >
> > Of course I don't understand the code in io_uring/ but it seems
> > that it always breaks the IO loops if get_signal() returns SIGKILL.
>
> Yeah, it does and I think Mike has a point that vhost could be running
> into an issue here that io_uring currently does avoid. But I don't think
> we should rely on that.

So what do you propose?

Unless (quite possibly) I am confused again, unlike io_uring vhost can't
tolerate signal_pending() == T in the cleanup-after-SIGKILL paths?

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
