Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39D19CC3E
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000444; cv=none; b=OwB9QZWKWA3IX0OIfW34jcTZ1HB6bNLylGmTtkeCrnjmhLE/r/Ims6KNUGYKCjW1en5QaZYGpKgmkUytNW9gAkHuyO4kxItZhzyttTxdAOVzy+QAlB2XmZcPoFtLJ3Ko2evCyeBwgxch7uMqUUC7aPlq6O26KGZ8lAkunw7q1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000444; c=relaxed/simple;
	bh=zj+kNdMecZ1mWILUvz4WG8GAQb/rm/mvr7EU/CCZ8DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC9drVm/8qR5rUNorL0xPol0Rutagz8LYrVlE5/KQu34t/NedsuJ+PpcGUUJodqngZjH/fofeToaz+pvTCf4F87VIAVLeKC51KpsDM9HsI753DWExi+2YGvCcuw1NT5IQ1j9LNLI2qOw6OnnKskbzLdLoaEZPz03ka2qwuGJJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHTs1fl7; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHTs1fl7"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E878240E2D
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 01:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uv6kUj3nueka for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jun 2025 01:27:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41B7B40714
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41B7B40714
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QHTs1fl7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41B7B40714
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749000440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVmJXGHCgwooCqymme55wOEwxwtQ0yZmHm9VDK+DDWs=;
	b=QHTs1fl7H7e+M5o9yEKkuv665PrvoWcFS94hP6HNFm2tVBAQy1/owKdDoWcHp6px7J79h1
	z6wPgxONGwxOKsoKXYI0uv8zo/mD+kTR/xWfl3Q61sazsIvPlu4n9fj2Z6oZu2Z17BdhoA
	m8WmnO1oCEPFdmFpMeION4kBMVuiLBA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-DvhwtpytOsGLw9b9lvSjKw-1; Tue, 03 Jun 2025 21:27:17 -0400
X-MC-Unique: DvhwtpytOsGLw9b9lvSjKw-1
X-Mimecast-MFC-AGG-ID: DvhwtpytOsGLw9b9lvSjKw_1749000436
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7462aff55bfso5034695b3a.2
        for <virtualization@lists.linux-foundation.org>; Tue, 03 Jun 2025 18:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749000436; x=1749605236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVmJXGHCgwooCqymme55wOEwxwtQ0yZmHm9VDK+DDWs=;
        b=XJ0ovMqr+at4/BS5d9nLNKkiEcD6rE8eNOMZYo+x8W3imQACFgYzJ3VtNeMx5QwR6/
         q/jp8nziXRZbyaYzlHu+xrWIgYuRfH4A2+W4zO4hjXJPxpNl8owFOM7v13AjfCl2DBPt
         esGGZ9lJxc8rrvjOhUXS72nkHEGP76yYFtzW1y/uMIBkr4H7ZR4qol7SBYOosRajG27P
         TtJYaZfgTfphdlGkK21GFD9pmvxJn/lt4wXFybbw7VRe9oB0x/MHW/5bYK2/JUD4PJim
         KAKmAFJ92TvqbFNUuWWGULrvgQuMFY37rYMgIDCFP9KnBDmSSXFAOWzOetRjIWhsCGmv
         BNGA==
X-Forwarded-Encrypted: i=1; AJvYcCWGtp7V5aJCExqJJuk7fil31LrvWzmxAoKXqalEWeJB4U1rpK5lrzCrxrBquZ9+/e7Cr10WLvdfLSWG81KNnw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx1IOy/Aw4he8dxSvRyT4tuN41vhY8mioLdU7THCB++PKLIXQwN
	HmNLFF0ctn4LMdXFr/sLd68dW4vaNEQz9bVmhqV7PRsgEXnOpY4MDCx30XX6DLZg1Bj7VnmiDRh
	j1koSRrwBSqilcFcBotU/CEBeL7trVOILNEXL0x3JM2ANXtKqwu4yU3kzXFVRsoRwiGaMiItuLM
	F7oYyqIO5GUd3JvLXb5Iour9WUN6AH4E2l77YggvzvF5VuotoY4da6OT/ydg==
