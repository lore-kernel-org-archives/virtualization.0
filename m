Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06352E2850
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807184; cv=none; b=OO/c0DGH2B8ndaecNFJVk1YGwTSwEnFDjghmx5JLVsJhgL/Ntk6C5z09tLGrRwJ+wGKoIUSxp6r5J4XMj6XXA91OXrS6Vmw6tuibE2XLHM+NylgQ7Qy9U3NfleU9F0QBJ0w6YjKCYNUEzOFYB3+9m5qDqjyVC58eYGKYWsksLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807184; c=relaxed/simple;
	bh=I5TZloe0N16Lc+9VCKoUntlUMnyLT53HOU0KQ8RVaf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dphaB1IcRRPxi99XUVpvTYyZQSSJzdglciY/jMYdXl4mVCKrg41UADIitkWQ9mSp9rbaa+xpFpHyZsB/cT3/ml9zc4Q1GVblsevEpi2GQJvGbldso2QYExqbemH4ynVnckdFrDXICBqV9OpJy3xxxjxDbOoR5USYARUgJD7jWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqWYivxT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqWYivxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768807181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4cP3yIdC/twLcxJsJjH7z0Y1r+y1tyw34vOeh6aiQ4=;
	b=CqWYivxT8RrlDr6O/l3zHuaCKUQTe4/U3XGl2NJWoFQDg33UyE8Mi25qU28RlKgBFqCOhm
	CkPv0vfzQN6gguG+fRdnByu5afmARxhCrXasUj1EdD+6qBkYk4Go1OFD5nMCa8DBihf0nB
	rL0yBJaR6tqvjcuib6qgRXx1z5LJIR0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-WfIHUo-gNGC-kf1EqH_W7g-1; Mon, 19 Jan 2026 02:19:40 -0500
X-MC-Unique: WfIHUo-gNGC-kf1EqH_W7g-1
X-Mimecast-MFC-AGG-ID: WfIHUo-gNGC-kf1EqH_W7g_1768807179
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso3945982a91.3
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 23:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768807179; x=1769411979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g4cP3yIdC/twLcxJsJjH7z0Y1r+y1tyw34vOeh6aiQ4=;
        b=Xc+HQik5yIv2GmYJhZuKwJRILu2dFxKHLIQNIROVzE39dUlhwFbdpvM0cNSrN/soL2
         8OBzSTsdM9+8CLRfxWvIw4sOql50So9s71K8jAAPsUKl6OueaDDjZpBKUI8jLeNIaD8j
         3tIbjteS9yDQ9BqqveYr691OVKa/hFT/7K7QWwr2lSCPgRbkjw/XBJK4+VEIOi8JZLo+
         iSW2oS5vWhJG9qbNPsbYRC3lRc1ugFwOPt+b4TFBGmP7e6nQwAsw6nTmAR0exhLVgRz4
         svF5DLv/9+BPAnZ8jWeeJMhv29O9hfROMOCcbGNGinYqy7+ImU89HlbZRhZiRTW3rwsu
         gfTA==
X-Forwarded-Encrypted: i=1; AJvYcCWbScDvQBbC2TlPL12QoDnDsnFzV3kywIyDTyOT9u0Y3yrjfunw8NVyAA9T3YrMClm4lxVe1MHg3F+s6tVnPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPk/A20bp4r2oJrCKT6EV/r4DAm5tNB1J+SqAJUR8ah3IVQgD3
	1q5R51YjEJxxytyTnG7uf+qeW+gKY1nzjP7UyA55UV1v5R3k1EoIyETc/WesAqBGjERkyJjsS3e
	VA/mIWjUFsTx1lR0VwNqRkAKeDfYQJl5CA2BJuYw8++fYJcsCU4VE6A+fShs3krBfVtqrpuN8dv
	IwxHQCkxlXDmqrCXwnmqyYNVTcrXj5T49pqB2iKuv86ow=
