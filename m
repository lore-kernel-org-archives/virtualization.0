Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49694319601
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977056; cv=none; b=Hd1W78H1ryptt8cnC5Vm3CGC0vNVvi+56CiQ/CnJ/tW46i4mMtx/UMKo4hWZrciOPJ6PSExQ0/dePjYYQy5xFeZFGvb8qZzkjFZufQTOaqu0cNIyzFxKQibDOG1JM/7UnyOBXUSP9f5iixk+ly1gsFt1KwhjAS9Zng4MBpvEJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977056; c=relaxed/simple;
	bh=C953rTc1lmFvOuDMDuD8oay8gPLdtKZ6vlmgWR9M7Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QkC9g59X69aXCa0RFzh3bM6OFbDreoHEv29UJSHKrzI2Z9CnV9wDcepfcN7nkXBZyQDyqtsthwwHBLy3u6Yas2D0MvaT3G0X5Pxsg/Jth4JUKLbuLsuEO8GFGMkTvYOMzLDCm3XaF1+6aZLiVURqDQZJ69ETx6oSJxRTjbxpGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIV+8YIR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIV+8YIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770977054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFaUQt8o2cm+tVon4w+y5pAdNpZ4dm7KtAjjkPonwIQ=;
	b=hIV+8YIRju4MNphC4755+TR+tcsNAwnWn5L9bnKt1Cxm98mLiKZTAVHnGcJrLW3aKSmCz3
	LncmKyHJFLRL0vxLdSr2J77Me3iuk+j971+/V9kp5Qbyt84sKgDkuaf1Z0DZiOAnObZYQM
	Vxc6Vc/MNQ1dzy5AqyD5WWSh/3RGCac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-NRFb_v9tMMGdhQ0lKyVk0Q-1; Fri, 13 Feb 2026 05:04:12 -0500
X-MC-Unique: NRFb_v9tMMGdhQ0lKyVk0Q-1
X-Mimecast-MFC-AGG-ID: NRFb_v9tMMGdhQ0lKyVk0Q_1770977051
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435991d4a3aso451667f8f.1
        for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 02:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977051; x=1771581851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFaUQt8o2cm+tVon4w+y5pAdNpZ4dm7KtAjjkPonwIQ=;
        b=Xu0MxnaNb4ETAS5EPhcyT4iMg47nQikIsfEDp1ySgHbLuqFvS6TDdyzJzHt2qt9Lgx
         MZK7y/xcy3IKZYf3T4OLZXNBylHKfwJZOkHP102PzhXk3iAPXjg4/yZDKMfmo2Pu1qXl
         2hLBFQo/5vAlWlIoeH7zHBmwJ+cS5qZpjX3D7w+j4G72Loa8YUEl67YcNMsgT8PhsGA6
         tkg5MwO/y+Vt7TfCTBE/iJavV/TZ8IAbV37/H0PSHKoYkX9bVysyot7GLsF4Duoy3gmR
         yPGuGoLIfhDksnLNG4BfP8eNaArL21OifGcY2LuiEdonV2qLZ/fRFUK2EMqLZke3S/ru
         /FhA==
X-Forwarded-Encrypted: i=1; AJvYcCXJfOr6DGj3KgHDE4MaA9nO8nkRWK1tBOQFRwo/ts7+bmqgSRfsp4LiJlFVEJNrob6A2AKeGxq6tODEq+ItSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn81sFLF+wLBxUUa97MdUkWfHubjuJQi6+Su0YHkvmRGTZRz0l
	qT0I6BwsDbAY7cvsIhvDphoZaq8KnUwcQpKmke8c7C9/mVNKm7gLcmUBGShQFAy7ZNXMJvhF9qF
	nitAp40RAxQzTEeOJHcxS0s+2THq7lvSEy4Pi3NRmBCEbTAKdwAxSM2ERzxOB70ZzkRmA
