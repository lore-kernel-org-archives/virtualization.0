Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704447;
	b=X1Ce3+gJwJOZdstQqs3VXKYOQYthZ52svNgVw7ZEi/g+sMT9eIM6w3iI8Sto7N7+o7Nv
	 btPPAcCkg4g++BJ5raRDROzx2Odkcygm8eRb2IojVvYXY6UeL6uX2E4rJ8BZibfOhENhX
	 tv9A+C7Ytigc/BEt5pscDDLOIJNwenXuy9U+3OlKHM75+13FDnEsL6vPJSYAq8dd1iW57
	 RECLHKNl1vAye2GritwJdf2ba6KMjPsOwhGdvJsDkD0uI6YMaL1dNNBVaqd/xxipcrxC5
	 P8GTOVcm5yrdBJH8LTrm7lbJrNbGYkPKDjNFgWX2CsMtNcap7xdVpXbPoO194cIRyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704447;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=Iqfmd6XAEkIO50L1hun+5wUwYYa1P9cDT/Kb3FgMUxk=;
	b=gyDh2ssHgSCbD+SxEvAX71S4oYrbfADaASB2s3aSoYTk1qGb6iuLFGo77mn8Ku8eBkZg
	 hVuUtf7gqlzRQEKPpdNOZOm2JRlZUYZsBiw8yp2ywJIl80sHy/DcFB20Ip7cHINGvVnDq
	 OY0ICg8rOJURzU3g4of1FkCTlGt30R3WAlbR8GrnJ6sKAGXoJttmZJ5T2oothk+CmVciW
	 yWtR1pKgJsHTrgVQulx50s2YcH5Wn1cSLeQ0tDepY9Q0r8eqGJWxbwiUuGc3j67KO0lAw
	 M+tEt28b6wOvAtEg8vx6NnswQn6VhYYjcsgxx6tw3iGQIjcgoVSoKuFHlUe9tzsuuRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JfW9/nWt";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2F606A33C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE2F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JfW9/nWt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqfmd6XAEkIO50L1hun+5wUwYYa1P9cDT/Kb3FgMUxk=;
	b=JfW9/nWth6nrA56eB0RUw5cJL9+Iwzsg0YTd5GF20+q4xli65wiswH16ZiNAMZihxM2vvE
	BZ3PyP9BvdKTxVDNte2w4AFCw7mybeeqzFP10qhVduU4zjYzavVH8VDWe2/fKccgxpRNj/
	zjrr3+zFFykvvx3joH0444yQqAifblc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9llTW1EsNRyKlgy76Z-VPw-1; Thu, 26 Nov 2026 14:47:24 +0000
X-MC-Unique: 9llTW1EsNRyKlgy76Z-VPw-1
X-Mimecast-MFC-AGG-ID: 9llTW1EsNRyKlgy76Z-VPw_1795704443
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb818d8dcfso35641435e9.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704443; x=1796309243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iqfmd6XAEkIO50L1hun+5wUwYYa1P9cDT/Kb3FgMUxk=;
        b=xM1wD9p+1cWPYnDGf9HDKlrNNVCeGayl6X0bM6VZ8MdRSsmIlyEZrl5JbEh2Zdg/Sf
         R9uKEKdj7zvK8/QM5eR51R2k4cxi+xwIdaUafsjQ5g4e2FqS5kxR02PD57e00emLdufx
         AN5k0sfV2DO3Q+qvTZf9aJa5K+AU3ipMPv2BkTCfr1HMTxf7We/aOXTcf48fYzzQQ8cv
         8qivpP4MFZc03ameu7XERYVk8dcDjb6l2g2MPF08gr6i/YaAL7gbp+ErUpJvPt1fXBpv
         JT2906y8D9pGR/HlLRKHezH3n/Pl25/W0lGmH8F4da+3IImkMuZV6MmduYQ7GaBtSjJ8
         i4ZA==
X-Forwarded-Encrypted: i=1; AL+hErF5mRe7WoNnb5aTFTnUb8sm8oNHVx0Q5PQgHGndD06exDqTX3w9G3Jij/QC6e4e3pAABvlm24RNMTLDvl2taA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ZS6PMj2OgXcGaWviaHlLzvlCCWeMQDJ6fCO2eMyfLaYJ9HVi1
	5AWCKInJVGcFATS0wAUyaA5LBmk+aCtAdMSxOlLEdoFptCWhefq/fTJwF92x5nn6jNat2jzvR2E
	IUYpwWc+xMVxxMxGvyU2ZAM+jt8VBpEq6uABZuZ6nNUnCu/f9BrFFt8G59t28EwFAn0sV
