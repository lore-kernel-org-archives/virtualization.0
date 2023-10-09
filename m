Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A5EE95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CBA56114E;
	Mon,  9 Oct 2023 10:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CBA56114E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/j2h8n4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZubECT7hTPP; Mon,  9 Oct 2023 10:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D74E86114F;
	Mon,  9 Oct 2023 10:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D74E86114F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4B3C0071;
	Mon,  9 Oct 2023 10:37:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9D15C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FB32415D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FB32415D9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/j2h8n4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6fT9XNCR6J3i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:37:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3457141517
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3457141517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696847840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVkt4f+cAU5YV1Y7/kjxW/Py3q2JOj+YxtMv25MEH8s=;
 b=c/j2h8n4lLjaR4vQGF0GdTeUc+hjkSsVMSQi6BNsv+CpIVmQRpegsrwpCdlTzmlniOtMyD
 6k5TfJNwmDwcJWR5zbLshKBN77sjBvlEhjEyGyDgkaG9R1cOzmT9yt+CtJEaZcTDTI/uxf
 GcWld56eEEqpY34u7EuxD3yt6TGC6OU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-Lfhvj4pcMLKum7y7wwQ2Zw-1; Mon, 09 Oct 2023 06:37:18 -0400
X-MC-Unique: Lfhvj4pcMLKum7y7wwQ2Zw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso102108666b.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696847837; x=1697452637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVkt4f+cAU5YV1Y7/kjxW/Py3q2JOj+YxtMv25MEH8s=;
 b=Ws6tCIyCusJ8Iwexo1gxjNV8PIylf4Oky+p+nbyIydfROcPOsvD09utNO6JV/s/JQz
 iBJR8HhVjPzl6sEDlCuBBc/9Jpv1WC4pUZLYCJsxdBpmAyYOGZslvStHDuBISZbJN0Ny
 +aXXddgfACfDulhHkW7z/b5BYd8Q0J/jCbNCtt4nG5nPkEQxXbdHe+5FtQcIXzTU6zH7
 fKRorYBvjLiTU+SkOxMfDCXS8mPc/Y+7/8nyij8GWiiSTbyIHQq5izwRZ6qY1UeVTnnJ
 r5+o0BREp/xf4vUX0pyPwtzE2E40hHC7ek+5Hr+xUnsD81/C+mQuxMkNm+z6xXmyL9ho
 J/Sw==
X-Gm-Message-State: AOJu0YyltZ6nEeSm1jR/igG5C8n+NPHJ2GA2M2/fa5IrGTgxkExkN29V
 AXGstT9FFTw5buoIaquN7mj8sRlT6qkdDFdSvHcg9lDl9nrdrWh5ndtdVu4EJWDxv+1iO0U6x51
 Qf/xrKOPUmRlfSiolxDTaI8FEYTy9+9RRpyStejX0wDDfb+5kFg==
X-Received: by 2002:a17:906:73c1:b0:9b9:fce8:e073 with SMTP id
 n1-20020a17090673c100b009b9fce8e073mr8470190ejl.26.1696847837257; 
 Mon, 09 Oct 2023 03:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFazHKRuPJhh2GvaaBl3ZBAAdjwZwO6e4Mt8wTemFh3CAzn2qWckWhjbgOOhbLUhEIGqUnKHw==
X-Received: by 2002:a17:906:73c1:b0:9b9:fce8:e073 with SMTP id
 n1-20020a17090673c100b009b9fce8e073mr8470162ejl.26.1696847836804; 
 Mon, 09 Oct 2023 03:37:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
 by smtp.gmail.com with ESMTPSA id
 si5-20020a170906cec500b009875a6d28b0sm6571045ejb.51.2023.10.09.03.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 03:37:15 -0700 (PDT)
Date: Mon, 9 Oct 2023 06:37:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 1/2] virtio_pci: fix the common map size and add
 check for common size
Message-ID: <20231009063640-mutt-send-email-mst@kernel.org>
References: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
 <20231008093842.87131-2-xuanzhuo@linux.alibaba.com>
 <20231008063339-mutt-send-email-mst@kernel.org>
 <1696814131.4268396-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1696814131.4268396-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Mon, Oct 09, 2023 at 09:15:31AM +0800, Xuan Zhuo wrote:
