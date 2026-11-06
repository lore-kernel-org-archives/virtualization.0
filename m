Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985324;
	b=Wp7v6fhU6/Y01IwkLpSGvupC2EFy+7ttltBY5EDmy4qoiIJ2euUTGGeAGYxBR5lGn/Rf
	 iiUlinAJwgseN55W64hqL/cwFAHBu4gjFs1GM5XilmMlDdqRcSsiQhscY2duAS38557tn
	 iAjSIBm8npCeXVW4v41DE7Oi85SG3Em3qH5MU4WYcYq69HW+hwLULLVhNJBhdpobT90KK
	 BAgOXwa602bf2hQU3pJo0hirV9al3oaarXjW2mAHn7SDGCFC32kgja0cAsbT7chOlNe0s
	 tP3RrI3SjRVYK0Y0Cmpr+ZjHva4yhCFsyRQMaFR/GsG2aHlwy+v5iVEA5rV44UnL9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
	b=e5NO8CCyLasbU0kPSjtdAgEtNvs1WSr0eGYAV2mM5ycMLZdrFtjanrVvTgCpkH9ue8B1
	 t6nmD7l4SDeEF9ZUND9Zcs6Ag1sNpESpAh7FKOVzAJQ8ZKMgA135L4rHBghuHm3kFbYum
	 oDySxV1aCVePx9wDu/zSy4yZnLAPVucJUxxCXO40AltZyyFXmF1oGYJ5YzPi3K+xp4uv+
	 n8g9NjpsCbE/WLEMyVEmvYwxUGmFPxSY0r7gQIQiZGZdfwZG4uNW/t70WqEprPhOyYPVb
	 PliIvp6s9ZMxdDaX0QOlBplfjr3kBmdZSodUM1ZjLBFahWaGmjsKmEp3ZMx1zkqMOWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MpuAakuo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1E606A32F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE1E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MpuAakuo
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F03x93723367
	for <virtualization@lists.linux.dev>; Fri, 6 Nov 2026 17:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=; b=CWp3lA3ZBUkp7Fol
	KBi1z85YbvC4Ff4EFM48+Xn7Eqdk9aEcyUzQ406xTDaux23vDyYkIz9jEPk0lJ5P
	rPBzMh/seGrgl5g/hIvVahi1yVqaEtvgeKZtxoIufjZahTCVsoxYE6C/Jqk3kf6s
	hwq7mJmRGNkliz3jREdoBRzAzZB62Gqr8L0ZKybwMSVYk7rYMUQdjBR856l3/qVK
	m1EgHrXjSJc5RNx4Basgl7U/GdAgv8OOnHUpjq2/ZxZh/h5wxKWcAHbn3HuIymHi
	1EdQ/D5TOfahmjntC+L1j+Csi+VS0Njjsbn/jbZozEPqs87nw0hibGDoMvLR2sA0
	NzLASw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9ksq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 17:15:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so1268087eec.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985323; x=1794590123; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=MpuAakuo4BAGmtkXhdgs1OaKXKPT6nP0p2sIOltQ3YtqTwxOJzT3HieC7INxhuiOS0
         jqKT3sAlakJ7ViUu8KDjE5M5MwWuk5wRUYuPrscq4iKVtvNzD+OJIneEslMCcg0Y5sgS
         hVCzSMI79aiaCq2ix+H9pkbS6R3Jmfc8RqyIOsO5MT9ySOBKYJYYO2hLQGrYP+M8rxXH
         wciS0b8TgetMEl9oAD0zyq4TGHEfIzWpI2Bl0qqcsD0R0cC7MVTUg9ua0qm7LlqchUhy
         kDpMwL03vzLU6QiE+g7PR9ZQXwzz51D3mUa8BBsjCQeAg2z3IWFpCgmLvTy+XAqe5vbt
         MJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985323; x=1794590123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=pG2X0CiFJtMPYp4wtYKm8DNp8EV8O4/TdNg/U/t2WwXE0dD/wCGAn46zE+po1QcYUh
         GcgPLdW+EnhqhZWqsrOoy6OdYD1JODytKCv+VoiQhg92CIy4G5RHnd+dHgQbKfBRkEGT
         dSDmRdaKMZ7Iru0m6Ap0HGSY0XtaJEuUKw91LDdr8t/2VYIqdsFtn6KAHYlPSB4vi16S
         XhNpwzzET4JaI0SqKeeuW/lwfO7LVwEYMjjDthkHNqNMphEZlCNdmIECYtOUCGoAAycr
         Bn57gpWhCAKPmaaCrDPwFHgCr5b+YUKv2yP/pXgGCeQ1TL34vyH/lB6kWqszZTQ26llr
         8NZQ==
