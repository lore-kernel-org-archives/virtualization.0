Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3297EC761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 18:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E00E416C9;
	Tue,  4 Apr 2023 18:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E00E416C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T+aNbcTj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQ_JEmPDroiQ; Tue,  4 Apr 2023 18:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 376B8410BB;
	Tue,  4 Apr 2023 18:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 376B8410BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13466C0037;
	Tue,  4 Apr 2023 18:16:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E02F0C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6C2980BEC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6C2980BEC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T+aNbcTj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nUXMZgdd-K08
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:16:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B18D480E99
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B18D480E99
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680632194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IteB3h1IFF9JrrwNNhJrcSxfFKVKvFn7WIKCluRji64=;
 b=T+aNbcTj0PM/4p7mCXMgq544SU8syIAaVzklZpnQiUMQnYz7EG8Aux7Um+kYCegnj/TKCo
 OqxjrWt4KnE457XBa44g+ZUUDdrzqcJtSRbb9ME3/+yvXjC6qnM1WP6SDb/hwhnTkNyzQ8
 DAcKd5FOIpGuO84sGZocwJUYmIQyF1w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-LzbWJsXjPJ-A70sGejEjuQ-1; Tue, 04 Apr 2023 14:16:32 -0400
X-MC-Unique: LzbWJsXjPJ-A70sGejEjuQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 s30-20020a508d1e000000b005005cf48a93so46885926eds.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 11:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680632191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IteB3h1IFF9JrrwNNhJrcSxfFKVKvFn7WIKCluRji64=;
 b=xKDnDiVI18hIXG35m2zDVpYwIURjKvcE/SBgekBgZ0OWXg/4NMe2HDrOKNtM7Pik3A
 L1SEyrDuv4c7xuitzecYYxRBNJmvw9/bFtj1oyjz9AItKuFDSyZwz93Z1GtLRldsNVKP
 MCwkyDi3RF5EbZCVfe5S1Kot7/KzZltn6l+jnqiHPYcGYbLVts4dP9VuJ0UUQU9SYDlN
 EooPDCies0BfRG7GrcFNAzXAlTnBsxB6TPS2AXR2qXqNIlldYGg6Fo0uuruajeeMHvXV
 c1Rb89BdJNRS7c0HKCkg1QJXJV/EXK2yNhD7aGMfN5i4jtagdZKOAfCchpdM1lgwLnuq
 3LJA==
X-Gm-Message-State: AAQBX9cIo7s/lJOb+mMD2IuCEjlPRPM41DsDHolNb1lzqJrusFUJ1FDl
 k4Kg+LxndFsTCKIZ6yqxuTZlXqVMGwSYwvPoGqZo7fY/S/ndMzdDs9+KPDi87KCy32T4iLndGFF
 FjKJKg0Y2QXr+Z7p6RLoAPgwmfcfFESLBdQfT8m8WeQ==
X-Received: by 2002:a17:906:4714:b0:84d:4e4f:1f85 with SMTP id
 y20-20020a170906471400b0084d4e4f1f85mr344216ejq.59.1680632191696; 
 Tue, 04 Apr 2023 11:16:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZCgo8S1M18VZAugvOWFRDnPyPjTek7bcWsZJ7qMIVGPNRWD16Sn2oW1a2cmFO9+19n6ACQMQ==
X-Received: by 2002:a17:906:4714:b0:84d:4e4f:1f85 with SMTP id
 y20-20020a170906471400b0084d4e4f1f85mr344205ejq.59.1680632191371; 
 Tue, 04 Apr 2023 11:16:31 -0700 (PDT)
Received: from redhat.com ([2.52.139.22]) by smtp.gmail.com with ESMTPSA id
 g1-20020a170906394100b00933356c681esm6266002eje.150.2023.04.04.11.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 11:16:30 -0700 (PDT)
Date: Tue, 4 Apr 2023 14:16:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v6] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230404141501-mutt-send-email-mst@kernel.org>
References: <20230324195029.2410503-1-viktor@daynix.com>
 <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>, Viktor Prutyanov <viktor@daynix.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "yan@daynix.com" <yan@daynix.com>
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

On Sun, Apr 02, 2023 at 08:17:49AM +0000, Alvaro Karsz wrote:
> Hi Viktor,
> 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4c3bb0ddeb9b..f9c6604352b4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2752,6 +2752,23 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> > 
> > +u32 vring_notification_data(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +       u16 next;
> > +
> > +       if (vq->packed_ring)
> > +               next = (vq->packed.next_avail_idx &
> > +                               ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))) |
> > +                       vq->packed.avail_wrap_counter <<
> > +                               VRING_PACKED_EVENT_F_WRAP_CTR;
> > +       else
> > +               next = vq->split.avail_idx_shadow;
> > +
> > +       return next << 16 | _vq->index;
> > +}
> > +EXPORT_SYMBOL_GPL(vring_notification_data);
> > +
> >  /* Manipulates transport-specific feature bits. */
> >  void vring_transport_features(struct virtio_device *vdev)
> >  {
> > @@ -2771,6 +2788,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >                         break;
> >                 case VIRTIO_F_ORDER_PLATFORM:
> >                         break;
> > +               case VIRTIO_F_NOTIFICATION_DATA:
> > +                       break;
> 
> This function is used by virtio_vdpa as well (drivers/virtio/virtio_vdpa.c:virtio_vdpa_finalize_features).
> A vDPA device can offer this feature and it will be accepted, even though VIRTIO_F_NOTIFICATION_DATA is not a thing for the vDPA transport at the moment.
> 
> I don't know if this is bad, since offering VIRTIO_F_NOTIFICATION_DATA is meaningless for a vDPA device at the moment.
> 
> I submitted a patch adding support for vDPA transport.
> https://lore.kernel.org/virtualization/20230402081034.1021886-1-alvaro.karsz@solid-run.com/T/#u

Hmm.  So it seems we need to first apply yours then this patch,
is that right? Or the other way around? What is the right way to make it not break bisect?
Do you mind including this patch with yours in a patchset
in the correct order?




> >                 default:
> >                         /* We don't understand this bit. */
> >                         __virtio_clear_bit(vdev, i);
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
