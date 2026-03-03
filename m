Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54138C417
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530427; cv=none; b=fctqo9HIVbJx0CDsjJVQKjb3kvsex6CAtBRQTRdus5bg+JmWfnqlKjcIqO0gyng2j7traqt8AdSslaOx0aLLSRJz3HzuK8xAbjXO2mQawLVJVVv3uDPk4ke+hmISYnCX+2tizSdIBm6D+/gNOL9UigQoWvWQkH1bAaV9ZGkt2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530427; c=relaxed/simple;
	bh=5k9PqMhpT8YU1XAnXotU8YC/eX2TqWD48lbtPVg+818=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfuxq1Vs/PG+K/qXc1NgJRraIEEQ1Mh1I3JUzS6VcGAI37sMVROP8AiNQGXjQ+FLuMPVHMtAK4BHUYpsOvIMvoUymxelqPIiEbXTNZSKWc1+Vr5XCkfQ2cZsh1HriETqsv1s4LMFYxFHrzoINT+e6qey0L870bBvy83y9saQ0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpjBQ3Uu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juXn90d9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpjBQ3Uu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juXn90d9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235s6dX2207878
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1
	mPomm33Q=; b=XpjBQ3Uu12WblyJhgX+AvwyVf7GKvlvTqaofR1Iuo+GTx3nD7pu
	zJFWRN5SbSyG9B0l6aDuGUuG1sIjGgJPz+MZ3CohbG7S1phKSLkM6qImDwGWRFWL
	Q80U9L2dBCyeK1J1xHTKkN9fVfd9sdby+E6j0e9TUHLA1WiBncK6oJNXbUe4mEhp
	DjQ1V1d5LcsrOZu1/JP/If03TazDsvUIomCu7cZwva0F1LgIM4j6lC8wbHzsxOIE
	QQ0MwC13PJsoxjpCuZrKuEVn6logXsxcdwjPEI0A+XgMKblxAKfcWo8+yrDwcWiX
	72P7m+bs8bpIOSkOWdORSfP6Z6YOJam6DWA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe0qt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:45 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c1b9061eso64208559a34.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530424; x=1773135224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1mPomm33Q=;
        b=juXn90d9Qaro/a1SI/Jr/8YV/fngIcjaH4ZtK63a473YrqV+1UQzn8DAvNffIMCfKe
         T8NFQaCpdbH+UYp80yU8+5b5p1c84XilCpoxvb1MW2qEoLW4jiT6c/kvhrTUecu6Elsa
         EMAPBulRd7DB4+ksPScvIollev8E3JoP2vb/Zm+nB0Ce5iVTJOiUaT83XCq0Ga6MpEkI
         N18sRuwLMVsKQcHggrGYeQ5h2t6GcN+akTCx9KWBwEwzrpEL8Wc7Aryb8oBSjI+B3svk
         dOocgL0XlV1elZbFJ68JH1oS3gWGg4Y+DYS4mcpd/gbJ8upfIiCVe4TgDM3194Zsbbr6
         EkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530424; x=1773135224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1mPomm33Q=;
        b=lyAdg52xk07ZKRbPvgI/WnroPHCO9FtDar01/so5voUv8/EFSmSN3XmMpwBbwUdYs8
         8HimK4xlZYOyqqduahQi4fZybB4QGkPraT96xnJB8W+UREOLj0ii0nwUm5wdu+RjLB7h
         Tz+HJszId1GinVVC8NKkafJzREAcnCeujtBLfgmG9f6sYuNyAXtpA/1urOWSDsUXkqVf
         XzZfP5iOcg1c4loKMU4cxWf9kuw9epWLKn2ryVAN/aAG0WzeVKCyTOwyPpLyItiuYmBh
         qGENXyURbJj2KJFPZGrT//tDnAUs1zdvo79yiZIjLKfMk0Tkqw5cOMBKdr7NWxzLalh3
         yiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZzxK3APGjaCxySZoukhZ43Ur1dZGROOI265xqJ9bU3sRAFfXtX273052/PvH67uwQRcJZ/TRG8kYbt6uYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaKlWB7VndrcjRefS5g8dHdIcdAPz6kqa5/qbBVD26qzG31ozB
	dj9Edn6YISKzvSjadF+/XJPRKom0fRyV79jZ0CTj2ySjSBFb9DucMNG/axV/2FOaw1rSgny9/fX
	iSg4h+g4u6rkLu6uJMNkl3k/AMmowHigosB1zGrf//Vru3ibZeBr4yAQh+KRj2hyLb6W+qQ==
