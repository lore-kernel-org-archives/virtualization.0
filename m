Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C03FCD4F57
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 10:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 088AF4210B;
	Fri, 22 Sep 2023 10:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 088AF4210B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GbFWs1a6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCHq6OyWtkXG; Fri, 22 Sep 2023 10:46:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 591AE41F80;
	Fri, 22 Sep 2023 10:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 591AE41F80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EF16C0039;
	Fri, 22 Sep 2023 10:46:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE8C9C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A4FC41F80
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A4FC41F80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6_S35or6MkJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:46:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23C07416C9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:46:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23C07416C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695379610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=523CLNpg/sOwhLY70FMKKiUkZU7FDspbvgGF4P5huNs=;
 b=GbFWs1a6vULU+egABQkZGxqrjH5nY57GIPKRgKhe27EAbHpLR/NMJsYTFcCM6lOdnf2kn8
 lLh5N1dSLKmhobXgDkNehXmseV179D+Q2kMXjJUk77UPzyVSU/tXQR2viylk5gjOAtJmfG
 m+utMEptyL99WH2HyDbIhq3wcXv4Pp0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-XmgsdV_LPjK7ZNGOOIhbIA-1; Fri, 22 Sep 2023 06:46:48 -0400
X-MC-Unique: XmgsdV_LPjK7ZNGOOIhbIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0b4so159226066b.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695379607; x=1695984407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=523CLNpg/sOwhLY70FMKKiUkZU7FDspbvgGF4P5huNs=;
 b=Q0HiOQQpNbYSJ+cYmLCAKnraZmA7WUmDWjaQQYZjbjOVWi8rqHmM6PksGNjrkYC9rB
 0y5lp3pXaEHp2pwkUmuRtXyBl2EGIKVvme3a1NHBwJnQFDvAKeTgAR8cfHAJHiAqlAxG
 h81ULub7qz65XX9ZIhvjS64eiHF9BPEOudYkD3of9MUpysKEvggE5bq+hMptW7JJ2aTw
 +Y5qNofs7wfYbejx6bD9E4oXU465RKy5q60GfFseG6GPKh5elybxIQWS1hmMNRr++LsY
 n3lXZFMWvDP9w6kJFRGGjUy5f0NZULyXHBqzL03QWVupGl9uNlS0fRhfjkxfZMoOc2oc
 iZ9A==
X-Gm-Message-State: AOJu0YyA8MJcunz5oDDzl5NfBU/yjuTwQnYhDVKE1v6c7nz5Q6ONjppJ
 AGZGDiXbK+Xa6fFcarO0765NJ5ZRJ9TvJqLmUsp6szQbFmc1pDdrmX9Th8mgACP/VnAIkdW3YWw
 kYBhjJFOh2h8dZItLxiDhNCt9qsJggV5zfuoBfv6LMQ==
X-Received: by 2002:a17:906:41:b0:9ad:e66a:4141 with SMTP id
 1-20020a170906004100b009ade66a4141mr7499965ejg.28.1695379607569; 
 Fri, 22 Sep 2023 03:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/7A6BDEm5D1OAZEqbWCsMuJ65vhHu1qiz2aGlCcO2bpN2TOKZRlo73gCToO1Ojpp+az0gQA==
X-Received: by 2002:a17:906:41:b0:9ad:e66a:4141 with SMTP id
 1-20020a170906004100b009ade66a4141mr7499940ejg.28.1695379607265; 
 Fri, 22 Sep 2023 03:46:47 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 d26-20020a1709064c5a00b009ad875d12d7sm2528479ejw.210.2023.09.22.03.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:46:46 -0700 (PDT)
Date: Fri, 22 Sep 2023 06:46:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue
 reset
Message-ID: <20230922064550-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
 <20230921100112-mutt-send-email-mst@kernel.org>
 <1695347358.2770545-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1695347358.2770545-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Sep 22, 2023 at 09:49:18AM +0800, Xuan Zhuo wrote:
> On Thu, 21 Sep 2023 10:02:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> > > Introduce new helpers to implement queue reset and get queue reset
> > > status.
> > >
> > >  https://github.com/oasis-tcs/virtio-spec/issues/124
> > >  https://github.com/oasis-tcs/virtio-spec/issues/139
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
> > >  include/linux/virtio_pci_modern.h      |  2 ++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index fa2a9445bb18..869cb46bef96 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/virtio_pci_modern.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/delay.h>
> > >
> > >  /*
> > >   * vp_modern_map_capability - map a part of virtio pci capability
> > > @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > >
> > > +/*
> > > + * vp_modern_get_queue_reset - get the queue reset status
> > > + * @mdev: the modern virtio-pci device
> > > + * @index: queue index
> > > + */
> > > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > > +{
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > > +
> > > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > > +	return vp_ioread16(&cfg->queue_reset);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> > > +
> >
> > Actually, this does not validate that the config structure is big
> > enough. So it can access some unrelated memory. Don't know whether
> > that's exploitable e.g. for CoCo but not nice, anyway.
> > Need to validate the size and disable reset if it's too small.
> 
> 
> static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
> {
> 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> 	struct virtio_pci_vq_info *info;
> 	unsigned long flags;
> 
> ->	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> 		return -ENOENT;
> 
> 	vp_modern_set_queue_reset(mdev, vq->index);
> 
> 
> I checked VIRTIO_F_RING_RESET before call this.

Yes but the point is that virtio is used with untrusted devices
(e.g. for SEV/TDX), so you can't really assume config structures
are in sync with feature bits.


> Do you mean, we should put the check to this function.
> 
> 
> Thanks.
> 
> 
> 
> >
> >
> > > +/*
> > > + * vp_modern_set_queue_reset - reset the queue
> > > + * @mdev: the modern virtio-pci device
> > > + * @index: queue index
> > > + */
> > > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > > +{
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > > +
> > > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > > +	vp_iowrite16(1, &cfg->queue_reset);
> > > +
> > > +	while (vp_ioread16(&cfg->queue_reset))
> > > +		msleep(1);
> > > +
> > > +	while (vp_ioread16(&cfg->cfg.queue_enable))
> > > +		msleep(1);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > +
> > >  /*
> > >   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
> > >   * @mdev: the modern virtio-pci device
> > > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > > index 05123b9a606f..c4eeb79b0139 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
> > >  				       u16 index, resource_size_t *pa);
> > >  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
> > >  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> > > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> > > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> > >  #endif
> > > --
> > > 2.31.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
