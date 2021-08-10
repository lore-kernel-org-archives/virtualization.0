Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 15:55:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3EB60EDF
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 15:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D3EB60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DEBF60620;
	Tue, 10 Aug 2021 15:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgM1EX7JqRxO; Tue, 10 Aug 2021 15:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8C7B606C9;
	Tue, 10 Aug 2021 15:55:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8E2FC0010;
	Tue, 10 Aug 2021 15:55:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02F7CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5BC8403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwuc75tXuqKB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:55:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7F2840357
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628610912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6JGdWkKZw7m5I7Ml6W62XXk0juw8pt6sorDOvoT2gRc=;
 b=EhdjvSlZxRVcCJcWxNK3nhtBLcP77wdLmZbU+xETYq71DVJUSGV2sSKDLe01i2tknbwern
 8IDl+jrRrvYVs/J59I50+AMDntPL0/ZWveePDXTgK2xndwtK1EAMDong/F/WdJwEoQAbog
 ncf1/+BrZZ7TrUD5TllJKIOaSw7uIKo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-fv3DUyZUOyyjdbGurcspVA-1; Tue, 10 Aug 2021 11:55:11 -0400
X-MC-Unique: fv3DUyZUOyyjdbGurcspVA-1
Received: by mail-ed1-f72.google.com with SMTP id
 cm18-20020a0564020c92b02903bc7f21d540so10962241edb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 08:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6JGdWkKZw7m5I7Ml6W62XXk0juw8pt6sorDOvoT2gRc=;
 b=m3wucoi+JUfGqPiTKvgrOlpdxRSbIWQdquhF3v08hgIXqDvr8a5ec7YF1bV6vQ3PLG
 FLnsz3yS9vzym4UmhdKW0wp+A19K8Ft7id2EJcOJ4SsodiaNE8D1wrAguF1vJMgLef94
 Vxcteot3lDdxFDyXJ1VmFt4AE4PXMTnj/x7G2/6J1cQLgZVCW9Oka7oBhoobG7G2ZXUs
 X0j72X8PttGd6dbQm9UmBjfb3z5Oc3PfYD03lC3sSLT+s/pg86uIfTApK9L/RDKLFEY+
 z50awVcsYpByGj8CEhCZ1pFIS712GIzFaD23sN9r6cAwna4WDe4j5peDwHWzQ/G1bL9o
 myMA==
X-Gm-Message-State: AOAM533qbuZdYEZNnh7KoNDosCcP95Jo5mSE7NIS6Bp/FDLydq5hboLI
 wsmu20F5YOIzDynhZohIKIOw5K8AdspuNd5jKiDEDZ+rQeyL65kbpwftzw2/aU0luaipnBmrVz/
 zZuhUefCovp2d75q9pdY/pvW/pRo9U7/9/gm1PBqDSw==
X-Received: by 2002:a05:6402:10d7:: with SMTP id
 p23mr5765628edu.74.1628610910301; 
 Tue, 10 Aug 2021 08:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhAqOjbpwq6qZvKf52l1eB2CXoys1g5LMgipiutGJOsuuQSXt7GBewnhdf/LGYjWompbmqjw==
X-Received: by 2002:a05:6402:10d7:: with SMTP id
 p23mr5765602edu.74.1628610910109; 
 Tue, 10 Aug 2021 08:55:10 -0700 (PDT)
Received: from redhat.com ([2.55.156.103])
 by smtp.gmail.com with ESMTPSA id jo17sm3085686ejb.40.2021.08.10.08.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 08:55:08 -0700 (PDT)
Date: Tue, 10 Aug 2021 11:55:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vdpa/vdpa_sim: Use the negotiated features when
 calling vringh_init_iotlb
Message-ID: <20210810115418-mutt-send-email-mst@kernel.org>
References: <20210720052533.415991-1-elic@nvidia.com>
 <20210720065740.56udn3ndebzvu26o@steredhat>
 <20210720071435.GA4647@mtl-vdi-166.wap.labs.mlnx>
 <20210720081327.6govoz2jjb6osxjt@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210720081327.6govoz2jjb6osxjt@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
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

On Tue, Jul 20, 2021 at 10:13:27AM +0200, Stefano Garzarella wrote:
> On Tue, Jul 20, 2021 at 10:14:35AM +0300, Eli Cohen wrote:
> > On Tue, Jul 20, 2021 at 08:57:40AM +0200, Stefano Garzarella wrote:
> > > On Tue, Jul 20, 2021 at 08:25:33AM +0300, Eli Cohen wrote:
> > > > When calling vringh_init_iotlb(), use the negotiated features which
> > > > might be different than the supported features.
> > > >
> > > > Fixes: 2c53d0f64c06f ("vdpasim: vDPA device simulator")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > > v0 --> v1:
> > > > Update "Fixes" line
> > > >
> > > > drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
> > > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > index 14e024de5cbf..89a474c7a096 100644
> > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> > > > {
> > > > 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> > > >
> > > > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > > > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> > > > 			  VDPASIM_QUEUE_MAX, false,
> > > > 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
> > > > 			  (struct vring_avail *)
> > > > @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> > > > 	vq->device_addr = 0;
> > > > 	vq->cb = NULL;
> > > > 	vq->private = NULL;
> > > > -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> > > > +	vringh_init_iotlb(&vq->vring, vdpasim->features,
> > > 
> > > vdpasim_vq_reset() is called while resetting the device in vdpasim_reset()
> > > where we also set `vdpasim->features = 0` after resetting the vqs, so maybe
> > > it's better to use the supported features here, since the negotiated ones
> > > are related to the previous instance.
> > > 
> > 
> > I don't think using supported features is valid. Better to make sure
> > vringh_init_iotlb() is called after the features have been negotiated.
> > 
> 
> I think the vringh_init_iotlb() call in vdpasim_vq_reset() is just used to
> clean up the `struct vringh`, then it will be initialized in
> vdpasim_queue_ready() when features have already been negotiated.
> 
> Maybe here we can pass 0 (to the features parameter) if we don't want to use
> the features supported by the device.
> 
> Thanks,
> Stefano

Eli? Maybe you can describe what is the observed bug the patch
is trying to fix.

Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
