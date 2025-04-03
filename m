Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3E1FECC2
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712519; cv=none; b=r92YZnZGYVL7nUWUIMiBt0rBXDAADBfaUA5/e0hp/sYn5KA3jnLFmTolJcRnY9lZAeRzZC5Dk9RR7t9q+9N3VUbzctdJ5/ZhnpCjWV+H4qX49hZuMDkUyAuKfATo8nTjyMiYolrXoYVPY5FaBy5LvqJOe86qDA8ygrk0rVMCnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712519; c=relaxed/simple;
	bh=6vNUGhiNPVvK0fjXn2B0OinFpjaznSGI+S3gqkfojt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1VGVUmwclaUM5GUkurpV1DYPSiOY4pXdgJH2eDr2Fg0i1P5oAJ7DTY6yg6VPf8FYEf8rwy+2KsUrcEE4OOIzbrVG1lb40uj/Eqj/S80VWXVsS+Wwm2iUukDUtaYayF2a8xXL7kp/lUJPEPAPm/Qh3hGjTNCOW7opTc7vhJPdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E69181281
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 20:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.591
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LOk7FLnuLhU for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 20:35:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.69.203.94; helo=webmail.webked.de; envelope-from=markus.fohrer@webked.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 57466811E4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=webked.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57466811E4
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57466811E4
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 20:35:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C45226200E;
	Thu,  3 Apr 2025 22:35:05 +0200 (CEST)
Message-ID: <f20968b4fd5c5f4e124021c86eba17d89b93afff.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 22:35:05 +0200
In-Reply-To: <67ee9ab0a1665_136b7c29412@willemb.c.googlers.com.notmuch>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
	 <20250403090001-mutt-send-email-mst@kernel.org>
	 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
	 <20250403100206-mutt-send-email-mst@kernel.org>
	 <67ee9ab0a1665_136b7c29412@willemb.c.googlers.com.notmuch>
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

Am Donnerstag, dem 03.04.2025 um 10:26 -0400 schrieb Willem de Bruijn:
> Michael S. Tsirkin wrote:
> > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > > Hi,
> > > > >=20
> > > > > I'm observing a significant performance regression in KVM
> > > > > guest VMs
> > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> > > > >=20
> > > > > When running on a host system equipped with a Broadcom
> > > > > NetXtreme-E
> > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > the
> > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configuration
> > > > > performs
> > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > is
> > > > > moved to a host with Intel NICs.
> > > > >=20
> > > > > Test environment:
> > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > - Guest: Linux with virtio-net interface
> > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > level)
> > > > > - CPU: AMD EPYC
> > > > > - Storage: virtio-scsi
> > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > bottlenecks)
> > > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > >=20
> > > > > This issue is not present:
> > > > > - On 6.8.0=20
> > > > > - On hosts with Intel NICs (same VM config)
> > > > >=20
> > > > > I have bisected the issue to the following upstream commit:
> > > > >=20
> > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning for
> > > > > small
> > > > > tx")
> > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > >=20
> > > > Thanks a lot for the info!
> > > >=20
> > > >=20
> > > > both the link and commit point at:
> > > >=20
> > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > virtio_net_hdr_to_skb()
> > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > is this what you mean?
> > > >=20
> > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > warning
> > > > for small tx"
> > > >=20
> > > >=20
> > > >=20
> > > > > Reverting this commit restores normal network performance in
> > > > > affected guest VMs.
> > > > >=20
> > > > > I=E2=80=99m happy to provide more data or assist with testing a
> > > > > potential
> > > > > fix.
> > > > >=20
> > > > > Thanks,
> > > > > Markus Fohrer
> > > >=20
> > > >=20
> > > > Thanks! First I think it's worth checking what is the setup,
> > > > e.g.
> > > > which offloads are enabled.
> > > > Besides that, I'd start by seeing what's doing on. Assuming I'm
> > > > right
> > > > about
> > > > Eric's patch:
> > > >=20
> > > > diff --git a/include/linux/virtio_net.h
> > > > b/include/linux/virtio_net.h
> > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -103,8 +103,10 @@ static inline int
> > > > virtio_net_hdr_to_skb(struct
> > > > sk_buff *skb,
> > > > =C2=A0
> > > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > > =C2=A0			return -EINVAL;
> > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > +			return -EINVAL;
> > > > =C2=A0
> > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > skb_transport_offset(skb));
> > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > =C2=A0			return -EINVAL;
> > > >=20
> > > >=20
> > > > sticking a printk before return -EINVAL to show the offset and
> > > > nh_min_len
> > > > would be a good 1st step. Thanks!
> > > >=20
> > >=20
> > >=20
> > > Hi Eric,
> > >=20
> > > thanks a lot for the quick response =E2=80=94 and yes, you're absolut=
ely
> > > right.
> > >=20
> > > Apologies for the confusion: I mistakenly wrote the wrong commit
> > > description in my initial mail.
> > >=20
> > > The correct commit is indeed:
> > >=20
> > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > >=20
> > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > virtio_net_hdr_to_skb()
> > >=20
> > > This is the one I bisected and which causes the performance
> > > regression
> > > in my environment.
>=20
> This commit is introduced in v6.12.
>=20
> You say 6.8 is good, but 6.8.1 is bad. This commit is not in 6.8.1.
> Nor any virtio-net related change:
>=20
> $ git log --oneline linux/v6.8..linux/v6.8.1 --
> include/linux/virtio_net.h drivers/net/virtio_net.c | wc -l
> 0
>=20
> Is it perhaps a 6.8.1 derived distro kernel?
>=20
> That patch detects silly packets created by a fuzzer. It should not
> affect sane traffic. Not saying your analysis is wrong. We just need
> more data to understand the regression better.


To clarify: my earlier tests were based on Ubuntu-patched kernels
(e.g., 6.8.0-31 to 6.8.0-53).

I've now repeated the tests using clean mainline kernels from
kernel.org.

Download speed was measured using:
  wget -O /dev/null http://speedtest.belwue.net/10G

Results:
- Kernel 6.11: ~85 MB/s
- Kernel 6.12 and 6.14: < 200 KB/s

This confirms that the regression was introduced between v6.11 and
v6.12 in upstream.


