Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585853C9EF4
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620042; cv=none; b=T74TLs3y718Dz332ZLAVHyMFZTTs6IDR3MUkmnjo2QRpiat1QPi1pk3m9FuxCDjlpJEFDLllOc0HWCYYK+nlPBpBvRlURxnWWnuANFEAPbGolsWcOR4c5FrcV8GOTVx7g7kinJkFsOq+TYL4Dg8HRwe+I8Yb5kAASfoBnvojrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620042; c=relaxed/simple;
	bh=7NdesRjgSv1b1kpIKOcJU3ghhlgl5tyDeUkJhLpnmYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=om8HJyr9nnIGKjIzCfjkEj4PMiTn8gNsmgTDk5IAVMmQtsl/zGjGwqJXTU2dkZsUxCRqOfFKmHZy6Wg5QHZOfeEwDsNrIP9PoJ4v0HyRA4My2UGGmnz8dwpVxeAQ1I6AVZcU3trHveQcaYZYmYqbZKAHkbWnqkVfBDjaqzhX1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jO8huRlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jO8huRlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXi+uVqRnkqRNPO9A5xD9TyHb3ak5Pg5n5rhgIRfmL4=;
	b=jO8huRlj+ihgxUbdbx8K1cX0LIxxTMpVFpxWvNHTJX7KqnY3mY5StY3ewPJKjQ/UgtWYPZ
	rDOn/K+2WjYKsSBpf/rFQpzp68JuTFn4gTBPxqkYXUx75y1ExGq4uCjH52CZ1mq41BnjuL
	iB7659sNXeFOq3cAd5jJCRkXFXXzldw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-HheZbr1RMB2w8POzMGBwDg-1; Tue, 12 May 2026 17:07:17 -0400
X-MC-Unique: HheZbr1RMB2w8POzMGBwDg-1
X-Mimecast-MFC-AGG-ID: HheZbr1RMB2w8POzMGBwDg_1778620036
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-447f2ce5556so3916931f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620036; x=1779224836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXi+uVqRnkqRNPO9A5xD9TyHb3ak5Pg5n5rhgIRfmL4=;
        b=U2qsk47B9YorRLlYekpxzT749fcR8xXyGbNyYQkChMiVPfo7b7y8il2g9VMgLzgC48
         hvnF9Nukka53TPjbbCLtgBbKsOYrBa4+hHYKKdlt7sCVcdEdl3EmH469iyQMHHb7Zr93
         GUQdEsdb+fBClMghMfHzAvZoBpPozH0c8UcRM2I3x5OHb7cCwT8JjCBbDhcKp2zv7XyJ
         NGmg2ZJA1woETbH8IFxvzFE9/FiTEy5rMGHUTymOmEsaZYvNnVVFX6d9/8bU0K4PZrpK
         lEkgMczpFtXZbQ6r5aB6H7O+hRT5VT6HS/y28rexn1pDlt5aUQeVmuy4hA1gTeKXrGuy
         OixA==
X-Forwarded-Encrypted: i=1; AFNElJ+bt8Pdx6mWLo3fetmrE0dIvgDy45ht6pC4L+v/oovVVEf1vGVM92/RYILhNPTr1P00SXY8QzwjsjYvIV8htw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+Dl3KJo3rC1llae0wlf9bBuboLTFI3laHYGmg3RkhMbzVBP8j
	mKpvzaOMl+i6fr0MV2flRx+MbGRgHfO4BNwBSpcHP7eTN5CnEKYf3s1zZ8yFaHJX5IXj532FFCn
	0DzUAOMx1qf1TQAcie+HoeqR7d9nrC9Fag0gfJTX3LnqgxfqWh+QMXM+BV23tqWOykCue
X-Gm-Gg: Acq92OE2SbLeg5StwSfzsbigr+tpZ9S25M+owlSrzfhUg06+CUpKMPkPyK2XH1Gz3bL
	dJ2vOcO1yPE/THAa4+spNhdaJjneyTdZFmtXbKgQ7urmlzUTECVfMlIjNkLlfWFhAyOQIG3LfR4
	wRLJceppEmNV0JeXuOz+irnXSg1zkb/bIIRvtAWux4WOH7tp8bEyv29CcPD4/B3uuqhld4WG8MW
	RsnzON+QdRrV/Jk9DGjbaufwjRq4cBhfNM1X+jRU0sHzPfTrKxTFvuuQLAagkWIi6zW/QHrt8PQ
	OVWM3kZN2KCpdHJUSIjnneF6kTA9mdqQQVXreCa3+v8NLwYvohsi6hjnaiVPII8tKj8P+9XLk5n
	IalP8Sl+l/3hGO9mnNDpmQaI8nlvmL5apEAIHpeek
X-Received: by 2002:a05:6000:40da:b0:44f:d9f8:c0e7 with SMTP id ffacd0b85a97d-45c77e635bfmr41872f8f.5.1778620035653;
        Tue, 12 May 2026 14:07:15 -0700 (PDT)
X-Received: by 2002:a05:6000:40da:b0:44f:d9f8:c0e7 with SMTP id ffacd0b85a97d-45c77e635bfmr41834f8f.5.1778620035141;
        Tue, 12 May 2026 14:07:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm19560446f8f.3.2026.05.12.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:14 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 23/31] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <de48f9fc3c353df8a55534d7300265055d48c9bb.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ErW-XGjAfM4Qhgqv4usyRAhbJcNWHcLlMaKufN1PYBI_1778620036
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Submit each reported page as a separate virtqueue buffer instead
of one buffer with an sg list of all pages. This avoids indirect
descriptor allocation (kmalloc in the reporting path) and gives
per-page used length feedback from the device.

On error, the already-queued pages are kicked and drained
before the error is returned. The caller (page_reporting_drain)
then marks the batch as unreported, which is conservative
but correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 36 +++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6a1a610c2cb1..fc43d0d7bbbc 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,25 +202,35 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int i, err = 0;
 
 	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
+	for (i = 0; i < nents; i++) {
+		struct scatterlist one;
 
-	/*
-	 * In the extremely unlikely case that something has occurred and we
-	 * are able to trigger an error we will simply display a warning
-	 * and exit without actually processing the pages.
-	 */
-	if (WARN_ON_ONCE(err))
-		return err;
+		sg_init_table(&one, 1);
+		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
+			    sg[i].offset);
+		err = virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
+		if (WARN_ON_ONCE(err)) {
+			nents = i;
+			break;
+		}
+	}
 
-	virtqueue_kick(vq);
+	if (nents) {
+		virtqueue_kick(vq);
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+		/* When host has read buffer, this completes via balloon_ack */
+		for (i = 0; i < nents; i++) {
+			unsigned int unused;
 
-	return 0;
+			wait_event(vb->acked,
+				   virtqueue_get_buf(vq, &unused));
+		}
+	}
+
+	return err;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
-- 
MST

