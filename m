Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995841;
	b=VMtJvYkXjxrozc1m9WfIjsL+acTPIyv8Ib8HnHpDaHOz5lGfaiAfCGuiYviS1+3cScHG
	 x9lI+ETtdMKEn9xchp0vehJUIXQ4IMQH2f7VxUcnATT/j5JiqMZQsEuLKlZkHHcr0fvCr
	 TZ73Pyga0PIu6fazCP1LHKXejd86CzYqr3n0CEhaw7OZ8Zuqf2Fd3SuPgXRoHnMiVFPH5
	 KwuiveuVPrXUeNyKnoUCn1Zarn3N/E00pyMTtHnJ5Ek/cJIyZZdYAvOZhYpJc2klyaIdv
	 gr9+sKqq61nMcoNzQWC8utk+4MY7uaOIYp5K2St+GNm5xlq+ercf8Q2f9DuUSpql6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995841;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=;
	b=WCd3NDZwH6oJFwlZitBoonC5J4PxEgrxyOXmGhpWY2zJFhJTPlM7lvHSXM3581B+qWWZ
	 GE952sd10gtWRL9AHoEd/vtiSPvddCmgW/JEef9hVlY2gYHtp8LwuYh1cQSat/gQ0nnUK
	 ZYQ1wKdXXa0izOXVR0IYSfZV7gLxG1iRLQbG24SmUfBspIrMyz6a9zsWDQO6ukB9Nq9FG
	 NH/wJmDf5XP77peiQF9YWuL5mRAPOVeXDVx+Q83YkOm3n9WP/5qcaAnBOLcDel43m9ZWo
	 AWHBS2mDkjw2IheXxbTE+szJCRCYU2khDEWLmUFQjzvM3892KCIs/KflByOBw+IBRPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dRS16m5m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRWJozv+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B176606A321
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B176606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dRS16m5m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WRWJozv+
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aPD22222508
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=; b=dRS16m5ms665/YuJ
	Br6BSa25BglOaVUYMDaXlJ/uSX/QpV0mpRKD61oClP+LUpAWEYxStU4EwUO7hnkJ
	jxgYutwnPits5c143mX5LemV7XGVjloM3+tGUkMa0S+tttGEGrpl9b0Hmkw4B1x/
	HanNbhsCSlJw1Dz0s6337gsZcwUhSYBISHXwmxkSyAIK1vX4ZmvtOt87m/f9Pn39
	cQt2Zyszk5Up+EJ0jQX3eHeWNiY+7txu6jGXuvTAXvdpEbreH4HLdrMZExPIZGah
	ICAmXeMImI+QRzO59OTo4WHTRxgArfTxwokNbh+7tN/i8mO1L6xLhj2+Ny887pCa
	KRgLxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8tut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67466211bso1618626a12.1
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995839; x=1793600639; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=;
        b=WRWJozv+nwr9vOb1AxdfLySv0K3chzK+5d3n0hrw9KJSU8/Uq77g3Cpjbk6STdDkuq
         MP3Qnwhw5VIvKY2TecNsJOBwLEiw+546Rtp3+VwB99IIpZm9eF0GTdxzBYdjlvesJQ0u
         fqyByepxzlwq7gwmjMROpzjsqO28ivGQ62WJz5EnxqMqGIlP3IrfU0IWYhiz5m3BfgVc
         o+NF/vTpWVs7a4XWiKFNSbKI6vRDiU/HH+KKkKLEdg4lbWC8Yl/GhELMe0XwbNJYAWMZ
         36hbnpuuip6mTpvcbhRC7aV9x1Pm8sCYlLdPLwjecU7/W0u8cjIabMIZ/ea99vcMM5kb
         YZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995839; x=1793600639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOR+3mQqNWrrLiobLgmkq+PeJAutB1Cemy1/2B3AOYo=;
        b=jqX+Fzivtl8xhsJr2J/sh5BzABTpggwfjBsDeP2rHfFAH2wbFM68ba2vIqjhDQXep5
         sPdSoBKQyGuAg2i/tOyXVUfN5ByK6w813FjYfGzRz367tW0CQj7N25/WLw8CgpxSTFfm
         E4pKXmQnvPGeaMOi6gzAJssIqhuZkTtIifELy/c/OE2vzNXTIGLPtzUcgA3xj6gZIeQp
         9hR6k+zQUmyVDjxMQDRWrTZLe2R/Rf00Udzsem0/EgMAHo7X29ik4F0EWJ4W+/a7Rc/h
         z0+T3llj7896dAK/GTKCL3u4ljsbXfuLSLM7rIJYoMFDH2Rn9a8DlSZTLQomZRKBRCAD
         iLow==
X-Forwarded-Encrypted: i=1; AKwUvBwAvbYI3EgfDYXaONDMWVWn385cpXUnwi46hmQhNvkK6LkDcVMKnOwKcu346p4N1u5EqtZ9Tlwa2Rc3fvkc6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLk/U4BsyZ+lWBWons5wCzdurBe5W1+UUiwNPWidcRld+3vfeCt
	flI5LyL2tHhG4MBgtFx0xMU4tHCQon1dz9iYgcZGMKF+jkhSLj2uakcB/QX9AlRVNu8SFD0oh3u
	PcyIH9DJ3i4ONMaYsQgL8iuzmkluq0ZtTmsAFtL4TvsoEVHK6ReMzJZ3p5KncBIbgAh0OJA==
