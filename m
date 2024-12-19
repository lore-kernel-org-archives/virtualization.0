Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7541C79
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619714; cv=none; b=fGFWMbvIqSeaI0d60OoZpY/7n9Jz/VH6AQIjnWePyWcMUWWMn0EWh1RUo5V85Udp8G61RYppRwoU0hj6moTF2fIrnw9CymrQ8S7F51GGH5rG8OWM02CzIiG98GT8oH/Lyousomx0VOMWA7gG0UB50fZsZCdK3hG0Q0EwGPUEtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619714; c=relaxed/simple;
	bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPZ1vjFM7T96YavKW06nwSrJqnOOtChOaCs1e4MK59+tMViar8lyv/fpO86+hLQUcBwh+oK//OsdRmf1D1BeOIDW7Kbdr4xonBtAaqBs/4ayifCY2UYMd8+o1p79Q4cnWQnuA9OzAXJ1pD8N8+ea9CDU4IA4s1zeKn3One1qhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFBiZokk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFBiZokk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734619711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
	b=gFBiZokkOMD0s8idYZWsNPB1t7L0t1wn/tJxIF/AGM6dXyuAlPIbbfG9KbM2holsJh4uD1
	N93GTXpLNgi3J3pDQorhT5Oczsq5DkhMbQ6wHP+TjvpyLcWYWht2Re9l/I8K+6iJuHrXpZ
	wqRvS+0eHooI0mhxGK1iW/itkMMpIHA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-QaeQK21jOhOy31fKCjPv0A-1; Thu, 19 Dec 2024 09:48:30 -0500
X-MC-Unique: QaeQK21jOhOy31fKCjPv0A-1
X-Mimecast-MFC-AGG-ID: QaeQK21jOhOy31fKCjPv0A
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6efed40a56aso9417097b3.3
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 06:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619709; x=1735224509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWynjvh9dabSYwRUA+Jjv/DQhoRvo7p8rsykS+/gwvY=;
        b=QN6QhV2QfPHxgMO7fawbuwzAgY27iHOgvV33rPY6Gye2K40IRe4QICvywofKDoi2i7
         ZunF0xaMhbZNSAJJzoJCTIlGgZ8Y4sQWoIjFsFWNwn1n0kL8TkUnUq8s8i219dNbp5uP
         RHIfjZo1QaKcp6CRx9H6w/gKbl3/uPlz/zL7cXf9yUQGMnABx+YdK/CElp2ScfIN0A/R
         j685x9pRq9mFusMK3hw5w3vfdDvdkIN4V7H/TxG2uhD9sOjA1Ps4YF+THL4Xm+B6cjo2
         lUxyuoyk91nY/Z2f245tryXZuXTFmh7VsxPZAyEKf6pvX9ZYVIHjh5J6O5tPaNjfnNM3
         CjzA==
X-Forwarded-Encrypted: i=1; AJvYcCU+UuM/24DJGjVjIQ8RmQpkivX0M8BY6Lggmz4gCcmTIRG02Jg25Szyr2csIyd3JNUzMoXpZPwCW0XaJLgzog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkQmawi9Ff9h53DQzKATdI6PWIpgBClxf8dC6WAkR0VDSfhAxZ
	rFF09QrhFcMqzgVYIwfaGXu+068z10+8agppggfBpn4WquO7klQ/6xG6TAVplmWjtjTcdPuoM8Q
	wB3zvAie9LN8T3vhDPJu5wVi2CaRupeHBGdiXrixoMF6n2nndHQ+q77hAVFpD71trbLUSYVZRgK
	RRCDopRWzzyyKyK/uVJKZbMqk76GDpZTICJ/vUy6AAeJpDhcF/9fmy
X-Gm-Gg: ASbGncuosF94H8vOSpKUelaYHCVaFED58/8NQw45LG1HCQx/haut005e+j/pwkRUhJ6
	c4Y/9U3UuSxQwWuPmzIennHHbz2+Xpevqqaid
X-Received: by 2002:a05:690c:d93:b0:6ef:146a:aac0 with SMTP id 00721157ae682-6f3e1b33cc6mr28410137b3.4.1734619709694;
        Thu, 19 Dec 2024 06:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgYDQOhtfDr+AO1Qgyag7331PuEiAbwWl2ozIO3vR/nCLHHckhLKLG/7TJoTfW7k7xl48SvjELlcyMVoR1Ttk=
X-Received: by 2002:a05:690c:d93:b0:6ef:146a:aac0 with SMTP id
 00721157ae682-6f3e1b33cc6mr28409887b3.4.1734619709336; Thu, 19 Dec 2024
 06:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX> <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX> <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX> <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX> <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
In-Reply-To: <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 19 Dec 2024 15:48:18 +0100
Message-ID: <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	qwerty@theori.io
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nw-_tZfRTi7u_QzgERHQ5yDNzcef4xLiFqOVJOxxhVo_1734619710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/19/24 09:19, Stefano Garzarella wrote:
> > ...
> > I think the best thing though is to better understand how to handle
> > deassign, rather than checking everywhere that it's not null, also
> > because in some cases (like the one in virtio-vsock), it's also
> > important that the transport is the same.
>
> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
> it impossible-by-design to switch ->transport from non-NULL to NULL in
> vsock_assign_transport().

I don't know if that's enough, in this case the problem is that some
response packets are intended for a socket, where the transport has
changed. So whether it's null or assigned but different, it's still a
problem we have to handle.

So making it impossible for the transport to be null, but allowing it
to be different (we can't prevent it from changing), doesn't solve the
problem for us, it only shifts it.

>
> If I'm not mistaken, that would require rewriting vsock_assign_transport()
> so that a new transport is assigned only once fully initialized, otherwise
> keep the old one (still unhurt and functional) and return error. Because
> failing connect() should not change anything under the hood, right?
>

Nope, connect should be able to change the transport.

Because a user can do an initial connect() that requires a specific
transport, this one fails maybe because there's no peer with that cid.
Then the user can redo the connect() to a different cid that requires
a different transport.

Stefano

