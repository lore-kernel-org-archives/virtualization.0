Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448D6C433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 03:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6203404CF;
	Mon,  9 May 2022 03:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdKZj3T57gKE; Mon,  9 May 2022 03:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5073640425;
	Mon,  9 May 2022 03:42:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 223CFC0039;
	Mon,  9 May 2022 03:42:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A87A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 03:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96FA881450
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 03:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCVwuDGoXweM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 03:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83AB881448
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 03:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652067744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G97dy4AVAE1GL5QBc/XNOK50cRVojaBVv4PlJyXXKIE=;
 b=SXxlbCqZnXaxaCGwkd+Smz/boD28pwtP5dgiU7lHsoKWZJIt5IsIWzWtn8lInS3lT3gn+G
 +JmQuNBg4bLvLFp370jEH35WutwAAJugqUULhPSOlvKSjgDfWMYs1wAPRSYcuctJ6lfSQV
 g47CKWDNpKzcCGTkBM6Ypky8DEnx6GA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-kmHldKMwMgqak3Do2Lu7iw-1; Sun, 08 May 2022 23:42:23 -0400
X-MC-Unique: kmHldKMwMgqak3Do2Lu7iw-1
Received: by mail-lj1-f198.google.com with SMTP id
 l16-20020a2e5710000000b0024f0c34eff1so3760650ljb.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 May 2022 20:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G97dy4AVAE1GL5QBc/XNOK50cRVojaBVv4PlJyXXKIE=;
 b=2T3DqrSnEJQTlz2rbP+fwVSyTsqu5muNtGhia/DP4kWDxpYdJyDvqlCyJECaaLP391
 arUdWKdIxvPzJW0rFCaASqQUOeZaX7Kp5/Ev1vep13kid4ruLvCShCcxzsj5l+d8Hf4L
 FrOu+VlRgGxtOJK3ZwQFHydORpMh+DPAq48DFCpxZILklF2k9JDtFx3QK9nikdO7IOfc
 8gsFT1VdV9CfXLAemrcLPXNHb5QMgPXsZrM+MBrroqykie76FkZaaq1BTXR01eObZZLG
 ZzCIAtx7m9By/+ZQ2IG6F9fWRbJb60FqhKR/3UnkKuNRebHmFYcD/KWTZ/X8Hr1dZljB
 ISIA==
X-Gm-Message-State: AOAM53228WBHRSMdkXaoXVutR9S2kOT+jqxCFOvhyK02vEok6V+cVtKX
 Swywy21tP4QgpQIb1brFIA4/VaVfrvwuvz4jc8bWo7HjfFLwfN7yMzVDGGq8egDZbrx9tlF83Qg
 8iipM6MAobCuTqdSyj2GOrYMt9TKT+9W2Q5cQRVCu26TRYRBMsjQ61PJ+jA==
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr9454711ljq.315.1652067741604; 
 Sun, 08 May 2022 20:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7GEcbSzWYNIjk9OQXsjM2c6stURHMd0ugWDlSfjCzX8HLToBBvCauutlmv9zmgZvEr/HPg4d/o9AZUH75zT4=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr9454689ljq.315.1652067741377; Sun, 08 May
 2022 20:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220330180436.24644-1-gdawar@xilinx.com>
In-Reply-To: <20220330180436.24644-1-gdawar@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 May 2022 11:42:10 +0800
Message-ID: <CACGkMEsPTui8XDLvvLCq4myx1gWh=W1=W_9tXe+Lps5ExdE4+g@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Control VQ support in vDPA
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: tanuj.kamde@amd.com, kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Xie Yongji <xieyongji@bytedance.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 eperezma <eperezma@redhat.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Gautam Dawar <gdawar@xilinx.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Gautam Dawar <gautam.dawar@xilinx.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, Martin Porter <martinpo@xilinx.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Mar 31, 2022 at 2:05 AM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
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
> presented by vhost-vDPA to prevent guest from accessing it directly.
>
> To achieve this, vDPA introduce two new abstractions:
>
> - address space: identified through address space id (ASID) and a set
>                  of memory mapping in maintained
> - virtqueue group: the minimal set of virtqueues that must share an
>                  address space
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
>   advertise a per virtqueue group.
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

Michael, this looks good to me, do you have comments on this?

Thanks

>
> Changes since RFC v2:
>
> - Fixed memory leak for asid 0 in vhost_vdpa_remove_as()
> - Removed unnecessary NULL check for iotlb in vhost_vdpa_unmap() and
>   changed its return type to void.
> - Removed insignificant used_as member field from struct vhost_vdpa.
> - Corrected the iommu parameter in call to vringh_set_iotlb() from
>   vdpasim_set_group_asid()
> - Fixed build errors with vdpa_sim_net
> - Updated alibaba, vdpa_user and virtio_pci vdpa parent drivers to
>   call updated vDPA APIs and ensured successful build
> - Tested control (MAC address configuration) and data-path using
>   single virtqueue pair on Xilinx (now AMD) SN1022 SmartNIC device
>   and vdpa_sim_net software device using QEMU release at [1]
> - Removed two extra blank lines after set_group_asid() in
>   include/linux/vdpa.h
>
> Changes since v1:
>
> - Rebased the v1 patch series on vhost branch of MST vhost git repo
>   git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=vhost
> - Updates to accommodate vdpa_sim changes from monolithic module in
>   kernel used v1 patch series to current modularized class (net, block)
>   based approach.
> - Added new attributes (ngroups and nas) to "vdpasim_dev_attr" and
>   propagated them from vdpa_sim_net to vdpa_sim
> - Widened the data-type for "asid" member of vhost_msg_v2 to __u32
>   to accommodate PASID
> - Fixed the buildbot warnings
> - Resolved all checkpatch.pl errors and warnings
> - Tested both control and datapath with Xilinx Smartnic SN1000 series
>   device using QEMU implementing the Shadow virtqueue and support for
>   VQ groups and ASID available at [1]
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
> [1] Development QEMU release with support for SVQ, VQ groups and ASID:
>   github.com/eugpermar/qemu/releases/tag/vdpa_sw_live_migration.d%2F
>   asid_groups-v1.d%2F00
>
> Thanks
>
> Gautam Dawar (19):
>   vhost: move the backend feature bits to vhost_types.h
>   virtio-vdpa: don't set callback if virtio doesn't need it
>   vhost-vdpa: passing iotlb to IOMMU mapping helpers
>   vhost-vdpa: switch to use vhost-vdpa specific IOTLB
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
>  drivers/vdpa/alibaba/eni_vdpa.c      |   2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c      |   8 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  11 +-
>  drivers/vdpa/vdpa.c                  |   5 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 100 ++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |   3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 169 +++++++++++++----
>  drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |   2 +-
>  drivers/vhost/iotlb.c                |  23 ++-
>  drivers/vhost/vdpa.c                 | 267 +++++++++++++++++++++------
>  drivers/vhost/vhost.c                |  23 ++-
>  drivers/vhost/vhost.h                |   4 +-
>  drivers/virtio/virtio_vdpa.c         |   2 +-
>  include/linux/vdpa.h                 |  44 ++++-
>  include/linux/vhost_iotlb.h          |   2 +
>  include/uapi/linux/vhost.h           |  26 ++-
>  include/uapi/linux/vhost_types.h     |  11 +-
>  18 files changed, 563 insertions(+), 142 deletions(-)
>
> --
> 2.30.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
