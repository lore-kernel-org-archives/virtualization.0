Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DE21ABAA
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259692; cv=none; b=DlNwjW4rJ1aXTq7KuLKELIUd2BuZab0hoIFLJh4jaV4zfounS/cwN+ZBM4vgo8ylJUU5QRLgJsAurtBDLGVE+D/a9peT9emtyaKYkDFfoENAyRzx+AAOAbGRwRQhQejWP9ljog/EUfSrY/pdJxytfq7VXDm4V5qfqDK3iVLYeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259692; c=relaxed/simple;
	bh=kmOx6KNrW9R2ODoH8ZfThQ3AFAnXjdWrstnCoX4e6s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHEePxLyJns1dPE7pptdt4930s0JkY2LHVYY8sARt42p3fgGeKA1inJA1YI9Uk72o7IxPADPmcjOzTp9GpLeYE3Av41QztP/Pwwy/dhras8/vGhaeVyeruAolqpE+/p6z3W5GlfE5guH4IbIUF+wb08n0LOGxMonf5AH0voKlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=W5LBk3ws; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="W5LBk3ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755259687;
	bh=94wBHy/NdizbVtKXVXboJCBrkTObdo7WSc8rNvbMJhI=;
	h=From:Subject:Date:Message-ID;
	b=W5LBk3ws4RD4VIXuRt4vDX2TNFz79zO0ugg/BfoYUFL/u5T3XxAMSW8Tky8pJ8Any
	 9eZxcBymJ7BcttvoND3D/onRFTRjXKIIdw3KI0InfURqL5Uo2mvX3bOq9LcsZDCwVV
	 FrG76WRkiMqyMHdgolxXXK7DOeLZIAfyaMNgZNe4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689F231B0000553B; Fri, 15 Aug 2025 20:07:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5596864456636
X-SMAIL-UIID: 3A54955BD27249B2992BABC3730E264C-20250815-200757-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Fri, 15 Aug 2025 20:07:46 +0800
Message-ID: <20250815120747.4634-1-hdanton@sina.com>
In-Reply-To: <20250815062222-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-10-will@kernel.org> <20250813132554.4508-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 06:22:56 -0400 "Michael S. Tsirkin" wrote:
> On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> > On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > > transmit data. Unfortunately, these are always linear allocations and
> > > > can therefore result in significant pressure on kmalloc() considering
> > > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > > allocation for each packet.
> > > > 
> > > > Rework the vsock SKB allocation so that, for sizes with page order
> > > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > > instead with the packet header in the SKB and the transmit data in the
> > > > fragments. Note that this affects both the vhost and virtio transports.
> > > > 
> > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > 
> > > So this caused a regression, see syzbot report:
> > > 
> > > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > > 
> > > I'm inclined to revert unless we have a fix quickly.
> > > 
> > Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> > 
> > [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
> 
> I'm not sure I follow that patch though. Do you mind submitting
> with an explanation in the commit log?
> 
It is a simple debug patch to test if Will's work is good at least in the
syzbot scenario, but stil a couple miles away from a patch with the SOB tag.
