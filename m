Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CDC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:47:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26C423105
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26C423105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5200786904;
	Wed, 16 Dec 2020 09:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaBlnreJG-fM; Wed, 16 Dec 2020 09:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79203856C8;
	Wed, 16 Dec 2020 09:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45CD1C0893;
	Wed, 16 Dec 2020 09:47:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B34C7C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97D4586891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcktRCZUxTZJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:47:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8C56866A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608112072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OnpaGqF6fBlhxGH2HmymIgB4u9qh1ujRtHG8EyWDWNA=;
 b=S37JJaeN+tRTM5rwkgZRcuMNgV1z6SAGGXudiIYKPkJxOhu/nSVVNc3ErBSTi5BKH8ZMxI
 9WRjqDx+QsZy42oWKrlbj56e9k6Aun3Jc0TcA/TgNcnhPK62BHJGgbxAj1eezFwaVkWs/7
 sLi/+SrwMhx8z5IgX2VMXetBSwzgG/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-uoXBgbX_PEKCyahJRAbBAA-1; Wed, 16 Dec 2020 04:47:50 -0500
X-MC-Unique: uoXBgbX_PEKCyahJRAbBAA-1
Received: by mail-wm1-f72.google.com with SMTP id g198so553237wme.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 01:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OnpaGqF6fBlhxGH2HmymIgB4u9qh1ujRtHG8EyWDWNA=;
 b=cMM/1E4kwVEuT6iDya3iXOnkUijQW3ppkpiKwhv1cVMCTqCAa43jqNFs5dXg97AyKp
 YzLH4yI+UJZPEaBjmSlLsvyMQTjp7LPf61dC4tCxYU/+HAK4A1Zl3k6QPy8VYnk650lt
 Ey4Z1ESUj91lY6j4ZT/Gyn9zrv7Z2E8RK0M0AdG+8OJfACxp9sZ/YvwmWbYVSKLvctqB
 Cu6pu7k6yPHTeBbc9Fn1ZCriv8ObxpcuSB833eKVJYFlzctX1bCqLUyxZl0sCA4Rx/Jl
 YrILeZZCHTDpAjdnYXWI0R5q4MFFtfnsxraiua29X0WtADQKbnDeE83yZqBRhZmSZiSc
 dt7Q==
X-Gm-Message-State: AOAM533wviqCMdSLD7N0+5kwsp23tpCUTKDgg5KRzFidYrof69rlbIc6
 7csDd2aBvide4cvRlWfrDgrJyxab17PrbhaLRgxuf/EnzVBGc9I3biH06xZxmklPXWV48iPqFKQ
 aCAVdDWS37h3NhB1eUN2BOdw9/RoF6W2Ou8LqCuamqw==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr37436427wri.195.1608112069509; 
 Wed, 16 Dec 2020 01:47:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfV1vXW29xJdPdujDOdRLOpVukt+skk2qfzG8oqvVv1VkOHFftPxLfa9EpZYgdf+afl0EleA==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr37436406wri.195.1608112069274; 
 Wed, 16 Dec 2020 01:47:49 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id l5sm2422805wrv.44.2020.12.16.01.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 01:47:48 -0800 (PST)
Date: Wed, 16 Dec 2020 04:47:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 00/21] Control VQ support in vDPA
Message-ID: <20201216044051-mutt-send-email-mst@kernel.org>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Wed, Dec 16, 2020 at 02:47:57PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series tries to add the support for control virtqueue in vDPA.
> 
> Control virtqueue is used by networking device for accepting various
> commands from the driver. It's a must to support multiqueue and other
> configurations.
> 
> When used by vhost-vDPA bus driver for VM, the control virtqueue
> should be shadowed via userspace VMM (Qemu) instead of being assigned
> directly to Guest. This is because Qemu needs to know the device state
> in order to start and stop device correctly (e.g for Live Migration).
> 
> This requies to isolate the memory mapping for control virtqueue
> presented by vhost-vDPA to prevent guest from accesing it directly.
> To achieve this, vDPA introduce two new abstractions:
> 
> - address space: identified through address space id (ASID) and a set
>                  of memory mapping in maintained
> - virtqueue group: the minimal set of virtqueues that must share an
>                  address space

How will this support the pretty common case where control vq
is programmed by the kernel through the PF, and others by the VFs?