X-Gm-Gg: AZuq6aIwNwPVINiCo+kmN8aQKG8XaFLG09+tPTwdmhr0FVaap0M7a089lP1IPfTlsDl
	PzuwCRXv1utx0AuypdsShZaNwRIIUSV9vD7FU0SfoI6N372WPoMhME82wWtSTGvBKbG7+0y35HG
	TsRZkm3Lb+dM1oB69CLI4Gr5R1DFH+1l0sIjw06y8RfvuSL7Z2FbPCGpWVlfj4Uqy0PrEom12g+
	FP2lTxQshB/bkJRoUgtypAYIICrCICowbrBNhQDVLKsX/TM2MgUn6RrR0l4XFGDwHKJlOrgEKvq
	VG1/bdbK2qIxvKlew+K+e7E5Nw5V9zb9UsozbiF7aGhdLYkaeRYG9N6Dd9rKxZyH73xHZayN3rB
	DGJiZ41PcFsxDK4sZrVq215ofprP6b7kCoabvTbW4xMZAMg==
X-Received: by 2002:a05:6000:1843:b0:436:3707:2bf3 with SMTP id ffacd0b85a97d-437978dcf68mr2620805f8f.24.1770977051013;
        Fri, 13 Feb 2026 02:04:11 -0800 (PST)
X-Received: by 2002:a05:6000:1843:b0:436:3707:2bf3 with SMTP id ffacd0b85a97d-437978dcf68mr2620741f8f.24.1770977050414;
        Fri, 13 Feb 2026 02:04:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm5319158f8f.18.2026.02.13.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:04:09 -0800 (PST)
Date: Fri, 13 Feb 2026 05:04:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260213050338-mutt-send-email-mst@kernel.org>
References: <20260202224835.559538-1-arnd@kernel.org>
 <20260202224835.559538-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260202224835.559538-2-arnd@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a-51tRNSMgqqJUNMZuP9fjxdBWYj6QDnXhTRM8Ba6z8_1770977051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2026 at 11:48:08PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These two ioctls are incompatible on 32-bit x86 userspace, because
> the data structures are shorter than they are on 64-bit.
> 
> Add a proper .compat_ioctl handler for x86 that reads the structures
> with the smaller padding before calling the internal handlers.
> 
> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions")
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


So patch 1 is in going upstream but I am still waiting for v3 of patch
1.

> ---
> The code is directly copied from the native ioctl handler, but I
> did not test this with actual x86-32 userspace, so please review
> carefully.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 123 ++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 405d59610f76..3ada167ac260 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1618,6 +1618,127 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	return ret;
>  }
>  
> +/*
> + * i386 has different alignment constraints than x86_64,
> + * so there are only 3 bytes of padding instead of 7.
> + */
> +struct compat_vduse_iotlb_entry {
> +	compat_u64 offset;
> +	compat_u64 start;
> +	compat_u64 last;
> +	__u8 perm;
> +	__u8 padding[__alignof__(compat_u64) - 1];
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
> +	__u8 padding[__alignof__(compat_u64) - 1];
> +} __uapi_arch_align;
> +#define COMPAT_VDUSE_VQ_GET_INFO	_IOWR(VDUSE_BASE, 0x15, struct compat_vduse_vq_info)
> +
> +static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_X86_64))
> +		return vduse_dev_ioctl(file, cmd,
> +				       (unsigned long)compat_ptr(arg));
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
> +
>  static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>  	struct vduse_dev *dev = file->private_data;
> @@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops = {
>  	.write_iter	= vduse_dev_write_iter,
>  	.poll		= vduse_dev_poll,
>  	.unlocked_ioctl	= vduse_dev_ioctl,
> -	.compat_ioctl	= compat_ptr_ioctl,
> +	.compat_ioctl	= PTR_IF(IS_ENABLED(CONFIG_COMPAT), vduse_dev_compat_ioctl),
>  	.llseek		= noop_llseek,
>  };
>  
> -- 
> 2.39.5

