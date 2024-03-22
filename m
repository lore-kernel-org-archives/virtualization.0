Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606D65C
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074587; cv=none; b=c5fBSTWm4AqsTcEJ4+V4Af+jzrvAjsZXRIy2iF5m+6ZWcBwXco+8q9uxbPAwATNT5nEiM+rl6Vn6O0wiT7wFAWD+BcaVAQFp5//3vpmevmHDGtzwhbkSXuMsZdlYHec3Ec97xYMt/K3T6b2Zf8VX/RpMe5U6GVxOovP8RhfcWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074587; c=relaxed/simple;
	bh=CieOxzIBUlQZFUCEz7pUgclpokc3TUGzvfoHbgAjT0c=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=BXJ1pAAYxpy6NY1tmIzK9m6B5Sj/fCEj2p1LoSI6FbKb7ASSRtBeMwBtQ22uMdRsOX9Qo9yUs1Gk4aztha3gHiJ4FW+568Zp2z4VBjON1VjoR9YmomVg/oF6V3KJnC1Cg5JQaTfGHwfZinyPlwLq40vEBfYDewUJg2fxmpnl9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sXvpVmSM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sXvpVmSM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711074582; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=llvpoe0TiqXlqpm6Zn+2Eb/X7ym0DKMgmBHC9RDyCLM=;
	b=sXvpVmSMZbovE29z9CQftY/WmbMIQYK5wUEaFE0tcr7rPPqz98wV+zsuutXNl6nYx7wzc6bbDfDrwgsSWMlCkF3A13ObZnuJBhFf6gsSSTB+jnao0ACPhXVgIfDSa7BeBW6ghW9wQ6RSCrgGb3cQ3spA4m9LUZeNdHHHF+wpGBY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W30NP74_1711074581;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W30NP74_1711074581)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 10:29:41 +0800
Message-ID: <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
Date: Fri, 22 Mar 2024 10:27:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Spike Du <spiked@nvidia.com>
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
In-Reply-To: <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The virtio spec says:
> >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> >     been negotiated:
> >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driver
> >         MUST set hdr_len to a value equal to the length of the headers,
> >         including the transport header.
> >
> >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiate=
d,
> >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD set
> >         hdr_len to a value not less than the length of the headers,
> >         including the transport header.
> >
> > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
> > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> >
> > But now:
> >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headlen(skb));
> >
> > The skb_headlen() returns the linear space of the skb, not the header
> > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature has
> > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> >
> > We do not check the feature of the device. This function is a common
> > function used by many places. So we do more stricter work whatever
> > the features is negotiated.
> >
> > For the case skb_is_gso(skb) is false, if none of the
> > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiated,
> > the spec not define the action of setting hdr_len. Here I set it to
> > skb_headlen(). If one of the above features have been negotiated, we
> > should set a value not less than the length of "eth header + ip header +
> > tcp/udp header". So the skb_headlen() also is a valid value.
> >
> > For the case skb_is_gso(skb) is true, it implies that one of
> > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST set
> > it to the length of "eth header + ip header + tcp/udp header".
> > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
> > valid value.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reported-by: Spike Du <spiked@nvidia.com>
> > ---
> >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 4dfa9b69ca8d..51d93f9762d7 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(const s=
truct sk_buff *skb,
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +               u32 hdrlen;
> >
> > -               /* This is a hint as to how much should be linear. */
> > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > -                                                skb_headlen(skb));
> > -               hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > -                                                 sinfo->gso_size);
> > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_offs=
et(skb);
>
> So could evil guests give us a 0 hdrlen through this. If yes, it seems
> much more dangerous than headlen or we need harden the value as
> 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.

Spec says:
	If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, and
	gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device MAY use
	hdr_len as the transport header size. Note: Caution should be taken by
	the implementation so as to prevent a malicious driver from attacking
	the device by setting an incorrect hdr_len.

	If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated, or
	gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr_len only as
	a hint about the transport header size. The device MUST NOT rely on
	hdr_len to be correct. Note: This is due to various bugs in
	implementations.

The device nerver trust the hdr_len completely.
So I think that is safe.


>
> > +
> > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_offs=
et(skb);
> > +
> > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > -               else
> > +                       hdrlen =3D sizeof(struct udphdr) + skb_transpor=
t_offset(skb);
> > +
> > +               } else {
> >                         return -EINVAL;
> > +               }
> > +
> > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO opti=
ons MUST
> > +                * have been negotiated. If the VIRTIO_NET_F_GUEST_HDRL=
EN is
> > +                * negotiated, we MUST set it to the length of "eth hea=
der + ip
> > +                * header + tcp/udp header".  If the VIRTIO_NET_F_GUEST=
_HDRLEN
> > +                * is not negotiated, that still be a valid value.
> > +                */
>
> I'd stick the headlen for deivce without GUEST_HDRLEN. It seems much
> more safe as we don't want to break legacy devices.

I do not get it.

Thanks.


>
> Thanks
>
>