X-Gm-Gg: AYBFou05YSHvWZH4onjPtx3LB6XAJJ+ziQBjsgDTB7sDL/8tG2Cj9hBSh5AxqNoMpkn
	7MaIHDTWg9ax5eol+KCjSB/1PZbPN6dUF++LJmVqyHZ+rcHKldb+oc6DEVZC68OG+TtPvtQ5zgT
	o30KHawCh/YnVsOmHGU71qBF2MrDcou7hHyc9vK8U9mGYrOkUdsuYS2ATr/J9Ivhd3F52DEFmh5
	Gud4xsfk2APrOJX22ZdNCB6fVSzhbMzD3pPqefVdLlfRpgiLxUdQyHTS0Qj0o90wTqdgCJ6lbV1
	bmHgjLTV3HJkxLmVaQ7JhexUadtHFyXb457SzSFCKbi1p2cMG5GWnuylfZfcFqIHUN2hdA2ncGz
	tUcjTk5R9rshxs2blT8rhnGSpS4B5mf2L/Q==
X-Received: by 2002:a17:903:3c6e:b0:2e9:6645:e9ab with SMTP id d9443c01a7336-2ea9c6c246amr54738215ad.16.1792995838584;
        Sun, 25 Oct 2026 23:23:58 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2e9:6645:e9ab with SMTP id d9443c01a7336-2ea9c6c246amr54737865ad.16.1792995838107;
        Sun, 25 Oct 2026 23:23:58 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:23:57 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:23 +0530
Subject: [PATCH v2 13/23] drm/msm/dcp: Route HFI display events
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-13-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=2412;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=BFTr4Q+ZfwwET6V0CyDqzPQcI8MwpqQ9e75s1Un7OM8=;
 b=SKN800pVbhcnvPWsUmrNznlIDbT64GT7gmpps6ZTh83CJvMF8drOdSRqgxsHIH2Rhkat9HE0L
 quOBQpd8NsHD9Z9IG6TzeX9xiSU8vrxzzp9OkSE6Nv19uQp+UAa/FHQ
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: WbNU9sjcaBVhqQ8owel1a_P02xcdqQLD
X-Proofpoint-GUID: WbNU9sjcaBVhqQ8owel1a_P02xcdqQLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXz0MI5H3LmREc
 BCOvZUqG/C3czSMlZBLzwuvwZLMBdOHjrVD1hQzQnRK3LzhhLTepRPWmGCIEQin4vZHE+eORCE3
 BWlglf35vOVayh98zyKHE0VDxhWxC+cKEDXc25IZ4i5OubF/TlmSF0/dyhT/Iz7bR6uGCT8UNuj
 AGYJ+4kLtg1BiPjlE2dHubEkiiGzX18x0vsuzNg6nnzHJkRgnJ5fptG48rs+P1ZiJ8yVn2/CF3v
 O/rQ6qEAraq3Z+xFUS58sPNnKMXloUpZN4euIP0u+aoC0912BPZjZ1LV1iCQ3cWuBCUoUUS49Mw
 4RDRzm0jmXcAcLzlJhp01gb+6BM9w0drzbm8snMQ+YY2kSz5NysBaZ7TEQaeIbF/CI11vYrf2mO
 ul7aY/zeRNAzQX6TCEkBOi3Gl3KCq3Fqsm9dOyH2unVU1M2OfnJ/5LPsdWnC3ymnxYsw7q5fpv6
 L/sMEIr0MRFFX0AhLXg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef1ff cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dkYgh42podB0RqWQ9ZQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX7vQ4aQnhJ8w9
 sc4c5ePz/EMr/oOtFgis3oUqiWmtQqTkPV/MIEzEnErGnB45YHVtHXBL+MNxldUqJra8yEV/ueW
 QasbhLxdJI+Fj+7693UTbo5hqfzJDPI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Route asynchronous display events from DCP firmware into the DRM CRTC
objects. Without this mapping, VSYNC and frame-scan completion cannot
drive DRM vblank and page-flip completion.

Match firmware display events to the corresponding CRTC session and
deliver VSYNC and frame-scan completion notifications through the
MSM DRM callbacks.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
index 774a5afac0f0..e54ccfafdae0 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -19,6 +19,7 @@
 #include "dcp_hfi.h"
 #include "dcp_hfi_priv.h"
 #include "dcp_drv.h"
+#include "dcp_crtc.h"
 #include "hfi/hfi_packet.h"
 #include "hfi/hfi_packer.h"
 #include "hfi/hfi_unpacker.h"
@@ -260,18 +261,35 @@ static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
 	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
 }
 
+static void dcp_hfi_dispatch_frame_done(struct dcp_hfi *hfi,
+					const struct hfi_packet_info *pkt_info)
+{
+	const struct hfi_display_frame_event_data *frame = NULL;
+	u32 sequence_id = 0;
+
+	if (pkt_info->payload_ptr &&
+	    pkt_info->payload_size >= sizeof(*frame)) {
+		frame = pkt_info->payload_ptr;
+		sequence_id = frame->bufferflip_index;
+	}
+	dcp_crtc_hfi_frame_done_cb(hfi->drv, pkt_info->id & 0xFFFF,
+				   sequence_id);
+}
+
 /* Route asynchronous events and capability packets before flag handling. */
 static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
 				   const struct hfi_packet_info *pkt_info)
 {
 	switch (pkt_info->cmd) {
 	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
+		dcp_crtc_hfi_vblank_cb(hfi->drv, pkt_info->id & 0xFFFF);
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
+		dcp_hfi_dispatch_frame_done(hfi, pkt_info);
 		return true;
 
 	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS:
@@ -975,6 +993,9 @@ int dcp_hfi_init(struct dcp_drv *drv,
 	struct dcp_hfi *hfi;
 	int i, ret;
 
+	if (!dma_dev)
+		return -ENODEV;
+
 	hfi = devm_kzalloc(&vdev->dev, sizeof(*hfi), GFP_KERNEL);
 	if (!hfi)
 		return -ENOMEM;

-- 
2.43.0