> On Sun, 8 Oct 2023 06:42:37 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Sun, Oct 08, 2023 at 05:38:41PM +0800, Xuan Zhuo wrote:
> > > Now, the function vp_modern_map_capability() takes the size parameter,
> > > which corresponds to the size of virtio_pci_common_cfg. As a result,
> > > this indicates the size of memory area to map.
> > >
> > > However, if the _F_RING_RESET is negotiated, the extra items will be
> > > used. Therefore, we need to use the size of virtio_pci_modern_common_cfg
> > > to map more space.
> > >
> > > Meanwhile, this patch removes the feature(_F_RING_ERSET and
> >
> > typo
> >
> > > _F_NOTIFICATION_DATA) when the common cfg size does not match
> > > the corresponding feature.
> > >
> > > Fixes: 0b50cece0b78 ("virtio_pci: introduce helper to get/set queue reset")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c     | 20 +++++++++++++++++++-
> > >  drivers/virtio/virtio_pci_modern_dev.c |  4 ++--
> > >  include/linux/virtio_pci_modern.h      |  1 +
> > >  3 files changed, 22 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index d6bb68ba84e5..c0b9d2363ddb 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -22,8 +22,26 @@
> > >  static u64 vp_get_features(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +	u64 features = vp_modern_get_features(&vp_dev->mdev);
> > > +
> > > +#define check_feature(feature, field)								\
> > > +	do {											\
> > > +		if (features & BIT_ULL(feature)) {						\
> > > +			u32 offset = offsetofend(struct virtio_pci_modern_common_cfg, field);	\
> > > +			if (unlikely(vp_dev->mdev.common_len < offset))				\
> > > +				features &= ~BIT_ULL(feature);					\
> > > +		}										\
> > > +	} while (0)
> > > +
> > > +	/* For buggy devices, if the common len does not match the feature, we
> > > +	 * remove the feature.
> >
> > I don't like doing this in vp_get_features. userspace won't be able
> > to see the actual device features at all.
> > Also, we should print an info message at least.
> >
> > I am still debating with myself whether clearing feature bits
> > or just failing finalize_features (and thus, probe) is best.
> 
> For me, I think failing probe is best.
> 
> Then the developer of the device can find that firstly.
> And I think we should print an info message when we detect
> this error.

If you fail probe - maybe even a warning.

> If we clear the feature bits, the developer of the device may
> ignore this error.
> 
> >
> >
> > > +	 */
> > > +	check_feature(VIRTIO_F_NOTIFICATION_DATA, queue_notify_data);
> > > +	check_feature(VIRTIO_F_RING_RESET, queue_reset);
> > > +
> > > +#undef check_feature
> >
> > this macro's too scary. just pass offset and feature bit as
> > parameters to an inline function.
> 
> I should pass the features as a parameter.
> 
> Thanks.
> 
> 
> 
> >
> > >
> > > -	return vp_modern_get_features(&vp_dev->mdev);
> > > +	return features;
> > >  }
> > >
> > >  static void vp_transport_features(struct virtio_device *vdev, u64 features)
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index aad7d9296e77..33f319da1558 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -291,8 +291,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > >  	err = -EINVAL;
> > >  	mdev->common = vp_modern_map_capability(mdev, common,
> > >  				      sizeof(struct virtio_pci_common_cfg), 4,
> > > -				      0, sizeof(struct virtio_pci_common_cfg),
> > > -				      NULL, NULL);
> > > +				      0, sizeof(struct virtio_pci_modern_common_cfg),
> > > +				      &mdev->common_len, NULL);
> > >  	if (!mdev->common)
> > >  		goto err_map_common;
> > >  	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> > > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > > index 067ac1d789bc..edf62bae0474 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -28,6 +28,7 @@ struct virtio_pci_modern_device {
> > >  	/* So we can sanity-check accesses. */
> > >  	size_t notify_len;
> > >  	size_t device_len;
> > > +	size_t common_len;
> > >
> > >  	/* Capability for when we need to map notifications per-vq. */
> > >  	int notify_map_cap;
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
