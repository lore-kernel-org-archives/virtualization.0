Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD529B8D0
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159722; cv=none; b=bZgo9fWG4yRh3L2zmB3JqZfFa82o6r2qe0FJcM8iK8L+WkrEgBCxkM7kG2WC14E5h6Ijn0pLRA2Na0qh7nlVqVftPASeBhPIWiltZbiMTbggEf6KlQJPwMSJrzFhx5e4fRo21J6Q+G62BTaKyWgMdPOQal2hrEkAXHrYgOlDNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159722; c=relaxed/simple;
	bh=bYbtRNJ146aC3TMQ8IfFXUbxO5W12g8YSi8uv7SMoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaFZ7eUdAh3qZTXIbp+/Fxl67BO4UpHUu21u5MKbsF3NMxeu52Ej6h4N2KDicZlSJck4Qe+f66MpSAqMUso14knECdvOccfG++3zHsAeGPYY4sRq+xrXwuYlurI8D9mRWsAAuqtLxcX2GJc8b3TJ7q953JRzztzoEs2ixf6YpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFYKzZAI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBnpSTL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFYKzZAI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBnpSTL3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7MGY2S3693658
	for <virtualization@lists.linux.dev>; Mon, 8 Dec 2025 02:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bc
	fxqoQ/vY=; b=bFYKzZAII+9IPC9cDmTe3CL+5j1hBTMXnsFTVvvocwHERVZPzzE
	B7ut+SM49EogVJxmGHt7IJ74HMiWsQc0xCCyBQ9ZE8avP0iILPjCxhXEFWFwIk3K
	Ezm2RfCA9z0Q5WMZr+nc2i1zO7b58V9M7AErtpQUQ3p9wh9sDSyaKF6Cy8S7e0SB
	ri9+MxmeZLlwr+tsXLr6RRH/F/vC5welCyZqGMaPZ/yOPOxCBtiAc4ldCcOhcwwW
	1azyh4aUD6I72/Fo7IIjXtOKEVL9WJ0KCtXQTMHsKjhfAu69xDkKPRVlN/5D/ZOV
	MhEXDI6RfcMQRbirR9V2bHo8K1dplWQ4dyQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avbga3cdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 02:08:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340c261fb38so6804584a91.0
        for <virtualization@lists.linux.dev>; Sun, 07 Dec 2025 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159718; x=1765764518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bcfxqoQ/vY=;
        b=bBnpSTL3XRqyZATwYp4YuwzwN+BL97yQ1cifUzeZulGnk7TkgMz91njg0iCTNQzqPz
         JudZWexSGSgD76vRPJCWzz7jpeA+PrhaDNbTMlkiRayrIp4Zqjlz6NWbbgfvHuQ8sAc4
         8D7LDNp9h0PrC7SH7YCoyEAEWUaQuGXE5N1KFJtHwXE88VFlEMp6Vlgfi2UaNdpiHf8u
         mRQaO+etwbNnRwcnexjzcgw2H9dMJbg17OxwVPHlccQHlQzDxcrg/ArADYb8xCXfdKbA
         dP8oArrBBipdPT04xeJqhCqFVAERLhZ4HrCb84+bpH8zjMXk7t6JD+FhLrOdl2ThO8yt
         j5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159718; x=1765764518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CpbeJ+C4anMYVxEHfQh4qSBUe7MaqTj+bcfxqoQ/vY=;
        b=h90Lw1zZVxtcaECeVA0ZzI0u750L8yV5loWsH8bP7K6Bhf1hvBq5il28mI0EKNWxX/
         U1vB2VhO1b+d5GbdVasyf8D5WqOlXROjBfQEP3BVVg3lQsWX+T5sNZrjjUn/fYNGTKZB
         pmjEs5eZal9QKJqip9SotFF3qidELr3fZj5EoFvVAQZCD6WCDh5LQ1uAiNvGxrl+seTk
         CxZBTk6rGHnPZfEDERAGDwhjXfeHrcA/gu9X49XRFtO5j4Uj0mHRyh09jbBvRVvAUFk5
         Q+g2XGkbfIWOY2nrhBN6YWo6xI/tss1r5HbxSsl7H8oZcTb1c7QqKqS7Tahrn9YdZkDO
         dL+g==
X-Forwarded-Encrypted: i=1; AJvYcCWpWe8uXVCBZL00sgAwkAI5qpRdEBqe6cHUnHC9dlPKAQKZsbPqYm4Wfg+sq5t+Wkv2RGjqper9ibDgHEE7OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxchsGIhQd/wBqtV6LXM3p64j9nm6hsJVJ+dmMQ2NFbdNdlvr2X
	9ltN2bQXiVDTK64i0y1+NRBPeaCS4vca+JdFWhuKj3C1bQsvujhKPYautNCAxJXU+fdHvm+XTnH
	jLtpvkFQ5SH1rE73OpO4AP4v8wBcPDw27jI1Hp3y2RncBOWidzSDUdEdyHNWWHMoVmXDtkw==
