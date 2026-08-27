Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05C48CD5F
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846915; cv=none; b=BaWW0JRlkJJNdTDeURUuRGruyDZ3J22MB1DGIaUVBNNs9nT2y47zoThZH0iYr/SuA3fHldZUAZoZhUUffKuXYDJ/entQsypo3vZxIO4eiPzYi7QcjGo0UanUh3qcjV3Ux1Jix2pm0QBjqImfrbVaO1HgxuDYTm3VrRhB8wSl+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846915; c=relaxed/simple;
	bh=Ro1Tw7bimijLX+zSbVZzcIcnTuF4NWioN9yBfIv7fvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7b+11/ryVncGVgjo4sbBVpNPfVLgcH7JcahvdvpRafzoDlCrvJrQ7JJLe7WdFsvF/33UVuiFYYdiXOcE69LtPW/KZMiz/+Hh+2dz76zcvP9PgG22yThJOgC+dp/wI1BuJPUKP2X9QTTR3R+ycPqpUK2fbXeQTdDCOBJ0gQPWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2BXcxZ5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqorKFf7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2BXcxZ5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqorKFf7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFcD4b3942140
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=szEkNwgY771
	Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=; b=c2BXcxZ5dH6V7p/j2Ymmx/kbwuk
	5ypm5J+Gy/Xe/Rzmh16ripn5C4xaaNvcWhKVxilUrwSyL8ZaX1EONIWOJxKjHI6C
	9r8+zMkdIft7vyYF67XPAqAb/fze38RxCGxangfO7+n4KFZc/us+ZyuwC1j8Pr3q
	nXuWhE9t3ykQ9oKvWijc/LsP+z+xEZF0jnxEn6d6IoUsbP/bqvHFOuCzr7iOGEzf
	VCs/kF+aS58KXOsQVJPfBiAwXVM6ag2XRg296GLNCNw+hk8XAYYcFSzNfjV+8JVZ
	KwOz7DPYZ1w7iq4y7PTnCS311Urm9TKF4Q9jj4hYpivdxTMopVBqWIF3hQQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6etv4ej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso106772a91.3
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846912; x=1788451712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEkNwgY771Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=;
        b=cqorKFf7Q21aKaTp+EH95jNREcOBA0t7jK6Cd7J8Fb+hYwsS1sa3dq0mf3GMFaK3s2
         c6ke3eVby90qslLKGRm5oncf2WfubJRU4xnrYjn4bjLloQQbey1X4NvkLtINrClaT7ZE
         ld+BGsDlp69FhkdVMMi49zXGcd+q+r++ziOuSnKk5++3n0vFd4pIPZYH9y2hqpQ+oE0y
         /OL0NtPc55ejmENIiTWTroUEpoIN1rmFzvfaz8r1OSwfKVdTAQlZLqhAysAWvYzUw2Un
         scBC8jeKzOoV8awkGQ2M4zNJQ1tSOfyDh6nDoHsW+BaWM9hnNlnq0dgMlSOjksKbELk8
         fSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846912; x=1788451712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEkNwgY771Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=;
        b=pUBBq45S5KEcBtPbYGRk1puZPdNYHWGMXNEr8GgCFtUKbNl3fNa/jy1APP52xKO0rc
         1/QbpHJzxOBNlTtiATKHMDwVIHipHLvfHiUmkxSzWOIKO7kSwy/foUaYYF4YBIZPWSpn
         /w/g+CwkuNJZ8FWwHeTn2GxRctdlg6hq9e90t1ktHnAK/jty1zKpfHPEOQCuN4Is1q1C
         j7n3Zp2HDKMRqrWEdUsmAIwEAE3GMQhAWGXPS3fZ92IhgW5zeySZxpL1vgblSW3hlkxS
         M7OkPsaC/pX0Y1+Rupa37pojuAnAXU+eDSJUbNBN++iBy/HhwgRzylxGqq3EqHDFH60q
         gGFg==
X-Forwarded-Encrypted: i=1; AHgh+RqFXPm8NwIKcUjjKeuJtV8Jnj9jKqK16HYTjU9eUizS94QgQNDEP4L9EdwQ6dHDd2NfSfGwQTrVkYIP30t8Cg==@lists.linux.dev
X-Gm-Message-State: AFuF++ky/H1c+Xz7uN4FzBdo6JD2iiOWjx8tlSfrrjiIorUfERUx5S0F
	KfFhNJXnsEEgFJsttNX72pCuRPb4pTIx15MvnbRg5iXsgEF679pDC6VOmgf1p9Ga+6DCV3qcnp/
	cgtfCpTn7c52nNULbCtX3vQaF5ZrnrJDGV0rk0BYaskw7pvMQs09XBDMaJdrHChisvxqwyA==
