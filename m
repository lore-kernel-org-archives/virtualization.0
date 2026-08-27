Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399D4908A7
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846919; cv=none; b=SC6JLvTMQKhWm8a9FU345TL4JJAGti0YnY9o4yVLmPVocn0AYpQrTF/g00XncUx1iGh1kU8PqDl3BqJfZG8bZ0oaJeb4R9C8n5x9tbE3UHh9KPbhFnO9lv984/QbYTK8Vw3HQwzt23tfXSVM4P8geVHnpmbObAPNXz+at2fK1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846919; c=relaxed/simple;
	bh=64JBdKFV0k5ypJWDkUZi9BoAaRy3vj5flkXzPsq15+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ird4nLCscD52lwmQ9T9F5/IyCK6NWa/Zcd1TXLH8kh9ku/RlziPTuEhvDhwX0eK2AnGBZN3GT/jXWMzLnhGag3ln7OjcUDvSr5hHPTXIJzNhjg8zx1rQF0vIyTqbaozjANyVIjpdBkey50ba25CbYvNmLNAm4NM0no7kWMNT0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPF1CI7o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IqLwoTE5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPF1CI7o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IqLwoTE5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbetZ865924
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LltqfmvyZbe
	c4Bgt7eBZwrXubHQDa7pvwd5LerJQc3I=; b=pPF1CI7opY3gmcOEv1Jilno3v2i
	VEBF+as3yqfzBh2zg2eYzZiFmFnDo+X6GsLvOvU9SiT4WmrOfQn5cd5TmzH/Coad
	26DWBpSBcoxynbm9jm2Z/6zxi16RlVDGJkDYtLkCqKJkef2JOLzhoE8jvzBmCxX+
	yxe/HWSTuXXi0lIK8SXphg2qG4dGFy1XZFUoDhLHpVFklJbwQuUrGSVHC7uwxYIz
	mSKLBkCac+xDJ7N12ZlLJUt58yo7UZ28bF58nk5Jfit+2BHfwFaiMuEGZPNK931j
	zNMO0o/W/+OZ4keC04GduHPzR580l37NTVf/9210ndWufByfzcqn+ES0lDw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgv8m86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39640eebc57so154080a91.0
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846916; x=1788451716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LltqfmvyZbec4Bgt7eBZwrXubHQDa7pvwd5LerJQc3I=;
        b=IqLwoTE55Ehv5rCTgluKHru+QTxacGPVtW3GT4+omIxZOKEYJgzCwdW8DR8kIydf14
         2xlppVCQBaGTR3skndza2IaSR2cUF51H/0UevFpjgSwbQZvpl6ydPPglAlI29W3AnLwB
         DBzI1CK3esYjKWnOWuQBABqWI1BeDF+NbyMLjhB7nkjkY0Ub621nXauqrC26B+MC7eON
         OHxBUAUWMdJHjf/S5k9NbV4yVPM5sAXQu9OjUffjh7xBEbnckqk5Hh0y6pWoqeDZPqHU
         wFxGquBThfxKl+PGkyi6ljxogfqjVIzcO0r3u5f5WS8k7AviQRp6OVqUSEht4pz7IcQ9
         lF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846916; x=1788451716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LltqfmvyZbec4Bgt7eBZwrXubHQDa7pvwd5LerJQc3I=;
        b=eOLTjYAD1mVDmRkYkloQpnkrBPQ6OWhAtqEtAuhwM9LUnh8QsIrAsJX4jdpJe3KHDJ
         EJ2KQJioUijXGuLCbNCU3iP/bqm1vFeJNC0tdrpECKc7Rccg8tfggIUcOuB7Sm7I86St
         5PoZK0160eKKSzuo60wRI1EaO0GsUYljfj8CSaqje5f9X2ORb323pwgEDIo16grM4k3c
         q5l0fI0mnb1zaUudjQvw9eqCHlH8DfTDdZLYGBqGCaH2tn3ndWAa6VFykKjth/tNRxTH
         PelisxZfA2pe8YNIjtK8FzYbA9Jh5LRa9xTCNxkOhN+ksrkUCbgkXSPNCmL53oB5y7Wd
         SE0w==
X-Forwarded-Encrypted: i=1; AHgh+Rpkvw/Y7kUIOyPB7wB+eIlxME0U2xxb+IfkrO7vp7gYAMkTFLNnYJ7v8V4k9Wwt29+kVteSbgEZN8JIP7AAAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k5O/RU7Qpeh5gatIMkGNZE/IiZ7v4HU5V6bpDspzrLZq5BGq+T
	uSu3rokMbqhKJDp++2mTFfwQzltKK36XWkrqSpA+TK/rYiJf7urd2fIYxpEj+QmYCaVXSx4Ok+A
	lfvFli9Bil23Rs0W/gwqW/f237zb0ifsQ0Eax7lX54Ju2K0Upmc5cCQLga+l+vYWjNHC+6w==
