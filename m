Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD63587C0
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375131; cv=none; b=nIwQEYEIGvmM/bjLHmVsCGj/V85v+H8G6yNvywiBMRDmRPXtussP0PDkZMGHhwOXbLYx2w9gEZlr+8ObwNw3+whDoKodWJW++716vgd63Ub3gc2XD73706bT4cMi4dSohcrhqy5iG0ZHDDrJ5H2LR4MaVWBMfbwjqKGlUlHTkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375131; c=relaxed/simple;
	bh=kqP77k226Wx8tCQ/0jWeIHBXDlzM0lq0ign/yDhfiAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnuZd9BTtNRMPdtqQkqHR/VfnnUmssvvI8+IXplLVh64PN/UVhDsoFC769KwBmBRFXJ+TYHGAlE2EHY6VciLYkFdv8QnF/bqAxXQxUzeAGsEtyfNTL2I32ZS8kimYy+a+W5vh5cZlUj7woBXGK5LhgTNRQJFPeckQtt1I5V+sdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw+UjI7U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw+UjI7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768375123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
	b=Vw+UjI7UgeDsiuTK+AldtFGslG1lpa6BX8qwit8ktjV04T28NF/6JZkLXvWX+JezbhZZjZ
	blBvO00IdKaLRR7uXFex1toqeaiQRsB5cvpRNriGftNCRo1DS1vuj5Ni1MFoiHLkqUlU6t
	8ajpR1bV5fdYtvB7Na3Sqt175FSzlFM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-fFzj11naPuqL0dKlhCzw3Q-1; Wed, 14 Jan 2026 02:18:42 -0500
X-MC-Unique: fFzj11naPuqL0dKlhCzw3Q-1
X-Mimecast-MFC-AGG-ID: fFzj11naPuqL0dKlhCzw3Q_1768375121
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c904a1168so9088048a91.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 23:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768375121; x=1768979921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
        b=AJShaS6mZH/GrnsizBqEipIRGdnQq6zbZzhwmZ+QMzIDZV0JmMG3tEue2HbC/PMfBu
         N+/EdcgkYxc3kcc5qJCqePJmZ5l8wGITVpbrO80BRgl4vFheVueUbLMEL0n8qbFO/1fr
         4jsZ7v9syVYN1vGsAS8Cm8UyTIaG/DhuHxk1zrxqdeymSUPr9ZVLcVlZmjns40F3Hx2v
         D4dp272eHjRWM4x5UHktK1nTZUK/rLWGJgfaJGsD0LZonYg0PwCqYFKnCxfm739SUS5h
         M0YP3mO2AQd532bOltXLmNqgGyGUM3r8uKen/hwAbcy/tGxPuKJc807S34ZHrme385vI
         +Bog==
X-Forwarded-Encrypted: i=1; AJvYcCVsppYGr5fcxJjDYTwwAYyE3l89we/9dLX0dwo2Da8sWgn9fIZ+jIxj19IOKx2Rq8UelM9n5hSoD/MidnCdtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuF/7k7meknXgDxxsmlYtFPQgTLQ+PtPqR7bXL7D4pWMDOB323
	wvrLg+f33aV1VKgdNV1l2zdLguf/Wm/5WpwJLHJkIRHipWJCar9j1RqyKDJo3eBqqqT+w65g29g
	EQIC9eSuNbBFADwz/hP98LToxUeklFggLh3gZSFdEumyY4Y2qcnnuAzlUE9FGSr+4JHD4T3b+ri
	QyXBiGaD1KRFMfmutlSlNtfWbc9NiGjjUMfal5D19kVGc=
X-Gm-Gg: AY/fxX4Ox2Cnde8LxDfRK3gMlCVbDsGTaqskO6uXJ13dbf8cpFwmsJEJpoLtBKpe3+F
	JmlHd0AH6cw3dQIh917gHq+K8GKloc1QvoDDRgQv5Z0byM8kvAMfvduX1i8homVhi82j1i+MFgx
	kIY+93hq4CcI4XaKeW6f9mH6U7lySFC7rG/AqPhMNxmwtNvyh+t5Refz0BATS8Gq4=
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-3510913fd7bmr1582686a91.32.1768375121008;
        Tue, 13 Jan 2026 23:18:41 -0800 (PST)
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-3510913fd7bmr1582663a91.32.1768375120558; Tue, 13 Jan 2026
 23:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aWIItWq5dV9XTTCJ@kspp> <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
In-Reply-To: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Jan 2026 15:18:29 +0800
X-Gm-Features: AZwV_Qil4_emZc9UC594LVQZD_WDE3u0sgwiGLvdx73MXFe_Cb2QNMYVC2G9b8k
Message-ID: <CACGkMEuFePpfpFvnJz6xvrKrVG84KmAfODP55cCJgFzZqba29A@mail.gmail.com>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct virtnet_info
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IWtbfv5_u2My28N2jHLDA76UyLGv6pDzIk4fMRVfj18_1768375121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> > Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> > along with the following warning:
> >
> > drivers/net/virtio_net.c:429:46: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
> >
> > This helper creates a union between a flexible-array member (FAM)
> > and a set of members that would otherwise follow it (in this case
> > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > overlays the trailing members (rss_hash_key_data) onto the FAM
> > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > The static_assert() ensures this alignment remains.
> >
> > Notice that due to tail padding in flexible `struct
> > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > below:
> >
> > struct virtio_net_rss_config_trailer {
> >         __le16                     max_tx_vq;            /*     0     2=
 */
> >         __u8                       hash_key_length;      /*     2     1=
 */
> >         __u8                       hash_key_data[];      /*     3     0=
 */
> >
> >         /* size: 4, cachelines: 1, members: 3 */
> >         /* padding: 1 */
> >         /* last cacheline: 4 bytes */
> > };
> >
> > struct virtnet_info {
> > ...
> >         struct virtio_net_rss_config_trailer rss_trailer; /*    80     =
4 */
> >
> >         /* XXX last struct has 1 byte of padding */
> >
> >         u8                         rss_hash_key_data[40]; /*    84    4=
0 */
> > ...
> >         /* size: 832, cachelines: 13, members: 48 */
> >         /* sum members: 801, holes: 8, sum holes: 31 */
> >         /* paddings: 2, sum paddings: 5 */
> > };
> >
> > After changes, those members are correctly aligned at offset 795:
> >
> > struct virtnet_info {
> > ...
> >         union {
> >                 struct virtio_net_rss_config_trailer rss_trailer; /*   =
792     4 */
> >                 struct {
> >                         unsigned char __offset_to_hash_key_data[3]; /* =
  792     3 */
> >                         u8         rss_hash_key_data[40]; /*   795    4=
0 */
> >                 };                                       /*   792    43=
 */
> >         };                                               /*   792    44=
 */
> > ...
> >         /* size: 840, cachelines: 14, members: 47 */
> >         /* sum members: 801, holes: 8, sum holes: 35 */
> >         /* padding: 4 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> >
> > As a result, the RSS key passed to the device is shifted by 1
> > byte: the last byte is cut off, and instead a (possibly
> > uninitialized) byte is added at the beginning.
> >
> > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > moved to the end, since it seems those three members should stick
> > around together. :)
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Update subject and changelog text (include feedback from Simon and
> >    Michael --thanks folks)
> >  - Add Fixes tag and CC -stable.
>
> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> think it should land in the 'net' tree, right?

Right.

Thanks

>
> /P
>

