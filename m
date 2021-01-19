Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39BFC433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 18:49:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB902312B
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB902312B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B9DE84B80;
	Tue, 19 Jan 2021 17:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDaaTKeXbClm; Tue, 19 Jan 2021 17:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A0CCE8456F;
	Tue, 19 Jan 2021 17:54:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 854E1C088B;
	Tue, 19 Jan 2021 17:54:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3834BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 17:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1B4332043E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 17:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qm7LgP84bMqG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 17:54:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 46614203BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=bem/4M8L62Jn47zv1wRCWw9J4rfbubNfeTQT1T3mqyg=; b=QvmCgohUW026YsJwX313hXd8Jr
 x7vvDHWSJjtQLA3V95OFuAyAYNMBfNbcNaSYAKsknQTQydAjdn9htC3xIaF8QXf/eofbkuUOPRnEe
 9gaJ698oMxw9WSiPyC9FaQKsnBQkMdkdFUEGtUGcdCCgUeuB+x7QAZHtFU4Mx2o5+R9dy4TGDVxkT
 owoSf4FZa6ieBgfyMW9q18FJRdhQ+3B74KHEFf7Xck3H+YIPUunSzUYHizgHW75sb+VGBYjjBLbV9
 aqrNQm6Ehz6PWM3dKR4J/ILgyzls/a2xwA/tSrS5Kz/efsuUuit8GnM+NvDDsSFNxUiaQrW3thId0
 QE0ymqEg==;
Received: from [2601:1c0:6280:3f0::9abc]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1vCd-00029A-NS; Tue, 19 Jan 2021 17:54:04 +0000
Subject: Re: [RFC v3 08/11] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 parav@nvidia.com, bob.liu@oracle.com, hch@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-2-xieyongji@bytedance.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cfdc418c-7559-c6b1-6d8d-8f3a91a24f2b@infradead.org>
Date: Tue, 19 Jan 2021 09:53:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210119050756.600-2-xieyongji@bytedance.com>
Content-Language: en-US
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Hi,

Documentation comments only:

On 1/18/21 9:07 PM, Xie Yongji wrote:
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  Documentation/driver-api/vduse.rst                 |   85 ++
> 
> diff --git a/Documentation/driver-api/vduse.rst b/Documentation/driver-api/vduse.rst
> new file mode 100644
> index 000000000000..9418a7f6646b
> --- /dev/null
> +++ b/Documentation/driver-api/vduse.rst
> @@ -0,0 +1,85 @@
> +==================================
> +VDUSE - "vDPA Device in Userspace"
> +==================================
> +
> +vDPA (virtio data path acceleration) device is a device that uses a
> +datapath which complies with the virtio specifications with vendor
> +specific control path. vDPA devices can be both physically located on
> +the hardware or emulated by software. VDUSE is a framework that makes it
> +possible to implement software-emulated vDPA devices in userspace.
> +
> +How VDUSE works
> +------------
> +Each userspace vDPA device is created by the VDUSE_CREATE_DEV ioctl on
> +the VDUSE character device (/dev/vduse). Then a file descriptor pointing
> +to the new resources will be returned, which can be used to implement the
> +userspace vDPA device's control path and data path.
> +
> +To implement control path, the read/write operations to the file descriptor
> +will be used to receive/reply the control messages from/to VDUSE driver.
> +Those control messages are mostly based on the vdpa_config_ops which defines
> +a unified interface to control different types of vDPA device.
> +
> +The following types of messages are provided by the VDUSE framework now:
> +
> +- VDUSE_SET_VQ_ADDR: Set the addresses of the different aspects of virtqueue.
> +
> +- VDUSE_SET_VQ_NUM: Set the size of virtqueue
> +
> +- VDUSE_SET_VQ_READY: Set ready status of virtqueue
> +
> +- VDUSE_GET_VQ_READY: Get ready status of virtqueue
> +
> +- VDUSE_SET_VQ_STATE: Set the state (last_avail_idx) for virtqueue
> +
> +- VDUSE_GET_VQ_STATE: Get the state (last_avail_idx) for virtqueue
> +
> +- VDUSE_SET_FEATURES: Set virtio features supported by the driver
> +
> +- VDUSE_GET_FEATURES: Get virtio features supported by the device
> +
> +- VDUSE_SET_STATUS: Set the device status
> +
> +- VDUSE_GET_STATUS: Get the device status
> +
> +- VDUSE_SET_CONFIG: Write to device specific configuration space
> +
> +- VDUSE_GET_CONFIG: Read from device specific configuration space
> +
> +- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping in device IOTLB
> +
> +Please see include/linux/vdpa.h for details.
> +
> +In the data path, vDPA device's iova regions will be mapped into userspace with
> +the help of VDUSE_IOTLB_GET_FD ioctl on the userspace vDPA device fd:
> +
> +- VDUSE_IOTLB_GET_FD: get the file descriptor to iova region. Userspace can
> +  access this iova region by passing the fd to mmap(2).
> +
> +Besides, the eventfd mechanism is used to trigger interrupt callbacks and
> +receive virtqueue kicks in userspace. The following ioctls on the userspace
> +vDPA device fd are provided to support that:
> +
> +- VDUSE_VQ_SETUP_KICKFD: set the kickfd for virtqueue, this eventfd is used
> +  by VDUSE driver to notify userspace to consume the vring.
> +
> +- VDUSE_VQ_SETUP_IRQFD: set the irqfd for virtqueue, this eventfd is used
> +  by userspace to notify VDUSE driver to trigger interrupt callbacks.
> +
> +MMU-based IOMMU Driver
> +----------------------
> +In virtio-vdpa case, VDUSE framework implements a MMU-based on-chip IOMMU

                                                   an MMU-based

> +driver to support mapping the kernel dma buffer into the userspace iova

                                        DMA

> +region dynamically.
> +
> +The basic idea behind this driver is treating MMU (VA->PA) as IOMMU (IOVA->PA).
> +The driver will set up MMU mapping instead of IOMMU mapping for the DMA transfer
> +so that the userspace process is able to use its virtual address to access
> +the dma buffer in kernel.

       DMA

> +
> +And to avoid security issue, a bounce-buffering mechanism is introduced to
> +prevent userspace accessing the original buffer directly which may contain other
> +kernel data. During the mapping, unmapping, the driver will copy the data from
> +the original buffer to the bounce buffer and back, depending on the direction of
> +the transfer. And the bounce-buffer addresses will be mapped into the user address
> +space instead of the original one.


thanks.
-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
