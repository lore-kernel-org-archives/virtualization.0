Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333C1F03F4
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994164; cv=none; b=NquxFrTbDxM87YalT+yFX6h76pKLVKGcranUfMFmbGyWIdV248K2hXHe8TvWUKCInXUO/rJUcKUasGmts1P278kTlyz+uZHPCvqriTOlRI9E0gth3hRSv3SdFSJOLeObBWydoBJzT3t4jXNU2Pa4z/q94iBPdUx3VY7diIakl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994164; c=relaxed/simple;
	bh=hO/1w0WIreFcCNOGOIiuvQHBGfGmx0RKyWkuiZ5OENQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQLgKSQjuHTyldFdas9Bsm1eq8FzBG3ZOtjVzIxaXWeas43UzfYlCvSNAkgncPlJ0yORFFxQxuLa/9tTPRId3F6f2clFTD4yOMlYwpkYRH77BuqaekS/mp2fxKt+4S4KUxNTnVwomAw4rCY5UyZXZJOFPptLAiWmIEgrrHUIRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYprvMfY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYprvMfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740994161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dm+Ad9vtaxKH6b/jFWjk7lOEkc1nxwN4lmuVSAb6Ah0=;
	b=WYprvMfYqbkU4GyHddEmOdyletLkVi88pqzKR3O7RyGah1cY/GW+VOOk8M8677Jm7pkoBH
	hTMvXoZAh+aaWh/DyqTb1aLmzzpI8RIoNoi9X2cr7qmyJnaM+ZfrpOvh5usxBtE5ieOpMp
	y+NsmZolO64uYDPq+3TqmaH+Wu+q6H8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ttv5gzkBMnGqDApOhRUI0w-1; Mon, 03 Mar 2025 04:29:15 -0500
X-MC-Unique: ttv5gzkBMnGqDApOhRUI0w-1
X-Mimecast-MFC-AGG-ID: ttv5gzkBMnGqDApOhRUI0w_1740994154
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22367f4e9b9so53172615ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 01:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994154; x=1741598954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm+Ad9vtaxKH6b/jFWjk7lOEkc1nxwN4lmuVSAb6Ah0=;
        b=FoWSV23eBzKJhfPU4UNXpyGGEOEyxuLoaxbUrPX9ndk5xOKv04+3RmePH61O11efQt
         jEWf6KoxJRx51iMQX/YLMoGCcaMBEhwg/4NR/hF6Aq1hTHJ6r9/yl3vaYbvEha0U/2Rn
         ZIbdouMPQjkB2yJdKfoEpf5zuAO4Tg87er7OQG7Op8e/aO4tmrVgXJABftfjaL6XcfSN
         HRZd57Q7GAoNjEtiEk7imvVLUGF/XXDeAXfT9xqmlOSNltwo2WqRBGXuYhlKOZBTsXHj
         hCcuMK3NYXONNgZkmJzfAra8HrX9yZjc8AcFXIHNmMeW0j0jSxBaNwKgDLr16BuJPTdR
         7SwQ==
X-Gm-Message-State: AOJu0YyMRAby3jG76oPOv9auC5CbRfQu1EfGrAFeoMpmbtB42NuNnsT4
	t6EFjDjGNYNMLYV4FQ2824HBGEw1W8yHyez9+vZ8a0kx3E5h21VMbAAYmIiOEzPL0YScfVsg5OQ
	Sq5euaFP6BIqIYDlNII5u3DBpLGVXGVm/n1MwN6EagDUZbyj6x6MokJeR5k5xE8e5TV9WMcxN4f
	oE7YrfRWjP0VXURp8Nw0RGb0Ko/5qAfqdbyGB2ixg=
X-Gm-Gg: ASbGncuF2hENTLWxAc6Q/d+sxQbL79HCvXJP/79c7H4T7Iiq3ueif53PE471pxlW/1l
	ZBp1N66ZyiSnO4ZEyy5GsymqLEw/bQ8JjzOTMPz6kOlz/n5/lLQF9kVEMqA9hKHru1qT9Zzo=
X-Received: by 2002:a17:902:f547:b0:220:f7bb:842 with SMTP id d9443c01a7336-22369255811mr196196055ad.42.1740994154024;
        Mon, 03 Mar 2025 01:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeh8T/Isef6u47m5QPpp9NHgJMkJl3dnUE8Ylea44Ny6EY1sjUVU9fZMYGnxlnkM9rFe7Jpp6zS4k5VEsVFKw=
X-Received: by 2002:a17:902:f547:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22369255811mr196195835ad.42.1740994153774; Mon, 03 Mar 2025
 01:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250303085237.19990-1-sgarzare@redhat.com>
In-Reply-To: <20250303085237.19990-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 3 Mar 2025 10:28:37 +0100
X-Gm-Features: AQ5f1JpYz8RUYj9eXvkfBI5yoVaRYAPygFZFSo69WGk-H92b36v2eBIN9Cg-xmM
Message-ID: <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix VHOST_*_OWNER documentation
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 84RPp8hD6aZFl1duDvXPWfRxv2RcG2hietBJ4izol6c_1740994154
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
>
> To avoid confusion, let's use the right names in the documentation.
> No change to the API, only the documentation is involved.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..d4b3e2ae1314 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -28,10 +28,10 @@
>
>  /* Set current process as the (exclusive) owner of this file descriptor.=
  This
>   * must be called before any other vhost command.  Further calls to
> - * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
> + * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
>  #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
>  /* Give up ownership, and reset the device to default values.
> - * Allows subsequent call to VHOST_OWNER_SET to succeed. */
> + * Allows subsequent call to VHOST_SET_OWNER to succeed. */
>  #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
>
>  /* Set up/modify memory layout */
> --
> 2.48.1
>

