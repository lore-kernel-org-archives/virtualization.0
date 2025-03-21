Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF523371C
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595331; cv=none; b=rGBg05bHIL2N8t7EJqmAg1d0zbAddYRXNs1sar9y263n0nEANbpt50L864dSxWwE1Gd8HOP/NIxm4/Nq4z4fSRCcdkAhSOmnCWns11qNpppCGWUyLm91GQm57CWBfrU7Xc21bBjIL254OfntG/uWQ29BGSoNYCXrocqdmchSmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595331; c=relaxed/simple;
	bh=BCN5JQqGHPfZWzsKH88CAQez5y3gRKn+dXSiBfdgsw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNj4ijHrgvUhJDzIYYF1oIKJXrh/Y6eNwuFQRCdTITV50CP833dsdtYTje7XTDOyyLaueHRELBoAtwf4xIADpWnajr0na3byHiz/vtE3mlmYqYiwSGVKPKRgHCt0GIj2qfp2IOzmnKateyN4NfSZUOKX7BkFee9yv2HmHdKMgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVRezX/x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVRezX/x"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264c9d0295so67995ad.0
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595328; x=1743200128; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz7SI+MRITJdDDcuu+iapQr7TxDqFp3vr+TXoSWWGCE=;
        b=FVRezX/xbhooypPq8JP7ABGlhDK8Pmf722oNLKMNWz0rSXVh+WK73nvFnjHJws+rrs
         SFSts4dlOjVE3Wax2Z15zDmykC5M2pTcnw1ViE3zz6Xw9h6JtPX3zrWJaXxMQtJXX14K
         h18bQYa7f37pKnGPKkQvv6C94Qq0uZyfgPcrEXQDhD7sDrkb5ionWbmkV4vGHqBRG+40
         wFYsKakzPMROneZxmAgRaddZEaRk2dG/geIE60CavNOi1VVtse+nhb2MipzVzepn7QuO
         XmopUpvKhmVv10ZkBY+/DPdvGRkKr404Q8BRRbms0Jbv+X/nS3YhxjRE2sKcU0uxho/I
         KQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595328; x=1743200128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz7SI+MRITJdDDcuu+iapQr7TxDqFp3vr+TXoSWWGCE=;
        b=qacRvHiXVK3IxFvJp/5mGe4StUDFofu1AwQuZlPkp/pMV+vHI9iebzNpp0tKWV82lw
         6JiNAclFx0MjUrsgDxcDjSBeBQlQsgJDjTJzjJm1GUd0JVikVYrUQTveOWswFi0nsPXW
         FZo3i4Vj+wyo+e8rw6/mADBgBsDOi4pGYY2MvMQ8DR/H+mnU26x2H9UpAPQaIGjvjLug
         04LiH0x7uixDbvQC/HRys8boeVg9LKnxvg4/K3DLo9/3+m14W4LycEsSDhH4ANuIfEmr
         AKmyiDn9Xf2mP5PJpWYOvqHnB8Ih5B6C/or4/DPNaZF2p32t9T0oMnQ++YJ4pPmnLI7n
         FeaA==
X-Forwarded-Encrypted: i=1; AJvYcCW3+0GNFsPb5lrgZjALC41EIEV9KJJqGbx+0BODSQhfSefxj0h2xciKQkyOfeDO7qC/pPO1mbGvOr8/wofmtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxD1pZlgYeCyKof/NsghoDf52nDKm9SLHI1cS/x6wIMzymb0TxC
	HL4U/XDUnXfZgy9KkAbSsHUf1klagJeGCw2UJrDnSz6Y1t5lOfzEVSn4nWHIysPi8+ePT6Sy1Zz
	ObN3EsgbQkj1j1vlPhbPYbguaKjuaY0Wm7UuLzAoMRiMC+pDwadO+wlU=
X-Gm-Gg: ASbGnctH00lcwlzhOlDf4oqyAW3PI4pacQSr+ZYISLivilW9e5gZqbkaqguoC5r6FQG
	tSt9gWnoJmk3fK/7tlVDR7z2NMZy4w6exteedTprrdcc+Se2U5hukPoeZEjZNdzEjFE6BZ76eOd
	3lbotMiGDtz0WoMAb3StjoBaKYLOvDfWWKgkQpz11jiTcgk4BkrYmcHKs=
X-Google-Smtp-Source: AGHT+IGBoa3JmICUjXYWbIuZG1QnxGwt2v2Pxt/ddhpOPWc2le0JOM4R9EEoSgO2H5EsypXp8nLSfXGBeIbvxdvRzAY=
X-Received: by 2002:a17:902:d4cf:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-227982bd0e7mr778235ad.14.1742595327611; Fri, 21 Mar 2025
 15:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-5-almasrymina@google.com> <5de5943b-5527-49f6-a454-b3c7358cff56@redhat.com>
In-Reply-To: <5de5943b-5527-49f6-a454-b3c7358cff56@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 15:15:14 -0700
X-Gm-Features: AQ5f1Jp_bSaJYceldtfK0dIdQEXx63Idm2vF7CtmSVJ_E1ycJl8iObtXRhrS3vg
Message-ID: <CAHS8izNfyfVhMj0wBvP0qa=7E4xL+eo9wn_Fi4o2PT8piwACWA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/9] net: devmem: Implement TX path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Adding Kuniyuki.
>
> On 3/8/25 10:40 PM, Mina Almasry wrote:
> > @@ -931,10 +932,67 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >       return err;
> >  }
> >
> > -/* stub */
> >  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info=
)
> >  {
> > -     return 0;
> > +     struct net_devmem_dmabuf_binding *binding;
> > +     struct list_head *sock_binding_list;
> > +     struct net_device *netdev;
> > +     u32 ifindex, dmabuf_fd;
> > +     struct sk_buff *rsp;
> > +     int err =3D 0;
> > +     void *hdr;
> > +
> > +     if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> > +         GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
> > +             return -EINVAL;
> > +
> > +     ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> > +     dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
> > +
> > +     sock_binding_list =3D genl_sk_priv_get(&netdev_nl_family,
> > +                                          NETLINK_CB(skb).sk);
> > +     if (IS_ERR(sock_binding_list))
> > +             return PTR_ERR(sock_binding_list);
> > +
> > +     rsp =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +     if (!rsp)
> > +             return -ENOMEM;
> > +
> > +     hdr =3D genlmsg_iput(rsp, info);
> > +     if (!hdr) {
> > +             err =3D -EMSGSIZE;
> > +             goto err_genlmsg_free;
> > +     }
> > +
> > +     rtnl_lock();
>
> The above could possibly be a rtnl_net_lock(), right?
>
> (not strictily related to this series) The same for the existing
> rtnl_lock() call in netdev-genl.c, right?
>

Actually I think this can follow the example set in commit
1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations") and
take the netdev_get_by_index_lock().


--=20
Thanks,
Mina
