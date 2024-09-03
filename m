Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EA200135
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351057; cv=none; b=s384ZgX1vmlkpNjAjlrdYhnL4IILtFqtJiDWhMYVP0trwhmErO641T4sy4YdgLzUF8ph39YA46fkVVjqh2qvllh8JUqkhkGj5684R73cH7crkc0aqRD/P9tgTP84H4gXV9qjJ/OSgqDKRzcIE5IokWS+ws+ZFom2URZiNNVsnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351057; c=relaxed/simple;
	bh=6mmc7di+pQIdeFxJ+VyEzy/XD6Ldgilncnnc07MXG7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwvvQv5HEtjGEtMajpI1KMJKVb7iZYtamc2F4ZGrE4sUXPmiOwvwB9yroas/+Y8ZX2i3lCFI1DZrvB2OknqW97qM0Rff7T6JTSAS2csLIixx6OHUzaLnd3CcjUCtKRkv4pHw3whQe60+UT8VeGhBIfNsBpf1coUJXgyDdt/3+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM8gowD5; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM8gowD5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0885280C8A
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 08:10:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sgm80ZLSEx-8 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Sep 2024 08:10:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 27B0D80462
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27B0D80462
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UM8gowD5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27B0D80462
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725351052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mmc7di+pQIdeFxJ+VyEzy/XD6Ldgilncnnc07MXG7c=;
	b=UM8gowD5lxh34Frh0bmZbHyzb812gSUAK/UDPfkrhXxlUAwBpdti5cfVUPsDQCMAepTvZC
	OKgnpSuMctMml7PHrC6/nsSlNcnbspEzmlAdOKuCq26vQVIgH+ik4sEbyMCblU6WClZrVO
	4Qs1rmQo8MIw0TuzP6wWMTJUGITqkc8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-6rKlB09LOLazCtEp01njUw-1; Tue, 03 Sep 2024 04:10:48 -0400
X-MC-Unique: 6rKlB09LOLazCtEp01njUw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6d3e062dbeeso55096977b3.0
        for <virtualization@lists.linux-foundation.org>; Tue, 03 Sep 2024 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351048; x=1725955848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mmc7di+pQIdeFxJ+VyEzy/XD6Ldgilncnnc07MXG7c=;
        b=U4xTy6Bz42tF6r0Vi8j+/LkHQuUrw6RBs1FcIuE/oHAdOgAMFeZCaTanfAf+EaRbcr
         qoAJgFcA5fkKAaVCPSnTySuTOFlchdGPRiQ41H62OwKwIgRwnbeTVxGOpXA400f7m62k
         FvnH8AttmN+LwNWtDiOl9fszk7RcESxrhNx1aJY/hFy/MaY6t68SgBxEIcRHqTvVdlBK
         5xZffMAMhstIzy60iv9oPyzqWnU19hZ1uHG5K5/7Mf8KDLnP042TvrfiMICD8kg0FyMa
         fyfpen/va86HEbBINrAVsNMHMnQt14RCfV0efIOnpn8lXltVRub42l6b0NSMKFnR7our
         V84A==
X-Forwarded-Encrypted: i=1; AJvYcCXdJQwvNICvOaJEckUxb3IZSJJezkMYvmCOHjunpVfvOiJBiP3H6DCjn5DaY581aE4zGrd05f9fmBciyvv6rw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzvnFL5QD8sm5gHCZRYk/wboSlcA+MtzGsadFmeu3RRQ4GVRzV9
	rBh/H2hz5OuaJ7jCvmSD0QB3udtwM4x3jzvDafF4o7h19owei3nNhoT5aW+qqV1WIrf9aJBHj8u
	rwP/vBcde4vVdPHzYjL7vxjsWboNjFdqzOz8FKXtxJ/aRAD1X7wAMWTIwLxdL5S/S9K6H1gRMk2
	0DDoRaaHpJI44rKZJ+xi3LbTUiEICWAYlvbpsmLvMhxH01tM2nfXFeAQ==
X-Received: by 2002:a05:690c:6089:b0:65f:cdb7:46a7 with SMTP id 00721157ae682-6d3fb00cd8dmr106367627b3.22.1725351047954;
        Tue, 03 Sep 2024 01:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8YUCke3AcOv2qy5ss1glBiO/5O8+6bG94dYgmaYGhOtdUneJ8MXedoPtfwNtK/AfOFzg2JTuMsyHPl+8F7HI=
