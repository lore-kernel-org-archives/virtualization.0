Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B5199FAC
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750594; cv=none; b=Ik1f55+c6B14rNszWZkfcTNGqNebWUyr2OmYJxTY+Wv47gtp6AWm0M6WhGI1xtukUw5NMbgw253aRL1tP3kayTGlJTk8myk9J7serC3Amx/dzj3H8brEkkMCn9UyZ5cHgN8QvRtLYsnPd18EUo/L5hAb6vwTtyIP/GEhlPGc09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750594; c=relaxed/simple;
	bh=Dyw0HFF2I3UqKNeJMJWrFl+V1/u9vlMYXlU1qdh2Fs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZu6arsS13D4IzaZQKvpUjKdTn5aSB2AyCMPyOAHBSI3sIEMPdluMEZbeQvGdPuH38npVl4jtd4y7qwZ37egsN7a9TR2ngOdDv+X++jlnrgNYFMjqvKv6KgfqbKvKCsa7pGwXN9217d+ZMYoQY+KB39HfduXyqkFLEOqVBWzgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dmz5LxR6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dmz5LxR6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 713AB8210C
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLOSeEStas2M for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 03:36:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6B1E0820F8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B1E0820F8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dmz5LxR6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B1E0820F8
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741750590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZpwUgpQlsRSqyhUJVMbAHrvSDusnw6V0w+ye5eNYLw=;
	b=Dmz5LxR6i3Ip8WdW5GUj4NlplR5B9aJy1+TKJBs2e2yX9/4xgolDxhKIfP/PNn5yyfcoI1
	r9rwoO6biiJg1SEymS2fm5wdm3c+Nt9WEtrk/AYBZ4rcFH68UOGypZSdCfxrSP9aSYL0F6
	hysjOwjyFjuUyHlkcwACb2Vn47nCT5A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-qbc2iwQmNhOBDmh3y9pRJw-1; Tue, 11 Mar 2025 23:36:29 -0400
X-MC-Unique: qbc2iwQmNhOBDmh3y9pRJw-1
X-Mimecast-MFC-AGG-ID: qbc2iwQmNhOBDmh3y9pRJw_1741750585
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224192ff68bso95616575ad.1
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 20:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741750585; x=1742355385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZpwUgpQlsRSqyhUJVMbAHrvSDusnw6V0w+ye5eNYLw=;
        b=tWSaf+JOajcgkD10HxlVAKW6ZyM34V3UuAhUngrKRy1orIBTrFFeT3FUV2R4hQ31Vm
         AYgdFBE4devgsPdl0YCMnDXAVAhEG0OpqikQI6J7ajtbuXqV8uMsnrteDN9lFlTm9dWv
         /CL5H3JMynkD945S8c7J797r6cSxxxG0wXRENpwFL12Kj2NFSuBoiFqYRS1RsADDj/S7
         xhf4wMv086JL1sqzI8Zb9fpzKtiyN4vGD9QexVxwBX91JNDXSjqby3VCw6c6YiF+xMKb
         iEL045iM5E3gmlx2CNjOYCD3IWvy7N/lsyQRqc/Dug8UTnxpkSH3poU62EpSqkn9wB6V
         j9EA==
X-Forwarded-Encrypted: i=1; AJvYcCXXZu1BweLs3eYjadRn89ap32rgkf/65+hEgRdY+WIG7Wiv/Rqb6NFx3aVqmTESDQDbgsT78TT1Z4SvJ+A5Dg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3Qlf0MsKqOKdwzEbn6jY8ZWtwLl9ZXditmiYqjZ7AF8lVmwg5
	hPfY04nEWMUS8OAgToMgfe7R+YQCsUdZxAluhpCVVBi9UmalSVWOtHa/q/h/mSqVIQWDcXOJCCN
	wOhj4Sz/avPD7/GiyMkmDamR7p4SRsc/h6/AJidxqVWjeZGID73cF7oGG6f/53x8LdbqMbJnm6n
	pxD+F0X62ySm2Dwxk8vepnOmgqQ0VeakgKuT2pNa1mB5XFoovy8d875w==
