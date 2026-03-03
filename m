Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95C38C2C2
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530433; cv=none; b=XsN12ppivY/YymkVcSJZQWl+b30NpQr3du5AA3mGjkAZ7tNm4op+tc7UD+ZFqZbScs6Cb4h1wFaqAQnK/zYzWZFL2sUuti/IQe8q08SfESSf7CCoo+INsSe753yqCyKaIxf2Olq0dFrvoUTvQrrGl5LPI6BcKNeVA71HotXj7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530433; c=relaxed/simple;
	bh=LbKFNBiZ+VRrB07vX9O8FknKJ9OvEGWcCKyR1m6xhDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlEms8yR1S08CAcsUpNu99RzJR2uFO3aDotgcIh58BJNBYL9FHsjILfb3du9mFqerY1D2DDxS/s6HMNe27lsPdmwaWpLQoTYkaROUOsYgzD8ptaCa5qA1Lk7zr/Ru/6CHeGVd2DR93Hh3IPm9D/mxF3vjAjjWNK1RHjEtG12Uy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhJ6LbCe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d63wjbKo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhJ6LbCe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d63wjbKo"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62352wfc3355959
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rSSvKdrdqNt
	Uffp+vZHypJOUj06k8TVBSBVgyR9aCmM=; b=DhJ6LbCePoXnCMouZMBaR1h51DM
	d05A0Z/R4oZD1dZxptQoEebeOA0ejjZSI4mfa7qiC2rxDkdvN5hJaSlOJtuQ1Oaa
	d8ITFjb8FNli8D4tAsPOkCQ2tTWHWT9yYNfaBFgoV6DRAM/JrOuqPmMkptAcWiYG
	3RYJ8FHeIURv8N+K0Vm31stgotT6Smfv2PTQMl9p8VnNRSfQTDsdjjLAs4LW44BA
	UKDPX5lKUsMIbDZY5MVppel4IddQRyvdfXMh/BXEOCUDMvJrUnEiWHDJRHja1YGp
	60jHv0fVQwNJXn/QzTqmm4Uaii384cEfsiZ7+LQxz9ExqNa/gnyGNVYxgMA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cns5frwdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:50 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c14f388eso27739094a34.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530430; x=1773135230; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=d63wjbKoaH8gifkYWnDHLwwx5btslRQWbIn7a0SJQc1ppX5Pjgj7Icpb4u9MeufA/H
         RSmniSMoong14VQo6EaBXGYntx6mZZ5FPQiLmHpOSZn+IM8bBmcmoHZ7AUFIYEk2g9iS
         pa3hHE50hOvvgzp6bQrGxf1f83OB5G6FTRQsMV7tzcV7Knz8A+72hsCCtnNDkyJ5PK1Q
         FGI5piqTctJhIcDRMVZ9Mw4h4FYct0nqMmPLsit1Wvu2yXTP66NWGBq2IcnaR1a4kszV
         Co+hQIIv/qhm23Gg8Zx8CS3BNPqKROhn2WgR+3eHjUoKo70/0uDYoN3dtm5XRufY2mqi
         Wpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530430; x=1773135230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=CkEcSxnQUBGW86G3hzpzaCfZmu4PdrUCw+9NhZU3HSTZRpSLsiFSW+fXwDSP8c0l29
         suqv4POEhl8mlmEk0aKnU0bySvfIpX24gxwGg9ffyUm2lwxLQfF5EvvU93oalWT5shcg
         MKG0fT8DF0ovMBXgN+wxAKXuF2BiUeDUCKQ+bdU5K+VdKDos/WsOP3ZBvITv3MPWQs/A
         r/NrT+BDom8I+oBtkTz5XdP4KcBVRMCeTmgfuUB/cCdv008E3gCC6IyPBk5Iqo/ugm6X
         csQ3Wvq7yd8Hk60+bW6eS3COhUwpJ+IuL7wiuMEBylvwF8DaA9wucNgU6L1XZWgZkRvb
         Gxnw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5kh0YPWs01xinPtwha1zilbS+kdF0X7KHbwEybyukKA7T2r8sWDYHMhONQEbQewszqiQf9PfafAsWLWD0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YznOlGrxFRZA9gRFWKOP2cbHyS1YbXeJXopPXPAVN7ZVdC0gM70
	E8iIf7qi8ij5A7TSzR2vzB2aUmCnZr45AaREI6klTYe7W/txxHlOrF1bOyxZH9jkGBFx3rlnhJb
	Jf2vPOGISCMw3JnQ+suYHfGEKlPAXT7OrGyYMbhPPlkRGgftvlzVT3nOlEUyiPkBnR4dvGA==
