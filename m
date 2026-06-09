Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F033C10A9
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027924; cv=pass; b=K7mm0NCBEFvcFaOLh/MXbb160OmWp/4uIm4/VC1KtqwADTvdabu3tjvK5fC270JL4i9L+8q43FMZ4VWH9yvG71sI9ITc4Yv7nBUM8RHBmz9PtkJ5OckAmAZ0LLUZufvho9HLRD5LApuVj4qFT5M64TxKFqtvvUV831qbcFzrG0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027924; c=relaxed/simple;
	bh=ybsezbay7k70lPOQonDhXOaQ/fkYTSjG31ey35ltwqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW7Fl7MnVRSHW+/G7dNpjPZhsyJ+6ygFGtyHjSazEP8n3rWtwLjmG/T1PtD9pXdbj8rP8qLNab7xRPlBk16NeCnSENe+t15JHjmBrx2VdSjfX8mKeT62GlmLVcyj3eCwgn6EsITOzXKqc+l7rcE6w1CCtWMSFa/1uLduzCz4q5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFoJYM6w; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFoJYM6w"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51765331535so2619631cf.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 10:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027923; cv=none;
        d=google.com; s=arc-20240605;
        b=Mfls19T5uQ3HxUFdzA9cLVXqjP02Cf/I8E4ptHCePso9xdf29P0tgto6ORbVoyb6lT
         2oXe0DEyCjCyV6JDR4FTtu/VkhUWqJm5zCTTPGpTdqrz6uSvbTMGF3oYGJDCPzxKccI7
         xKShNOcBgqlOpnBdgMt0wUGYcHOdSDjqXUFEvRcXBU/VgQ3irMyNbxyJUv8aHlV7cB9v
         6E0qh4Yfv6PmykqrveYKTc3WiN4algsT8bOdHh7uuuZ4WkJAz5UYLsw2aLiMSG8jHyPE
         dkG/op2lDr5Q5MEPSFDyk0AbovCj/o6o7jnbpdHrb1H6vVpDhr4+WbqQLOLSpHx7qalx
         VMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        fh=k7KQwdeeujh6M8nXkpLfvYH5jjGfnuxhLHnS5RvAbGA=;
        b=Ki4snSHEzu3N8j4Ti5UR0LPLV0WDj4VhVO3/CrfjdTbjvRNZtGVvtLFf/KeGpvIb2i
         CMzW4yoOXSG6nsf6HxKlOdcVZFyYKKy0HetFU9xKuYh6SZ0odsIl5otwv3hLn2G7yKys
         /NkxqUw/6PYeAHSGKbNd7MZBrR820JGlJ06KIGkj6NPQHwNXkmusGCnkedNkdA3qBZ2G
         WH6s7icNSxSANNZEmH5Q2eLVljN9MoUU6Pxs6uG7ihDgnn5Hn4DQhBr7pZwVO3echnAk
         DgTLx1ImAWoLmg2ZkqTZx+lq7vfRYwmqlq+ZoawUkipjNcsT6di6FgkPtzdaev8AV94a
         zJNg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781027923; x=1781632723; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=KFoJYM6wymTWzdczS6UigKjCKIpvU8hcq8qGljaSt3xVBls3ks1wJswyTgsQtvaMLh
         F7zwN7H7vRD7ETxta1ssH0T332q7jzuN/DGu+cwJI7vZY9C80nHZwkmv93S6kvLJlehw
         /BB8mqo9NaGFjEEOV+GgVvXcs0BESd+SdPZZ80Oyw+l8nYt6/K1yAA+Dl4ZQO4EA29RN
         D3m8GPwnxaTuzWZWpp/S1P2WZeU+P4GS8HRnc1wLXX/BTsEDEVJoHziw7RcKtLTjzRzL
         iWt4Nia1/k61A2Y4VfJKqn1FEruVenOaQo3fMhSguIDv+sBQGRoWNVGRmM5c3MGryTnu
         V4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027923; x=1781632723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nwn+8bVabCNfsWsGPnwkQLJpfQuXsi9OyDflFuRUOro=;
        b=M+U2L4RZ3ic8uzePli6UXsv8J19EZZLOu2LulP8WTcrERmTztl8ss+NxO+s6OxkTNo
         a4+Kfd/n2jpNEvpXazGkcwFoqqgOXfDC7K/SfCzvJa7zCVbedev4/hTgAvlFpL8dQYYg
         vPRg2QP2VNc6YFAa22hFWRe9x3NersLp0c5GmUPv6vc0NlbJfRyXPVRPKmLb1ra+ZMli
         OP101G++JmZ0DbNeavGxmwYdkZ0X5yB4dquGCAWMF9LPHkHIrvF1xASh8ekSQ8MA88K1
         9+Y5wo/9pcZBqkL4tbdi4uS267P0d/dr7Mj6KDIqgZ59xpwehk5ynwQGhX6kkYPQVBg2
         MtzQ==
