Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF81B5A4
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239578; cv=none; b=r2cGof+OVH/5dzFDw4/POBOt1AGNnjkA9XQSaIep8KnEFBx1LioHQW19za7bGn3SyiiQYcw5rZdkkB2YYUd8AoNWcAfUZ+RqcAKCVt6xY5lT0KnsSJdflTBhmnJ/hivxffpCoYe1KO9rDmDgWNVVXDgvMjES5/1dYE4VySFQyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239578; c=relaxed/simple;
	bh=2sgJxnJigr8wcFGR1iwhSNcT2nBcK5Eld3s+LF+X6uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smU7gH1m/QC++OehN9zoPnIq/+ILiVg1n6T0uy2VsbdHwX0TitgLVdCaqVCR6TvirCP+hlOVbncRICD8Ot280okZHwkLqauet01zQNGTjWw69gwF8m3RuEvyeVkIG5BHYFUCHsrZilhydVeq0lg0dlYqcOnBAUqfdIu6DwcHP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLiMdbVS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLiMdbVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713239575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbgF6/U11epiwGC99e3x/yP6nFxwSBfWiCFk3BvgC/U=;
	b=MLiMdbVSiqtL4/ZO9KuLa4SfpQnb2fcAS9pRJAuiGhqQuxNVfnJ/aFmQIjupUcsdUZW+Pm
	G2cPB9p5BrNXh8nddkAZks8GHzCdCjmOlLkhKnv6ahXQFgpGNy3TcyXt09LpeA8Pr291m3
	0pgP1Bi35VWrvg3uTaq/5eMTC8imRXY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-FZQlAsGsMFmoSqaQGyTc4Q-1; Mon, 15 Apr 2024 23:52:54 -0400
X-MC-Unique: FZQlAsGsMFmoSqaQGyTc4Q-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so4035273a12.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 20:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239573; x=1713844373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbgF6/U11epiwGC99e3x/yP6nFxwSBfWiCFk3BvgC/U=;
        b=sUi6hpzqy5zvc9BL8nBmGW8DZVjLDIwcgrmTg8GlZiOcP0sE/kTX2HKHPpiMXnlsvZ
         mANh16OdPZPmgoa85nV8Mm88nI5vjvwoVI9D5SBcxn4vxgr+1DWq3RN3Q+aShjFVePSt
         aU6U8jWBWRaiCzjanruXrm/WtB2VSHS5n3DFoG3rZC49HcyMzuVRvCwGoPyJTUbf3xu7
         TBpUiB99y7Pfb4ocBMs7ivE420sCJzbryRtERwPWZu6BMr5cEr9vZrL2p0VsueU7Zj+B
         WOzEzF5RxvqYyuij03Tjezr7eYUX875TsXe6xSPYXwgrmb2FkGP/zdtTA/Bha58BfsXY
         SM9g==
X-Forwarded-Encrypted: i=1; AJvYcCXvNdCKLWsynK0dgLFC3jBsSRxWhl9ZWsfFrHSkZev0VGu4pL9SQNe6DjNAcRxQFqbypILPL2V1TpJws2Nf2hKK4KpQug78VavpmMasWGg=
X-Gm-Message-State: AOJu0YxC2AhLvPi/0YQqBlZS+qaDUIM63NbYu9qs8Y1Sw/2pIUCAAV/M
	ZCngTnAk1FO8YNXDwkTuv6MLsHAxGZin4cN7cFf3eLJlFZjHJ/vB3Zczgd1WGU9sDgfcAj34Jqs
	K+UgOEZ0ty140VWc4/JLS+fXnIw7UJT0s4Gefk6+xqnNhUZ0lkeTiCnRRCwxV/aHTbk452NOKf9
	Nz6sq3QOSKPbZQGBkioUmOs5aukUqQrCDcZUm3C2Y=
X-Received: by 2002:a05:6a20:1a91:b0:1a7:802d:f67c with SMTP id ci17-20020a056a201a9100b001a7802df67cmr12232029pzb.53.1713239573414;
        Mon, 15 Apr 2024 20:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHoyAP1wkJw/DB1EQ793IhrBgwbVmMVVgNjLcjYO082GE/+PThXolxxzYq5LJiiJio9HBvdJXNAxfQ9evpVQ0=
X-Received: by 2002:a05:6a20:1a91:b0:1a7:802d:f67c with SMTP id
 ci17-20020a056a201a9100b001a7802df67cmr12232013pzb.53.1713239573117; Mon, 15
 Apr 2024 20:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
In-Reply-To: <20240415162530.3594670-2-jiri@resnulli.us>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:52:41 +0800
Message-ID: <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Currently there is no way for user to set what features the driver
> should obey or not, it is hard wired in the code.
>
> In order to be able to debug the device behavior in case some feature is
> disabled, introduce a debugfs infrastructure with couple of files
> allowing user to see what features the device advertises and
> to set filter for features used by driver.
>
> Example:
> $cat /sys/bus/virtio/devices/virtio0/features
> 1110010111111111111101010000110010000000100000000000000000000000
> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> 5
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> $ cat /sys/bus/virtio/devices/virtio0/features
> 1110000111111111111101010000110010000000100000000000000000000000
>
> Note that sysfs "features" know already exists, this patch does not
> touch it.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Note that this can be done already with vp_vdpa feature provisioning:

commit c1ca352d371f724f7fb40f016abdb563aa85fe55
Author: Jason Wang <jasowang@redhat.com>
Date:   Tue Sep 27 15:48:10 2022 +0800

    vp_vdpa: support feature provisioning

For example:

vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000

Thanks

