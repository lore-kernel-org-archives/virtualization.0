Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B16AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 08:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EFFC40D7D;
	Wed, 29 Jun 2022 08:43:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EFFC40D7D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dfkizzwA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkB2nHS05quU; Wed, 29 Jun 2022 08:43:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7866D40CD7;
	Wed, 29 Jun 2022 08:43:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7866D40CD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 333E8C0032;
	Wed, 29 Jun 2022 08:43:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 184C240CD7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 184C240CD7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5TbIzbMYPWE5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2A2B40C76
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2A2B40C76
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656492181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlGCypZ1cQvv3V+v5q9PQcrqSY8WL1ipwnqeNBFmu7E=;
 b=dfkizzwAEO2P5GQ6TRWnWOiTzXPOGGS+HVZRb970qoJiNeqmUGg8RUdvHvfcgLIXAcqbuh
 oLnXio5dETwp+AMoETtUP/lPMgKzTWbtTRG5O7/gLgLoLw6liBfXHulPmArHK7Wixjumef
 1ads3qT+ZXVvx4iob3qKc0oTqCh0WZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-KaH0gFLsOS6h2o2P-Kebhg-1; Wed, 29 Jun 2022 04:43:00 -0400
X-MC-Unique: KaH0gFLsOS6h2o2P-Kebhg-1
Received: by mail-wm1-f69.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so6312462wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 01:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GlGCypZ1cQvv3V+v5q9PQcrqSY8WL1ipwnqeNBFmu7E=;
 b=BgWjMVxUaJFPH/ACoWNjbH45GRfDAzyMW4N6YNPtvrURxGKLuohZkpUULV4mLFj4VB
 h8jLKG2l6qYnKHDJr38swWHeHbsUjcwTVWIvsmEfo72LqWVHb4EtXxMAUucBwLOnKstJ
 q08Cq+g1jGUpTRmUSzAiou3eKmfKH2wxXZP42c62EF8/+XGxIe8uQNuEs4sDbhnB4msq
 ZrAUGn5edfP7Jmchnyz12bxyLRYEreX1QfVvHrwAVohQtJb3AlT4R6n0d7CwvKu3A431
 rCaNkBnbPBE9KB+xWHm6FaPO6XP86MpupcvVflYz49dVZ/BNsnsF8M+TkkLF6xfF+eoS
 hagg==
X-Gm-Message-State: AJIora99/XKkhTlsiBcNjtkH1ohBbMBERTB9WJ8dQeymGascFGuCn3CM
 9Xl+c0xs+7oVvnBAXETNjRQ8yWL65DECxF0h2A7qR7vu/dRBOzleRC/2UWWx9GelbjfxXqfjDpy
 K6GVoCvA9C5oXDI+bWcchAYjltpXIf3JjLRjlAXaGwQ==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id
 k6-20020a5d6d46000000b0021b933d7950mr1852051wri.679.1656492179498; 
 Wed, 29 Jun 2022 01:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIEG67vGMX2iL8I9wiTWD5Lhbc4JZvMuvX48MEPvoxGxQdvBECJ+sJEgCSzEzGIw7mI5Hmbg==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id
 k6-20020a5d6d46000000b0021b933d7950mr1852030wri.679.1656492179238; 
 Wed, 29 Jun 2022 01:42:59 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 t3-20020a0560001a4300b0021b9cc87aa9sm16130444wry.111.2022.06.29.01.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 01:42:58 -0700 (PDT)
Date: Wed, 29 Jun 2022 04:42:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629043539-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220629082541.118-6-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiaodong.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com
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

