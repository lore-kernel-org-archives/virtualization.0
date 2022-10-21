Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F92EC4332F
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 02:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95DD3410B0;
	Fri, 21 Oct 2022 02:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95DD3410B0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anumOhsW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2SY70u_WdUce; Fri, 21 Oct 2022 02:24:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A1BA40996;
	Fri, 21 Oct 2022 02:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A1BA40996
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D01A7C0032;
	Fri, 21 Oct 2022 02:24:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9E6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3BBA843CD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:24:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3BBA843CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=anumOhsW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0JRfaK-WndW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAD6B843CC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAD6B843CC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666319075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PlZXSujXxnsONYt0iOQmULTiA4NiBkwixiMYgCgEGWg=;
 b=anumOhsWT2Bks0hb8uHlt+PWXQDVwV74q6+A4U0lndm/kESbVRwyhgddW3Drs+zsSBKGHm
 Vdj8HgWV2sBXd5Ye5JN9Hm17kHm3EgX7khgqaQXYMZwPg6yNI+lppzinZ+2k1BNtDEZubL
 NXsebnaIvsqCiW/6fjnbR7+jvQekGCU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-V_U9RlVsN_SBAktBcmtSdQ-1; Thu, 20 Oct 2022 22:24:34 -0400
X-MC-Unique: V_U9RlVsN_SBAktBcmtSdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9853B38012C2;
 Fri, 21 Oct 2022 02:24:28 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F3E10DF8;
 Fri, 21 Oct 2022 02:24:05 +0000 (UTC)
Date: Fri, 21 Oct 2022 10:23:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1ICvUwglbxkqE+v@T590>
References: <Y1EQdafQlKNAsutk@T590>
 <Y1GpB6Gpm7GglwO3@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1GpB6Gpm7GglwO3@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Jens Axboe <axboe@kernel.dk>, djeffery@redhat.com,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Oct 20, 2022 at 04:01:11PM -0400, Stefan Hajnoczi wrote:
> On Thu, Oct 20, 2022 at 05:10:13PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > David Jeffery found one double ->queue_rq() issue, so far it can
> > be triggered in the following two cases:
> > 
> > 1) scsi driver in guest kernel
> > 
> > - the story could be long vmexit latency or long preempt latency of
> > vCPU pthread, then IO req is timed out before queuing the request
> > to hardware but after calling blk_mq_start_request() during ->queue_rq(),
> > then timeout handler handles it by requeue, then double ->queue_rq() is
> > caused, and kernel panic
> > 
> > 2) burst of kernel messages from irq handler 
> > 
> > For 1), I think it is one reasonable case, given latency from host side
> > can come anytime in theory because vCPU is emulated by one normal host
> > pthread which can be preempted anywhere. For 2), I guess kernel message is
> > supposed to be rate limited.
> > 
> > Firstly, is this kind of so long(30sec) random latency when running kernel
> > code something normal? Or do we need to take care of it? IMO, it looks
> > reasonable in case of VM, but our VM experts may have better idea about this
> > situation. Also the default 30sec timeout could be reduced via sysfs or
> > drivers.
> 
> 30 seconds is a long latency that does not occur during normal
> operation, but unfortunately does happen on occasion.

Thanks for the confirmation!

> 
> I think there's an interest in understanding the root cause and solving
> long latencies (if possible) in the QEMU/KVM communities. We can
> investigate specific cases on kvm@vger.kernel.org and/or
> qemu-devel@nongnu.org.

The issue was original reported on VMware VM, but maybe David can figure
out how to trigger it on QEMU/KVM.



Thanks, 
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
