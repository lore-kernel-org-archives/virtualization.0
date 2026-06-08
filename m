Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BE3B4E9F
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911429; cv=none; b=CHjZJvILrus72egZnkl32SNyxmMdQg1HN3qykSqU8nRFTy4ktvs0b0B0Zmua1DYRvi8xUobL9d6OHYIE7DnFsfxDXGNnn0q9TX3PbBfzete/9M6zTi/kffncyzutKf0n2pxt2s4de1nuSfwBWebHISSnXBgzL5dx//6pjQ0OnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911429; c=relaxed/simple;
	bh=59/tSJ0dW51Zn1c5BQkejmWziRwoc8zt4d0DBdDQLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpfRHVrsLTpkhtuhjLrsfzJTAJNlgS3KHlzwruNKp3v+meNDGskemxhWvowVOtv9V7a1dlFmQVoX17tsrtiGug9eZIL5zX6rU6VlV6RLTchb/I5ky/ceD4tiGrv+V4K5TDVCTMEQ3ViGjB+c+FEV2C+MVNSqipVcSvr5K5QM9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX6SQVxf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX6SQVxf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 516D960BE4
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 09:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6j3Xsfzc0SuB for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jun 2026 09:37:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=david.laight.linux@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE8F660BE1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE8F660BE1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NX6SQVxf
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE8F660BE1
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 09:37:05 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1818862f8f.3
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jun 2026 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780911424; x=1781516224; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=NX6SQVxfM7wd1f6r43yM/i6byt7sE0kGaQSjNlrFyxLymOULON1QHXW7QbBVscG2aB
         OGv21wTGGMtUtxtxer7MjIGfQCQiyl24ZCEkGqqlDkW/L6hbvL9H6y3JuGL8xcBPeBnu
         dq+iAUCXvuz2UfT2fobQ7l3A9ZfqkhDmfDziF840vI2yo2eLdLulYerSqBovqSP8mtsm
         ajO2bAaVGabsb5c0/AHrfamIvYASlfHNgKnBMasA2p/471oiXpub5mAyrtT2+jEivKOX
         Ro4ftkjyozTuYyeE8Dym2Fy+VVmaj12Jb7OB8PFqNOvlQLstC8BPYprcdGiH0TaT8Wce
         OECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911424; x=1781516224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=iv4re4Pmi8Lfy/5b/bGRlvCERyDM3ywFHoEgJy8wLY2dc7rfkkaD0odBjwfCH2JW40
         Ti30GizCzClA4mBAngi2M4E4U3TfuzrejAVOShMzgV0pwKTmQtoVAZ8zq+GAqxy+Q894
         RIImKk/EujWAZ5Ie8ew0J5IwMkeIv/Ybjl2pTy0TYlRVQVOMaleBTh6Bfa59mzKxFbO/
         y3Anur9IDA10JwJTUHb7SWfOoNdwyK1B6kZNXbM9nYL/FNZUF5/LnPplYBgtSuAikn+d
         51YKvrnhSXoZ25x9FFupXLSc/0oTuqK2xzbON/UQJruHpPyh1K4CjjJA/6YG+uJEF36R
         QfCw==
X-Forwarded-Encrypted: i=1; AFNElJ/sGNLh0UrpHV1ReTv7CYhgJEMz71My3LufUOL4q53eNF+E2OYbcPgku61uqpkrfbwi11yxq67H8LFa2vfxdg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzaHFtMXCSs0phUQCZdpCMnphf8GGV13giCSDX1+c4oS0Nx10R5
	lPYDEPunl9H+2oRdn/zR4q75SYObEWcbmnioRFruBozuPMdI2j5Sjrog
