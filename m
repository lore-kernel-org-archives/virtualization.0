Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009647D94B
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537444; cv=none; b=EoTT/C6QUjUWTUWLpkeJ3MFFSlzUzUGchFxADk7Ekg/MhzVrJ8t46iYmcaGZwu+JesE4JS16yT4WlF66tbtH/8YP96QTKrOHveaggKZxIdnC6QBSLpbw3jEAGKNh2NGNz/7eNfX3fTwNfkW6smtMN9xbqxhAr0eruEZF164O0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537444; c=relaxed/simple;
	bh=YIfiGg54wHsEWICe5AuZdm92KWtiix1jjDHpjH1udtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEvdYTmHQtQGeIgBvEljXrYBGmNCvCzAhqA/LpWEjLK+2X7JaL0wdnLTN4D1TiblUTM6v8wBYnimvaXf8sDp6cjPCrsSj55irjbuFWeOVgsWlZnJfb+JOcbG9UW/i9J9qDXB+wN9nNrkdM2lWZeRWCunj9IzQ5R7gxjvH7hgZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbOV+ITG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TsogEjWp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbOV+ITG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsogEjWp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239muxe2736101
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7rYseVkxS5+
	KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=; b=KbOV+ITGzgxWA7RFsNR5bM1JHaM
	4/f/favWm2i73bz0g03m+FpAdqs0yTsVtyCMRuqkOqHyS/3vaNWJ9+FBVUpGUkZn
	mk9smX2Iuwo/49nl41OzGdv9EYfYF4cyVguSF0vYkGP3r/vf65p/2Yp6uAOKlo0J
	zhwb6KGAPslXzD0W442CX0I9vCNRPkxgDF6lOyrm+n1tuiGDbIxpp6ubGpyaIqEE
	bIyc39j6xESkjgt6/GSXgtVPgnGNtHSA/CgJT6N+FEnsvn6dXZnRY2FCogg05Rwa
	11RxwRHPdOEpOcK9SQZLn3N3jqQRFajN7SN25b/TUGuTOPQIC1sua16Eyzw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe13df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f16aa81a8so105990448b6e.1
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537439; x=1773142239; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=TsogEjWpNnZ0wqplNNr82DmU11kR6fs0256qnn2T6tvZ2hZMHtG+qG04ktvrfJ1ICu
         XcFHrhdBKTuvB+pSmF+TPuGu1nxHjI3TwxJ/AZNmT6orBGzdjETVklGi7bc7XWitHLc/
         u/WtJkhtSAgPXrNn8a7vYnQv3Ei3CHZ18Enob8wA8KyefVi71A57454YP64up72BgZzs
         0g/QgDe1dRTFco64K3RwNJvftRuiHiVRbwRZ+2ZfQ8SHKfelcKDEMR9KNARfqDpFJtEv
         7olc5W1VOtly+j1nWaGm/TluImZ8dJcdPkMOxpISitk5Zy3HNC/5KXDsWFDHyykQignL
         Cl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537439; x=1773142239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=SewbNyHoCr7KK89g+5NKK5OY+mj2uO3PvdgwcRy+GdHPx2Y/wGmvqr1juSHRFuUqPU
         MCj+A8RKbt5pcrqZ++Z4bJ5EiQnbOSW0WLdyabsykBc7IRQxK7zzzxSaNv3kdL5T0D9t
         qQ4PPOYo6fP8uoz1RCZVYp54bm0pWeufoLVFVeSrO1HXJD8SsrfTKWgh4Aqs9Xgg23vT
         h6OVI5AJkQUfvQ/14q/ilfrhgNHOlNiayu78cNXj/wAayvD+YGlG9WPYkophhBSNZbMQ
         1oSv2YE165jwJXsiew1yt6JNRRBxi92n1FljEwZSCrD1d1LC8BYcpgc4ccikUe2w1UEX
         87AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFGvBB8iKC+lqpZHw4hmzPoWMg+sWyhBfFYdF8/j39vOlAeM4pBqV0tMXrbRWNx/cHDqYAJuPZb8MuAWsuzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzElP9lBugpYVsf+zYSaW20nn2csHvbzX6gMRQ451u+txzb/Y4
	5e1EDe4CMUcXIqTsYD2y34wb88WGNzKtZAoF3DPZDhaggU56u9mRihEQzZqaZ4WnSlcG66ahpfy
	pRx4tTN+b1VMK8o7qoefTwRR0481aq9lLnsfaWXhdeMgx/DnmC3pIspndi7MEehLZMIR7MQ==
