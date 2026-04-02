Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CD37C90B
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123647; cv=none; b=DDlXC9wpp605d95SppTZQtvpoKBKjnrUoMDRPdLbDLAouFQM1EI8W5mShdHu6v8P2PIZSeakfjRQJZzv9em1WeEwdcQCz9803+FDTh30ck1ctxKOWAj3nOC5QZ+8aDH3Us5+mZws4Fll0CSB7Z2MKNQy+oexn8QjPP+TIuEm0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123647; c=relaxed/simple;
	bh=kzXmK1LyQ7Pxz5auKaOrqKn1PR5xdPEBrfI8KMqG3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V+Jy2cGCBVcYV3CdYeI/cZMmOce6vlI5StR7ytMwtGC+W+mVBmg4HDu7j/G1NCSlZm4nwzgvEJhUTQsuW+SuSY6BEYsaEjtCLjJYrqbq6xwQOxQylAoNPetFQqZJtJNHWhB36yZbf6bE+FzgWuZ75lL+1Ur7uGG61sbTmiygJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk7FJis3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk7FJis3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9brIZXgm8f6iWI3LrJCz8H9WO/3Jzr4RfpoeDF6A6xA=;
	b=Sk7FJis3V8qBj/shZuktn53Wrh66BQG8T1Vuaar42nOjE/isXFT3d7hqUyKfaRnezwmfak
	stOYWrRgCf8rIe9tsRrSrAdx1GfXQ8kQULB8bAON02AsgdLA5451uZ9MzppA75RRYBceLS
	fzZFW5nPOrIG0GfrWjDhVUzC3HYbkT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-nA02HtsfNgGi5DLrr0WqJg-1; Thu, 02 Apr 2026 05:54:02 -0400
X-MC-Unique: nA02HtsfNgGi5DLrr0WqJg-1
X-Mimecast-MFC-AGG-ID: nA02HtsfNgGi5DLrr0WqJg_1775123641
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d14a4bcd0so636793f8f.3
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 02:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123641; x=1775728441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9brIZXgm8f6iWI3LrJCz8H9WO/3Jzr4RfpoeDF6A6xA=;
        b=hDqESqnjui0zGxgd4lN/C0Kq4Ogkd7dj0qqWlN2D4Q1KjVHSrSs1CbBfzNoV3Ur9n0
         YNFb0KAmw9qfnaaAsBZdUmbyyvHLSW8iIjVo29b8bzK/Y5U4PDxxVnk8vOQJ9pTFY/gK
         osS+/QcAWRtixshiMn2eQ+wsQEh7GvYxpZ+NaQ2eB1Mdlbxs+tALZ07ItSOlGa41P+XZ
         +lM/ndEYwgLe52PPH5Hap/2uMs5emIU8E+NV1xfY4VZuI5l1gtr0JDeUwibmu1flnoml
         UP6/pjjeQJ4Ca4Bt6wQpxN10DbmZKU8t3ZZz/ou8eD+K/cQu4iU4fnNK4hbuSrkLTwFL
         kYvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7FEXpmFLTRPhSYxl5ytwNsvbHwt5x985zjUirAQLTo30jaZWz5dozqgnyInlJXSaNqg8jnaiM1svwrQ69tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu7TwmGUMvs/G5+RdRU6Xiwi5i0ryHDLj9/1t8Q4CaZRy3lhkV
	vZZ+erKrgPs05cptyaBS0B86dp4FkUkHOEEqSpxokzpMwwSymy8p05TEgIfrNdI0bp+mETmae1O
	/N2Dvw0lBHBmbGt2t60rPyJv/XLVL0GI9l5xVIlrbKVk1sGCGtAkQwrcafuHbfEkxjdgi
X-Gm-Gg: ATEYQzzFjMiAC6rDRIjDYTQ/m/EkuEhV7SmDgEmTGhxap/wjFGoqZCsY4+jPGHA6hi8
	RR70EAhpcJfSKh3n6H3/RJzAZSZWWLDnhnx4zFjeEy1D35a5wPz0i8pkkqyhlaQwZKO23QlepPA
	IJunyrV5kk0OTdKUf/9TjQGO9URNFuZ+HcfXBeB9hHj85hFk47zTK5LeJRO5j9h27XzjelGBhvy
	eOtFxiTw+ko5IPWJZNgoZt03nrZyBsPhL9ryMLNqp/bL5ZmUQ/iIkl45/CXh+npcdSAg6Dz5Ia0
	VZSiXRVfdutyx2DgfK5TCtR1UnvbgUNWyefga++vI3zFEZw8wlbVTA4bVP4aDFwbzeKVCtcXSJR
	nAN9Licg+jR2ZPlW+ZuwKgtWdAuwT7GRSPTo9H8FuG+jMdng=
