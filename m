Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674260;
	b=YujREFmh4KHxTfwT5rGWdJE6ypMKFp2nVK9Rm/PB7ARRQ0VUO4K4JA6XYPdGNoNr8LXg
	 1JkNEsJUNeCCDsisujZXPgFNOVNnDyMSpUZTqOCSgN3fjlVSS+pEi2Ch+ks5V51xk5T2s
	 vAc44MoTeM3NTZ3wWPpeuonP/7S+DeN/qmJ9pBnArAY82PGpYW1Ji4YyyswOwhIIv/0aA
	 RNGEXWZ3daOanTmk+IixkOcMcAPVCxVeSDpPHQPhxezDukyc+jdq1tmlJnQxTks8waIc9
	 IKx3hcVF3DkFuyKegk4hpc1mL6Vk4QHuBG16bnisvZp7xONCvu+O4GuLFF5KM67jvhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674260;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u/xWhErjST9JRJm1KdXs/0MD8YoYtL1XVol2CzgfeIs=;
	b=WOxueCmNJtpTISPyDrNht1gpx3YZkX8FhCYLd1knjbnZpy09nckNuVZFUCDD5lIn9qDY
	 SgvfJCIRgE082YC52TVeJhTFS2icFIuRzXFPX70P0HnFlfEBujGoR/lWqEv3KD1zhbNBj
	 Cdu/DTcC1RRFHj2ITPpqnI/jeNDDM9P3MhhtWTmOGILkrKeeMatEZoQop13VtgNT+z1Ue
	 lVVTOS8uEnsKpPI5O1j08gBgRFWon0Paz5VijMshqi3y2vY2Pfjy5CvaTJ/LCfUIOhxR0
	 bnWFJuxuVwyGhG9aTMHnjBYGvY3APKDkh4WizjgzZOoN87WMalmKYglwWVBqdM1QIPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HdF+zjcg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4cgBepv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149E606A326
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D149E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HdF+zjcg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i4cgBepv
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36MXk3022906
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u/xWhErjST9JRJm1KdXs/0MD8YoYtL1XVol2CzgfeIs=; b=HdF+zjcgV7T2KWPe
	5PMV7LMlwOmccFIYr2g9xHpndcmSbGX5FEBPBdBnOKO67I++b/ILK+kvYGF2NTLe
	9NDnRYHKqbllpNKaqKOabn9vuFLfBNR9TjkicV5/WF731rFez1Cd3+Dx8xt837Q8
	EwekU7MqIpixJ/6zyP6CHIj2C/heEwDuO3ASc1a+KVXni2JsmOeM0d66tJ1/jqDq
	n7vF+i8+X0SMef1J62f3BaoE0rqb/NhmKva11OKQupxK2jwe0MiexFgseZc6j3Sv
	qqGmgDrZOpIErYS7b9qiJcGx/3iPQeOPuC6t6+LMqYAFLCNNEV2V6byOzN46Pxvn
	sBeXLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vatjpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b42ebf632cso4780244a91.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 22:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795674258; x=1796279058; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/xWhErjST9JRJm1KdXs/0MD8YoYtL1XVol2CzgfeIs=;
        b=i4cgBepvYRjjYwO6UsP/0MH0C169U0vG8LK0bnWd+kP4eazwSa+lUCFRZLr76j1CqN
         /9ernFmm30MWkaeRFlq1WQWEGzk+NbQEI9zprma/KYFAFBiJRz7SlfE35jp5t8SX8PJX
         YrQFVOLGC5kgg4F+8/FT8YJ+lRMoHp2KFKviAbMkyJ/UFZpIoaBk3ApU2CPkWTMJy2vO
         ObWsKdGnQH5PO850aLQUGnsxnGp2R9gLMeuhWBonuM2+GISC1ISlrkVwPi5vtG3Ux8Qb
         ukWJ0FcHb8HXZ571lO9PPgBuhbOBqQyj3J7wEpD8UGsE7Hwz6T+o9sU8bgkfl9q4wzi3
         mp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674258; x=1796279058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/xWhErjST9JRJm1KdXs/0MD8YoYtL1XVol2CzgfeIs=;
        b=w/7Qsjs7b9+1Y5jdTbk9kiTxD6D2cOG6218vUQokJorQ/129LVTeM5CdR68rG/zIrw
         q1+0dEEdsdh2R/P1TpkyMDRsAnRq8FrVeJvf6CtoUcbtEif5F8awHRFRWSIn7TixLvAq
         9FK/SodCR6ucN10uSXoK2n+9vdSioZnOz0PXppgobJZCXF4FWHjW0STvR2kobDBks19R
         XuRaCkp0hAbm5QB8BZoKLleqJ06JjDyAUMnpLB65LoqFIHUM7Nkayjwo3lozNX22NS9Q
         2f/UM7uDiyOqc8zwkwKrAMNVrCDcjbIG9Sz6wFqfW8yubdffZ7JBzRKNH+qwWsdZgnFE
         54Pg==