X-Gm-Gg: ASbGncsdhfj+qc5K/IYxDjWW+xHekPolosBvvBIaanbXtbRX1MuglD0zUZi8WQEJqMj
	Q02MZZhsJszLfyuDYgmGA/YFGeL/C1bIUyKUuMzp/JCIfvaPD13HsJ9lSECbP62QvmBgv6ME7iv
	ovWoafZ/e28bEdiHDnXFmd44CBcIHjqVq4qTLSb+Q8bFsz0WpKz5zjZGOQa+qbduenIGg25GNUD
	9DhXcYS+3uSgU4suFLxN4LFeH4aH9+jG+tSwmEus7dj3IEKL6b5Sxj1XeGJr7n37cUMoAf+1gRO
	trdgogS/2o1uQSgrndMGufzkDGbpl1QXTiCjS2/Wj3LMxqot2gxqKxcf9kYnsDxQPfUrMN67HG6
	F2akMSwU0KZK0cooiQYhxu75JdjM7INJSamAY84EDTgWbEH/xKrcZTrCv
X-Received: by 2002:a17:90b:224c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-349a2599aedmr5351028a91.17.1765159718110;
        Sun, 07 Dec 2025 18:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZG8yf/Ns1EegSTFE0Rpw5twCPlKcZgHeZqg7GH4TQfQZXerKNzs/OlugiBcRykEiG2Lkmng==
X-Received: by 2002:a17:90b:224c:b0:341:8c15:959e with SMTP id 98e67ed59e1d1-349a2599aedmr5350993a91.17.1765159717551;
        Sun, 07 Dec 2025 18:08:37 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfcfasm104991325ad.41.2025.12.07.18.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>,
        virtualization@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] spi: virtio: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:31 +0100
Message-ID: <20251208020830.5225-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=bYbtRNJ146aC3TMQ8IfFXUbxO5W12g8YSi8uv7SMoh8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMe0DvQW5czVU9hlSRb6igUPfFufx99kUMHy
 zulbG8OXYCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzHgAKCRDBN2bmhouD
 15AED/sGzg5QlPKWdXtKqMXjKN8gqP5QezAXVEFPO/7jfwTrbHUhGjN1jV9Q9DZxUCUMFbN604D
 ZWGlEzAzP2zBLLdv3cx4gZZbSZGGr3V12/2cst/Gj/s3WEpRkaQZeRLmeNCaqb5TZtoytwn24Is
 10hkKayTWO0z4lmmPGutLSess7wBB6iEMs8bnKZKrJPq4DN+LU0SyOHlqdtTXAXTghoyd0YKgiZ
 RtXtTIOGbsaAUDpw8lFA56EaExiEPWxIntBkG14EQISPOApqlArLYTigF6ivD6x8OmaA1N6Zfx9
 YUDr0uH41XMq4GShO9fZ9q+8uAFmBzXjJGdFJjO2Pz0AXZ3BCGwZksHt2vb8pBc8BrBf6KEMSgR
 ujzIORfuXgqOoPAnQVzyz9rvqMo638Q5VNEdv9uzhjRA4vbiHdX05iq4mOjHAeB0pABTDx/Y7i+
 gHkny3X0/Vo6OqwzPNdB4eumQ27dwbcbYhIlUCFO53TMsbOpZUrtb9e7aeEnOB1SjNzvkbqKJnj
 //B7JxcyqaUD91jSmCTDE3Daa54VnH0NRUjEWM6jexeWYHIrQ/jAUlpKUgbZTi10ze4KLZscXE5
 UkmNS0rNAHywTgPm7j3L5L6NJJozACXaalQQw1VqNWRGpyo3IAa5IHYA7hOVm8V2m0+7Vvcubxp gVxAh8a/px1ySxQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4z4CBjE c=1 sm=1 tr=0 ts=69363327 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5GyS9ht9Ox2oK99QZPgA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: kw-GnC5RRvcKN80-L4xYqA46nikFMZPk
X-Proofpoint-ORIG-GUID: kw-GnC5RRvcKN80-L4xYqA46nikFMZPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNiBTYWx0ZWRfX41UW8kM8aLhP
 ut35S5c113lIGZlsjTI+NT5SH9U6b8/iYSSnauRZ4RA7E6iGYjkOfD/NJKr4GIOPjCbfiIHXtjM
 euCN/Xlx9cf4cdQHvdf9FgxLyx14FqeGj7+95jExBGRH+k+Ub2B/5Z4usOLUw3vWiccu6ExDEI7
 uhbJK4bg4nCSP75Ddu278oDB7rW5OBgXIFjLz4hd0jThaKG8MBDJMWm8kpnEG+4SfVVD6D4dWDF
 dp5CwowKje7gsFI+VsdbbiZ457ZuDgz8Gdar3GN4I7G1hp8uZ68mhMdlbbYbGx3thDhoI4mN3KJ
 Y2nrsw6E2XDU/dODNw6qICWHgMegUEJ3KqdwFBAvYbXNMcmNPh0ia430pH75P1Ca4lobFalF349
 GoeePt6WCKBF+PUuGr0/dHfmct4LIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080016

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2acb929b2c69..6aad9f1fd016 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -150,7 +150,6 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 				   struct spi_transfer *xfer)
 {
 	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
-	struct virtio_spi_req *spi_req __free(kfree) = NULL;
 	struct spi_transfer_head *th;
 	struct scatterlist sg_out_head, sg_out_payload;
 	struct scatterlist sg_in_result, sg_in_payload;
@@ -159,7 +158,8 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 	unsigned int incnt = 0;
 	int ret;
 
-	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
+	struct virtio_spi_req *spi_req __free(kfree) = kzalloc(sizeof(*spi_req),
+							       GFP_KERNEL);
 	if (!spi_req)
 		return -ENOMEM;
 
-- 
2.51.0

