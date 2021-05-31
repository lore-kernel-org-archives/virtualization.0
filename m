Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD7C47096
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 04:56:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FFC6023B
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 04:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FFC6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1304360A3A;
	Mon, 31 May 2021 04:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiHHtTT3t96E; Mon, 31 May 2021 04:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A499E6090C;
	Mon, 31 May 2021 04:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81071C000E;
	Mon, 31 May 2021 04:56:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE714C0001;
 Mon, 31 May 2021 04:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE67560A3A;
 Mon, 31 May 2021 04:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7L4wFHJHEl3; Mon, 31 May 2021 04:56:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1224C6090C;
 Mon, 31 May 2021 04:56:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D886961057;
 Mon, 31 May 2021 04:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1622436988;
 bh=ZmSvGxgElt/PTBdcjud8xAVC3SnaA7rmloK6j6Sv88s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iECVcrjdtpBEoiSTdgPnfA9VaCZX3lXZXVFRxcs36qIJm/fGdtrOg6ursZ+ZUev6p
 SG3ywHs9kGpchB+/l0NRmeD5iCcyzHVz+3Q08ImQ4cRhhwQaCcDa7NSr6UaWFTEGuz
 2HuPqdeBd30igoYiQHo8xDIOag1dwVriDuvzZSlQ=
Date: Mon, 31 May 2021 06:56:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <YLRsehBRAiCJEDl0@kroah.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517095513.850-12-xieyongji@bytedance.com>
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 axboe@kernel.dk, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

On Mon, May 17, 2021 at 05:55:12PM +0800, Xie Yongji wrote:
> +struct vduse_dev {
> +	struct vduse_vdpa *vdev;
> +	struct device dev;
> +	struct cdev cdev;

You now have 2 reference counted devices controling the lifespace of a
single structure.  A mess that is guaranteed to go wrong.  Please never
do this.

> +	struct vduse_virtqueue *vqs;
> +	struct vduse_iova_domain *domain;
> +	char *name;
> +	struct mutex lock;
> +	spinlock_t msg_lock;
> +	atomic64_t msg_unique;

Why do you need an atomic and a lock?

> +	wait_queue_head_t waitq;
> +	struct list_head send_list;
> +	struct list_head recv_list;
> +	struct list_head list;
> +	struct vdpa_callback config_cb;
> +	struct work_struct inject;
> +	spinlock_t irq_lock;
> +	unsigned long api_version;
> +	bool connected;
> +	int minor;
> +	u16 vq_size_max;
> +	u32 vq_num;
> +	u32 vq_align;
> +	u32 config_size;
> +	u32 device_id;
> +	u32 vendor_id;
> +};
> +
> +struct vduse_dev_msg {
> +	struct vduse_dev_request req;
> +	struct vduse_dev_response resp;
> +	struct list_head list;
> +	wait_queue_head_t waitq;
> +	bool completed;
> +};
> +
> +struct vduse_control {
> +	unsigned long api_version;

u64?

> +};
> +
> +static unsigned long max_bounce_size = (64 * 1024 * 1024);
> +module_param(max_bounce_size, ulong, 0444);
> +MODULE_PARM_DESC(max_bounce_size, "Maximum bounce buffer size. (default: 64M)");
> +
> +static unsigned long max_iova_size = (128 * 1024 * 1024);
> +module_param(max_iova_size, ulong, 0444);
> +MODULE_PARM_DESC(max_iova_size, "Maximum iova space size (default: 128M)");
> +
> +static bool allow_unsafe_device_emulation;
> +module_param(allow_unsafe_device_emulation, bool, 0444);
> +MODULE_PARM_DESC(allow_unsafe_device_emulation, "Allow emulating unsafe device."
> +	" We must make sure the userspace device emulation process is trusted."
> +	" Otherwise, don't enable this option. (default: false)");
> +

This is not the 1990's anymore, please never use module parameters, make
these per-device attributes if you really need them.

> +static int vduse_init(void)
> +{
> +	int ret;
> +
> +	if (max_bounce_size >= max_iova_size)
> +		return -EINVAL;
> +
> +	ret = misc_register(&vduse_misc);
> +	if (ret)
> +		return ret;
> +
> +	vduse_class = class_create(THIS_MODULE, "vduse");

If you have a misc device, you do not need to create a class at the same
time.  Why are you doing both here?  Just stick with the misc device, no
need for anything else.

> +	if (IS_ERR(vduse_class)) {
> +		ret = PTR_ERR(vduse_class);
> +		goto err_class;
> +	}
> +	vduse_class->devnode = vduse_devnode;
> +
> +	ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");

Wait, you want a whole major?  What is the misc device for?

> +MODULE_VERSION(DRV_VERSION);

MODULE_VERSION() makes no sense when the code is merged into the kernel
tree, so you can just drop that.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
