Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E92313526
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114165; cv=none; b=gYQAfB3T5MEE7AVuO64GnFmcg0gu4TCabH3ACmUG3WTDefRnvxVUxXtDnKcKKTc/lZ45ZFN5pF9ZAnRCVdjHQA98mEN3yZf0NEgK4nnXxowPqq3Ph1eujrnxIvZHZYSVDBjNfHPNV5eu4Ud8H+j87/i8a5Znn7rUEw6o0hejSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114165; c=relaxed/simple;
	bh=prmaXrFKwwio+mOGSzr/9ol8L22BVJeYEEhmds/TAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i8Rbk9iXzE82f9e6hZ8MTQsH3xSMwK3Jhvv8Kiy9fs1fEg/XwSbh8qqvZQAkJBYXNPYdya6Y4ZinMf2R52EzJS81OgaAOa6JKreeBnJ+NF3TOk3fCBb4W4oAeLLOlqWUIvha3Kt94pgfD/1Dst0S+2qrxD0VmyQMoW/Jfjj9kHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrxbbFxn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrxbbFxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xh/UmK3MDA/v1xjO80i0eilp6Lnmx07hLEk6LbEtMTs=;
	b=NrxbbFxniphE3nH+yoxdjG3vTvMfv7ntY7FdMUxPnhcsNas2GsiBNo0Ng20S+2kl5XqIXS
	hqnlMkZroRrj2GsvdvWo2/StdyyZF7OrTtmaHjaqvGiWJvK+KtnUUSZ/vZlKnHbVD7eJvZ
	9xKunhTTk2py1egalowjhGyKVwggRvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-kHM-pik3NfGGVsBAf_iMMA-1; Tue, 03 Feb 2026 05:22:41 -0500
X-MC-Unique: kHM-pik3NfGGVsBAf_iMMA-1
X-Mimecast-MFC-AGG-ID: kHM-pik3NfGGVsBAf_iMMA_1770114160
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435db9425ebso5304273f8f.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114160; x=1770718960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh/UmK3MDA/v1xjO80i0eilp6Lnmx07hLEk6LbEtMTs=;
        b=kaxMKxJOWLUEWgRO+DJmNR+zr1LrYIKH58+TishjBzrWsXLu7Gcn3ah6PnHYaR3xAg
         1ikbNml8dUBKvmqsh0I1Du/1jnKqKB5sm6MqTnomtInF2Q7PS/ss7M/w1O3NvU0gulAr
         dRn6NnGwgwxy/ynDnHQ+7jLw/2GJtXDk6rkntBy9p/d5Tbj3Ag6X1YQJGiBe9q9GFuAJ
         9i3u9KBQOws5N9N2jwsCYgY6he7+l7IB8/cCvqvkSZnn64nWT3iObQCa8BMYWfiJQm6e
         4GFn/CPvckqEyggYYwmCfaaCifzAIonmPBvimd6OzicD3uRp1KLA/sF4M7DKhvky1P/Q
         I2uA==
X-Forwarded-Encrypted: i=1; AJvYcCWsN4djBTweAhnGB9pQB84VzZv7PR6EO87EvEQMjS4gv0KQcOw48aDH/Z7roAOXPqL/ruKE/8TKpJMfRSLryA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkE9FsSsCcTHVYFyZHXFolywusxNIzdGBjw4dPU2eN5csBHbPf
	GVdoJdhoO1q1zAT65AAqtIX9WIOrPaepUStg1tnHPDVV7ba24nwqfB+oiiSFRWD4whmmRQHNZ6i
	YCVZHOEv+JxdTzCpeRWxpZQFCDEuLBZug+PWui7L8xAeFv0ZQ6+EmOPayYb3KnFqk8hvU
X-Gm-Gg: AZuq6aL0XqHa1rYcF2PH3Wr91NAJP+nPNl/sB/xleCOpHq2CgRs9LKjQflo8hY4kdJE
	suWG4umg3jkxwiqWICB1aPv1g93A4Hl4ZLcohgTFcdVxmo9f+jGzqPRgsAimLu2tQkgjKt9pmkr
	6olfLTQbbmSCaLvup/zY2+s2gi1opd6Z97Pjim50LwcD5NJho6rzzLG/+216yI35dCdGXcFkstx
	EKFJQVB1eKx/l9KWXJDw3H/E+OhyB1dVPSpbBuYplWCOkzEeNVtHj3dY7YpXBKERxbl0/PyxNdb
	oeFjwpaq8MTYg+EeEHaunXueBEQYNMJsfGuidL9G49qWFysDKBkuKdFfE3N9bTpmkrjyWYNNN9l
	nDn41X45O0c6w3GEp5+GYWC2DZwuq22PGhQ==
X-Received: by 2002:a05:6000:40da:b0:435:9bf5:b32c with SMTP id ffacd0b85a97d-435f3ab283amr23460766f8f.29.1770114159582;
        Tue, 03 Feb 2026 02:22:39 -0800 (PST)
X-Received: by 2002:a05:6000:40da:b0:435:9bf5:b32c with SMTP id ffacd0b85a97d-435f3ab283amr23460716f8f.29.1770114159007;
        Tue, 03 Feb 2026 02:22:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ed952sm52718921f8f.10.2026.02.03.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:22:37 -0800 (PST)
Date: Tue, 3 Feb 2026 05:22:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260203050216-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 8sv9LEPppSHfo1PEm5_YNh-EK4xQLV8C085tpoYW_NY_1770114160
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

More importantly, I'm not applying this until it's tested)

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

ifndef CONFIG_COMPAT around the structs will make it clearer
they are only for this purpose.

> + * i386 has different alignment constraints than x86_64,

why i386 specifically? many architectures have CONFIG_COMPAT
and it looks like all of them will have the issue.

> + * so there are only 3 bytes of padding instead of 7.
> + */
> +struct compat_vduse_iotlb_entry {
> +	compat_u64 offset;
> +	compat_u64 start;
> +	compat_u64 last;
> +	__u8 perm;
> +	__u8 padding[__alignof__(compat_u64) - 1];

Was surprised to learn __alignof__ can be used to size
arrays. This is the first use of this capability in the kernel.

I think the point of all this is that compat_vduse_iotlb_entry
will be 4 byte aligned now? Very well. But why do we bother
with specifying the hidden padding? compilers adds exactly
this amount anyway. Just plan compat_u64 will do the trick.

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

it's a global variable? I'm not aware of this trick. What is this doing?

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

Too funky IMHO. Everyone uses ifdef around this, let's do the same.


>  	.llseek		= noop_llseek,
>  };
>  
> -- 
> 2.39.5

