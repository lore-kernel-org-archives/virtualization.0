Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A0156CA
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498556; cv=none; b=nwLXMP96F44ENUmmaiPsbKPMvqV3hRffOw7OBiFKB8ek4obEQGqGgNmqlUbrUXHQGauKJPgBz8/3Y7frmVrNf5NWado2tlB8ywlw0iijJ+Pu+H3jy/xHPt+NxuLXaJm/RrOAeBnYUUKmcqiWNDATFOxA1xCJA26SjDFNPE5yMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498556; c=relaxed/simple;
	bh=2oUX8OGhC59J4+7i7XnmNn7xcU2hccOEO26Zz+gQF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6K9bYmgdmLpTUQ4Zt/jNbTC5NBQdzKZU7ntG5upKQjkV5VoksXgOaP5J5IZ3+rVrk7IRzWUREUCz1h61orZu5OzaLMGTYFM6UzJEcz7uoP8QskksjFgKsYlUG090plSYhxY3hvjsQIHCZRFTsuxO0HJr20f95qTV3U2Ykqg8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diryEVLH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diryEVLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748498553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XL7na2q707MGwhuwlmpiGvZQ5mpH0ZBTH40hCat7Z8=;
	b=diryEVLH0+PNdatXNBqNwCR+8poFkv4DifUPacp6CFr7trNZaZPtO5Rje+Konp0eHTpQak
	+704PkLTICupU5wibdxzD1hJTuMgLnZ+Pj/dVl2nuadCVhU2Ei1K2cV98p4Xr9BbmTt6U8
	fk2RSDmlfaIp7t5zZ9EkjxeTLacFWNA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-TBHWnL3kPbuRJFeABETjsg-1; Thu, 29 May 2025 02:02:32 -0400
X-MC-Unique: TBHWnL3kPbuRJFeABETjsg-1
X-Mimecast-MFC-AGG-ID: TBHWnL3kPbuRJFeABETjsg_1748498551
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31171a736b2so924337a91.1
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 23:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498550; x=1749103350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XL7na2q707MGwhuwlmpiGvZQ5mpH0ZBTH40hCat7Z8=;
        b=avsHM46eKWaDyHuk68iHtM7D8nvyUYwMP9k1h57RZmN+Y3B0AoO/ihe9KiswzPBh6P
         p6d8aaE/xh/29xifpVjg3YD3iQgI5wfsqhEMMbhIw6Hi1kM3aGXOVQvNuk7cbj4FZRhf
         pZdZ3RPeg5VADkzoKRLZRpM5+sBXiwyIsxayT3kuWSUIhVxrus7GUKrH3O6UokIIfcPw
         sVMzrqwim8ZImf2hUUIUaeG6/dJbBvkd2Xpw/Ln2bI1V3ejt5BEXvmYESjN7SAm9EtVK
         0ewY6OLRl3g2asDx4TIPxgpbcIrFsyR+6TEWseH+7bQtUI8GbVnQ83k/LhxTeTCuLta6
         eSnw==
X-Forwarded-Encrypted: i=1; AJvYcCXhU9avm4vVkJWjWWj6WgeKwHPgx7AJWpU9akuDfDUNgLZZMQNQG4E3S7h+Et6UdtGnIP86yR/ITj1HRVvMcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm7ALsoULkplwdFHaJXi1rrH/NhGuHgDjfUXzWIbTlPaSkR8qx
	5HyQpiboJInZMTZ/YL0GNkwA/PQUSM7aJ6FX48vs1uDPK6Rr0PwBP7p0OewcRShxeoI+XnDULY8
	Y9jgWkh6ZrEziHJ5oXIyM8vorPS8IieSR6sUvXpb3waZk3dwgL6ZusioHgwlhI/PCrCGYRNRVFq
	+2z0YN722CL99PIi9dARpEdYk9Z8rjrdG9ZGQFeZ+bD5ezsD/Tpl/WUw==
X-Gm-Gg: ASbGncuTJ+nRdtXvKqpr/a7ezPueDzN6mZ26XgtCNY9M8FKAoOqnIZcUXCbsMTCy7Ye
	fLNFj6ImjCWfm1N+VjBEvYvScUnsElH9IThu5Qjs7DsqEx922Ecakfn1cqylIVmA0OgB8jw==
X-Received: by 2002:a17:90b:3852:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-311102ca59cmr27730776a91.3.1748498550377;
        Wed, 28 May 2025 23:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1gNWq5cK3jReZL/0sdiUQ+L4jIKQsRiEpsi78tpKqjSm1UajX2yfQghizAo2fBaBPQlV2oeLQs/wO4Hvrq0A=
X-Received: by 2002:a17:90b:3852:b0:2fe:6942:3710 with SMTP id
 98e67ed59e1d1-311102ca59cmr27730737a91.3.1748498549897; Wed, 28 May 2025
 23:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
In-Reply-To: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 14:02:18 +0800
X-Gm-Features: AX0GCFvXzCMiOni-GDOpltnH51_T4C9rhPbEoqZ04wmzxIWpQ2nVob_9wMLyp4c
Message-ID: <CACGkMEuYQ7PXUtoyUOVyL7TY1wRZUhiTRfDnQw+gwE_yLvbtvQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: document ENOSPC
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JYX87ek1h37bliKICP2uix_NvrLJ9toXcV-03unvGUc_1748498551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> drivers handle ENOSPC specially since it's an error one can
> get from a working VQ. Document the semantics.
>
> Reported-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b784aab66867..97ab0cce527d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue *=
_vq,
>   * at the same time (except where noted).
>   *
>   * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + *
> + * NB: ENOSPC is a special code that is only returned on an attempt to a=
dd a
> + * buffer to a full VQ. It indicates that some buffers are outstanding a=
nd that
> + * the operation can be retried after some buffers have been used.
>   */
>  int virtqueue_add_sgs(struct virtqueue *_vq,
>                       struct scatterlist *sgs[],
> --
> MST
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

