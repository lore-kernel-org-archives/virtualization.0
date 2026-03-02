Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF135361665
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450287; cv=none; b=XjyHbqyIbAdHCHn7UrnyZNX3KBTj71fBQ78v2sZxkyYFF6wLqxXXrddWOIxQHzJxlCH6ybrQXQEC52Mrtt93bhhrBPwzdXsys/5Y7HGRgv6HQB9p9phBaXVvFiDMGpVHdV6tNFqsn83mJJdnkVB+wUzEFTBUcaLv1aime3H9/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450287; c=relaxed/simple;
	bh=scaxuEdemD777UDHldqGf5u60vNPBgT/Kjx7liEpxUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0/ZH7WnHY3gNMfBjAh4cUD9AUh99fXxe2Wu2p7F7IfOcylimNWFORcFQwFiTynd8myCLWt6CZuzy7OCdV3fnxwBU95G0LKjpH7fexGbtFoGu6h9OcQii2NUbxjr/dFTvDvD/o1cG6mGgVdoS/vNYZ2ktp6BuvWYQ7zjara4Umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLOkFwV/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Clr42f4d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLOkFwV/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Clr42f4d"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62281Hxv356388
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 11:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L+0kgesUCMd
	NFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=; b=NLOkFwV/qYS+iMo0DscBtUWTvxW
	uynYI7C9YoIbmqZ5kSpLlMNbm7xLMYD6N1VtE9isV/qfRXK/6B6xPOFIB9+k/itc
	F7HyggLQqqUEkToi4Sq/dFUq2Fs9Au6In8tY6kPeJGw+6G3TfGzeg+J/UUGR3Cmt
	ZmDJiGlruKDuiML5aPWAhwE6E8tuL5cxuIDsOYMaIaGbHNKn5dZIit+N+4U5m8U5
	tNOiT2l7HG4wMLL8QpTY1Q/F4xXayEsyIpZvXflvaUWt1WPh0kT9H1enSC7BH6io
	oCPO+453jF7rhTW0Yxn7GmqOrzmlHGel7jGvUfvI7RVJxwc7cDSVtZVzhIA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw64a4d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:18:06 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-463a7f204a7so54140352b6e.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450285; x=1773055085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+0kgesUCMdNFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=;
        b=Clr42f4dIFX5h38MkIaA7ISxbxZIkNHxIFjoMIB4+Re03E8n3d43h9q6Shm/8v1rJN
         SxnuDWlq9paYa5tZoMtHLwFHydJ8AtM8g3a9RJX77F3tzXhMFqGH7+fiMkIqdgaOCSc7
         vxHYd0ZTcOkVZl4pQc/ROeWNV3X8Zhi6T9J/NHW+ME27G8Wo3HwgM/STtIkl64YBSExw
         3KB984JJLhNio9SoPrEAyxRyOs926Q5c64Ihq5HEig6R+wBCIk7TYxWfpUQMRMT4BS4q
         DEFwEVdhYxX0WUe0bq7sdcfV1odk0fiQw9IlLyJhrH9mVfJ+GM7MeROYPVQzBkD+rift
         TdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450285; x=1773055085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+0kgesUCMdNFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=;
        b=UqMHk4aqkSJX3Hc+s3Qnhjv7Icl6NUz4nYea/rVf2tqqAslRMjmRHVFQUuwzJefoxH
         110jhONkF2wuflj7PvEeWf2aMsdUSCkNspQNff5NBrz+gIaGWNuHIrHFwEMLYeBHnEPy
         7H1KtaeQJU2AlypdmPhfAn4pKVtGW4f6SoX52NGxCt3tOiWtPOTT/XXeGhj+XRJM5x9K
         CbhjINblDsLpd/RTlH8R97wa9s4rGtVXbPLXmGj3ivY9RzdkYivDlMfKiWW17MUo4MQX
         DYMBMulfAZYb3naTYzpHrQ189EtJqwELIdabarEomCSSZIHRiXNPTlVKFN/iZAuGeeoS
         sIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXvYJem96dJZzE+ZS3enVtW89oh1hrCZ0oo3pGSnW+PN/6iRLfqPvCcQ1u9FS77NCmN4zvmoxT46cANGfxVZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6iVLrKgz9zeIxURb/IU/0WRC3vz9PX+vTPKFtm2TYfpi7Hmm2
	38+Fwgj5NpAtPdr+FnQQ7WUXcgOo0rLkmci873F3w3ietSF8UyYU2n7NM2gqrBnA88pU3RMeD2A
	D0IGPszxWtYupZk6P9egQFpPuOMHHgfQhMf9Hc2ylyyW9NTaGqloLzaGvkU3UIal1GG6KBA==
