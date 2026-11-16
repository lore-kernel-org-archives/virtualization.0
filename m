Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831371;
	b=exlM1JCw5qrIO/e1vRVmL6LOSawCGscic3zqlbq2cpujPexGUhJEOvq2X4Q5JsEOq5oN
	 SdRk1ZRjF5/GvqMwP2sDxQJUJhtimR3BXLc0/AvdV4JMqerhdnv4fgmf1kgRgrd786uJ6
	 uTNDk1U6JCB8BYcUmWjN8u8zVsxN3p1Gv4ijiK+QgmRP9KiY8nRVQa2kmlB1gAjX3JozG
	 K0mQVJUvUiLz30+DDtFjsCusW3kzsFiKGWIr5xD52brxOqD8oTeDB/zs5zzx0LKMFFNLg
	 Q/GalHaULYNkOHWbWlMM65kUWIolfNq8gi541xfgUxeVolzbhe9bCoo0f+T+9T6+dRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831371;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=hagfi1157KenUDCT/Gf/vwimxfuG+ZLb+Q+ggtjfRr8=;
	b=VFTvfRYhohUx3iK8ZHFKav4eEAsq1OWcMamxWNHDpoDEUee7huxK5qLxDofmzpxR1h3G
	 XbIGVIk7nsxG/7s2PMPnf0Pgpxoz8nlv0mitu2eX7BZG6msPsWG1uBvdcYAnu2yz9Rzck
	 OzgPliBctQSraEtnzNobcwLPGwCHM9HtkANTuyn0/jmluwKXSWrzG2iSI6tSbY1zwmS5i
	 Xc19AmQedyQdfGP8q+C4Z45yXFA5PJtTI+odxs8Mm4mnpQ55cQKzG8fuxorfoFzizSJZl
	 rZWjvrNhgfOI4YL0rsY+MLGSMkudRtQjKUZYXzAiqv04vPDc59ywNxbbp2ahiCGT5GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EU8U93LM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D402606A332
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 12:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D402606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EU8U93LM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794831369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hagfi1157KenUDCT/Gf/vwimxfuG+ZLb+Q+ggtjfRr8=;
	b=EU8U93LMgTjjplNGeidaoVrxdStg30sW3oKHjPyPu/4tUK+GseT1VIDTh7UyTQaDhY1SzF
	QXDNkAXizx9qLkytoa+kXsHS7ZEhnjADOz90WOzHrMlptow/M/CD0GMuAiqbhQ16FKmPEd
	mr9Po3YluGXuqv7V5rI19NYUkz3wAjo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-D3pGrA1rM6iDl5YkHrL1cQ-1; Mon, 16 Nov 2026 07:16:06 -0500
X-MC-Unique: D3pGrA1rM6iDl5YkHrL1cQ-1
X-Mimecast-MFC-AGG-ID: D3pGrA1rM6iDl5YkHrL1cQ_1794831366
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67dbb53a803so1279705d50.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 04:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794831366; x=1795436166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hagfi1157KenUDCT/Gf/vwimxfuG+ZLb+Q+ggtjfRr8=;
        b=06R/f1Pn/+Omodzve7/oAgdqV8uoo5NLjT7MCnUkRjiT5IQAjt9cB4ahfKi0I8G6I6
         G53vBqtP/FO5D8pVgAsT2VBT9+OqM67890ZVY3X25UR9rIzMrKWduq2d+afKzqcifQqt
         jFtzsmJyflJA6+CJAGTJVaBHma7ZxVsphLweK4IKREAZGi38FObPEEHbxOP2uaRHW1fr
         LKYivmiNwmrqu1waQhRRBfKpAoPvb7246MuaMpuxdmqGyMqPs5wOElzA1WDZ7bW0k7jC
         7zW2OVwgJz/kAGzXIDoL1T+FC07Ws3t4AfMk9/Z+0Nnww/IztMU6ETHk8Vy/Br+69gOw
         tU5A==
