Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6D3D3494
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490237; cv=none; b=A/1yUKt7gcncSAUjsfF0lWkUqVIElSVbNZBAj1RVoXzt7Y8LT34NrwzfbTyNkDX7SyJQNeiroXndXusVU+9XB34xCKqSJvazUtDTtQ2qoTWLJTSCZPer5y56HYCc+MWgQbAu2lxY+vNTAWWKM3MUQ5purVzwnze8vcRONoynv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490237; c=relaxed/simple;
	bh=oYf8Ac6ioZ/fyq4O92mQTh5p7Zvk+J/G+lE9Pf1TUvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sqKwhIqvSmRJm160jW/G+sO8NcV1J7yo3ZiDqupMYSXi3LTZoizI0S+9wnME0mxV7wqTziNk+mt/kHKuMsGUq4U/bx/J0K+gehQxci+/iwYooOiaE7pHxj/ezd0VnCFunSwQ9ZjtS2MWti/ZwSoc8x17HO1PQGDu9MnW6XAr/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrKqYGs8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrKqYGs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJvki5d0ND9UiDEat7+4BM/+FuHUbmXzqDz6vRDL3g0=;
	b=GrKqYGs8xVbPB6kioHBDMRz944epcd93GBTrKwoxUPa6Oi5EWaVVSrOJCa/QrYHaAWporV
	INp7CDNRs281xPcKOoXGMcn2Gpr6bEDt2h6l9SxSomJwCV6iPvaZVzKQyYQ04/H9/AOBaL
	n97m9946gI+dMv9SbAFaeFhe7C5aKls=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-RdarJK6YNZuQ9oDjWgHNbQ-1; Mon, 11 May 2026 05:03:54 -0400
X-MC-Unique: RdarJK6YNZuQ9oDjWgHNbQ-1
X-Mimecast-MFC-AGG-ID: RdarJK6YNZuQ9oDjWgHNbQ_1778490233
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-449dcfe8005so3842698f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490233; x=1779095033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJvki5d0ND9UiDEat7+4BM/+FuHUbmXzqDz6vRDL3g0=;
        b=V4s0uZXWrQYAfdos4mW/3lZ2gJez4iQPvrkMfctlVxF5gtzJk7FgYmN5jfM5G+SmGz
         AUloNbNt5FZGGNhSq784FFCQYetC1WIS+PuSyzXOwqibbf4e9cENelPyFrULcQzh+CMu
         lWHLf9/1o3VF/1pGn/bcUrBK3j3AevsgdvaBao+1AiTV5vTKMdiP/ED1tsU3hFIwTuki
         g+HeM/TR/X7DY8MtnGFakZL3iFY9FwoRGiTfsRARBqPwJh2R1XJdmMFSakRj74g7BNl8
         PGWeA8jkvdllICj/UGuM5DVC+4nWBGh/2T5iqLqDcA1JdF7vMyHrNwQedOvmcutiAg10
         yvCw==
X-Forwarded-Encrypted: i=1; AFNElJ/IdCN4JHnvUsCIvZVlfHpHslRUvAcvOt0Q6EwNLxHF68CUDZWTHZlkRr1K7O5v+S8DxH0jYNW5r6BEX3gYIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI2KwuTswXm8OZsD6BdLsa3JTlsvblTyWtamC71z3pHHUvN4ud
	sdrxPqvH8hhsGlxS/BcuYbD+emSUYDZ5ypAUlom6EAWMceldUKVrC3QCbVx9/ggmWlcmO9JvwMH
	1dVCOsRyWN5W2EwkTKuJ9VToVzdj2N0gMsP1oznTBd5ELV6k38+NdPvyabY6asNBdisF6
X-Gm-Gg: Acq92OFMThOySwyCqVUgNK5yc+B0u/cy7L6AmTStXuqpwX9+7z9E8a0qDH5HBOK8Th+
	KJSDV5+7JsxEZSlbX1A68fF+Qu3GD40eJTTxyw/8p7fOL1ytGPEX0DpMBSYoDc82YCNcA7BrUN4
	vIjtey5QcNxIa9SBAoI3ZaV7Cy1bsCQ1ky4SvB82F7e+0vGbUS6pbUtqpuYPP+XqTlrtkWmneAV
	dHsCdBORbEdYQaWqUn67ipb275NlXgSm6ICNwcOug6OiyydvMlSobCYRJF91ptQRxae/W4zd73D
	oRSpCianjQtjvtwBrowOZmSr6OhqPN/l6H7L8r9R4YMkhsPvBxk+goV51yQtV/3CGDb3BmTcDsZ
	bS2baO+nxuJhaqSVM8c1f4Z8ikZAR4JUSIKfo8zwL
X-Received: by 2002:a05:6000:2909:b0:44b:e349:e6bc with SMTP id ffacd0b85a97d-4515b056ac1mr37167857f8f.3.1778490232754;
        Mon, 11 May 2026 02:03:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2909:b0:44b:e349:e6bc with SMTP id ffacd0b85a97d-4515b056ac1mr37167751f8f.3.1778490232034;
        Mon, 11 May 2026 02:03:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304387sm23431955f8f.21.2026.05.11.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:51 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:46 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 22/30] virtio_balloon: submit reported pages as
 individual buffers
Message-ID: <b5126dd421a0ab80b646be7a84dbd62c688c4837.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lI8sr_HVkf-nJ0AYiu9hkPHCNWv8tfxLTne2X1b6Mow_1778490233
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
index 6a1a610c2cb1..fdfd828657dd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,25 +202,35 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int i, err;
 
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

