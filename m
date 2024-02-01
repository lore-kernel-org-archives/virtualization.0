Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEC612C6
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765882; cv=none; b=uoD1YSRIYl2ObMDVjY+htKybsw85W8Au/6JlNT1yGiEu0gfwrJYJBlKhn3aGXAV+GQyQQR9Ra4IKxcCaAeIfAt34HJ/l8Alh9f76duU0gb76b76I3Pl/HlQTZ3da2nQywNlMPSUoJiLajRXqYp/AWk6gDGHYTI+aOoam4N4mKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765882; c=relaxed/simple;
	bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYHG7YlByE/bZ4amg4yjiSZDw1aK5EP2XQgnWo1Dks7SlIX2ACEw8zk1roiXMPNZcddt2+K9KPK39MqMa7EmXQuHS/4SMbgCazRQkDVkKFPNh68wmOmc0Czn0dSRQTQ8J53mXGg9cxNVeXgrIsW6cacBrRSWHgYMJuD/apCxp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ptkej54j; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptkej54j"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C529B60B35
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 05:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C529B60B35
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ptkej54j
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfElXrN4iQRr
	for <virtualization@lists.linux-foundation.org>;
	Thu,  1 Feb 2024 05:38:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB08160B2B
	for <virtualization@lists.linux-foundation.org>; Thu,  1 Feb 2024 05:37:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB08160B2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706765878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
	b=Ptkej54jXcqU83dncA+MPiBLTUInQR6ZtlXXqSXBURtZ/XRiPnhOuT0U5doNVwhCgy395F
	t8cDK63tjCkyAqeMdWPTWT0hRFf73KwKBnEKt8PY2X6UroDdYUzjdnrpJQ3vmVRm9EYwtV
	zA2RLYprEN9Jj7NEAGi8v3Ck4Jtx2vQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-MOu5i4yaO2GvgMbdbAXr4w-1; Thu, 01 Feb 2024 00:37:54 -0500
X-MC-Unique: MOu5i4yaO2GvgMbdbAXr4w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-292bc8b6b7cso501963a91.2
        for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 21:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706765873; x=1707370673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
        b=VaIDOh23DwVNNxBqaq5CYAzqIoYpoJIc/tGxIA9BvhGUE2Phyp+U99UIpG+BTPHKbG
         vOuv2prjMXX1AKOQEbm1jKDHuVPhcjp8cCP1J4dmjlr/lNaY3lFoUZp3sfIZI7IDy5Tz
         iin7Z1Z3kHTELktVg+gDsWMi6dGqBvUwsJ6/n/Ih0D/Q3LxDwf7Zg/PdximYQZT4kz+r
         F0LO8VBcsoZKrJ2CnI5pRQJPJi/719knaQDG3KiVzWMRnzaXrvBoVXReT6w9AMYEnPuf
         l6SA59wLmcxA9EwUM4Cx5bWDwgRdIoWCCdo0r2PvbOrgqQOgDeLKprdlithNDKmSYZaL
         dfjg==
X-Gm-Message-State: AOJu0Yys1kOgJQKLesSQ8xCrlgN4V8tq8XpxWeoEXTBav6CB+Iu3TqNy
	OUYy6O3P/iJPzsJ76Skpd/Ebu9oPrrOt2CfCWPtwZ6sFapdTxyFxHr9GnjDJZCtblopyI6Nj7ge
	/+KL/1IN/MmEO1130CnSopbyIO3wtihDT2n75MRTKH1cIxFhcQlJBEjSOdlfLMfplWtn481DeGQ
	GkMqfZHWTq+76S3nhNaSzJ1QzC1wg4IylHk8F8b6ZIcy9lkjgzW4zhRA==
X-Received: by 2002:a17:90a:1189:b0:295:cca3:73d4 with SMTP id e9-20020a17090a118900b00295cca373d4mr3873876pja.4.1706765873814;
        Wed, 31 Jan 2024 21:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhjcbJELHa6M870aBPEiK+ULPeq/Cay0m3VpUBudp/caBPr4O0l9QR82oXMQV39Dl/Tgu2DgMKZZqxBtd7b1M=
X-Received: by 2002:a17:90a:1189:b0:295:cca3:73d4 with SMTP id
 e9-20020a17090a118900b00295cca373d4mr3873869pja.4.1706765873535; Wed, 31 Jan
 2024 21:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
In-Reply-To: <20240131035535.22258-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:37:42 +0800
Message-ID: <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gmail.=
com> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