X-Forwarded-Encrypted: i=1; AL+hErHn+3HJ2+ZoZFoSHqR/M8oKA8/DR6+kgwVG3UItwRN0YezIXpOl/UEqABLX3epM0/fyQm4LFbZF4DJnkA1qQg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+kcVRB+XI8Gz86RStwKc6olqNEl7XLTYwJAaJ6zvF9NSD/t6Vc
	hQEncHUMD94OuRAgYu/A0YIl//pFokLij0FyYI4el1vRBCJO/WhDGoR/Or0JmMhmS2BbBNeVeG/
	+3h1EhdxfdARsWytkyzVsfixqvYgXSEikHXW0j79evrXiD5ctE6SQXo1NPaOHc9MnAftzoA==
X-Gm-Gg: AYBFou1CPEHfFseAPDXFP09AC0TWvZBLjS2n9ZSJCmhLNb6CN0+H+QIPN6UrKD02Pei
	SXazKE7lAME8DGY+p5vXBMBwSNkoYTDzXWlLd4ZYNn8Yw2W7myu6howf4o8e0Hu2mRRM82kAsZt
	JSS7EN/6aPhozzpxmdwzm6U0CnUQCdcSZGpdwTb8flioAbGaBT4sq4W+r8Xr099weNJPjTtN6FE
	iWJEt8xkH0t+4gdzosOOwReUwpEw2l/CCMZPDc1ZYqpi7xNUNAo7XMBlfEq21VG0BQg5g4aLH5K
	ju2I2xEyTBu8J8ByP6d07NhJD2hk800zdNAsVJZBzlfnRTr+u1YStobVsf4i04XrYe/SA4kmHNh
	yRyBm8/JJlXc8WnViNMM69aU+8Pbsc0Qbxa8ML68XQCIHuaXbe9fKzXzZRnvIj86hr5Y41jI5E+
	BnfXESiQcj
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971955eec.20.1793985321808;
        Fri, 06 Nov 2026 09:15:21 -0800 (PST)
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971885eec.20.1793985320950;
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:25 +0530
Subject: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
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
Message-Id: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=7235;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=llMLpfQId9UaG2rP5mXxqKjE8GpDMlcPgKGb0UPmgHI=;
 b=xOQtRH8sZwd0gtSU2fFskz28Dk4hc+HSvL1AZEsMm+mQ6tli2NY766/rhiLsr2TyCT8PTBDrr
 OAMPQHcGFXHDLPeeE1jhZGBbjPHAf+2djrReXZOQxJ/wO2HIwXTG48h
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: tGPyIKsoP5DuUNies8CPYODZEFxo9ULO
X-Proofpoint-GUID: tGPyIKsoP5DuUNies8CPYODZEFxo9ULO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX9WeEjPo2aHy3
 72AuvtyRdSrG1Z0muIbS4F0leOGG9UFbsctC1IoUq+hRE+rd88vYNDJQl2KlVtSd5K7RyI/S28B
 Wh8EMhNwa60Z5dmXXx9CSc8Mhm61+/8=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aee0b2b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ljjM-8V9AhcL1OkpCucA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX5vNQLMrSgiS0
 EZwRw+r6Nk0duHs2KwysGwRwwil/xaDk7/sqjs7K8uUOpx/8BHz9dar+VOlz/ctHDTNBYOrTPB7
 9XI7JH5mVmKegwiTME0rX4qBD1mzlsOjWZTGvvRPOnTuUEqNxmCAm+7sqPmSQCP6Ce1xWsSfrJu
 3jf5gooQv5PmsM00zpeCF1h8VDWOK6c5K2nsekQs4vcgheuQFcW7KjrTFj2xcYzIJGZj72g5U1s
 WWFRe46kmzGnsVj5mQakcQX5Ooepd5GWAlUmf17DgBxRL/iuPn/hpTiR2mYzHV9GByjbwrWJPMl
 fDzX4mp6ujPIXI1/aYtrF7wJHB4td0iOElDoyPDmO7lQEqKeR29gl9UzRo4PfexvZQiD0qpf2fr
 dMgzeHH22JrrneaQJnzblfAi/g+Zvs8g72M7vzsbZJgkpQqadSjbWM58jSV2bqvGY7ZmD+v0iWX
 2A/+g55UZ0iDUjFhkKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
