Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D02C433EF
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 07:34:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11464610FC
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 07:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11464610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDDF24038A;
	Wed,  3 Nov 2021 07:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NhpC3l1uVBEG; Wed,  3 Nov 2021 07:34:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49C36403BD;
	Wed,  3 Nov 2021 07:34:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1841BC0019;
	Wed,  3 Nov 2021 07:34:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23D1BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A70440101
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0WyCk0f4Gls
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:34:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF6C1400F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635924859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2evzeN2dUJ97RkJYIYZWd1y4ZdCaTHeSbdPXFeoqPXY=;
 b=SebnF1PktGsv7KYc26W1XANb0FtlWABmYo4ZAc4lvp4HjMqNyezxMeuvFM0AOYCYFLiSeM
 QIo+DuVwYfdJzbEsnf3JDwTY3wv+VsnX4vf6SICrQVvjyChoSDvoXCPjtgfz7xQBCXFMPu
 aLGQofRn+QiPHwCpJrJZuQXpks9X5IA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-mxEi8bk_NdOd1dTr10Dr7A-1; Wed, 03 Nov 2021 03:34:18 -0400
X-MC-Unique: mxEi8bk_NdOd1dTr10Dr7A-1
Received: by mail-lf1-f72.google.com with SMTP id
 i1-20020a056512340100b003fdd5b951e0so295302lfr.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2evzeN2dUJ97RkJYIYZWd1y4ZdCaTHeSbdPXFeoqPXY=;
 b=JhzxDc3RfS8Tqd816h3u58IwXfidWpmsWmMDud7/8zU7+mB/WYjo/3rOg1OGRDKfXs
 Gu0Bkk0ybsfip9svwUaQuacc5YcB31Vlfd5T8+gOz0DkQ8n79s3ZoKe+l5GNnDkUvLEW
 VJ2OMJLFXebLOnxlDyWO3yCLA2m9FXO/Sk08kuFhJmUh+yDFEWXjId4vswoqhhWLQgfi
 zLj0sdL83hnvE1W4x42KO4XWgAIpi3j1MJswEB760X4j/0CLnKqoJnazzNisy7XR3qY9
 MFzvVYvlc9EP6IKvujfoY95q6oNNB/1kG3rzzdu1Lry5J4ppN2YNFbq9jA21ZyNa/hwd
 gnUw==
X-Gm-Message-State: AOAM530diETHqLTlUk97oA8YV4MzaenPxE/dCDcW6XFhJGmFt627Hp3G
 Mz07f397DJ6Cv5WwddJ3D2HomLz/Lb7ranwvt8OOTqHuJMeS4bUPUeqbA0rT702w4UEvNUJra+V
 gG+rq8tPG2UeZNYTvbpSCiSLcSjNX2bfVNC22+aD5+RAB36T+cap5utbvow==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr44928336ljg.217.1635924856892; 
 Wed, 03 Nov 2021 00:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgumhOzJkMB3252KusefaLzXeoNl6AE+RgxHii73ou3HxIh+V3ny7+BZb0pyCgH7dvZNxuJB7iyjgLMLh5hNQ=
X-Received: by 2002:a2e:9155:: with SMTP id q21mr44928307ljg.217.1635924856684; 
 Wed, 03 Nov 2021 00:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-8-jasowang@redhat.com>
 <20211101141133.GA1073864@nvidia.com>
 <CACGkMEtbs3u7J7krpkusfqczTU00+6o_YtZjD8htC=+Un9cNew@mail.gmail.com>
 <20211102155611.GL2744544@nvidia.com>
In-Reply-To: <20211102155611.GL2744544@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Nov 2021 15:34:05 +0800
Message-ID: <CACGkMEt35cLjb-YRD34yhyo2oiK5YqVozsg5t45a0oThiAKS4A@mail.gmail.com>
Subject: Re: [PATCH V9 7/9] vhost: introduce vDPA-based backend
To: Jason Gunthorpe <jgg@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>, mhabets@solarflare.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 rob.miller@broadcom.com, Saugat Mitra <saugatm@xilinx.com>,
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Christoph Hellwig <hch@infradead.org>, eperezma <eperezma@redhat.com>,
 shahafs@mellanox.com, Parav Pandit <parav@mellanox.com>, vmireyno@marvell.com,
 Gautam Dawar <gdawar@xilinx.com>, jiri@mellanox.com,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 zhihong.wang@intel.com, zhangweining@ruijie.com.cn,
 Tiwei Bie <tiwei.bie@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, netdev <netdev@vger.kernel.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
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

