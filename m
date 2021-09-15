Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50560C433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 11:07:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96E860724
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 11:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E96E860724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9627F4056A;
	Wed, 15 Sep 2021 11:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nrl-xvjtKNaK; Wed, 15 Sep 2021 11:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1F0A4015B;
	Wed, 15 Sep 2021 11:07:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C71A0C000F;
	Wed, 15 Sep 2021 11:07:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEA7C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2C1160ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JS56WONEQYl9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:07:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 436B76079A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631704047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5T4EtY6YqPdr6DqANexUv6V+E1smvYyFTvihkINkGvw=;
 b=bVD1Lc0MNYUxsApaypv8fQHJnxvVHkXFkicP2qnstMhIKTOhfpFfCQ3w+/gM7JeP5J73v1
 a+2riIxEpi5BF0srmw9/ORhHAeSutihJO1gPPdMYCrdHs5fTsj/D1lksEWmdlDduS675gU
 KzDgBm/LlxQENWjy3Y91xgko8Wq6ZZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-0T6dthqAMxKmQXkwYsCOiA-1; Wed, 15 Sep 2021 07:07:25 -0400
X-MC-Unique: 0T6dthqAMxKmQXkwYsCOiA-1
Received: by mail-wr1-f72.google.com with SMTP id
 v15-20020adff68f000000b0015df51efa18so877975wrp.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5T4EtY6YqPdr6DqANexUv6V+E1smvYyFTvihkINkGvw=;
 b=JYFEWjjx/lEvZCYKPL+nCdkghz2beTONfUF5Qq5tb08LMi5W2UovDFas+7avoAzTqf
 g14GzywcNfLZ+AKkMEPoJTHscAH6wvIIDL0GSSxtD8/5Iw7irZWJReTXexjryBrCqw2w
 KMM2EPwOkB8XJ0sWtenbvl1sOyDjhQXkqMo6xHt1ROzuw4+75nyg3vkqyiBfH3eYwith
 PjPU9eGfATiEYV6Tm5w8HDbV2mdZVw9Q4tUHAdRTPFNRB+jSdvUfaJyIQQJldlp0oHbg
 B/c5wQIV/XNhQ+0pPzXz56Unze2ZhgrXEUTjmEo2DIn8RFMs2cJJILXnlVKcF7e2D4u5
 dODg==
X-Gm-Message-State: AOAM5317+ugQUJoGN3fBtpXZodug0AvMgkG/PQqsh5TLBYB97eLi8qse
 Xd0693AUDTpTTnmzCNpvyi1GJzOSc6OuQObUEAV8p14+8U/XpJBtx0iHCI/rRW4RTxNtjwo6BbU
 wN/jEId8u/mp5PeHXQqTPAfzeKPopFu3+5cZ7RMleIw==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3739739wma.45.1631704044492;
 Wed, 15 Sep 2021 04:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiUVcCDKx5a58kfJEqz/PWXLAkHjoq4C2QIF0d6VJLqiZp8O7h7BGO9k24Gn5jr6a+O4qTGA==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3739706wma.45.1631704044191;
 Wed, 15 Sep 2021 04:07:24 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
 by smtp.gmail.com with ESMTPSA id z12sm8302896wro.75.2021.09.15.04.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 04:07:23 -0700 (PDT)
Date: Wed, 15 Sep 2021 07:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Message-ID: <20210915070703-mutt-send-email-mst@kernel.org>
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
 <20210915032510-mutt-send-email-mst@kernel.org>
 <20210915075232.GA18977@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
In-Reply-To: <20210915075232.GA18977@L-PF27918B-1352.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
 tiwei.bie@intel.com, virtualization@lists.linux-foundation.org
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

On Wed, Sep 15, 2021 at 03:52:32PM +0800, Wu Zongyong wrote:
> On Wed, Sep 15, 2021 at 03:26:41AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 15, 2021 at 02:39:32PM +0800, Wu Zongyong wrote:
> > > Currently we unset vq irq after freeing irq and that will result in
> > > error messages:
> > > 
> > >   pi_update_irte: failed to update PI IRTE
> > >   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
> > > 
> > > This patch solves this.
> > > 
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index f41d081777f5..15bae2290bf9 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
> > >  		return -EINVAL;
> > >  
> > > +	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		for (i = 0; i < nvqs; i++)
> > > +			vhost_vdpa_unsetup_vq_irq(v, i);
> > > +
> > 
> > If we do this before reset like this then the device might assert the
> > irq, might it not?
> > 
> This would not be a problem.
> AFAIK, vhost_vdpa_unsetup_vq_irq just disables the irq offloading, and the irq
> will be handled if there comes an irq.

Oh, right. ACK.

> > >  	if (status == 0) {
> > >  		ret = ops->reset(vdpa);
> > >  		if (ret)
> > 
> > 
> > > @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  		for (i = 0; i < nvqs; i++)
> > >  			vhost_vdpa_setup_vq_irq(v, i);
> > >  
> > > -	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > -		for (i = 0; i < nvqs; i++)
> > > -			vhost_vdpa_unsetup_vq_irq(v, i);
> > > -
> > >  	return 0;
> > 
> > 
> > 
> > >  }
> > >  
> > > -- 
> > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
