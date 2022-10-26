Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E5BC38A2D
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 00:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B637060B51;
	Wed, 26 Oct 2022 00:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B637060B51
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hA3Q49Gv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h7Qjn1T9XJlk; Wed, 26 Oct 2022 00:21:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25A9F60AAA;
	Wed, 26 Oct 2022 00:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25A9F60AAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E47F4C0032;
	Wed, 26 Oct 2022 00:21:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C887FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B10540252
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:21:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B10540252
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hA3Q49Gv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wNip7_TZV-Fj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:21:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADC5840250
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADC5840250
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666743701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJVTvBkVHMZ/lT8r9tRA2ACgcAQ2VeGXc5dkhOHZb+4=;
 b=hA3Q49Gv0o7FW2k08IUwIu8EYAZni9f95ItzkU1wW/BAPxCRbjmMX2Gb3R8Y61FiKhkfaR
 jvZiVMrWwZOde2oUm15eflmYWjoNmuw09ozDPJ4OhjQkBgT+Noyc2R9DvOpzE4QanY7/ZU
 xMxBsuP0cH2Jk2r2+6PIiArfMXSmmr0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-MAUn63qdMM-rl5IPi0RQvw-1; Tue, 25 Oct 2022 20:21:35 -0400
X-MC-Unique: MAUn63qdMM-rl5IPi0RQvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 808CC3C10149;
 Wed, 26 Oct 2022 00:21:34 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5E640C6EC6;
 Wed, 26 Oct 2022 00:21:27 +0000 (UTC)
Date: Wed, 26 Oct 2022 08:21:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early timeout
Message-ID: <Y1h9fiY8TYD8HK5v@T590>
References: <20221025005501.281460-1-ming.lei@redhat.com>
 <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: David Jeffery <djeffery@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
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

On Tue, Oct 25, 2022 at 12:11:39PM -0600, Jens Axboe wrote:
> On 10/24/22 6:55 PM, Ming Lei wrote:
> > @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
> >  	if (!percpu_ref_tryget(&q->q_usage_counter))
> >  		return;
> >  
> > -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> > +	/*
> > +	 * Before walking tags, we must ensure any submit started before
> > +	 * the current time has finished. Since the submit uses srcu or rcu,
> > +	 * wait for a synchronization point to ensure all running submits
> > +	 * have finished
> > +	 */
> > +	blk_mq_wait_quiesce_done(q);
> 
> I'm a little worried about this bit - so we'll basically do a sync RCU
> every time the timeout timer runs... Depending on machine load, that
> can take a long time.

Yeah, the per-queue timeout timer is never canceled after request is
completed, so most of times the timeout work does nothing.

Can we run the sync RCU only if there is timed out request found? Then
the wait is only needed in case that timeout handling is required. Also
sync rcu is already done in some driver's ->timeout().


Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
