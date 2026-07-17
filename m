Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20B42A144
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298137; cv=none; b=YxvdpGH3AKmczr9JBMaERPAhPO5deO6xp/QndCzhZpfiuhysSoFyahIj4JCHelJtaACj71t+ew1B3ECsn0u7tuiAe0Ak8ij1wyrL5R295AngF6PYEpEDknTArf+ziBFq63uor0GrFoYTjo5CFipA/GxHhEkYzOGIfrW8y6lssSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298137; c=relaxed/simple;
	bh=7kow3xJStgv3CCEwPVH94AHQZCvexA38wioGE90Sw6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fjjtFpnLA/i6X54Lb21DWwwn9AT/kvCdaH3EVKbrUQOrGkOv6f8N63rA+3T4tujrQm9+rvCa7rs9nbaK4XR/qp3FMP/I3k1heH9CCcnETevBCxA0kJMEK5LJqkNXqsFD7+SwiEpN+zEQkPyBYqwhkqIf4wXcJft05jBtIbQPCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmNNrGi2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmNNrGi2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4361976a91.3
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298135; x=1784902935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ye+2o/nLKhbl8EFiB/65QBjN6Z27bE/oD+7iGYaj4l0=;
        b=pmNNrGi2/j+l0j26q10ORP9Jatje3SncvICemU0nuOyLBSdW5QkIR6cI2qV9QwvbMo
         OjEcntz3uf2FWR9u9uTIcnhtGJfy3lE4SrX1jvOsHzYWdVPnggXz7wheEvbRH+Hz+h51
         hpPVXN9mhyXtsem38YiOTnBIFFTGGm6pJPwihpgd1qBXInqaEa6igcOqOrRBrKh1NS5R
         Pz15zprBGLBt8nZHxItsYhgWf0PaevC5k/aYMxIsayIry9ROKEGhLZEDhAJC7RRHMo0U
         MPSXUJUsRFcuycgHoUyYMcPZgelu5Ndh6D67XPYpZ20btjiuajfruoS+Z0abHKRtn6pG
         HycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298135; x=1784902935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ye+2o/nLKhbl8EFiB/65QBjN6Z27bE/oD+7iGYaj4l0=;
        b=NyafEq5c5IFSkvWc78B9IXMqwOXEbzVzg/DeB/bawNouRI9nKHHd1K/wtX0hhl0zzI
         n2WWY6cCCb7jF1AuTGoY/FzPpK7fX25MqX2Xd4RJQOS/RR3EMfjT1qEwoGjgT2wDlVFE
         OhsgzD3ImpbuLCxtsv5nE9vKc6ihY7Z7X2dJ59rZgBY8Fm8WSjcXeerbLysNMIMSbA7c
         +aOxVXuXAeYpUR3nYyejP9Q72DDfdG8tk7bEQSYJLPclL3wfZ05P31lIiH3mM2Tn2fKN
         R9z/BMu6Nn8MTGDv6Odn+PTcatdFjbkVKzRQAwD5SxHiiOySSm5Vv+5M58bHNRmzJzl/
         xRPw==
X-Forwarded-Encrypted: i=1; AHgh+RoAl65oToOioujXxi29CVcWAOx2sfsJHGv64HFdNxyiWJjH1RU1KMf3PZJtzUQbR8tEGzq0GljFYbPRR8fVIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSnFfHeF3/GZ3svoejGpEK9e5RMV4mNYWb5enXYe4MaqPMBpLR
	KaA2F/LEoL32SLo9f+YcYHiKD6v3EKLEVQFKcqf2sDGn8+3rYiF8n4K3
X-Gm-Gg: AfdE7cn1/wVoIPdRpjuFyjfxjEcYTafIpnwmxxeYKSMDqI53ovgpHE2boHJtCgmk7No
	99rWuf82PNtE1IelFeXJAQ9Ik9CWw1wYhSCSWNdqQ0dSQ/ackLWv8M6E0h7PAaTjyPxk1l3eNR6
	yczhf9Oy18eBWwbpwLZuHk13wOJu9mwGCivPZKlpmaZSlXu58zZKAtsoWUOlhIB+N0X3ak/PHur
	81dPudCTjIixLnUktOt1HcK927BBnygja2eJahKgv18JSHtoQ8ok92/csQwatiakshdZD19BEf4
	EiFf/zri0JqCkWEBkDk+yipTjYHd5LpqFPmz7G6AzvLxnoaONTEZK3Dl+rOSbPxIXxM9eDsNIP7
	42BpqO9lVnvqkSGjT/kSdnLi8L7A5wuSOm6DIoag1b3xAs+nriAHu7eAWNisOmxM8rnyGO+l+Oe
	jutPhQ
X-Received: by 2002:a17:90b:1dc3:b0:384:5b5b:3465 with SMTP id 98e67ed59e1d1-38e4b5792e4mr3066215a91.29.1784298134525;
        Fri, 17 Jul 2026 07:22:14 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39de785dsm3009325a91.4.2026.07.17.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:22:14 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Date: Fri, 17 Jul 2026 22:22:05 +0800
Message-Id: <20260717142205.103515-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The protection SGL path passes the result of vhost_scsi_calc_sgls()
directly to sg_alloc_table_chained(). The helper returns a negative
errno when the iterator is invalid or the request exceeds the segment
limit. The negative errno is then treated as a very large unsigned count
and sends the request into the SGL allocation path with an invalid size.

Repeated malformed T10-PI submissions from a host-side application caused
memory usage to rise sharply. MemAvailable fell to about 200 MB, and PSI
full avg10 reached about 1.46. The OOM killer terminated several userspace
processes before the endpoint cleanup completed. The kernel log included:

    [17036.451028] Out of memory: Killed process 2345 (systemd)
    [17036.493325] Out of memory: Killed process 2349 (sd-pam)
    [17078.265127] Out of memory: Killed process 1793 (networkd-dispat)

Return the calculation error before setting up the protection SGL. This
keeps the protection path consistent with the data SGL path and prevents
the invalid count from entering the allocation path.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Cc: stable@vger.kernel.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d..8486652fd 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_scsi_cmd *cmd,
 	if (prot_bytes) {
 		sgl_count = vhost_scsi_calc_sgls(prot_iter, prot_bytes,
 						 VHOST_SCSI_PREALLOC_PROT_SGLS);
+		if (sgl_count < 0)
+			return sgl_count;
+
 		cmd->prot_table.sgl = cmd->prot_sgl;
 		ret = sg_alloc_table_chained(&cmd->prot_table, sgl_count,
 					     cmd->prot_table.sgl,
-- 
2.43.0
