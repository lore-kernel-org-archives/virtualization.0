Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE1229B12
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466470; cv=none; b=LDTytp21aT27oSa3UYUhEiJ0cKAIPcTgtU5V48yULaElXssvOPY/x5rg1SuHlpbJ5kqgc3hRB3vRcVx785JXkLlE1okV8fZwQ1qPwcq4+I2TjM/g0i4f+HKE6pyVqhJU7Q6SJk2dFg27yQhO/SY7lu1rXfksAduSrbnr07XAvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466470; c=relaxed/simple;
	bh=+wzBuN4KidO8MO6orQXf7y66N/RZ6NStFOIpjiDyUyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bdKoTnQB89h4ePaNMCvM3GdYDjv2QzRDJcSq8whZQq5e4qUbKQt6LPm4lXLagykeA/r9fN7ivgruukN1S6slde2Tfi32Cz44HYZnIbTt3lP1x8AKHpie47gj0DYO3B9ziIwemA4sSZreIi1HG3zRJpjn2DbPDirjDjrqe5PA+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doNYV3CS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doNYV3CS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768466468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGq0ojxFgIbcUhxRFKzME0p+XYpvzFHdQrjvntUvkPI=;
	b=doNYV3CStB36AQVxydCMY3Ltvr/EQX0C2V/y9J45rwcX6XPHAHdetULjSiEZXvlvPWnmWw
	5nr1l4RD7qkXu62vj6WV6mTAooQz8TVSG75SoGhhsyXLobdl44LjwGWPSF1drIT+kTpp2t
	fB3nYU/ZfszRrX5T+Rm5G6vw2S8Wbl8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-K6BRYJbaMRiL3n94Me7NGQ-1; Thu, 15 Jan 2026 03:40:59 -0500
X-MC-Unique: K6BRYJbaMRiL3n94Me7NGQ-1
X-Mimecast-MFC-AGG-ID: K6BRYJbaMRiL3n94Me7NGQ_1768466459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso3821615e9.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466458; x=1769071258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGq0ojxFgIbcUhxRFKzME0p+XYpvzFHdQrjvntUvkPI=;
        b=qv8YdXSWBcFZ0OydoSVGGLbL0t1MFI+iTzG+eku91e2laA54pT9mMNnucjW5bpLFNc
         WzPnv/vdk4572KsbGU6mAgC/H7AxCGdycIetUe2VzF1lnr9iqZ9mf643cEom9OyCeA3x
         bGU57lWOPQx5NNXD+p+VB6pynhS3L+n9rfeGF9O3XmgvQuGoXEo42wsEmPq1aaTU7nZM
         RHK2QYGvNh2yYGlt1vbwIlc2z6FHnjs3V+TMKXHRJuuxpkTqKwJ5CtJjI47bw4w+XA0G
         1Fz6PSQg9MEyuK36fN/2l/bfkIxYHMxa/njKSLtteAp8fBvajJpcoPAI3lPgBk0B2jFw
         pFuA==
X-Forwarded-Encrypted: i=1; AJvYcCWR+U5F2n4y7QYtcVdSyAc79oLlq6vzKtyX/kGBjDISMbeiBjChycr6GHfw/nTISDxCZWYTQnzQEx4erzkoaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPu2c86Yhb1XtYJoaNg5OHREeJfTOzUKDn7r8sJIAncRlPYh1P
	l7sbmH8fulYdY7/SHRTxcrOLODqoKbRiJ3G2q8Lv52zldl71YoVsVcPM1Ddb0sXTKzderHlFZtZ
	Cl5fBxS3y6GEemSWcjATxijBZPWefbC+JDT2Jcnc1qCxzgrR2CSHKpRnf/8jHEO20iU3p
