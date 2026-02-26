Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65B27FD5D
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089293; cv=none; b=mpOf+qL/DNRpCv+sw1FsCDy4QAmoAgIf1F4ryxTx6QxsibWs9KqtpP9TCvsworEXwDzlDLW/JsxrxTTWOZ6hXRBZkYctQg0YgfLy2n5eA1fdvcU5dDR6YrkRhacJsZPjvX3kQHTWwq/DooCHcAf4QRDXV63raCa8zylziMWKmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089293; c=relaxed/simple;
	bh=bnoXqYVVBjkyKM5cHX/zYf0/TJ3P+ZNYdxGTg7K1whk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHnOo2nDOn8iTuWLXLy6MLCS6jGI/nLPAQqgD4AuExQR4bum4dxN1z7C8Er8E/hhLYNv128bq4SF+Sd8h+S6iSGvTNXJlgPhP5QqSCCVzEfmG6wpNy+3HeQKyKGg3K6K1uCVmLn+p1rcZ+op01LuyE6oz1lGQRpKc9ti5aY+hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6sMo5Ud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AR1Sq1MG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6sMo5Ud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AR1Sq1MG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V7Kd350077
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yKSAahOYvAC
	BfhspLoB+yDM9PsACZqr7CJChzc1vka0=; b=C6sMo5UdFEY8ev0ii8sDTQWBAp/
	Tp/oPfunqK42/Ax8V/s5ZCt0NzltP7tYJMak0mhb9O0x4k+Db+nvw++MFjlN2koD
	m6jWyTWaG5+FJIG9Xp9bXpbKfv7iJa6JhrwMoghwxJfPqeP0uxIi2H60/FVBH3uF
	x8c5KBVhevXytXExn5k/0NFMagIioZK4pQ2maCwP8ySN/K161qUDbHFUPFZzTNAo
	QypGflLzQKPNKkktw2VYtrKE6qOLg5Cm+HEi42++X1KrXalWePpDO9isiXkGSmOL
	7ywD5n5h62s/QRzgAqyInXRErUS/30BFm4JAYG0Xppl7cC8E6D1f5EvW6sA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa5vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:31 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679f6f264ceso316498eaf.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 23:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089291; x=1772694091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKSAahOYvACBfhspLoB+yDM9PsACZqr7CJChzc1vka0=;
        b=AR1Sq1MGhG78IyeYLCH9nK4m/JjU7fPg2b67pSMZGK980iELyrSVmTXbZd+6MTLQFf
         VskDn3QwYKha4HllkaiyMwpO387pGCkh2SOrK4TZUTIxAzwipf6vsQV7tpq58hKwjTm0
         Rf2HQ2i3gY+koF6SiNTiXimZ1NjW7ybePFJWCJOK5SInVRbLzv2QXRg9qHKlxc3AS/6V
         OWgZwwTVdpKR/2wcPDTGK9SIxnfw8/6iF735huSE1AqQHevVhZAHkjYFUrptnop0QdCv
         flVi7lK5OURQrhkrb6SZ/QPKhIs06wEaFV0Lf8Fgkz++B35+HA9pDuOOM7vkjPL+084l
         QXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089291; x=1772694091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKSAahOYvACBfhspLoB+yDM9PsACZqr7CJChzc1vka0=;
        b=TJ3NdsDJ0N2XrxfNUGMxeP/vvLfsXz4tAaUNKuj9Kbr+6wyzblpkr6r8gqUve5XXWR
         QHAcA4i8yXPih/8DbuygJUArf+QTxjl3wFplDvf9E+6MwR3AtR+k80P035NPcmUmW3eY
         gZomwn86ro7N6j9zyiX7oU+uR0PR3oB4XJC5PP7QjeTehSJBqPbuMVbaBt8/cT9MQIBo
         Pvobf6B0rebsBRL1swtf41FJw6lzn/oKNFM3zpIegs4IuxaUS9tlEhvb4AhBR19JeW1P
         G+83EJ6NQKuIJlwaQ/KQtfZAvF8VL5wNMu02/YL3E17vhF7thzh9yfClQhRak3neiGVM
         4SjA==
