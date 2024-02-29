Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B379DCF
	for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203731; cv=none; b=p4QPN+tZQrHwpnviGx7qqUfzBKYDvwqpnhg32iG8rAl+3AaHfCAvhTweMTl5bn0t/yGEWmGGYtnfTg0UFxARbyQfJTQlixiGXctgzwC2oTvjelJ8lzNXTCJUDHJC/LrCBbjIGJuv1RDYct2mntm9xtsKFGKrag6EqPm/XIXIUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203731; c=relaxed/simple;
	bh=U040oU0vEP06i1C25D56/VpGVa5ZSvafwiSSOBz7nWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6gySe4q8fH1ZYkInaE3MOJ4D17iAZ9fQawEWd9c8wu6xTnNBUwejcbC6+CHV6A9GjTp/ojRRsYY2Aj8bTCYfXzksaRdEJHfT2Ff5Su8AsL5d/vQx3FLMekc4srmwTYzOg7B1nffgM8CkkyBLpHBwfRTd2RMXngosYUfB8woJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SglJRMCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SglJRMCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709203729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=abeHQN/Ifs+3w7+L704xqLeF0Y/ZlN8gh1Nav3s3twc=;
	b=SglJRMCoZo+5tifSKcFnhpDowddxamb9IDaYLxe8yV3ow4Co7ShZhdwP4GL1ChfST2Ikdw
	4ljYks5hJgci0k97NyP222DsE0BIUFNhNrmpEcAd3FmX1xQo03YRNtnxegDsEagrADrQH6
	JuF3PSchB93bXt40SFjijm0h//GTuqA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-yKO7ciJmOxCJtKE_dbFdOg-1; Thu, 29 Feb 2024 05:48:47 -0500
X-MC-Unique: yKO7ciJmOxCJtKE_dbFdOg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5132987ccfaso52198e87.0
        for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 02:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203726; x=1709808526;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTQNgwDYWMu50d3fX4YnqzUpTcfqlF52qDT1Uxsy8p8=;
        b=Ovn4UY+uwGRBNxUhjfA4w2VKHkf/zyCc8CVU6wX3UFBSzLSFc/83JSd7Cylz7zxdXg
         j3jV9jEd62SxyyYTv8OdnUpcvWIxKbnpqWGEBAQO+5MjK5bpQyF206crdfvWPo1Ob9pq
         MXVLfCoLjnnpWNJ/lXnTjN3m2lYbdK4kp/zC/0mdVJngIzbU7r+ENp54LzqDI8Xg988R
         QKYmLFibWezcFr7GkKi8WEqxa+cYNKoG8HZ+ABfQTnu9OeT9+vol3zvgwHWjqbXwQGN5
         JR8i98rFrVbwk1QINSUUKZ2hIsKhL4QyFh4e/gZyLb55ixQDa8Z3ZpqqifCcdSB1VO5L
         ttPw==
X-Forwarded-Encrypted: i=1; AJvYcCVMI5aMOcFVTZkyb86PcryT9+M2VVCqGNiFdzW2xxd4Fg0vsajFTF9VLBKou3qRabGS1lioiqqMuT92YShZibR9iXtZnfE6VS67/GDHeww=
X-Gm-Message-State: AOJu0Yxm9t+e8Pb+LrjzNWDa6NRcK/1UnHwm7DLZXaeIydl4iY/7gu1B
	vWMS0EHHYYkNk4qLCxC1+vYHYSIRoKADTGxJRy8L90b/amdMg0nvr2Mre0nk6+je7sCH70Bp/of
	6hU+tgUuB4RwsP26xGSuWkpND8TXT0ecJXZ8O5erbGC21Tu1ROOI1HArC+PMZsfKv
X-Received: by 2002:a05:6512:3b89:b0:511:9ea2:f589 with SMTP id g9-20020a0565123b8900b005119ea2f589mr1463611lfv.0.1709203726265;
        Thu, 29 Feb 2024 02:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS5gieFTKdIGG4SJuTQlGR8TPXmC/tE8BJ9sq2UItrPbXs/wsObrdj9Ky7fDTCqAnBObdqLg==
X-Received: by 2002:a05:6512:3b89:b0:511:9ea2:f589 with SMTP id g9-20020a0565123b8900b005119ea2f589mr1463595lfv.0.1709203725888;
        Thu, 29 Feb 2024 02:48:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id bx5-20020a5d5b05000000b0033e103eaf5bsm1159217wrb.115.2024.02.29.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:48:45 -0800 (PST)
Message-ID: <94bd28f625f7ca066e8f2b2686c2493cfab386bd.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] vhost_net: Call peek_len when using xdp
From: Paolo Abeni <pabeni@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kvm@vger.kernel.org,
 virtualization@lists.linux.dev, xudingke@huawei.com,  liwei395@huawei.com
Date: Thu, 29 Feb 2024 11:48:43 +0100
In-Reply-To: <1709118344-127812-1-git-send-email-wangyunjian@huawei.com>
References: <1709118344-127812-1-git-send-email-wangyunjian@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> If TUN supports AF_XDP TX zero-copy, the XDP program will enqueue
> packets to the XDP ring and wake up the vhost worker. This requires
> the vhost worker to call peek_len(), which can be used to consume
> XDP descriptors.
>=20
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/vhost/net.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..077e74421558 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -207,6 +207,11 @@ static int vhost_net_buf_peek_len(void *ptr)
>  =09return __skb_array_len_with_tag(ptr);
>  }
> =20
> +static bool vhost_sock_xdp(struct socket *sock)
> +{
> +=09return sock_flag(sock->sk, SOCK_XDP);
> +}
> +
>  static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
>  {
>  =09struct vhost_net_buf *rxq =3D &nvq->rxq;
> @@ -214,6 +219,13 @@ static int vhost_net_buf_peek(struct vhost_net_virtq=
ueue *nvq)
>  =09if (!vhost_net_buf_is_empty(rxq))
>  =09=09goto out;
> =20
> +=09if (ptr_ring_empty(nvq->rx_ring)) {
> +=09=09struct socket *sock =3D vhost_vq_get_backend(&nvq->vq);
> +=09=09/* Call peek_len to consume XSK descriptors, when using xdp */
> +=09=09if (vhost_sock_xdp(sock) && sock->ops->peek_len)
> +=09=09=09sock->ops->peek_len(sock);

This really looks like a socket API misuse. Why can't you use ptr-ring
primitives to consume XSK descriptors? peek_len could be constified
some day, this code will prevent such (good) thing.

Cheers,

Paolo

