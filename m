Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4D166F1A
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798206; cv=none; b=IE2pDGS21RJk6uaB8TPiwYgJcBdes7Pqdzj0JtqHLGDgMQ1l/8UEcms9NDeCKI0unBo3ydxWWMJWoWC0MB7IXSQhqPmyvYMw1LF4Vy8PmhMaWhWBGYUumFKYEBNS5CAuDQw+/YPtbR3hlXATHgpatZanGnej+UKXrHxQrv+9GBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798206; c=relaxed/simple;
	bh=KynK17m8gzCfpiirN3+RmhG9s7QXD8jjm7XlUSRzDBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LhsXvVvJfa0TX1baf3kHLzi4q74JM/OuQKtOVCtwkXBEq0H543EKmVuhmiDGI2LQhkNr8ezcX84w9l3h4QSr37SCB8xVmrgiZZKPH4s5licJcmj+jMC93vlzssT7HydLyIWAshbSvzkKhVG7IE/CzmQRbN3XKE0+7OvVfAgsu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F9C3608B6
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 20:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.591
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F25J7ksZ6Ocf for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 20:23:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.69.203.94; helo=webmail.webked.de; envelope-from=markus.fohrer@webked.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 982FE60BCD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=webked.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 982FE60BCD
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 982FE60BCD
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 20:23:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD1C061A78;
	Fri,  4 Apr 2025 22:23:01 +0200 (CEST)
Message-ID: <62a6bf463858c443f6380bbf7ae5a3cc76b81844.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 04 Apr 2025 22:23:01 +0200
In-Reply-To: <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
	 <20250403090001-mutt-send-email-mst@kernel.org>
	 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
	 <20250404042711-mutt-send-email-mst@kernel.org>
	 <e75cb5881a97485b08cdd76efd8a7d2191ecd106.camel@webked.de>
	 <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
	 <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
Organization: WEBKED IT Markus Fohrer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Am Freitag, dem 04.04.2025 um 11:13 -0400 schrieb Willem de Bruijn:
> Markus Fohrer wrote:
> > Am Freitag, dem 04.04.2025 um 10:52 +0200 schrieb Markus Fohrer:
> > > Am Freitag, dem 04.04.2025 um 04:29 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
> > > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael
> > > > > S.
> > > > > Tsirkin:
> > > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer
> > > > > > wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > I'm observing a significant performance regression in KVM
> > > > > > > guest
> > > > > > > VMs
> > > > > > > using virtio-net with recent Linux kernels (6.8.1+ and
> > > > > > > 6.14).
> > > > > > >=20
> > > > > > > When running on a host system equipped with a Broadcom
> > > > > > > NetXtreme-E
> > > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput
> > > > > > > in
> > > > > > > the
> > > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configura=
tion
> > > > > > > performs
> > > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the
> > > > > > > VM
> > > > > > > is
> > > > > > > moved to a host with Intel NICs.
> > > > > > >=20
> > > > > > > Test environment:
> > > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > > - Guest: Linux with virtio-net interface
> > > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at
> > > > > > > host
> > > > > > > level)
> > > > > > > - CPU: AMD EPYC
> > > > > > > - Storage: virtio-scsi
> > > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > > bottlenecks)
> > > > > > > - Traffic test: iperf3, scp, wget consistently slow in
> > > > > > > guest
> > > > > > >=20
> > > > > > > This issue is not present:
> > > > > > > - On 6.8.0=20
> > > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > >=20
> > > > > > > I have bisected the issue to the following upstream
> > > > > > > commit:
> > > > > > >=20
> > > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning
> > > > > > > for
> > > > > > > small
> > > > > > > tx")
> > > > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > > > >=20
> > > > > > Thanks a lot for the info!
> > > > > >=20
> > > > > >=20
> > > > > > both the link and commit point at:
> > > > > >=20
> > > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > > virtio_net_hdr_to_skb()
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > is this what you mean?
> > > > > >=20
> > > > > > I don't know which commit is "virtio-net: Suppress tx
> > > > > > timeout
> > > > > > warning
> > > > > > for small tx"
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > Reverting this commit restores normal network performance
> > > > > > > in
> > > > > > > affected guest VMs.
> > > > > > >=20
> > > > > > > I=E2=80=99m happy to provide more data or assist with testing=
 a