X-Gm-Gg: ATEYQzxOIjkN8WaxopKAuE2eBtUIM8gF0yHLEWOEN0ozPl+pB3MeIadrZmo5hT/CR8b
	Ukz3QSmqbQbaZM8PLmwtuAOecZwhr4QpGSlZonTF0Qv88LHrdrFELefJv5Io6sL62eOg7EPB/0B
	hjnMqwFDY7DQ2ZICqVQGE+5qqp3Yp2irV19aRh8RFN0ddGfsDervYJwO6Df7/lQA//4m87yy+Bo
	P/6XQi4LooAOZt/mJdIgxqOVld5PJ2EbEO9RB96JWtVUlmir5UFUmoN3tzsmekL0zWneeZ4uebN
	H87l5cEfao++uwwPaZMAXun0BxG3q5BoT16/XjYQoPBUDscPt9kJiGr9YiFtKFofwZOBByjcCTP
	HTspRyiAiaDSFT1yg+kNQwE4MLW01sLNIR7l5xUsZTN9VfksfFHap+1/KkdAC7WFIfjtLFFoSd/
	daY3fB
X-Received: by 2002:a05:6820:1ca8:b0:66e:7aaa:be64 with SMTP id 006d021491bc7-679faf45b78mr8277755eaf.55.1772530429730;
        Tue, 03 Mar 2026 01:33:49 -0800 (PST)
X-Received: by 2002:a05:6820:1ca8:b0:66e:7aaa:be64 with SMTP id 006d021491bc7-679faf45b78mr8277725eaf.55.1772530429276;
        Tue, 03 Mar 2026 01:33:49 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:48 -0800 (PST)
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
Subject: [PATCH v3 3/5] hv_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 01:33:39 -0800
Message-Id: <20260303093341.2927482-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=69a6aafe cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: v0gHfx2D7QCOY0Spa7nfnMlrS-m0nYZ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX7C8/c+vUz10/
 5rHfn6UITEnw3p53g80RGVtmNIzr0KvRCSOp1ha0M05bQDPmblz4q3u566Psk8c1CU3C+3nSByM
 OwSSr2Yplf+L8jH65hU03n+DLtAsBj20GqgnJNgou1jh9SirOJ8WOy/aLBN8mB1XVOnbdMTL6PE
 /bodUijfVOSflZKqNiET3EAyqLy0TtaCL/BhF5pjDM0NWa3ozBG/BRHHQDL1nF0iG/tIR/kEkm+
 Ao5jk74LfbRYkqCcLsNan7+/WHncWDVqFgNXgCnNqIZL344hPvjMaYblCM/HIivygMTDveg2Y8R
 OkxOF7fnnmktOXE1vpwD3Q9nYrzfgWOdYk6GJpnRUwNit9gvnNK/P8TSpB486gA27AxgHwLboZP
 TDgXJE9VfxaruH+GKpOnFHQG9nPSwtd6ztagS2wav0rpB0oIw80gsYxjjhFKcRAGujwJMjDHsWQ
 cSlKPnzwv63DBMZ7pzQ==
X-Proofpoint-GUID: v0gHfx2D7QCOY0Spa7nfnMlrS-m0nYZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..09da68101 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1

