Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF2FC433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 07:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9404160F31;
	Mon,  9 May 2022 07:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RcfbXK_ekooG; Mon,  9 May 2022 07:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFE1860AFF;
	Mon,  9 May 2022 07:07:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1361C0032;
	Mon,  9 May 2022 07:07:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC35C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 07:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96C264023F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 07:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hH8wj6LnxMMz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 07:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0677440203
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652080049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJB9Em6I7OuLyYTTBEaXQS40dd84xL6H6gQSfOQOSK4=;
 b=GRWs4DQhY6XpTeJ7ZW1bxIl80mIb0FxZhyKyGvDQXNyNwE5UkCfSdfamx09eAPqsKmgELt
 WyHuzD1QMBU/xnXDiPhxLSofk9ZVvvfi6Z+yc3+elG7wBRRx/M+1MMue0ArkBvd7coIezP
 cfjQj9hXNBtL4p6ZfrYuWJFAlKA50U8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-ZJFC34ZhONiAJSWKCwETPA-1; Mon, 09 May 2022 03:07:27 -0400
X-MC-Unique: ZJFC34ZhONiAJSWKCwETPA-1
Received: by mail-wr1-f72.google.com with SMTP id
 t17-20020adfa2d1000000b0020ac519c222so5378558wra.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 00:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XJB9Em6I7OuLyYTTBEaXQS40dd84xL6H6gQSfOQOSK4=;
 b=AYRhU3Owxzc3tYSwDVpHSLOTij4VQH8YzccjAoC0TD+xKCv/9DzXw/fNyxHHmaJaGD
 sBFci3YUjYWcZ/ql/B7NVyM8xCcxCW3R+gv03gP6Mgn7bVl6JlQiGEdx85guIlpmPLOV
 bNiDcLWu+dZEV7bmAXWVyaCjyikMKNMZz6f0rZ6pn2RlOJZedEKWH5fjOx7gp1xaIvkD
 3+akAU4cGThuv23bJmFLn4Sn6R/J5ZBfoX/lYvy8UOTv8zGUFP46Gf3L5eGmp8FYXqJP
 vIw5I6WLryQujDtgAz2XMZU7+0BosgfIW2PVGjsMKu2w/DeUJVITdiF6mWJZBE4+5ycn
 zE1Q==
X-Gm-Message-State: AOAM5301dA/9V7CyeyGwv1KrnKwVNqbqDc+ur/tio5YbgAAJOCTFEcIV
 X7sRH29s9pKq4D1scGZlBG06gOS7XjwfPoOb/ZYuh2LEdPKSMSDkg6aX08hE7FG7FTea7at67TQ
 n7ZAK9RBfQx5fiWrNm8VcPhYBf/HNug9RKItFF5HVMg==
X-Received: by 2002:a7b:cf04:0:b0:394:27c8:d28a with SMTP id
 l4-20020a7bcf04000000b0039427c8d28amr20487773wmg.94.1652080046257; 
 Mon, 09 May 2022 00:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCyHCGQCbWEwWZ/UHI0DnttZzMiYsb/44YfiPVnJDRlGYZi1SIGptJp+PDbsNZyHEwx15Iog==
X-Received: by 2002:a7b:cf04:0:b0:394:27c8:d28a with SMTP id
 l4-20020a7bcf04000000b0039427c8d28amr20487743wmg.94.1652080045958; 
 Mon, 09 May 2022 00:07:25 -0700 (PDT)
Received: from redhat.com ([2.53.130.81]) by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c1d0600b003942a244f34sm15441415wms.13.2022.05.09.00.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 00:07:24 -0700 (PDT)
Date: Mon, 9 May 2022 03:07:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 00/19] Control VQ support in vDPA
Message-ID: <20220509030656-mutt-send-email-mst@kernel.org>
References: <20220330180436.24644-1-gdawar@xilinx.com>
 <CACGkMEsPTui8XDLvvLCq4myx1gWh=W1=W_9tXe+Lps5ExdE4+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsPTui8XDLvvLCq4myx1gWh=W1=W_9tXe+Lps5ExdE4+g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, May 09, 2022 at 11:42:10AM +0800, Jason Wang wrote:
