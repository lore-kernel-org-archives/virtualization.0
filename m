Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902543769EC
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338029; cv=none; b=Xu1yyzzpXHd/he4tCtJaoq4o786BTOl/DX6cAHii1UwfvPXNih5bRlmvPfxpvUC/62tX+KPZZp6OdejA9AzrS/HS1bx2a3jTjJ8CU+ovfofKDKbMwuCPyPkzp+QNn33mTBdDsO5yS1El/fuJvljutU64bArHJrD3VXzEiJlUFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338029; c=relaxed/simple;
	bh=21KHO1/C/fEHAwrmDDbB9VknpaoFgoPoaI9JO1mVzgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3tvrDByhvTQ/r2GsAtV6WUpPfQIbRFve/Z152Btd5Gf5w8zO4eF3PIcvMb7vEItDLzcqnusMRabxCTZNblmOpOqJjaxSGsFahZUjcZ2pB8svCQD7crPnTyS4QCZXFjaJjXXGJha11THEjWkdwArBjWAYiZlWufS4nXc6LzwQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MRj4f9AN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MRj4f9AN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VbMP3443086;
	Wed, 2 Sep 2026 08:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0CeJ/6
	g4RHOdVzSO/BtYe4b5aePEs7Ds3IK/lyJIk4g=; b=MRj4f9AN/xQL4BfvGw8O++
	FH+6pQlWRxrX5wTV/Kdu/BamHYZCXAks3ubIOVqTOl8uBxpqFmu6KwaN/DugYq+M
	7VXz5JZg3notU5rz2qvR1Qf09CxQq1eokGDG5L76iq5kDyPlGyhDF9i+vOdxE18W
	2PBgmnD/7pLNC2MYZ77Y2WjaooRsWUTADRgjq36GpPVPUPwN76DEyzsAEJXlAh3W
	U57LAPp1NOJkA0prctNd/Qmvop2Gts5FnZOzlUIT3lmcRl/tsIGpHf8iHgd6oQ/P
	2Ki9ValXhn8nfrNcn07PpDBS2cmqkmUlSlgw78hkNjmUZlwbKt67XcQv8ezfgGZA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5n96w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:33:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6828QTPO010976;
	Wed, 2 Sep 2026 08:33:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hgjae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:33:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6828XAHt44433838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 08:33:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6A9D20040;
	Wed,  2 Sep 2026 08:33:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90C5D20043;
	Wed,  2 Sep 2026 08:33:02 +0000 (GMT)