X-Gm-Gg: AZFdTZc4TdT7eCJdZYC77XlkuTIXEb21ii7JmmzOu6qswn/7Y2KN8Q0F1eZeJgVZMk0
	yNQB+2521MsnBsYHtFHmBLiRtBVvyS9pnBFv1udB79Z+Et/IviayDIudCGdJN3CaMEMfJSgPcFN
	24j6VC1O+XA9OFXcYAmVEZ98Ix0Dt9fXtVrhPzctmRuLBzJg1069V+fNsn5di+xTU2qaBkCKQLM
	+qCrVPYBu04oly98h/thqak1Yril3Xuy3GYMo4cAUkFmKuNHVzCCswHaVxixu93OaVwYj8OYmUv
	TNs8dD/ozfUtIcdmsT0PxRxx0k2PA8GawO7OYGNFXEy/oGQJHMqtm3YuPakIoRtDhQmPuAouXvV
	U65C1XwESfwakqO6VgO02+6t5BHnspG9D+t2VvZeMZbNM7Gf3ynYVyzbhp2fNxQJ2nJsj7+/Ewm
	xsfObdDgKgAIKCEd0jf8r0a0q2kmjVq9WOTEfbpIGN
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr431882995e9.4.1795704442945;
        Thu, 26 Nov 2026 06:47:22 -0800 (PST)
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr431882695e9.4.1795704442556;
        Thu, 26 Nov 2026 06:47:22 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (193-226-214-34.pool.digikabel.hu. [193.226.214.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm388114905e9.0.2026.11.26.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:47:21 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev
Cc: Li Wang <liwang@kylinos.cn>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/5] virtiofs: don't abort DAX removemapping on allocation failure
Date: Thu, 26 Nov 2026 15:47:15 +0100
Message-ID: <20261126144719.232329-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126144719.232329-1-mszeredi@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p1hOtCvCX_kLzBWTpusCHLsBo8bC4r7CffitqrY0P9M_1795704443
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

dmap_removemapping_list() allocates an array of fuse_removemapping_one
entries to batch the FUSE_REMOVEMAPPING request, and returns -ENOMEM if
that fails.  The only caller, inode_reclaim_dmap_range(), has no way to
recover: it just warns and returns the ranges to the free pool, where
they can be handed to another inode while the server still has them
mapped.  The request is never retried either, so a single failed
allocation is enough to lose the removal.

The allocation is up to FUSE_REMOVEMAPPING_MAX_ENTRY (PAGE_SIZE / 16)
entries, i.e. a page, and it is GFP_NOFS.  Inode eviction and the DAX
free worker are exactly the paths that run under memory pressure, so
this is not hypothetical.

The batch array is only a convenience: dmap_removemapping_one() already
sends a single entry entirely from the stack.  Move it above
dmap_removemapping_list() and use it to remove the ranges one at a time
when the array cannot be allocated.  That is slower, but it cannot fail
for lack of memory, and it only happens under memory pressure.

While at it, initialize ret, which was left uninitialized if the list
passed in was empty.  The current caller checks for that beforehand, so
this is not a bug today.

Fixes: c2d0ad00d948 ("virtiofs: implement dax read/write operations")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dax.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e20a5ae6fecc..c5bbb5d91026 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -248,18 +248,46 @@ static int fuse_send_removemapping(struct inode *inode,
 	return fuse_simple_request(fm, &args);
 }
 
+static int dmap_removemapping_one(struct inode *inode,
+				  struct fuse_dax_mapping *dmap)
+{
+	struct fuse_removemapping_one forget_one;
+	struct fuse_removemapping_in inarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.count = 1;
+	memset(&forget_one, 0, sizeof(forget_one));
+	forget_one.moffset = dmap->window_offset;
+	forget_one.len = dmap->length;
+
+	return fuse_send_removemapping(inode, &inarg, &forget_one);
+}
+
 static int dmap_removemapping_list(struct inode *inode, unsigned int num,
 				   struct list_head *to_remove)
 {
 	struct fuse_removemapping_one *remove_one, *ptr;
 	struct fuse_removemapping_in inarg;
 	struct fuse_dax_mapping *dmap;
-	int ret, i = 0, nr_alloc;
+	int ret = 0, i = 0, nr_alloc;
 
 	nr_alloc = min_t(unsigned int, num, FUSE_REMOVEMAPPING_MAX_ENTRY);
 	remove_one = kmalloc_objs(*remove_one, nr_alloc, GFP_NOFS);
-	if (!remove_one)
-		return -ENOMEM;
+	if (!remove_one) {
+		/*
+		 * The ranges are not reusable until the server has dropped
+		 * the mappings, and the request is never retried, so failing
+		 * here would take them out of use for good.  Fall back to
+		 * removing them one at a time, which needs no allocation;
+		 * slow, but this only happens under memory pressure.
+		 */
+		list_for_each_entry(dmap, to_remove, list) {
+			ret = dmap_removemapping_one(inode, dmap);
+			if (ret)
+				break;
+		}
+		return ret;
+	}
 
 	ptr = remove_one;
 	list_for_each_entry(dmap, to_remove, list) {
@@ -350,21 +378,6 @@ static void inode_reclaim_dmap_range(struct fuse_conn_vdax *fcd,
 	spin_unlock(&fcd->lock);
 }
 
-static int dmap_removemapping_one(struct inode *inode,
-				  struct fuse_dax_mapping *dmap)
-{
-	struct fuse_removemapping_one forget_one;
-	struct fuse_removemapping_in inarg;
-
-	memset(&inarg, 0, sizeof(inarg));
-	inarg.count = 1;
-	memset(&forget_one, 0, sizeof(forget_one));
-	forget_one.moffset = dmap->window_offset;
-	forget_one.len = dmap->length;
-
-	return fuse_send_removemapping(inode, &inarg, &forget_one);
-}
-
 /*
  * It is called from evict_inode() and by that time inode is going away. So
  * this function does not take any locks like fi->vdax->sem for traversing
-- 
2.56.1

