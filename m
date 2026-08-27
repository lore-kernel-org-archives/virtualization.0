Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8D486E6D
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846922; cv=none; b=T0gFpdO3kOOt8qp3VyvHGBa3x/lL8dv22Tf90OYCdBBaCfcALSq6SU56qSXdJvz4jeeiajS4Cz6aodC9Go1up03hZOVhNLoHVFdiIEh/IdKK96X5f9nxmX1rG9oEdlNv/QMKF9PyaeT5ifpoI9vX/C1MqwVGEycGaKhHZlxPupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846922; c=relaxed/simple;
	bh=XzVRSJskkXzsRQMCF0q2XHzItKnQaDkIqK2bV/uMi6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZWrG0bz3UJ1YE4vnViCkHmvP2YotcVGO8pbW6ocbRXAhX+aqeb802v7pMCv15Q0Oaw7XlNEZic+wbIE08UjXiYGasu1jZhGaazHTKUXaTVGQQAFbP/yyelXZ+oT74OpcKXrXTESSLtI2WbLlCsD0diixcQYd21zAQg+XDOh+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFwTjd6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LyXWt7EG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFwTjd6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyXWt7EG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbsW9618149
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GQuf/V68eCT
	XXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=; b=oFwTjd6O46+rn3wQuhLnjLfejRI
	JzlkxQSt3yFeu41vHuEDRwREWQb/MqlkNuVm1K7rXRrb1LnCdn7kasEpR73XcA4I
	0RUsK5WYrYHBR+ekT3kOuxUJTj9DvpOV7EJQJZ7kZTPydi9vTE5SM5FJFJaM4swO
	6cx951RiLv1XwxTtlcUdL7qyWC83c9a0lrDN9Ro7St3H1fkKn1PDPGNdgkyYf+n4
	0I05RdmD/c3T6KmB5Jo2tG6ZNq9g0uOiMJHwGomEX1zaxpZNwDz3WJFIzCPUKQC5
	VUHQzo0KHoD6lNydXTaSoa7h/p4k7EROq3txUc2+bYHsHO/xDvwP/N2vM7Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egmkw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so49621a12.3
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846917; x=1788451717; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQuf/V68eCTXXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=;
        b=LyXWt7EGtzSmU+Rzyg8yn/ve0eW60TuZBBfMogcl8/CU9SMjXian1pQIPTb9eSaKYP
         cXuWCWu5Sm3bPmFGHPXQBSLF8N8mSoCt3adqVwafzZ59ajSFe3A7LCqkcSoS7WVvuoPE
         RWWhME3VPCKTysT+51jnuvNdfak6ZdPHa2TNYleTxDnRzyuG+duESwjNcv/t0VjUydVk
         9aEH659Mb4JPDuEzG4yruOOo1mnDXTxx1XtUuIGrRrKj1wFUWUnsT2yt3gFkGz6Yjn0j
         7H/ci9kawmFT7+qBOWUl4qepkYOUbnAUqWm4b8nm96AHTprNeSu1IZvSYuey7G0JMtG2
         UT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846917; x=1788451717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQuf/V68eCTXXH2b/XlQO3XYqlyP/kTHk7utlZNkRig=;
        b=i47r7nyFj8Ps4RLKqiIXnEhuW1bf/xpFlriuZiOttcqnbiFQU8YVcN4eFoTuD0Qmof
         6KniwEdheI+jTvLRQHDM0xb00WuYAFa2U7FRJ4HdivthmSPVSpr/qJINAfaRKVNUoPXB
         1mrIEgluUytmtpO5ba6hSUEXkE8h1OXCDgcDgP7HTHJOZHknvd0VwBCuCQR/GVLZAmWh
         gZDoN4e8QIx3j2efxmns42L5SUDz8aqLo9OKAPNn5aGgKIkQi0qGhN5tqKBEJvUxbgG5
         S6UZHqxEaJfOfqBVQdODlm8MbSTRQyQOfN9mSXnfKtitP3bK1MPyXW6YxZMd1N+vaTQ2
         CcTw==
X-Forwarded-Encrypted: i=1; AHgh+RruVL57DAN94OUdZDxMaoX7sO1n706weCevxOyUWFqd2BBgrbe7Ajg9OATx7p4ZbGZ2KcFBObcdRAEyUoKuVg==@lists.linux.dev
X-Gm-Message-State: AFuF++kjwot77inxYwMBwiznxfW+4itQ2oN6YEdqWQEB25MUGewrzplK
	Utbb3T5aaH+1e6TBUu8jJoHSp6qTHCe7qZzdeVa4ecrLUiDdG+kkHt1uoaiZG4hHEt8ENqU4COG
	ULRv9gdDhT6EYPmmOQ8ilwnWEBXEMWUfCGx8ljG4oxK1Y3K6+qWkk7kTBk8PPj4w7KO0tAFTLq3
	l/u3Fd
