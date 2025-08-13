Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EA21257A
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091575; cv=none; b=ofWMd4n89UtO1920lTNwb+Bf6Y1JD+6FmDK/VB687OuCz3DOk1fNBK6f+77XulLgnMCyDa9vCOZyqpLWeMUUujnPsSNqtV7h1kF+KapFi4U1PP215GqEmD7nFw4PWeS77vD8ch2thWwGLwP4lEhnubvjzrNBF2BhJXSok3nFtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091575; c=relaxed/simple;
	bh=Uq9n0I9N5l8mMnseAxwMTJToi2ytaZfBB0V8c7fEYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbgmuQSUx1VCZD/uYtD2wiXMTijTHm9AXZQ1um55HcjvNj7a/wTZj4/Um27WCNFM1nwGLf+dPzmoK2BXwSva85LZp95OEvD3YXz4alci+8Ip/XuOzD8qYObuvKOyP76V8acRQA6qc8Igj/N5YeQOQEb9Z0rsqSyVlKYVHiBjCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LHu7edKu; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LHu7edKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755091570;
	bh=D2wtmkC5cRwj57r9Km0rnHswAsCqKsDcHe53mfuX6aA=;
	h=From:Subject:Date:Message-ID;
	b=LHu7edKuOMSHs0jF8NB5EfKai3C4BtD6z6/8H1Kl3L0lS55RH5hh9vL7j9miW8muh
	 IYPyBgYnx56I2g6jlx53PZLlNSdZOZOusmuph29V5rwfg+CY/9v+upKa7uOcLf7E1k
	 M/Rim/vE3tTUniGI2FcJM3I4gBlLlHUwWIKVG9z4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689C926B0000478F; Wed, 13 Aug 2025 21:26:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4862744456671
X-SMAIL-UIID: F3A7C21EFC92444F91B50E695AC80BA3-20250813-212606-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Wed, 13 Aug 2025 21:25:53 +0800
Message-ID: <20250813132554.4508-1-hdanton@sina.com>
In-Reply-To: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > transmit data. Unfortunately, these are always linear allocations and
> > can therefore result in significant pressure on kmalloc() considering
> > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > allocation for each packet.
> > 
> > Rework the vsock SKB allocation so that, for sizes with page order
> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > instead with the packet header in the SKB and the transmit data in the
> > fragments. Note that this affects both the vhost and virtio transports.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> So this caused a regression, see syzbot report:
> 
> https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> 
> I'm inclined to revert unless we have a fix quickly.
> 
Because recomputing skb len survived the syzbot test [1], Will looks innocent.

[1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