> On Thu, Mar 31, 2022 at 2:05 AM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
> >
> > Hi All:
> >
> > This series tries to add the support for control virtqueue in vDPA.
> >
> > Control virtqueue is used by networking device for accepting various
> > commands from the driver. It's a must to support multiqueue and other
> > configurations.
> >
> > When used by vhost-vDPA bus driver for VM, the control virtqueue
> > should be shadowed via userspace VMM (Qemu) instead of being assigned
> > directly to Guest. This is because Qemu needs to know the device state
> > in order to start and stop device correctly (e.g for Live Migration).
> >
> > This requies to isolate the memory mapping for control virtqueue
> > presented by vhost-vDPA to prevent guest from accessing it directly.
> >
> > To achieve this, vDPA introduce two new abstractions:
> >
> > - address space: identified through address space id (ASID) and a set
> >                  of memory mapping in maintained
> > - virtqueue group: the minimal set of virtqueues that must share an
> >                  address space
> >
> > Device needs to advertise the following attributes to vDPA:
> >
> > - the number of address spaces supported in the device
> > - the number of virtqueue groups supported in the device
> > - the mappings from a specific virtqueue to its virtqueue groups
> >
> > The mappings from virtqueue to virtqueue groups is fixed and defined
> > by vDPA device driver. E.g:
> >
> > - For the device that has hardware ASID support, it can simply
> >   advertise a per virtqueue group.
> > - For the device that does not have hardware ASID support, it can
> >   simply advertise a single virtqueue group that contains all
> >   virtqueues. Or if it wants a software emulated control virtqueue, it
> >   can advertise two virtqueue groups, one is for cvq, another is for
> >   the rest virtqueues.
> >
> > vDPA also allow to change the association between virtqueue group and
> > address space. So in the case of control virtqueue, userspace
> > VMM(Qemu) may use a dedicated address space for the control virtqueue
> > group to isolate the memory mapping.
> >
> > The vhost/vhost-vDPA is also extend for the userspace to:
> >
> > - query the number of virtqueue groups and address spaces supported by
> >   the device
> > - query the virtqueue group for a specific virtqueue
> > - assocaite a virtqueue group with an address space
> > - send ASID based IOTLB commands
> >
> > This will help userspace VMM(Qemu) to detect whether the control vq
> > could be supported and isolate memory mappings of control virtqueue
> > from the others.
> >
> > To demonstrate the usage, vDPA simulator is extended to support
> > setting MAC address via a emulated control virtqueue.
> >
> > Please review.
> 
> Michael, this looks good to me, do you have comments on this?
> 
> Thanks


I'll merge this for next.

