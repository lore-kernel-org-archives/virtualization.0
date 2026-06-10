Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EF2EDD6C
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069173; cv=none; b=HuxSsCvSEunyizUi3RAMhFSSTiVnagwx+xiC7QQ1typZhIYe6bU9C6BK9aD5n7pkYHhykngqw8uUf9OGpjzxNOyooQe6s5IN5Wqsag0oCFXbtO3GeaMsBeWuPFR8f7e6YhAHBfkmNZGs2MqIEOf64YdcNo/M0oGyIZetQ/ucKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069173; c=relaxed/simple;
	bh=bAo/9pVuQEla4AfFVK48Ke2WXFes/c6ZDC9cEbQIvxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pILqDrWL+kf1eTHl8TTUzZaz+PPh6WyXskvc2kWXAI0IkaJEct1AGNucqQXpUv2U5zO7lFgn7ZZ/Gw0Yb7czbzeG0MmzrWwz/XQjWHEsD9vsLYOancbrEOkH0AZNv8E/cQ1fSD5LaSbgP8QYrwr4FVIKigzQjBQDr/o3uMvmI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTnJ2IGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTnJ2IGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781069170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua3AD41us2FBEHQ4+Zr+c+pHwYn7Q8L/aLenfNA759Q=;
	b=NTnJ2IGXhjnf61VdVbFc1UFgKjPaNhmKvOfFhbneniuPsdpW5POA1McaWLwhSSlD0dBIlj
	Pyiyyx0/OAk5lp1Fuk/VGLxFcpf5yebeC0ye6gsAGaH3BZILdT9MrMZlberOIw198y4R3+
	vIXWnW79Uck37VNsJLq2gCrM8KhNlJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-V5F1_woeNiSUsL84lI3Zsg-1; Wed, 10 Jun 2026 01:26:09 -0400
X-MC-Unique: V5F1_woeNiSUsL84lI3Zsg-1
X-Mimecast-MFC-AGG-ID: V5F1_woeNiSUsL84lI3Zsg_1781069168
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490addd42bbso38892085e9.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 22:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781069168; x=1781673968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua3AD41us2FBEHQ4+Zr+c+pHwYn7Q8L/aLenfNA759Q=;
        b=tRn9GOu+gWUV/VyPe82O6jxeHs0ToULaaqIXhcibaVRKosCftqYow1sl6MkFyxCbOp
         Di0JxInWJr7WEF/tZ2qRmkhse2DifjG3X5sd3C1zDl0dpjO4WiCCj8OyGFmeld3DF0Nw
         coIBEg/hUC8HezTVW9qjs8N+vo01f/1382hkZkzv37xdKwTX6VQzxGTDNFsV4goiIFVM
         Agxz8RHZ9rMNiPQ5KT+Vo7+Bp+5ah5uw9+TUfCZBQkbdo2naAmzJKW2nLZ8lAa49Ni0r
         TPDEBgcf6a0LtWgJAbOL7FlP1mdMmldYLmzg6q4wYrkoK/4kPLSta63y8vhdLXyFJPcb
         0bdA==
X-Forwarded-Encrypted: i=1; AFNElJ9UOXzlVlLUSaWuF90yeyjI9sNmAAGYmGubI2sx+0amPi/7Gk0zoEE23ees7S1Mxuiwah1aPP3mG+mRIq5PZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YypaLg424M4IIPEvzRJPR0xfVdoP2xZ0GRAvOgZmTTQ5Oly7uVb
	WikB6QdC8jPylvY9F0DLDYK4ZeixuQffOg9eFxRTRpQqtzCLSecQ8WxbJRIllOc7EEAXpW5eueX
	OevqoyZQ06ZAJaoQlUnBo8OU/N/Hh4hfx+bDcnbRqTnfF/P6i7Y3qbHmkGBE/zb8N3RIl
X-Gm-Gg: Acq92OFDAoXTXW9rlxsm5nmwoKx/JtWIH7bGxrnPc2TKDpwLEfPuD00c/8yA4jAnXCj
	MQEVjQbRf18i8C3rKVqo1WRHd/D+0VWsXa2MbK2xyjQLBoHC8MX+dJGML9CXJ5NkJaOyP6aebi4
	F8Jt5qfGJ7xr9rTdDe8k0Awkc8ylLtdVpyiz0ADObRX8VnVWcf2g2F7z7laLQ2jYMebUaEVGJhW
	ik4lChD65dmkWt9pTrppv5OCa607QM1g2eadWmLzA5EVzhuujP3dk5ZmABbZZ4q9m2nBDRG753q
	saRdX4lc4VTuIiqGztE2uORXO1ucweDwfxs378EepRhrICj3yty0Qxrvt9TWKK3bWEDbYSqQnmR
	k8F+FriI0V1kigiQ83ScxA1NsUlK5OlFgrqL9qsVKQtQu6LC+0s9jTA==
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr385315355e9.24.1781069167660;
        Tue, 09 Jun 2026 22:26:07 -0700 (PDT)
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr385315085e9.24.1781069167116;
        Tue, 09 Jun 2026 22:26:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm56939057f8f.32.2026.06.09.22.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 22:26:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 01:26:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260610012421-mutt-send-email-mst@kernel.org>
