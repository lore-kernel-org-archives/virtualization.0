Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD15335C0
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939687; cv=none; b=DXhCvQo2YXnjBjar6vpyrjJPrbEftaC70rGB6k4+PFDxtyM9CUF2+HRbK3SARC4/8mSqqnOfu1YWFKuZPVs8PfWZuApQI/5pCFAdNt4/9wXYX7UN05bk/bmfkZ0ayfM7xYSLSfG9YqOnu4xpxqlLlxYRi+fwj5FkUcNiGYnu2Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939687; c=relaxed/simple;
	bh=lpT4EEEFtGcKtomDFu0DuY1Ilyst3kgzdjJTTE066wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK3rTlNEaZ6lp1b662Ww1FE9LamHKlpCTwxo3lW1a2o2B8OC/00+/CeYRzbrmwt3/YX45ivgu5A+Nbu8+8t48Rf50hH41Lj54MS381lgo6eLK7rYu0m4+BBA7KZD8CEayHvTZ8mV5RuuxzZBgNeldqjm+i90k9AW2ma9oQQkIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbSabRk2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbSabRk2"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so314027266b.3
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708939684; x=1709544484; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zezp1plCc6cYEOmZOZvdSFi9iYdG1RWykK9uDZ/Mnao=;
        b=PbSabRk2Mz8FogHyFsYASP30MZDnSl7DPFe0CNLFi+Yt67OLNOM8KB5z6bBG3EoJ1I
         l7ikzghrR3KXwBPKBY6pF+ZE+W4LZuXd+uPcxTiCFdoIqZd90Y9m7TQcLrbY2ebrgded
         ftpaJori07AHS6OOIAw+iNQgt3j7TQcQ8uUwSdJ43SmG2H5sV4goJylSe5rgKZXe8p8R
         LpvBjCS5CpecSc+cdC4Fw5ltgkIAXEo6B9A08FdgIANVwy2r+EOazmIgkGoxZOGzFV4D
         5lJmn8ImqQA3Z3Wxb1Wq0wRRUqVHBT7oNr8Wl9S2ztTHXCtknOhJt5tFP8Bnzl6Sj0V1
         k6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939684; x=1709544484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zezp1plCc6cYEOmZOZvdSFi9iYdG1RWykK9uDZ/Mnao=;
        b=XC/QM8epQNhyXV7Ij4+/olCyA0xooKdaHDEraZv20lzENGZ1Id9szAG8x9Hkz1gutK
         AZMIKgz6L1w1Pcu7M78C3z5z+tWYL70KDuDpG1RG4PrYyW6xm0eAuZafWKFB9fnqfVU6
         1TG5ZoZ9bGWjGPwLwG/pkN5QJ0qHUYjEO5vXon1ftg/fdS1NFcN6EwHwzW97X9eT0HZk
         lf6W9HwmIIaeVHMlySvEslJkmGT2BHC3sIvoF5Q6mG4RkCPRYbEJ5wQd4A4ZyUuhj/In
         B8nicxguOjOm64poFUqM6Yg5Ahw8D6CoCvSOrc62ZLlHXjZF64BVS3fqKOom2wKTkDQL
         LDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTEYf/WOIVbdW5WQayynnwqDZ2E0u8Ic5bPJl5rca0lBVTP5fLZ/VBKUJqp1jgyY+mUaKr+8NgHvBQa1aO38vhRoo1dMtIX5zIrhVvTaM=
X-Gm-Message-State: AOJu0YyhjrxHUnMJR53V5q7gEJmQnjelQZHx4U4J/vhwn+4K3pQDKixe
	7p3h1Lv2zPZrH1mC/xd5dyLOmiqCG8HEGCWD2pnH7Jwr2+/8PviPAflgqe1ozClMJAPIsUakYzd
	wAsVegmNvEe3/5fVh2GKTqrez3Qw=
X-Google-Smtp-Source: AGHT+IHSYUBtbIIKd5SFQ0SrthFoCS/puFEZ/tiizES94XySMAwveW9qDVNNtbHeTogNFlQ80ybtAHjRWTsBT85jaCc=
X-Received: by 2002:a17:906:8802:b0:a3f:40ac:1e0e with SMTP id
 zh2-20020a170906880200b00a3f40ac1e0emr4166524ejb.67.1708939684159; Mon, 26
 Feb 2024 01:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org> <20240223115839.3572852-2-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 26 Feb 2024 17:27:27 +0800
Message-ID: <CAL+tcoA=FVBJi2eJgAELhWG_f+N-kwmrHc+XRfKXhYk2RJcPKg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:59=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Another similar codes that also can be changed later go like this:

diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 5e19a6839dea..9b205b152734 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -56,10 +56,8 @@ nlmon_get_stats64(struct net_device *dev, struct
rtnl_link_stats64 *stats)
        dev_lstats_read(dev, &packets, &bytes);

        stats->rx_packets =3D packets;
-       stats->tx_packets =3D 0;

        stats->rx_bytes =3D bytes;
-       stats->tx_bytes =3D 0;
 }

 static u32 always_on(struct net_device *dev)

> ---
>  drivers/net/vsockmon.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
> index a0b4dca36baf..a1ba5169ed5d 100644
> --- a/drivers/net/vsockmon.c
> +++ b/drivers/net/vsockmon.c
> @@ -46,9 +46,6 @@ static void
>  vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *s=
tats)
>  {
>         dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
> -
> -       stats->tx_packets =3D 0;
> -       stats->tx_bytes =3D 0;
>  }
>
>  static int vsockmon_is_valid_mtu(int new_mtu)
> --
> 2.39.3
>
>
