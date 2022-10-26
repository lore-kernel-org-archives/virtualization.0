Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19CAC38A02
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 03:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6716F401F1;
	Wed, 26 Oct 2022 03:30:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6716F401F1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OKl/czJO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tyfVCyKuXtoW; Wed, 26 Oct 2022 03:30:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D307C4000B;
	Wed, 26 Oct 2022 03:30:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D307C4000B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1FDDC0033;
	Wed, 26 Oct 2022 03:30:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B2BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 03:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60D9440268
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 03:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60D9440268
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OKl/czJO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ngzQwN0F2fY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 03:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E14DD40219
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E14DD40219
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666755011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uY7wa0Mwx95gEw6M0cObxCixtlKzD3t8llwv4U0Oj2A=;
 b=OKl/czJOeOc3zrV/5gQOEocH5R8woIdCwXs7Q8EjXGm1dUdhdkoX+G0DNm4DT/ZZBBWJvR
 ahLeTq93Ykt3fLnk/fJc/OIxOCpT9apV4JxnhgGgCKicKk75vUEPYwnoN/WklruibTruiz
 TdBxmY9Z0KHr1vwZd/p891YSMcJiEJw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-AJ-rCRHHPUmVK_-cKA2lQA-1; Tue, 25 Oct 2022 23:30:06 -0400
X-MC-Unique: AJ-rCRHHPUmVK_-cKA2lQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4308D29AB435;
 Wed, 26 Oct 2022 03:30:06 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA6DB40C6EC6;
 Wed, 26 Oct 2022 03:29:57 +0000 (UTC)
Date: Wed, 26 Oct 2022 11:29:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/1] blk-mq: avoid double ->queue_rq() because of
 early timeout
Message-ID: <Y1iprFhtHLSESDdJ@T590>
References: <20221026015521.347973-1-ming.lei@redhat.com>
 <Y1ilaQV3hz6kudH3@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1ilaQV3hz6kudH3@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: Jens Axboe <axboe@kernel.dk>, David Jeffery <djeffery@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Oct 25, 2022 at 09:11:37PM -0600, Keith Busch wrote:
> On Wed, Oct 26, 2022 at 09:55:21AM +0800, Ming Lei wrote:
> > @@ -1564,8 +1571,13 @@ static bool blk_mq_check_expired(struct request *rq, void *priv)
> >  	 * it was completed and reallocated as a new request after returning
> >  	 * from blk_mq_check_expired().
> >  	 */
> > -	if (blk_mq_req_expired(rq, next))
> > +	if (blk_mq_req_expired(rq, expired)) {
> > +		if (expired->check_only) {
> > +			expired->has_timedout_rq = true;
> > +			return false;
> > +		}
> >  		blk_mq_rq_timed_out(rq);
> > +	}
> >  	return true;
> >  }
> >  
> > @@ -1573,7 +1585,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  {
> >  	struct request_queue *q =
> >  		container_of(work, struct request_queue, timeout_work);
> > -	unsigned long next = 0;
> > +	struct blk_expired_data expired = {
> > +		.check_only = true,
> > +		.timeout_start = jiffies,
> > +	};
> >  	struct blk_mq_hw_ctx *hctx;
> >  	unsigned long i;
> >  
> > @@ -1593,10 +1608,24 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  	if (!percpu_ref_tryget(&q->q_usage_counter))
> >  		return;
> >  
> > -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> > +	/* check if there is any timed-out request */
> > +	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
> > +	if (expired.has_timedout_rq) {
> > +		/*
> > +		 * Before walking tags, we must ensure any submit started
> > +		 * before the current time has finished. Since the submit
> > +		 * uses srcu or rcu, wait for a synchronization point to
> > +		 * ensure all running submits have finished
> > +		 */
> > +		blk_mq_wait_quiesce_done(q);
> > +
> > +		expired.check_only = false;
> > +		expired.next = 0;
> > +		blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
> 
> I think it would be easier to follow with separate callbacks instead of
> special casing for 'check_only'. One callback for checking timeouts, and
> a different one for handling them?

Both two are basically same, with two callbacks, just .check_only is saved,
nothing else, meantime with one extra similar callback added.

If you or anyone think it is one big deal, I can switch to two callback version.


Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
