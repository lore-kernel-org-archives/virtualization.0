Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291061EFF9D
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779637; cv=none; b=jd8+WyiFi8/JDTcRCSl/+WHD+KtD9i8O8emN8CN84nVwUE3BAWepuQzme6srl7zhM5f9s/HxELTVlT89P4TcDcKVc3L88y14I4Ifh/95DV53A+09VeGLjke6I6WaEMy1gbo+1C9mmiYrPDt6R95/GD7aMgoLSgOEJwrs44MoTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779637; c=relaxed/simple;
	bh=WQbI3dyKllE7gweQpwKdM6+FVHrPveHLAJaHhBAMGzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nCXwe3PjI3k03rDxQ7CGgdzwGuRlbEdeuq/+3ayef2sUMIzhpdGKvMle0uucUezFuSbiQLFs2d9S+BqSBEwn7K9f40abjHEVrN2yEGwZxURobtlX1KW3Uzo6ewmvZaquzvAzU11PGjMRcuuOuJXFVj57V9/RHATFpYbqxVKP8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpQ7Qp0E; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpQ7Qp0E"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93178411C6
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 15:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvFw4rUwZ51R for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 15:13:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7EED7410B4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EED7410B4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GpQ7Qp0E
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7EED7410B4
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 15:13:54 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7be49f6b331so208293585a.1
        for <virtualization@lists.linux-foundation.org>; Fri, 04 Apr 2025 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743779633; x=1744384433; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/gFZeVnc+kSH/zqiFoTPbQDrc4DhywqySchfhRCUGg=;
        b=GpQ7Qp0EsJ7zefaBFfIPTGZKbgll09pOUuWBOO8JBF04SvzZIEyQM7FULHI5GFui4R
         gzuFsx6f6zRr1Vv4bjoYN2eDXNQC+5QUt1V2W6vdxB4o9og0vRd5EXiwvIHq/MwFFcWL
         9gwq0YpqJRjbX1N/nhofv0V1T/7CCyjFFHAluw8tsPesqWLdgP5Z77K2cKhXp93NtA/h
         YObzobs5EqsjbE6+YdgYl+Hq+xSIJkNeC7dyrrkQJeqh51C63aHopswxUK1uaMm/0yOd
         oBVrDH9TRj4eQnThgyAeBe3lsF8YpwnvO/n+cn53DMi4Y0rfDEHoegPZwnD/8G0GBFkT
         G9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779633; x=1744384433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/gFZeVnc+kSH/zqiFoTPbQDrc4DhywqySchfhRCUGg=;
        b=OgP/LTr9ZcP8zFkFStWL9hooylSixJmiA3IOP9m4It53x1FVXVbls7bA6HyxSZeMd1
         xs7qOK2F5qznl+LZ1KxR8PzQXQBmaPrcj4OgKavL0Nt9Y8HJBRbfxInztrsOh2KUT/ql
         DTyDvSNSSSHPDKIahsSBGIlxO2KW1zuefsyjtkHuJvsT5ZsrXdMV95/LnolJFzSAmTcM
         eOT0LZ/Rgsv0qTsr5fb1br3deknf8n3ll1Uf5UMyo4TM3D21RZOgLCy8E0//mG6+vKan
         BfupUph+tYdOfFQIG6ph6+Xw9IZ1O/oN0ZVIjhojwxmi9CpgO8D+hMKOx7MB83d8QSxd
         nLQg==
X-Gm-Message-State: AOJu0YynqQdK8POS6s7i75cmhrD8K1ICgPtD9QYotrU3STGx3hgCqkxD
	ZRg8fdANnE77ZPkRaacHpaNGGdyfpyVzDoPiy/Tih6O+9UvTPi1R
X-Gm-Gg: ASbGncsKhI3u5HVdRQ8b55J08l/v33EbWe2KBEEbXIMJYd3CNXnULwijRLlbwVkVq2C
	vWY/Zt56MI1LMF2KgXwcSumZ3ccvlRXEfCNJMISRTKkU+U262IDfFyle5iZqfGJ9VqTcXFcYKQG
	71WFNfh36C4BFGHuO8/sjQq+3wPyAi+rVmNi9NzeNtgU0/SDMLkkxUe7Jyc0UxlblQ9xFlGwIBu
	hdCkAlpxPWGUfUurlAL8NPuYgbRqq5k/+EidTqfq3J9rgFU9j5v7IFnaPGA7zZMePA0PDBw+SLJ
	/+CTRFkK6Tnjus76Shlvd8kGYwV/assk8Ni1jVRkjtIW1E//wzTLjgSdrdi9xf6QPtLFSLvmuBc
	x45LATBHCIkUAnNJZp2So/g==
X-Google-Smtp-Source: AGHT+IFJi2tzpNLKZWpEPzGAGH5aga7+T+NCkeMlRPFClkmPT1RGO2gImTS1cr49l3Tpn3kkj8Il4Q==
X-Received: by 2002:a05:620a:4449:b0:7c5:f6be:bdae with SMTP id af79cd13be357-7c774d205eamr466302885a.20.1743779633097;
        Fri, 04 Apr 2025 08:13:53 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96e566sm228375685a.63.2025.04.04.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 08:13:52 -0700 (PDT)
Date: Fri, 04 Apr 2025 11:13:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Fohrer <markus.fohrer@webked.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
In-Reply-To: <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
 <20250404042711-mutt-send-email-mst@kernel.org>
 <e75cb5881a97485b08cdd76efd8a7d2191ecd106.camel@webked.de>
 <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Fohrer wrote:
