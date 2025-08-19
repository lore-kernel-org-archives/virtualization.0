Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E01DC075
	for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610899; cv=none; b=N2mb+4g6hQsfrGEzZ2LcwglseoLH4wv00qFfSV4U5eZctWCt77zzK+4UEZWEVLzJt6CjeP0mzTPc2aFedLPSBSTzxEHI8KTan8mfrJ7OiZ2/8IJGG3jLvyfsGvcVc9JlczJogQhasUYeDfLMRKv578eKKoeupK/7EyYQRFOZPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610899; c=relaxed/simple;
	bh=45kfBlIx/c2YzCpopNGEzgYrDpvm5CQrUb7RS9hYw5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzeaM/L6eAxiTtgYFD7uu3cQxsDq2gX2nQqcEPx6QyjzReGGA4oPdlMmp/hN0Fxgoqfj6ysS7UAk4mMF3MYh7XsM7kaNIkoq/83Ezdm8NBnMR9bDhk6h9wZCP1Ulk4fzcchf8opieligdmYd/zY+idBXVSWUSYU94dbqXB4NHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTId6T+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTId6T+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755610897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
	b=XTId6T+acdN3hpv9jXPBq63m2l+BTsnhsPfigvwXtAGxIH0LpGEm+1m/eb6hSBm3I7UtKz
	kS78Xmx+ARo6ETuIop2IuLhKnNN2J4VrFYI3+usxbVEBDFElRzF818bWGJUIg/yd9k5YEJ
	YOErgPCLU2nzQ+s58VrJhL0ErdS4koM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-7p9Mm_kCMfyKSOv2mga4Qg-1; Tue, 19 Aug 2025 09:41:35 -0400
X-MC-Unique: 7p9Mm_kCMfyKSOv2mga4Qg-1
X-Mimecast-MFC-AGG-ID: 7p9Mm_kCMfyKSOv2mga4Qg_1755610894
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb62cffd4so493424466b.1
        for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610894; x=1756215694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
        b=ONKcuBbxPOO1SWeeAXLcZu26xriQA37WSj1NXw7D9eVAEfbI5b7cSXNy4wexa62B37
         yYVs3pQBUHNjAo447ZdS5is5agHqguuSD9ilzlwWhqnAvidhhNn+WTOV0vX5zOpjxqAh
         bVH4nk7KVxjm70F97DXLppl8qB1zB1kAtr7tmND0C7NnUr3bvjbCN2mIKI1HzXonJ4du
         wSPwpdXL89d/iuEjDtgQtKFrW5bV97Dpv7W8z/n7MH86MA9zaNX+upYZsK8KxJ9E9qgd
         200Omz5x4TP/rcMiFfGPTlWRmtuATgQ9HbUdIDISlkkVGO1nhIdT9ZH5oiB9kzqeQGsn
         Bz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuh1ybWCuZI/cNXTKb6saYbPluz3vMMRXRxZRDywwAoWLH8Y8LLgZEuKnV//I/86ruZXUlWfAwMmwjy7ujCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyubdBzxKHtYmiZtfmedUIkPxc3prF3BuJPSforvVrGzhA324Tv
	ZN62yjZ+AwLKKLVX9pHJHvZw10PgN9ET832nJsZ5TQfzEIPrLIjJEmrK+3CFq7gep8+peA+/8bN
	ApnBrkf5vADRgNaUf8u98YIMFbQ7jWAT7JS2feOeb8FNwDgHzQ8j9HlBTAiCyqeqPF2d9hKyCJX
	knu8Qwk/UOWqMe9XUa0iprAJNoQrV5fzFzDLwWsBQkw+Y=
X-Gm-Gg: ASbGncvvOTzqlLlSiI23Oqx96yO42c9v7jC/gDP/LhAFtfGugFWr5Cy4u/jkv56HZd7
	5u8lniaZkuowIx+Uet9XIK4guS5S1N7JvGGZBGWZqEY3WIElvf8lq1QtXRunmLlNmtHbY7MnUU6
	CnsknYDro5k6r4jZ1xNKrzEg==
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id a640c23a62f3a-afdeb4fe8d9mr16481966b.31.1755610894095;
        Tue, 19 Aug 2025 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1GVsEmsaG7XrNaXe8wonzWZoX3xXdB8eON+UVwMeu7PAq8S6nacljTSpJPy0fGiNqSMsvj1L05aVdNrtBjig=
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id
 a640c23a62f3a-afdeb4fe8d9mr16478566b.31.1755610893561; Tue, 19 Aug 2025
 06:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org> <20250819072216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250819072216-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 19 Aug 2025 21:40:57 +0800
X-Gm-Features: Ac12FXwPH4sSIUdUFp_9NFkFDCQTsp7XMFuiZKn4U01cioGDSa8UFneCp5B5QWs
Message-ID: <CAPpAL=xm9sgU=8b4TTYSMBYkdmgxmdx4PXFPGwYe3qkqcCh=3w@mail.gmail.com>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mWI3Nt6TD4ocam7_wXJKxvPMtSZYWLzDTe64NBxM7WI_1755610894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Aug 19, 2025 at 7:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> > The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> > result in a build error when the vhost uapi header is used for perf too=
l
> > build like below.
> >
> >   In file included from trace/beauty/ioctl.c:93:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: I=
n function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: error: initialized field overwritten [-Werror=3Doverride-init]
> >      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
> >         |                  ^~~~~~~~~~~~~~~~~~~~~
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=
=E2=80=99)
> >
> > Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode s=
election")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied, thanks a lot!
>
> > ---
> >  include/uapi/linux/vhost.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index 283348b64af9ac59..c57674a6aa0dbbea 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -260,7 +260,7 @@
> >   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
> >   *   - Vhost will create vhost workers as kernel threads.
> >   */
> > -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
> >
> >  /**
> >   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhos=
t device.
> > @@ -268,6 +268,6 @@
> >   *
> >   * @return: An 8-bit value indicating the current thread mode.
> >   */
> > -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> > +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
> >
> >  #endif
> > --
> > 2.51.0.rc1.167.g924127e9c0-goog
>
>

