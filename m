Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958962;
	b=X5g9wqNXtG9XIDvgGpxIBLhXiRbOdzp9pQhvW7rs6G3hbF01mxzq0iNwzgkyOlhMZRLt
	 uNJtchuGUtYsVVByInGIxC+HLr0rSgRaaMMeo9L5jBy8IH977TTEi7+5VdQfwngVZkKAl
	 8aPwYH63HiqtgWTVh2SMpIdIAF8wl6mAX0MCe7+O6uQnQnEAOsA+63p6QmX8QibkufL0N
	 vqWbI2OaIZ66CPcT0JEgKQGkCURpBTIx5jiAU+C/C3mOScLKaRMMvRk/K74thd8HFXqiW
	 WWcLiUuHMNW2VXXRyOs3XZrLqNAhQhUvUMtX/EwCmRtRELDtY+eagPDM7k086bP25bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958962;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IQAaNA5x2J6cR42Xyyfpudju4b6qQzyTPkfO1wBJwtM=;
	b=bjhR9ZQ7rCmNtgSorIwGMITAnppnd0grTRu0JCqyz4mgVzHYKqdZVs/B2NsRBe3qLd4p
	 kBAyWLE+aPx2+EmCn+hVfCjuoQNbuZwgNcvHJ6XvdLOVL2Nw6aHQiGoDDLcj3s4PsINoF
	 YaQD8iboDM/FJLflxmYtxM8n6CVigdT7jm4CwyVlStmhdg/mj8NKjGmGY3KeCnvD11jfG
	 PdLXu801Ee+dEk0R6vW4xHbTMMv8zP7LE+zHHk3w6GmPij2akmtfMMhOsUIpiR2q1AV+x
	 47X4eHQD8kSdM5RFYQazwmSCLAU0TlEZCVxsz8EuIyyFzPilr2fBEBR6iUR4ayZNACg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fqk/Fl+j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5406606A328
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqk/Fl+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DF1F008A7
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958961;
	bh=IQAaNA5x2J6cR42Xyyfpudju4b6qQzyTPkfO1wBJwtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fqk/Fl+j1fyQ6NyBxC1a3+LWlkyUbGSrX/Qyp7EXACCHdWOIgLGN6W5ku8sg3gQdv
	 u93YCG9vHdgZG5K1UGXWGZJQLHrfOK8maGIIPnDsvioUfrNKizO8DVa1hA3Tik/kCV
	 UU2pUGcSWvnLiimimVgAwX5YZqspY5ueDlAU6rz8Cjki5WgkNzrdRvqm7wWPVeaTBy
	 zi6lKybi2VPFGBa6Nfeo7EJY3Av9meVlhcv3ssoNqWE7SRAvPumM0YH7+bMR82Ugem
	 ev4aGXDYvsY49x0CqjUESYf2WsiL9fsuXzhGU3MpcRyjOLFgH7zf/b9DNxJDxqN13k
	 LSLLzwKT4723w==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843cf077f10so729193a34.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 01:56:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwZuN8uPd5VTLdkEc/n4zum7QalzQEVMncQ8VbCoTHPuCqt+xQ8g7/MhVN6c0wkT6xk5Bepbq6BA2LBJO9iVQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ccmiGP+gs4oa/mM8Gg/yQ9UW9nJ6KLLk30NpYCWuEBKk3+Ujd
	5JIGw4H6njEjprBHPliTw64cvy7djstXb/KnlxfFzDPljjU8oob+3/DHiy1vl8BIuwmgzyZnJfY
	u6tneht1u+t3bF64sFn4BvJX/AaoDjP0=
X-Received: by 2002:a05:6820:628:b0:6b6:c0bc:365c with SMTP id
 006d021491bc7-716e78812f4mr1280505eaf.22.1793958960523; Fri, 06 Nov 2026
 01:56:00 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-3-edumazet@kernel.org>
 <20261106042744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261106042744-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 10:55:49 +0100
X-Gmail-Original-Message-ID: <CAL4WiirN0keZgyx6bP-+_96FEAsQAHnbkgJ0fC+DcFCY3zjXvQ@mail.gmail.com>
X-Gm-Features: AclHuK8ZDTLU4isi_dgkuIx-7_ncwrjPNhIMfW1viOX5kV74wv3XHkP7rOme_5c
Message-ID: <CAL4WiirN0keZgyx6bP-+_96FEAsQAHnbkgJ0fC+DcFCY3zjXvQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Hassan Sultan <hassansultan@google.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 10:28, Michael S. Tsirkin <mst@redhat.com> a =C3=
=A9crit :
>
> On Thu, Nov 05, 2026 at 12:57:09PM +0100, Eric Dumazet wrote:
> > virtio_net_l3_start() decides from skb->dev->type whether the frame
> > starts with an Ethernet header. tun decides it from the IFF_TAP and
> > IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> > to any value, without changing the flags.
> >
> > On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> > look at the IP header at the network header (ETH_HLEN), and never read
> > the Ethernet header. eth_type_trans() then sets skb->protocol from an
> > unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> > the skb_under_panic() addressed by the previous patch.
> >
> > On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> > Ethernet header that tun then treats as the start of the L3 header.
> >
> > Checking in tun that the device type matches the framing is not
> > enough: the type is read again later, and a concurrent TUNSETLINK can
> > change it in between, since tun_get_user() only drops packets of a
> > down device after these checks.
> >
> > Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> > virtio_net_l3_start(), so the device type is no longer used:
> >
> > - virtio_net always receives Ethernet frames.
> > - tun_get_user() passes whether the device is IFF_TAP.
> > - tun_xdp_one() always calls eth_type_trans() on its frames.
> >
> > Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org=
/
> > Link: https://lore.kernel.org/netdev/179387332014.488856.91119564136101=
07951@kernel.org/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Sorry, I saw this reply too late, I sent v4 without it.
