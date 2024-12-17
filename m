Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56083A1BA
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402000; cv=none; b=BD8DPbbfP0zV//GkcLgmGj3rqEWa4feAAOzSD9jMyK1E5VVhSHjFFbUTMv4Y+uBtXAll3RsGJ4TL3h7slJY7PB77V+wVXuh7fH3FDsuGEMET1hBACEJ5C+wT3PAYKFghukufERgaUpwaCycIwp8R2rbN/Ak668+XtJLQoDBK4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402000; c=relaxed/simple;
	bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM0dSU3ptbbIf1J5AqXWQXNbl/H7KC67aa09kPFz6JFDDCjNxyHFcqn3ucgsNxTNo18s2A3H6ePxn4Jgi/2FBjkXXakiRbigHsLNgpPxV4Wb5UqBZ57NYb0DfyJYvERmEqCuULJHCKXAUr1FXUqWg5wpV/oKMU8/sPZvNMKGuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4HIfMWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4HIfMWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
	b=c4HIfMWgAHoo1nC6OhZwUViJNHsupXwUR5MFJIDHBwgRD/nrp5BQIBTrkqvLuDtOndqJii
	qc/qI+o/G7mwVt19xCxb4ovr8X2GQC44fZ+o1YU1Yndbnud7kwyQb5shwm6CQJSJAzgE05
	+7xiTtaMIYcmQ9imEMCmaeXhQ5e62no=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-NnJdkUqDPJuVWfOOSCr2Cw-1; Mon, 16 Dec 2024 21:19:56 -0500
X-MC-Unique: NnJdkUqDPJuVWfOOSCr2Cw-1
X-Mimecast-MFC-AGG-ID: NnJdkUqDPJuVWfOOSCr2Cw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so7117454a91.3
        for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 18:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401995; x=1735006795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ae9GrmZ1Zm5dg5PngnXgnGcYRGb2sPlzBmUBy75Xoc=;
        b=upr9jKkMKP/F6xjD0/6pZXCWjw/ZMLxT1SczxUsN56eRRAmmI9r75uB/I2NwvCazsl
         w5dbWPwuXA4x0Wdf20Zb1A9Bbiyd3ygLWnzO8OxAFJ9EtyAkomVRPo8J0g3p3Oxj9+TS
         p22e6i3XSgGxS3wC9gsTxPm12L92/O/ah1UV73ffPJchgERgroUohLv85JbPD0N1dcj9
         gm4rtbDoful71VxjpmqbzY02LrM6vxOkqIkFyVcHk00J4Qyd1GMyyN9t8P2hFPN1P4zd
         /jnp2lwQ9KM9GvPv/RmGlGnK0JCwf0kpx4XCClRnnhF0iXUQqenDAv1qfC8ciU8S2puj
         2prw==
X-Gm-Message-State: AOJu0YyRhxZXIRDeORa5i5WUSab5d6Vyq5AEM1OuBsbmViDeqElfZr3j
	mcW0unHwrxhdKeKFLpdGG5xYIf8ksjNCb0Z1MgnkUe49gNQ2VdCyjZIL8YwXdS7Ao07u7oVMUqN
	Si8RqODIGvFc26HNhn0DbUHhyCmzRW/8pxS2mhVxOgarzZGHOlb5b3CFPhjnR0XcFr0pCiIbqJU
	KdYpIQ0jyHaPCiFkVgcsr5oek6vqHg7TvQ60XEfsM=
X-Gm-Gg: ASbGnctlmiu8qNaIbxoGM99kWeC7NTWUkMaGB039kP93DbU/kiNMrc8sv1r5vt2P5Bf
	acA+6fnhESt2M4SeM1PFBWQT96TmqMhIZnc6RqU8=
X-Received: by 2002:a17:90a:dfc8:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2f28fc67364mr22185524a91.10.1734401995617;
        Mon, 16 Dec 2024 18:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKbSp41eH0dkhZ/iSROy/9EyV2a2K0VoSxmiPfeIXLS8zQx4thuhAEpQdj6jpTV2/IQTbIKRHVlKkxyeu6GeU=
X-Received: by 2002:a17:90a:dfc8:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-2f28fc67364mr22185500a91.10.1734401995261; Mon, 16 Dec 2024
 18:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241214070835.568818-1-sthotton@marvell.com> <20241214070835.568818-4-sthotton@marvell.com>
In-Reply-To: <20241214070835.568818-4-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:19:44 +0800
Message-ID: <CACGkMEvsTy-RJToryuKG+NL9cNGLNuc7EkDYminNx9FWTXCQOw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ov4e4PawThEEGiMsGG9fW2fW29u2uf5LWJ8hWmfJHkY_1734401995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 3:12=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

