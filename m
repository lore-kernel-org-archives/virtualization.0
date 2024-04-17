Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEB282E1
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328670; cv=none; b=gtuxlTZa811MxN5HBHYfFFkU6q4H9H2owTD3auw0CnZX+AIMuEoxAE7BPdYs5kctnHMyehFaUvsjIDxKK+7jR1zyo4GXRt5IMhFTIquvcYktD/OhgYVLNAOEmT5XheqygG2Qc+pxnR6B1oaNUJu6RS4p8eLLkdL729vBX64K/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328670; c=relaxed/simple;
	bh=6u3GKlFSpoC10lgNlkKM4E/0oPW+3YT0UrSAx8dtQ8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAB2OITCep5ezuCqRZGQ1ZjLornEQY14UIadmnNKkpTr49xwgxiFB2Geu0dKLZZ1p7b83c7UnWjzMGyUD4DuUq1U3jSvds+XH2de18QQRzRphX4rjowQa7i8l2D/HDsce3U/VTKKJ3Ro/oHBzoFM0LzZew4WHBhoSmuByahLZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OA3mcIEF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OA3mcIEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713328668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDzI+eWvpQYZ0ImlPJLuB0OPGdawUBCt6eGK/x6pkLU=;
	b=OA3mcIEFShHDkQafM0n6uhdluVAn3RmbBF16eQNZlv6LUSGGGaLxsk7YlG/G8dE5aieJnK
	QqtWZk4AmlZfcNnu+S/pCwD843V6xPw1sQHVBW7zq/eZ1atvNiu6fu47FjAV6KSAKbqNH+
	y4UcQu2xLNS/m63/yHZ0TtdcwqdxTeU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-u5L-rsQ3Pc-A9AGm96VC6w-1; Wed, 17 Apr 2024 00:37:42 -0400
X-MC-Unique: u5L-rsQ3Pc-A9AGm96VC6w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c72a04dff8so918039b6e.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 21:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328661; x=1713933461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDzI+eWvpQYZ0ImlPJLuB0OPGdawUBCt6eGK/x6pkLU=;
        b=SYCyaiA8yVfBkurfmxj1bE5LwV7ydcTSCZTqfy8Ae//UeQkjyU3AM8gVmyce2GQ6eE
         IBD3hDks+CjLS/E8AiVU9FpnqNIj0rw1ya9U+yVaemw7Gv3mYdcaBIIYoy/7dN7p1jAF
         duhTeoPghk3pkIPvutYOrN/oC5IBn/QSe5j1bW/v5GN9aSQi2k/KOzf2XhHFOxmzx3GH
         IwLyzuInxn0VOfMPNnUEuRIwMUbL6BXylyiBGFAfwSU4VDHtwRjquCrlCASK7ySFXB4d
         G/nB0r21/BIdbGEiIzzQcz06OkQNkwS4VjZZH4lLB8REz6GbPNwg0qlDVgnD1gJY1V07
         EKbg==
X-Forwarded-Encrypted: i=1; AJvYcCVnA7b0zJYBqiixtbvl4H3TPp9yd3B5jbrPVHyY7eHGTaxSd0Esx3shA+Km0FDtK/tqikfjRJoPEBe5+2qg9dSloPVi01xiMAqeaqaHNYc=
X-Gm-Message-State: AOJu0YwsnJy7n8a7+WduUkO5sA/4hXf5lZ5F0ZQcXyFhpGhtsIukqRSj
	aSuLw2XGeJpab40i70SQQTSFrn9Fr/XvUUkKwU2bjIuUBquGlKf0yvx5PTlBlBHCqJ2Dztl/4nE
	eTNSz2fvcmPN/3gGO0Dhv1jJLIWCo9XWqILEeIDr+YdGv/LC07Z2/1YPD5eyhiyGX25y8gA/G/L
	c+JzwvPv3qPXS7iLJcJIPa2DnuiS1PdvXkKclI1ok=
X-Received: by 2002:a05:6808:4406:b0:3c5:f056:5df1 with SMTP id eo6-20020a056808440600b003c5f0565df1mr14573927oib.30.1713328661607;
        Tue, 16 Apr 2024 21:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPyQOhuoksiXETieVQiL4ktPmvaFhbyn09+z30rs2FVFfsVE3H6qT8PMgIL12EumOKHbJEnaW4RziRWMxmwsE=
X-Received: by 2002:a05:6808:4406:b0:3c5:f056:5df1 with SMTP id
 eo6-20020a056808440600b003c5f0565df1mr14573913oib.30.1713328661365; Tue, 16
 Apr 2024 21:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com> <Zh5G0sh62hZtOM0J@nanopsycho>
In-Reply-To: <Zh5G0sh62hZtOM0J@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:37:30 +0800
Message-ID: <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:37=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
> >On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Currently there is no way for user to set what features the driver
> >> should obey or not, it is hard wired in the code.
> >>
> >> In order to be able to debug the device behavior in case some feature =
is
> >> disabled, introduce a debugfs infrastructure with couple of files
> >> allowing user to see what features the device advertises and
> >> to set filter for features used by driver.
> >>
> >> Example:
> >> $cat /sys/bus/virtio/devices/virtio0/features
> >> 1110010111111111111101010000110010000000100000000000000000000000
> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> >> 5
> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> >> $ cat /sys/bus/virtio/devices/virtio0/features
> >> 1110000111111111111101010000110010000000100000000000000000000000
> >>
> >> Note that sysfs "features" know already exists, this patch does not
> >> touch it.
> >>
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >
> >Note that this can be done already with vp_vdpa feature provisioning:
> >
> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
> >Author: Jason Wang <jasowang@redhat.com>
> >Date:   Tue Sep 27 15:48:10 2022 +0800
> >
> >    vp_vdpa: support feature provisioning
> >
> >For example:
> >
> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020=
000
>
> Sure. My intension was to make the testing possible on any virtio
> device.

It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
with mediation layer (like feature filtering etc). So it can only run
on top of standard virtio-pci device.

> Narrowing the testing for vpda would be limitting.

Unless you want to use other transport like virtio-mmio.

Thanks

>
>
> >
> >Thanks
> >
>