On Tue, Nov 2, 2021 at 11:56 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Nov 02, 2021 at 11:52:20AM +0800, Jason Wang wrote:
> > On Mon, Nov 1, 2021 at 10:11 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Mar 26, 2020 at 10:01:23PM +0800, Jason Wang wrote:
> > > > From: Tiwei Bie <tiwei.bie@intel.com>
> > > >
> > > > This patch introduces a vDPA-based vhost backend. This backend is
> > > > built on top of the same interface defined in virtio-vDPA and provides
> > > > a generic vhost interface for userspace to accelerate the virtio
> > > > devices in guest.
> > > >
> > > > This backend is implemented as a vDPA device driver on top of the same
> > > > ops used in virtio-vDPA. It will create char device entry named
> > > > vhost-vdpa-$index for userspace to use. Userspace can use vhost ioctls
> > > > on top of this char device to setup the backend.
> > > >
> > > > Vhost ioctls are extended to make it type agnostic and behave like a
> > > > virtio device, this help to eliminate type specific API like what
> > > > vhost_net/scsi/vsock did:
> > > >
> > > > - VHOST_VDPA_GET_DEVICE_ID: get the virtio device ID which is defined
> > > >   by virtio specification to differ from different type of devices
> > > > - VHOST_VDPA_GET_VRING_NUM: get the maximum size of virtqueue
> > > >   supported by the vDPA device
> > > > - VHSOT_VDPA_SET/GET_STATUS: set and get virtio status of vDPA device
> > > > - VHOST_VDPA_SET/GET_CONFIG: access virtio config space
> > > > - VHOST_VDPA_SET_VRING_ENABLE: enable a specific virtqueue
> > > >
> > > > For memory mapping, IOTLB API is mandated for vhost-vDPA which means
> > > > userspace drivers are required to use
> > > > VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE to add or remove mapping for
> > > > a specific userspace memory region.
> > > >
> > > > The vhost-vDPA API is designed to be type agnostic, but it allows net
> > > > device only in current stage. Due to the lacking of control virtqueue
> > > > support, some features were filter out by vhost-vdpa.
> > > >
> > > > We will enable more features and devices in the near future.
> > >
> > > [..]
> > >
> > > > +static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > > > +{
> > > > +     struct vdpa_device *vdpa = v->vdpa;
> > > > +     const struct vdpa_config_ops *ops = vdpa->config;
> > > > +     struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> > > > +     struct bus_type *bus;
> > > > +     int ret;
> > > > +
> > > > +     /* Device want to do DMA by itself */
> > > > +     if (ops->set_map || ops->dma_map)
> > > > +             return 0;
> > > > +
> > > > +     bus = dma_dev->bus;
> > > > +     if (!bus)
> > > > +             return -EFAULT;
> > > > +
> > > > +     if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> > > > +             return -ENOTSUPP;
> > > > +
> > > > +     v->domain = iommu_domain_alloc(bus);
> > > > +     if (!v->domain)
> > > > +             return -EIO;
> > > > +
> > > > +     ret = iommu_attach_device(v->domain, dma_dev);
> > > > +     if (ret)
> > > > +             goto err_attach;
> > > >
> > >
> > > I've been looking at the security of iommu_attach_device() users, and
> > > I wonder if this is safe?
> > >
> > > The security question is if userspace is able to control the DMA
> > > address the devices uses? Eg if any of the cpu to device ring's are in
> > > userspace memory?
> > >
> > > For instance if userspace can tell the device to send a packet from an
> > > arbitrary user controlled address.
> >
> > The map is validated via pin_user_pages() which guarantees that the
> > address is not arbitrary and must belong to userspace?
>
> That controls what gets put into the IOMMU, it doesn't restrict what
> DMA the device itself can issue.
>
> Upon investigating more it seems the answer is that
> iommu_attach_device() requires devices to be in singleton groups, so
> there is no leakage from rouge DMA

Yes, I think so.

Thanks

>
> Jason
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