X-Gm-Gg: AR+sD12XGfAgwNS+ODK0FX40eMft6ieWcTOcZWyEm34eAOfrcpkoITXW7zcN/HwDJG7
	34/NNotykWtvO48BiIGZ1KMss0ZUqa9IgVbzSn4tdYH3Deqc3vnFdpx4KcUW6IAOVGVnDlnRdju
	1kO2SylGizNOkoTSyS4rodTNtDbaXVONlDPR+LqmpGAGgPdpcTa8/uIT6/h9x645VJCnTedt0sB
	ATBcWfNZSOVcTPEJZKC0UHdUbBC+hwZWYpabCRONvGPd+EDJ8FDD5oCFc4XNejF0owVOz36GFB4
	EaWA+A56PFJQkFdlBxapFFvyZTqhPliMqZgF28DkaDJX/avSwQlH6vWsy5KDdXv7NCQtlYdp3u+
	jAA3N+j1CjnBg6tcarMAfhCXeexW+6ljJAjKTyUCUfEVBAaEnC1EpXQOQ9eI=
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-396d0e27e11mr634849a91.1.1787846910198;
        Thu, 27 Aug 2026 09:08:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-396d0e27e11mr634645a91.1.1787846909524;
        Thu, 27 Aug 2026 09:08:29 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:29 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/11] dt-bindings: soc: qcom: add binding for qcom,crypto-virt
Date: Thu, 27 Aug 2026 09:07:13 -0700
Message-ID: <20260827160806.1295313-5-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a906100 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=S71HXAmslS2k5ljwlz8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: oCzivAy1MUigcwlY9Hz4I7YyQ-kFqe_p
X-Proofpoint-GUID: oCzivAy1MUigcwlY9Hz4I7YyQ-kFqe_p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX6K4QCFEOq8Tr
 Y/WTtw7etS9wdvXJ78/BZbyo4PbJU4ORabqtUv7yB8DJd5wF4pr4+0TiBKqzl6evmyvQh2JRg95
 29rdDkgT3M6v6DZ3X2Bt2ZqxBy85+C2xiki5COrIXPF2o5NMOkFEK0OnhbFnKjX1FMVo7wIdfAL
 HiNfsH8dzceqnqbQunUTh16rdy1oBo4Q0ITPNYgvrSweH2aPyck1J68mC7h5HmeR1STpptcabDr
 At+TN6qSFTAIkPT+fgaJPWMaaYBbQHYMAWB2foQf3xgQDrofGKj3NOehrFy0x+NtcjvD65nzopf
 Jqe1J6NBe7YJiP59/ZOspAtkfpL4NuWx5fDon49CY8oG4AYW9AmPdUULZQgR2+/w9X4PqH8CRDF
 06Ocl1VzG6zQ00ki4KNZpFqW2WqwjGm8kZXYARS1E1eh/dsuku368T3aH0iNF+9H9QLDii8ApB+
 sNxiz9F2/pnN8IMyzZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX7pv9dnEfsZRF
 qFtJ5bAUAYJfjTan02xpNbTe9Af94QqE+zp07FixbemydJqGN/uEQT5m5vVUCkeiQQOYOcwF9VP
 kQjR4j2CYQd47qJw00LqXqWXZOPg8Eg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Document the device tree binding for the Qualcomm GVM crypto-virt node,
which provides the wrapped-key buffer size needed by the QCOM_CRYPTO_VIRT
driver to perform hardware-wrapped-key SCM operations backing virtio_blk's
inline crypto layer.

The host does not report this size over virtio, so it is supplied via DT
through the optional qcom,wrapped-key-size property.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 .../bindings/soc/qcom/qcom,crypto-virt.yaml   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
new file mode 100644
index 000000000000..5eb204f29762
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,crypto-virt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM GVM Crypto Virt driver
+
+description: |
+  GVM-side hardware-wrapped-key SCM operations backing virtio_blk's inline
+  crypto layer. The host does not report a wrapped key size over virtio, so
+  it is provided here instead.
+
+maintainers:
+  - Linlin Zhang <linlin.zhang@oss.qualcomm.com>
+
+properties:
+  compatible:
+    const: qcom,crypto-virt
+
+  qcom,wrapped-key-size:
+    description: |
+      Size, in bytes, of the hardware-wrapped key generated/prepared/imported
+      via SCM calls.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    maximum: 128
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto_virt {
+        compatible = "qcom,crypto-virt";
+        qcom,wrapped-key-size = <100>;
+    };
-- 
2.34.1

