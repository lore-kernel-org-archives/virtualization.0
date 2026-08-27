Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E04949F6
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846930; cv=none; b=H3eZaNBx3jDz84XNnAnUr1Cox5j16NXHzl2xHcqMvqUi0DtG0cktjZPOc1bL+T//E6auKrGMiDh4dVpW36TYwl+u+f9UbpAq++5aMne8AQpzXqtA888rjaHWbC2GM2W9TrlR0OkT8jRx+Hz6HtB9jZ7XJjirMbYP/kb8k8rlEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846930; c=relaxed/simple;
	bh=FOQ8uDheGL0RiZyjVAqiRMkhp79Dx5PmAY0sqwohPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0jgF+cn8ovOF1m8bBp2dpscESL7XbunoHiV43i4vpLs43w0lvQbx04KsbhYkxHiG0Zakvj7vbKZCkKZ6SPgrH2Jh94CbCgg9HssvXgBBth2AUT59s4TeoxwLfkJfHXxRlKbE0pHdTyNAQryRuadbaJ3qM57o3TSWvIFjvaHxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngeJ6rmb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T0DO0dzR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngeJ6rmb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0DO0dzR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RG4Asc342098
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gw7Hc5+BlXa
	fOfOrerU1qnVYYtDHdeXg75QOvio0igY=; b=ngeJ6rmb3+FSRoyW59SrAQKyeBy
	e0tQQsPJHDCRlxDA2TpQOzKZqQMuSYR0lvNxHQQtzxrhSKYCQUnBMzJI1s7F/cC/
	JSVIjvTjHdA1xdr8jElpBGflgaxLFmO08iyP4Id+Y9HvfRSaASv1UmyzDG6yKuoS
	CHaeGAmrHbXD3csWQXIKMPLkpC2+8fpeovuDbKHudegJBPAkhzLl4sDXj95gcmZp
	ywejjJY4AhokfhCdLAH76cdmz5mijD6wMh1W2UDf26kmKNhN0kIBQQDz/Qo1jr9R
	1t7Q37QVvD7o5Nt/759glFLvhoRc5FmY07a3S44l7cXPRcbsD0Mqb8IGTaw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee00s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so13392095ad.1
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846927; x=1788451727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gw7Hc5+BlXafOfOrerU1qnVYYtDHdeXg75QOvio0igY=;
        b=T0DO0dzRKNF9+95LWxCzjvdsONb8kf19eX57UBOpgJM4U+fG7yZp7WW9GbnX3trxhs
         7oHK5RrPgrwjkhyfybM1+FTcmZZ7LWMVXSRUT30pLebLW/fa+KDQrMvCxq4YLqS+kSfW
         hE5jOy3fsNKBIIKxmx28j539iAAKNECNcF5i2K0zsRxGnBFoox3ZzUHaU1clH1KUL6jt
         T/v2TMQiDwz7CG4zFVALKaWYe9yRiWQ8d5hIvCgq67AEHMfo1gyp42L/8aUTP9+aQ2mo
         cvlbIc+OoqywtxMdXInTZbB2zbukNxQwdciEjnQkm0Hr5hqxLbktLMPa+Oyy6i/cLbxR
         WJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846927; x=1788451727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gw7Hc5+BlXafOfOrerU1qnVYYtDHdeXg75QOvio0igY=;
        b=KFNl/hbQGpZwTGYOeJr3SXbl3OnhJsQb4WtUsOUFFW7JrBtAswQN/DWkLLF3oiugwf
         mohLLhSUvsHmgR41ycnk7bRBvSG83u0ZEnu0P/uT4BntrxkeDbVNy2zmNxRoytJbLKwI
         ogL9ohH3LbfRj9SDXkQIbvDXYIbmWUHyFKg1PM8YWqYjQDX0HaYXHsFO00wRbHMZwV8m
         Uwfdp6Gx749Jx4kisEMGXqjYUE2WcSwfUrnwX3qvHm3FGn65RGoC4mxv4rOkw6ud7Iqe
         VZ03Mz71E7Ij2g5y+wMpOk6G78njCqP+v+KLjLo2esR6Y6GmewUDQfuuVAeZkQMtrmAN
         ix9A==
X-Forwarded-Encrypted: i=1; AHgh+RrlV+J/pBtkq2X2kPcy1r2YxWTApC+9SHJZXmL74niF5llh64bdR00rG8HQsoBxSyhalV2iuHmMFQQm8AUEIQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n//2J3wYcQzpX7S1zL/IMqE4ZDJf9vDlXCmI998kmn1bhlx1U4
	ugwpn7imGFWZYTt58O9UExic7Nfqra9TQFYnaTTAJakqZoBzJRHhyRR4yfEINAjetq6G2/A/f8p
	LpWKdyOQPB81UEya1ZAItRqkuWURnCxcrzA27TVIZ2ib/B1/LWnrXh7gIMhNxWHcqt/t+Dg==