X-Forwarded-Encrypted: i=1; AL+hErHL9j1cdxnWzQNnx0iLSCo6UFQPl6+1wyi/uZ0DoHF8zvlePNcIh9ZxEZOHkT7JUX6Q/1kZdYewJxZpvqffeg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dJ6c3kDsuAYCu8c7e1TAEaqg7u7hxgyrC8AjGi6uCw8CsjO+R
	dUFt1FsbgvcbA5DyLyzAahHDNDZhZhPttBwzhSaxwKD92EIkj5nSdIEkAZp8odNwWjYw7NrRLGZ
	61uxBSZKXCMQA98ioacvNp0S5G/0uE992Lagv2ABvdVTyFxgS50fWPWUboOS10PiPXb/89Q==
X-Gm-Gg: AZFdTZdsi7MTYa6QbF48bTcGXXgatL3yMa7wwkh3DSSaHyQffp6mHUV0ZgLI7T2N3NR
	HGSlCBG8t/U088SmbLaCtasLpwlkDq8t02x9Q4yqDA3TCA7Ykrz9hmrHiBtzV+PkeIFWLXCrfie
	XeCKb50R43oxXrcbIzC7O0NyQCBbDbtHNekhVg004RawqU7CuaXMO4IF1EsVW082h9CO7BA19lT
	gId4Rv4iQ0aGDszVKE1R64jC9XJ1ivKSrtImpOuuXwGzIUIaIfXtq8qPx+BZxHyyPp8323c6lyu
	4e/Vsn1/71szgsfqoF5Yru8/rxKWhBZZcxId5d3lChNnf517SvWH56tKjqGYR3IQ2gmKOd/iI0f
	t8e+k9x2t/qexg8oj7pcO7gbPqY2vGVa6+BpAWlsWPnLDKmLdZrKnWX34vMz/JSHnS16hZeuKF+
	Sb5JNTXrWh
X-Received: by 2002:a17:90b:384d:b0:3b3:be94:8dce with SMTP id 98e67ed59e1d1-3b41c9d2026mr17191875a91.31.1795674258249;
        Wed, 25 Nov 2026 22:24:18 -0800 (PST)
X-Received: by 2002:a17:90b:384d:b0:3b3:be94:8dce with SMTP id 98e67ed59e1d1-3b41c9d2026mr17191860a91.31.1795674257773;
        Wed, 25 Nov 2026 22:24:17 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fc28asm14988015a91.1.2026.11.25.22.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:24:17 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:53:59 +0530
Subject: [PATCH 1/3] dt-bindings: virtio: Add Qualcomm DCP transport
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
Message-Id: <20261126-jshekhar-qcom-virtio-dcp-v1-1-7b49bda74916@oss.qualcomm.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674248; l=5491;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=zCMy86BiblMaTBntUv/0p8a9VYlpgN/fmt2L3B4qlTo=;
 b=hhE9orONRXV/1l/KbhI97l59bUccrilv6rQt4kIGT77iWCoOC9B3G2WbTS9bMQVJmyqEJ8bMQ
 mOotnZGbPtgDcESFt9uxYCyP8BSr3nCsXTCgU1qSSbzuMCEpStkvoO9
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX7YQ7ZJh4nVJE
 V2yBkedqMKGLVB8BBI7b19rf46m8e8a8qDeFRgB8fABgrhaKJOvVUwajdxs0hPg0/9kVQCL07EG
 fW3qdNuLAdp5Fv2TShCRngIwiQA+qL4=