region can be larger than 4GiB, but its length is stored as size_t,
which is only 32-bit there. The length gets truncated.
Use resource_size_t for the length so it matches the width of
phys_addr_t and holds the full size of the region.

Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/amd/iommu.c       | 2 +-
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/iommu.c           | 2 +-
 drivers/iommu/of_iommu.c        | 4 ++--
 drivers/iommu/virtio-iommu.c    | 2 +-
 drivers/of/address.c            | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 include/linux/iommu.h           | 4 ++--
 include/linux/of_address.h      | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec69b346d1af73241dfa51393b0851a..179e6c28afe6f86c233d9d7e64abb0870095e985 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3327,7 +3327,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
 		int type, prot = 0;
-		size_t length;
+		resource_size_t length;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e025245d4b42c4a9f765c67d708d4..70e210ca085ff52519376358a3e3b7a01619d7a8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3535,7 +3535,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 					  i, i_dev) {
 			struct iommu_resv_region *resv;
 			enum iommu_resv_type type;
-			size_t length;
+			resource_size_t length;
 
 			if (i_dev != device &&
 			    !is_downstream_to_pci_bridge(device, i_dev))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcdc359d936234bb3f8631306c8786..18f3efb94043ace9f1f4abc7c6ac8974dc25b0c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3010,7 +3010,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
-						  size_t length, int prot,
+						  resource_size_t length, int prot,
 						  enum iommu_resv_type type,
 						  gfp_t gfp)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..5c266511db78910d6fd221af5437cecff4931c22 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -170,7 +170,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 static enum iommu_resv_type __maybe_unused
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
-			   phys_addr_t start, size_t length)
+			   phys_addr_t start, resource_size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
@@ -246,7 +246,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				struct iommu_resv_region *region;
 				enum iommu_resv_type type;
 				phys_addr_t iova;
-				size_t length;
+				resource_size_t length;
 
 				if (of_dma_is_coherent(dev->of_node))
 					prot |= IOMMU_CACHE;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12227e69aedbc721cfd49cebde2ef..a37e713b0678a516a777436d616f0d3df54eae38 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -483,7 +483,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
 {
-	size_t size;
+	resource_size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
 	struct iommu_resv_region *region = NULL, *next;
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 499d37ceae210ac844eef853aeecbfabaaa5e138..f665432638a6d1cc1ebfc0d2356b813c8c584910 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -655,7 +655,7 @@ EXPORT_SYMBOL(of_translate_dma_address);
  * Returns a pointer to the cell immediately following the translated DMA region.
  */
 const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
-				      phys_addr_t *start, size_t *length)
+				      phys_addr_t *start, resource_size_t *length)
 {
 	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
 	u64 address, size;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f7addfbe1aab4f6fb662b8b2fa66bc02d98b5f03..9f508143505ad9e603af1730e811c30bd5edce16 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -164,7 +164,7 @@ vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
  */
 
 static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
-				      dma_addr_t start, size_t size)
+				      dma_addr_t start, resource_size_t size)
 {
 	struct rb_node *node = iommu->dma_list.rb_node;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a3651419679316c5a20cdf049efeaba..1d8f9381a358ec2309503bfe2866f08a1f236b2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -306,7 +306,7 @@ enum iommu_resv_type {
 struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
-	size_t			length;
+	resource_size_t		length;
 	int			prot;
 	enum iommu_resv_type	type;
 	void (*free)(struct device *dev, struct iommu_resv_region *region);
@@ -968,7 +968,7 @@ extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
-iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
+iommu_alloc_resv_region(phys_addr_t start, resource_size_t length, int prot,
 			enum iommu_resv_type type, gfp_t gfp);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 0cff9036539168b0cf2826ee34417738a4836ace..ae6d96c8c110adad966f2c1bad2cbefaf55e5c57 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -56,7 +56,7 @@ static inline int of_range_count(const struct of_range_parser *parser)
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
 extern const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *addr,
-					     phys_addr_t *start, size_t *length);
+					     phys_addr_t *start, resource_size_t *length);
 
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);

-- 
2.34.1

