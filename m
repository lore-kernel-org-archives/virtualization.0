Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D940DFC2
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258664; cv=none; b=MATj3lLVtNdaaODoNB5gzRjtBtUDrb/1cpFRGYTB7rGP+xGn38TDLsrKWc72H1/Nz44Z4gub6pLk26s562bUVVHq4NEBKShSYMe710lK4zzcyv4DsS/hdbIB5EyWzJda9vY6wEWbCcx2349o7yqMWj+fsy/8w0kvJNv/P06ee5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258664; c=relaxed/simple;
	bh=GmB8OB8MBui7lDml76JA2BxvhthP+WnYVp2rivY7tPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=X0ac4hB49+4PTtIVu4gkweLa0rHCSYFqVart//Va6khJ2PLl89coBfa9No7ysr4kt1dOt22Y2aJ93GbSePovTzLpntxiv+8jCkd08DNECioM/mldnI8CVF2d+M6hNYJ9olRo6jzOonCSXJmc4hz+fegPpdvrsJi8NzGEgQpEG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OISjPRLA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OISjPRLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
	b=OISjPRLAOUKsuWrrQ2qtvN8lfhHkznELRsTCVTvcNul5u4qu8SzhRUVwl9SHawSoAIl6US
	0vi1zbTLVi1m1d9vTCgPetdtZs90T/OmQJP6SGOs9ppwL0CUjn9FGyjuyw9Xq+EGmwEULb
	m//rPEof/zW9ou9xLRg/JNA4lB+by/k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-soVugxN-NH6zIYhtKW58Gw-1; Fri, 08 May 2026 12:44:20 -0400
X-MC-Unique: soVugxN-NH6zIYhtKW58Gw-1
X-Mimecast-MFC-AGG-ID: soVugxN-NH6zIYhtKW58Gw_1778258659
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso1419165f8f.1
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 09:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258659; x=1778863459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
        b=lGrUJ7vaU8upyMXaWOKw6wwpWnrI07uwNzqfjVuUY3pFmVhIC7f/3Vvu5bM4Lv5A3j
         QotylgApUknBGttXVB0B8kK+kARD2e2iahIzQBxqeSgZaKsEJKH5kKORMmZi4Gu4GaZx
         H4/rWCHGNyg6ykQsMuN3P6RKp+49armdn5J7gROVN94NQElGASWONJlwwCSb445Bc4LQ
         VkFvwNu480u5zlb/zQb+aNkjyCJiB0QLabjgYz6epBMFwtjONqahVNyUgp2enk1FjN2p
         zhWv3FZ5d66azrIRDTyHJtPYB23GA3vEl1/oOzl7SFQuR2PWGH4kuHA2HU4kfsQp/1P6
         RtgA==
X-Forwarded-Encrypted: i=1; AFNElJ+NYdLvUl0Cl3CBq+E+AyKraVwGeze5N/y2DgSRDEzI4N224mvdPlY5VF4uwwprb7DkpG6y22+q8f7aCPRi7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgqR3IshCAAtSOrK2WA2JWciDwsVgdHh/Lb26bXfulfk3/5EiU
	o1n2NUXdPMytqM72m2Uibn/syf5xgCGTzZAk2Vr6BGmKIMmyJvFq7yvsAYYiINej5g7VCf89MDJ
	Bg0Df6YzrbsIuoUVFG8VwgSruxWr4zATE3NOJD7G/W2o/HQk63WJjN7uB+qNh+G6E6GAJ
X-Gm-Gg: Acq92OFOEC0ymWaA7udokkU9LfqeJdJuNWUFEMuE9h3s90JTGCSPzyK6gIgK+WRwPI6
	l9FEwlMPGHqAnSXxQcvevQ1HFJF8ybBzfSgqsWXtKlCwbNloDdAj+Ku5nvZC+JBy14ZEONmFvau
	nojmkGNLdGhBpvnJCqchrNT4C+uMZ/LtGKieif1Z5lvU5lHKVvqPGWLSzvGILJ4/+07kng79ZJE
	VHZcroYcusW4RTVZyztVNluscXcC2fZHgn5qEM79jPmVZsSj/Ko30PybdLNm6WpMvMdDY9tIsYI
	s62IqZoJ4lMhPR0iqPzTO2pH8RpPWW1b7/I3aG0MiRYTaMrEpX62p32/Y9By264sMeyspjcUovh
	sj6DIp2TDQItnYfER3Pcsv419Lb25uQFdAjINS5qJKs/vJtMSMwYOlkxyVVEfMeg7pPSlTnte5+
	n5
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832387f8f.27.1778258659237;
        Fri, 08 May 2026 09:44:19 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832302f8f.27.1778258658503;
        Fri, 08 May 2026 09:44:18 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm5477523f8f.25.2026.05.08.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:17 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb for split packets
Date: Fri,  8 May 2026 18:44:10 +0200
Message-ID: <20260508164411.261440-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pz66J12O3uR6cJE7wuAFsz73v-25fURtQB_Vq5ZYg-s_1778258659
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_build_skb() builds a new skb to be delivered to the
vsockmon tap device. To build the new skb, it uses the original skb
data length as payload length, but as the comment notes, the original
packet stored in the skb may have been split in multiple packets, so we
need to use the length in the header, which is correctly updated before
the packet is delivered to the tap, and the offset for the data.

This was also similar to what we did before commit 71dc9ec9ac7d
("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
missed something during the skb conversion.

Also update the comment above, which was left stale by the skb
conversion and still mentioned a buffer pointer that no longer exists.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..a678d5d75704 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	struct sk_buff *skb;
 	size_t payload_len;
 
-	/* A packet could be split to fit the RX buffer, so we can retrieve
-	 * the payload length from the header and the buffer pointer taking
-	 * care of the offset in the original packet.
+	/* A packet could be split to fit the RX buffer, so we use
+	 * the payload length from the header, which has been updated
+	 * by the sender to reflect the fragment size.
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
@@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 
 			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
 		} else {
-			skb_put_data(skb, pkt->data, payload_len);
+			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+				     payload_len);
 		}
 	}
 
-- 
2.54.0