X-Forwarded-Encrypted: i=1; AFNElJ87Kof9IlIVmCGjhKhNHbjaIcrExWN4ibt4b9+HFLgULw8n2ma1wXv7/qwJ5Wn4NZX/dhAIyZpWfBsn6pKBnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJBs72FKcfpWc67JsKH6wRwvD0EnAJTYDOHbJI1NxeTjjl78XO
	sFS9Dj21ASwrGGn0TAqxQxRSGKKd0sO5iOn9wiwOqDQEUkHzvBx/SKJyT5HXLxm2lMb5ugAJoSZ
	wjpTjuUUYbzmc29JiD+wiwuzZQ/tu9Wiu7gl/zuQl
X-Gm-Gg: Acq92OGOR4AKEjdbRZ+SEbW08uv5fyYexj+8ALhoB77yOPcVYlxEAdFCh8rJtuO2+bm
	prot9sdQd7yb8Nv18ICZ1Z2zukYy9+KQz/r4XvoT2U4u4rJgVn0xjfN8WCAql5ItzMoPOiq2tP+
	oOYYNPJmeu9Ai6pGuEUdIR6dc01ugOpKo9vctw6MOcXV+R8S3awNVOXYEj3mPICi6gFg6cknaxc
	u8QaEnE31RScDIZrpjsC+d4u8/ynyj2EVEkiuWby6Ny6ZZuaKApdwQBkDuluFLn6tjkqVJFd8FG
	DEDUSozHmV9hwsbCY4qsR5kPvgCVaEDj4AMN1kpdGcnm+vd6OBAm8uAD7VQQFAI=
X-Received: by 2002:a05:622a:6843:20b0:516:4f62:85ed with SMTP id
 d75a77b69052e-5179b114418mr33538681cf.18.1781027922090; Tue, 09 Jun 2026
 10:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260609004809.1285028-1-tavip@google.com> <aifL0f_QO1kocccU@sgarzare-redhat>
In-Reply-To: <aifL0f_QO1kocccU@sgarzare-redhat>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 9 Jun 2026 10:58:30 -0700
X-Gm-Features: AVVi8CdWuQeEp3U6i-IMth0fBQwGbxFj2zuxQPoE0fGsqs-1g0UsFmC0xhO_DaE
Message-ID: <CAGWr4cSY9V7JyvJWyO_YRR-9KJtp=OzAkDjjODJ9tM7orebZ5w@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: restore msg_iter on transmission failure
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:48=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Jun 09, 2026 at 12:48:05AM +0000, Octavian Purdila wrote:
> >When transmission fails in virtio_transport_send_pkt_info, the msg_iter
> >might have been partially advanced. If we don't restore it, the next
> >attempt to send data will use an incorrect iterator state, leading to
> >desync and warnings like "send_pkt() returns 0, but X expected".
>
> Thanks for the fix! I have some comments.

Thank you for the quick review!

> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index b10666937c490..588623a3e2bbc 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >       do {
> >               struct sk_buff *skb;
> >               size_t skb_len;
> >+              struct iov_iter saved_iter;
>
> trivial: reverse xmas tree:
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs
>

I'll fix it in v2, sorry for missing this.

> >+
> >+              if (info->msg)
> >+                      saved_iter =3D info->msg->msg_iter;
>
> What about using iov_iter_save_state()/iov_iter_restore() ?
>
> IIUC we may need to export iov_iter_restore(), so not a strong opinion,
> but it looks better to use those API IMHO.
>

I agree,  I'll add the export as a separate patch in v2 and move to
using these APIs.

> >
> >               skb_len =3D min(max_skb_len, rest_len);
> >
> >@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
> >                                                src_cid, src_port,
> >                                                dst_cid, dst_port);
>
> What about adding a comment on top of virtio_transport_alloc_skb() call
> (or when we save the state) to explain that in specific cases it can
> advance the msg_iter ?
>

Good point, I will add a comment explaining this in v2.

> >               if (!skb) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
> >                       ret =3D -ENOMEM;
> >                       break;
> >               }
> >@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> >               virtio_transport_inc_tx_pkt(vvs, skb);
> >
> >               ret =3D t_ops->send_pkt(skb, info->net);
> >-              if (ret < 0)
> >+              if (ret < 0) {
> >+                      if (info->msg)
> >+                              info->msg->msg_iter =3D saved_iter;
>
> Also, what about having a single restore point after the loop?
>
> I mean something like this (untested):
>

Yes, that looks much better. I tested it locally and it works fine. Thanks!

I'll follow-up with v2 in a day or two.
