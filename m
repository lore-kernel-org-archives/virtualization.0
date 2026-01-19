Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499B2DCF4C
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807038; cv=none; b=Tcs08CSEU3Abg4ogV0Pu0fXVsVXB/1NVb53TOtVKKezFnMp7HvZ4UhBdn0Svf5mBJO02HqQ6/r2GjPkPKB3cfwT8Uc9bDTsdRcQaNLqTotAD320vYC5Q9JtH8O4a3+M83ryRKvUxjCvmcKkXdSlLTT2EaLXBaDYEF+e6cw29DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807038; c=relaxed/simple;
	bh=4aVwbNFEj84uouaiblzzYxz3t1d5BLTI4cjDThhV7IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV1nT/UUIt7+8T37YJxAB4oYER0pY/IsY+oSMlz/NNJ/yOu8bJCtWkjA0604XxepKBMLFaOLJD1GsPVQUWN0FEzsjr/Wk4OO4idSV2kfOy2q/FTF8YgDeo18qRiJrs+PRz5S2duKcdKpXxbgC9UW9ysde3YS1Vhii6LgCO+QRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtbX1ZAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtbX1ZAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768807034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mawL27YtUZYpNyqV94/El0+rm+teg/ed9gch5C6TJ8=;
	b=KtbX1ZAc91s3wfqLyGiiUw1Lf59P+EmiLS5BR5N9BJr9tSFwrn2UXxGBzXNIwCsbvFj58f
	m+AGb91ZTd3Bb/nA49AlhUV5NDBJZ74uXrixTXddl5UY5io3HE6MMdOSP33sTsPEaMY+1P
	R2wbr6WfTVLWpU2h+GjQRIbd2sW+WK0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-aifD5E-5MYG3_wMFrG0bfQ-1; Mon, 19 Jan 2026 02:17:11 -0500
X-MC-Unique: aifD5E-5MYG3_wMFrG0bfQ-1
X-Mimecast-MFC-AGG-ID: aifD5E-5MYG3_wMFrG0bfQ_1768807030
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so3417228a91.0
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 23:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768807030; x=1769411830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mawL27YtUZYpNyqV94/El0+rm+teg/ed9gch5C6TJ8=;
        b=gwZWjpEVfYXUSAnhxbXsikPlngrtcunpbZDnFLutpjOcNB5aUVT7KB3eBymDfX0mCK
         BchX5epaL/6OrktSQCtG/XIjaehKTHAK3fnLBjtUkfI7kpHpgVMBB0cNkE9q0pKRZlpw
         ykd19b/tBIGSz4Pi3vhnIZuSJMxsNNV5L9vIZOoMil99qRCkVE6um0s3RetbhleJfNm6
         Km4Say1oyzwHxicgSVlFqy5M3gsUEXbE6PgVu5KxU4q9/elApXFMhaPk3ox7RW48vP2R
         cGasq3Y4Sxdn63swOsM5+WF9HSopiWtebH3Q9zSAmrVNCchjv8t/lVpPpdmEn784AZxN
         IvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7zkIYCUMEJGx8AzuscAwBoAerpy24Ry6l4i1ZYt7XViQRZhAzv35oaWIr7qGgZk3CZO7DUyLPs49pvcsXiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy02gUDWPFRjnqf9XpKoZSCPN5Dq+12nu1kLaeTFafVPmEOb4uz
	ZI4enPIb954C5d+IWeenIwJWNxrJjxuxwlJtLcHxHHSwDXDSuoB5HCIVbAStari2uOO/lfqACUb
	Tzrsz69TpPGP6t2x8lKlnGaXPMo6y08g10RObH36wAh5/GOeQcUuc5YnRQOn+ZvTkW2dzOHuvqF
	7aWkCAXmJiYygbqVJd1JzwbeQ154YrQS9LmXhnP+BoLhU=
X-Gm-Gg: AZuq6aLbT8E/AtquOjSveU1ScLBhsjXuo4MDphy7QTOEOIetRy2aYbUUVIVP9btGkxc
	7CE0EMetmol8SQi6YKhVj6smF6vMxU9S7Pu1wH3RmHD/huwQ9aG0/aAhDig20HP9+NjB2AjfEAW
	MRcmfaaUn7ZCHfs8k2oOZqXO8Df/T9VG9rogOuz4rXwWRjUTEKXdFe7i6MdcA3OTYepEg=
X-Received: by 2002:a17:90b:2d10:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-35272ec4bc5mr6798911a91.5.1768807030181;
        Sun, 18 Jan 2026 23:17:10 -0800 (PST)
X-Received: by 2002:a17:90b:2d10:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-35272ec4bc5mr6798899a91.5.1768807029738; Sun, 18 Jan 2026
 23:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-12-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 15:16:57 +0800
X-Gm-Features: AZwV_QilqeigojR3LgkW0tH4gY2wiKECiXWYAr76DsUtRJkhbU_laDbTYIl9qcA
Message-ID: <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DH4QKehisBJNE2u4idR8QpC_pWYliCFg6FyEGPv55zE_1768807030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> The vq group to ASID association is protected by a rwlock now.  But the
> mutex domain_lock keeps protecting the domains of all ASIDs, as some
> operations like the one related with the bounce buffer size still
> requires to lock all the ASIDs.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> ---
> Future improvements can include performance optimizations on top like
> ore to RCU or thread synchronized atomics, or hardening by tracking ASID
> or ASID hashes on unused bits of the DMA address.
>
> Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> one of them modifies the vq group 0 ASID and the other one map and unmap
> memory continuously.  After a while, the two threads stop and the usual
> work continues.  Test with version 0, version 1 with the old ioctl, and
> version 1 with the new ioctl.
>
> Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A few
> workaround were needed in some parts:
> * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
>   the enable message to the userland device.  This will be solved in the
>   future.
> * Share the suspended state between all vhost devices in QEMU:
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
> * Implement a fake VDUSE suspend vdpa operation callback that always
>   returns true in the kernel.  DPDK suspend the device at the first
>   GET_VRING_BASE.
> * Remove the CVQ blocker in ASID.
>
> The driver vhost_vdpa was also tested with version 0, version 1 with the
> old ioctl, version 1 with the new ioctl but only one ASID, and version 1
> with many ASID.
>

Looks good overall, but I spot a small issue:

int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
                                       struct page **pages, int count)
{
        struct vduse_bounce_map *map, *head_map;
        ...

        /* Now we don't support partial mapping */
        if (count !=3D (domain->bounce_size >> PAGE_SHIFT))
                return -EINVAL;

Here we still use domain->bounce_size even if we support multiple as,
this conflicts with the case without userspace memory.

Thanks

