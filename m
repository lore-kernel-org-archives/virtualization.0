Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7C38C43C
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530429; cv=none; b=npxn23ztjOxHZ5KW77j46xuti25OeSWrodd7FsfuPyXPkIozfMLjwGQEoPSF/koBEaQhp+mPOW7y7ySuz3KUhDgmlh7fzfA2L3C25jYEbC9vsryAJ2GfAhCayTGRjd4nETzy4uyfM3x+aD4iK9qpD9nXK3w5rS9Afs7mZggM4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530429; c=relaxed/simple;
	bh=wOBwbbCEwwaqId+Xz/bRQyO4PmCTMWcuZ1ouSKxi3+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/3/mBO3RFije9jvI0ywNrqQR+eO44j9es6rz1rF3KTeXl1uDAG+CufVzn7GzHbmS7Sz551dm/xrkaA+m1OD3CueQG6V4FpHVWxa4GMw0+bYqtqFRwtPXmy0Sv+QaYaEF5YwcgGpBXFelOufT+Xg98DeCP1vgzLzHsCXoihk138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJ0tq9jf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KJMqiLTy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJ0tq9jf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJMqiLTy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235V2iY2197130
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CezckF6fL+Y
	K+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=; b=JJ0tq9jfMstclY10VCwTW9P1ptQ
	f9m+RBSQy1XsnT3+jgUuRjk2wkFP9XnBu7C1iHr/sbRyOAZz6yjdYetGKX/YuEUi
	ShjsiFYNUxlJLhf7Ht2NtdkYKjKe56SO6aupKdf/dlR5ryC9LixuE50wc8Aq5b44
	EXSgYTgnXGWoZyZgstaIIVGg01CAk+T+pDhaVQdzGE/YY4o/0BHeDbXg6+PJCOpx
	OcL7jTooBMz9xbTAQMebBevY1OIsax2Da9oY9QW321ysoOFBSlxaW+/zlPgctwCf
	oLD4vZfoDqzEDhJaDIeOuBIcJ6iLKh9FiEOSeeoNUTiTXXA/9LUEjqpKTPA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnsjm0uwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:47 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4cb5810a0so38690720a34.1
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530426; x=1773135226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CezckF6fL+YK+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=;
        b=KJMqiLTy5XktNLFDU58iniUrd53XuigDOOBURs2atVrGML68hm/F/qOKn+YCmeMeb9
         LhPMHzuw6BpYx7LfVIJ4zkSOqADNvmFwghuKNpYTQMtBVEaO3mJuHb14n9oVNTE0yNHv
         fqR+QNtz/hm8C3n8GX0tuoYYmj0cAEuNGjE29rfGxyNdlWUl3LwOXNSb+X9L23X88wQx
         Ms2/8L03hvA7gY/Oc53B13pRH55O2lvisl+NV5z4kWgxIYT3f3tvVqSYAayx6NLSMYva
         NZudPWkPKY7hvJi04QP5Yd2LJfL++WxsCWMDXkpVsW5EzgT6M+KpxViebjPng/R69yLw
         w91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530426; x=1773135226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CezckF6fL+YK+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=;
        b=qlbuP9Qrs+wb59PMEsBYNtdMnSBXd/yL+IW3H4DUlo4T8Ibsgqt4xM6gGxe4JBOke5
         +82mXmifbpKe7ulH0E52IqOp2Uox/osHsWM8221iqy7GpOh0542xBZitoyUXhKsRRuRs
         F0Wi6vRqqTNJBR3l2iX3JzRx/+ofhI45BDt76ckOBq7KN6SlK3upEicJ2+ebqNJ8FQ3O
         MFhKNEbwNFtYIG0djqHKHjjix1DzvA5gNkB6y7C31Rp/XwcxHbSbfCs08T4jGJIngkoW
         S8lM1WODj1wGZUfdByPIWV529nNaSAEbu/b8tBXl5lAoBZpScZ+ZQkoXjLujSWqcSmhT
         LsFw==