Received: from [9.39.25.199] (unknown [9.39.25.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 08:33:02 +0000 (GMT)
Message-ID: <8de8d33f-b3e5-407c-98bb-65e8ebe3e100@linux.ibm.com>
Date: Wed, 2 Sep 2026 14:03:01 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yury Norov
 <ynorov@nvidia.com>, yury.norov@gmail.com
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
        vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com> <apMziCV_8y0xeIBT@yury>
 <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
 <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com>
 <apWxmL_brfi4fa4z@yury>
 <CAKfTPtA4zmD=0Es2cXSHAodTZGLJPvv88s0_4QScp745PxFVMw@mail.gmail.com>
 <3368b089-32ce-4521-ab19-e37c9f029b8b@arm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <3368b089-32ce-4521-ab19-e37c9f029b8b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a97df4d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8
 a=GkFGCOBzxNR5m4WF0iYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8tssfpr0h9dxSqX7WbaSdghJxQZ0Rz_x
X-Proofpoint-ORIG-GUID: u8T0_SYKktJAeabuBoMXzQL2VsvwySgp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX32WIu2uV1qqk
 17P634LgQThDeONw1BqMvigu6izyXOvpbBpuRk5LubjiLrJpK5jLB/e1MvgOncYmckmbvGVrWO3
 3XDVC6+GfF41a13h0PyOhmnuNPrFE6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX8py/LV3n5knt
 1SYpKMNd2lqq4vwzzuSz+E+EEWzAMxLclJm2auS9xebj0Ub39zxwYjWiDQOLQMP86mbO+5yUej4
 mXB+8RgEubTfoFqiJrkrWJXrixLYypEEAl6q0T8E9vZz3obpabKQCMIt+skapwiVY/+iA/20URa
 E48BuuZ/b9j6BU33azfRfPxHZpjpDePCeqN901qIGqW9THpYmFo5Bemvcu2AUDJl+vunIV65dHm
 12gZs1qQu8PHqwg+DkaSe50NThlvXUIFNijRpBuaMAZUCNPRRx9ONwRmaqg50XPSCMAn7grsLjO
 qQGROpdJ30PsCjMmSOKt8OZ3SlEd8TEftzfVDFRHKA0tIOMbblGN7Lq8p9UMN4/1z4eY4xBBE3V
 Wf2gLCHn4oROU+Ic2Csb+/qBI0IpBq50+0fT36Ltg8BGKut4dwpp+hAITU4+lP9SVyJRQxfJwYj
 IUCh+KwxM7zT4LKofmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020075


On 9/1/26 5:51 PM, Dietmar Eggemann wrote:
> On 01.09.26 08:21, Vincent Guittot wrote:
>> On Mon, 31 Aug 2026 at 18:54, Yury Norov <ynorov@nvidia.com> wrote:
>>>
>>> On Mon, Aug 31, 2026 at 05:09:41PM +0200, Vincent Guittot wrote:
>>>
>>>>> Dietmar/Vincent,
>>>>> Do you think it makes sense to enable the driver on ARM64 now?
>>>>> Or you think it is better to delay it and once the feature is stable
>>>>> ARM ecosystem can enable it?
>>>>
>>>> It's always better to support all arch by default, unless something is
>>>> missing which is not the case here.
>>>
>>> ARM64 testing is obviously missed.
>>
>> But the cpumask is already available not like if you need to create a new one
> 
> IMHO, when testing the steal_governor on arm64 w/o
> `allow_mismatched_32bit_el0`, I wouldn't expect much difference in this
> respect compared to the architectures already tested.
> 
> Also, AFAIK, `allow_mismatched_32bit_el0` was mainly relevant for
> Android devices up to Android 13 that supported 32-bit userspace, so I
> wouldn't expect it to be commonly enabled on recent devices.

Ok. So it is a narrow window in a relatively older versions.

> 
> As Vincent pointed out, `task_cpu_possible_mask(p)` (which defaults to
> `cpu_possible_mask`) is already used in `kernel/sched/core.c` and
> `kernel/cgroup/cpuset.c` to support `allow_mismatched_32bit_el0`.
> 

Based on the discussion so far, I think we can keep the feature generic
for now. If a concrete architecture- or hypervisor-specific limitation is
identified and cannot be addressed in the generic code, then we can add
Kconfig gating. So far, there is no such case being identified and current
generic version is in good shape IMHO.

I have added cpumask_intersects_and and used that for valid cpu check.
Please see the v11->v12 diff attached at the end.

cpumask_intersects_and could also be used in other places such as
drivers/cpuidle/coupled.c:cpuidle_coupled_any_pokes_pending.
Patch for that will be sent separately.

If any of the above doesn't make sense, Please let me know.
I am planning to send v12 post running the workloads and sanity checks.

I have run cpumask_intersects vs cpumask_intersects_and with the workloads
I am currently running and did not observe a measurable difference.

---
  include/linux/bitmap.h  | 14 ++++++++++++++
  include/linux/cpumask.h | 18 ++++++++++++++++++
  kernel/sched/core.c     | 16 ++--------------
  lib/bitmap.c            | 17 +++++++++++++++++
  4 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b007d54a9036..e595d189047b 100644
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
@@ -442,6 +446,16 @@ bool bitmap_intersects(const unsigned long *src1, const unsigned long *src2, uns
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
index 34d08a3d80e1..d7f59bf32d32 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -833,6 +833,24 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e73d2dd997b3..0dd1d92a23db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2496,9 +2496,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
  
  static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
  {
-	const struct cpumask *valid_mask;
-	int i;
-
  	if (cpu_preferred(cpu))
  		return false;
  
@@ -2510,17 +2507,8 @@ static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
  	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
  		return false;
  
-	valid_mask = task_cpu_possible_mask(p);
-	if (likely(valid_mask == cpu_possible_mask))
-		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
-
-	/* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
-	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
-		if (cpumask_test_cpu(i, valid_mask))
-			return true;
-	}
-
-	return false;
+	return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
+				      task_cpu_possible_mask(p));
  }
  
  /*
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b9bfa157e095..34e202800c5d 100644
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



