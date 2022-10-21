Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846D2C4332F
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 15:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E74B54119C;
	Fri, 21 Oct 2022 15:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E74B54119C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SETnlhzY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZUf413tVxuu; Fri, 21 Oct 2022 15:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D94E2403C2;
	Fri, 21 Oct 2022 15:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D94E2403C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0CC3C0033;
	Fri, 21 Oct 2022 15:22:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28121C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 15:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E89FB419E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 15:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E89FB419E0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SETnlhzY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhKT42IRwaZC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 15:22:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED3F04196C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED3F04196C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666365769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNUtD0qOkGMlGUgfA5NfPqgJZTck3/7w6b9qm8JJosE=;
 b=SETnlhzYfM9hj1A2CPkQYzzisU9d4zmSSpkqPgqC2IDMd6+lcjaV99Puszheja7nY+MjSr
 bAKiH45s/qkCHWCaBtxReF3q5mT1HMqG+ydTS4Rc5FdAVpxMGJ1uEeJ2r/9TGaJDkOZEfL
 Nds6g42IELURwQW/73ASEqaSqZceq6I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-1BqXFHcOPbm4uh747QbAzg-1; Fri, 21 Oct 2022 11:22:47 -0400
X-MC-Unique: 1BqXFHcOPbm4uh747QbAzg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E03D92823821;
 Fri, 21 Oct 2022 15:22:45 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27AEE401E5C;
 Fri, 21 Oct 2022 15:22:39 +0000 (UTC)
Date: Fri, 21 Oct 2022 23:22:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1K5Oo7bIRlVTDnb@T590>
References: <Y1EQdafQlKNAsutk@T590>
 <Y1Ktf2jRTlPMQwJR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1Ktf2jRTlPMQwJR@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Jens Axboe <axboe@kernel.dk>, djeffery@redhat.com,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, Christoph Hellwig <hch@lst.de>
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

On Fri, Oct 21, 2022 at 08:32:31AM -0600, Keith Busch wrote:
> On Thu, Oct 20, 2022 at 05:10:13PM +0800, Ming Lei wrote:
> > @@ -1593,10 +1598,17 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  	if (!percpu_ref_tryget(&q->q_usage_counter))
> >  		return;
> >  
> > -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> > +	/* Before walking tags, we must ensure any submit started before the
> > +	 * current time has finished. Since the submit uses srcu or rcu, wait
> > +	 * for a synchronization point to ensure all running submits have
> > +	 * finished
> > +	 */
> > +	blk_mq_wait_quiesce_done(q);
> > +
> > +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
> 
> The blk_mq_wait_quiesce_done() will only wait for tasks that entered
> just before calling that function. It will not wait for tasks that
> entered immediately after.

Yeah, but the patch records the jiffies before calling
blk_mq_wait_quiesce_done, and only time out requests which are timed out
before the recorded time, so it is fine to use blk_mq_wait_quiesce_done
in this way.

> 
> If I correctly understand the problem you're describing, the hypervisor
> may prevent any guest process from running. If so, the timeout work may
> be stalled after the quiesce, and if a queue_rq() process also stalled
> after starting quiesce_done(), then we're in the same situation you're
> trying to prevent, right?

No, the stall just happens on one vCPU, and other vCPUs may run smoothly.

1) vmexit, which only stalls one vCPU, some vmexit could come anytime,
such as external interrupt

2) vCPU is emulated by pthread usually, and the pthread is just one
normal host userspace pthread, which can be preempted anytime, and
the preempt latency could be long enough when the system load is
heavy.

And it is like random stall added when running any instruction of
VM kernel code.

> 
> I agree with your idea that this is a lower level driver responsibility:
> it should reclaim all started requests before allowing new queuing.
> Perhaps the block layer should also raise a clear warning if it's
> queueing a request that's already started.

The thing is that it is one generic issue, lots of VM drivers could be
affected, and it may not be easy for drivers to handle the race too.



Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
