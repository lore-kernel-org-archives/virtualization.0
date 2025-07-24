Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49E258CF8
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367850; cv=none; b=CwAkSB4DlFQWOj+gWRWdCU8iFX4zn63CGgjZCcVFUmprn9e1XMvlCgpc7DDONjqUjMcAfd7IAxJi2FjEc9ijtsSXHUL8xZWtKS1BixPioZCv6cqn8iRigcKl/mrA1ExnFy8QR+CP8eKsHJxSvCI9yLEL0nqwM7vpOGLUyOF8A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367850; c=relaxed/simple;
	bh=i1slLS6fKL6k/lJjpB1zEBUCWviGCPU4GQH5Mw9K1LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgTouUv0rEcXDFpVloAWZv0hr16MlmjztsGuWz3c9xJbUT5fXE3OpxADceqMTjA7qNOWFW2AjiDRAjl3S/95rZgGfWLxajYMxFCZfKUmSEbDZNOQ+l74Daz23PvPuMwSbgC5sVHwaR6Lk3ia00fuo1E0M80Al4n5gYgKl0Ss73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJNUZb2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJNUZb2M"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9afNB029601
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1/ClJdrWPfw
	KRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=; b=nJNUZb2MHMlazo/lHBTTkx7RVqD
	mKkM1XLOTUjLVxHwwO6ntu5k5NMLGeu3GfWfeExSsH4CoG18PYbY2sRQZwk6GepE
	kKJnegj1qnrJ9987J981svWV6MRgM5b4e7lhl0k3JWRT/0Jsiq74Mt0sZCIoFjoz
	WzunazjjNXLOQyIBbthmKudOX/0HTUd3oKj7vZgQOiexnSKaqCApet/I4mW4AXh7
	sJOhS0RpouMRpufAsY8vfP1N+Jkfgmx2iVB3rwgPS+2EazMnGYACZFEdT+/nr0Cw
	TXwOKZIkQ1w9XlFcueMIDTmmQENAQ9g9sJ6PbIXm5simWPnD8+deTD6gRRA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1gcyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:27 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-53169549f5aso366643e0c.1
        for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367847; x=1753972647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ClJdrWPfwKRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=;
        b=wEDddZliQ3YJ/I/caJ8z1ZofVksBz1vcKQW4hsBP59fWOf/esYZXqSaRLXr0obSiUg
         Oq2f5LP49CxSaspXqsQ9v+EvGX0Jqqz+qszVLHq2HtEtapIredCXFgMkFWidpeQMJZVT
         hIPAu11FfkblwnJ3MCIGeUsKyc3588KPhT1UY4iwCfEMH63MIeYnArDPfUB/NifYAf0P
         tJNlFOgUtaN+FYV0smHX2Mj/2eCVBuOK6qKh8I/DTKIQZZqaVScsXusstZK0oXlsehwc
         QBYB+EDnxUFx0nnNKeHwmN5vx++8LWUhDto0NtVMckm52wTWxgma1UaScQqqfMOYzZm9
         RSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNirZnX3Nb1OXUENRFG+nWt7A8ItJCH0+ZGJhFJ9aIJ57AEbHsTeLlBiGF7iNVGeUAm2Hl3iw4j5RlngDBEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmdgyrwNEqnwin/39DbxIgdlyddQZxv0Fcxz1aiKy/sRdId3yq
	YKM4n7hHrZ3I2qCC6/jDDBXLlf8zHv+ZA9TpKc1+tka7g6FCzquaBa7dBOsYCmvbtEjZzGCK3US
	BO0+qTmSipIgsKOGT4nI9k6QcnjoXNaBYRMU4lq6GrLsaGWxVymHzgFn9ats+ASoXU07Skg==
X-Gm-Gg: ASbGncu4ABHdpRI2WetxYiOyIOwmTxGTo19pwiDTO5G0ZZp4+lwtBqraTH1WUCPLBNJ
	FlgpYwFTr0jpGrdhwiGe1/ZgLy1qZxdCJmjIEJCYOA2eQ8oB6wfANST+STid6IEaak3N0XSJgkO
	CIg7/RJ2fqKGciIG1gION8qPoQxdpfRa0yHb1765vvYRS/S6SssyolRR1tg7URO6jPFMqbsa2sw
	5fuXiGmOojCSzSEB5fZhjvzC7xU4WzxKO15zPxnvQoLNIDzXt2TDVWbp8VSUpzGuSqod19GVdaG
	sjxhm+BhtIOCBitoQUKr6JtWBGV5s1Fjy4bTZ7cXVoEE4YpzVyaEMs42lOZPyZrI7Q==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835506e0c.9.1753367846785;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFC9QgriQyVRZksDj1oB9q4RdVIKez8rc+GtzAgwBhWM1KCgo2TsHI0fM64ZXC1O2Pn7YiEg==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835474e0c.9.1753367846304;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495f02sm122856266b.2.2025.07.24.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:37:25 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:36:53 +0200
Message-ID: <20250724143718.5442-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
References: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2vx03LyIbvt7kNexG9nKXqTmXzZj0i3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfX5XvUeeK2dKTJ
 5ZmeIq5WJqgASom3IdII79eKiznOCI0rkg9uyHnJNW1I1+zCBbMxARhl4xXGCj0bNnuFxLTKbgp
 6G357YLim3IlrSlZDZ/GleWW7gvHAb47P/DjoyePC4dGqMAJMEBDa20p2c690RNwBnAdg0qxeMv
 zw4A6JOY3ruZo6jdMu/fRA7ePIsSJZE+EVVaQbq6hmVBVucUo7xZ7VPrZTvOGruGWHQUyitGgCM
 chzmkXpGvYFPZeDz7NLCcL4+63k2UHkJuXA3oszpYwLlH4a8v/O/rpcUVMlR9O1h9ESvu0rxfSl
 WxdFQtptHdaxFbSn4P613cbOGDIkytLNxIvRTHe2e/HMqHzHWnX7vu+11MIpCkGkysa6FD6wWIZ
 bbsWPDfE4b3g8sSSqJhGX64EzoSCtYP5et6SlBQnoaIreLbjGd4WcrSmjGR8lil47A6PZKZr
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68824527 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=x8YHxakxDffKOoiCecoA:9 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2vx03LyIbvt7kNexG9nKXqTmXzZj0i3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111

Quote from the virtio specification chapter 4.2.2.2:

"For the device-specific configuration space, the driver MUST use 8 bit
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
64 bit wide fields."

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpio-virtio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 92b456475d89..07552611da98 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -527,7 +527,6 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
 	struct irq_chip *gpio_irq_chip;
@@ -540,9 +539,11 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
-	gpio_names_size = le32_to_cpu(config.gpio_names_size);
-	ngpio = le16_to_cpu(config.ngpio);
+	gpio_names_size =
+		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
+					      gpio_names_size));
+	ngpio =  virtio_cread16(vdev, offsetof(struct virtio_gpio_config,
+					       ngpio));
 	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
-- 
2.43.0

