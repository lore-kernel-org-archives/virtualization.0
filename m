Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B0488238
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846911; cv=none; b=XFEhejLBnIww1wjyfuhFflAPCJtShW1X/BQCqbue829qOG3AQJH6eni3cinOO+doXMIx2T4AD0EQgmjNRutNdtIyNPS1RInkoipGfNnano/yLcjHYwvM/Ns7G3Dkrr2C04tJfUt6SArkbvvmcMJtMtS6kHyM9fXVCd22Vr8TUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846911; c=relaxed/simple;
	bh=fVeZw9EDi7ERA4LNK8w26r8i8AIslzVnGqRWpyHht7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsYRBujyPxfEykn4X08orbNhXs6kZxdx8wz5W/CbEDEfQaTUuOSga9F1uIwTSHK28o6OM6d0hZysUNC5q4i9PPAkdpgUKc9Rdky9tUFLas6CmA3lCtCONr9i5ov4H3wJQiPFyynfylozQFyhki5k9dhTp4b2/sF5sMuY/7zT6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2KWwxIF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZ5tqc7g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2KWwxIF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZ5tqc7g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFcOAX3360298
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Tb6pSykcv9W
	jH2s5aqk5SoF1TrILL2gUQOLQeoLKEig=; b=Q2KWwxIFk2F/i0p4ivIdce28hi/
	Kfsvpi/llW7MriXLEr1R0lJqVOkL+SdAqphOorZ6C9TBaPJXTJklaz1exwKCHVRl
	3rDnkKEOvS71K/HuQMf5/kLeEzwBlzwqd4p4EuIdd7Y1USbAcCEW5LMRYI55Aao0
	TaObjUU00cbV4mCBt5ClP0WkQmXvuoobdPr8eJC20Rkgb8HBUSvDsJmj2tPHmMME
	6gmyuVtWum1Pg2myTCpiy/9Cv57OHsPznzLt5LUUE34y5tfhFlliVQpzSTEHmK2z
	dFxWYzr4y3HKTO4FolcMpJwWVp+aNccuH6ZpXECEuZ33SJuXeHadtWd5YUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t39dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso166120a91.2
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846907; x=1788451707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tb6pSykcv9WjH2s5aqk5SoF1TrILL2gUQOLQeoLKEig=;
        b=CZ5tqc7gJQI2WcANvuJQaGhjzxAWTgDPUFlSATsWiHZ5LQqbuxSrQIlA6ZB0Ew/GLp
         GOczPXVkh5olfZeOzp1xXnI8v44ZddN1Ao9js8RqYMNhvYQn8LjdYCHH/ijBLY6Up0Mt
         uPYwfhSzsQc8qdSLL20A1uOjY2ubIVCxBNbqPxfwMUEzS9lM61+UBjLKzScJL2nFcmn+
         8qxZhe4/6ilzLfBzrPbiQYP52G3060lLVgT7XgDl5hCCW9Iqj4dkfxNVOtWmmxUfoxXy
         KHmIIPD8206Tv+A4OLUCdfiTPtJsrfOn+NWk+I/w+D2aVve0nArDbkaq7isiMxbDxHjj
         cisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846907; x=1788451707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tb6pSykcv9WjH2s5aqk5SoF1TrILL2gUQOLQeoLKEig=;
        b=nwsF68WkBOFzGzfFrcuOOZ2+iUAbjvEpQCyluYOIuSRkhN4mlUsyu737TDLuYQ8Hu7
         t6GKj6LDVCO8d/ZUwAbctUx454eATUe8qstt1/mg1U7ID9qbkyOha7X28nMHL+WXBkv6
         x/TMI9n88FNMDmZht+FXnF2KGk4Ie6ccTNFx3F7uyr6vi2ZA9qlmwyKjVDqyhZaz1TjP
         GxCyMplcAX/fRteFbzAO4JB1S5wrRvbDUskNkx40aKDt/wWXUWS0es3mchl/C4MTVi/W
         2wPltEgBfAwp9zb0E8f21EDrOwpyXDMeyhmpp6q9my+QGJmpt2QsBY17iTd8CfI1QAKU
         0gMA==
