Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2033086
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462190; cv=none; b=lXazHaPrg06v4GQQyabshW77qvg584txDLoOabbXHrBBqVuj0kP7AfIDNhHE8Goq5HZZrYKGpEqGy1g6N0/InOlJmP9hgWfrkJs4flcmE9m14EZvEWGTZ7ZMJCT14yWsUoICSVc8WKSPwPlfQk1d/QwG29VJnAueBO1Hit5eZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462190; c=relaxed/simple;
	bh=m1SjG8ugznS7cfFTPWpCsU6Bn2rYcqj36xrYzkwRalQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUu+Sfx8NVn2vcRqEkJGct2Gq/+LRJQ5eo5WwJ4B6QOGzlbGbGQ/po2CD+7FIkbvb/HGN1aSeyV6AQeZzpdvWC0re4ita4EvyNikUOuH0XZVxo0Q88zkiywewpDiHaWnzjdrug6x6dvlT43aU5nFr57vJzZfmGpTnoKQaz8YoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWWTKUeq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWWTKUeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731462186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2rB3RrwPY1rfdMiysUodqNFLXKaLd7bLkjxE+eeG4c=;
	b=JWWTKUeqFAJH9qLjixZ06QL3EtlYkRuB6NKnrVIhAFxx47L4xzdtFIpFY1mnxE7GNeDyu7
	kHXP1w4NrWhkebNrWQ8piAeJ7nqhnxH5vAF0medDPb0H/Cz0Os0RC1kyRCR71xyAI6hnaG
	eCktlalRZyLCCAI4T8pnTZf1N6qWSYE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-CimQ59l-PSeTQiHF1AhyqQ-1; Tue, 12 Nov 2024 20:43:05 -0500
X-MC-Unique: CimQ59l-PSeTQiHF1AhyqQ-1
X-Mimecast-MFC-AGG-ID: CimQ59l-PSeTQiHF1AhyqQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e9b2c5189eso233979a91.1
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 17:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731462184; x=1732066984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2rB3RrwPY1rfdMiysUodqNFLXKaLd7bLkjxE+eeG4c=;
        b=d5qOTTPxJ5aFwauiYamqXPWHEHc67nfFwNAb7ikojnFJB57R+ILxww+2Nq2K7eAEk6
         XArjH/fqJmDVlO8zcthYNYeOqZza4drPQEjrjwxboAIF5xUmtvmUxwEzivyLNjiU3y6z
         UzmPhZ6MYO9tk8BBKQTqw+vS1Mbn50pI+2ovsc9YvU0mrpLUqeWwiXneNVSTsI65GMeC
         9o+6kihA+Ihvzc8iHMF8JAYZwMH7T7E9aYR6PFP74s1aWGqDuUS2xA5rTsj/a9KerxNi
         JhBE+VxVxnrC9Te5s5dWuucCmlpFnRHfv82a0P127Ob8fIQ1SajQHGVCZphtsZkyiDER
         s1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPbh/iy+FxEa4do2b0g7WT/uy1aNocnKF0K2Mp20XYCMfX4mxrepSCPt0Iq59QPd6Y7ifAg3vL2FLGDC1yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLMm1neEnHJL1RidKRVLjRoWC2GzbCIsEO3QjGDqhmv/EHjEZ7
	G5v+XbT0v7FI9f4ogxK1cKzYsuvEokT9lBFUsri7+gWXWnlImbMMHH8MrX1FF9wkD2xL8Q0tRDk
	cY2sc5fMW98OsgFLN1HegSc56pXuH1w+z2tWTmwrxylNsrAd8wkr6D3c3Po9pXBiIGhZzuh4/hO
	X6T8tu7NTSpIcimqY9MW3+RRj2K+gJsJm7z18Ln1M=
X-Received: by 2002:a17:90b:1a91:b0:2e2:c225:4729 with SMTP id 98e67ed59e1d1-2e9b0a3325emr29256963a91.8.1731462183974;
        Tue, 12 Nov 2024 17:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+vRCC4mrbHKut4t1fJto0Y0iBNbGPDhwP/9QXBKj/+OyIIO3GDNJxRo0creIYAsWkJaKGsGYm4Ut75lVbM+Q=
X-Received: by 2002:a17:90b:1a91:b0:2e2:c225:4729 with SMTP id
 98e67ed59e1d1-2e9b0a3325emr29256906a91.8.1731462183395; Tue, 12 Nov 2024
 17:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com>
 <20241105100647.117346-10-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+9USaOthY3yaJPT-cbfAcP0re2bbGbWU7SqOSYEW2CMw@mail.gmail.com>
 <37429ace-59c0-21d2-bcc8-54033794e789@kernel.org> <PAXPR07MB7984717B290B1BC250429D2BA3592@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <6c6aced9-7543-b195-93e9-17e824538c55@kernel.org>
