Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1B288DF
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581822; cv=none; b=pz5H2S3LGMeFmk+kZ3h6b3wWo7j/JWsa9DlW+9vQBCDKYddrj4nIsoV93rXU/MEFRZfEf0He43pJe9eoVbpf8G3sz+4WQp5gRQ8eG+HF4UUlFg3a8m4Q1xEx+CRPG7hgn3KsAs3ETUe8UPSMPOB+wsKQ5APa2xWhhjdIFGiGa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581822; c=relaxed/simple;
	bh=e60a2asA9Ve1N4Z1JddmItByU/gQ1qB3RGuVGW7iM1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auJYAUh6/sjFY+Qv/54MMPiZqRLN2Lq+LB8NVuQjaqeRJN28r1Vpkpvety1s0wWIDRHsxpqvVkleBx+BGqTOp3a0w97PqNjg/knrOKmDqNC7EUspNxcdKYXrXhWIsQgQdOniOpwmMkIbdUJmOs1+uMx5Rxq4s7SDHrL5d019Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aiUOtJxF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiUOtJxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZswbjLB1y8lw7MUcnotzFxNVGtfWvLFPzmA3BKP3mY=;
	b=aiUOtJxFjdNu/FaZaSomoXvwAGD3g1RYJCyjsiDgsYeadnVZxfl743/HtGkYHtdVvp3CC8
	Zlj2Fjdc16z8ewiLVr7LBIW8ETMGpvgXoTAsGb/F8FvD1pyPs8DU65Q1BdbdnTUnon6qln
	I7XbPx08VAmGcbjX5d/iTnUcm210Ys4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-HS9Oti-NMeiKVq0mywgT-g-1; Tue, 09 Jul 2024 23:23:35 -0400
X-MC-Unique: HS9Oti-NMeiKVq0mywgT-g-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70377dcee38so1474362a34.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 20:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581815; x=1721186615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZswbjLB1y8lw7MUcnotzFxNVGtfWvLFPzmA3BKP3mY=;
        b=eHw1LZgDe0U0Zt4jweIUZ9P8ek7LaUXtNdp400LeofrYqDnQVW7jNwubjjdIuqTXg9
         tvBKJ2//g9EacjHUzKtN/zfdvGKc7HxlSeefvQQhyUakwvppzHLtmIOPGUGARpm/uEzz
         CpZqbf5cZgSy43gktpu04/XtDTBcO6gahvaVbF35sBDyQKkBPxWNQ1hX8j+gkfgdADkv
         Uwdl+dpQINACIHhPcCwTsGpl+z9PQj+rERrRySbRHizPSpExpWeQA2c3VFH/WDKYUAX/
         AqAnKAtCdJ523VcN8ZfCtp7lHrGha2Yddb4f2sEURpjd3MlqlB0iLDz2nHlRvZCBoAZS
         3C7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt0cHzhU55GDQ8j+KTZ+LRF64ZPB71aXMWY1/JbaC0qVX6EXBxlC4CiZznHTfU0hxycDwsllOkKMEhbjI0GP1YXlSRKjdvhSfWgshCWb4=
X-Gm-Message-State: AOJu0YxTdaV2oxo6+/rpSy8ezOBU4TACvvC1AboiQxyva3EFUsXBESK7
	H/IeHCBqzZwjhHZX1hOLjLC+GuOiFbljEA9Hh/LN7ghaVnkv3hIONe0BtCuAMa8xeLKbRmQwBHQ
	QJqI2B5TG1CiTqK2JcLuVgqGDUyLWIPvLoGNs+BVf1Qt8g72Dj40GlkAuohuG2Nf29UBNwVL9L7
	OkUVYGPyEYB2mHG1ThB0M9pc1Kc/esjeSYku6Q7DI=
X-Received: by 2002:a05:6808:1206:b0:3d9:26ad:dad0 with SMTP id 5614622812f47-3d93c10b44amr4356479b6e.57.1720581814705;
        Tue, 09 Jul 2024 20:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE32zqWgi+EMG3PGXtiSEfre0Nfibo0rJwV8l+r+oMHEMd8b/xBj0gNNkQMlOQ2EwwZHEb7fC5I6r3y5AIPyHI=
X-Received: by 2002:a05:6808:1206:b0:3d9:26ad:dad0 with SMTP id
 5614622812f47-3d93c10b44amr4356470b6e.57.1720581814359; Tue, 09 Jul 2024
 20:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
In-Reply-To: <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:23:20 +0800
Message-ID: <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> QEMU implemented the configuration
>         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> incorrectly: it then uses vq3 for reporting, spec says it is always 4.
>
> This is masked by a corresponding bug in driver:
> add a work around as I'm going to try and fix the driver bug.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 9a61febbd2f7..7dc3fcd56238 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
>
>         err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>                               callbacks, names, NULL);
> -       if (err)
> -               return err;
> +       if (err) {
> +               /*
> +                * Try to work around QEMU bug which since 2020 confused =
vq numbers
> +                * when VIRTIO_BALLOON_F_REPORTING but not
> +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> +                */
> +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTI=
NG) &&
> +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_P=
AGE_HINT)) {
> +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D "reporting=
_vq";
> +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D balloo=
n_ack;
> +                       err =3D virtio_find_vqs(vb->vdev,
> +                                             VIRTIO_BALLOON_VQ_REPORTING=
, vqs, callbacks, names, NULL);
> +               }
> +
> +               if (err)
> +                       return err;
> +       }
>
>         vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
>         vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> --
> MST
>

Acked-by: Jason Wang <jasowang@redhat.com>

Do we need a spec to say this is something that needs to be considered
by the driver?

Thanks