X-Received: by 2002:a05:690c:6089:b0:65f:cdb7:46a7 with SMTP id
 00721157ae682-6d3fb00cd8dmr106367467b3.22.1725351047631; Tue, 03 Sep 2024
 01:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <CAJaqyWfwkNUYcMWwG4LthhYEquUYDJPRvHeyh9C_R-ioeFYuXw@mail.gmail.com>
 <CAPpAL=xGQvpKwe8WcfHX8e59EdpZbOiohRS1qgeR4axFBDQ_+w@mail.gmail.com>
 <ea127c85-7080-4679-bff1-3a3a253f9046@nvidia.com> <CAPpAL=wDKacuWu-wgbwSN3MORSMapU8=RAdzp3ePgPo=6EMFbg@mail.gmail.com>
 <e08c5cc6-27e7-43b7-8337-095a42ed9698@nvidia.com>
In-Reply-To: <e08c5cc6-27e7-43b7-8337-095a42ed9698@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Sep 2024 10:10:11 +0200
Message-ID: <CAJaqyWd-gc+BDx+DWvBLOEYP+q_Rb+L5n4txf1fcvrcbcE=_Nw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 00/10] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Saeed Mahameed <saeedm@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:48=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 03.09.24 09:40, Lei Yang wrote:
> > On Mon, Sep 2, 2024 at 7:05=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >>
> >> Hi Lei,
> >>
> >> On 02.09.24 12:03, Lei Yang wrote:
> >>> Hi Dragos
> >>>
> >>> QE tested this series with mellanox nic, it failed with [1] when
> >>> booting guest, and host dmesg also will print messages [2]. This bug
> >>> can be reproduced boot guest with vhost-vdpa device.
> >>>
> >>> [1] qemu) qemu-kvm: vhost VQ 1 ring restore failed: -1: Operation not
> >>> permitted (1)
> >>> qemu-kvm: vhost VQ 0 ring restore failed: -1: Operation not permitted=
 (1)
> >>> qemu-kvm: unable to start vhost net: 5: falling back on userspace vir=
tio
> >>> qemu-kvm: vhost_set_features failed: Device or resource busy (16)
> >>> qemu-kvm: unable to start vhost net: 16: falling back on userspace vi=
rtio
> >>>
> >>> [2] Host dmesg:
> >>> [ 1406.187977] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> >>> [ 1406.189221] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> >>> [ 1406.190354] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_show_mr_leaks:573:(pid 8506) warning: mkey still alive afte=
r
> >>> resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> >>> [ 1471.538487] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> >>> 428): cmd[13]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will caus=
e
> >>> a leak of a command resource
> >>> [ 1471.539486] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> >>> 428): cmd[12]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will caus=
e
> >>> a leak of a command resource
> >>> [ 1471.540351] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> >>> 8511) error: modify vq 0 failed, state: 0 -> 0, err: 0
> >>> [ 1471.541433] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> >>> 8511) error: modify vq 1 failed, state: 0 -> 0, err: -110
> >>> [ 1471.542388] mlx5_core 0000:0d:00.2: mlx5_vdpa_set_status:3203:(pid
> >>> 8511) warning: failed to resume VQs
> >>> [ 1471.549778] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_show_mr_leaks:573:(pid 8511) warning: mkey still alive afte=
r
> >>> resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> >>> [ 1512.929854] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_compat_reset:3267:(pid 8565): performing device reset
> >>> [ 1513.100290] mlx5_core 0000:0d:00.2:
> >>> mlx5_vdpa_show_mr_leaks:573:(pid 8565) warning: mkey still alive afte=
r
> >>> resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> >>>
> >
> > Hi Dragos
> >
> >> Can you provide more details about the qemu version and the vdpa devic=
e
> >> options used?
> >>
> >> Also, which FW version are you using? There is a relevant bug in FW
> >> 22.41.1000 which was fixed in the latest FW (22.42.1000). Did you
> >> encounter any FW syndromes in the host dmesg log?
> >
> > This problem has gone when I updated the firmware version to
> > 22.42.1000, and I tested it with regression tests using mellanox nic,
> > everything works well.
> >
> > Tested-by: Lei Yang <leiyang@redhat.com>
> Good to hear. Thanks for the quick reaction.
>

Is it possible to add a check so it doesn't use the async fashion in old FW=
?

