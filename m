Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3205226A2
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068091; cv=none; b=MTZv/wwPUasUIl3KqBnNJVDz6qTdER15jMgR5qfOYwj1hAcJz3IRiJOmluaXyk9Wb765eg3YCCBHoNLTJ5fjG7Brz/L6ChqyNiICBEE3EnFt/B5jprj02pgTcCPuYPJQRMe9uAr0Ad4Jxuxy7qzfb/EjmQSw9oRiarC0rSQ+NcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068091; c=relaxed/simple;
	bh=B9H+Ad0yi56qqX3Wrqd3mE/6pQkLakPw4j1ZK3PT0YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rT7BjWpOANBb1wrEEhuOuM/0If7+0Q9XKtPIBE9XuYpoGZfYtwQqKrWc2uDXQuStpTHzJJ40f5Xnx/kAsks/t5NbByi+F/tVd9qUyd4P47TcZkLirvSRUY+GJMJlGm36mJ+7SKrXqny6ERy1OA/ARTYcqHCH+EgOdPXbVqqn5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atd7Eoj1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atd7Eoj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
	b=atd7Eoj1VotY7VRlNhYFkqOO9LK2uU8r1j9U3V+Zxzwr2ETnh6EbfOPbkKY4TMH9Ayi0uL
	ZSD07x47EM4BQPmVoHOmJ26J3ShrECB1A/AyiCRrFzQndkHrZwtm4MQsyvPHxwhRWIEOaO
	yDSdhQU7hqyU0agN4vYBBrmzeWKiNlo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-OOUF3MmcPpKmSI3CZnEaTQ-1; Thu, 15 Oct 2026 12:41:26 +0000
X-MC-Unique: OOUF3MmcPpKmSI3CZnEaTQ-1
X-Mimecast-MFC-AGG-ID: OOUF3MmcPpKmSI3CZnEaTQ_1792068085
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a16dc2323cso42452445e9.3
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068085; x=1792672885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEV7NzYtQRgE9IRDA9odxEpqlMO8W0BmhwXqYIjgqPM=;
        b=d15yTr48EkWyWnw+NsYVVI3v06IAow1/gBjiC0yjKDC+DTwitPrL18aZ7JqlRh7JJF
         AXJd1TvW44xRzSPYSReP/yTfzHSN2gJysVJcUuKP5VSfqwhFwoq5k3PjxXoUNkxCMiRp
         GeN5KZpnVtKSSFmgarShFT1SR2R2jJMyLgWaRqXzHReMftezRJpiA/mbPaiqqeIX/9Tl
         SgbRe6idbkusF4c0v+XvGZ5+mlkIzlyND6NiB1gwFcyxRIMcy7ipZ0caj9G2hDBXp93L
         RtjRW0gOf/MkYNZHR+vmHJhSIoHR6MCxhi2N8UBknx83/JEulIOqUcsSVuvdxVEiQvG9
         yysA==
X-Forwarded-Encrypted: i=1; AKwUvBxFZXFTmJ4DOKRl3FoiqspHKLSqb+aVeHuLgtCPQqBUFRCaKiKJDTg8Nnx0FnfNOBsxUAGOhi7spvH5MaEgRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9DfiS/x2lU41cVpFMvJAQ7bLZ8jx3i84XD/PJes7cywAF4fam
	DLesUQK23ClCtH9QW4dWsNaDI5NL4Eu8tcOKOM8+537sgxY9bNrf4TOVwBNg75sXG/aMLDZOYCi
	Q+Sj0eFOmSUr1CLKaynQzFr09cwmeCU8CBS417WVAkoSpeMmW3zWixbxrPmXhiXe0k+Im
X-Gm-Gg: AYBFou30PxSbCU1IxWRPs19N9jVRH4loLP8al0pOy5uqs0FrTqARSY+hPugmgUXBRet
	G5KOhE/eOT/k0o7wQbuEH32HC6SvO6Mtj0IOvzpaZwYwVbTSVCnowMajyAWDSDttKV0Y66iGttc
	lVK72aZMQBdywRxucvXdubbRqPAQcvpPHMTDMIid678o+jPkBWIT4OiP7JEtQA9J1LZLYSpXJxY
	e6XWBHeZv4FZ5KaY3+F3GRkVl0hYh3YNe9fZDJXlRYX75p949BtaIqIa2vedlVM24ur+uR7UcQ0
	TF+g8T2cz03ux80QWG2UWiyyuu75VrWMKH4T7upRjP4SN61U3UxJGMFq97u5jnocaCqVFQ==
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912252f8f.16.1792068085120;
        Thu, 15 Oct 2026 05:41:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id ffacd0b85a97d-48dece6d67amr10912175f8f.16.1792068084547;
        Thu, 15 Oct 2026 05:41:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm23198836f8f.4.2026.10.15.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:22 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 48o7eJYVCgMMfMUtQgkBtjYtehfvmKrWou6sgr9OZ2A_1792068085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio_net_hdr_to_skb() refuses packets whose checksum metadata
it cannot make sense of, but the vector raw transport ignored
its return value: rejected packets went on into the stack with
their metadata unvalidated.

Propagate the failure.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..8b7548458663 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,9 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	if (virtio_net_hdr_to_skb(skb, vheader,
+			virtio_legacy_is_little_endian()) < 0)
+		return -1;
 	return 0;
 }
 
-- 
MST