X-Gm-Gg: AY/fxX6CFrMwvfEFWY9/Z6wp3gzVPeAwzwYFJ23Jhb1qAvl854HmNFmesQV/k5h3QT+
	irTvKoHn8px9fjXlOv4ClZngr8SbLyUQmjmpwT5QDGHJBClkjlZC7q5JeFzH9r3OKJrGJ1i2uRf
	X9Cpyppq5C4+uz+KoQOAtFQaOwPipVTHSEcLp/rO23q56awsAysYFuTwMwq+s1OoWpSCaE/2wse
	i4wPDGfqcn8qlltgOUwzpp/1g/INhLDsy/HBEuE2En0/MLyIP2j7bo8GIELvnEnfpTv+QhKZu19
	UI6S/ESTbHvn1eJk85hr7fxRGka+8fHlZ+ncZ52FqzHTc2YSmbVRY3TPj9RrygH1aRNYL+/hlJP
	vgWA0VQSQj5HUWltRSVIJ4JXXX/aBMw==
X-Received: by 2002:a05:600c:c4a1:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-47ee3342eabmr59984355e9.10.1768466458534;
        Thu, 15 Jan 2026 00:40:58 -0800 (PST)
X-Received: by 2002:a05:600c:c4a1:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-47ee3342eabmr59984115e9.10.1768466458063;
        Thu, 15 Jan 2026 00:40:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm34468375e9.9.2026.01.15.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:40:57 -0800 (PST)
Date: Thu, 15 Jan 2026 03:40:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
Message-ID: <20260115033239-mutt-send-email-mst@kernel.org>
References: <20260114184839.926884-1-eperezma@redhat.com>
 <20260114184839.926884-14-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260114184839.926884-14-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJgEbXfz8__Jhw38xxnL0I70WJzilUtpuH81QX2D8PQ_1768466459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 14, 2026 at 07:48:39PM +0100, Eugenio Pérez wrote:
> Address Space IDs allows the VDUSE framework to support devices able to
> expose different virtqueues to different part of the drivers.  For
> example, to let QEMU handle the net device control virtqueue, so QEMU
> always knows the state of the device like mac address or number of
> queues enabled, while leaving the dataplane passtrhough to the guest

passthrough

> intact.  This enables live migration.
> 
> Expands the VDUSE documentation to explain how to use the new ioctls or
> the new struct members of old ioctls.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v12: New in V12. Requested by Jason.
> ---
>  Documentation/userspace-api/vduse.rst | 49 +++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..66110d918815 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -230,4 +230,53 @@ able to start the dataplane processing as follows:
>  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_IRQ ioctl
>     after the used ring is filled.
>  
> +Enabling ASID (API version 1)
> +------------------------------
> +
> +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> +version 1. Setup it

Set it up

> with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/control` and
> +pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> +ioctl(VDUSE_CREATE_DEV).
> +
> +Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO) to
> +select the address space of the IOTLB you are queryng.

querying

> Similarly, you can use
> +ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an IOVA
> +region of an specific ASID. Example usage:

a specific

> +
> +.. code-block:: c
> +
> +	static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
> +	                        uint64_t *len)
> +	{
> +		int fd;
> +		void *addr;
> +		size_t size;
> +		struct vduse_iotlb_entry_v2 entry = { 0 };
> +
> +		entry.v1.start = iova;
> +		entry.v1.last = iova;
> +		entry.asid = asid;
> +
> +		fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> +		if (fd < 0)
> +			return NULL;
> +
> +		size = entry.v1.last - entry.v1.start + 1;
> +		*len = entry.v1.last - iova + 1;
> +		addr = mmap(0, size, perm_to_prot(entry.v1.perm), MAP_SHARED,
> +			    fd, entry.v1.offset);
> +		close(fd);
> +		if (addr == MAP_FAILED)
> +			return NULL;
> +
> +		/*
> +		 * Using some data structures such as linked list to store
> +		 * the iotlb mapping. The munmap(2) should be called for the
> +		 * cached mapping when the corresponding VDUSE_UPDATE_IOTLB
> +		 * message is received or the device is reset.
> +		 */
> +
> +		return addr + iova - entry.start;
> +	}
> +
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> -- 
> 2.52.0

