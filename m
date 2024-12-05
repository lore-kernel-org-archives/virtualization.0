Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291F1A3042
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383957; cv=none; b=oTxg97Bb03II9CoFa+oxRlkkRYH7ZTCuPaZqBChPUvrFFLgYj47mPVzpE/u6oaTJ2M+BVTOPlPN8usBvJs4PPlcVvE1cbIbBbGc/eqMPUfToRy2tGgu96h9r2EvqvzzM3g38QreFaj/Sxw0/F7MVXAfPuN+LdZHaXGEyzaEpNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383957; c=relaxed/simple;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJSODKaPKdXAAgJAWq8rJSfx2gVESJwJTTOkp9c1czQm+8me4VXxt2w9FgaToTn/gFmGthcKEtYY6Y5BzUsdcAUCYnt+ckjGHXTR02S7Q3mFC/3G2Lvffb9zTJHEFlvVcA/iMS/0YGnpF57BPfHcFVVslVedN0OTWRuU4JLO9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZwpdw+h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZwpdw+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	b=UZwpdw+hxSeMcAegtnmvko+kpwfH5j5SXg2dEyrBf6BnxJjZIA/aGK0vsIZ4GAsuJaiClC
	1UWnyeG5KCAF3hN7Iy6MaewoMLLc5ifgZONonmLt4VkV7i42j85JPdhnt4wS6wc/J7S3Dp
	KoSksl0XJEiDGA66XOaCxKrGqWDwbJg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-KYJRfd7UPiO0jsmqk3xWwQ-1; Thu, 05 Dec 2024 02:32:32 -0500
X-MC-Unique: KYJRfd7UPiO0jsmqk3xWwQ-1
X-Mimecast-MFC-AGG-ID: KYJRfd7UPiO0jsmqk3xWwQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6eb39edaso829653a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 23:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383951; x=1733988751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
        b=ZBOu4fIsg05GhENKZhR2dA2yeqLaTyLhNesphm19CA+VNRBkKPWxWzMcRQhZEAvvOO
         iwifNMgFjysilLdHcYPfTga7pBPzcNg7YMxfl1tLz/vrVlN29U5kbcbYcDPRoMTMW3fu
         QAuejOVKNjfMKD20H4QyF5vOE8mJToqN2Sk34meTGVuZH6gAkOmdVhIxRHCSQ/hUeJTP
         aI7/tC9EIsw6eOdZMWI39oEOKMu1KEP26/48DSE2dYfH9PrMnhVzt+1FnZqt1UOa8zLv
         9TyOg7IB5KGL4biO3v4pgbubc3G3SxotMHgbdSzhpfXnyjzH2183GDXzEb7wKaCd2dQq
         4Jdw==
X-Gm-Message-State: AOJu0YyFUxI9SdK8GCwRMmARQl+ydXUnmKdoKJyS+6q0MACix06BaPnR
	36y7xqBf2Q3eBOQuvtpVyi7MUYW4kLxUUHKVb/hrALLcvelqCukjWkArJePEkm3melEOW+3Vhx2
	jg1vJqX5VcDzAQWIiKFzxCRCCyFW2N0uQc57z5Bto1PDtnyyonYYetpSA/GXtR3rcXZys/7rq3V
	08I72DO0AOeaFipuaCk7PsP+GAT2jahAP1kMamfFU=
X-Gm-Gg: ASbGncuRpJrTJ/F8ZiiL2Wp0cxN9ZAJv6LN6i4ux3J6JXO1AIhNJ3jJRbgAYXqeb3kJ
	AUlDDSmhxW4oorTC7PcOtqaOHYPi2z/I/
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2ef012446e8mr12752044a91.24.1733383950953;
        Wed, 04 Dec 2024 23:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00pmkLuLXttemKJiKF9Q/OxhVoQePAQMlOpYi0wt7eK+3w9Uxtm8XqdoXThMNr2b4ra7bR0qWU9AsuFmRg/c=
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2ef012446e8mr12752030a91.24.1733383950636; Wed, 04 Dec 2024
 23:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-6-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-6-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:18 +0800
Message-ID: <CACGkMEvHUQDfAjeSBdNd0iotrgyjkbXuZBH7ehs6dZ74prspdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue
 is called on tx ring resize
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: flGgGjpxnkC1fHugyhZn4U9C5Eq1IhZKSDRbBZDkEW0_1733383951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
> be reset when flushing has actually occurred. Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
> handle this.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

