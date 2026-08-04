Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133537E5D2
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844452; cv=pass; b=FZJ0I1UndsoG5x5j2IYDuseFrVd1AMZDwiZ9vwNgJmAv8xIH2bauakTspMA2V79F14v/oD+piz3/BsnycEaLC1sCZnJBkEGM/PtAFURw7/Zkf+RO1/9971JOl2mOuIJVWCc0c2XKwcdWXX9nxO9CaKniDhwQenpwp120CvS+Os0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844452; c=relaxed/simple;
	bh=NiHYBO6mM54WqCxaJ6DJN8tIYDx1o+0wAXpicen5XgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqvaHeIkf6zcqNU+UbZBd9utQ1jkfQuPd75lEcY8BDWQg1fJh4KEq88TbILvlsSg/dSoavvXm2mh85pwpRVrNYQwKutaFt6inqI2rhSRsysCEUeuiG16WDArDw9ZMpptNWGFA1ov9IcRv6EGG/2ySsKWgmd0ej0I1Z/KqgjlBQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdyqgBN/; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdyqgBN/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39f75e0a2f1so34458221fa.2
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 04:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785844449; cv=none;
        d=google.com; s=arc-20260327;
        b=qXt8zVFnKB8yIg7gD2THlKPYugWLmGHsaY/kHwd57EfvqUwpXzViVSn6EXbEA2x66X
         V/6Jn8pDdKzgeWFLY/5ErYoQCC/dfAykGF+FG0p6WEcJd0B5gA8W+dCL1hgOc8K38fBM
         a1+sHMOGtnjVSIWbnFcFbAGwY3pUKZK1fS1LePP9O27qmj7U0KNIzX3gwMEsGcjlsO0w
         27kq8SstjTPNULh1wwrgk+49R4BJEyDLBeKHEelpSQ4amzzuc3Q60FN04PIzKlCCOR6J
         xj5bDX5pC6a/TKzD93Di3ov8d3Zn2IuQB7g8s2yor9wglxiMOwN24F2Z/z5mi8fKIiHd
         Q9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        fh=maEkpRAyWUgYLRnHbJEnijivu+q6k/gB+gSDv/o1GNQ=;
        b=ZKLzhNGKf0b4WNPJb9J1gn/N3Ct96Pe9Q/7WRDXszW2tA2zb4I2fhK/Zm44Ru1c2Y6
         phmLrEIl5cuQbyEPiGAG845krmdcxt6Dd0RtsLnnjpwstWl73ZlQQZBlYTJlios+1BKo
         VRf9hbyjYS7kCQc3yViPXTLvmvSRuKIDa5uTou4FUZ4bbKtBOFAQ5h3h+P1yQcSejmik
         MIKd1KKeLoeq4KWwb2X6wJUsroFdgxxyTVWq01vAY7RAucT/nQVOXFn+kJZxBoKhYk6T
         EPdkQfPOyfaTL18XJ/gm8Bz0Fj1tTzryyqFsjOhd3wPzIHNPzyWCSCBIMO2ZuP7St+4d
         +TcA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844449; x=1786449249; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        b=UdyqgBN/fPdaZYIuKpZ09T49VQsUY1zKr40xMCBliD2dEvPUsMrKsQUcGZoh+kjFuT
         hYnsmbESPuw8NEZozO5mVdz1XBsrMFRsl9jLYHCqCfkTQYVxDed24v53bHx/WADhc0aB
         7uGlh2idUHwvthy8EoovIuBvN/BKBkIG337csLwl8ZBPxh4Lw9/58V8rWXu1I5+aYiBC
         WzQNxdmQ7ygvu6H0GQ4WqN/YaShWtumjbGE67m5Lehyc3QpePmUc0WJyYN84vUFKYGgF
         uy2qIdCs02WLNqVrlU+txKLbPxiqByYvwLZMZfdUAeuSu761H0aW8TYVSRObg7YV7Ea1
         +0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844449; x=1786449249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzEDkw2lgyz4LJOfYQbkuDjFz07+NbqDM9wJpqc6Ag0=;
        b=m0oX+PbVkuJH6J7IMyq7rmXfitJXHc6VC/oTXO2NVEIhI1OQ/lTUSkJf9gDM41n01g
         AaUICbD+wJrzkRcg/RoKsiPEiuTeO2kmygn4nKvE3j6I5cg+cGHaFGJb0BKRPOGswjHv
         6kpt+oxzlkJhWwHpz2qSeL/uUtwPTSe7rk8naT6UQL8RPp8CC55EzXRwArXo9gMDjK1E
         ltcO/B9ZfcYxf/JWqwRxR707AyZm6BqLTqIc4ePOKredwS2F+MEHLj31D9jlM8VubKsd
         Hy8LpAc0Q9+o2TjHfASYBkJuvxNppY6yrj8QMhlDbpXfd19cX1SIQTD4PuDXe5A3hMGc
         05pw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9o0+rCnEpZ6UprVTXC2d7MrMoLRoTdXhkpziIZtP92oSSr2cjeMxvDXxfijJIuoiXlAJzWwZN5/9u9Mv5yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEH6YgSNRvw+25rGRBCTayJ7nIElkcidv70WSRu7/TewmSZWcD
	aYh8h1YO4PCzP/gWmTlYrXberU+RDOtozWvRrg/mQYoJ7KPOc0aBiBF/bEnCJdzxBvUOG33xXJp
	LBIJJ3dqvDNnswlbgAousOBYdsNSQGy8=
