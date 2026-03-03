Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070538D00F
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530435; cv=none; b=WOlcpcATecH0/MF17c0tEwptiDlcfRvaEOnVzBB9AK/6Il2vTRMFXKJWhgI00FyP/xz1YXmA5urB+zcTolkSbsfE2EfDw02Ls/wUUkjXHQDpULf6oFJdZJTel8T0LokJ8Ap9uwmEZWdtPZuUM/R/WRZEEC4cCKxFIe84KuBW0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530435; c=relaxed/simple;
	bh=g0IFKDbaVyFX/mq83PnPwWEpsddcb7B0V1NVF2xNyoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CACod4Zkjx4LWlFLW316ajfeWouOUvXavjNHb5yz8rgNcDUgE6h5NoDQdzKFgopv2hC19tZZcfwB+2WCR7laFlkgipTDTvj0MWhX2XsegY2pLI9BZpOGHwYGGMYmTI+TFPBUo4W/U/Zrn5WB7+IwPyrJByDIPJ40qWfqX8VT9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0/7P4l0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fk+4a1h4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0/7P4l0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fk+4a1h4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237FjxS3614687
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LfGWmgs2oNU
	vnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=; b=b0/7P4l0FVPZuXBYQuwzeCwqNUZ
	Ep31sNDYK9bgVIfC3Du4RO5X9MSRV+kJCx9SnMnFAzJkYIMyX0Wc9IB6bnHZ6kX8
	5NUG4RhdTcHs+XKFBG4Mg2w7Aofip4E7t30mb7lMFPWIk02WiyARFKPqDwOqfX+w
	6GtipcZg6sF4mE+LPnrcRBT4vjlj75XhjRv07Pmv0nYWqrhvGcIuclYO+5jwAZdT
	TV3llc/AGVS1NgpLvPmwWM4AZx+a6wyCRScDhghd/8EtoT3wa9lP5P93j7IIsKZU
	PPdccLoJhOyhJi7ZdiCwVPGgWPGYHEWDGWk6aG2UwYoKC/s8UYSXJWcPiGw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnu3n8f7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:52 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c5ed0942so77550768eaf.1
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530432; x=1773135232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfGWmgs2oNUvnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=;
        b=fk+4a1h4OTzK5wVFDLdL44yroIg2fEku3xI0gCe2tbNSwszBpMTuGfld0DSmv5O1nj
         y26ObfiS657mYCBeVL5G8zuxu7Xv3nUYVORsb0pRY4C6X5fihZfjOyj0PlR2iJLIVSn5
         nFU6XqLlYo2wV+P4+ZLKbgene1EDaTtRd2SwZxwgspoiVB5mNHekOhwrjXjcp9gaPH+2
         rKLk2UCHlP6xH/JCrgp4ppDoCWTwjcmcNs7rpmgFDHNBPbzHCr4EIX11nZ1eBtnBjHpm
         TKl+qVzPXyzSsnlZdLAqnT1b1NX5ucK+OJK2bZN5HRpDmQeJ3W/9xBVJAKr/dh9G6KE0
         lgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530432; x=1773135232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfGWmgs2oNUvnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=;
        b=T6zsMn3blNbbGA+HlIux7c4H/ALJYQ0kZujLkmCx7AqCJXjXRGAHe0kB0X7kbetH8m
         ixm7ng7Zp8EzSprjcgMVpnZacSmiK+phHeWCnmd7WhsUvxaYS7DoAHhf6MUD9BDKoPvJ
         kl8Psvot65ObIoZ//TT16+qlKWLUsr9ztTp+IekQf1Gb44p9QSWYL+tmJHOC8NQTMUQN
         htGDi8pQXX5y/9dcwsrg/Tcq1w/7s8J2346gqIrC+fySZvU8YBHTdA02z1C/QlB4DEjG
         yO8p1mkIHaDoHJF233Zc89CPz1pzgMVz6y7JQDotb74jPkxSyUxbsZMxKEq4LCZ05m2r
         DwYA==
