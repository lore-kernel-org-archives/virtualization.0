Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1E489880
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846928; cv=none; b=B+JENZf7vibUMtChsNlEeKkXCQ4jDG9JcLligXEf0KtqFVY9k529oZDiT06ZYFJ2HiAJ1300uSWTon2mInpxyJNjmgQAdChNjZpfziK3MeamSD2DE8f7+3NvRpOI02DpmY74rRPwNDsmNjG6EuAIB1M0tEp3xszfCxXs61j97Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846928; c=relaxed/simple;
	bh=oEtNN5KbRNMq2h6V0CnWjra0k2iO7Ns7CsfkpVo5D98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ckdxp00UI9APXsxmZTQUS9MfSfAHmlWJdNXn09hqZ2b1GlS17whcwvsUHP316yAvH3PF/wGLSbPc7rVIbBvVSEKmKfIlMm1jJHOo9oK5gkBgT+6pkHqenzP5guILjGQ5wVk5zXke8XhBmXRoUH9/RpMJ95vwBe+lLcQlyebjfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IfYIo5+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S/w3Rctg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfYIo5+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S/w3Rctg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFcOAh3360298
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqmAgGVZ9+r6xr3Nv5npOlTiLJ6Hzk9Y3TXQVd3sS28=; b=IfYIo5+kqfBeFtH0
	9uxPPIAJR780978nDcAC6P/1YM8DV6C5OpsrJZjy5TSFsc2PiuTSLr0Ir5FncXMt
	9mo+/bkHeLBlgNUxW8gfskKFe1R153+UvqnVyl8WcE49lOz86p0I3d8iZWJ4DfRu
	36SFyc0GUxgPnzrCU5BSFyOfeJOVMTd/zLo3nqOIHRVlLBffFhJDWyUtRjDB3dDY
	fYWwZkudddJhWwLehMItDyJoCcZX2WQpXz2oQsqyzaHAODMcdU3Jp+6vNIkE+Xmj
	KOFlbY1fPe/4lbXKjdsV0lMWD4URv8h0QuoCHVANrTtFGxp0BBUsSYSMLEBZfwEu
	GFFIMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t39g1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:08:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso158985a91.1
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846925; x=1788451725; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqmAgGVZ9+r6xr3Nv5npOlTiLJ6Hzk9Y3TXQVd3sS28=;
        b=S/w3RctgjlF00/ySCEtyCwSEnkN/+QGPSrVV+DkVzsCM3jPR2BThJZ3v2d357eVktY
         cERRPtRldexaAnC4yPNoWFDZo1Ixovesv26Kb4OeoAyV1WM9ORCxsCb5addcCy3Kc2wJ
         u5sfQVNZblbnFOckd2j+9F8pGMaN3WS7/55YrDdnBU4jdWKT4YQZzYSBux3/ajHRdMlQ
         ayaVN+nrtjpqSBg1oVQgC9kTcwUZ2YT6ZH9e6LaiEICig40ctkPTPnmi/cprojgfrjwI
         QGjHYmpnfB4Z4xx4OvaZQyWiMxhsmYROP0Bx826h4/jBw8R/QI8tKX1Yf9DdzENMmpPp
         +rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846925; x=1788451725;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqmAgGVZ9+r6xr3Nv5npOlTiLJ6Hzk9Y3TXQVd3sS28=;
        b=d321ET/5NMmyOoxWWMm5HeQMfGnBsDPQCx26B2Ca0C0Kk79mjCEaykB0Nca+I/0t9q
         j4JYJ/eW/c9n5NzV46p4VzC2RlHE386skeZ6+URP3BiXOZ5M/NgqaVYwvz1G2Cd5OChy
         EAkYLwOxspjxt/AJY7jQw2C17JxGjMMgSJGcs2/WKFrRzCzoFCZCEASzKqsf2STrdlHy
         dEHcpqduxyjSuWL/8I99qXh9V5oO0jw0T+a+vq8fjIpolU5mqxU+AaJods9cCMdI9+Sx
         zhZYoBQDxnkHlHUoBWkBdnYnIF92vuiwisGEsmn1xZVRvRaiwOo9Ih9GJ0UwNNf1JQNH
         kkeg==
X-Forwarded-Encrypted: i=1; AHgh+RqwU8zIalTEYDAtST9JvGvlmY7cwIhiLjb+KvO9wGt8qQe6oOaiXe74zyIt+1yRE4XLrFOB4+xVQa8S8Adg1g==@lists.linux.dev
X-Gm-Message-State: AFuF++kl35GaNrHY5kjjjdRIPdl/TwRrgT5SDIYVpqBR4UCINVAN+zBp
	KDUdw4BPAv/GDOpOJlKQyC8GcYSijz8K7tXp+C4DZEFFx4s+DWCN7PQLpy02zoj9rGR67yqNCW5
	Cy0iG8GExrtE+DpGEEyv5RvatxlISRg3Drvepb48cpKWE6pPSqyEW3ZMIXbIRAfIGsGTe6w==