X-Forwarded-Encrypted: i=1; AHgh+RoAK3sD2T4dTd3QXhcU4xniG2w9ucFyd4UjL+WGSWUFqbzNBT4xhhWs4VSHxz6rNnMluoTrZ/d6LMhuycNPBg==@lists.linux.dev
X-Gm-Message-State: AFuF++kEOieAh/9hUwzI4/Omg+S7JGP/DcY4AtmtUlUV+ZO3Bfi6pJ1T
	nrLfJgZjSd2RLz8WeyA7XY19rI7h3tEbrBes8Dj/CkMEUJdFPuTR20Ki/cEzDsJ+lqIYyFNxX0T
	8FyMJgs/PeOZvPsjNk1564Hyz5Dr4ou0Sqy9Qkjqjy/QYJ88RMXyj2udPJa7hTtXV6Blm1g==
X-Gm-Gg: AR+sD12l5pj3l9S7sYcTj6dPBBilptztBsnpuBZGk60sHIRt7Op9YxnHW2sQeCnkaDm
	BlY9GleqDvwGw5r+uzcU5no5uptoVZjmkT+9YN1NP3guCrAlmPGYrYysCS02yHn7Zh0XRVzeM6s
	43xg1Mfv4VrYchCOX5/bGVv/9qGjVvtrjxCLfKpTsSbZK9dharP1hL3gCpO/aFHPXxrUMpLyqSY
	+45cMAqnt2Hn0SyiraH73ZGB6nlSgu03YBrYSzRARvMSfJ3G0QGi4IsBRYSRig1Cic7RQuieRc9
	mBgm9bsCrtFJ6OySZK7GeU1Res+ORvj35la0M3IjQ3FXFlm4ZMbe/glpkKLUx1jrx3f0mJD31OQ
	cufwmarVZXVvjVylacH/Najpl6s6S0/718JS3QuA989v0VsAPoi7xch/S42o=
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-396d1023217mr343746a91.14.1787846905101;
        Thu, 27 Aug 2026 09:08:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1d83:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-396d1023217mr343639a91.14.1787846904578;
        Thu, 27 Aug 2026 09:08:24 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:24 -0700 (PDT)
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
Subject: [PATCH v1 02/11] soc: qcom: add crypto_virt backend for virtio-blk inline crypto
Date: Thu, 27 Aug 2026 09:07:11 -0700
Message-ID: <20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a9060fb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=EqLUM-vDyOCcG5bjvusA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 9zZXD0AHK0VeOc2Nx5bT2hdjNlIIsQ4N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX+WHuQFiWd/Mn
 Xs/HCc9ePTvw9IwJ6O7z16giejpfDuSf26Xxg9soldsinhgxVNxA2gtdlrkv9Fjq3e3NcGmuDTs
 D/SUH+lienQwaoxn5DWetfpsVKluYUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfXyb2OwHwTTXzj
 qdz5vJ3hBIL8EbASFKiPVm/Zuf71RpNpghT5/+dl0xb1BTOh/5jQN8lNVHqPOtcBJW4aHESQshb
 fudtsJ9uO4JqbzUp8aWoWLpUZEqhCXtRjBHkPnP7QiS64HbQIU/UdF9jiBD+qKL8f9tk/XGyvZd
 CbUKilahLOn/CX2KfuHZgrBJLo0kQANRU4szUL9hSO+lkjaC4CnIXeKr3wCZLbl3hgIQqrF3qOi
 P33UQfvMk1rUtwAcgup1/2yBObV1vBI2B91YMOwcpb9jBq7LFlwyVU1hFNVicPbXSLn/HX5wM+4
 W4vGfofSjKlyPnR2qK0DICMFLfIT50QgduM9INOSBYTQefzVmbHU+QKzvO6P6qch7fTT5qqhwjD
 PK2ozlk0szyPY6q3pRkakCP5L7u5qxCFGDcg1yn3i3xLs7Mqmx/0l6gs1kVrQzb8wADDZSJT4L1
 KORpJWOADDW/EVwlbsg==
X-Proofpoint-GUID: 9zZXD0AHK0VeOc2Nx5bT2hdjNlIIsQ4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

In a Qualcomm GVM environment the ICE hardware is controlled by the
host, GVM has no direct access to it. So, key operation in GVM is
done through SCM calls rather than direct register access. In this
way the access to ICE registers are offloaded to Trust Zone.