X-Gm-Gg: AR+sD13vSp3OeqnnaVzqstY8WI5u2IhNOooYX9ebn3WAQ/+LP91bd3oKLH3qu+7f+pr
	EVANTLLlsmrtfyu6mKZAjR16ar0QZYpbDXZk8jBt9KtEVbAKe62BIe+7uwbqnZpmKudqg/USYvv
	VsVzdclh+xoT+3PF1aoxZBgN9fr0HXO3L6N+zsDzn5sgEGVidzs537lKb0UYlWbhwmqZshPL9k6
	rnwO+NfhYmXgxRb430kTLDnc30vKhj2qToAEDYyaxii3xSvm/3rufiSkgxQWThvfWXv8hGdMXS6
	zIMPPx3AvzeUHtSdR8c4R7N4LFRy7YDwE5a7XO1jkmj7B/eXUzxw715e9rWFoaGDqUuX73L4CFQ
	G+Dp61d/1HCqqvcgoS9N8TriS6zexEh/LVfxXjo8/do5odmbu5j5llWqUeYU=
X-Received: by 2002:a2e:a99f:0:b0:39d:b60e:d70e with SMTP id
 38308e7fff4ca-39f8613f0ecmr28953541fa.3.1785844448678; Tue, 04 Aug 2026
 04:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn> <20260804085330.1333242-2-xiongweimin@kylinos.cn>
In-Reply-To: <20260804085330.1333242-2-xiongweimin@kylinos.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 19:53:30 +0800
X-Gm-Features: AUfX_myJfe6cC_LDyaq8piVi7GizRNnxneLKwPSD6Rv2uLsowGjk9JnmZPaYfjY
Message-ID: <CAL+tcoCVPfyK3o2Ps1eJgifAntffMSB8OoZc4eRqw+NHpz4mig@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio_net: unmap AF_XDP header with tx virtqueue
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:22=E2=80=AFPM Xiong Weimin <xiongweimin@kylinos.cn=
> wrote:
>
> virtnet_xsk_pool_enable() maps the shared AF_XDP transmit header with
> the send virtqueue, and the disable path unmaps it with the same queue.
> Use sq->vq on the setup error path as well so the DMA unmap matches the
> mapping side.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Nice catch! Thanks for your work!

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6160aa8ba..a6f90f579 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5959,7 +5959,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>  err_rq:
>         xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -       virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +       virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
>                                      DMA_TO_DEVICE, 0);
>  err_free_buffs:
>         kvfree(rq->xsk_buffs);
> --
> 2.43.0
>
>
