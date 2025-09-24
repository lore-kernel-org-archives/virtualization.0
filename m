Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8C1EB5D6
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676331; cv=none; b=PljU0Mmlwk+HmQHmlHmsEYPI+K6q7MPGbZcjnKberedFqKt+6lwcdue5f1CeJW1fF7me4xiVaYdeQUjS5INeoeQAiQ7l9J8QMwOYiAa5QMboc5beqF767WKypBaNCWmHSQlye3yavu/7xAVhyWTual2rTGtZzIBnNn1QoasdF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676331; c=relaxed/simple;
	bh=DKLy9xSYdH2s+P4CanyQdvSo0zsUWoF7Fj9I7KFYkj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBe7oYd0U3r72oNTZhqYTARQx1W60YtXKbAYFdvlQ/N3JGcys1X5NATzu32zL8syw5pAR/tVwWxthxO6N7xTF4lH2W+h6jb/kt6Y8dKVdQvttR4srB4a2YBm9fZutc4AnJCVtbqr6BWnTTI9RdT0XtsllWLeuKao2/W2oXwsi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGMh2zvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGMh2zvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/Z9ru3yZuHgFLEyjMuFL1AU8zZki8asTUSFf8CWbuM=;
	b=aGMh2zvy7XZdDrdoKxrniNbr+SlkFChbTfqM6j2OFK8dOS29m1uzRLnKQOVVKpqBH1uvol
	tHDY35YY/N/YfDdkEf5BWILqoS2NuNsXRP51d4Doj3NSNa/yUQYSvgNYWyZeUwR8VMBjGH
	EQJ79dJf+le0jATchyRLWO0me/FjB70=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-9sYEdbZAOxCgsYWI2WIzPA-1; Tue, 23 Sep 2025 21:12:06 -0400
X-MC-Unique: 9sYEdbZAOxCgsYWI2WIzPA-1
X-Mimecast-MFC-AGG-ID: 9sYEdbZAOxCgsYWI2WIzPA_1758676326
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso8417224a91.2
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 18:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676325; x=1759281125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Z9ru3yZuHgFLEyjMuFL1AU8zZki8asTUSFf8CWbuM=;
        b=FHcRz6czeIM7OAHI0aeU4w1hMJXaEM9vaH4nbwqasfEFUGFejbYgDF2uMlf4EVKnXL
         wrxFNA9gmvdrdhYQTb8h5tTk2vOwv+nvYXrjWzvy9+g+voEFQMMEiVCmG8Xb5MlZCiEv
         3Q/EmcFuHXAoSLmRiTkn9oczRBFiYyUd/uCbV0ui6Ukjdg2LL/N+Vgc0vkpNpjjNIVQx
         vVfoMqQRhHljXjBIzDUHm6QebP2Q7sGi9UF0o73PM8gWhC2BRHLLppaC3UxmYv4QoFwq
         epF1P279ZeCvwue2C0ch8y1t8nvXUWSFkcq/Vgy1Ad+IGq9cXmrUG1SdqApe366nHbq3
         SL4w==
X-Forwarded-Encrypted: i=1; AJvYcCV2+kBJzDzgQ5tdryNB1oLPLJnGucAYvO1VdkBbeL/CLtUUwy/UEssWlNUdfHo9PyGja3EU/sFaG8xr1JTU4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqZ1X4p088GugOAM6LTwE5rkU8Ve/OFdWO36RLiTdlKROxZ3+G
	XGNrwImPZxqRw7EJxO7wX5ZzaoCy/xLiCzP8p+eFf/4FAzJXafY2pXR3EQXiwv9ZyLRw47M0YXS
	hwI13k5dmYmZAi4NegevpCHMAfxtQz5yonF2E5uiBt4XZFbkmNAS1TB2gEuZL6xAOuVBMZLuDwN
	1v7Gw6Nwj1uHxECc8I9U4eZ72IKIPjp9IxuOCbReEXVLI=