X-Gm-Gg: Acq92OHR3Dm+ZqjgIDtwdV+oguvHEw137XTA4xlV4eGeXt2lx2OJb+qvJx7XW7H3HKt
	Ez8bmuU2lSrjuvBVLiN8es1OOjXILiKO2R/wuIBv6APzbJKHj6W7VAKnipvFkrgrkUCsXCBhCfM
	pVxh7/yokiWF5+P5sA+oFUv6jVlgbYPU6t/sVuJXUmaC3e6mK9ag0sPobQ7FaiNYqAmYi27Uk6Q
	5HW5X696Bk4kcbe1U1MwVC3ksaHcCHvWacu903QcsuyhOcpAv4itnSAavefLsKftewsqMGmuo5I
	J1L18pEas9WnjsRVXdYXB69R4Tllno9QdHpNvAtcDp7XR8g3xbxnkdisqHUt9h4TCVUUv8Wcuey
	6JgwqHU+PQ6kYVH9BJboBE/yQGYpPoyRQs0gVCbssj4cOmoi5F4IntRjVFq/pfx7Fs+fgQqUtz7
	KFCK5aJK6LVtKClqzVsjLpk7Y9qO589LfST/A+PU7aYs4E9lXNX/xtAAfUsdrWyXpd6Z/RqaQaN
	48rcQXy1g==
X-Received: by 2002:a5d:42d1:0:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-46030609782mr16804802f8f.22.1780911423510;
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm55824962f8f.5.2026.06.08.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:37:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260608103701.7839ff1b@pumpkin>
In-Reply-To: <e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
	<20260605160851.3ddbd2ed@pumpkin>
	<e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 11:10:24 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> On 05/06/2026 18:08, David Laight wrote:
> > On Fri,  5 Jun 2026 14:53:14 +0300
> > Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
> > =20
> >> Logically it was based on TCP implementation, so to make further
> >> support easier, rewrite it in the TCP way.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> >> ---
> >>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
> >>  1 file changed, 32 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> >> index 2fd9eaaf5ca6..00caeeaa5590 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struc=
t virtio_transport *t_ops,
> >>  static int virtio_transport_fill_skb(struct sk_buff *skb,
> >>  				     struct virtio_vsock_pkt_info *info,
> >>  				     size_t len,
> >> -				     bool zcopy)
> >> +				     bool zcopy, struct ubuf_info *uarg)
> >>  {
> >>  	struct msghdr *msg =3D info->msg;
> >> =20
> >> +	/* We have completion - attach it to 'skb'. */
> >> +	skb_zcopy_set(skb, uarg, NULL);
> >> +
> >>  	if (zcopy)
> >>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
> >>  					       &msg->msg_iter, len, NULL);
> >> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  						  u32 src_cid,
> >>  						  u32 src_port,
> >>  						  u32 dst_cid,
> >> -						  u32 dst_port)
> >> +						  u32 dst_port,
> >> +						  struct ubuf_info *uarg)
> >>  {
> >>  	struct vsock_sock *vsk;
> >>  	struct sk_buff *skb;
> >> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  	if (info->msg && payload_len > 0) {
> >>  		int err;
> >> =20
> >> -		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> >> +		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy, ua=
rg);
> >>  		if (err)
> >>  			goto out;
> >> =20
> >> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >>  	if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_RW)
> >>  		return pkt_len;
> >> =20
> >> -	if (info->msg) {
> >> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> >> -		 * there is no MSG_ZEROCOPY flag set.
> >> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> >> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> >> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> >> +		 * handling from 'tcp_sendmsg_locked()'.
> >>  		 */
> >> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> >> -			info->msg->msg_flags &=3D ~MSG_ZEROCOPY;
> >> +		if (info->msg->msg_ubuf) {
> >> +			uarg =3D info->msg->msg_ubuf;
> >> +			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> >> +			uarg =3D msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> >> +						    NULL, false);
> >> +			if (!uarg) {
> >> +				virtio_transport_put_credit(vvs, pkt_len);
> >> +				return -ENOMEM;
> >> +			}
> >> =20
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
> >>  			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> =20
> >> +			if (!can_zcopy)
> >> +				uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> +
> >> +			have_uref =3D true;
> >> +		}
> >> +
> >> +		/* 'can_zcopy' means that this transmission will be
> >> +		 * in zerocopy way (e.g. using 'frags' array).
> >> +		 */ =20
> > I've not looked at the tcp code, but the above doesn't look right.
> > I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY s=
et.
> > That would give the outer code a callback when the last skb is freed but
> > still copy the data. =20
>=20
> Hi,=C2=A0
>=20
> I guess case when 'msg->msg_ubuf' is non-NULL is special case today for i=
o_uring MSG_ZEROCOPY implementation.
> It was added here https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/commit/?id=3Deb315a7d1396b1139fc7daea55f2d3191e8e7092
> As I see implementation of its tests in tools/testing/selftests/net/io_ur=
ing_zerocopy_tx.c , it doesn't require setting SOCK_ZEROCOPY option for
> socket, so for virtio vsock case I just copied same logic to maintain com=
patibility, because there is MSG_ZEROCOPY io_uring test for virtio/vsock.