X-Gm-Gg: ASbGncst4PU+nR1dM6CbQFTBTfNgkoYU13ciLb3JENLpam/r59PuJ6pfhQ97E2Hplz7
	jnjnqzbTagxXjrVvLSEk14DNtuGSMZA8tx62F1uSmz53k+g0CmPsmuqjX4C2acj9TyAGYJcA58X
	1VLmrS
X-Received: by 2002:a05:6a00:218e:b0:746:cc71:cc0d with SMTP id d2e1a72fcca58-7480b48d71emr1594622b3a.12.1749000436434;
        Tue, 03 Jun 2025 18:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU7UshbqAmiFChVYE6GtmnkwbH2sxix2Z0rwMiDn2wsmE31jBilsjSxpe70S1Y+X8iIvmuRFYjW8X4WKcP5fA=
X-Received: by 2002:a05:6a00:218e:b0:746:cc71:cc0d with SMTP id
 d2e1a72fcca58-7480b48d71emr1594593b3a.12.1749000436015; Tue, 03 Jun 2025
 18:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-3-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-3-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 09:27:05 +0800
X-Gm-Features: AX0GCFuYlEXU2HjXeMTaDnRIvTFcw3ocyvQ95aagHgYzrm-PLm8iX2G4BD1kF-4
Message-ID: <CACGkMEvVf0LrquZcWSv3vp-r44sTj0ZDnjwbwB20N0aU35+vxw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nc5nIKu8Q_NjRWx0h3U8WKhXRzBXzCY7ObftQJKx2xU_1749000436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> This clarifies a steering eBPF program takes precedence over the other
> steering algorithms.

Let's give an example on the use case for this.

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |  7 +++++++
>  drivers/net/tun.c                   | 28 +++++++++++++++++-----------
>  include/uapi/linux/if_tun.h         |  9 +++++++++
>  3 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networki=
ng/tuntap.rst
> index 4d7087f727be..86b4ae8caa8a 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it=
::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>
> +3.4 Reference
> +-------------
> +
> +``linux/if_tun.h`` defines the interface described below:
> +
> +.. kernel-doc:: include/uapi/linux/if_tun.h
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d8f4d3e996a7..9133ab9ed3f5 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struc=
t *tun, struct sk_buff *skb)
>         return txq;
>  }
>
> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff =
*skb)
> +static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff=
 *skb,
> +                                 u16 *ret)
>  {
>         struct tun_prog *prog;
>         u32 numqueues;
> -       u16 ret =3D 0;
> +       u32 prog_ret;
> +
> +       prog =3D rcu_dereference(tun->steering_prog);
> +       if (!prog)
> +               return false;
>
>         numqueues =3D READ_ONCE(tun->numqueues);
> -       if (!numqueues)
> -               return 0;
> +       if (!numqueues) {
> +               *ret =3D 0;
> +               return true;
> +       }
>
> -       prog =3D rcu_dereference(tun->steering_prog);
> -       if (prog)
> -               ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> +       prog_ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> +       if (prog_ret =3D=3D TUN_STEERINGEBPF_FALLBACK)
> +               return false;

This seems to break the uAPI. So I think we need a new ioctl to enable
the behaviour

>
> -       return ret % numqueues;
> +       *ret =3D (u16)prog_ret % numqueues;
> +       return true;
>  }
>
>  static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
> @@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, s=
truct sk_buff *skb,
>         u16 ret;
>
>         rcu_read_lock();
> -       if (rcu_dereference(tun->steering_prog))
> -               ret =3D tun_ebpf_select_queue(tun, skb);
> -       else
> +       if (!tun_ebpf_select_queue(tun, skb, &ret))
>                 ret =3D tun_automq_select_queue(tun, skb);
>         rcu_read_unlock();
>
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..980de74724fc 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -115,4 +115,13 @@ struct tun_filter {
>         __u8   addr[][ETH_ALEN];
>  };
>
> +/**
> + * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fa=
ll back
> + *
> + * A steering eBPF program may return this value to fall back to the ste=
ering
> + * algorithm that should have been used if the program was not set. This=
 allows
> + * selectively overriding the steering decision.
> + */
> +#define TUN_STEERINGEBPF_FALLBACK -1

Not a native speaker, consider it works more like XDP_PASS, would it
be better to use "TUN_STERRING_PASS"?

Thanks

> +
>  #endif /* _UAPI__IF_TUN_H */
>
> --
> 2.49.0
>

