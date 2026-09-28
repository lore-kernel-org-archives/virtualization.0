Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2A38839E
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573919; cv=none; b=NIvlpRwaJ5tQDEjSnpdwfyDRqROAo2odiwm6JmEhyQR9JBNTCwPYshkZBQmn2W3QRAPBcnShrEsh7e+oMMsqwatSz4u9mJ8sWiyZgRiBBF8EDyCSlaaJPFgAQAVsWOniVnnHHubTkqyX0SBXrz7gxAaNTK7MMRq24z+/aNt2gZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573919; c=relaxed/simple;
	bh=Y8yw2weEHdQBEvmllxlLd67L8gI8mkL3y+ZToLx7bxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDFomfth7hjwZzmv1vqJg+Lb/FJNnA/GNJ+xGUDjIgZpAGSLhnLWsBXT8V8mGOazVWkECH0XAhXm+q9OzXrpdg+HXxbOuOV/IEA6YohufH3sKzRLr6RiK6stsbKPOcDAjVfIKJqVFD62WqgRctWHS/PhCcg4Xjit0qYNa817QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NrtGsB0+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NrtGsB0+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S0d9BJ1122009;
	Mon, 28 Sep 2026 05:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+pxnuxaAPRZJhckyc
	xlGaZKHhQUZ2GMwSTpwLjkaC5I=; b=NrtGsB0+WamCaxZJIaLkf6N4flhz4Q1ie
	Ae33myQ/sMs01/3uSpl8WORd+MM90oKCQTOS6ovDwStZlzo7HV0jo60s6MTUjRZz
	lqAlxDDGESqCkCi8qLuzZxz3/GTsZrBkDyokIK8EFraKTCwCBglTyHVz5APF9pX2
	/dpmTbTLpZ9NqQbuPCsuSbElnMCD77IruYArRoMudMXJQWaXkA1QsyrqRsPnNliQ
	mmVB05FJJlTdxAWVFb8ZsjyfyzUg0G/YImpo6pGJK/YT0oVbp1fA+LB6qocG1mmO
	UrvT2RJQmOvPA4Y8ACIPtBOaSG3eiOvzuHJmn8O21Lphd32iZ3LuQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s4ygav-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2tEMB2024582;
	Mon, 28 Sep 2026 05:38:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw3wr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5c9lb45941006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:38:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3932120043;
	Mon, 28 Sep 2026 05:38:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2BE920040;
	Mon, 28 Sep 2026 05:37:58 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:37:58 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: sshegde@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: [PATCH v14 02/13] cpumask: Introduce cpumask_intersects_and
Date: Mon, 28 Sep 2026 11:07:17 +0530
Message-ID: <20260928053728.797539-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928053728.797539-1-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfXx/kacNOQvOaf
 uC/6JoC2rE6UR+MgYdQe7vdIGdVPn5rZXKPMKGRK++ZuT6ANu0vNlyrKR99LD3fk+605iP1I6pW
 J/FdfcBaM2jrkXouSj3971IoUt2q5n0=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ab9fd47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Op-pV2-EWUbyySEFqtoA:9
X-Proofpoint-GUID: gwNDvemMWdf68glvckONkznBO-RzOxuJ
X-Proofpoint-ORIG-GUID: 3yQFE04ySsynSRS-Ckcxe5f1RBUAvL4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX/+42UfHGTDZE
 4+ERXMd3fT57trZ2/eBP4jLy3gWxBoOdAxqku6euwOjZr46i0s4KI1vPC0bxIuHEx3+PTdqwL7M
 J+v9BHp+5ovCLW2rk2SWzaGcQovoEs6Nu3eIliATDaCo+88okEe6KZoxVIPKp9BJl2dM/J2t8N2
 W0WV+3naq1Z/p6jjEhxM+YvI47mHDP5BTYaBZJTE1OLvHxj2UjfUcDCkbYSnyS5Tn2tzxYbS998
 oWVqXOhabE8O3Hf/P36D7kMJ5LiCj8gtr7YKtzRXhAmIOfNg+2iptovVdUTKuSfymz/GRTI513+
 3GUvy3/GaNuowljdJWNKqIZvxHQgSRtRx9azEdK8F2dj54h86MA/rkv02806F9Rs9dukN1FrAne
 PQVua42hFK4+mTnZmhXj4c4f2fLda+57xryy539SsETqLboRfxthhPAfPG6xZ9CZTTPcLIzjStb
 mNOdo2LqCbqASy7xLcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