X-Gm-Gg: AR+sD12sHAkDipYgC5+itr8JrNP5Dpe+jHehPClLSvSyA76JI2Hf4jj1vduiZdPhyHA
	hWRJckej9ZlegMKtfN9XYM78ujVJlO9+qWWmdtr7KVr/GHIKM8DZ+04LWQEccl5nrE8MxcpXYai
	sVy+0uRiEVq578CoFog3Mse+5oBR0mTc1Sr7u+AjovSoDsJshP635CNCFhXJzf5nFan03J0i2Vr
	sXgiYsspzL4JNnt9pIuHJBbRXroS9iZRMyZlabrKQiL34y0mqZqtqEItDJYGNmHfrgzibne2yao
	PVMKrWir7q8pnkHebmiPau2+txXRARRfIuvAjVzvW4jY10SV5n2cce6/YEX8R0UPvL/wTNQSozY
	Us2iLIPhHde8r2JNlUs2k7mHiEe9DwDaPV7+2IPrEQ9ZRnvwZk83ZeL+nN1E=
X-Received: by 2002:a17:90b:1dce:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-396d0eba0c5mr359719a91.5.1787846926977;
        Thu, 27 Aug 2026 09:08:46 -0700 (PDT)
X-Received: by 2002:a17:90b:1dce:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-396d0eba0c5mr359631a91.5.1787846926458;
        Thu, 27 Aug 2026 09:08:46 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:46 -0700 (PDT)
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
Subject: [PATCH v1 11/11] scsi: ufs: ufs-qcom: support ICE keyslot partitioning for guest VMs
Date: Thu, 27 Aug 2026 09:07:20 -0700
Message-ID: <20260827160806.1295313-12-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX15JTHyMM/VXS
 ylHFXbpVNWoEBQC+LZGGxTkO3CKvSAkkeZbbUrlv7DVyFa6wdhZzkvcRG7n64CECiFJOL9DGsfr
 tZ1NEJIBATxJYfxpeEMPO3kK+VQf15FQLkKYc4tX2GXBNHkbW9mP1pmDWJDjuuwJe5V9xq4l9rj
 zWUdo+FVhdT0NTPst0uoLjj1fsuJxbdiqVBADQ63ndUe/nZtFL6r3WJjwJ0gx+hE4YBwBsXlieq
 GLsbchDrvhRnikfP09WtBCveE2c0I4aHayUs+HDHR8GnrELggmR1Pq+blp8WOFK5YWQBkfzx6+P
 mgCdUoWj/luvbiLXesXt8eQaLhQUcF3c5yuuSzlKb9m5+aCvIDg4tbHSwqa8mHf7VT7OC2SABcv
 YE7omnbHQo83TKL67VQHZDqxsL1frQpfo40OQeHbcE3f/6rZEkQMmiL9G4me5axM4uaTgYQqCwq
 /QJ+IY1Os2CqCxPhTYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfXzSUsC39mjqa4
 Qbnx9h2wwEziMPh4UGG9tXdRJERbSRGDty5DVsE6F2TaSUpe8ZJjgOk5lBXyt1R0hl3vWK5zS82
 HMD/HhnkfP3NlP06f4msdNuuv3YW17k=
X-Proofpoint-ORIG-GUID: p3qmcQKhZni61rKBz8AnvJ6EAVZrqiJA
X-Proofpoint-GUID: p3qmcQKhZni61rKBz8AnvJ6EAVZrqiJA
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90610f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ui157SQb00ZPLHfqI5IA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

On Qualcomm platforms where UFS inline encryption is shared between
the host and guest VMs, the ICE hardware keyslots must be partitioned
so that each VM operates only within its own physical slot range.
Without this, the host's blk_crypto_profile would manage all hardware
slots, conflicting with slots already allocated to guests.

Add ufs_qcom_ice_parse_slot_table() to read the qcom,ice-keyslot-map
device-tree node.  The function parses all child entries and validates
that no entry's slot range or the combined total exceeds the hardware
slot count from REG_UFS_CCAP.  The first child entry is taken as the
host's own reservation; its slot count and offset are returned to the
caller.

