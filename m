Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473C41B351
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201223; cv=none; b=oyI1SdlrI2shz2TH3Eb+a8R5rKE4bxulXo1+lpnS6vw9+A/NTGUKAd4Po5h1aVqrjMmUCK9eDYx6UTLWMQ+XKfZqGlSx3rgVztJCJMp4UzOx4HTk3hAJqi5YrkzzM6KkvinGf1Yk6+x3iwIjxzLk/UgewJEs8RQ7yeO8c7mmi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201223; c=relaxed/simple;
	bh=naazySnsgbjNdTcLsULUz0vZIulmBOcrahnhbXYjagM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A03xWoOO15OGzod4HD+jzbJMPohNZKshKZFUYpjpp6WNcI7ITODkBWrUhAugM1Fy5EUu7u3bSvVMBIgLX3JhTlDoriOIfSfoUmyLejI/wXKk4ryDWrtvb2wtx2vnKAjdI/i2yFzJ07YEXeVHiPmN5BH7osNEE0koH+v/1OWieUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kq1etGyh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=He274Aw2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq1etGyh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="He274Aw2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9kCgd3945775
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9Pd
	TKktztCg=; b=kq1etGyhNt4m2E6u7HdG4M0LhfYmMYMjrKzNb/KwO0Gociue2Wi
	RJrAsblaFp6itjPUqm9dpIIFIKLwzPyMjVjaHsH/31s8gLCWQTgS3EPduYHxYTb2
	SSlsj+WdzQnjyM90Z9TDfzWm6ZSSmS9VlKn6K2U8vp6EqGDy+SrlXKU6MeItboHf
	6e47c6r+Lp3f9Cgvv9WNg0yEI2AIhIDCPWG6pR7VhrctHW1viqhHTtCUJI0ZCeLK
	go4IA6l5X7uYe1IhTPqlKKJqOXED5P+S4m8FZYF9bjBgJwa2yFgJ82/iUSdPt6D8
	J79wJiETN+6/etseKP0irCCgrfGScEFjECg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x88sm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:01 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d596a5c9a9so10393510a34.0
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201220; x=1772806020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9PdTKktztCg=;
        b=He274Aw2SCaHCQ6t2vdBpwKKYp0lBpmyAbNMiw9I4PYIRvfL1SDQ/Nb5Wqz0HxZVbx
         5pzoS67mP+mwG0HPmSRffyLQj7oge6HYqPoxYU2GfxB8nJ+bJbTawpiBJ0v+NM9X6MKf
         I9OzU+AZX+GHn1FZlHGDQEhR3UizLNos6y+7C902N7PG3I22CNrWrQPn+82XOMfUeTNY
         ZHw3u4FVvigqnzYsNM4yE0hp3AM32VZbk6lBjS8vbF3zFMAD2G2LlDc6qKnsGo24kkVR
         JoDYVZYgt3hDMxvmtP0obUQIzfkd4zismvFGqGoG7Xl/tLjIYfYHpv/ANfjpOuwuBLmd
         vbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201220; x=1772806020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9PdTKktztCg=;
        b=fkPKaHbNrWIqY6JfKwlZhmwTRDxiTmU7k42bVygWtqLwvKQ66IjbmxpLlhKf5gfuYR
         4ljxUSJzoStTC0pdFdE4Z2fL5gGNWMoAs6pATqLYlYDQpYRa4vsSIxvPJWNIBhnHuboX
         fNVBJfZua31CC5OcLmhv9jjwD0kPDK6NBlIN7vAWq5GJ7unsJ5i+H9DcNZR46la5WHBZ
         oaxiqj+sN5+ow3LDYuLwWlbOLAuMPS+yAO+l20PA7hfURtYCwaPtcR0R6eTjygTTOk1v
         Td7O5vs4LQPx10N3l7msFjEI5CnShorqElNpHgRnWSXwKqRYw1GZv28S9geOPKK6/uc5
         73Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWt37wL89000fs+Jf0VgJRViGAeIyxNa+F4hs+sK6hoqCF+MXpufekJL9Hol+pXZIWtRCkZcVVlrHgVy1r8qA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8YN2YFBIqBWc0PO8LYFvJbcnFJiF0J8ZLasszeNygb60k52my
	XW1WGYJ/hr//gpFVPRk3UXT36tVq06d3mwIfHfkeK0Y+EauCU5w8uJDCzZ1PLilaOTo7oYCXjo0
	UrP1TZQX+57nHbysVxLPXE87gfHEq5ShDSkDJHYZrFjq+Qw1E+0n/X9x0h1TAAzaFZP+XpA==