On Wed, Jun 29, 2022 at 04:25:40PM +0800, Xie Yongji wrote:
> Introduce two ioctls: VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM to support registering
> and de-registering userspace memory for IOTLB
> in virtio-vdpa case.
> 
> Now it only supports registering userspace memory
> for IOTLB as bounce buffer.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 138 +++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         |  28 ++++++
>  2 files changed, 166 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c47a5d9765cf..7b2ea7612da9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -21,6 +21,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
>  #include <uapi/linux/vdpa.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -64,6 +65,13 @@ struct vduse_vdpa {
>  	struct vduse_dev *dev;
>  };
>  
> +struct vduse_iotlb_mem {
> +	unsigned long iova;
> +	unsigned long npages;
> +	struct page **pages;
> +	struct mm_struct *mm;
> +};
> +
>  struct vduse_dev {
>  	struct vduse_vdpa *vdev;
>  	struct device *dev;
> @@ -95,6 +103,8 @@ struct vduse_dev {
>  	u8 status;
>  	u32 vq_num;
>  	u32 vq_align;
> +	struct vduse_iotlb_mem *iotlb_mem;
> +	struct mutex mem_lock;
>  };
>  
>  struct vduse_dev_msg {
> @@ -917,6 +927,100 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>  	return ret;
>  }
>  
> +static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
> +				     u64 iova, u64 size)
> +{
> +	int ret;
> +
> +	mutex_lock(&dev->mem_lock);
> +	ret = -ENOENT;
> +	if (!dev->iotlb_mem)
> +		goto unlock;
> +
> +	ret = -EINVAL;
> +	if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
> +		goto unlock;
> +
> +	vduse_domain_remove_user_bounce_pages(dev->domain);
> +	unpin_user_pages(dev->iotlb_mem->pages, dev->iotlb_mem->npages);

I notice you don't mark the pages dirty. This is going to be a problem.

> +	atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
> +	mmdrop(dev->iotlb_mem->mm);
> +	vfree(dev->iotlb_mem->pages);
> +	kfree(dev->iotlb_mem);
> +	dev->iotlb_mem = NULL;
> +	ret = 0;
> +unlock:
> +	mutex_unlock(&dev->mem_lock);
> +	return ret;
> +}
> +
> +static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
> +				   u64 iova, u64 uaddr, u64 size)
> +{
> +	struct page **page_list = NULL;
> +	struct vduse_iotlb_mem *mem = NULL;
> +	long pinned = 0;
> +	unsigned long npages, lock_limit;
> +	int ret;
> +
> +	if (size != dev->domain->bounce_size ||
> +	    iova != 0 || uaddr & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->mem_lock);
> +	ret = -EEXIST;
> +	if (dev->iotlb_mem)
> +		goto unlock;
> +
> +	ret = -ENOMEM;
> +	npages = size >> PAGE_SHIFT;
> +	page_list = vmalloc(array_size(npages,
> +			    sizeof(struct page *)));

Is this basically trying to do a vmalloc with userspace-controlled size?
That's an easy DOS vector.

> +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +	if (!page_list || !mem)
> +		goto unlock;
> +
> +	mmap_read_lock(current->mm);
> +
> +	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
> +		goto out;
> +
> +	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
> +				page_list, NULL);
> +	if (pinned != npages) {
> +		ret = pinned < 0 ? pinned : -ENOMEM;
> +		goto out;
> +	}


This is a popular approach but it's problematic if multiple
devices try to pin the same page.
Can this happen here?