X-Gm-Gg: ASbGncuSpOdKqVgUJqqEWuUVt/PsLjlt9koMO0miXld6ptAM9mcZgd0hYF0fQelzvLL
	qGAsVyawB9l7cgCyy/6uvvjxMoez509EHztH/2gYyh58mkTRsGYe3ZGjuUXZYYMtSOBtuKw==
X-Received: by 2002:a05:6a00:238d:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-736eb667a71mr7986971b3a.0.1741750584750;
        Tue, 11 Mar 2025 20:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmxpIAevVVywh2O0MaRFt52q3IQdqP0x11H7Tx5Em3ifIbgwiYbMghj8Z7Q/WU0TpCaMabTo/4ereJNFvbKw=
X-Received: by 2002:a05:6a00:238d:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-736eb667a71mr7986941b3a.0.1741750584315; Tue, 11 Mar 2025
 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com> <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
 <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
In-Reply-To: <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 11:36:11 +0800
X-Gm-Features: AQ5f1JrxpKp6znsUaqgeF38Q8NdhxxsJo9tfhGhP07-EGgT1K5NsmabBVB2dyas
Message-ID: <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: ZFPDsXGymBjtvrA-jEntQBKTDpVdEI6IKrx6sO-je9U_1741750585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:42, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 13:43, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on =
the
> >>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
> >>>> hash values (i.e., the hash_report member is always set to
> >>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
> >>>> underlying socket will be reported.
> >>>>
> >>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++-----------=
---------
> >>>>    1 file changed, 29 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c3=
02f3586ea6bb5e0d4289 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -73,6 +73,7 @@ enum {
> >>>>           VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>>>                            (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>>>                            (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>>>                            (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>>>                            (1ULL << VIRTIO_F_RING_RESET)
> >>>>    };
> >>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
> >>>>                   .msg_controllen =3D 0,
> >>>>                   .msg_flags =3D MSG_DONTWAIT,
> >>>>           };
> >>>> -       struct virtio_net_hdr hdr =3D {
> >>>> -               .flags =3D 0,
> >>>> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >>>> +               .hdr =3D {
> >>>> +                       .flags =3D 0,
> >>>> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>> +               }
> >>>>           };
> >>>>           size_t total_len =3D 0;
> >>>>           int err, mergeable;
> >>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>>>           bool set_num_buffers;
> >>>>           struct socket *sock;
> >>>>           struct iov_iter fixup;
> >>>> -       __virtio16 num_buffers;
> >>>>           int recv_pkts =3D 0;
> >>>>
> >>>>           mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
> >>>>                           vhost_discard_vq_desc(vq, headcount);
> >>>>                           continue;
> >>>>                   }
> >>>> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcount=
);
> >>>>                   /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET=
_HDR */
> >>>>                   if (unlikely(vhost_hlen)) {
> >>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >>>> -                                        &fixup) !=3D sizeof(hdr)) {
> >>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>> +                                        &fixup) !=3D vhost_hlen) {
> >>>>                                   vq_err(vq, "Unable to write vnet_h=
dr "
> >>>>                                          "at addr %p\n", vq->iov->io=
v_base);
> >>>>                                   goto out;
> >>>
> >>> Is this an "issue" specific to RSS/HASH? If it's not, we need a separ=
ate patch.
> >>>
> >>> Honestly, I'm not sure if it's too late to fix this.
> >>
> >> There is nothing wrong with the current implementation.
> >
> > Note that I meant the vhost_hlen part, and the current code is tricky.
> >
> > The comment said:
> >
> > """
> > /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> > """
> >
> > So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
> > to mrg_rxbuf len.
> >
> > And this patch changes this behaviour.
>
> mrg_rxbuf only adds the num_buffers field, which is always set for
> mrg_rxbuf.
>
> The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but this
> was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers for
> virtio 1.0")
>
> So there is no behavioral change for existing features with this patch.

I meant this part.

>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>> +                                        &fixup) !=3D vhost_hlen) {

We should copy only sizeof(hdr) instead of vhost_hlen.

Anything I miss?

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >> The current
> >> implementation fills the header with zero except num_buffers, which it
> >> fills some real value. This functionality is working fine with
> >> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header=
 size.
> >>
> >> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> >> field, which also needs to be initialized with zero, so I'm making sur=
e
> >> vhost_net will also initialize it.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Others look fine.
> >>>
> >>> Thanks
> >>>
> >>
> >
>

