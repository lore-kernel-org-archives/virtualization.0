Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D0130A7D
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293529; cv=none; b=ndAn9HZAu96IJeHdpmKQvuzGGMUdrJemaSFkdltZRX/qO99GJB6Lfe6c4JEBrZErIF7hAHmlT0P2Mg6YavzOBgOVfPY+pyMczaMZxLawQwVkczet1y8SCUL2PuAvQYJsmD9eKlLNiLTATgeppaoqqp0khWpH643O+XmM1TBbILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293529; c=relaxed/simple;
	bh=jtcBiybF18rrhoGoJIJZVMTIuu4MOYpa6C8hIZbgkFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETcUkiwP4P7ofOcMogHb3Yo3QvF/zfzBFiqo5dR42UfzdCu2XLGtGvzFK4HybOdWRJQmy1HN0K5p7PCcD0jzUuiqlKs8mkQ/OiBv9zZD7rCdc3bO5z63p21m3HnbdrP62Dq5OIMnO6WTICrRRtzUbByHBgIjUDDoCAKIGXYTS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz09DAFG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz09DAFG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D73DB40A48
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 22:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EoN4d-sMhkaJ for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 22:52:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 80A1D401B2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80A1D401B2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Iz09DAFG
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80A1D401B2
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 22:52:04 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e0b2d2e7dc9so2681060276.2
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722293524; x=1722898324; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg5HeEiGHzT8hT6f5/evSH/gSzb5Mo4puYNGhy7jr5U=;
        b=Iz09DAFGCz2a+dYpEPr3gMGpcCJonnw+kUbNGIIygDVsEdU+wFlsGIz6yq19hOfAnR
         FQiUpYZBClIhjEDk+M/thXtFHiVJpkdWnPCaAVDgWmJQfyzQhnP2rCRhxEGUpNM2Ng8L
         wDNzzLuehcLO8DZtGKgmKuvdEp4cDBf36bpRxeU1w6QSSj+MT5esG6lyKedXpGqeaWvi
         UQ8ybfGjWdP3ZfRQnf+lNA4pWjPOkpYMSrvFfUk1ufMmrY1cZnxUrf8lF/agtnxn/hkI
         jPcqWxocv5NYhzhq53OThix2/gu/yyBsnZasUE/1Nz+TQNLnyCvxGMtWksLKDIksp2z4
         DN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722293524; x=1722898324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg5HeEiGHzT8hT6f5/evSH/gSzb5Mo4puYNGhy7jr5U=;
        b=pqPOHKJO37A5xoyNaWvv48l9A/Y3MeR+L6WDl1JqU6RkbrCKo0zc7O6enLSAu8PJES
         HtgEqeYModrOX64LO5Iau2qh0dzr526XTqnyPp0WGvhe7iN0xUqHAEUlMuu5uFYz2L7j
         bmi9m03fTJdtBU1sZEE+c5H55hvoJXqircdmuoajP6L03npDSDfxPysk+5Jwn5oyg3Td
         PRTHb892Sx1JgmzPBqEivoXqDrnPCUQ3jFmXUBBETCPmFtK4HXmAyNmaqcpttZke/HkJ
         j93jNIiHzlUW+uV9bcVFp+REHuxi0HiWqvVV+t1N30Vvr8SdJUqqDm0Ndcpbdidi3nkI
         gEUg==
X-Forwarded-Encrypted: i=1; AJvYcCUk1K6ESYxuSpTo1/LtQ/7bWQuzTHs1TpQqmGd8lJxsvdO1p+SKIVjjq6FXhqhPv+9u7AE8HUb6kq3LHul1g1nj0gBHwpkQRzJ2dfospwF0Bmt/idQ4h95rEQ==
X-Gm-Message-State: AOJu0YxxMsrFOLYHtF9wvIDvNEGfy/9uu3qXezFR3FtmmCGI9yM6Ot2a
	99GU9FePdSUJuM1nFcjj4A7YMR/HaYW3itMIoLZijCNnRJZ+uhJa+OlTDGuPFq5ri/Y43mwsuzk
	CstjPohFWYs3BZc/D5GwwAwzIKKg=
X-Google-Smtp-Source: AGHT+IFp1maKkseHyDEiVQrlMWP8F7GBiHqFsuJ7fcviqwFGiyOAHy2I1TSLKaLeQ7ojbPuZs/dqshqB1RUfEPRFJvM=
X-Received: by 2002:a25:dfc4:0:b0:e0b:1241:cc19 with SMTP id
 3f1490d57ef6-e0b544cbe9dmr10355797276.32.1722293523937; Mon, 29 Jul 2024
 15:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-8-amery.hung@bytedance.com> <e1647f5f-5056-5cf0-e81c-5ef71fd6efd0@salutedevices.com>
In-Reply-To: <e1647f5f-5056-5cf0-e81c-5ef71fd6efd0@salutedevices.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jul 2024 15:51:52 -0700
Message-ID: <CAMB2axMXzcxrFr+zWV6CFJxDrKwH+U85F7dkeXfJjAO10EmSAg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 07/14] virtio/vsock: add common datagram
 send path
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, 
	bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com, kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:12=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi,
