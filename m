Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C011C3BEB
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653754; cv=none; b=GqBUqC0SD7FdTA8s/vGYW5jrFg7I97SVkoAuq5WY0v/8zzw/Ui3xy+QQpEZjMdJBhpfGUix+0vpHyPsnKZffpUZn0rrxUFHFCi0ZdFg8yeS+ArETUBHPLPXRiVk/+ZoNlIV0Jv4SRvnvqAqzPsdMAb9geh3UE3i4amxOJ8Unxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653754; c=relaxed/simple;
	bh=mDO9x/sNKaSh6VKq6BR9qetuUOFySZaiPD1KWPXFKso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMuCRqvW0kF20PP8nnAuruPB82PtVqhO/8xdP9ykPlYxM43RZ487XDm4CtoHmHvcKuyUKweDYj9PEnIMY3OAp2ovR4x2hVxbKLEODrx9g4ShkR2qdiGF8FvLXXlYuIuNf/3/lrGJUEmP+T1jdw+SD1bDDTpc3V0jfYW/OvxItIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abpa0v7a; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abpa0v7a"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E3BB40197
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:42:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxO77qGqZdtH for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 00:42:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F00DE400C5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F00DE400C5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=abpa0v7a
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F00DE400C5
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741653748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=847bTrI9x3dTQBNL5SAKMbZJ6bNHhxo9NrLY7aN1zMI=;
	b=abpa0v7aYlU0RYCKz6z8vXYlUqyMCGZbh0lBay896Y7CQao3mUuaAnDdpEkohuNS8EXzEm
	BuGjYe/Zh/24KoKW9hDeLO+NOoU8yk61rFhzbowAlTb3ot416Qz26ec1ZAe22+gX0ph4DF
	DLbJ42TuZHIl901RYJZLsUMqEa59qjM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-x-Yzj8T7N1-P3V9oNaf8Pw-1; Mon, 10 Mar 2025 20:42:27 -0400
X-MC-Unique: x-Yzj8T7N1-P3V9oNaf8Pw-1
X-Mimecast-MFC-AGG-ID: x-Yzj8T7N1-P3V9oNaf8Pw_1741653747
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so7202295a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 17:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653746; x=1742258546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=847bTrI9x3dTQBNL5SAKMbZJ6bNHhxo9NrLY7aN1zMI=;
        b=BK7nW6Mzths/npKvYEMfOW9894FQYQKMxvMqyg2feOo9UOnuXehsPJMjZCYJiupVGX
         NPW93+Bngg3ZoDMQIeq2vEig+N93a98UYS4je5fgZ5F0LP/hYVVW1BBN5IxV/dff7KZj
         Xgw33OOFg3kG1+RRp1sXGSgWmey4AUlRtnIyFs5MWSpiIrYBn1yl7BxaVJ4rBVB5itJz
         HOnOolL6dNpJFAiMmomRlmDUTwWgjBFTfakl3GUI+K00GxGMj59W+s5aAe6QhEvPxB3Z
         epYzyeBJkM714FsbLTNMhZiVFMbBA9PsFux4EpPqJFeGeOn1F8oRJVNqjnje8dwTN9MI
         Dq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSv/3vhz+m70CGoZsw+nkFfIa08mbUg4uU2n/aMOkqUBehxb+uRexkCUmz21A7IcqznQkHTqIHTS3mmEK4kw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzwSsCPXvg04K0uUrFNX6gs28G0biVPZi46YGJIaPlyODf9DnUj
	bkUGJeBMB9hsz8nBNSvnxpHabiae1hyiie2+fpFI7zuuk2FF5FDS5JpZ9mp+YGc2SwTJAowf2yk
	i1Qrvac/LmjBfq37ZWdAAHK8leCbck3zt+C6Rqzn0IyX7mUpu6nSIrGj5MITaO7Y6l6recWy+Bk
	/aJGLOwDzaBOniYXMt/3u/NiYSuin7wSTbaRgoYRi1L4HcrVyXjOgLZw==