> > > > > > > potential
> > > > > > > fix.
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Markus Fohrer
> > > > > >=20
> > > > > >=20
> > > > > > Thanks! First I think it's worth checking what is the
> > > > > > setup,
> > > > > > e.g.
> > > > > > which offloads are enabled.
> > > > > > Besides that, I'd start by seeing what's doing on. Assuming
> > > > > > I'm
> > > > > > right
> > > > > > about
> > > > > > Eric's patch:
> > > > > >=20
> > > > > > diff --git a/include/linux/virtio_net.h
> > > > > > b/include/linux/virtio_net.h
> > > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > > --- a/include/linux/virtio_net.h
> > > > > > +++ b/include/linux/virtio_net.h
> > > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > > virtio_net_hdr_to_skb(struct
> > > > > > sk_buff *skb,
> > > > > > =C2=A0
> > > > > > =C2=A0		if (!skb_partial_csum_set(skb, start,
> > > > > > off))
> > > > > > =C2=A0			return -EINVAL;
> > > > > > +		if (skb_transport_offset(skb) <
> > > > > > nh_min_len)
> > > > > > +			return -EINVAL;
> > > > > > =C2=A0
> > > > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > > > skb_transport_offset(skb));
> > > > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > > > =C2=A0			return -EINVAL;
> > > > > >=20
> > > > > >=20
> > > > > > sticking a printk before return -EINVAL to show the offset
> > > > > > and
> > > > > > nh_min_len
> > > > > > would be a good 1st step. Thanks!
> > > > > >=20
> > > > >=20
> > > > > I added the following printk inside virtio_net_hdr_to_skb():
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 if (skb_transport_offset(skb) < nh_min_len){
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO "virt=
io_net: 3 drop,
> > > > > transport_offset=3D%u,
> > > > > nh_min_len=3D%u\n",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 skb_transport_offset(skb), nh_min_len);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > =C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > Built and installed the kernel, then triggered a large
> > > > > download
> > > > > via:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 wget http://speedtest.belwue.net/10G
> > > > >=20
> > > > > Relevant output from `dmesg -w`:
> > > > >=20
> > > > > [=C2=A0=C2=A0 57.327943] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.428942] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.428962] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.553068] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.553088] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.576678] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.618438] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.618453] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.703077] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.823072] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.891982] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 57.946190] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > > > [=C2=A0=C2=A0 58.218686] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > > nh_min_len=3D40=C2=A0=20
> > > >=20
> > > > Hmm indeed. And what about these values?
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u32 start =3D __virtio16_to_cpu(little_endian,
> > > > hdr-
> > > > > csum_start);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u32 off =3D __virtio16_to_cpu(little_endian, hdr-
> > > > > csum_offset);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u32 needed =3D start + max_t(u32, thlen, off +
> > > > sizeof(__sum16));
> > > > print them too?
> > > >=20
> > > >=20
> > > >=20
> > > > > I would now do the test with commit
> > > > > 49d14b54a527289d09a9480f214b8c586322310a and commit
> > > > > 49d14b54a527289d09a9480f214b8c586322310a~1
> > > > >=20
> > > >=20
> > > > Worth checking though it seems likely now the hypervisor is
> > > > doing
> > > > weird
> > > > things. what kind of backend is it? qemu? tun? vhost-user?
> > > > vhost-
> > > > net?
> > > >=20
> > >=20
> > > Backend: QEMU/KVM hypervisor (Proxmox)
> > >=20
> > >=20
> > > printk output:
> > >=20
> > > [=C2=A0=C2=A0 58.641906] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > off=3D16,
> > > needed=3D54, nh_min_len=3D40
> > > [=C2=A0=C2=A0 58.678048] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > off=3D16,
> > > needed=3D54, nh_min_len=3D40
> > > [=C2=A0=C2=A0 58.952871] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > off=3D16,
> > > needed=3D54, nh_min_len=3D40
> > > [=C2=A0=C2=A0 58.962157] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > off=3D16,
> > > needed=3D54, nh_min_len=3D40
> > > [=C2=A0=C2=A0 59.071645] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > off=3D16,
> > > needed=3D54, nh_min_len=3D40
>=20
> So likely a TCP/IPv4 packet, but with VIRTIO_NET_HDR_GSO_TCPV6.
>=20
> This is observed in the guest on the ingress path, right? In
> virtnet_receive_done.

Yes, all tests are done inside the guest system. Packet drops are seen
when receiving traffic.

I hadn't tested upload before, so I did now:

- Download is slow (<200 KB/s)
- Upload works fine (~190 MB/s)

>=20
> Is this using vhost-net in the host for pass-through? IOW, is
> the host writing the virtio_net_hdr too?

Yes, the guest runs on a Proxmox host using QEMU/KVM with vhost-net.

vhost_net module is loaded:

  # lsmod | grep vhost
  vhost_net              32768  30
  vhost                  61440  1 vhost_net
  vhost_iotlb            16384  1 vhost
  tap                    28672  1 vhost_net

QEMU is launched with:

  -netdev type=3Dtap,...,vhost=3Don
  -device virtio-net-pci,...

>=20
> > >=20
> > >=20
> > >=20
> > >=20
> >=20
> > I just noticed that commit 17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8
> > (tcp_offload.c: gso fix) also touches checksum handling and may
> > affect how skb state is passed to virtio_net_hdr_to_skb().
> >=20
> > Is it possible that the regression only appears due to the
> > combination
> > of 17bd3bd8 and 49d14b54a5?
>=20
> That patch only affects packets with SKB_GSO_FRAGLIST. Which is only
> set on forwarding if NETIF_F_FRAGLIST is set. I don=20

Checked in the guest:

  # ethtool -k eth0 | grep frag
    tx-scatter-gather-fraglist: off [fixed]

So fraglist offload is disabled in the guest.