> >
> > Changes since RFC v2:
> >
> > - Fixed memory leak for asid 0 in vhost_vdpa_remove_as()
> > - Removed unnecessary NULL check for iotlb in vhost_vdpa_unmap() and
> >   changed its return type to void.
> > - Removed insignificant used_as member field from struct vhost_vdpa.
> > - Corrected the iommu parameter in call to vringh_set_iotlb() from
> >   vdpasim_set_group_asid()
> > - Fixed build errors with vdpa_sim_net
> > - Updated alibaba, vdpa_user and virtio_pci vdpa parent drivers to
> >   call updated vDPA APIs and ensured successful build
> > - Tested control (MAC address configuration) and data-path using
> >   single virtqueue pair on Xilinx (now AMD) SN1022 SmartNIC device
> >   and vdpa_sim_net software device using QEMU release at [1]
> > - Removed two extra blank lines after set_group_asid() in
> >   include/linux/vdpa.h
> >
> > Changes since v1:
> >
> > - Rebased the v1 patch series on vhost branch of MST vhost git repo
> >   git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=vhost
> > - Updates to accommodate vdpa_sim changes from monolithic module in
> >   kernel used v1 patch series to current modularized class (net, block)
> >   based approach.
> > - Added new attributes (ngroups and nas) to "vdpasim_dev_attr" and
> >   propagated them from vdpa_sim_net to vdpa_sim
> > - Widened the data-type for "asid" member of vhost_msg_v2 to __u32
> >   to accommodate PASID
> > - Fixed the buildbot warnings
> > - Resolved all checkpatch.pl errors and warnings
> > - Tested both control and datapath with Xilinx Smartnic SN1000 series
> >   device using QEMU implementing the Shadow virtqueue and support for
> >   VQ groups and ASID available at [1]
> >
> > Changes since RFC:
> >
> > - tweak vhost uAPI documentation
> > - switch to use device specific IOTLB really in patch 4
> > - tweak the commit log
> > - fix that ASID in vhost is claimed to be 32 actually but 16bit
> >   actually
> > - fix use after free when using ASID with IOTLB batching requests
> > - switch to use Stefano's patch for having separated iov
> > - remove unused "used_as" variable
> > - fix the iotlb/asid checking in vhost_vdpa_unmap()
> >
> > [1] Development QEMU release with support for SVQ, VQ groups and ASID:
> >   github.com/eugpermar/qemu/releases/tag/vdpa_sw_live_migration.d%2F
> >   asid_groups-v1.d%2F00
> >
> > Thanks
> >
> > Gautam Dawar (19):
> >   vhost: move the backend feature bits to vhost_types.h
> >   virtio-vdpa: don't set callback if virtio doesn't need it
> >   vhost-vdpa: passing iotlb to IOMMU mapping helpers
> >   vhost-vdpa: switch to use vhost-vdpa specific IOTLB
> >   vdpa: introduce virtqueue groups
> >   vdpa: multiple address spaces support
> >   vdpa: introduce config operations for associating ASID to a virtqueue
> >     group
> >   vhost_iotlb: split out IOTLB initialization
> >   vhost: support ASID in IOTLB API
> >   vhost-vdpa: introduce asid based IOTLB
> >   vhost-vdpa: introduce uAPI to get the number of virtqueue groups
> >   vhost-vdpa: introduce uAPI to get the number of address spaces
> >   vhost-vdpa: uAPI to get virtqueue group id
> >   vhost-vdpa: introduce uAPI to set group ASID
> >   vhost-vdpa: support ASID based IOTLB API
> >   vdpa_sim: advertise VIRTIO_NET_F_MTU
> >   vdpa_sim: factor out buffer completion logic
> >   vdpa_sim: filter destination mac address
> >   vdpasim: control virtqueue support
> >
> >  drivers/vdpa/alibaba/eni_vdpa.c      |   2 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c      |   8 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  11 +-
> >  drivers/vdpa/vdpa.c                  |   5 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 100 ++++++++--
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h     |   3 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 169 +++++++++++++----
> >  drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
> >  drivers/vdpa/virtio_pci/vp_vdpa.c    |   2 +-
> >  drivers/vhost/iotlb.c                |  23 ++-
> >  drivers/vhost/vdpa.c                 | 267 +++++++++++++++++++++------
> >  drivers/vhost/vhost.c                |  23 ++-
> >  drivers/vhost/vhost.h                |   4 +-
> >  drivers/virtio/virtio_vdpa.c         |   2 +-
> >  include/linux/vdpa.h                 |  44 ++++-
> >  include/linux/vhost_iotlb.h          |   2 +
> >  include/uapi/linux/vhost.h           |  26 ++-
> >  include/uapi/linux/vhost_types.h     |  11 +-
> >  18 files changed, 563 insertions(+), 142 deletions(-)
> >
> > --
> > 2.30.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
