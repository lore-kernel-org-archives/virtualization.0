Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704446;
	b=GamuzItMQsmTLXglAWVw/IV67ZGQ7bmAYRgUpJPwj20iH4XLrddle26uorVOrm88joRo
	 NMFZCbTm3KmZXBj7wKlNw1vgr0EsXQ1lkdj7Clx+IIzT7rZ/0FS8IKpWn/etvfGkJoQ/I
	 +pxJ68bp0tdpRRVuSgUnlz/93gy+NdhIrGD3bflJPuR7ky6nrWxYOWjEBDMBQ+phW52oJ
	 zenOSxTTG/SFCQNr/ygbHU6OBJ6jgjteAjIYRIDAEUJpEZgNb7IKwC0cosoJs+8u8wEu0
	 //2Mqdd+aGuqnEjVe8f6N7fy7WhtBtU/+ciH/wnidRdbnsik0Gv/xzRx0+e4kdkWG4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704446;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=YifvtI16dohalgScYWshuikeWghBJ/xe0p4EKREtgkU=;
	b=LLMwzuOx0/56Ovl26wGRttJXvyl2WMGTeh0tFRy4y9vGEdYXfxfsjN2E/Yj5L7wfsz/E
	 kGq54I0iUT5JXV9f0R3io3HesygCmz/ikXg7Ih/dhFA8GaBPK1sbQbk/1jyKurjinJoaF
	 Inh3Wl/atWuEpfarQXZ/Y5XYTtRTIBCX9Bs760/nGFjEldZnvttOIs50UW9U692/g+pq8
	 Oc2chVH3BXqYZGUD2Q1B22ZQf8FfQSSoIwd69mL2sNT2RocLHoWH6WPxgp9VUE+NzYiDx
	 PEzrQohNdpSMXtZPttU1ETbnPc7I6d54aQe5pYE6dOabeMZDL2fWQKef5JqxYbCTudg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCa2SOK1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2B606A33F
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC2B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCa2SOK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YifvtI16dohalgScYWshuikeWghBJ/xe0p4EKREtgkU=;
	b=MCa2SOK1o7JgUXca/aELERmbX2N0/NeE7vTittutQw/qPYUeGVQ4m4oyNlhp7+vfLvav1Y
	m7lrGv9pnelIX/RDpUdCmgEHci+TyHAL9UxAZw4ZvY8JDXMJfRZnxrimMH/UT8R9t9yyIJ
	4rl4Jh339su9/kmYaAT0ELwvzhpUWUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-IIf-r2kLPQyJWJLfPWYdog-1; Thu, 26 Nov 2026 14:47:23 +0000
X-MC-Unique: IIf-r2kLPQyJWJLfPWYdog-1
X-Mimecast-MFC-AGG-ID: IIf-r2kLPQyJWJLfPWYdog_1795704442
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49febef74e3so54864165e9.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704442; x=1796309242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YifvtI16dohalgScYWshuikeWghBJ/xe0p4EKREtgkU=;
        b=0XfbNw3gTSwSlcPHbypwLb0R6Dd9cxmLMqhKF93msdmZnK+kuEH+3ji7nySGWsdBQO
         /S04UuNIGTSyEiXImr9q7irsK42npJh949EXe1z76CiXYnVVcuZgMK/og4O5LdKsRjeP
         E9S2Rn/bNCkFw+Os4zKLogRvnDtflAD1sQmR831jDtaM6QK0prqv6M3GUNd30L7khxrR
         GyTeXb86Em2Fswbrg3cIgaPLsmL4RxMJUd8h+S7oytDIGfgOvttltI8Ck/giDmhtrTGi
         o6myrCRJHdX0SvNZS5rC8FV16IXl79GywLFn8HD6EmAbwiGS/l48wKp1W58AdC3WMAvS
         sQlg==
X-Forwarded-Encrypted: i=1; AL+hErFf3Ee+btwygocQxRF/mQL75wrfmvVmqGrO6CrDoENF57ILiKPxgLBiCmcc2n5BESOg7H5I1CJq6fGfbs6p1A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9zuQOxyyKidjw44rMxn3KDl1p/8Fe8CEK6692c/ef9nYGO0q5C
	6hur6YBHZVpSUzjQgwbewlp/4DMoNGY6uWlmwiqxkfBUm0XVWLTPzc06v4EnrR/OsxaWAnx05q0
	WqFnWwyFvLTtuwXfGvT5+R/M/YTFkvbRuj9L5x+74M48Kwffq03XNgp/j88b/HLLtEvR+
