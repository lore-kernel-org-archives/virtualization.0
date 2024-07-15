Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7084C9A
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009690; cv=none; b=fkqw8esRZCiIvbAiuBo8/5HXY9g/6aXcp2VlM8qSaHKjoy/KFB6q8aDq42UWOt1EAN6d1nO4goYwsAnBZH5NpJh/tn6wPAG7NJ+751PvRGHgbCTQ7GFgnMjgxX7ZEVST+Vv/Y/0iRphICbUcsxtPANz7wPHKJ1gMV5CNJrqri7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009690; c=relaxed/simple;
	bh=yowH7QalUapkYgHeZUVZ+f9BegeEJH4ngNknLAglrJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBQwa3POogJEbViL/7SDONXQIZzsQraemgqZcdRKgD7EIxInpIfIH2y9UM+Ivz+xH9AI+TdWxcxYKPJxYVA0GPTu0Saysh13SVI/ezQ1+Nd3j3wdp6qs1aWEbRYWfFWsWoPAHvYp8JlkRtvK5ccs9XozjUIL57rzJWw9/cDL4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoAoFhE0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoAoFhE0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25FE280ED5
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXHWRMu7q7jM for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 02:14:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1D7E780ECF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D7E780ECF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NoAoFhE0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D7E780ECF
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721009686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6J84PcjdhpOh6VF/DDBtLfXI9t3OT/wsOmHTj50YU8=;
	b=NoAoFhE0tTe76pxfCtLd8XHABs9fUGDUHMDTgNQNkQe2Od6NBdrfTxdvfgyLtoOPrR+x3Q
	4rmATZ86hHDUonj2ISGW4dbicYP9QEH3l8GNbWu+8NahObayUNV2bn4Jqi0K8QM+1UwvJC
	9HjwybMPdbXeNa71j4MAtydJ5lH/KiY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-rTcBkRHRO7eEtYvo8zzJmw-1; Sun, 14 Jul 2024 22:14:44 -0400
X-MC-Unique: rTcBkRHRO7eEtYvo8zzJmw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c95c80c6f7so3208410a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 14 Jul 2024 19:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721009683; x=1721614483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6J84PcjdhpOh6VF/DDBtLfXI9t3OT/wsOmHTj50YU8=;
        b=Uo4EqxywZH9s3r4ejU+4NoNVAJ/EkH2953H6ZNuu5Q2I3orgGeD6iY10WNfAPeFadZ
         LhA/a8uD8pCzmEwNO//4oeLT36PfZzq8hlWGSLxnn/wPBlvPUPU11clAS1e2D17AlDoL
         OgStMJNX8n2rREpbR8Y4ym32UYKWmeqEIiOku12/JskdXs1rqMlr/Razj8YnY8elIF2L
         8Ia47ADJW9r9UCwLGIfa5b2J3KwDV55DkX9cDz262lEKpcHEssaayk4gzSFcTjy9/SAr
         Pe710wIUBDyZC1cTLvI+RIozEgRni9ggzhOE43PCssIx+gW7oFxcJYlSFloPIgvGIZ4/
         zZuQ==
X-Gm-Message-State: AOJu0YxrHvsrDmaeDkfNs+Ku1/y3eIA+q31G3AzSVLX7FciIYh55uImZ
	rkHdu80RtzsR9B4HKtSVO7SWUfQb/cd+ecXmTY0L6shZW96TBIAvgjuHiuSAb7NuvMjwQQeZtmn
	8ZVFwgQ52KocmDSBSvv5Ebkxq8VDqbn2sJDc70UYYLHuec0aAeI8gf1UsDPZaSwVa2tPxEb1xKX
	xtB442ihNGxMff5NITHjERpoR9eS3yihCxo8pZ+BGUtM3wpKobzRqm7Q==
X-Received: by 2002:a17:90b:384c:b0:2c9:752d:c007 with SMTP id 98e67ed59e1d1-2ca35c7d124mr12543380a91.29.1721009683261;
        Sun, 14 Jul 2024 19:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGspocBKY5h4Ykba/X8TSphcHRCAowc5kdsJBrllBcK1uqTGlzIbjTzOagJ0s7w0Xxe6h7gxFBSEq/x37ViMVE=
X-Received: by 2002:a17:90b:384c:b0:2c9:752d:c007 with SMTP id
 98e67ed59e1d1-2ca35c7d124mr12543369a91.29.1721009682769; Sun, 14 Jul 2024
 19:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:14:31 +0800
Message-ID: <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Live update is a technique wherein an application saves its state, exec's
> to an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
>
> Define and implement interfaces that allow vdpa devices to be preserved
> across fork or exec, to support live update for applications such as QEMU=
.
> The device must be suspended during the update, but its DMA mappings are
> preserved, so the suspension is brief.
>
> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> accounting from one process to another.
>
> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> VHOST_NEW_OWNER is supported.
>
> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userlan=
d
> address in the new process.
>
> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> require it, because the userland address of each DMA mapping is discarded
> after being translated to a physical address.
>
> Here is a pseudo-code sequence for performing live update, based on
> suspend + reset because resume is not yet widely available.  The vdpa dev=
ice
> descriptor, fd, remains open across the exec.
>
>   ioctl(fd, VHOST_VDPA_SUSPEND)
>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)

I don't understand why we need a reset after suspend, it looks to me
the previous suspend became meaningless.

>   exec
>
>   ioctl(fd, VHOST_NEW_OWNER)
>
>   issue ioctls to re-create vrings
>
>   if VHOST_BACKEND_F_IOTLB_REMAP

So the idea is for a device that is using a virtual address, it
doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?

>       foreach dma mapping
>           write(fd, {VHOST_IOTLB_REMAP, new_addr})
>
>   ioctl(fd, VHOST_VDPA_SET_STATUS,
>             ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)

From API level, this seems to be asymmetric as we have suspending but
not resuming?

>
> This is faster than VHOST_RESET_OWNER + VHOST_SET_OWNER + VHOST_IOTLB_UPD=
ATE,
> as that would would unpin and repin physical pages, which would cost mult=
iple
> seconds for large memories.
>
> This is implemented in QEMU by the patch series "Live update: vdpa"
>   https://lore.kernel.org/qemu-devel/TBD  (reference to be posted shortly=
)
>
> The QEMU implementation leverages the live migration code path, but after
> CPR exec's new QEMU:
>   - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWN=
ER
>   - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of
>     VHOST_IOTLB_UPDATE
>
> Changes in V2:
>   - clean up handling of set_map vs dma_map vs platform iommu in remap
>   - augment and clarify commit messages and comments
>
> Steve Sistare (7):
>   vhost-vdpa: count pinned memory
>   vhost-vdpa: pass mm to bind
>   vhost-vdpa: VHOST_NEW_OWNER
>   vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>   vhost-vdpa: VHOST_IOTLB_REMAP
>   vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>   vdpa/mlx5: new owner capability
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   3 +-
>  drivers/vhost/vdpa.c              | 125 ++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.c             |  15 ++++
>  drivers/vhost/vhost.h             |   1 +
>  include/uapi/linux/vhost.h        |  10 +++
>  include/uapi/linux/vhost_types.h  |  15 +++-
>  6 files changed, 161 insertions(+), 8 deletions(-)
>
> --
> 2.39.3
>

Thanks

