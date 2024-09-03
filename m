Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B61D6DD1
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349297; cv=none; b=X40MJ099Clm3U3942x+zEPZhwMWUS0GTiiqE5X++85+7DLxQxmBRKR4bGsdgeYg7jqGyJMH8g3fs3MhvyunnUKIadIo19Vsgr77W8tAEQezEyaVHjuQnWWCdoZ7mJ2qq67fcVXm8u42H8gyKoYPC5P6U+4PVoseOym0kPwr+dQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349297; c=relaxed/simple;
	bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1K/yVWmqusVui5zZnzxyL8cniQGjv9qmLLjRragK6QVHWFzBu3lywW7lfKWXLV19PnpsCbgXfNUzuxYnD0WBjd964f1fnIBW5xcmjNqaipilkxWO2UaNu96R6MqY6sC8KE0Sqs5xhVHQKUwIQR+COUhfD1RpR1YDImZuh6SHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCO+5kxb; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCO+5kxb"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B129660658
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 07:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_9G8gNSpfdp for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Sep 2024 07:41:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3F4D06060C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F4D06060C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCO+5kxb
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F4D06060C
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Sep 2024 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725349288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
	b=cCO+5kxbIRbBnlms1qVTL0je2u+Zmvcg+KAfLKjk+pub2Rw3c0m8jxlBOdFU9aixuvqPBh
	cE+sDJrQGc91rDBVmYiadk39QBqhYBBQus5JUZbhX1qQ1Of+rPZiEMbhnyK4RLkJmLdntA
	8RW8GCX/j/Z9Xp15ZFnOTKezw70Vx4E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-UPi_dZ_SPkaHVV3mjBF4UQ-1; Tue, 03 Sep 2024 03:41:25 -0400
X-MC-Unique: UPi_dZ_SPkaHVV3mjBF4UQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3f6d581fbso56878641fa.1
        for <virtualization@lists.linux-foundation.org>; Tue, 03 Sep 2024 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349284; x=1725954084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmZGb+MA+mXou1jnaR60KfjaG6/mC67CXIvC/9dCxeQ=;
        b=FJtneyAKxl9WlXOv+Pg/5dHrcvrtUK8CfdVB+lJyjRMjqAd97xcBnorsgp8APvLE2f
         7cPXFjozm3FaMZn/2mC9uyR9SufFuQQ8aHYYQPBH5PQFDxhGFfFF3w57suYbTRLG15dC
         n5J6EdbD1f6W4w7ZciBr9Y9zpAZE2UsglvEvr1YwXltq0VV1/60LR4yneA5xgryoOe1R
         378+Lc7kC/X71CosG6Cso4dh4wMm3SMgByaSMkAxL5BveZzHPuOeRIIQktSTMxobjrn7
         G6Im8avAIoxcfasO9Oq6vrTDtC9g+2/aseroX6zmP4lWu//dVDjaAUkcr3842KFXJU6/
         QMGg==
X-Forwarded-Encrypted: i=1; AJvYcCWpYIurQ6z6iQsh8X3+fNowAxO5ZBbus7uTliWmtzjsyb52kAfaefKc2UjiFdK+q2rQCRGphuPJa1Ko4U7zvA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxLfJUprIrjneT4h8Zl4iui88JIRuJPCU+Z55KQT1I7ZxtJndzF
	Kt5FIhP1739sSX3il8qkKIeN2Ln7vC5H4qokZnJ11Xdp2jJ7EbUF5fs97nOrnhh3eFwitgDJ/no
	9M1zdc0JhClZKaJ+OPzFgAzjQQGhN/CCDLpEJymJFN2++9UDr/JnMCrHjUD617G7iwAiXy1Qhun
	/xgmDnaz3TILuen7Vodn60em/51lAqMz3DV81O4k3astvMbjrwBQ23dQ==
