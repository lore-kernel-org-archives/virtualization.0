Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B831C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 10:38:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07006113D
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 10:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F07006113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A97A24041F;
	Tue, 19 Oct 2021 10:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XoU7JzNExOCz; Tue, 19 Oct 2021 10:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 253EF40117;
	Tue, 19 Oct 2021 10:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9CB8C000F;
	Tue, 19 Oct 2021 10:38:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3882C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A406040117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YnX8fWfoeQqk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A177E4025D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634639913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cwc5gH8dqOaYSCVX9S0ahR6ofa7v5M3UCjae7Uj61l8=;
 b=auxq5+enTsvtnB+V5fW+eryvMWnDC8cd6Y9XKFgjIdVQJJIwWUgIKGb1P/mt0tGbyLaluk
 8sBsiLTBEVmRsSdHalXea9YPc8ahQBTba+0SK2v4H22KAias1NiAZkCU88ARQvz8G40Pc8
 3Rb2spYiZfLw5ud9Z3U83ZJZM8b4KWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-mnRJbcoDM_6tFZfxo3971A-1; Tue, 19 Oct 2021 06:38:32 -0400
X-MC-Unique: mnRJbcoDM_6tFZfxo3971A-1
Received: by mail-wr1-f71.google.com with SMTP id
 r16-20020adfb1d0000000b00160bf8972ceso9980854wra.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 03:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cwc5gH8dqOaYSCVX9S0ahR6ofa7v5M3UCjae7Uj61l8=;
 b=r68E9YJsD0fs5tZiBzZlsyfy38OqirBZmi+OlVQuDMuT3Ie+bkrAp5K1LbWjAl+6p0
 GkgB0FXiwdym7oZhTPsgABUfX1j43fVTGSFKMRFuBMUW0/Rb09ApY4GzisEUPnm94fZd
 W/mdNo4MLc76fdnWrs2GdoUHCxgB90PKAoQkhFCAifu30SlVs9qRWF98BW1DKHtLr5Xx
 fqXWxxWV7g5r3C73KaMXXELGkLG/ZOzlT1q+7yOxwQC2AH1ZDkGZ18fj1G74sDMB/cXg
 oi1i/R/lIXRU3YLRgDi9OOLWhlsA5COp8Mb8LfwJZxU8jiX79TsZ+a+h2CIz1d5uZPr0
 6yug==
X-Gm-Message-State: AOAM531T0fo1pbNXNfuvXUlOrEzdFsfCKi8SskW6QGKpdb6xfRTl7gE+
 Ccjr3nzFybkqQN85GLS554KklMGQ7Al7A2b6OWjBGaywqnTHlEYo6RFp22AOSgu7MIlGWcMY+EZ
 QN07KUdPl4OolFh6PDb1WwzxTSRcbiT2EiYRtwuY9oA==
X-Received: by 2002:a1c:9857:: with SMTP id a84mr5030930wme.28.1634639911071; 
 Tue, 19 Oct 2021 03:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQQtHoL+g3a4z51tzLIgc/14qDaK1jCyrUhxBQxa1alm68+TkhmzXNHKofzIyIdXCnXMX0VA==
X-Received: by 2002:a1c:9857:: with SMTP id a84mr5030910wme.28.1634639910847; 
 Tue, 19 Oct 2021 03:38:30 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id r5sm1810291wmh.28.2021.10.19.03.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 03:38:30 -0700 (PDT)
Date: Tue, 19 Oct 2021 06:38:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] virtio_ring: fix style of
 virtqueue_add_indirect_packed
Message-ID: <20211019063754-mutt-send-email-mst@kernel.org>
References: <CACGkMEvA4GjbFyftndGVAWnPWP6pMy4o35xKtVhrjmmNE-uLvA@mail.gmail.com>
 <1634631341.208131-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1634631341.208131-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Oct 19, 2021 at 04:15:41PM +0800, Xuan Zhuo wrote:
> On Tue, 28 Sep 2021 11:14:47 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Sep 27, 2021 at 6:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Fix the style problem of virtqueue_add_indirect_packed(). The next patch
> > > involves the modification of this function.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Hi, this patch set seems to have not been merged, is there something wrong with me?
> 
> Thanks.

there's no problem as such. something like

"align arguments to the open ( to make it look prettier"
would be more correct.


> >
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index dd95dfd85e98..91a46c4da87d 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1050,12 +1050,12 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> > >  }
> > >
> > >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > -                                      struct scatterlist *sgs[],
> > > -                                      unsigned int total_sg,
> > > -                                      unsigned int out_sgs,
> > > -                                      unsigned int in_sgs,
> > > -                                      void *data,
> > > -                                      gfp_t gfp)
> > > +                                        struct scatterlist *sgs[],
> > > +                                        unsigned int total_sg,
> > > +                                        unsigned int out_sgs,
> > > +                                        unsigned int in_sgs,
> > > +                                        void *data,
> > > +                                        gfp_t gfp)
> > >  {
> > >         struct vring_packed_desc *desc;
> > >         struct scatterlist *sg;
> > > --
> > > 2.31.0
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