X-Gm-Gg: AZuq6aKFU8kCVf9MIuuhHsofuk9+nXp0A9KzGkov0syt04ybfyHikjt1TbxOXu65k4P
	eewSKp37+sWJlce2JHUvZNyfevWB7ldU/LWCyEST5wS+/WSDKJhwt7/uyCjEIXN3IpT2l5kZzYw
	sbrY0gy7KbFtoLSO5gokXfhq1xTHbcU7Cp0qlY9JykTYv0Kf+9c/Pi1OMhgaGOHZXBPgU=
X-Received: by 2002:a17:90b:278f:b0:34c:c50e:9b80 with SMTP id 98e67ed59e1d1-35272fbdde7mr8091457a91.27.1768807178912;
        Sun, 18 Jan 2026 23:19:38 -0800 (PST)
X-Received: by 2002:a17:90b:278f:b0:34c:c50e:9b80 with SMTP id
 98e67ed59e1d1-35272fbdde7mr8091445a91.27.1768807178530; Sun, 18 Jan 2026
 23:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-14-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 15:19:26 +0800
X-Gm-Features: AZwV_QgQYRKacI2exBc_91r4a7t3-0jyQ1ceao6xamRP07kR8abzxsyGBt-gCjk
Message-ID: <CACGkMEthnMXVYDEO+=XPumyWf9abN8bCLVQ42emYOWZQuDLG-w@mail.gmail.com>
Subject: Re: [PATCH v14 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Utxd1qXN0RMFtFLSNRnwN0C_j5VleIsN2YKgTTraP9U_1768807179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Address Space IDs allows the VDUSE framework to support devices able to
> expose different virtqueues to different part of the drivers.  For
> example, to let QEMU handle the net device control virtqueue, so QEMU
> always knows the state of the device like mac address or number of
> queues enabled, while leaving the dataplane passthrough to the guest
> intact.  This enables live migration.
>
> Expands the VDUSE documentation to explain how to use the new ioctls or
> the new struct members of old ioctls.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v13:
> * Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/.
> * Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
> * Fix typos (MST and Jason).
>
> v12: New in V12. Requested by Jason.
> ---
>  Documentation/userspace-api/vduse.rst | 53 +++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..aa067da92cf5 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -230,4 +230,57 @@ able to start the dataplane processing as follows:
>  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_I=
RQ ioctl
>     after the used ring is filled.
>
> +Enabling ASID (API version 1)
> +------------------------------
> +
> +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> +version 1. Set it up with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/co=
ntrol`
> +and pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> +ioctl(VDUSE_CREATE_DEV).
> +
> +Afterwards, you can use the member asid of ioctl(VDUSE_VQ_SETUP) argumen=
t to
> +select the address space of the IOTLB you are querying.  The driver coul=
d
> +change the address space of any virtqueue group by using the
> +VDUSE_SET_VQ_GROUP_ASID VDUSE message type, and the VDUSE instance needs=
 to
> +reply with VDUSE_REQ_RESULT_OK if it was possible to change it.

Nitpick: Is this better to move this to the part of

"There are now three types of messages introduced by VDUSE framework:"

?

> +
> +Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file des=
criptor
> +describing an IOVA region of a specific ASID. Example usage:
> +
> +.. code-block:: c
> +
> +       static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
> +                               uint64_t *len)
> +       {
> +               int fd;
> +               void *addr;
> +               size_t size;
> +               struct vduse_iotlb_entry_v2 entry =3D { 0 };
> +
> +               entry.v1.start =3D iova;
> +               entry.v1.last =3D iova;
> +               entry.asid =3D asid;
> +
> +               fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> +               if (fd < 0)
> +                       return NULL;
> +
> +               size =3D entry.v1.last - entry.v1.start + 1;
> +               *len =3D entry.v1.last - iova + 1;
> +               addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), MAP_S=
HARED,
> +                           fd, entry.v1.offset);
> +               close(fd);
> +               if (addr =3D=3D MAP_FAILED)
> +                       return NULL;
> +
> +               /*
> +                * Using some data structures such as linked list to stor=
e
> +                * the iotlb mapping. The munmap(2) should be called for =
the
> +                * cached mapping when the corresponding VDUSE_UPDATE_IOT=
LB
> +                * message is received or the device is reset.
> +                */
> +
> +               return addr + iova - entry.start;
> +       }
> +
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> --
> 2.52.0
>

Thanks