X-Gm-Gg: AZFdTZftTQB5Q84nLp8UjdLRPbYMefryi4LBWo/bC5T0lAuO0qtg6mw4nMuS8MA2zvN
	Y+n4MAmWteQCAXo8mbvgcFmQPgIWKelsIn2Rtti/azUspBhejDW0T313COPWLSDgK5YMmk9BX6Z
	NpstIPNi75ufS9IQSDafFzCm9HUPzfebHU9pDkbgYkzLqXXIpQg+z3Y5+jbSgzTOD4eiZaU3cSt
	PkR6BDeRhlV+UCU5438suFGHKSPq4/aqAardYkg9POFNoxX2cKCzTpDBBuNlWS4d3zr86oE0AEE
	pn9wBA6GBU/HNp2FAorBiVRxIKI4HSmyvl3x/F/ek6Xah2+HfhytpYi3j7JT0j75q5GAjS6CY6/
	Bp6Yy1/dFsnY+25BugJwySZOZlv/vO5tAoYXWQsXmoCr2upoV172DZqLTMbFHih728UucTzPa5j
	/oeY82cASYnErypp98/5mqwoOvT1fzmMYqLrMq9sBQ
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb887fb66cmr446667255e9.5.1795704441854;
        Thu, 26 Nov 2026 06:47:21 -0800 (PST)
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb887fb66cmr446666735e9.5.1795704441481;
        Thu, 26 Nov 2026 06:47:21 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (193-226-214-34.pool.digikabel.hu. [193.226.214.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm388114905e9.0.2026.11.26.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:47:20 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev
Cc: Li Wang <liwang@kylinos.cn>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/5] virtiofs: fix DAX range leak on unmount
Date: Thu, 26 Nov 2026 15:47:14 +0100
Message-ID: <20261126144719.232329-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.1
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
X-Mimecast-MFC-PROC-ID: Wm2TeCPjkmEIrS08kqFifjy5hTwdyxVasEe2txp_QTw_1795704442
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

generic_shutdown_super() clears SB_ACTIVE before calling evict_inodes(),
so at unmount time fuse_evict_inode() skipped fuse_vdax_inode_cleanup()
for every remaining inode.  The DAX ranges owned by those inodes stay on
fc->vdax->busy_ranges instead of being returned to the free pool, and
fuse_vdax_conn_free() only frees free_ranges before kfree()ing the
connection, so the busy fuse_dax_mapping objects are leaked.  Nothing
warns about it: fuse_free_inode() kfree()s fi->vdax without checking
that the interval tree is empty.

Call fuse_vdax_inode_cleanup() regardless of SB_ACTIVE.  That is what
virtio_fs_conn_destroy() has always assumed ("Soon evict_inodes() will
be called which will free all memory ranges belonging to all inodes").
Unlike the FORGET in the same block, which is pointless once DESTROY has
been sent, the DAX cleanup is the only thing there that owns memory.

On a full unmount virtio_fs_conn_destroy() has already run by the time
evict_inodes() is called, so the FUSE_REMOVEMAPPING requests sent by
fuse_vdax_inode_cleanup() fail with -ENOTCONN, which
inode_reclaim_dmap_range() ignores.  On a submount unmount the
connection is still alive and those requests are both valid and needed.

Fixes: c2d0ad00d948 ("virtiofs: implement dax read/write operations")
Cc: <stable@vger.kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3b38f8c0-5e4a-4c21-87a6-4f96cc3cf147
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 20fbc99f3590..344fcb55a64b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -150,11 +150,16 @@ static void fuse_evict_inode(struct inode *inode)
 
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
+	/*
+	 * Must be done unconditionally: the DAX ranges owned by this inode
+	 * are freed nowhere else, so skipping this on an inactive
+	 * superblock would leak them.
+	 */
+	if (FUSE_IS_VDAX(inode))
+		fuse_vdax_inode_cleanup(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 
-		if (FUSE_IS_VDAX(inode))
-			fuse_vdax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_chan_queue_forget(fc->chan, fi->forget, fi->nodeid,
 					       fi->nlookup);
-- 
2.56.1