X-Gm-Gg: ATEYQzwpHboLuu4b0sQlaaurP+kZpyQJoS9jAILILZT4m9Af+N+utng/CB5W/HaoR/l
	dTcpf9RsOZHrkH41LDScJj7inYr0RQ+4pyDUbEoz0lEhKM8OTmArjTiAMow1rCHbbHKevgEQHae
	MjCkiluMabEEXsFLa6BvgC2+3hdogf4lbe3B11sk93RIHLK2br7KPWl7HurFaTtElcRQWSVZFMO
	O19vVdyX3Q0JAXpn9UrGegsMCsVEd7uW5cPO1li6nI5QaGBFnzN3o8JKLwxzmFhtCrCUs4AToUM
	CreMQv4kCfgQy4jKeLgarwl1ceKCpG9ndMknZh1NeXE7y2tgSOWeQ9DmuR++qRbFH5W+gV1P4V0
	nop7uVDwaT736ctoHbW1BJKLKa9Zb9/mAPdFUlywtGNy9AzP/ZMQiSNfsijn/ipwujhtEKmwMjE
	L9zUQU
X-Received: by 2002:a05:6820:4de5:b0:673:3cef:fc1f with SMTP id 006d021491bc7-679faef8a08mr8486871eaf.38.1772530424283;
        Tue, 03 Mar 2026 01:33:44 -0800 (PST)
X-Received: by 2002:a05:6820:4de5:b0:673:3cef:fc1f with SMTP id 006d021491bc7-679faef8a08mr8486861eaf.38.1772530423888;
        Tue, 03 Mar 2026 01:33:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:43 -0800 (PST)
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
Subject: [PATCH v3 0/5] Allow order zero pages in page reporting
Date: Tue,  3 Mar 2026 01:33:36 -0800
Message-Id: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GONO3eKTKG0JQegDCGd0_OUdU-qbHlZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX6MZfFPUrjIAr
 hFKDAlP1v+0XaDLzjB4o9mGWOKNkBJMXJHO3BW3xxFDowALR70uiNCnklhKza1xzIOCkHu/lhKp
 ZdRTerG+a8790ze+nFAz+H2RF8RrV9UMbRkxlutxODxiQ/wrO/1Ka4wsBfoz7nbSaZMdkxWzFzi
 xp+Q9xeVIXAcXJJ66l/veIC3nbpjbTcfDzLPtwVhmV4G7CYHIxWPuD9ATZTOHRHbqFyfxTeMer6
 UfosaOAeAeDo/dHnVux7BTSOUZsQfX0FbjSOa6ZNYKoWiWqTDL0Qh8fFPrC+78ggh/v5GISR5Eu
 0qEftHg7rMLlQb7HL/3vvUzlSfTCOeHvA02avYdV7uwjVx6D4LL1PANDRP75lCJDT632An8/i/b
 KiN1621NqMs63EQu8o3yF/KjOkN3ACTwWaTwdZzhEJH60hDX6MOui4bjh00NeyLmgu24+JH1ikk
 xxAM/L+IgObsG+bUtvw==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a6aaf9 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=HYTG7BDJ-qdBC1FqdxkA:9
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: GONO3eKTKG0JQegDCGd0_OUdU-qbHlZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071

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

Changes in v2:
- Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
        PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
        the situation where page reporting order is not specified
        in the commandline.
- Minor commit message changes.

Changes in v3:
- Setting page_reporting_order's initial value to
	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
	PATCH #5.

Yuvraj Sakshith (5):
  mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
  virtio_balloon: set unspecified page reporting order
  hv_balloon: set unspecified page reporting order
  mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
  mm/page_reporting: change page_reporting_order to
    PAGE_REPORTING_ORDER_UNSPECIFIED

 drivers/hv/hv_balloon.c         | 2 +-
 drivers/virtio/virtio_balloon.c | 2 ++
 include/linux/page_reporting.h  | 1 +
 mm/page_reporting.c             | 7 ++++---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