X-Received: by 2002:a2e:a9a8:0:b0:2f3:ed2d:a944 with SMTP id 38308e7fff4ca-2f6105d7638mr150706101fa.15.1725349284132;
        Tue, 03 Sep 2024 00:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+2y0Ox29ncWXSJQ27vWedil4q1hbIeNw26N6BH7DRSWODvYcgpZIEbdqPrK/1dWOWpcepNHdpzljzxOVI1xg=
X-Received: by 2002:a2e:a9a8:0:b0:2f3:ed2d:a944 with SMTP id
 38308e7fff4ca-2f6105d7638mr150705531fa.15.1725349283019; Tue, 03 Sep 2024
 00:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <CAJaqyWfwkNUYcMWwG4LthhYEquUYDJPRvHeyh9C_R-ioeFYuXw@mail.gmail.com>
 <CAPpAL=xGQvpKwe8WcfHX8e59EdpZbOiohRS1qgeR4axFBDQ_+w@mail.gmail.com> <ea127c85-7080-4679-bff1-3a3a253f9046@nvidia.com>
In-Reply-To: <ea127c85-7080-4679-bff1-3a3a253f9046@nvidia.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 3 Sep 2024 15:40:45 +0800
Message-ID: <CAPpAL=wDKacuWu-wgbwSN3MORSMapU8=RAdzp3ePgPo=6EMFbg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 00/10] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Saeed Mahameed <saeedm@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:05=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Hi Lei,
>
> On 02.09.24 12:03, Lei Yang wrote:
> > Hi Dragos
> >
> > QE tested this series with mellanox nic, it failed with [1] when
> > booting guest, and host dmesg also will print messages [2]. This bug
> > can be reproduced boot guest with vhost-vdpa device.
> >
> > [1] qemu) qemu-kvm: vhost VQ 1 ring restore failed: -1: Operation not
> > permitted (1)
> > qemu-kvm: vhost VQ 0 ring restore failed: -1: Operation not permitted (=
1)
> > qemu-kvm: unable to start vhost net: 5: falling back on userspace virti=
o
> > qemu-kvm: vhost_set_features failed: Device or resource busy (16)
> > qemu-kvm: unable to start vhost net: 16: falling back on userspace virt=
io
> >
> > [2] Host dmesg:
> > [ 1406.187977] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> > [ 1406.189221] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8506): performing device reset
> > [ 1406.190354] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8506) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> > [ 1471.538487] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> > 428): cmd[13]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
> > a leak of a command resource
> > [ 1471.539486] mlx5_core 0000:0d:00.2: cb_timeout_handler:938:(pid
> > 428): cmd[12]: MODIFY_GENERAL_OBJECT(0xa01) Async, timeout. Will cause
> > a leak of a command resource
> > [ 1471.540351] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> > 8511) error: modify vq 0 failed, state: 0 -> 0, err: 0
> > [ 1471.541433] mlx5_core 0000:0d:00.2: modify_virtqueues:1617:(pid
> > 8511) error: modify vq 1 failed, state: 0 -> 0, err: -110
> > [ 1471.542388] mlx5_core 0000:0d:00.2: mlx5_vdpa_set_status:3203:(pid
> > 8511) warning: failed to resume VQs
> > [ 1471.549778] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8511) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> > [ 1512.929854] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_compat_reset:3267:(pid 8565): performing device reset
> > [ 1513.100290] mlx5_core 0000:0d:00.2:
> > mlx5_vdpa_show_mr_leaks:573:(pid 8565) warning: mkey still alive after
> > resource delete: mr: 000000000c5ccca2, mkey: 0x40000000, refcount: 2
> >

Hi Dragos

> Can you provide more details about the qemu version and the vdpa device
> options used?
>
> Also, which FW version are you using? There is a relevant bug in FW
> 22.41.1000 which was fixed in the latest FW (22.42.1000). Did you
> encounter any FW syndromes in the host dmesg log?

This problem has gone when I updated the firmware version to
22.42.1000, and I tested it with regression tests using mellanox nic,
everything works well.

Tested-by: Lei Yang <leiyang@redhat.com>
>
> Thanks,
> Dragos
>