X-Gm-Gg: ATEYQzxcMh6ffglnML+31ysew3pAPMTJLqD3++GlnD82joRfNHhwFxCVl/yW7wL7LOP
	dn4ODE8aypzHXxT8E8b9O764dRp3TquK0AusCmHwKnbECONb6oGi2hIz+HiM5+H5uZPM7KnzbWM
	m+noS4LQCLzjLPdUaSzSxJs5zJ3oBIv2pZ8P1o32uvQy+Jn/h6to46wdvn7y0YanNrG5ICJQC/H
	dVJk/uEZf2iy7N7P6nFfLi1ZwBVCVNWbk2xt08npJ2r1DnCBSpS9tv31bz8bc2FprOYOB2G5o0V
	deIxlmQz9gRpFZ/UJG8CM/yMijAG7oIFke3006e2wtjYdgsTYAeuAuQ7AtHWlFSsRYgr5ZZELIe
	f63yleTfarfe2mEQdtw4GRG+ykuvzNucNZreHbvN/ZN0DYZsujnD/TYcaQftgiWN4qLxPx/7vJ7
	hfPJ59
X-Received: by 2002:a05:6808:1999:b0:463:4196:3d3f with SMTP id 5614622812f47-464be922ec0mr6157830b6e.7.1772450285374;
        Mon, 02 Mar 2026 03:18:05 -0800 (PST)
X-Received: by 2002:a05:6808:1999:b0:463:4196:3d3f with SMTP id 5614622812f47-464be922ec0mr6157807b6e.7.1772450284836;
        Mon, 02 Mar 2026 03:18:04 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:04 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org,
        jasowang@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Subject: [PATCH v2 3/4] hv_balloon: set unspecified page reporting order
Date: Mon,  2 Mar 2026 03:17:56 -0800
Message-Id: <20260302111757.2191056-4-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PRm8FMiKgK-nt-6c9kD96YmMpzGBaq2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX0x+oOYSwvGHk
 aRINTylgXOA1GSrH5Yi5v0Nwwth5E49m28uG9UYa53obrMKeivDpYIRej55mV/RGgYhrsjTnzA8
 JFxQ9HlWH0x36MXlKQ67Gd0M3sJ3eT6tMiWmGHlSIPIFKKHYf/jPGbwn5rOfT4yA0Ot2j1ndK0U
 tqZs2HeEVKgi9e8mHqn5Sc4pXQpHJyq+1YViznQpwcjYTEECywYvPB/4paTy0U8SVUCtnnt6lPt
 iMPWjKKDPr0QRVjf4cypQhn7OLnWXCwwJs3Nj8nkCliVSg9Dyk4BtJ4THZgLp940T3jCF9ZBUGe
 fRpRVePgI8gwEnmL0thIhLXmHab1YWJ8WSVtEmj0ONaqpfEoKvdJljm7UOx4PKO1Y7b2NI6wMP+
 dYwHD1xYsqJosYHtLukGpz3Ww+4he/K1HcoUpXHyQHS5kGWwATAxBeXQQz/m6LSjOnlOhg+gv5v
 pLaOh6ukljuFYbpdpjA==
X-Proofpoint-ORIG-GUID: PRm8FMiKgK-nt-6c9kD96YmMpzGBaq2m
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a571ee cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=yAl3Rinrq36N4FMOn3wA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020093

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

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