> Am Freitag, dem 04.04.2025 um 10:52 +0200 schrieb Markus Fohrer:
> > Am Freitag, dem 04.04.2025 um 04:29 -0400 schrieb Michael S. Tsirkin:=

> > > On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
> > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > > Tsirkin:
> > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > > > Hi,
> > > > > > =

> > > > > > I'm observing a significant performance regression in KVM
> > > > > > guest
> > > > > > VMs
> > > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).=

> > > > > > =

> > > > > > When running on a host system equipped with a Broadcom
> > > > > > NetXtreme-E
> > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > the
> > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configura=
tion
> > > > > > performs
> > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > > is
> > > > > > moved to a host with Intel NICs.
> > > > > > =

> > > > > > Test environment:
> > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > - Guest: Linux with virtio-net interface
> > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > > level)
> > > > > > - CPU: AMD EPYC
> > > > > > - Storage: virtio-scsi
> > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > bottlenecks)
> > > > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > > > =

> > > > > > This issue is not present:
> > > > > > - On 6.8.0 =

> > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > =

> > > > > > I have bisected the issue to the following upstream commit:
> > > > > > =

> > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning=
 for
> > > > > > small
> > > > > > tx")
> > > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > > > =

> > > > > Thanks a lot for the info!
> > > > > =

> > > > > =

> > > > > both the link and commit point at:
> > > > > =

> > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > =

> > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > virtio_net_hdr_to_skb()
> > > > > =C2=A0=C2=A0=C2=A0 =

> > > > > =

> > > > > is this what you mean?
> > > > > =

> > > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > > warning
> > > > > for small tx"
> > > > > =

> > > > > =

> > > > > =

> > > > > > Reverting this commit restores normal network performance in
> > > > > > affected guest VMs.
> > > > > > =

> > > > > > I=E2=80=99m happy to provide more data or assist with testing=
 a
> > > > > > potential
> > > > > > fix.
> > > > > > =

> > > > > > Thanks,
> > > > > > Markus Fohrer
> > > > > =

> > > > > =

> > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > e.g.
> > > > > which offloads are enabled.
> > > > > Besides that, I'd start by seeing what's doing on. Assuming I'm=

> > > > > right
> > > > > about
> > > > > Eric's patch:
> > > > > =

> > > > > diff --git a/include/linux/virtio_net.h
> > > > > b/include/linux/virtio_net.h
> > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > virtio_net_hdr_to_skb(struct
> > > > > sk_buff *skb,
> > > > > =C2=A0
> > > > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > > > =C2=A0			return -EINVAL;
> > > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > > +			return -EINVAL;
> > > > > =C2=A0
> > > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > > skb_transport_offset(skb));
> > > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > > =C2=A0			return -EINVAL;
> > > > > =

> > > > > =

> > > > > sticking a printk before return -EINVAL to show the offset and
> > > > > nh_min_len
> > > > > would be a good 1st step. Thanks!
> > > > > =

> > > > =

> > > > I added the following printk inside virtio_net_hdr_to_skb():
> > > > =

> > > > =C2=A0=C2=A0=C2=A0 if (skb_transport_offset(skb) < nh_min_len){
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO "virt=
io_net: 3 drop,
> > > > transport_offset=3D%u,
> > > > nh_min_len=3D%u\n",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 skb_transport_offset(skb), nh_min_len);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > =C2=A0=C2=A0=C2=A0 }
> > > > =

> > > > Built and installed the kernel, then triggered a large download
> > > > via:
> > > > =

> > > > =C2=A0=C2=A0=C2=A0 wget http://speedtest.belwue.net/10G
> > > > =

> > > > Relevant output from `dmesg -w`:
> > > > =

> > > > [=C2=A0=C2=A0 57.327943] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.428942] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.428962] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.553068] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.553088] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.576678] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.618438] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.618453] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.703077] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.823072] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.891982] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.946190] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 58.218686] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > =

> > > Hmm indeed. And what about these values?
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 start =3D __virtio16_to_cpu(little_endian, hdr-=

> > > > csum_start);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 off =3D __virtio16_to_cpu(little_endian, hdr-
> > > > csum_offset);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 needed =3D start + max_t(u32, thlen, off +
> > > sizeof(__sum16));
> > > print them too?
> > > =

> > > =

> > > =

> > > > I would now do the test with commit
> > > > 49d14b54a527289d09a9480f214b8c586322310a and commit
> > > > 49d14b54a527289d09a9480f214b8c586322310a~1
> > > > =

> > > =

> > > Worth checking though it seems likely now the hypervisor is doing
> > > weird
> > > things. what kind of backend is it? qemu? tun? vhost-user? vhost-
> > > net?
> > > =

> > =

> > Backend: QEMU/KVM hypervisor (Proxmox)
> > =

> > =

> > printk output:
> > =

> > [=C2=A0=C2=A0 58.641906] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.678048] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.952871] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.962157] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 59.071645] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40

So likely a TCP/IPv4 packet, but with VIRTIO_NET_HDR_GSO_TCPV6.

This is observed in the guest on the ingress path, right? In
virtnet_receive_done.

Is this using vhost-net in the host for pass-through? IOW, is
the host writing the virtio_net_hdr too?

> > =

> > =

> > =

> > =

> =

> I just noticed that commit 17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8
> (tcp_offload.c: gso fix) also touches checksum handling and may
> affect how skb state is passed to virtio_net_hdr_to_skb().
> =

> Is it possible that the regression only appears due to the combination
> of 17bd3bd8 and 49d14b54a5?

That patch only affects packets with SKB_GSO_FRAGLIST. Which is only
set on forwarding if NETIF_F_FRAGLIST is set. I don =

