Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FA29BD80
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112837; cv=none; b=LoRfY5wNPFuLxOObGqM7G90EErWiyt38/f09p79Bqxrwbkve7+P7sfGFd3XgjLNIeR+Bt8qYPhKCsRsFJej8dBKwqJafKxTVw0WSULcwoQVg9XHzguA/n2vML5up05xqC5GSinBJll6qWhBocv1mx2UctlRdq79dnU82daVuKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112837; c=relaxed/simple;
	bh=6gC6QwOSU2CEbHxnD2RcW3ic9SaytmxWU004Utl+5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TYDgMxBd50BAF7RWjfkX9lYzwtVXRK+S/iYo1hyzIChAKwC1ewYc2JJho4ZpZftO1XLtbfRJvxj33i9/tNPZ6sy1aijYdnZrWG61U/nsObaymterl/y4gV7q+VwWlvU+ukk/2goDjJ/C1/VN/9/ArqkVHN1AxkANB/X3Ma9jieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Osg0bVZC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osg0bVZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770112835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Maoq0nNNPcqKh6aFj2hRGbE9WNaWJtcvwwKWPlQodf8=;
	b=Osg0bVZC2GfLMFpEzNuMUntEj53h8kPMdqMtWLrEHrtiIcTOQDyycNClNrCLOmpnRh23Pg
	DGkscIiZoXT/ZP5BmZ/fSXjY20j3F9OkT912OiUMGcdYQ/SrOwfY8OZwNUaFiVfGmayMVk
	Z9TeZZ0hw7fxX5gynSXbb6f+zn8AQB4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-HZ5Gim7VPLG7RKIIrQgUOQ-1; Tue, 03 Feb 2026 05:00:33 -0500
X-MC-Unique: HZ5Gim7VPLG7RKIIrQgUOQ-1
X-Mimecast-MFC-AGG-ID: HZ5Gim7VPLG7RKIIrQgUOQ_1770112833
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480717a8ef9so5800275e9.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112832; x=1770717632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Maoq0nNNPcqKh6aFj2hRGbE9WNaWJtcvwwKWPlQodf8=;
        b=aeb2ZAG16ge6uLQavwUqw1jSZ9UK8zDRnFgn/t9qHCYPMRDOJYwLg/AwZnMF7ruqsL
         AUoLoS3yHJzmrWKYpR4BbI2K0RJGxbcoeoEED0T11YSy0r/U6DquN2iDUd5Fn5xXwAE1
         Y3rW6+LRvQojS9amtXGUkASgEpws6rKi3TeeifvGPWbwYak4tjNjtfVveDrbesCXWFKE
         omd0sPTWDv4H8HKeknsyATVZvUi5A5/Bh/VDRbSaNvlnst5GE8oG83YOgIQ5xe5N9LRN
         H1w1Wj7eS3CKmiCXEN6fYl/cPd8Pr6izAlUDhCQ5WEE/ZGWmtAloD095M5ETnea091GV
         UVbA==
X-Forwarded-Encrypted: i=1; AJvYcCVoE4yz9HLgyLzFsLU3duai9i/p4lJhyV4m7DzDq8Q3zsF02jb1HwRfm7AyN6KzcIhQ1p/9zRdkeZlmRbVpCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlEFNDLZhk9c+CmCRaZ1Eugnl0IfEvYphtrLc0RPKbZu89mpah
	ILcOEASjIx90JbHZ+7l8CAsg2k1uQ+91HOez5XbDmE8awBawFPRpz2wXUdzn2gpDyYgzzDrcmP1
	SxJ/GkleKTxUlM/JxSAwjF53nXjFLdel19/PWnd89egQ5D6XexIvHPK/4TpxFRMEhwtAE2niNYY
	GI
X-Gm-Gg: AZuq6aIjDY3tsk4SAqAPXBfBik09kKBA2f/Mn6vszYsVKfdlz4lhokw0qdVR5NO7a1T
	tucbZZZ8yOuPaTO2TqMZUPxovBqAZqBMYojCulrUrr2IEcLACGBY/3GubL5wABLCSEa+fX/OE4j
	kcv6GK7z2+jUpBrWolUwBonZ90pn3GwiI0WG2Ji7E+f/AQyQJ9YPFId6MrKWsrvNfWhItThDW9S
	gUH1xyZTLEiF4cnuMjuDujTeotlLOW2ZGNjWkrDTfZZwo6j6pHHOq6F5F1dWCXTm9enU0/Rb1Ls
	VVXqH7GqEwQUe0Xhd5ySoqwKAZrxjH3SvuHNxRr82kWTGijEMORqXiCW1I4CgIgvu6/XPl7QncF
	6p8EbDm4gfVikHWEU6ZvIjnHDAcAWy2zBvA==
X-Received: by 2002:a05:600c:a00d:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483051478fbmr37344315e9.12.1770112832321;
        Tue, 03 Feb 2026 02:00:32 -0800 (PST)
X-Received: by 2002:a05:600c:a00d:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483051478fbmr37343845e9.12.1770112831768;
        Tue, 03 Feb 2026 02:00:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830515381esm55676745e9.11.2026.02.03.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:00:31 -0800 (PST)
Date: Tue, 3 Feb 2026 05:00:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260203045942-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: FUGQzRxeL1_XbKmDomQqTEwYsjzJ7TnJ3XzaLxR9z6k_1770112833
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


I think this needs an ifdef, otherwise gcc will warn about
an unused static function.

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

