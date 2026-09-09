Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C95650F4
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962238; cv=none; b=QbQ0kJZRKR4Vu1YPMGgCRo6VwguVgtwpY2RZIsb4+bDGmCz+OtsgFL2/czBwJb0PXmko3BIE5WA8GyVf+UhNYBmsxhPu6eMT8+zo69u8cuRUTsDs4FI/yd8CC1kEn03lg5Gaxn/EXdFKwTATg9wXcWrYjJzjAesWwyc02+46Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962238; c=relaxed/simple;
	bh=1dMM77xohsh0uUWWK5pc/n57DMoFbPH5U47NaaYCfYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4qLuhqIZx90ehcPUX3D9NuLW4xQ3euo58QHocYk/B1H+7lJl2KRi/KamExjFs8LMgM++Evlg0MVXVOgFrlOjbnvdZhOniznJVCET6DmFtFbBQL/1qF7wpjs7N/pA940iNNvOXPaxYKGwt8fO3zEgrqcRQGXdkGqq/bZ9qY3yyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdqBzICV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdqBzICV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1aIQ3839613;
	Wed, 9 Sep 2026 13:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jQ6Txq0OWN8sohjwx
	cHNee3Hnk5lvEZRjiLQ/oqdqXs=; b=rdqBzICVBO8aGXFutNBP42JxX3kJQi86n
	acanPMtaRiyUoHUmqaZ1kqTJxVHF4z08WMCNVnfBrUMZUAksB+IgEOwvqDvIecas
	o7phd0112jCoSJeqsLYQjxObg8rzKV+XKxoTXIhTbZ0X89J09peLkfZ0NxgwFq1o
	pBYsV4Z/Sx9h5V7E51soblY56Wyzsr4Q7U6sQmt3WfN5/myJQf+9ZuO+yLVynqBW
	Q90yZu8k6vY+xIOb7hWfHGvg6Ux5zFyzDTisRqYQKBOteH5TUK83/Ss92OhSMU+o
	sYiIoj4BYrL9m2+Z5ixlK2NY7RMWkmxARXBdbWOxbHMv01ggmMgCA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf5vg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuF58026468;
	Wed, 9 Sep 2026 13:57:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgjeue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Dus3B43188724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:56:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3E92004D;
	Wed,  9 Sep 2026 13:56:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FEFB20040;
	Wed,  9 Sep 2026 13:56:44 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:56:44 +0000 (GMT)
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
Subject: [PATCH v13 02/13] cpumask: Introduce cpumask_intersects_and
Date: Wed,  9 Sep 2026 19:26:06 +0530
Message-ID: <20260909135617.871006-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909135617.871006-1-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _O2w0Pgc0t928lSVQ-iOedVncPhvR7Uj
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa165ad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Op-pV2-EWUbyySEFqtoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX+Ox32gbVHRI2
 XYoyQUwIKLJ2baTvDlz8SfU7EMZdrVHQIx6vo2Tv/paWHHljbQM6ldZ3FM+hiVrc/23Ev3HeSPa
 QOXrar2XKaLtEBVE/IqZ6VA9lUSo1Ak=
X-Proofpoint-ORIG-GUID: Q_ikTkJAvCLWNxfgGyP-6Jg_0Y343as-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX5FeK7Lxz1brl
 5Fg9/arPLFRFcRyh0SloNuNSIA8OqIk56hrf+BbAEQJgg6sJnbWjDWslHb0BhkP30r1MIuHYJJi
 NEwbwVLUGKA/ScIhNtUxNd6lZrsdVs/VVmA4HGV7Fltm0DBLBPUSVTMqaVH/41sgvKWwfOsdbBq
 B68hQ3qq6a2aHk2rWOPouSABcVIIVXIjrcCB6xBWeeP2V6gWmGdU1HbNUzj4tgob8PNXrJeAYWS
 EFsAHrnVt2qm+zGtTYhdKzPlqEiVHr7YtvANZAblcppQ3lPAq143oNFMADvi7SjtPSy9w9UhKZr
 SgjBm8cmppKEBKKYJoXQuGuoMfCHpfOWcs51apzv4DkMY22Z76TAgLvJYbnZh1qtQwYTSeFi4kw
 n1S/L9AnJHgUPOvNg6C3FTtpCfnHI3ww7m8jFgOa3vNe24qqTGc/VLyJOWT5samACn8zjrfUqGU
 Sel0WjmqVVi19uaqk9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

Introduce bitmap_intersects_and() to determine whether the intersection
of three bitmaps is non-empty. Unlike cpumask_first_and_and(), this
returns immediately when an intersecting word is found and does not
calculate the first matching bit.

Add cpumask_intersects_and() as the corresponding cpumask wrapper.

A subsequent patch uses the helper to determine whether a task
has a CPU that is present in its affinity mask, the preferred CPU mask,
and task possible CPU mask.

Suggested-by: Yury Norov <yury.norov@gmail.com>
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