In ufs_qcom_ice_init(), use the parsed host reservation to initialize
the blk_crypto_profile with only the host's slot count rather than the
full hardware range.  Set profile->slot_offset so that
blk_crypto_keyslot_index() returns the correct physical ICE slot
number when programming hardware.  If no qcom,ice-keyslot-map node is
present, the existing behaviour (profile manages all slots) is
preserved.

Note: This patch is submitted for visibility. The ufs-qcom driver
gets its max_slots and slot_offset based on the the current
DT-based keyslot mechanis. we are aware this may need to be replaced
by a TZ SCM interface, submit it RFC for design discussion.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/ufs/host/ufs-qcom.c | 91 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 62396212a0a7..0611ab50f4cc 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -163,6 +163,74 @@ static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 		qcom_ice_enable(host->ice);
 }
 
+/**
+ * ufs_qcom_ice_parse_slot_table() - parse qcom,ice-keyslot-map DT node
+ * @dev:          UFS controller device
+ * @hw_max_slots: total physical ICE keyslots reported by REG_UFS_CCAP
+ * @num_slots:    receives host max_ice_slots (0 = no partitioning)
+ * @slot_offset:  receives host ice-slot-offset
+ *
+ * Parses the qcom,ice-keyslot-map device-tree node.  The first child entry
+ * is the host's own reservation; subsequent children are guest reservations.
+ * Validates that no entry's range exceeds @hw_max_slots and that the sum of
+ * all entries does not exceed @hw_max_slots.
+ *
+ * If no qcom,ice-keyslot-map phandle is present, sets @num_slots to 0 and
+ * returns 0.  Returns -EINVAL if any entry or the total exceeds @hw_max_slots.
+ */
+static int ufs_qcom_ice_parse_slot_table(struct device *dev,
+					 unsigned int hw_max_slots,
+					 unsigned int *num_slots,
+					 unsigned int *slot_offset)
+{
+	struct device_node *slots_np, *child;
+	unsigned int total_slots = 0;
+	bool first = true;
+	int ret = 0;
+
+	*num_slots   = 0;
+	*slot_offset = 0;
+
+	slots_np = of_parse_phandle(dev->of_node, "qcom,ice-keyslot-map", 0);
+	if (!slots_np)
+		return 0;
+
+	for_each_child_of_node(slots_np, child) {
+		u32 off, max;
+
+		if (of_property_read_u32(child, "qcom,ice-slot-offset", &off) ||
+		    of_property_read_u32(child, "qcom,max-ice-slots", &max))
+			continue;
+
+		if (off + max > hw_max_slots) {
+			dev_err(dev,
+				"ice-keyslot-map: slots [%u..%u) exceed hw max %u\n",
+				off, off + max, hw_max_slots);
+			of_node_put(child);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (first) {
+			*num_slots   = max;
+			*slot_offset = off;
+			first = false;
+		}
+		total_slots += max;
+	}
+
+	of_node_put(slots_np);
+
+	if (!ret && total_slots > hw_max_slots) {
+		dev_err(dev,
+			"ice-keyslot-map: total slots %u exceed hw max %u\n",
+			total_slots, hw_max_slots);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops; /* forward decl */
 
 static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
@@ -173,6 +241,8 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	struct qcom_ice *ice;
 	union ufs_crypto_capabilities caps;
 	union ufs_crypto_cap_entry cap;
+	unsigned int num_slots, slot_offset;
+	unsigned int hw_max_slots;
 	int err;
 	int i;
 
@@ -192,7 +262,23 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	caps.reg_val = cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
 
 	/* The number of keyslots supported is (CFGC+1) */
-	err = devm_blk_crypto_profile_init(dev, profile, caps.config_count + 1);
+	hw_max_slots = caps.config_count + 1;
+
+	/*
+	 * Parse the qcom,ice-keyslot-map DT node: validate all entries against
+	 * the hardware slot count and read the host's own reservation.  If no
+	 * partitioning is configured (num_slots == 0), the profile manages the
+	 * full hardware slot range.
+	 */
+	err = ufs_qcom_ice_parse_slot_table(dev, hw_max_slots,
+					    &num_slots, &slot_offset);
+	if (err) {
+		dev_err(dev, "failed to parse ICE slot table: %d\n", err);
+		return err;
+	}
+
+	err = devm_blk_crypto_profile_init(dev, profile,
+					   num_slots ? num_slots : hw_max_slots);
 	if (err)
 		return err;
 
@@ -201,6 +287,9 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
 	profile->dev = dev;
 
+	if (num_slots)
+		profile->slot_offset = slot_offset;
+
 	/*
 	 * Currently this driver only supports AES-256-XTS.  All known versions
 	 * of ICE support it, but to be safe make sure it is really declared in
-- 
2.34.1

