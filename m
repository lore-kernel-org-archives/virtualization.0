Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98939C43217
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D53760EBC
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D53760EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0723C80CFB;
	Tue,  2 Nov 2021 03:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1NF44ByJFet; Tue,  2 Nov 2021 03:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 842D980CF9;
	Tue,  2 Nov 2021 03:52:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 546A3C0012;
	Tue,  2 Nov 2021 03:52:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5DA8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A000240112
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SsEvHT6N-xcH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:52:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73064400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635825154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5JQX7PK3bUB+fO7KCHuTs96kpHZCzUz5hWvhokA8Wo=;
 b=RghOEjDL4afjnzXeL55cWpEv8TQnj+im4Xg6YL8Q9UZ8b7ywZC6RWYaVmoejXVlsUTxjML
 n7dqZkUimmxIM9cufFuSp3odoS4C/14M80PXhaH24MEFexRj+cJBoCu02k9Iibw0XbVwGL
 CZ0oKhiyg3N6AG4OyLVFjVRr3NKzuCU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-0YrvUnqRMfGFbC5zgzl72w-1; Mon, 01 Nov 2021 23:52:33 -0400
X-MC-Unique: 0YrvUnqRMfGFbC5zgzl72w-1
Received: by mail-lj1-f199.google.com with SMTP id
 s17-20020a2e2c11000000b002119b8e1336so7087068ljs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 20:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l5JQX7PK3bUB+fO7KCHuTs96kpHZCzUz5hWvhokA8Wo=;
 b=qBffbwxO19K2iydVX/nfRpJyQ0kYKL1/WFLpBBzexf7IOgIBf3OoslXvZ0NDwDnEjV
 bpa3tbsAfOxK+NNaY8oLyvmSAMVQsJMKxE5ri6VRLy5OMMnkGQKruW8IirOuv1boJpLY
 X2ayh0jPWSbDMxD8IXYIqMeYy2Jmn1srOCaBsdIONddNJDEOPDo7eznkiAo7PTYf1vFG
 VlxXa5Wp/pldAm4l3u/mkBzE4t0IxEqY9BlYHFbCFt1C3IiVP88k3TgwD3eQ6I4VoOlK
 kRZFoxWfWSqx10nD4tIvkL2MIl5Atnq693zrT9XTlvYKkyBGCErTm2Or12ka0ZgbVZKp
 u13Q==
X-Gm-Message-State: AOAM5327vpif1fJlfwm+hy99FllDWnBwvIMFIX3Fq1NtTHuGzDa8PGxp
 ZRPfj9plw7qSkWVxjMQ0U0bOtGLgBNlGM8tRszX3aW/r9NDfQlVr4G90DNuiWcbwaM0ItKAkcH8
 crasgLOQ0f5tDgk56wK61rSa/uRhceeTn2QdNpmMn5BTJW+bvIjoYod9iSw==
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr34920381ljp.307.1635825151461; 
 Mon, 01 Nov 2021 20:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFQk+sE0CmE+gyBZ9tANj3V6182Ct3x1qzy7cGmMP3hS/SewKac2u33kWWjZYVFWZ9SvqxSnBV3r7bPJN+SIk=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr34920347ljp.307.1635825151261; 
 Mon, 01 Nov 2021 20:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-8-jasowang@redhat.com>
 <20211101141133.GA1073864@nvidia.com>
In-Reply-To: <20211101141133.GA1073864@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Nov 2021 11:52:20 +0800
Message-ID: <CACGkMEtbs3u7J7krpkusfqczTU00+6o_YtZjD8htC=+Un9cNew@mail.gmail.com>
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

On Mon, Nov 1, 2021 at 10:11 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 26, 2020 at 10:01:23PM +0800, Jason Wang wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
> >
> > This patch introduces a vDPA-based vhost backend. This backend is
> > built on top of the same interface defined in virtio-vDPA and provides
> > a generic vhost interface for userspace to accelerate the virtio
> > devices in guest.
> >
> > This backend is implemented as a vDPA device driver on top of the same
> > ops used in virtio-vDPA. It will create char device entry named
> > vhost-vdpa-$index for userspace to use. Userspace can use vhost ioctls
> > on top of this char device to setup the backend.
> >
> > Vhost ioctls are extended to make it type agnostic and behave like a
> > virtio device, this help to eliminate type specific API like what
> > vhost_net/scsi/vsock did:
> >
> > - VHOST_VDPA_GET_DEVICE_ID: get the virtio device ID which is defined
> >   by virtio specification to differ from different type of devices
> > - VHOST_VDPA_GET_VRING_NUM: get the maximum size of virtqueue
> >   supported by the vDPA device
> > - VHSOT_VDPA_SET/GET_STATUS: set and get virtio status of vDPA device
> > - VHOST_VDPA_SET/GET_CONFIG: access virtio config space
> > - VHOST_VDPA_SET_VRING_ENABLE: enable a specific virtqueue
> >
> > For memory mapping, IOTLB API is mandated for vhost-vDPA which means
> > userspace drivers are required to use
> > VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE to add or remove mapping for
> > a specific userspace memory region.
> >
> > The vhost-vDPA API is designed to be type agnostic, but it allows net
> > device only in current stage. Due to the lacking of control virtqueue
> > support, some features were filter out by vhost-vdpa.
> >
> > We will enable more features and devices in the near future.
>
> [..]
>
> > +static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> > +{
> > +     struct vdpa_device *vdpa = v->vdpa;
> > +     const struct vdpa_config_ops *ops = vdpa->config;
> > +     struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> > +     struct bus_type *bus;
> > +     int ret;
> > +
> > +     /* Device want to do DMA by itself */
> > +     if (ops->set_map || ops->dma_map)
> > +             return 0;
> > +
> > +     bus = dma_dev->bus;
> > +     if (!bus)
> > +             return -EFAULT;
> > +
> > +     if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> > +             return -ENOTSUPP;
> > +
> > +     v->domain = iommu_domain_alloc(bus);
> > +     if (!v->domain)
> > +             return -EIO;
> > +
> > +     ret = iommu_attach_device(v->domain, dma_dev);
> > +     if (ret)
> > +             goto err_attach;
> >
>
> I've been looking at the security of iommu_attach_device() users, and
> I wonder if this is safe?
>
> The security question is if userspace is able to control the DMA
> address the devices uses? Eg if any of the cpu to device ring's are in
> userspace memory?
>
> For instance if userspace can tell the device to send a packet from an
> arbitrary user controlled address.

The map is validated via pin_user_pages() which guarantees that the
address is not arbitrary and must belong to userspace?

Thanks

>
> Thanks,
> Jason
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