X-Proofpoint-ORIG-GUID: pWXx6JAh1yRXIGCIaVyr56IgeDsnx77M
X-Proofpoint-GUID: pWXx6JAh1yRXIGCIaVyr56IgeDsnx77M
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b07d093 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=mhW_SsdmBOH7Z-IcfJMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX4CeWMhKeeJ2/
 4EWvK5natwecO1KoYqLOIA4uTjcbfjGlOK4x+EOJKqB3IG2dXI6BqRlosQsRaojyUegj5NuolBS
 jq1AQY3grMQj5GXyan3EW/3Tu2Adg6TScCS5aK7ztPrZu8wiYSyc7gbmO+kFIWjU+Y7y8ymSC9/
 7Xd9qBh8RYgeUBRFvNKmrqPuYB1CaNZL9xW7tMzOYu7xuYBKgD5NUX23xExo/nQ6LKs9LtJSONh
 QsGvz9LcFVMQPv9JSvrSxdBEefTwBhgs8j4BURuSqfXqP5OKsw/PsCqJW/j8iQsnskHM9ehnXiT
 ppVeYwcRgVKkPRBwxFyZJ6nNViXv2LbOSQGF8GlJ1QQ8b61FXa28pL8kCveeKly6NjilUtRs6rH
 Gu8wOsSs0ASJFo5KaTws5R1qV7zH+OdgYw/69rZNbAk5KzD1LAdvCcnbHsN9rMFxXbuvPHEwnHA
 pPPF5ABsuzyjJdCOfUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024

Add a binding for the Qualcomm DCP VirtIO transport wrapper.
Document the IPCC power-notify resources, transport MMIO region and
interrupts, transport IOMMU context, firmware-visible IOVA range, and
mailbox channel required before the transport accesses its registers.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 .../bindings/virtio/qcom,dcp-virtio.yaml           | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
new file mode 100644
index 000000000000..46b0e53468be
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/qcom,dcp-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm DCP VirtIO transport
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  Qualcomm DCP VirtIO transport. The IPCC power-notify channel and
+  associated interrupts are required before the transport can access its
+  MMIO registers. This is a Qualcomm-specific transport and must not use the
+  generic virtio-mmio driver. The DCP VirtIO function is described as a child
+  node and is assigned to the registered VirtIO device by this transport.
+
+properties:
+  compatible:
+    const: qcom,dcp-virtio
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 2
+    maxItems: 2
+    description: The VirtIO-MMIO and DCP power-notify interrupts, in that order.
+
+  iommus:
+    maxItems: 1
+
+  iommu-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      The firmware-visible IOVA range, specified using the parent bus's
+      #address-cells followed by its #size-cells. The DCP transport uses two
+      cells for each, encoding a 64-bit IOVA base followed by a 64-bit range
+      size.
+    items:
+      - description: IOVA base, high cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA base, low cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA range size, high cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+      - description: IOVA range size, low cell
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  dma-coherent: true
+
+  mboxes:
+    maxItems: 1
+
+  mbox-names:
+    const: dcp-power-tx
+
+  display-subsystem:
+    $ref: ../display/msm/qcom,dcp.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - iommus
+  - iommu-ranges
+  - dma-coherent
+  - mboxes
+  - mbox-names
+  - display-subsystem
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    / {
+        compatible = "qcom,hawi-mtp", "qcom,hawi";
+        model = "Qualcomm Technologies, Inc. Hawi MTP";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        virtio@9be8000 {
+            compatible = "qcom,dcp-virtio";
+            reg = <0x0 0x09be8000 0x0 0x1000>;
+            interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+                                  <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+            iommus = <&apps_smmu 0x15a3 0x0>;
+            iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+            dma-coherent;
+            mboxes = <&ipcc 13 5>;
+            mbox-names = "dcp-power-tx";
+
+            display-subsystem {
+                compatible = "virtio,device34";
+                iommus = <&apps_smmu 0x400 0x2>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@1 {
+                        reg = <1>;
+                        dcp_intf1_out: endpoint {
+                            remote-endpoint = <&panel_dcp_in>;
+                        };
+                    };
+                };
+
+                interface@1 {
+                    reg = <1>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    dsi@0 {
+                        reg = <0>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        panel@0 {
+                            compatible = "novatek,nt37801";
+                            reg = <0>;
+
+                            vddio-supply = <&vreg_l12b_1p8>;
+                            vci-supply = <&vreg_l13b_3p0>;
+                            vdd-supply = <&display_panel_vdd>;
+                            reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+                            port {
+                                panel_dcp_in: endpoint {
+                                    remote-endpoint = <&dcp_intf1_out>;
+                                };
+                            };
+                        };
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0