Introduce bitmap_intersects_and() to determine whether the intersection
of three bitmaps is non-empty. Unlike cpumask_first_and_and(), this
returns immediately when an intersecting word is found and does not
calculate the first matching bit.

Add cpumask_intersects_and() as the corresponding cpumask wrapper.

A subsequent patch uses the helper to determine whether a task
has a CPU that is present in its affinity mask, the preferred CPU mask,
and task possible CPU mask.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/bitmap.h  | 14 ++++++++++++++
 include/linux/cpumask.h | 18 ++++++++++++++++++
 lib/bitmap.c            | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7df1573a409c..adafbcf2016b 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -52,6 +52,7 @@ struct device;
  *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
  *  bitmap_equal(src1, src2, nbits)             Are *src1 and *src2 equal?
  *  bitmap_intersects(src1, src2, nbits)        Do *src1 and *src2 overlap?
+ *  bitmap_intersects_and(src1, src2, src3, nbits) Do *src1, *src2 and *src3 overlap?
  *  bitmap_subset(src1, src2, nbits)            Is *src1 a subset of *src2?
  *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
  *  bitmap_full(src, nbits)                     Are all bits set in *src?
@@ -181,6 +182,9 @@ void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *mask, unsigned int nbits);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_intersects_and(const unsigned long *bitmap1,
+			     const unsigned long *bitmap2,
+			     const unsigned long *bitmap3, unsigned int nbits);
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
@@ -445,6 +449,16 @@ bool bitmap_intersects(const unsigned long *src1, const unsigned long *src2, uns
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_intersects_and(const unsigned long *src1, const unsigned long *src2,
+			   const unsigned long *src3, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ((*src1 & *src2 & *src3) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	else
+		return __bitmap_intersects_and(src1, src2, src3, nbits);
+}
+
 static __always_inline
 bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 4c8bb6953107..7c8f16797f94 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -824,6 +824,24 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
 						      small_cpumask_bits);
 }
 
+/**
+ * cpumask_intersects_and - (*src1p & *src2p & *src3p) != 0
+ * @src1p: the first input
+ * @src2p: the second input
+ * @src3p: the third input
+ *
+ * Return: true if AND of the three cpumasks is non-empty,
+ *	   otherwise false
+ */
+static __always_inline
+bool cpumask_intersects_and(const struct cpumask *src1p,
+			    const struct cpumask *src2p,
+			    const struct cpumask *src3p)
+{
+	return bitmap_intersects_and(cpumask_bits(src1p), cpumask_bits(src2p),
+				 cpumask_bits(src3p), small_cpumask_bits);
+}
+
 /**
  * cpumask_subset - (*src1p & ~*src2p) == 0
  * @src1p: the first input
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ed685127a107..d1cb8a507c60 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -308,6 +308,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_intersects);
 
+bool __bitmap_intersects_and(const unsigned long *bitmap1,
+			     const unsigned long *bitmap2,
+			     const unsigned long *bitmap3, unsigned int bits)
+{
+	unsigned int k, lim = bits / BITS_PER_LONG;
+
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & bitmap2[k] & bitmap3[k])
+			return true;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & bitmap2[k] & bitmap3[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return true;
+	return false;
+}
+EXPORT_SYMBOL(__bitmap_intersects_and);
+
 bool __bitmap_subset(const unsigned long *bitmap1,
 		     const unsigned long *bitmap2, unsigned int bits)
 {
-- 
2.52.0