X-Gm-Gg: ATEYQzxcdDMGLMduGOJhmFRBdcmqZdoMmx2XPI7hYAJDjSfD3lV2xwG+NwNjGSinUlU
	IywamWcdjqyEmxTEPwPHKC4uOLEoohq387SBv0gUDM5bCUqd4gF9Y5x8TY1fi2fEz7D/6Eaal5p
	6BNzBwkAU6twaFdWrPaR9jFPFbqpwUbziQtwhO4pc8mfcooG/Y2J+A38KdIHRT4v/s8z4K3Aoyo
	jtl3eU8n9spMD16nusAAuAciYoAHWoIVrmCMnsJpOVs33ZBWwzoDscaiPVHqhVoberFLaEOwXL/
	Rz+lRXk5Nu/wncSuB943PMB13OAME0dfMSIcdlXxvlJnr/xCc9n3Vz+zJk998t2Vy9Q3OIn4CJm
	YjC1zKr2su1Fbb5XkIH1299TAnK/Wf40dMpMMP70yseagERQJshbH8yzjQRli7NqRRzqvbrKrDw
	qY9HO6
X-Received: by 2002:a05:6830:3146:b0:7cf:d7ab:bc5d with SMTP id 46e09a7af769-7d591ec617emr1870658a34.15.1772201220531;
        Fri, 27 Feb 2026 06:07:00 -0800 (PST)
X-Received: by 2002:a05:6830:3146:b0:7cf:d7ab:bc5d with SMTP id 46e09a7af769-7d591ec617emr1870621a34.15.1772201220051;
        Fri, 27 Feb 2026 06:07:00 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:06:57 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org
Cc: mst@redhat.com, david@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Allow order zero pages in page reporting
Date: Fri, 27 Feb 2026 06:06:51 -0800
Message-Id: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a1a505 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=9ecvtSpfVrh-a2M179QA:9
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX7/Sx7wBErmSH
 Mbvr5VbkRo6JQNoQY+g6zfH2P+bpuAtlyXPPCSQV3OARqk/iCc3c1Y312VBBgR4m1sNuM0ZrDn7
 q52R6h8UuEMejzFmf8njH1+D4RhYLOOpf7JUwk4E4pncpRiAreLoDjHiYZpu7qOUOVA5LwpP7tQ
 y7PB9P82IiEPt8/ie6e3Te8xDgyQSMx3g3I3X2HXkg2dM1R/ph8aGngR8JCMgapK3WyipOVzumn
 A4E5LVZH/EetxHv79gp6NX04q6ODj1l6F9XOQMQltUs+P7QNbwFGuFj1XvAsrmDgZdB7ZbbNvGp
 xIkhUDSAcD9HdGtAi+b9pkoL8HikHYw9Q/JPL2enS05sUQYyjxeg+VtUFWTeKSkiXLmTBgTRibq
 L4Wtdi5uMDKvJhX5eSw+2t2G8XZCzyz0/tQZQKlH/AwtqY1lGaSycWTwbhbBJqQpXyTX8LOjAL0
 sSTj+1irbg7XMxEqK5Q==
X-Proofpoint-ORIG-GUID: 9p7bkAuECi8k6Oo-vLXNJqS_dn1bK2aY
X-Proofpoint-GUID: 9p7bkAuECi8k6Oo-vLXNJqS_dn1bK2aY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Today, page reporting sets page_reporting_order in two ways:

(1) page_reporting.page_reporting_order cmdline parameter
(2) Driver can pass order while registering itself.

In both cases, order zero is ignored by free page reporting
because it is used to set page_reporting_order to a default
value, like MAX_PAGE_ORDER.

In some cases we might want page_reporting_order to be zero.

For instance, when virtio-balloon runs inside a guest with
tiny memory (say, 16MB), it might not be able to find a order 1 page
(or in the worst case order MAX_PAGE_ORDER page) after some uptime.
Page reporting should be able to return order zero pages back for
optimal memory relinquishment.

This patch changes the default fallback value from '0' to '-1' in
all possible clients of free page reporting (hv_balloon and
virtio-balloon) together with allowing '0' as a valid order in
page_reporting_register().

Changes in v1:
- Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
- Make use of new macro in drivers (hv_balloon and virtio-balloon)
	working with page reporting.
- Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
	page order that can be requested.

Yuvraj Sakshith (3):
  mm/page_reporting: Allow zero page_reporting_order
  hv_balloon: Change default page reporting order
  virtio_balloon: Set pr_dev.order to new default

 drivers/hv/hv_balloon.c         |  2 +-
 drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
 mm/page_reporting.c             |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