References: <20260213154051.4172275-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260213154051.4172275-1-arnd@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P_FR4579NI7OJgYkVoOhcXYTHf0vrGkQ4XyfSuaPX0E_1781069168
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 13, 2026 at 04:40:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These two ioctls are incompatible on 32-bit x86 userspace, because
> the data structures are shorter than they are on 64-bit.
> 
> Add a proper .compat_ioctl handler for x86 that reads the structures
> with the smaller padding before calling the internal handlers. On
> all other architectures, CONFIG_COMPAT_FOR_U64_ALIGNMENT is disabled
> and no special handling is required.
> 
> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3 changes:
>  - check CONFIG_COMPAT_FOR_U64_ALIGNMENT in preprocessor
> v2 changes:
>  - split compat handler into separate function
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 123 ++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 405d59610f76..e0f5a7397221 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1618,6 +1618,127 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
> +/*
> + * i386 has different alignment constraints than x86_64,
> + * so there are only 3 bytes of padding instead of 7.
> + */
> +struct compat_vduse_iotlb_entry {
> +	compat_u64 offset;
> +	compat_u64 start;
> +	compat_u64 last;
> +	__u8 perm;
> +	__u8 padding[3];
> +};
> +#define COMPAT_VDUSE_IOTLB_GET_FD	_IOWR(VDUSE_BASE, 0x10, struct compat_vduse_iotlb_entry)
> +
> +struct compat_vduse_vq_info {
> +	__u32 index;
> +	__u32 num;
> +	compat_u64 desc_addr;
> +	compat_u64 driver_addr;
> +	compat_u64 device_addr;
> +	union {
> +		struct vduse_vq_state_split split;
> +		struct vduse_vq_state_packed packed;
> +	};
> +	__u8 ready;
> +	__u8 padding[3];
> +} __uapi_arch_align;

what is this __uapi_arch_align supposed to be doing?

It compiles by luck because gcc thinks it's a global variable.


> +#define COMPAT_VDUSE_VQ_GET_INFO	_IOWR(VDUSE_BASE, 0x15, struct compat_vduse_vq_info)
> +
> +static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	int ret;
> +
> +	if (unlikely(dev->broken))
> +		return -EPERM;
> +
> +	switch (cmd) {
> +	case COMPAT_VDUSE_IOTLB_GET_FD: {
> +		struct vduse_iotlb_entry_v2 entry = {0};
> +		struct file *f = NULL;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
> +			break;
> +
> +		ret = vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
> +		if (ret)
> +			break;
> +
> +		ret = -EINVAL;
> +		if (!f)
> +			break;
> +
> +		ret = copy_to_user(argp, &entry, _IOC_SIZE(cmd));
> +		if (ret) {
> +			ret = -EFAULT;
> +			fput(f);
> +			break;
> +		}
> +		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
> +		fput(f);
> +		break;
> +	}
> +	case COMPAT_VDUSE_VQ_GET_INFO: {
> +		struct vduse_vq_info vq_info = {};
> +		struct vduse_virtqueue *vq;
> +		u32 index;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&vq_info, argp,
> +				   sizeof(struct compat_vduse_vq_info)))
> +			break;
> +
> +		ret = -EINVAL;
> +		if (vq_info.index >= dev->vq_num)
> +			break;
> +
> +		index = array_index_nospec(vq_info.index, dev->vq_num);
> +		vq = dev->vqs[index];
> +		vq_info.desc_addr = vq->desc_addr;
> +		vq_info.driver_addr = vq->driver_addr;
> +		vq_info.device_addr = vq->device_addr;
> +		vq_info.num = vq->num;
> +
> +		if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
> +			vq_info.packed.last_avail_counter =
> +				vq->state.packed.last_avail_counter;
> +			vq_info.packed.last_avail_idx =
> +				vq->state.packed.last_avail_idx;
> +			vq_info.packed.last_used_counter =
> +				vq->state.packed.last_used_counter;
> +			vq_info.packed.last_used_idx =
> +				vq->state.packed.last_used_idx;
> +		} else
> +			vq_info.split.avail_index =
> +				vq->state.split.avail_index;
> +
> +		vq_info.ready = vq->ready;
> +
> +		ret = -EFAULT;
> +		if (copy_to_user(argp, &vq_info,
> +		    sizeof(struct compat_vduse_vq_info)))
> +			break;
> +
> +		ret = 0;
> +		break;
> +	}
> +	default:
> +		ret = -ENOIOCTLCMD;
> +		break;
> +	}
> +
> +	return vduse_dev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#else
> +#define vduse_dev_compat_ioctl compat_ptr_ioctl
> +#endif
> +
>  static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct vduse_dev *dev = file->private_data;
> @@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
>  	.write_iter	= vduse_dev_write_iter,
>  	.poll		= vduse_dev_poll,
>  	.unlocked_ioctl	= vduse_dev_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> +	.compat_ioctl	= vduse_dev_compat_ioctl,
>  	.llseek		= noop_llseek,
>  };
>  
> -- 
> 2.39.5