X-Forwarded-Encrypted: i=1; AL+hErEfQ8ictophDhooiF0yrnLX3w9uNhjbESHmcL7DwtsneHR42XKisEh3mS2/Us2fPU2qTGLl+HOSf845OEdfvQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ypbIxduqhcNFpxHzXCGiesDl5nwyC228mPgWa3CUxFizM46n4
	w7l5bhWpoAgdppmHn6BVgY1vkLGvNRCFSbCygyDVgG2rdadUxEcPSTlgzVR1r8KyCUt+FAPl+eP
	mkuCMA35AlNxcUUSnCNffyw3smSz5MXAmXQUHF1ymcSQDLdzWYLZpO7+EaZ8knTZ99L5Ia76GlB
	M2fYNWlQ7JcDJHwZZWwgbKqsFIYJMGiW5esN71DT9dCDw=
X-Gm-Gg: AZFdTZd7c9IKZvyxMjY9ZXDF2YPWj2op+H3ypZ1knWz00NJPTCi2tdmO1XE8pVZ3wsP
	7JTVyp5leMaYmP2fNQCKm6lf69wCkjVEJNeNhh5myU87MopgD22aaGmFX5COVzPDNdQj29ytr4M
	67sof0CGIoKqfa39SnDWyWpT67TiOdqLhfNTg/9L8HLMN9ZrvYa2kg10XiPKkUa8zs18KCQ6vLo
	/Vu1tIY4wVgE5m00jWYryIlbeJOEhX3pSKApE1YIY0l3hX3oqoYZQdozS8=
X-Received: by 2002:a05:690e:1447:b0:67c:11c9:2d10 with SMTP id 956f58d0204a3-67d89828203mr7426508d50.89.1794831365838;
        Mon, 16 Nov 2026 04:16:05 -0800 (PST)
X-Received: by 2002:a05:690e:1447:b0:67c:11c9:2d10 with SMTP id
 956f58d0204a3-67d89828203mr7426492d50.89.1794831365223; Mon, 16 Nov 2026
 04:16:05 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261112154927.4004184-1-stjepan.poljak@gmail.com> <20261112154927.4004184-2-stjepan.poljak@gmail.com>
In-Reply-To: <20261112154927.4004184-2-stjepan.poljak@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 16 Nov 2026 13:15:26 +0100
X-Gm-Features: AclHuK9hknMzCwQmnyctLW_nYU9P8TLzSSsy1qjPj1v2VPieAeY0m88QS7tIYa4
Message-ID: <CAJaqyWdB=qZddhEPmKPOdUDALM-3M3z2OvwWq6hzfTAjETQnVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio_ring: reject a split ring size that is not
 a power of two again
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Francesco Valla <francesco@valla.it>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andy Lutomirski <luto@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, virtualization@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9hDLm06VgxrLAiO8pfEfBeUconfuCN4Yl1XiAp_n_jo_1794831366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:49=E2=80=AFPM Stjepan Poljak <stjepan.poljak@gmai=
l.com> wrote:
>
> The split ring indexes its avail and used rings with num - 1 as a mask,
> so its size must be a power of two. Commit 2a2d1382fe9d ("virtio: Add
> improved queue allocation API") moved that check from
> vring_new_virtqueue() into the new allocation path, which
> vring_new_virtqueue() does not use.
>
> remoteproc calls vring_new_virtqueue() with a ring size from the
> firmware, checked only to be non-zero. With 100 entries, for example,
> the driver would put buffers 4 and 8 in avail slot 0. The device would
> look for them at slots 4 and 8, possibly reading the wrong data.
>
> Put the check back for the split ring; the packed ring has no such
> restriction.
>
> Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
> ---
> remoteproc still reports this as -ENOMEM, although the "Bad virtqueue
> length" error names the cause. Returning an error pointer from
> vring_new_virtqueue() is left for later; the same change for
> vring_create_virtqueue() is here:
> https://lore.kernel.org/r/20261106055635.3019889-1-stjepan.poljak@gmail.c=
om
>
> v2:
> - Log with dev_err() rather than dev_warn(), and say in the message why
>   the length is bad (Francesco)
> ---
>  drivers/virtio/virtio_ring.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..f855b8d41575 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3513,6 +3513,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int=
 index,
>                                                     name, map);
>         }
>
> +       /* The split ring indexes its rings with num - 1 as a mask. */
> +       if (!is_power_of_2(num)) {
> +               dev_err(&vdev->dev,
> +                       "Bad virtqueue length %u (not a power of two)\n",=
 num);
> +               return NULL;
> +       }
> +
>         vring_init(&vring_split.vring, num, pages, vring_align);
>         return __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
>                                      context, notify, callback, name,
> --
> 2.53.0
>