Add QCOM_CRYPTO_VIRT, which implements struct virtblk_crypto_variant_ops
for the virtio_blk_crypto_ext dispatch layer. It maps keyslot
program/evict to qcom_scm_ice_set_key() and
qcom_scm_ice_invalidate_key(), and software-secret derivation to
qcom_scm_derive_sw_secret().

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig       | 12 +++++
 drivers/soc/qcom/Makefile      |  1 +
 drivers/soc/qcom/crypto_virt.c | 89 ++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/soc/qcom/crypto_virt.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2b524154d9fb..6c632d114d45 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -298,6 +298,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
 	tristate
 	select QCOM_SCM
 
+config QCOM_CRYPTO_VIRT
+	tristate "Qualcomm Technologies, Inc. Crypto Virt driver"
+	depends on VIRTBLK_CRYPTO_VIRTUALIZATION
+	depends on QCOM_SCM
+	default VIRTBLK_CRYPTO_VIRTUALIZATION if ARCH_QCOM
+	help
+	  GVM-side hardware-wrapped-key SCM operations exposed to
+	  virtio_blk's inline crypto layer: per-slot key programming and
+	  eviction, and key derive/generate/prepare/import.
+	  Say Y here to compile the driver as a part of kernel or M to compile
+	  as a module.
+
 config QCOM_KRYO_L2_ACCESSORS
 	bool
 	depends on ARM64
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 798643be3590..6d4b7546d1fb 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
+obj-$(CONFIG_QCOM_CRYPTO_VIRT)	+= crypto_virt.o
 obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
 obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
diff --git a/drivers/soc/qcom/crypto_virt.c b/drivers/soc/qcom/crypto_virt.c
new file mode 100644
index 000000000000..4ee2a36af6c1
--- /dev/null
+++ b/drivers/soc/qcom/crypto_virt.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/blk-crypto.h>
+#include <linux/virtio_blk_crypto_ext.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+
+static int crypto_virt_program_key(const struct blk_crypto_key *key,
+				   unsigned int slot)
+{
+	u32 dus_512_units;
+	int ret;
+
+	if (!key || !key->size) {
+		pr_err("%s: invalid key\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Only AES-256-XTS has been tested so far. */
+	if (key->crypto_cfg.crypto_mode !=
+	    BLK_ENCRYPTION_MODE_AES_256_XTS) {
+		pr_err_ratelimited("Unsupported crypto mode: %d\n",
+				    key->crypto_cfg.crypto_mode);
+		return -EINVAL;
+	}
+
+	/* qcom_scm_ice_set_key()'s data_unit_size is expressed in 512-byte units */
+	dus_512_units = key->crypto_cfg.data_unit_size / 512;
+
+	ret = qcom_scm_ice_set_key(slot, key->bytes, key->size,
+		QCOM_SCM_ICE_CIPHER_AES_256_XTS, dus_512_units);
+	if (ret)
+		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
+
+	return ret;
+}
+
+static int crypto_virt_invalidate_key(unsigned int slot)
+{
+	int ret;
+
+	ret = qcom_scm_ice_invalidate_key(slot);
+	if (ret)
+		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
+
+	return ret;
+}
+
+static int crypto_virt_derive_sw_secret_key(const u8 *eph_key, size_t eph_key_size,
+					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	int ret;
+
+	ret = qcom_scm_derive_sw_secret(eph_key, eph_key_size,
+					sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
+	if (ret == -EIO || ret == -EINVAL)
+		ret = -EBADMSG; /* probably invalid key */
+
+	if (ret)
+		pr_err("%s: ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
+static struct virtblk_crypto_variant_ops virtblk_crypto_qcom_vops = {
+	.owner = THIS_MODULE,
+	.program_key = crypto_virt_program_key,
+	.evict_key = crypto_virt_invalidate_key,
+	.derive_sw_secret_key = crypto_virt_derive_sw_secret_key,
+};
+
+static int __init crypto_virt_init(void)
+{
+	virtblk_set_crypto_ops(&virtblk_crypto_qcom_vops);
+	return 0;
+}
+module_init(crypto_virt_init);
+
+#if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
+static void __exit crypto_virt_exit(void)
+{
+	virtblk_set_crypto_ops(NULL);
+}
+module_exit(crypto_virt_exit);
+#endif
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Crypto Virt Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