X-Forwarded-Encrypted: i=1; AJvYcCUExp84uXGNuTp+BbUdSVPp0F6DYY96ENBofB1ZuzzCxeoWJNRHgyVTFtk+Ncdo4QkzHAQsO9gNq5gQ3prziA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHH6vjlMvArKXN0qfeb2IxwXkJvcfbi//sgM6IyMzDhjOzHZjD
	LOPjhe/GybDAUZjpyBMRJay23yuI/mgGg1bfPOH927RI7ob6Ltq5sjBYm9zwZs/p8vyW3M+6O2+
	SLbsRsrmxZET19RF/s11VsO55GBvLPT3UbKvTfE1svJw/Y1eO2cvodJj29q21QMFlMfuJYQ==
X-Gm-Gg: ATEYQzwrZjPwxDn7lgnOZ4H8EeBs64lWnSMIaqKIfY8zG1b5pE0oDuFo8ngRclZuSWp
	Fzh0e1FGDJYOSM/pvkyHstQ2wqc1GiElZ0IkMXXK6ju7U3NZBoB0BNwwAOiPqdAnU8878WSUp+L
	o6M4lS7Z1WmhW4OPjeXaHT+B3V5b37bbzb6WFn+KAcBHI6W6kE3QBYegeZKvTHSdVx5ZE9JZwK6
	vUZjgV6jtWi6mneW3JZX6dmdXklhvnonOvf5bze3Z8tnFsLzXo/qjjjemOP6ZKZiV+mWj/6T1qJ
	RqEqoJOMPmBXm92kUbE+a9t+YZErPMa2QazoWsqdKc9y7GlQk48dLeqjhSnZjcwiCfwVewugLnz
	bOvHxkYx5yrGN3sI66QvXnkuV2SEqs/5JabU1d3V3gaPTtncLz1mkk5Ubj2AxLxgvP5dDyjb1pl
	FqiHDL
X-Received: by 2002:a05:6820:4b91:b0:672:f683:7c54 with SMTP id 006d021491bc7-679faf9a246mr9755954eaf.69.1772530431868;
        Tue, 03 Mar 2026 01:33:51 -0800 (PST)
X-Received: by 2002:a05:6820:4b91:b0:672:f683:7c54 with SMTP id 006d021491bc7-679faf9a246mr9755930eaf.69.1772530431435;
        Tue, 03 Mar 2026 01:33:51 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:50 -0800 (PST)
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
Subject: [PATCH v3 4/5] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Tue,  3 Mar 2026 01:33:40 -0800
Message-Id: <20260303093341.2927482-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69a6ab00 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=6q7Fjfde3VlTRWJJNBIA:9 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: uoD1nEIUmQy49uvxJsZtb9ygXuTiUG8Y
X-Proofpoint-GUID: uoD1nEIUmQy49uvxJsZtb9ygXuTiUG8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX4T2MDNZaduGx
 Tgtfk7e0KLh4p2T+bj5PabpQAdhMgJhj3ezknlvuYiAvD1r2W7kLoks9tEowHyUcMy/61/ENp8w
 chxK4anxOWcMz3unp5bwjhEBoOOW/5xwyd134UGyDHcddz//A9bAO+/pZbsORfbuF9l/gnZE8Xj
 LYIocf641fKJMPYiZ1y0OTAJTLGtjfwO13nAeqJZLRyWe7MeUuUjwC5mNGnOx/o2Pzgh8dlzLZ+
 n+GCI2AC5mpbDjb8Q7G509K6PAjHFF6iLxCffnvGwUl+PSXUYCsXqqdedZoknhMyhqEX6ZS54Jz
 HKVAsR1m/yjkQxnflD/RV09SBcjwenQc1pZhlAyaNvM16n68KwR6BfKnYNPqAZh+/0uiV++/k/m
 ZP5NSy3H+ALp3TeE5YuOvTnyozJ+g7Pdwc2HTEWxU41fOncT85CUavCsAVhI/i/GW8p6txA3uj0
 V97cZpcdW+XcBpdhvfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030071

PAGE_REPORTING_ORDER_UNSPECIFIED is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_ORDER_UNSPECIFIED to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index d1886c657..9d4ca5c21 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,7 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
-#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	-1
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
-- 
2.34.1

