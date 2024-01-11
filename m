Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3F23AD
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHaqON7U"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAC02614BD
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 02:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAC02614BD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHaqON7U
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZoo0yqO11CK
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 02:55:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B76561431
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 02:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B76561431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704941737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9j8eMpUTHCJ1mO7p36IGUmNwnqk3Axv6bQ9HcFkssI=;
	b=gHaqON7UMUF1AE5fDvwjNeiradmfCEkaZsLUEJcRce6BmZ3ljRqLU/AJxEYXCYlIMJURcg
	rM8YuZ+Cl0BAh3VaWLuqclAIhbihahejhpMP/Y3qEcSZAFqIPINVzhKAWcR2YA3nb5fXNb
	65h2UzHHOBLtTOAk2ZgrQSQhNIqwyto=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Ma-938XtPZWR3ECLeh0-1A-1; Wed, 10 Jan 2024 21:55:35 -0500
X-MC-Unique: Ma-938XtPZWR3ECLeh0-1A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bb87fc010fso5938503b6e.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 18:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941734; x=1705546534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9j8eMpUTHCJ1mO7p36IGUmNwnqk3Axv6bQ9HcFkssI=;
        b=VX+LToCes+eulTcFp+t6J7/OlFk4mh1+NXsXFwerfjGGSY68yCaUit41Ch+T7hZ8S0
         mIt1EyLb70TZQ2arioufTeDkiZqzQGirWDImWuFjP2JRUyfMKHqHmKjfjrZ2sTDiAl7r
         3TZx9ELrvvOszd0qXOnuXAXQU/1mr/4mzQPZ9uB0rduOrsWPHrwfRpdd3DMnfTrFf8cY
         pAk523/n00tx/1fgqd8NL6XbMJHm+RIwQdezmfgPESh36RXrzULcXVXKqD+wV5/YhIZo
         kAqNOSbxuz79pk+kt/3zFeSEEs3Sgg0KgLkmifM3MOECtAetUYWOvFO22c75khQnpEuh
         GoMw==
X-Gm-Message-State: AOJu0YzdgRioqEKL5+F4aXWPizaxHSvMok+CvqVHJrPDTAS6vP3TT7os
	xhNOhFAPoRoLhcK/jBOxRwCbMwLnvFfVQf7MbRe4iXqpJ7rcUpw6nQ4vfcpkU8DBcNXrKkDZTGQ
	kNnFIlgRPG1UCUzLEq/SoFmHNNf/StDWi8OfoGBRQRMUqN7fo2jdjBkGdA3ElbJTjoQ==
X-Received: by 2002:aca:1917:0:b0:3bb:bc99:97ea with SMTP id l23-20020aca1917000000b003bbbc9997eamr539518oii.113.1704941734408;
        Wed, 10 Jan 2024 18:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrvL5aN1oMY/xsWTuvDAwaYkeqoFoVu5BHvIE9XcjlsRb3VpFbSQsl3zMzrvJV2ZKCUCflaj93XQntprMwaYI=
X-Received: by 2002:aca:1917:0:b0:3bb:bc99:97ea with SMTP id
 l23-20020aca1917000000b003bbbc9997eamr539508oii.113.1704941734197; Wed, 10
 Jan 2024 18:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 10:55:23 +0800
Message-ID: <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com>
Subject: Re: [RFC V1 00/13] vdpa live update
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Live update is a technique wherein an application saves its state, exec's
> to an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
>
> Define and implement interfaces that allow vdpa devices to be preserved
> across fork or exec, to support live update for applications such as qemu=
.
> The device must be suspended during the update, but its dma mappings are
> preserved, so the suspension is brief.
>
> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> accounting from one process to another.
>
> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> VHOST_NEW_OWNER is supported.
>
> The VHOST_IOTLB_REMAP message type updates a dma mapping with its userlan=
d
> address in the new process.
>
> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> require it, because the userland address of each dma mapping is discarded
> after being translated to a physical address.
>
> Here is a pseudo-code sequence for performing live update, based on
> suspend + reset because resume is not yet available.  The vdpa device
> descriptor, fd, remains open across the exec.
>
>   ioctl(fd, VHOST_VDPA_SUSPEND)
>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>   exec

Is there a userspace implementation as a reference?

>
>   ioctl(fd, VHOST_NEW_OWNER)
>
>   issue ioctls to re-create vrings
>
>   if VHOST_BACKEND_F_IOTLB_REMAP
>       foreach dma mapping
>           write(fd, {VHOST_IOTLB_REMAP, new_addr})

I think I need to understand the advantages of this approach. For
example, why it is better than

ioctl(VHOST_RESET_OWNER)
exec

ioctl(VHOST_SET_OWNER)

for each dma mapping
     ioctl(VHOST_IOTLB_UPDATE)

Thanks

>
>   ioctl(fd, VHOST_VDPA_SET_STATUS,
>             ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
>
>
> Steve Sistare (13):
>   vhost-vdpa: count pinned memory
>   vhost-vdpa: pass mm to bind
>   vhost-vdpa: VHOST_NEW_OWNER
>   vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>   vhost-vdpa: VHOST_IOTLB_REMAP
>   vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>   vhost-vdpa: flush workers on suspend
>   vduse: flush workers on suspend
>   vdpa_sim: reset must not run
>   vdpa_sim: flush workers on suspend
>   vdpa/mlx5: new owner capability
>   vdpa_sim: new owner capability
>   vduse: new owner capability
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |   3 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   |  24 ++++++-
>  drivers/vdpa/vdpa_user/vduse_dev.c |  32 +++++++++
>  drivers/vhost/vdpa.c               | 101 +++++++++++++++++++++++++++--
>  drivers/vhost/vhost.c              |  15 +++++
>  drivers/vhost/vhost.h              |   1 +
>  include/uapi/linux/vhost.h         |  10 +++
>  include/uapi/linux/vhost_types.h   |  15 ++++-
>  8 files changed, 191 insertions(+), 10 deletions(-)
>
> --
> 2.39.3
>

