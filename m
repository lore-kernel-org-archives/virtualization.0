Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC631B292
	for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yKFYQgVO"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabd1c701so11180582e87.3
        for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705355085; x=1705959885; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dKtPTrWnoc6fMe3lLbkoCZ1Tu8sXcss1oKD1gcrdh4=;
        b=yKFYQgVOUBJgmCssXAcUEFUMC2H7INjGJAIN2wgF5T9kuJ3K9Ichi9aX7pPcsYGGuq
         wR7Qf82m/9fSbnDajkxNIPvPIsZBpJqTNy750eTuwLs9lSRxq0E9KMp4rzCPB37GH4p9
         VGvO6dDF44xsBQcZaEjq/EyOQvmF1bxUibNPCPJxnZpSHAufhj1/ifeAH1wcwhkIKrKS
         e0V2eX6xKXKC9ZRssXN93erQaGRTyfVZepGmu3tA6JEw1aQ4iqI6U6CckXpG1fJ1UI+p
         h63W5jMgqkZhfufNL2ZkBS8NSVjdQdV89pbVvT1El/W+tbAoA7nMHxNHSxRRvFgAl+vK
         ANfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355085; x=1705959885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dKtPTrWnoc6fMe3lLbkoCZ1Tu8sXcss1oKD1gcrdh4=;
        b=ed2hS1mDIcELzYzmYOJRtqfp222ImNCyHE05r1hxhiPjqDCDZzLj6DHRa9ESNMnUh5
         V3nCvqG811vLi9YsNm/VjLpQpXuOcZWe1Ej6X+0CCAeU5Hl12d1wYYoR2eipNeNZL7QK
         5jK4Eqp2J3YiRzlWmJzxvTPai7iaEcirHR+LHk1QKl//o5lzH1TpZvuWDV9wbc+b/lAR
         tzZ/YOfb7NxerubQ2hE3SegyHvQtQxxkbKZWwJeFkEDKsMtUkayVTlDGJ/tsU8yCDa4A
         Yk7sU41y0Jkyye7SsSEkWYc02Hki1qvmjXCJIkQipD1bgrPNSWGuzdRSFhmfpxxK0wUU
         0huw==
X-Gm-Message-State: AOJu0YxXfaNuLcAE2MU7gN3VBYvkSZB+y4mqebiguiljXUtUmMqBrKL2
	g7fJweGwKLuSQFcZpDu617SwEy2xin5DT+0aLL/dzhypOqXd9Q==
X-Google-Smtp-Source: AGHT+IHKiK8prqPQNKjM0sjGqQfOTCEmNaayIspi6IUCYFWmkjH19fSrGZkx3kzlTUFqZaeipvcci4afBS1SYzofu+c=
X-Received: by 2002:a05:6512:1284:b0:50e:7b2c:6818 with SMTP id
 u4-20020a056512128400b0050e7b2c6818mr3603951lfs.26.1705355084857; Mon, 15 Jan
 2024 13:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com>
In-Reply-To: <20240115194840.1183077-1-andrew@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 15 Jan 2024 23:44:32 +0200
Message-ID: <CAOEp5Ofk5NrKujDApLXT6RL=hD6b4NFxv9GZ-NSvkbJvRYtG8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: linux-kernel@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, yan@daynix.com, 
	Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

See also https://issues.redhat.com/browse/RHEL-1303


On Mon, Jan 15, 2024 at 9:48=E2=80=AFPM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
>
> Qemu options:
>   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
> +       if (!sock_hlen)
> +               memset(buf, 0, pad);
> +
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> --
> 2.43.0
>
