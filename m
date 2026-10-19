Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44F4E01E5
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411402; cv=none; b=r8YF8u06XR24K56ga5Bb11FDVlsd3T/qWk30+bIaDZI5cCxTdKmXp+sQUIUnfglK1766LxRHCV3A+ti3UgI1o6C2jg+xEfvF68Eiw/Ogpz3ifjmMLhxK50YNjMmYEhj3nU+1dX9apKNea5XC0uGFnPdg2Pt6lkbK+hkJT3fewMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411402; c=relaxed/simple;
	bh=q3RS+TwRg3t5oZH6IrcoVIYjH3/jmXqxC3p1mYXXgks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qNqqdgaf8PqvtbdWyfKje/tpxcn8jjvsEveBeT7yIb0ijE4xjWwFPi34nsJaZuCfI6VOMXaU3sYsdANjH0P6kRPHg5l6DAcJorupiuZ+cCTiL5oFSB72jSN6mmi4sdXqOVPGCv8M6iNTjDldLPm86nH/+TtJ5WvEKm2Xa8aR2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPiFHZY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPiFHZY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
	b=EPiFHZY5fICb2NVnDxyAOcqA4B9G6/T6GafpI0CpYiF+SA0KioKr/jJnnuGVW0CNPlGAfP
	rZHdx+MUbpTueXPhyJrktRhReqKnBIMbOkW6/+Liy1iRL82ZNMNtHnXzt95Eh6atQt0bDT
	g3c3TEbqY1dOSipw+IlUF79gNatYbkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-c8dDb4SRMDqXxGO9hfLRTQ-1; Mon, 19 Oct 2026 12:03:12 +0000
X-MC-Unique: c8dDb4SRMDqXxGO9hfLRTQ-1
X-Mimecast-MFC-AGG-ID: c8dDb4SRMDqXxGO9hfLRTQ_1792411392
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so22857735e9.1
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411391; x=1793016191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+e+7zZS8Om0Hv5D5NOXTDcthbJqXRoYdlzoN2ljcZOk=;
        b=bNxlzgDe25EKnph61Q8eOHV1UofTCKt2dU2NpQEdngtYYfk2C869eU9RrfG5ckMfnK
         /UYzU91at3giUekcj9yJRlfeA6n28h8GtlsWR7vo836mPFTNRCOdjJRxC9PDUyL7wuos
         IEllQlo47QRRs/p04LjajD50KgyY2A8/QZZV5CCc9w9qIH10WEnGR6LMj6iws4fgaFPS
         Tdxz7JZhGHimEcSFaY/egdpPdZpu224pE1Dr/URrLeyJXvA9321J0+fqdLxX7KnyDTwD
         bs+VxZSuuIU7cR9NGBhNVdeTiXD2e3JDfsExbROlFvhD+qBdLhUiQ3d1fr5eHfpoux90
         Y6ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRmVgS3/yPpl2XZwiRczKTA8yPlAmiJA9OjaMuJC/gUbm/cQyJgB6ZQX2IlcIfPmOG2fyWpgNrOPHoPfkMfQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIX4bhhcpxP0k14GkMKK/CzExMcsANciyqEF0OaGUhYskSIoroY
	zh+OL8EuQeXyMIXSrRUcz5aApWz+71T3Aj8TBcVhRBK5TopDVfTYYQT1Ig43AnCMBguFrMfvuZw
	+k4PFK+0HHqCyVyPhLSCmpRDUlSE4QPiyl/y1P+f/QJ4mVy3axG0wJNLUes8WmLibhR4LsfWeLU
	ar
X-Gm-Gg: AYBFou2KJFWBNaftkoK3DTI6PiOAZuf69p7p5zGN/zieqOpZ5NtjzPvcXafbzOTiIsS
	mHVLgIJqZx7hmFnmwnh17fMbJ3L77z4uHlLrKWoUcB4Az+LAiJN9ej2mwzgkoBJPyZStkc3t5zP
	xRImUpGzo4+O+2L5BpHCebkDbgFrd4L262Gaq5TPt9DImDlX9BDNQKEC2N/DiMaMDdbepq4kknu
	Cf7Q2xzjcl3L9AeJ5Sx58XEXjBvQEtWqJGxFbRia5VMGxmkYOmuenPpBMQBmaX7JX1jt5iyozTl
	cL3POC6Sx4HB31jpOMiHAAMqo3E+mLbZkQUWSmAyvakZ/d/9QkAcDhXQHrglYX0fXg+i2w==
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831865e9.12.1792411391207;
        Mon, 19 Oct 2026 05:03:11 -0700 (PDT)
X-Received: by 2002:a05:600c:2319:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a1c66bdcafmr171831005e9.12.1792411390490;
        Mon, 19 Oct 2026 05:03:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm20719207f8f.12.2026.10.19.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v3 2/8] um: vector: honor virtio net hdr conversion
 failures
Message-ID: <554a7cf11f82676fcadde914c7044dcad9bbd0b5.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8blTzyIdlBJnVnSFo_Xv4j3y_SVZQBgjxGUnwtXhmEw_1792411392
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio_net_hdr_to_skb() refuses packets whose checksum metadata
it cannot make sense of, but the vector raw transport ignored
its return value: rejected packets went on into the stack with
their metadata unvalidated.

Propagate the failure.

Note that a follow-up patch will modify virtio_net_hdr_to_skb()
to return a negative value on error and a non-negative value on
success.  This is why we don't just propagate its return value
directly.

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