In-Reply-To: <6c6aced9-7543-b195-93e9-17e824538c55@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Nov 2024 09:42:52 +0800
Message-ID: <CACGkMEt-JpE0-WwEQYWLFijLoqRcWr9CV08otOR=Veg61aVcrA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 09/13] gro: prevent ACE field corruption &
 better AccECN handling
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dsahern@gmail.com" <dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>, 
	"pablo@netfilter.org" <pablo@netfilter.org>, "kadlec@netfilter.org" <kadlec@netfilter.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, 
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gr-5vfjJVPhWgI-frJoWVzbxgqLuBhKIrqALamYdb-0_1731462184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:19=E2=80=AFAM Ilpo J=C3=A4rvinen <ij@kernel.org> =
wrote:
>
> Adding a few virtio people. Please see the virtio spec/flag question
> below.
>
> On Tue, 12 Nov 2024, Chia-Yu Chang (Nokia) wrote:
>
> > >From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > >Sent: Thursday, November 7, 2024 8:28 PM
> > >To: Eric Dumazet <edumazet@google.com>
> > >Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; netdev@=
vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; dsahern@kernel.org=
; pabeni@redhat.com; joel.granados@kernel.org; kuba@kernel.org; andrew+netd=
ev@lunn.ch; horms@kernel.org; pablo@netfilter.org; kadlec@netfilter.org; ne=
tfilter-devel@vger.kernel.org; coreteam@netfilter.org; ncardwell@google.com=
; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@=
cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.=
com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi=
_goel@apple.com
> > >Subject: Re: [PATCH v5 net-next 09/13] gro: prevent ACE field corrupti=
on & better AccECN handling
> > >
> > >
> > >CAUTION: This is an external email. Please be very careful when clicki=
ng links or opening attachments. See the URL nok.it/ext for additional info=
rmation.
> > >
> > >
> > >
> > >On Thu, 7 Nov 2024, Eric Dumazet wrote:
> > >
> > >>On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > >>>
> > >>> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > >>>
> > >>> There are important differences in how the CWR field behaves in
> > >>> RFC3168 and AccECN. With AccECN, CWR flag is part of the ACE counte=
r
> > >>> and its changes are important so adjust the flags changed mask
> > >>> accordingly.
> > >>>
> > >>> Also, if CWR is there, set the Accurate ECN GSO flag to avoid
> > >>> corrupting CWR flag somewhere.
> > >>>
> > >>> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > >>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >>> ---
> > >>>  net/ipv4/tcp_offload.c | 4 ++--
> > >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c index
> > >>> 0b05f30e9e5f..f59762d88c38 100644
> > >>> --- a/net/ipv4/tcp_offload.c
> > >>> +++ b/net/ipv4/tcp_offload.c
> > >>> @@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_hea=
d *head, struct sk_buff *skb,
> > >>>         th2 =3D tcp_hdr(p);
> > >>>         flush =3D (__force int)(flags & TCP_FLAG_CWR);
> > >>>         flush |=3D (__force int)((flags ^ tcp_flag_word(th2)) &
> > >>> -                 ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
> > >>> +                 ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
> > >>>         flush |=3D (__force int)(th->ack_seq ^ th2->ack_seq);
> > >>>         for (i =3D sizeof(*th); i < thlen; i +=3D 4)
> > >>>                 flush |=3D *(u32 *)((u8 *)th + i) ^ @@ -405,7 +405,=
7
> > >>> @@ void tcp_gro_complete(struct sk_buff *skb)
> > >>>         shinfo->gso_segs =3D NAPI_GRO_CB(skb)->count;
> > >>>
> > >>>         if (th->cwr)
> > >>> -               shinfo->gso_type |=3D SKB_GSO_TCP_ECN;
> > >>> +               shinfo->gso_type |=3D SKB_GSO_TCP_ACCECN;
> > >>>  }
> > >>>  EXPORT_SYMBOL(tcp_gro_complete);
> > >>>
> > >>
> > >> I do not really understand this patch. How a GRO engine can know whi=
ch
> > >> ECN variant the peers are using ?
> > >
> > >Hi Eric,
> > >
> > >Thanks for taking a look.
> > >
> > >GRO doesn't know. Setting SKB_GSO_TCP_ECN in case of not knowing can r=
esult in header change that corrupts ACE field. Thus, GRO has to assume the=
 RFC3168 CWR offloading trick cannot be used anymore (unless it tracks the =
connection and knows the bits are used for RFC3168 which is something nobod=
y is going to do).
> > >
> > >The main point of SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or =
NETIF_F_TSO_ECN offloading to be used for the skb as it would corrupt ACE f=
ield value.
> >
> > Hi Eric and Ilpo,
> >
> > From my understanding of another email thread (patch 08/13), it seems t=
he conclusions that SKB_GSO_TCP_ACCECN will still be needed.
> >
> > >
> > >SKB_GSO_TCP_ACCECN doesn't allow CWR bits change within a super-skb bu=
t the same CWR flag should be repeated for all segments. In a sense, it's s=
impler than RFC3168 offloading.
> > >
> > >> SKB_GSO_TCP_ECN is also used from other points, what is your plan ?
> > >>
> > >> git grep -n SKB_GSO_TCP_ECN
> > >> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:3888:
> > >> skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCP_ECN;
> > >> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:1291:
> > >> skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCP_ECN;
> > >> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:1312:
> > >> skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCP_ECN;
> > >
> > >These looked like they should be just changed to set SKB_GSO_TCP_ACCEC=
N instead.
> >
> > I agree with these changes and will apply them in the next version.
> >
> > >
> > >I don't anymore recall why I didn't change those when I made this patc=
h long time ago, perhaps it was just an oversight or things have changed so=
mehow since then.
> > >
> > >> include/linux/netdevice.h:5061: BUILD_BUG_ON(SKB_GSO_TCP_ECN !=3D
> > >> (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
> > >> include/linux/skbuff.h:664:     SKB_GSO_TCP_ECN =3D 1 << 2,
> > >
> > >Not relevant.
> > >
> > >> include/linux/virtio_net.h:88:                  gso_type |=3D SKB_GS=
O_TCP_ECN;
> > >> include/linux/virtio_net.h:161:         switch (gso_type & ~SKB_GSO_=
TCP_ECN) {
> > >> include/linux/virtio_net.h:226:         if (sinfo->gso_type & SKB_GS=
O_TCP_ECN)
> > >
> > >These need to be looked further what's going on as UAPI is also
> > > involved here.
> >
> > I had a look at these parts, and only the 1st and 3rd ones are relevant=
.
> > Related to the 1st one, I propose to change
> > from
> >
> >                 if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
> >                         gso_type |=3D SKB_GSO_TCP_ECN;
> >
> > to
> >
> >                 if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
> >                         gso_type |=3D SKB_GSO_TCP_ACCECN;
> >
> > The reason behind this proposed change is similar as the above changes
> > in en_rx.c.
>
> But en_rx.c is based one CWR flag, there's no similar check here.
>
> > For the 3rd one, I suggest to change from
> >
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >
> > to
> >
> >                 if (sinfo->gso_type & (SKB_GSO_TCP_ECN | SKB_GSO_TCP_AC=
CECN))
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >
> > This proposed change is because VIRTIO_NET_HDR_GSO_ECN must be set to
> > allow TCP packets requiring segmentation offload which have ECN bit set=
.
> > So, no matter whether skb gso_type have GSO_TCP_ECN flag or
> > GSO_TCP_ACCECN flag, the corresponding hdr gso_type shall be set.
> >
> > But, I wonder what would the driver do when with VIRTIO_NET_HDR_GSO_ECN
> > flag. Will it corrupts CWR or not?
>
> I'm starting to heavily question what is the meaning of that
> VIRTIO_NET_HDR_GSO_ECN flag and if it's even consistent...
>
> https://github.com/qemu/qemu/blob/master/net/eth.c
>
> That sets VIRTIO_NET_HDR_GSO_ECN based on CE?? (Whereas kernel associates
> the related SKB_GSO_TCP_ECN to CWR offloading.)
>
> The virtio spec is way too vague to be useful so it would not be
> surprising if there are diverging interpretations from implementers:
>
> "If the driver negotiated the VIRTIO_NET_F_HOST_ECN feature, the
> VIRTIO_NET_HDR_GSO_ECN bit in gso_type indicates that the TCP packet has
> the ECN bit set."
>
> What is "the ECN bit" in terms used by TCP (or IP)? Could some virtio
> folks please explain?

According to the current Linux implementation in virtio_net_hdr_to_skb():

                if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
                        gso_type |=3D SKB_GSO_TCP_ECN;

It mapps to SKB_GSO_TCP_ECN which is:

        /* This indicates the tcp segment has CWR set. */
        SKB_GSO_TCP_ECN =3D 1 << 2,

Thanks

>
>
> --
>  i.

