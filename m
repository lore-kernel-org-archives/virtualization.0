Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.249.96.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692261;
	b=wLMw0rzLYYl/k2MiyuIj7NkmkLgGOoVTL4rleSpzagkoyfghEwBspCe/IQDmpXpszw17
	 LDG4fHlQBF+K/Tubmh2JgBa3+DORChTzymcWJfbThbVH5GYgSMFhw3qRrlE3K6wy6qC6v
	 77u+etHXRRxOGTosI2pz7RnYdHBOR8cvC2+8CLhQ3rrH5gtS0Hfq+DhpJU8+xdBifVpQ4
	 rygvBgQClmZ4EgvkS7OyU3GTOx99sQpq75ITXhrgsAtNfkKsN39nDmPbaahyhQJpnlW9/
	 9n919t6DnFLyUVm+nm1Jc1RiMZYU4NFRwnU5swCvNPb6/97+/3xMEOTRVU/episc8Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692261;
	h=DMARC-Filter:Received:X-Original-SENDERIP:X-Original-SENDERCOUNTRY:
	 X-Original-MAILFROM:X-Original-RCPTTO:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4cLpyVLT81vsGe/MWRB0WeCLSq1KPhypEfIga7yF/Ro=;
	b=fmKUxdOiqh1UXKYBQ44r4Hp8UidyABWf/GI0dGeaCXnmmL2DuXIOu23sb5BZlL+9Cpxc
	 3AET5S4KbHCt6AUvwJLtOXRxCLLQlhHxeh04Y/lYG//WtaDQREMvNQ9k7MDyQppncNb0/
	 +wNF5iuB0G91VimXZM2LWcvXvdkWrGyej42B+ZyxLNejoFtMRqM72rDQ4+zEGK2oRG0C9
	 cHtALVDzCxyilpowwrlMuf5S465g+htxuOL+movJgtp4D2lp5iC6PjSyNxOHfMi7uCdVz
	 eORJfwTv0GBDhJsZc7xlf5Vd11yfErzO0c5TenPnU5AqlHUclerNDBmMdRDvZ1UvOBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uos.ac.kr;
	spf=pass smtp.mailfrom=uos.ac.kr;
	arc=none smtp.remote-ip=203.249.96.39
Received: from sniper.uos.ac.kr (sniper2.uos.ac.kr [203.249.96.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62260A2601
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 11:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF62260A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uos.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uos.ac.kr
Received: from unknown (HELO localhost.taild276f1.ts.net) (love09010224@uos.ac.kr@1.229.202.195)
	by 203.249.96.39 with ESMTP; 26 Nov 2026 20:24:16 +0900
X-Original-SENDERIP: 1.229.202.195
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: love09010224@uos.ac.kr
X-Original-RCPTTO: eperezma@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	security@kernel.org
From: Seojin An <love09010224@uos.ac.kr>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	security@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Date: Thu, 26 Nov 2026 20:24:10 +0900
Message-ID: <20261126112410.3485471-1-love09010224@uos.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
References: <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. Before I post v2, I want to confirm how broadly the core should
enforce this.

One option is a common check that rejects total_sg greater than Queue Size
for both split and packed queues. That would catch cases where a driver misses
the check, but it may also reject requests that existing drivers issue today.

The other option is the narrower split representation guard from my v1. My
original check used total_sg > 65536, but it needs to reject exactly 65536 as
well. At that count the split cleanup cursor wraps to zero, so a failure while
mapping the indirect table leaves the data SG mappings behind. Packed
indirect tables do not use that cursor.

If you have a different core-side approach in mind, please let me know.

The current virtio-gpu v2 draft enforces Queue Size in the driver
independently. For the core, would you prefer the common split-and-packed
Queue-Size check, the narrow split guard, or no core change for now? Once
that is clear, I will post the corresponding core v2.