That code path probably sets info->msg->msg_flags & MSG_ZEROCOPY so wants '=
zerocopy'.
But wants it's own callback function called rather than one that msg_zeroco=
py_realloc()
adds.

But there is no reason why a caller might not just want a notification that
all the skb associated with the sendmsg have been freed without requesting =
zerocopy.
Maybe no one does it today, but it is trivial to support.

>=20
>=20
> >
> > I also don't see the point of calling msg_zerocopy_realloc() to get a
> > callback when the last skb is freed and then setting
> > 	uarg_to_msgzc(uarg)->zerocopy =3D 0;
> > so that the callback doesn't actually do anything.
> > It isn't as though you 'find out' later on that you can't actually do
> > zerocopy. =20
>=20
>=20
> Sorry, what do You mean "last skb" ? In this code we first allocate uarg =
(allocate, because third arg is always NULL). Then in
> loop we allocate sk_buffs, fill it with data and send. I mean first/last =
skb will be freed after uarg is already allocated and we
> don't touch it. I think i didn't understand Your question here.

The 'uarg' is referenced by all of the skb that contain data for the sendms=
g().
So when the last one of them is freed the callback function is called.
The purpose of that callback is to 'undo' the zerocopy (page pinning etc).
But when you set uarg_to_msgzc(uarg)->zerocopy =3D 0 the callback does noth=
ing.
So there is no point setting up the callback at all.

-- David

>=20
>=20
> > =20
> >>  		if (can_zcopy)
> >>  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> >>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> >> -
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> >> -		    info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> >> -			uarg =3D info->msg->msg_ubuf;
> >> -
> >> -			if (!uarg) {
> >> -				uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> >> -							    pkt_len, NULL, false);
> >> -				if (!uarg) {
> >> -					virtio_transport_put_credit(vvs, pkt_len);
> >> -					return -ENOMEM;
> >> -				}
> >> -
> >> -				if (!can_zcopy)
> >> -					uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> -
> >> -				have_uref =3D true;
> >> -			}
> >> -		}
> >>  	}
> >> =20
> >>  	rest_len =3D pkt_len;
> >> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >> =20
> >>  		skb =3D virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> >>  						 src_cid, src_port,
> >> -						 dst_cid, dst_port);
> >> +						 dst_cid, dst_port, uarg);
> >>  		if (!skb) {
> >>  			ret =3D -ENOMEM;
> >>  			break;
> >>  		}
> >> =20
> >> -		skb_zcopy_set(skb, uarg, NULL); =20
> > Aren't you passing uarg through two function calls instead of doing it =
here.
> > Doesn't even make it clearer what is going on. =20
>=20
>=20
> Agree, to simplify patch, uarg could be set earlier (without passing it t=
o functions) I guess.
>=20
> Thanks
>=20
>=20
> >
> > -- David
> > =20
> >> -
> >>  		virtio_transport_inc_tx_pkt(vvs, skb);
> >> =20
> >>  		ret =3D t_ops->send_pkt(skb, info->net);
> >> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const =
struct virtio_transport *t,
> >>  					   le64_to_cpu(hdr->dst_cid),
> >>  					   le32_to_cpu(hdr->dst_port),
> >>  					   le64_to_cpu(hdr->src_cid),
> >> -					   le32_to_cpu(hdr->src_port));
> >> +					   le32_to_cpu(hdr->src_port), NULL);
> >>  	if (!reply)
> >>  		return -ENOMEM;
> >>   =20