> +
> +	ret = vduse_domain_add_user_bounce_pages(dev->domain,
> +						 page_list, pinned);
> +	if (ret)
> +		goto out;
> +
> +	atomic64_add(npages, &current->mm->pinned_vm);
> +
> +	mem->pages = page_list;
> +	mem->npages = pinned;
> +	mem->iova = iova;
> +	mem->mm = current->mm;
> +	mmgrab(current->mm);
> +
> +	dev->iotlb_mem = mem;
> +out:
> +	if (ret && pinned > 0)
> +		unpin_user_pages(page_list, pinned);
> +
> +	mmap_read_unlock(current->mm);
> +unlock:
> +	if (ret) {
> +		vfree(page_list);
> +		kfree(mem);
> +	}
> +	mutex_unlock(&dev->mem_lock);
> +	return ret;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
> @@ -943,6 +1047,16 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (entry.start > entry.last)
>  			break;
>  
> +		if (domain->bounce_map && dev->iotlb_mem) {
> +			ret = -EEXIST;
> +			if (entry.start >= 0 &&
> +			    entry.last < domain->bounce_size)
> +				break;
> +
> +			if (entry.start < domain->bounce_size)
> +				entry.start = domain->bounce_size;
> +		}
> +
>  		spin_lock(&domain->iotlb_lock);
>  		map = vhost_iotlb_itree_first(domain->iotlb,
>  					      entry.start, entry.last);
> @@ -1102,6 +1216,28 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		ret = 0;
>  		break;
>  	}
> +	case VDUSE_IOTLB_REG_UMEM: {
> +		struct vduse_iotlb_umem umem;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&umem, argp, sizeof(umem)))
> +			break;
> +
> +		ret = vduse_dev_reg_iotlb_mem(dev, umem.iova,
> +					      umem.uaddr, umem.size);
> +		break;
> +	}
> +	case VDUSE_IOTLB_DEREG_UMEM: {
> +		struct vduse_iotlb_umem umem;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&umem, argp, sizeof(umem)))
> +			break;
> +
> +		ret = vduse_dev_dereg_iotlb_mem(dev, umem.iova,
> +						umem.size);
> +		break;
> +	}
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> @@ -1114,6 +1250,7 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct vduse_dev *dev = file->private_data;
>  
> +	vduse_dev_dereg_iotlb_mem(dev, 0, dev->domain->bounce_size);
>  	spin_lock(&dev->msg_lock);
>  	/* Make sure the inflight messages can processed after reconncection */
>  	list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1176,6 +1313,7 @@ static struct vduse_dev *vduse_dev_create(void)
>  		return NULL;
>  
>  	mutex_init(&dev->lock);
> +	mutex_init(&dev->mem_lock);
>  	spin_lock_init(&dev->msg_lock);
>  	INIT_LIST_HEAD(&dev->send_list);
>  	INIT_LIST_HEAD(&dev->recv_list);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index c201b7a77c2c..1b17391e228f 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -227,6 +227,34 @@ struct vduse_iotlb_info {
>  /* Get IOTLB information, e.g. bounce buffer size */
>  #define VDUSE_IOTLB_GET_INFO    _IOR(VDUSE_BASE, 0x18, struct vduse_iotlb_info)
>  
> +/**
> + * struct vduse_iotlb_umem - userspace memory configuration
> + * @uaddr: start address of userspace memory, it must be aligned to page size
> + * @iova: IOVA of userspace memory, it must be equal to bounce iova returned
> + *        by VDUSE_IOTLB_GET_INFO now
> + * @size: size of userspace memory, it must be equal to bounce size returned
> + *        by VDUSE_IOTLB_GET_INFO now
> + * @reserved: for future use, needs to be initialized to zero

You should check that it's 0 in that case, otherwise userspace
will conveniently forget.

> + *
> + * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> + * ioctls to register/de-register userspace memory for IOTLB.
> + */
> +struct vduse_iotlb_umem {
> +	__u64 uaddr;
> +	__u64 iova;
> +	__u64 size;
> +	__u64 reserved[3];
> +};
> +
> +/*
> + * Register userspace memory for IOTLB. Now we only support registering
> + * userspace memory as bounce buffer.
> + */
> +#define VDUSE_IOTLB_REG_UMEM	_IOW(VDUSE_BASE, 0x19, struct vduse_iotlb_umem)
> +
> +/* De-register the userspace memory. Caller should set iova and size field. */
> +#define VDUSE_IOTLB_DEREG_UMEM	_IOW(VDUSE_BASE, 0x1a, struct vduse_iotlb_umem)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>  
>  /**
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