X-Gm-Gg: AR+sD13yMPEbnwpZ1A0/oGHcmC6qc1/FQjGRwBQ85jVvq/otCdkcrelyRyepvjkLVUv
	UiuCDyaPsFEi6JaZJ8DNt8EdI1h504XnJn66j0x1RWvp2PF1ekrUcNvDWhiVG8BMqgPLszSLlcc
	UUO71AqdohJN3Nr+am7/qh/LqCnhBJ8crltQRSTAssJygt3WUSyaAT9AbBM+2nZWEOalwG8sZHy
	p7Nro5C5c1yksCbvu2z7YQKW+1iMP7XFwOb7YRs/XB6Zxg0oGjSsUULtAByT3Op/PLR3h5ARr63
	9XnnKYTgy9LYJ/JsjKfQykGG9cu5oFSKxacv7AQRr5Aig29f7K65kuJ8A31QgdzzLXZf5bAaJPq
	1XJe0v4UrFiBMIrqcGrwhcvHcVh6sQOXaEhzRLpNMSHZCeKu+JqaK7pqqS1Q=
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr551956a91.10.1787846924596;
        Thu, 27 Aug 2026 09:08:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr551806a91.10.1787846924033;
        Thu, 27 Aug 2026 09:08:44 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:43 -0700 (PDT)
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
Subject: [PATCH v1 10/11] blk-crypto: add slot_offset to blk_crypto_profile
Date: Thu, 27 Aug 2026 09:07:19 -0700
Message-ID: <20260827160806.1295313-11-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a90610d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cA43FAKIMfXQIL9lPwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: iSdm-dwfjoQYdRIJLVqYxKkhcQCPxwWP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX1M3rwl2EGnQL
 nd9AuBOXpmOU3LpaL68SxL0mEcXm4dNfmlRbb1gN1YVI9GLQ5in7jBTIygIfObxnYeIrgqwFvTw
 P7A0r8jkfE9clCjUbTCK98S5pWiQA10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX6Gk25M4GW/zE
 FwM4Zkyn1+3YLf580TWYW3v4DBkoW09CxqRslu+iQa0WZfiJI/gZjl62BHVrabtK8bZmfA7fpla
 LXfjXuD4clFHZD2rpDIhVjJUSEE70ykPDZ0Xipx/9u3XLDXUedj7mdoMIZrTn1maSN/8eK9+E9/
 2+8gPest0TziYaujdHmebks6ps+jG6DgHosbWZi23SLq+7NfkhUM+5Q+e8whIImJzQrH1UxCgEc
 oIZJ0amzcilPr+oID9SGxE3CTUchat9AQzm/A7RsUoAX7MaIzJCuAAewZNjA5muOwiAjjY9DsGs
 lL0OYxE49FO/pryAwUCxz558qpI0KiTefRj4X3xeNOattPCuwZCfpiDGzlcWSQZCXLGvufap/M2
 NbdywhQdYcU6OytK6rhmphsVNBID681qhe3mkHOuXgNxiMQOIYG7OMuR3xECczRP+OniYDRBHEH
 JLYDKJKFwHsuhuewsNg==
X-Proofpoint-GUID: iSdm-dwfjoQYdRIJLVqYxKkhcQCPxwWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

On platforms where ICE keyslots are partitioned across the host and
guest VMs, the host's physical keyslot range does not necessarily start
at slot 0.  blk_crypto_keyslot_index() currently returns a 0-based
array index, which is wrong for such configurations — hardware
programming requires the physical slot number, not the array position.

Add an unsigned int slot_offset field to struct blk_crypto_profile.
It defaults to zero (no change for existing drivers) and is set by
storage drivers that share ICE hardware across guests.

Update blk_crypto_keyslot_index() to add slot_offset to the array
index so that callers always receive the correct physical ICE keyslot
number to program into hardware.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 block/blk-crypto-profile.c         | 7 ++++---
 include/linux/blk-crypto-profile.h | 9 +++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 53126c091b0b..64202d64a018 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -218,14 +218,15 @@ blk_crypto_find_and_grab_keyslot(struct blk_crypto_profile *profile,
 }
 
 /**
- * blk_crypto_keyslot_index() - Get the index of a keyslot
+ * blk_crypto_keyslot_index() - Get the physical index of a keyslot
  * @slot: a keyslot that blk_crypto_get_keyslot() returned
  *
- * Return: the 0-based index of the keyslot within the device's keyslots.
+ * Return: the physical ICE keyslot index, i.e. the 0-based position of @slot
+ * within the profile's keyslot array plus @slot->profile->slot_offset.
  */
 unsigned int blk_crypto_keyslot_index(struct blk_crypto_keyslot *slot)
 {
-	return slot - slot->profile->slots;
+	return (slot - slot->profile->slots) + slot->profile->slot_offset;
 }
 EXPORT_SYMBOL_GPL(blk_crypto_keyslot_index);
 
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index 4f39e9cd7576..a9bdc05abfa3 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -162,6 +162,15 @@ struct blk_crypto_profile {
 	 */
 	struct device *dev;
 
+	/**
+	 * @slot_offset: offset added to the slot array index to obtain the
+	 * physical ICE keyslot number.  Zero in the common case.  Set to a
+	 * non-zero value by storage drivers that share ICE hardware across
+	 * multiple guests, where the host's keyslots do not start at physical
+	 * slot 0.
+	 */
+	unsigned int slot_offset;
+
 	/* private: The following fields shouldn't be accessed by drivers. */
 
 	/* Number of keyslots, or 0 if not applicable */
-- 
2.34.1