X-Gm-Gg: ATEYQzzbKxf4ozdeBewnvO8QhDGoKxZnCKIajSgZXQM4my0XYlxZBisgTOvxpx322+C
	+MVOzE+81qdyrOH2LxlWn+b8utDZqPdq7fVhuuIJZJlq4bEIiJFdcuOW2IIrfmVYx7RK0RC6bRj
	pn/Eq5L2c2MuJUaO83ZRlezFOcfIFZunQett/vpxju4Qh964qykEa4suY3qfxC+E/zyKCibCA6j
	J9U3VfZROPYm+pLNgHFARm7VW/IhWS4WNmmoR934v9YAlcHBXXlmtpaSExYLCXovoG+iOE08J0l
	MBhFVdbJsiBIE3OZdl/+nNRfSRJhzX2kjnUDteHH8Tu/3ofwnPfUFTqJ/qWK+FEFqZDYQdcmtBt
	dENs4hKjnbmH+EWuQuP50+ppWLMB7GkGmLaOWGLCxrhHDxeTLcSCpggvvGqvtZXiVuL19sRHqUp
	UZVhIH
X-Received: by 2002:a05:6808:1206:b0:45a:58af:fed6 with SMTP id 5614622812f47-4650c7a1614mr811599b6e.17.1772537438673;
        Tue, 03 Mar 2026 03:30:38 -0800 (PST)
X-Received: by 2002:a05:6808:1206:b0:45a:58af:fed6 with SMTP id 5614622812f47-4650c7a1614mr811578b6e.17.1772537438134;
        Tue, 03 Mar 2026 03:30:38 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:37 -0800 (PST)
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
Subject: [PATCH v4 2/5] virtio_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 03:30:29 -0800
Message-Id: <20260303113032.3008371-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GtbZsCUkG9MSxr267LN_H6eHj1TRsUbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfXzrQvti0Zjlpr
 UpPhNpdIDyDmNeafHUbU+dvwcN3uCbzNHd52S0luopsdjzhWW22sC2O39Q+lnW1ucyXj12/CT1d
 bawfmblQf24Ack5NN9LHvanIcbewR2DDVRCuNPyEU+/rmDqD3WWnC5CjEbM/LYqvyHhEzSjuA4G
 ELaUIgSMQx/kapqMeKCViiPXzhNsLpUq1VRU0t126ObTZkPT6ttgJqr/RWwQg0C5jeNdvpHG0A+
 +1a/ZL+YNh7n+c+vZfKPqdDlMRnMYqGR+dUNYGPl/vuFc1K5JfuThQOcLUs1626lI3zZi09BEdE
 3/jyNLDEPN3XvCXyJshUhFM5FCC5pFZ4yKqwqFi77IoFmPOZpp2W1qkT9g9WLDolMgMJOoEORdt
 1INOBlArwF/otPJkaNxzMDG8HwrngRusY5NSAAM0lhF4nrOob0Q+ail0szLwU0fXt2oYIFkOeqg
 UdkFhcdIJNmFDG1yYxQ==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a6c65f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: GtbZsCUkG9MSxr267LN_H6eHj1TRsUbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_ORDER_UNSPECIFIED fallback value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..2dfe2bcd8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1

