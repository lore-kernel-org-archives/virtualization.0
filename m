Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54839C433FE
	for <virtualization@archiver.kernel.org>; Sat, 22 Oct 2022 04:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAC7140328;
	Sat, 22 Oct 2022 04:27:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAC7140328
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBDXDKKB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDU1axVm3nBe; Sat, 22 Oct 2022 04:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23850400C8;
	Sat, 22 Oct 2022 04:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23850400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D38DBC0032;
	Sat, 22 Oct 2022 04:27:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB38BC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 04:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD24A416B7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 04:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD24A416B7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBDXDKKB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hM-w0E-VPf6R
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 04:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 863CC416B6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 863CC416B6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Oct 2022 04:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666412865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YALJeQimVqF3PDTuJUBe9FLwaPKnqyd4jwSNzoM9Dks=;
 b=LBDXDKKB79agVGWkigRS5BL03uWnIlwUvOAheH6/EXn5tIaSHNhqbrZlVyx/4zfB5b2Liw
 hzaqm/FqbA4AN8Yo3C6q6Pym/9Aii5pW2KrRMJ6//+tC3jLsmFZGLC1A0mlyhnP0Dlfj8L
 kfVe+yMCR8vdHJ8KwgysJnXCjDWRRiE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-jCZBay40Mqa5xvmTIq6V8w-1; Sat, 22 Oct 2022 00:27:41 -0400
X-MC-Unique: jCZBay40Mqa5xvmTIq6V8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61F4A3810D20;
 Sat, 22 Oct 2022 04:27:41 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2C45492B04;
 Sat, 22 Oct 2022 04:27:30 +0000 (UTC)
Date: Sat, 22 Oct 2022 12:27:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: David Jeffery <djeffery@redhat.com>
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1NxKvq7MKcX6gTD@T590>
References: <Y1EQdafQlKNAsutk@T590>
 <Y1Ktf2jRTlPMQwJR@kbusch-mbp.dhcp.thefacebook.com>
 <Y1K5Oo7bIRlVTDnb@T590>
 <CA+-xHTFp+gFVy6aKW2nj47+WY2+1vOLAE-X067C-hm4_8ngA6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+-xHTFp+gFVy6aKW2nj47+WY2+1vOLAE-X067C-hm4_8ngA6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, stefanha@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Oct 21, 2022 at 02:33:21PM -0400, David Jeffery wrote:
> On Fri, Oct 21, 2022 at 11:22 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 08:32:31AM -0600, Keith Busch wrote:
> > >
> > > I agree with your idea that this is a lower level driver responsibility:
> > > it should reclaim all started requests before allowing new queuing.
> > > Perhaps the block layer should also raise a clear warning if it's
> > > queueing a request that's already started.
> >
> > The thing is that it is one generic issue, lots of VM drivers could be
> > affected, and it may not be easy for drivers to handle the race too.
> >
> 
> While virtual systems are a common source of the problem, fully
> preempt kernels (with or without real-time patches) can also trigger
> this condition rather simply with a poorly behaved real-time task. The
> involuntary preemption means the queue_rq call can be stopped to let
> another task run. Poorly behaving tasks claiming the CPU for longer
> than the request timeout when preempting a task in a queue_rq function
> could cause the condition on real or virtual hardware. So it's not
> just VM related drivers that are affected by the race.

In theory, yes. But ->queue_rq() is in rcu read critical area, and
usually CONFIG_RCU_BOOST is enabled for covering this problem otherwise
OOM can be triggered easily too.

I guess it is hard to trigger it in real hardware with preempt kernel.


Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
