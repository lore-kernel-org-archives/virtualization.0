Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B2477E28
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131031; cv=none; b=XS4ogCcprdspWN4P6hFRJYG8pkmh6waSd9hHRbF0vThQry94YG701uUcI49TJVs+YgjeX7G2xvsjkpEZEeZ01UzR6QWq4QVluw5jKQEpzblaWn4nr5gf9F89fcyqaLRoXGi7s8E+QqGttn2h6KgAmsRVta1OsgS+LS4aReFbNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131031; c=relaxed/simple;
	bh=uv/zLXnCvLIlm5SSXwTVSkUYz8GZAW9tYkJKFd4w0vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xd3/mr4B7QAH6fj5RReMHqvF7/DFdGs9ykn2lmYYjZzVhQs/RfCNX8HU4fBPYrygS9jGaft3JsDuM3a/uFc1Bwvg0r4IfF9adFn5D//3uSbS5ow4Bwm4SF1q0lzL2y27hv5dvpXdzOCM5HlKugv7wxiiu32/OiX2HMa+39RIxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHMTQM0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHMTQM0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784131029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QucJ8nQZseawvH/pWqtNGkyG0ZJfjIBnQLKskMGohYU=;
	b=VHMTQM0W6R1WvgE4ZkB7/IDtR3r1iBMLizrNmqxUV3r9Hi31b+7T08phIKMNnYt5wKnn4u
	1BEWtlxR/c76kL8pX9kqWy5SOAiaEvD5EpiQrPnaSEdrIuSE3jEjbIXmgg2H5aOUgr/QsL
	0X3yanO9ElOMm0IFlDz6TKSl6g/Rb18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-grEO56rWO6-YG7N8i56RuA-1; Wed, 15 Jul 2026 11:57:07 -0400
X-MC-Unique: grEO56rWO6-YG7N8i56RuA-1
X-Mimecast-MFC-AGG-ID: grEO56rWO6-YG7N8i56RuA_1784131026
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493e9ea2c77so46527565e9.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131026; x=1784735826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QucJ8nQZseawvH/pWqtNGkyG0ZJfjIBnQLKskMGohYU=;
        b=m0FFOrDA9UVosB/UEUu20CotjmL1NAG/2ZT6Qq+C0JMOloWLill6+uklwUNhyPtjbt
         N3N7i+AHp/PeQ35JiAPdMc2IyuOfVOHe27QM4glQtAu8gvmfSEhLv8R8Q3dr7mTmSsnZ
         tcagzrNmU41tssCIWJ0zPodQKSey9eHRYktIuOQvR0HBh/0zZu94luWyN62HMghZrq3v
         s+vG1+f3LcRb3Qibi8l5qvoqPPHbDB0+9bBuGFcWf7PhzRdbn4ck5a+MzbigXPF/JKiS
         WZdYeI424Vr+prR6tgvoPzIS5hDaUyW204NQMOIkYJJ3HuAALDOiXNBaJzsh5WfRujPT
         Lv8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rod3j0pDsgr33jJgoCv9Jke17ID8FBkU0gEYGQeaO/TIkFM/REd0xnlxBVAwMehWNHweY6Ni/+0G73MmUtzoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR8GTum58LKf0MePANekbIoeXlkhsXrcu8fxQ9NyLE2arx9qWX
	1An9e8FIVEbZ3L2QsItUmKwxUOLTOZcdPG6CjCe3cVxLLJpHdujDEb7YpJomgBmzvprOEPmoQFE
	9LnjS+3l3Cjxy+h4Y71m7ccElhMEd9ugGYZeVTbpvXiEkch0i7UI+bE2MZ+Bo6CuY5dp+
X-Gm-Gg: AfdE7clWnWg58wB6dZDgFoxsaz4DQUjhQOXzsvhp/lCLxqVaduSebNzKKAwrb/xv3Fl
	eUSJ0n9CrylYkfATzvFhtf8W9LZ+zOvPrQt0yjEDeBK0dCrJtbQ5niVSVFmuy+apoF5jXcYTNun
	bp8s/3E9WnUirqGpuAV7RttrlMq43FNO5PunqBpsBP6n7XuEOfyb4eJts/MvoZfFM5ukTCMlOPn
	G3Bpc4hnQDPmIkUqb4Iy/8drwM/DIbmvqENUCk5mYX2daif25XY2v0I9E25gaVPoYHThZMpMjdM
	+a7B5wl76OGUMr27Www44HDNJ8N8gvcADC0vexCX7mx7kR4mSOuNWqugJ+LFLtHGGYrN37nRarX
	OweolijijAsEMeSIsBtqVhYkxzXoGKoURA3k=
X-Received: by 2002:a05:600c:4e93:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4953c286bbemr40012455e9.26.1784131026027;
        Wed, 15 Jul 2026 08:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e93:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4953c286bbemr40012045e9.26.1784131025583;
        Wed, 15 Jul 2026 08:57:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508731fcdsm140971355e9.4.2026.07.15.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:57:05 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:57:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260715115206-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-2-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260715142337.22811-2-harimishal1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KqtzJgVo7HUJn0P2i3W2BFvIJefsTPGj7-Yr0Wg52YE_1784131026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 04:22:40PM +0200, Hari Mishal wrote:
> The device_block_size read from the virtio-mem config space is used
> as a divisor and also in ALIGN_DOWN() further down the code path in
> the driver without further validation. A zero value leads to a division
> by zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
> arithmetic leading to a misreporting of guest usable guest ram, post
> crash. Reject both at init time instead of trusting the device.
> 
> Assisted-by: gkh_clanker:t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/virtio/virtio_mem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 11c441501582..43d12ec7c323 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2847,6 +2847,13 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  			&vm->plugged_size);
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
>  			&vm->device_block_size);
> +	if (!vm->device_block_size ||
> +	    !is_power_of_2(vm->device_block_size)) {

0 is not a power of 2, why do we need to check twice?

> +		dev_err(&vm->vdev->dev,
> +			"invalid device block size: 0x%llx\n",
> +			(unsigned long long)vm->device_block_size);
> +		return -EINVAL;
> +	}
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
>  			&node_id);
>  	vm->nid = virtio_mem_translate_node_id(vm, node_id);
> -- 
> 2.43.0