X-Gm-Gg: ASbGncvZGmSk2xdo+nIR6h+gbEqIXsEu/xbO4CiNJDNUJqfAZkFKNNEPzb8N4ChP1M5
	PJVzlNtjL3Y74+tlr+CYptCQZEOesIyPFlZGhvd9ZydID8MXDRoBlmmk/6FQzEVe/eWgjXw==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:698d:ef7c with SMTP id 98e67ed59e1d1-300ff3701e6mr2209787a91.29.1741653746483;
        Mon, 10 Mar 2025 17:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbDtyJiENvXOe613oqH0vAWN8hUrOgIBvwTgQjpWafbqSKNzh+whVUzZLm1l+kq/H8WuSWlOotAIb4Chd6SFM=
X-Received: by 2002:a17:90b:1f8c:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-300ff3701e6mr2209768a91.29.1741653746073; Mon, 10 Mar 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com> <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
In-Reply-To: <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:42:13 +0800
X-Gm-Features: AQ5f1Jr7Qnv1FpSExilgR3dbxXrVBsVK1HLZstm0K3Mj08GcyKcVawpejY0cXIk
Message-ID: <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
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
X-Mimecast-MFC-PROC-ID: DNsfOwMx8enml2igp4yBhoiYr7TXTtyudZgNf0BlR3Y_1741653747
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/10 13:43, Jason Wang wrote:
> > On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on th=
e
> >> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
> >> hash values (i.e., the hash_report member is always set to
> >> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
> >> underlying socket will be reported.
> >>
> >> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------=
------
> >>   1 file changed, 29 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302=
f3586ea6bb5e0d4289 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -73,6 +73,7 @@ enum {
> >>          VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>                           (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>                           (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>                           (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>                           (1ULL << VIRTIO_F_RING_RESET)
> >>   };
> >> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
> >>                  .msg_controllen =3D 0,
> >>                  .msg_flags =3D MSG_DONTWAIT,
> >>          };
> >> -       struct virtio_net_hdr hdr =3D {
> >> -               .flags =3D 0,
> >> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >> +               .hdr =3D {
> >> +                       .flags =3D 0,
> >> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >> +               }
> >>          };
> >>          size_t total_len =3D 0;
> >>          int err, mergeable;
> >> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>          bool set_num_buffers;
> >>          struct socket *sock;
> >>          struct iov_iter fixup;
> >> -       __virtio16 num_buffers;
> >>          int recv_pkts =3D 0;
> >>
> >>          mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
> >>                          vhost_discard_vq_desc(vq, headcount);
> >>                          continue;
> >>                  }
> >> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcount);
> >>                  /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HD=
R */
> >>                  if (unlikely(vhost_hlen)) {
> >> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >> -                                        &fixup) !=3D sizeof(hdr)) {
> >> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >> +                                        &fixup) !=3D vhost_hlen) {
> >>                                  vq_err(vq, "Unable to write vnet_hdr =
"
> >>                                         "at addr %p\n", vq->iov->iov_b=
ase);
> >>                                  goto out;
> >
> > Is this an "issue" specific to RSS/HASH? If it's not, we need a separat=
e patch.
> >
> > Honestly, I'm not sure if it's too late to fix this.
>
> There is nothing wrong with the current implementation.

Note that I meant the vhost_hlen part, and the current code is tricky.

The comment said:

"""
/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
"""

So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
to mrg_rxbuf len.

And this patch changes this behaviour.

Thanks

> The current
> implementation fills the header with zero except num_buffers, which it
> fills some real value. This functionality is working fine with
> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header si=
ze.
>
> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> field, which also needs to be initialized with zero, so I'm making sure
> vhost_net will also initialize it.
>
> Regards,
> Akihiko Odaki
>
> >
> > Others look fine.
> >
> > Thanks
> >
>