>
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > index a1c76836d798..46cd1807f8e3 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1040,13 +1040,98 @@ int virtio_transport_shutdown(struct vsock_sock=
 *vsk, int mode)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_shutdown);
> >
> > +static int virtio_transport_dgram_send_pkt_info(struct vsock_sock *vsk=
,
> > +                                             struct virtio_vsock_pkt_i=
nfo *info)
> > +{
> > +     u32 src_cid, src_port, dst_cid, dst_port;
> > +     const struct vsock_transport *transport;
> > +     const struct virtio_transport *t_ops;
> > +     struct sock *sk =3D sk_vsock(vsk);
> > +     struct virtio_vsock_hdr *hdr;
> > +     struct sk_buff *skb;
> > +     void *payload;
> > +     int noblock =3D 0;
> > +     int err;
> > +
> > +     info->type =3D virtio_transport_get_type(sk_vsock(vsk));
> > +
> > +     if (info->pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> > +             return -EMSGSIZE;
>
> Small suggestion, i think we can check for packet length earlier ? Before
> info->type =3D ...

Certainly.

>
> > +
> > +     transport =3D vsock_dgram_lookup_transport(info->remote_cid, info=
->remote_flags);
> > +     t_ops =3D container_of(transport, struct virtio_transport, transp=
ort);
> > +     if (unlikely(!t_ops))
> > +             return -EFAULT;
> > +
> > +     if (info->msg)
> > +             noblock =3D info->msg->msg_flags & MSG_DONTWAIT;
> > +
> > +     /* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps a=
void
> > +      * triggering the OOM.
> > +      */
> > +     skb =3D sock_alloc_send_skb(sk, info->pkt_len + VIRTIO_VSOCK_SKB_=
HEADROOM,
> > +                               noblock, &err);
> > +     if (!skb)
> > +             return err;
> > +
> > +     skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> > +
> > +     src_cid =3D t_ops->transport.get_local_cid();
> > +     src_port =3D vsk->local_addr.svm_port;
> > +     dst_cid =3D info->remote_cid;
> > +     dst_port =3D info->remote_port;
> > +
> > +     hdr =3D virtio_vsock_hdr(skb);
> > +     hdr->type       =3D cpu_to_le16(info->type);
> > +     hdr->op         =3D cpu_to_le16(info->op);
> > +     hdr->src_cid    =3D cpu_to_le64(src_cid);
> > +     hdr->dst_cid    =3D cpu_to_le64(dst_cid);
> > +     hdr->src_port   =3D cpu_to_le32(src_port);
> > +     hdr->dst_port   =3D cpu_to_le32(dst_port);
> > +     hdr->flags      =3D cpu_to_le32(info->flags);
> > +     hdr->len        =3D cpu_to_le32(info->pkt_len);
>
> There is function 'virtio_transport_init_hdr()' in this file, may be reus=
e it ?

Will do.

>
> > +
> > +     if (info->msg && info->pkt_len > 0) {
>
> If pkt_len is 0, do we really need to send such packets ? Because for con=
nectible
> sockets, we ignore empty OP_RW packets.

Thanks for pointing this out. I think virtio dgram should also follow that.

>
> > +             payload =3D skb_put(skb, info->pkt_len);
> > +             err =3D memcpy_from_msg(payload, info->msg, info->pkt_len=
);
> > +             if (err)
> > +                     goto out;
> > +     }
> > +
> > +     trace_virtio_transport_alloc_pkt(src_cid, src_port,
> > +                                      dst_cid, dst_port,
> > +                                      info->pkt_len,
> > +                                      info->type,
> > +                                      info->op,
> > +                                      info->flags,
> > +                                      false);
>
> ^^^ For SOCK_DGRAM, include/trace/events/vsock_virtio_transport_common.h =
also should
> be updated?

Can you elaborate what needs to be changed?

Thank you,
Amery

>
> > +
> > +     return t_ops->send_pkt(skb);
> > +out:
> > +     kfree_skb(skb);
> > +     return err;
> > +}
> > +
> >  int
> >  virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> >                              struct sockaddr_vm *remote_addr,
> >                              struct msghdr *msg,
> >                              size_t dgram_len)
> >  {
> > -     return -EOPNOTSUPP;
> > +     /* Here we are only using the info struct to retain style uniform=
ity
> > +      * and to ease future refactoring and merging.
> > +      */
> > +     struct virtio_vsock_pkt_info info =3D {
> > +             .op =3D VIRTIO_VSOCK_OP_RW,
> > +             .remote_cid =3D remote_addr->svm_cid,
> > +             .remote_port =3D remote_addr->svm_port,
> > +             .remote_flags =3D remote_addr->svm_flags,
> > +             .msg =3D msg,
> > +             .vsk =3D vsk,
> > +             .pkt_len =3D dgram_len,
> > +     };
> > +
> > +     return virtio_transport_dgram_send_pkt_info(vsk, &info);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
> >
> > --
> > 2.20.1
>
> Thanks, Arseniy