I actually thought the way to support it is by exposing
something like an "inject buffers" API which sends data to a given VQ.
Maybe an ioctl, and maybe down the road uio ring can support batching
these ....


> 
> Device needs to advertise the following attributes to vDPA:
> 
> - the number of address spaces supported in the device
> - the number of virtqueue groups supported in the device
> - the mappings from a specific virtqueue to its virtqueue groups
> 
> The mappings from virtqueue to virtqueue groups is fixed and defined
> by vDPA device driver. E.g:
> 
> - For the device that has hardware ASID support, it can simply
>   advertise a per virtqueue virtqueue group.
> - For the device that does not have hardware ASID support, it can
>   simply advertise a single virtqueue group that contains all
>   virtqueues. Or if it wants a software emulated control virtqueue, it
>   can advertise two virtqueue groups, one is for cvq, another is for
>   the rest virtqueues.
> 
> vDPA also allow to change the association between virtqueue group and
> address space. So in the case of control virtqueue, userspace
> VMM(Qemu) may use a dedicated address space for the control virtqueue
> group to isolate the memory mapping.
> 
> The vhost/vhost-vDPA is also extend for the userspace to:
> 
> - query the number of virtqueue groups and address spaces supported by
>   the device
> - query the virtqueue group for a specific virtqueue
> - assocaite a virtqueue group with an address space
> - send ASID based IOTLB commands
> 
> This will help userspace VMM(Qemu) to detect whether the control vq
> could be supported and isolate memory mappings of control virtqueue
> from the others.
> 
> To demonstrate the usage, vDPA simulator is extended to support
> setting MAC address via a emulated control virtqueue.
> 
> Please review.
> 
> Changes since RFC:
> 
> - tweak vhost uAPI documentation
> - switch to use device specific IOTLB really in patch 4
> - tweak the commit log
> - fix that ASID in vhost is claimed to be 32 actually but 16bit
>   actually
> - fix use after free when using ASID with IOTLB batching requests
> - switch to use Stefano's patch for having separated iov
> - remove unused "used_as" variable
> - fix the iotlb/asid checking in vhost_vdpa_unmap()
> 
> Thanks
> 
> Jason Wang (20):
>   vhost: move the backend feature bits to vhost_types.h
>   virtio-vdpa: don't set callback if virtio doesn't need it
>   vhost-vdpa: passing iotlb to IOMMU mapping helpers
>   vhost-vdpa: switch to use vhost-vdpa specific IOTLB
>   vdpa: add the missing comment for nvqs in struct vdpa_device
>   vdpa: introduce virtqueue groups
>   vdpa: multiple address spaces support
>   vdpa: introduce config operations for associating ASID to a virtqueue
>     group
>   vhost_iotlb: split out IOTLB initialization
>   vhost: support ASID in IOTLB API
>   vhost-vdpa: introduce asid based IOTLB
>   vhost-vdpa: introduce uAPI to get the number of virtqueue groups
>   vhost-vdpa: introduce uAPI to get the number of address spaces
>   vhost-vdpa: uAPI to get virtqueue group id
>   vhost-vdpa: introduce uAPI to set group ASID
>   vhost-vdpa: support ASID based IOTLB API
>   vdpa_sim: advertise VIRTIO_NET_F_MTU
>   vdpa_sim: factor out buffer completion logic
>   vdpa_sim: filter destination mac address
>   vdpasim: control virtqueue support
> 
> Stefano Garzarella (1):
>   vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov
> 
>  drivers/vdpa/ifcvf/ifcvf_main.c   |   9 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +-
>  drivers/vdpa/vdpa.c               |   8 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 292 ++++++++++++++++++++++++------
>  drivers/vhost/iotlb.c             |  23 ++-
>  drivers/vhost/vdpa.c              | 246 ++++++++++++++++++++-----
>  drivers/vhost/vhost.c             |  23 ++-
>  drivers/vhost/vhost.h             |   4 +-
>  drivers/virtio/virtio_vdpa.c      |   2 +-
>  include/linux/vdpa.h              |  42 ++++-
>  include/linux/vhost_iotlb.h       |   2 +
>  include/uapi/linux/vhost.h        |  25 ++-
>  include/uapi/linux/vhost_types.h  |  10 +-
>  13 files changed, 561 insertions(+), 136 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