X-Received: by 2002:a05:6000:2c07:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1f277a14mr4541952f8f.51.1775123640946;
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2c07:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1f277a14mr4541899f8f.51.1775123640463;
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
Received: from fedora (185-219-167-200-static.vivo.cz. [185.219.167.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm6673371f8f.3.2026.04.02.02.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: mvaralar@redhat.com,
	virtualization@lists.linux.dev,
	linux-can@vger.kernel.org
Cc: dbassey@redhat.com,
	harald.mommer@oss.qualcomm.com,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com,
	sgarzare@redhat.com,
	francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Date: Thu,  2 Apr 2026 11:52:43 +0200
Message-ID: <20260402095243.647258-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <acLNB9PYmJ9L0Wvc@fedora>
References: <acLNB9PYmJ9L0Wvc@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Hds_14SD-yIKpRXK5u0BHmyB94aVV3IgPLF87WKHQ8_1775123641
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi Matias,

I've been testing PATCH v13 of the virtio CAN driver and encountered a
FORTIFY_SOURCE panic when transmitting frames:

	sh-5.3# cansend can0 123#DEADBEEF                                                                                     
	[   51.700501] Kernel BUG at __fortify_panic+0x9/0xb [verbose debug info unavailable]                                 
	[   51.700798] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                                                      
	[   51.700881] CPU: 2 UID: 0 PID: 374 Comm: cansend Tainted: G        W          6.12.76 #1                           
	[   51.701070] Tainted: [W]=WARN                                                                                      
	[   51.701143] RIP: 0010:__fortify_panic+0x9/0xb                                                                      
	[   51.701212] Code: 01 00 00 e9 58 7e c2 ff cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90  
	90 40 0f b6 ff e8 57 a9 c2 ff <0f> 0b 48 8b 54 24 08 48 8b 74 24 10 4c 8d 44 24 1d 4c 89 e1 48 c7                     
	[   51.701406] RSP: 0018:ffffc900001ffb10 EFLAGS: 00010246                                                            
	[   51.701454] RAX: 0000000000000000 RBX: ffff888100ea8780 RCX: 0000000000000003                                      
	[   51.701530] RDX: 0000000000000000 RSI: ffffc900001ff9b8 RDI: 0000000000000001                                      
	[   51.701625] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fffffbff                                      
	[   51.701700] R10: ffffffff82239ee0 R11: ffffc900001ff9b0 R12: ffff888100ea8000                                      
	[   51.701789] R13: ffff888100817200 R14: ffff88810037cda0 R15: ffffc900001ffb48                                      
	[   51.701866] FS:  00007f7c4cda3740(0000) GS:ffff88812bd00000(0000) knlGS:0000000000000000                           
	[   51.701948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                      
	[   51.702007] CR2: 00007f7c4ceffdc0 CR3: 0000000100d12000 CR4: 0000000000350eb0                                      
	[   51.702072] Call Trace:                                                                                            
	[   51.702105]  <TASK>                                                                                                
	[   51.702126]  ? virtio_can_start_xmit.cold+0x2b/0x4d                                                                
	[   51.702171]  ? srso_alias_return_thunk+0x5/0xfbef5 

The issue is in virtio_can_start_xmit() where can_tx_msg->tx_out.length
is set AFTER memcpy(can_tx_msg->tx_out.sdu, ...). Since sdu[] uses
__counted_by_le(length), FORTIFY_SOURCE sees length=0 during the copy
and panics.

The fix is to set length before the memcpy:

diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index xxx..yyy 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -308,6 +308,7 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
 
 	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
+	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
 	can_flags = 0;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -322,7 +323,6 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
 		can_flags |= VIRTIO_CAN_FLAGS_FD;
 
 	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
-	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
 
 	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);

Tested with vhost-device-can backend, and it works correctly after this fix.

Thanks,
Dorinda Bassey