X-Gm-Gg: ASbGncvwRfT8pSvLimAtGn8xg+QRpLa9/XQPhuzLaDtc0mfr05u+CdimESnbpyLN3sc
	DzGSpTu4sqwOGnFgjYy+hQDbzQVACIHuRihvugtTc+vXvCvSO758dje2y7Pw1Aa4LnSkEz8Mnkh
	69RsBWWxw3di1r2OdQLQ==
X-Received: by 2002:a17:90b:4b8a:b0:32e:ca03:3d6 with SMTP id 98e67ed59e1d1-332a9a02e13mr4771506a91.36.1758676325634;
        Tue, 23 Sep 2025 18:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzxYjJRjaWhGevKoPRjS74qdeEP5KEee76nkTOV7sNOGR794WkZrfNsw1UREBYwZf/IPytkduQWK66MGn7H/M=
X-Received: by 2002:a17:90b:4b8a:b0:32e:ca03:3d6 with SMTP id
 98e67ed59e1d1-332a9a02e13mr4771481a91.36.1758676325193; Tue, 23 Sep 2025
 18:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923202258.2738717-1-kshankar@marvell.com>
 <20250923202258.2738717-2-kshankar@marvell.com> <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
In-Reply-To: <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 09:11:53 +0800
X-Gm-Features: AS18NWAFTXygnvQR_4lKDl_YKIGpGbmtcj7ZwTo_3ajzvVYk4XQXOBLzbMHHLNU
Message-ID: <CACGkMEskxO4JKXZZiDSi6GgrTg1bRSteaYAAJe1wJ6=Lp5byeQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] net: implement virtio helper to handle
 outer nw offset
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	jerinj@marvell.com, ndabilpuram@marvell.com, sburla@marvell.com, 
	schalla@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ptwE5yY2lh2pmdZOdGqJASpNZQbn-LjE_LfRPlZrj-M_1758676326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:51=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 4:23=E2=80=AFAM Kommula Shiva Shankar
> <kshankar@marvell.com> wrote:
> >
> > virtio specification introduced support for outer network
> > header offset broadcast.
> >
> > This patch implements the needed defines and virtio header
> > parsing capabilities.
> >
> > Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> > ---
> >  include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_net.h |  8 +++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 20e0584db1dd..e6153e9106d3 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(s=
truct sk_buff *skb,
> >         return 0;
> >  }
> >
> > +static inline int
> > +virtio_net_out_net_header_to_skb(struct sk_buff *skb,
> > +                                struct virtio_net_hdr_v1_hash_tunnel_o=
ut_net_hdr *vhdr,
> > +                                bool out_net_hdr_negotiated,
> > +                                bool little_endian)
> > +{
> > +       unsigned int out_net_hdr_off;
> > +
> > +       if (!out_net_hdr_negotiated)
> > +               return 0;
> > +
> > +       if (vhdr->outer_nh_offset) {
> > +               out_net_hdr_off =3D __virtio16_to_cpu(little_endian, vh=
dr->outer_nh_offset);
> > +               skb_set_network_header(skb, out_net_hdr_off);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static inline int
> > +virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
> > +                                  struct virtio_net_hdr_v1_hash_tunnel=
_out_net_hdr *vhdr,
> > +                                  bool out_net_hdr_negotiated,
> > +                                  bool little_endian)
> > +{
> > +       unsigned int out_net_hdr_off;
> > +
> > +       if (!out_net_hdr_negotiated) {
> > +               vhdr->outer_nh_offset =3D 0;
> > +               return 0;
> > +       }
> > +
> > +       out_net_hdr_off =3D skb_network_offset(skb);
> > +       if (out_net_hdr_off && skb->protocol =3D=3D htons(ETH_P_IP))
> > +               vhdr->outer_nh_offset =3D __cpu_to_virtio16(little_endi=
an,
> > +                                                         out_net_hdr_o=
ff);
>
> I'd expect this to work for IPV6 as well.

Or why it only works for IP/IPV6.

>
> Thanks

Thanks

