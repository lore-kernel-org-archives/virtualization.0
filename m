Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B2C4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:47:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68443235F7
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68443235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF587874EE;
	Wed,  9 Dec 2020 12:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZbSg+VaZVgY; Wed,  9 Dec 2020 12:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3619487514;
	Wed,  9 Dec 2020 12:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18F9CC0FA7;
	Wed,  9 Dec 2020 12:47:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A4FC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3137D87514
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0pxb7HepuHad
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 54482874EE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607518057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5/QC77pLL7q6oLDtS15hQa633CfWuWBmAY6OEIwT1U=;
 b=EKpw/R8zYE1vd3a8myzQSv4t0a4TIiGLy2xRLhGEDIYULIE94z3P9Wri+mkuPQsxPVtAtC
 mDpTUm3HRbb5X+JHi0AY7LXORmUelGqe+FfHfRU+Bc99n6A480cutV5tqQvpAtfBAq8Xrx
 6Ys75M7BbNZ1Bp5O3cpGrIACi1XG0CE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rJdJQ1tFOfaimxxeygrWLQ-1; Wed, 09 Dec 2020 07:47:35 -0500
X-MC-Unique: rJdJQ1tFOfaimxxeygrWLQ-1
Received: by mail-wr1-f70.google.com with SMTP id w8so608220wrv.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 04:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t5/QC77pLL7q6oLDtS15hQa633CfWuWBmAY6OEIwT1U=;
 b=SOYZxd8AYAVaVP930vcq5d6ywHquw4SoR2Zfrm5acewMAdLgttCq+i5Lucoz9C4g9C
 VnezMRiVitZtaQIiq/sHmOsosxmcgetBxYz+7RlJXgFk8K5wn3x1nF/haKtbzI5bWqpc
 8Py8Vm6B/BiEkeCvWmn8l7CWfg4axBZ7TXqId3QxLz3NgdUoPaYGzdMvqrAZnqF6eiPv
 BhUg9gPKEF/fSb1RH0r8ItpdSJvLoV4MJJkW0cGkGL/r0GtKJ4+7UY9e4gMzFQd1hM24
 uBB/kCUGd/z+nJ5gVoYAgY1sLNf4F0/zcVOKRJL7a7GLyXSzB/Ps6X8ENwX8WdVO5Cbe
 g+wA==
X-Gm-Message-State: AOAM532BB2AITYx/8wZAWaeTb4/qr+8h0BR6+cZGvhXHsGXLpx3UQ9Pe
 uCuMYBqcS/kPKG+AYfsa7UHlShXG9G/a25aVbhP+gF/uRgg1kJGJlt0n4L3W+ocNxyNxouU1ABy
 HCxyyKgK8NUxQAefDfYOex/+HkZw+feE9z3gxwbBClQ==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2676757wml.155.1607518053506; 
 Wed, 09 Dec 2020 04:47:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0xGiVf4PphEDlh5fmvmna9OBjQj5phL3O8OvQlmZbwiqsSHc0XXcX9/n8UGHxS+qcdiceqA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2676744wml.155.1607518053325; 
 Wed, 09 Dec 2020 04:47:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id d187sm3476873wmd.8.2020.12.09.04.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 04:47:32 -0800 (PST)
Date: Wed, 9 Dec 2020 07:47:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209074703-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
 <20201209014547-mutt-send-email-mst@kernel.org>
 <20201209065846.GA59515@mtl-vdi-166.wap.labs.mlnx>
 <20201209025712-mutt-send-email-mst@kernel.org>
 <20201209093836.GA62204@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201209093836.GA62204@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Wed, Dec 09, 2020 at 11:38:36AM +0200, Eli Cohen wrote:
> On Wed, Dec 09, 2020 at 03:05:42AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 09, 2020 at 08:58:46AM +0200, Eli Cohen wrote:
> > > On Wed, Dec 09, 2020 at 01:46:22AM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> > > > > On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > > > > > Make sure to put write memory barrier after updating CQ consumer index
> > > > > > > so the hardware knows that there are available CQE slots in the queue.
> > > > > > > 
> > > > > > > Failure to do this can cause the update of the RX doorbell record to get
> > > > > > > updated before the CQ consumer index resulting in CQ overrun.
> > > > > > > 
> > > > > > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > 
> > > > > > Aren't both memory writes?
> > > > > 
> > > > > Not sure what exactly you mean here.
> > > > 
> > > > Both updates are CPU writes into RAM that hardware then reads
> > > > using DMA.
> > > > 
> > > 
> > > You mean why I did not put a memory barrier right after updating the
> > > recieve doorbell record?
> > 
> > Sorry about being unclear.  I just tried to give justification for why
> > dma_wmb seems more appropriate than wmb here. If you need to
> > order memory writes wrt writes to card, that is different, but generally
> > writeX and friends will handle the ordering for you, except when
> > using relaxed memory mappings - then wmb is generally necessary.
> > 
> 
> Bear in mind, we're writing to memory (not io memory). In this case, we
> want this write to be visible my the DMA device.
> 
> https://www.kernel.org/doc/Documentation/memory-barriers.txt gives a
> similar example using dma_wmb() to flush updates to make them visible
> by the hardware before notifying the hardware to come and inspect this
> memory.

Exactly.

> 
> > > I thought about this and I think it is not required. Suppose it takes a
> > > very long time till the hardware can actually see this update. The worst
> > > effect would be that the hardware will drop received packets if it does
> > > sees none available due to the delayed update. Eventually it will see
> > > the update and will continue working.
> > > 
> > > If I put a memory barrier, I put some delay waiting for the CPU to flush
> > > the write before continuing. I tried both options while checking packet
> > > rate on couldn't see noticable difference in either case.
> > 
> > 
> > makes sense.
> > 
> > > > > > And given that, isn't dma_wmb() sufficient here?
> > > > > 
> > > > > I agree that dma_wmb() is more appropriate here.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > > > > > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > > > > > >  {
> > > > > > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > > > > > +
> > > > > > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > > > > > +	 * RX doorbell record.
> > > > > > > +	 */
> > > > > > > +	wmb();
> > > > > > >  	rx_post(&mvq->vqqp, num);
> > > > > > >  	if (mvq->event_cb.callback)
> > > > > > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > > > > > -- 
> > > > > > > 2.27.0
> > > > > > 
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