X-Forwarded-Encrypted: i=1; AJvYcCVkCh/ax4dPCYpjrDK/xWBqRfaN3cb3ozgF6oKPW0GC2/YbJjK6HLCTQ8HeD9YjBiPRAs1Neau3rG+BuTdN8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YypyuLtUdclILWqKFnWdB6NjAF9iIMZj8F4leeX+xwSWIAXG8HA
	VmT7dSeE+DJwvuFmDrgrp/6Ay9kW0k5dlSdadt7U+D+o5euEjcqVwe+l8CqYvipHXMEBV0sYuPo
	1xY5ojjEOsTHKUulqWEgom3nM0xV0PXzRKy5NywucE/U4K53fBDGIO8l8qws3eW7E5sl07A==
X-Gm-Gg: ATEYQzzeFA7iuCQ37CfTXcEfvzqTnmzCuWB/3b8rjTR7QwhE7hfM8/lcd1uSY6UfSVD
	HPveZA+jn9yBhcq1XM569mm1vbabiA5r6Iy6X2clVHrh5UIHLFRp1PQxAYMw8+Bk//PTcU7wBPP
	Ym2ylDEGZEJvcVatMGj9DbZde7fuze1w9zsp5v3JkhzzQL2KZ46BISGkBlMz6QO9XQM/yJN8Z2y
	DG2jtqmmgtqYqEoRlfxv3VytP1cgDyUuAgdG6Zf3GR/iS8ioVm7jNO9JYAQwz0KlBOzjTrX1HLK
	P6OZMPSwWWGRIG/JN2/Q4V9qLr3D0fBU+r+UtsO+Svv6fJfEf+P2Vz/JahRl3uUbVtI6livuonG
	nVEaDupHpY6KANzDHT0R/pNb3Lzb/jnlSNH8/KxNGozB/fRUPO24HeYKoKwb5Utwg67QzD5fO9X
	1JouiI
X-Received: by 2002:a05:6820:818d:b0:679:8a47:ab95 with SMTP id 006d021491bc7-679faf9f2ecmr8558582eaf.71.1772530426337;
        Tue, 03 Mar 2026 01:33:46 -0800 (PST)
X-Received: by 2002:a05:6820:818d:b0:679:8a47:ab95 with SMTP id 006d021491bc7-679faf9f2ecmr8558564eaf.71.1772530425942;
        Tue, 03 Mar 2026 01:33:45 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:45 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: mst@redhat.com, david@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH v3 1/5] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 01:33:37 -0800
Message-Id: <20260303093341.2927482-2-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FJtXPcEsDcDxtVjFSbFE22pM-lUo6K7n
X-Authority-Analysis: v=2.4 cv=GIUF0+NK c=1 sm=1 tr=0 ts=69a6aafb cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ohdZF0R09fBrv2_F_REA:9 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: FJtXPcEsDcDxtVjFSbFE22pM-lUo6K7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX/hotped+7Byg
 y4zTjuBHFllDMNM0GAoH2FJoegjm06IBTKEmk9iSLdFQUdxoKeao2wjNJGF+mu7A3OCfCe/9vuP
 iCjbGDIrGpzmZwCV9a8vYBOcBA801nby57XgGrMXk6poQCNiK2EKJN7f/6wOwnfJ77TB7lObces
 Xex1OWo8ITfDVgjDcLDmZUWIRXAKxWhIR+tmMs6EOw8mRlyU5ZwHXIa3OgbKQYOsnKbSt5xG/Em
 pMnQCFH3SJb95LTo7/wzQPVM9/ltF/U9ZyR/RfY2vlthSQH0AL9zhwo2NY9K3XuGsBHYluROBvp
 PyXoypuktN3lzdS1RHmuD2qtUcMvypkGisHuuoL6GsPSAHIcwVmVnvP7qhhMquyEa0Y78Yz2a9d
 Efs6o/0tHXdwMhbUpmvKd3iNToua98/5YkPIe7SqMR8GrF5pFifh4Gb5Zow6ogsn10x0NXNcpf7
 bmxm5SdxgJPGdgKb+Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_ORDER_UNSPECIFIED and
check for it when the driver is being registered.

This macro will be used in relevant drivers next.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 1 +
 mm/page_reporting.c            | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3..d1886c657 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..40a756b60 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -369,8 +369,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 * pageblock_order.
 	 */
 
-	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+	if (page_reporting_order == PAGE_REPORTING_ORDER_UNSPECIFIED) {
+		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1