X-Gm-Gg: AR+sD10y+W37C19KKu3+PmtGz2YGjTO0JNRHlNFn9D7HBDA/3P4x77QctIQHd3L2Wg8
	X1YHMnHxqikriJcXZiwKQ2nHb5b2nAqam5EJdlUYh0xxluDp68zHeIYKJUzN5DOB/CTkbbF0eTq
	WjVho9b3iqQkqTaIWTzulcALGzc5H2dIUgbDZKHLTzgFD0nJ+dTkKDIT2TWXh3mEh9pIu3toJF9
	AiyA7tZQJ+9TGvlknU85Y/3A0EH2NJ5NxfXDkWzXNQ+e1aFKmCa8SFSQksAyVWjV/iaQTlI6V8m
	iDiIUWenuyYJeFe0rSovbBzej+oywnaNSECL6IY4seI2cXN4urgE+0wI1FlIQG2N7DpgDA88+U8
	a1hUCvj0xJS8W7hY7HkHa45qRYMh/Do28VtPgfQUyHij/yZMAciHDFI8Nbtw=
X-Received: by 2002:a17:90b:51c7:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-396d0f52b2amr503446a91.15.1787846917350;
        Thu, 27 Aug 2026 09:08:37 -0700 (PDT)
X-Received: by 2002:a17:90b:51c7:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-396d0f52b2amr503276a91.15.1787846916655;
        Thu, 27 Aug 2026 09:08:36 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:36 -0700 (PDT)
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
Subject: [PATCH v1 07/11] blk-crypto: move bio_crypt_dun_increment() to the public header
Date: Thu, 27 Aug 2026 09:07:16 -0700
Message-ID: <20260827160806.1295313-8-linlin.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 7Z1CRoZKbWAjQFnF8gEhKqXgNiPEeNLV
X-Proofpoint-ORIG-GUID: 7Z1CRoZKbWAjQFnF8gEhKqXgNiPEeNLV
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a906106 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Dog9NmGJ06mbJvtOeFoA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX0PX7TgbGQhIM
 3buxTDbzLIdjj1rfsu/+H8/I9wR3nPsZAdv9bUkFFB3MnuRSQJbMuKs5ck1w2JUD6dM5buboe0f
 9SPTXXqj1+qC7nKHXkj2e9aXU/orvvkPIspeZkzHSfBT4keb+8Jhv64KhFuDFmDAPTO0tzDUIge
 y4zpXH0Lnz8TB+VsAoukqj+O9yu4nyc2/J+wOEIeXB3DzVWCSVvjRn+BpuPFg+dPJwJARVDI7Au
 v1Ef9iLIL73klCkLpC8t0gJpn2KjFlbFkI3LijDhwCJZphG4J+zMYI10p0HQTC8spGB3nYMK8U1
 6rjst6f9DVfcjmkvBJT9ccqiDPA/E6sI2I8FIt5i1BNUA5d2DhKgPsCD3b7ejET9R106ATFulLZ
 rSK13X9B/Jy4oTBuIWqd6E3w3u7T0CDkQeFgSF6dhKHz7JFQV9/nwW45hCPdB0+su5K6L/2qhtq
 dInYs+wWI13tWFTSzRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX4E2yEhxmvzyf
 O+wbZRB1F1TFIaLDhOuuHAUHpA7Gw+ibiUz0LIy+Dan7mfXyl5KXJo/tD307iXdOUGPqF90/jbZ
 Pv/osvqh7/Egx3S+5vgsQEa967HULQU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

bio_crypt_dun_increment() is currently declared only in
block/blk-crypto-internal.h, which is not accessible to code
outside of block/.  Drivers that manage inline-encrypted I/O
directly need to advance the DUN across bio_vecs within a bio,
or across multiple bios in a request, and have no other way
to call this function.

Move the declaration from block/blk-crypto-internal.h to
include/linux/blk-crypto.h alongside the existing
bio_crypt_dun_is_contiguous() and blk_crypto_init_key()
declarations. The implementation in block/blk-crypto.c is
unchanged.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 block/blk-crypto-internal.h | 3 ---
 include/linux/blk-crypto.h  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 04035d237f03..32c720aabba7 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -26,9 +26,6 @@ int blk_crypto_sysfs_register(struct gendisk *disk);
 
 void blk_crypto_sysfs_unregister(struct gendisk *disk);
 
-void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
-			     unsigned int inc);
-
 bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
 
 bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 33ae52b77522..c9f436b6b2ef 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -181,6 +181,9 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 				 unsigned int bytes,
 				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE]);
 
+void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
+			     unsigned int inc);
+
 int blk_crypto_init_key(struct blk_crypto_key *blk_key,
 			const u8 *key_bytes, size_t key_size,
 			enum blk_crypto_key_type key_type,
-- 
2.34.1

