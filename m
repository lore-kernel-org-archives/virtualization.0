Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1D2BE634
	for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572218; cv=none; b=gBDvV0c3zvKpxo2edUPnsUH4TJ8tPPNBJn+kJL/Mwxs+T9egy322ea4itd57fVeC7zR5yG1qTShOhp7FTA5nSVBGWia4pwS3WDPG83k//JROh/ZDNdxuOnNBsPqsPn8H9Aipa+vz/HEsDd37gw2dS0Dp/wpIVc/L9vtcZT1U4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572218; c=relaxed/simple;
	bh=vOTsLPHrmR4KWPLCxzIidma6yhGcdhM6/jmIPZ0Y6GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aepj3xdOufcPqky+ySwrUuU+13NE5dGmZmt6LC/hK98jJgXGj4FLhThgDOXnqcUCtT5uI+sCV9XtsGBIMMYhPBQm7ADMwLIDqZKUMthG+wPYb+xFQ+ag0uTkr0h0lPq1iJIP4YM7K561BuY3/ORLTffG5+GlKg193jO+uegQZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEVMfxWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEVMfxWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755572215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
	b=iEVMfxWp8HNg5t4vnahTlQ/Dh2JiMv7VmXmDWjCcCirIprRqoWad1gE5YnAkagX5yewm+D
	Ps3Q0V3ON73qAJEZphMmtp+Uly9ofMTSgJ7Wjz/hyrz5mvAsk1uMWJ8Su5cvPsIFgPyle2
	q2v5RQvZEIfN/835LyNtOJAXKDVLkTA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-6aMmp-W-OXOWMF-3dsYGjA-1; Mon, 18 Aug 2025 22:56:51 -0400
X-MC-Unique: 6aMmp-W-OXOWMF-3dsYGjA-1
X-Mimecast-MFC-AGG-ID: 6aMmp-W-OXOWMF-3dsYGjA_1755572210
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471757d82fso3804102a12.3
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 19:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755572210; x=1756177010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30rtf85COe0Own+57CwCTiuCFuWNx+52rsJaNL6+eGg=;
        b=irFjiiuOFLdG4agLejtKZuM/g2RgR8euinmptYBLSohdLSK2XeHMqVNXrT8FUtVvH4
         ulj2zRiXhPAnajyzVAtvLYQR5x7omN2ptrt9yTTPqCjeHGDCW0EIbU2gAy9jkCRR8s4B
         cLj1jDHDWlIvU05WXklX+E+cHqgPzEcBcupAutfvt0LsU+bY9Wu3ngUbC4iBwcFg4o6/
         mSCs3cDqNo6P0KGvG2fr/ZYnEw+JyEka3EuMWbP/EmJc2x8QEhZjXzWT7j3NopzyeIt2
         EMKKa7R04oiXmibu2Q5yJHY0xoNEU5Z7BZgCELWWwNAkWtXMc2fnu1AnqIUi+16neX9j
         NWZw==
X-Forwarded-Encrypted: i=1; AJvYcCV0rlTqQmuPkpzHEdKczFiuiBSpPsq62cqA2XzrRhFtoAztbtSiIuGAxOYBEnVu96CXXY6ng7TjfD7lPoI7mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvlPaOKEXz8llJwdQhJKPSdLVdVPileOkH68Soo9FMNldSCsrO
	GXYj2aIihfJfRN3wA/3ehMKlEhe2yL4CozotUzRLxlwgs0NBiHodeDBwhgkITADbcZNkiMAAvJI
	283N/Wn6Vta1ALiqTO8DFuClEWIi6LJZAGMSJYaG6ntyd8G0ogCBWONrijD6jnEmfAf5Z+JqKbV
	Gu/DloiUyPMJlWBYFXpsknko9Bkhex3orlAx9NEjyDWE3Draqkp2gy7dik
X-Gm-Gg: ASbGncsRccJ7jGw8K8fWAvaZLl5k8aniULhAXtAp1IL5n+zcl0gElcbOiYZdsZXduZG
	BhxEpnJ3+MQEa2VOXsfV5on5Ow8eBkKLv+fQwXVWgHyPCx/SnaQXxfQuhQlAv1sWzEbxhBJW6J1
	D5TJ0I0hAUynOv7nQj8bT1FPw=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id adf61e73a8af0-2430d4c1313mr1346432637.42.1755572209911;
        Mon, 18 Aug 2025 19:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnlIuMdMyqhr/p8CYdMvQzUInme5H88bLRkT2Jl0duOeXAZIWJz9QHEu8m1RFiElzvhplq7z95g+i2y/CkKNc=
X-Received: by 2002:a05:6a20:6a24:b0:240:750:571 with SMTP id
 adf61e73a8af0-2430d4c1313mr1346412637.42.1755572209496; Mon, 18 Aug 2025
 19:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aKOLrqklBb9jdSxF@google.com>
In-Reply-To: <aKOLrqklBb9jdSxF@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:56:36 +0800
X-Gm-Features: Ac12FXz4QQ7I_WS0I16x3o7tcM5Be883zhtqEJVTDk_lwuE3fHpjghTmF64HFYE
Message-ID: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
Subject: Re: [BUG] vhost: perf tools build error after syncing vhost.h
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J0I53QVWz7DA0eHpgMJmnmvfVpXnVsf2SU6nLk4ZXrU_1755572210
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I was sync'ing perf tools copy of kernel sources to apply recent
> changes.  But there's a build error when it converts vhost ioctl
> commands due to a conflicting slot like below.
>
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In =
function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: error: initialized field overwritten [-Werror=3Doverride-init]
>      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:1=
8: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=E2=
=80=99)
>
> I think the following changes both added entries to 0x83.
>
>   7d9896e9f6d02d8a vhost: Reintroduce kthread API and add mode selection
>   333c515d189657c9 vhost-net: allow configuring extended features
>
> The below patch fixes it for me.
>
> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 283348b64af9ac59..c57674a6aa0dbbea 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -260,7 +260,7 @@
>   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
>   *   - Vhost will create vhost workers as kernel threads.
>   */
> -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
>
>  /**
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost =
device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>
>  #endif
>

Would you want to send a formal patch for this?

Thanks

>

