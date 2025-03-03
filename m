Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D01198A2F
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041247; cv=none; b=jMjP00bQEUA3k3MqYo+jK2rFYlYBxybSm65WAcq17g/5wVKIv4gf89p78WIo2PC5FYakj97vyxwQb/j9yUMPLA34Z7sGFzqsVO7JpxZU75sT4Jyaffn10884GBRN/Nzoy6Mei43tSnXqGe6IehkHPAK66EKZfKBRIx54rVBUhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041247; c=relaxed/simple;
	bh=mXqIacAC3RLc1tYiomnB+ph7/jwRad1h/08sQbaQrKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEK0sxIH2tz+dokX542U8sbXYu49DEvtNvdosyxa9H/xRUVUCvmJYaxoahDWTnD4sgQjkkOxBOQMUPCiVoQotKd8m4xFXxrkXKNra6xVmTALg70Lhm4u30WPPDNIhQ6XE8DQ+/rf8m8TLwxe98W1MU+b17Xj1kUG+Fjyh4VayIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzCGyc0A; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzCGyc0A"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A11C40611
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 22:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -10.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufRNuI8Aw3Yo for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 22:34:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 02C31405DC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02C31405DC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nzCGyc0A
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 02C31405DC
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 22:34:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 12DB65C2EDD;
	Mon,  3 Mar 2025 22:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E9C4CED6;
	Mon,  3 Mar 2025 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041234;
	bh=mXqIacAC3RLc1tYiomnB+ph7/jwRad1h/08sQbaQrKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzCGyc0ACZ4YdrUHbJuOX/zRI9wJJHe9tJrLmln3cGv7f5a4ExHBkfa6nyB0NA4/T
	 05CadXsIjbbLOjIDu7qJIfi+7SlFPB7Dvyf0gTAYG7NMTPzooHI6WQKaQJeOAtSWVQ
	 7xckCLhk5n7rPFK/iz1cQ640OhIOfPjdnP85lVp986kRIK6Osx36Oi/l+P2skCcrvQ
	 iUqTWLdMcwbuBy4H7/YsekYHSoIV4TBphHWU2yHOKUHlI5c952/hZwAWE0KFEfBloj
	 iiDAljQ5a/aM4CFvHvANKyLa+vibaunMplD1jcsef+oMYzGkf0nGd8w3Vemt8xIdmf
	 tzzvYxHgeg5Zw==
Date: Mon, 3 Mar 2025 14:33:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>,
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v7 5/6] selftest: tun: Add tests for virtio-net
 hashing
Message-ID: <20250303143353.42219664@kernel.org>
In-Reply-To: <0ec77558-bdfb-4471-a44b-0a37a9422f72@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
	<20250228-rss-v7-5-844205cbbdd6@daynix.com>
	<20250228062947.7864a59c@kernel.org>
	<0ec77558-bdfb-4471-a44b-0a37a9422f72@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 15:20:33 +0900 Akihiko Odaki wrote:
> > # 5.90 [+0.00] ok 14 tun_vnet_hash.unclassified
> > # 5.90 [+0.00] #  RUN           tun_vnet_hash.ipv4 ...
> > # 6.18 [+0.28] # tun.c:669:ipv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), 0, VIRTIO_NET_HASH_REPORT_IPv4, 0x6e45d952) (0)
> > # 15.09 [+8.92] # ipv4: Test failed
> > # 15.10 [+0.00] #          FAIL  tun_vnet_hash.ipv4
> > # 15.10 [+0.00] not ok 15 tun_vnet_hash.ipv4
> > # 15.10 [+0.00] #  RUN           tun_vnet_hash.tcpv4 ...
> > # 15.36 [+0.26] # tun.c:689:tcpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_TCPv4, 0xfb63539a) (0)
> > # 24.76 [+9.40] # tcpv4: Test failed
> > # 24.76 [+0.00] #          FAIL  tun_vnet_hash.tcpv4
> > # 24.76 [+0.00] not ok 16 tun_vnet_hash.tcpv4
> > # 24.77 [+0.00] #  RUN           tun_vnet_hash.udpv4 ...
> > # 25.05 [+0.28] # tun.c:710:udpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_UDPv4, 0xfb63539a) (0)
> > # 32.11 [+7.06] # udpv4: Test failed
> > # 32.11 [+0.00] #          FAIL  tun_vnet_hash.udpv4
> > # 32.11 [+0.00] not ok 17 tun_vnet_hash.udpv4  
> 
> I cannot reproduce the failure. What commit did you apply this patch 
> series on? What architecture did the kernel run on?

x86 inside vng, see this for exact details:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

The tests are run on top of net-next + net (the two networking trees
merged together).