X-Forwarded-Encrypted: i=1; AJvYcCU9vqjEPxn9K8B4GIsziqBU3+o2ZmkEkRIYPjM/dY6TgozVSpZGH7GuI/1R+silNPifwhdvZ5CNc4I0oOfdJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/k5yVS2I2z9iRwE7oMtTjjc0obNXZSJZG+BjLrlk5NIQ7I4J9
	F49Gx0VmaFilLZPTr+bEclJ2H0jzrvnJk5aNrSilv6lVsEtDiEULQmOUB1Kg4S5Xhzi1uE4ZBPA
	9Ag+9ZGDFiuJtGF6Mkn3/V2QPfCpeI3sC/ydLDfoCHtZTqsDITydmD691pNm//sMcpWg5Ag==
X-Gm-Gg: ATEYQzzd8AbRDScGZQSUy+0zOGtvWpdeueAEYzZa9fuks9gPVoq5lymLMdlaBio3uJK
	JHINdpWUCSHJ/s9y16WCA5lIl3j8JXOjZ5RVxPUWPkKeuRBNMtEA7CHAolKRf3MC2s2mzuhOXdq
	N8LJmQl4MTeEqn+X2n1VbZoD9d7rISYKg3aJV8z2YH1SpNq3ffpQjAYQqDmejb45IpzYRdrfbGr
	mtqC7Pzktss00EqRpbW40JuoePoAPQ2w4HniRbbr76gQzyJv/X6BHrLXPxG/B47cI8F8FoO1kmP
	2jA/P/3rLG9HnVKrhtsOAnvktCkkiaYZrCJZTpXD5rNnLEPnfN7I/QeqCfbNHqWiKORivpx8J7H
	t3Lik5uq6pb2XawtcUt9dRDE393+0K0+YnOZpGtsVqAI0vbLab/bYITI/SUptsvYEfCkTb3s4mk
	hc4Gvf
X-Received: by 2002:a05:6820:6ac1:b0:679:f37c:f995 with SMTP id 006d021491bc7-679f3d79437mr569670eaf.37.1772089290274;
        Wed, 25 Feb 2026 23:01:30 -0800 (PST)
X-Received: by 2002:a05:6820:6ac1:b0:679:f37c:f995 with SMTP id 006d021491bc7-679f3d79437mr569358eaf.37.1772089289794;
        Wed, 25 Feb 2026 23:01:29 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:29 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/page_reporting: Allow zero page_reporting_order
Date: Wed, 25 Feb 2026 23:01:23 -0800
Message-Id: <20260226070125.3732265-2-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX4L83TvJRUE/z
 B9gu6wasVEl3aPdEE5HRFVJEICaTtHL7hySBdD8CCKK59sB6zGFXhNN5B2xvfx3F9mP2eae7qyq
 ss+XIwvOYnm4cgF1Rz9YUfUTUrL4DdhlA4iDplpEs+lgVu3dZg0UJBGhqCki+pjFCJ3MA7IKaaO
 PlrapIyegyE7woAi78LzPq4j56DmY4nsmpZXs6M5l+rSO4m8niIfMGmh08Mwt9ZxlNak3QTlSg+
 3hr4kuchlLJJPFrxjnuEWJz8hgeuv5XnlkDkT91dNqw6PfRoK475A218zLNiy/wkmORkWNbWYNj
 x1GJWFZ4c3J2XUFCaUpEThxKcqxbnpPODDFzM5yJqHx97ZoT4YDuZliIcVOCRha6E+kJXYKRz/K
 +CMvE7R2ooa+VZVJnwShrg74KkcZzqoYsznksKzAvauSbHHpSWvCwxxEfXV1Bf2QnXLydr7pl9w
 c9yWob4udlSJbRWCYBA==
X-Proofpoint-GUID: 9Zvg4MYBSoFz_4ny4nxGtLKYMB-rHyhD
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fefcb cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=oYu5RVeIbCLf98ibfWoA:9 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: 9Zvg4MYBSoFz_4ny4nxGtLKYMB-rHyhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061

Some drivers might require page sized chunks to be
reported. This patch allows registering a driver with
order as  zero.

Example use case: virtio-balloon driver running on a
guest with very small memory. After some time has passed,
the guest might not be able to find a chunk of 8KB.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..fd7c5f0de 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order >= 0 && prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1

