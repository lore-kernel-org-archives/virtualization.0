Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED638655D
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417216; cv=none; b=AJ2fG9l8F3//wDsekXJf+kTYuIYQCB90IFHcEN7Bk4PqncGgBzCTi+k8o2azFfhBF6FnLl8QCYDAP3uKNNV0E5+P9KYfnpOcILqNv1u5T/wJHWd0V3zIVqxJ/6NwHffopK+NRwHrx+fylS1MmxroIjqmSv1scC3Su1Glx7QqcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417216; c=relaxed/simple;
	bh=1dMM77xohsh0uUWWK5pc/n57DMoFbPH5U47NaaYCfYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU7rLO/h7cwk8ZSwu/cBi2JrquTlOxvgHXrNB1Ezr3LQuEqzGqmSou3Fu688K6+MfxVTBAY2XsBa2+mPv3ufgZP33aCHSHGUcViJWqfRZqiP9sLBFSFh40SM+B1ApdUXm6GGyHiuGnDWwxjkw5W5HAMdV6rATeAbUjcwqQn4q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ebSD4Omq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ebSD4Omq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361wNQ2067854;
	Thu, 3 Sep 2026 06:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jQ6Txq0OWN8sohjwx
	cHNee3Hnk5lvEZRjiLQ/oqdqXs=; b=ebSD4Omqh7OsKljzzOE1p8GOxvESwnhZM
	wABM7vyc4BfcF0mhfaZLNeZhjV54CNqksY1U7B5Oa3Wnp9EIlD4uVjln3WC9dVNA
	dNy4+LOpDW0Z1lxOBOFPG7FGxrB2OX1yc/p1A3iipWrH+XLYovaf+KAYk7PfYpUt
	gHwOKhwwCSP6D+RA1iMj5avU+pP+e+Vyq1WCQO+ONF1fHxFvVni59M26iUkY5nDl
	rGdRHY384JRM3iPkEQXVT04oE1xR8/tI1Jna5LEbkNH5RGTYfMQx/oEcAtnP6d9X
	AFdVbEotcS/aKvnoF3yOiwefdRhkprw8Q8a3vVxEUMsfYrqQ8QCmQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj36r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QEBf020524;
	Thu, 3 Sep 2026 06:33:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygp73q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836XCh346727440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9302004D;
	Thu,  3 Sep 2026 06:33:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A52620040;
	Thu,  3 Sep 2026 06:33:04 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:04 +0000 (GMT)
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
Subject: [PATCH v12 02/13] cpumask: Introduce cpumask_intersects_and
Date: Thu,  3 Sep 2026 12:02:29 +0530
Message-ID: <20260903063240.268775-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903063240.268775-1-sshegde@linux.ibm.com>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lsbSYVmPbPrb5YhIw6PAmQVvcjCpVgE-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX4kGQIsXsSJG2
 TZ97qGSpKgz2tIbyE6RlWl8elLmLtXxpeor3r9PmY8CnNXv4yZa0yY6qFChZbVQBklxoFm98/LU
 /jClNi3fxNEaGm3P2vtioUJ9JoIr77S9zGSdV0H5YSmaLLL2vmUHfUCIlmTMTNzkYFOnbYApipD
 2L1eKBr+DAi3FcLTE96CGeNLSeoQkoQXIriUWdSsrHBigKUcFLvF4LwTsO89IFIwo8xQFB3QSZp
 v3loT3nEm73DEsDHnvP1KpMRU304KbS1iD6b7ZhTeqrvQUVoih2kmaqrxOsjnAilE4jMaAELd98
 lSr5PgAkQmVq9/1s6YgUlemafkkpo8644EJuN/LrGU+r5XfMngAkMgR5xlW1oM2Hrhnzqy55gOK
 l5JdIOsR3mztxLi+xTfnm9+K2bbAq13o8jOfVvQr5vFT/ZC78Bj6WuVvJ/f6U+F7Kawk/jSMvf6
 0I5OqYwIfIFa1gxpMzw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9914ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Op-pV2-EWUbyySEFqtoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX750laDqAv6I/
 rvUMstuRncKn+ayjeoVTFwAxIzSIQDU/LaSZmN/Hppi7J3jtO0iKmZ5lfXo6p2Co5qgJVfUq9bY
 QeNx7rhCtkINQunnzlLf5SAaCEIg2bE=
X-Proofpoint-ORIG-GUID: uIQJZuOyssVanKqnj-85G0FfCPf4unAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

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