X-Gm-Gg: AR+sD10BLU9X+b5QDMEd5YAheyeToDrTSlyeAyymXubL1cxsze2jlv9ls/zB2Z4MOfU
	1GUAPaCLBZ8olg2HRBpe7PCXW9tfuRgFwfMQ3WiXhEo4qv5+wJ9RGm7TH2I5uV9gWmTrsXjG/qY
	UsfqkiDGRufnKKH2pFn74ueS0DOUQCzXhfIOfvB4JET/OfDvw99ityjWeZI/S2ubuX3GJ41i0Bk
	zSyzsm6DyovAVCeNwUlPR4qpMzmgAaTVaPWcmcTi6RYoeHog2T7wijE6XetcJ66cOB7Cak/HV33
	lVgy2+zzlPpdUPimunaOC2h6tTFU1sJAvEfhH2vEsptHo4accK1qYKiSQ0NwX0p9Gwj/h2B+Lto
	0lOdVd9eyW4Ha3lByIIFCWD4uAJRboO1MiBE/oizK/sJFqbt+Vkn6cakn6J0=
X-Received: by 2002:a17:90b:4fcc:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-396d0f8fbfemr510631a91.10.1787846914813;
        Thu, 27 Aug 2026 09:08:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcc:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-396d0f8fbfemr510461a91.10.1787846914243;
        Thu, 27 Aug 2026 09:08:34 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:33 -0700 (PDT)
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
Subject: [PATCH v1 06/11] scsi: ufs: core: add slot path to ufshcd_prepare_lrbp_crypto
Date: Thu, 27 Aug 2026 09:07:15 -0700
Message-ID: <20260827160806.1295313-7-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: aMW9ah4kxZ7SKZ3JYo0WttbSSm2bhFtw
X-Proofpoint-GUID: aMW9ah4kxZ7SKZ3JYo0WttbSSm2bhFtw
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a906104 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=UfCYJ6Unc3kZa_kcAOwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX6t7NbHlX/+tT
 nqXia4Xox7HhMAkmtRNTtGH5D90yG3W8cnhzbvlFbZVU6lbt/MLB9CbzqBsMK6qSG7zcKbYASQl
 GAsCSeAMw5xLfV8UhrrEm3NZwCzUSIzFfTfBn7C2eUrFdUdK/uaCmpFY05DCmy5BOhGNlGWGQOJ
 A31dvVD0zLRSoejBOwXVTZM2VxwqSgm8FROTMepYkXhtwlw+upDJkFdiNVMwBNpTAXFyY0S1biw
 UDZMoOuob1xO0jByN3BFEF0L6fSeoniakwgH1o6vGXqo1CmTvTZFPxMSryyG1ZAczBF7KW7bqC8
 Vlaqos2rBD8YCK8rLnzKWaYwN95d8m5JtiTjoQGs+GOCqH9lCbVUspzGeRFvkV8m9ALqQlDSfGh
 N29X1O92jvOJD9uSKNKvkKZ3w1q2ymrdhSw1EHrtIDLCuBUBym+1JzGNkPBoYMT3JNsHDTtGPot
 oMj6meHm7u/0x4XEhLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX/7H5RmE8mKCE
 j86khHzkJiV12BYRn6OaWpG3A5y58kVYSJwLgHkahFIcJr85iSYiKU0fWqvdP/VtJzRk5XbZI0V
 LVpGdcp+fVOGx+M5zTUTX8z25e2YGf0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

ufshcd_prepare_lrbp_crypto() programs crypto_key_slot in the LRB from
rq->crypt_keyslot.  With the blk-crypto slot path a bio can carry a
pre-programmed physical ICE keyslot index in crypt_ctx->bc_slot rather
than a blk_crypto_key pointer.  In that case rq->crypt_keyslot is NULL
and the existing code incorrectly falls through to the "no encryption"
path, leaving crypto_key_slot as -1.

Extend the function to handle both cases: when rq->crypt_keyslot is
set, derive the slot index via blk_crypto_keyslot_index() as before;
when bc_slot.data_unit_size_bits is non-zero, read crypto_key_slot
directly from bc_slot.phy_slot.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/ufs/core/ufshcd-crypto.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
index 8f66db94e179..2fc5601c0f76 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -15,13 +15,21 @@
 static inline void ufshcd_prepare_lrbp_crypto(struct request *rq,
 					      struct ufshcd_lrb *lrbp)
 {
-	if (!rq || !rq->crypt_keyslot) {
+	if (!rq) {
 		lrbp->crypto_key_slot = -1;
 		return;
 	}
 
-	lrbp->crypto_key_slot = blk_crypto_keyslot_index(rq->crypt_keyslot);
-	lrbp->data_unit_num = rq->crypt_ctx->bc_dun[0];
+	if (rq->crypt_keyslot) {
+		lrbp->crypto_key_slot = blk_crypto_keyslot_index(rq->crypt_keyslot);
+		lrbp->data_unit_num = rq->crypt_ctx->bc_dun[0];
+	} else if (rq->crypt_ctx && rq->crypt_ctx->bc_slot.data_unit_size_bits) {
+		lrbp->crypto_key_slot = rq->crypt_ctx->bc_slot.phy_slot;
+		lrbp->data_unit_num = rq->crypt_ctx->bc_dun[0];
+	} else {
+		lrbp->crypto_key_slot = -1;
+	}
+
 }
 
 static inline void
-- 
2.34.1

