Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFED3DAAD3
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849220; cv=none; b=FeBNWPSHuEsDVrOGr1TCzR/DtmTiKDsM2Z8EsMtqy5x50fVPAH5oTPSzCssBrdK4VzjcM67QHpyp/QY5asVmyQFrxmp8cNMLnwXgNbslBRGnIRHT6G1TOGcBMeT1yNlJGcxp6Rh/62rpOtn+OVjZmcP0+k9AsWT6GAwdk1beEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849220; c=relaxed/simple;
	bh=hhobeF0P1JpyFwf08e1roz4aoNovzKG+BxlS1ft92FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=iuhwAVrIeX1aQetP6v2jC/MOw8kYORrGEssVmfOvWVyFjAkCy5J3B+hqiitsWc2OvZePvLzUE55907qk0wlH0RGTYaKITu6SYfuAVXCZJ3RBP3TC4zsKnqcxuXq8HKBqyw54T+38y+I7N9QzC+/IntH1wC2L8JATECjQvBCOAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OShnb30O; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OShnb30O"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF83D80C6C
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 13:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.492
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xT7Fk_5hFAJk for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2026 13:13:35 +0000 (UTC)
X-Greylist: delayed 328 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 04 Aug 2026 13:13:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B565C80C69
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B565C80C69
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OShnb30O
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=nj.shetty@samsung.com; receiver=<UNKNOWN> 
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B565C80C69
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 13:13:34 +0000 (UTC)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260804130803epoutp02185d5a02fac46bfec5918ce4e859f461~InBjtobNO2917529175epoutp02u
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 13:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260804130803epoutp02185d5a02fac46bfec5918ce4e859f461~InBjtobNO2917529175epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785848883;
	bh=jnUkZ+BpvB6NJMBSwlqfaw25gpgbDKwOED+dgjvhpkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OShnb30OmDCN7E9+MoRuI4JEsIpY5Hh1ODkmuLwyc8cZxE/AbMZ8qqGRsNeQMT5Al
	 p1oYOv6Rt9OGbQiX1W0ViZE8L/hKWsH6bZQqFTRdmOEd8aGf/aj11dwarZ7c5gDQjP
	 lX5PIVWnZWxcpzcPLT38f4qL0WApg9lCVkJP9Dzw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260804130802epcas5p2b30cb9f257983bef8dfcc34c78546576~InBivRhgm0321903219epcas5p2u;
	Tue,  4 Aug 2026 13:08:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hDv3k0Lfpz2SSKY; Tue,  4 Aug
	2026 13:08:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260804130521epcas5p4d81ad6c4799150dc98794e56a1e2edf2~Im-M2doGg1490014900epcas5p4Q;
	Tue,  4 Aug 2026 13:05:21 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260804130518epsmtip1fa8d46a6cc1711f0a75e79ae2282e8b9~Im-KEFLsU0310603106epsmtip1j;
	Tue,  4 Aug 2026 13:05:18 +0000 (GMT)
Date: Tue, 4 Aug 2026 18:35:04 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Alok Rathore <alok.rathore@samsung.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "axboe@fb.com" <axboe@fb.com>, "Liang, Dan"
	<dan.liang@intel.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "rrendec@redhat.com" <rrendec@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "cpgs@samsung.com" <cpgs@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "alokrathore20@gmail.com"
	<alokrathore20@gmail.com>, "nitheshshetty@gmail.com"
	<nitheshshetty@gmail.com>
Subject: Re: lib/group_cpus: make group CPU cluster aware
Message-ID: <270056930.01785848882032.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>
X-CMS-MailID: 20260804130521epcas5p4d81ad6c4799150dc98794e56a1e2edf2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>
	<561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
	<DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/07/26 06:58AM, Guo, Wangyang wrote:
>> For higher number of jobs(>=64), we are seeing ~8% regression with this patch.
>>
>> HW info:
>> Intel(R) Core(TM) Ultra 7 265K
>> CPU=20
>> IRQ-CPU are 1:1 mapped.
>
>If IRQ and CPUs are 1:1 mapping (20 IRQs/20 CPUs), the patch would not change anything. Every group is exactly 1 CPU, same as before.

We see its not the case, before this patch, irqs smp_allowed_list was
sequential, but after the patch this changes.

Hardware:
Intel(R) Core(TM) Ultra 7 265K
- 8 P-cores (each its own cluster, own L2)
- 12 E-cores (3 clusters of 4 CPUs sharing L2)
- 1 NUMA node, 20 CPUs total, 21 NVMe queues(admin+io)

Cluster topology (from cluster_cpus_list):
{0} {1} {2} {3} {4} {5} {6} {7} {8-11} {12-15} {16-19}

Before:
/proc/irq/168/smp_affinity_list:0
/proc/irq/169/smp_affinity_list:1
/proc/irq/170/smp_affinity_list:2
/proc/irq/171/smp_affinity_list:3
/proc/irq/172/smp_affinity_list:4
/proc/irq/173/smp_affinity_list:5
/proc/irq/174/smp_affinity_list:6
/proc/irq/175/smp_affinity_list:7
/proc/irq/176/smp_affinity_list:8
/proc/irq/177/smp_affinity_list:9
/proc/irq/178/smp_affinity_list:10
/proc/irq/179/smp_affinity_list:11
/proc/irq/180/smp_affinity_list:12
/proc/irq/181/smp_affinity_list:13
/proc/irq/182/smp_affinity_list:14
/proc/irq/183/smp_affinity_list:15
/proc/irq/184/smp_affinity_list:16
/proc/irq/185/smp_affinity_list:17
/proc/irq/186/smp_affinity_list:18
/proc/irq/187/smp_affinity_list:19

After patch:
/proc/irq/168/smp_affinity_list:1
/proc/irq/169/smp_affinity_list:4
/proc/irq/170/smp_affinity_list:0
/proc/irq/171/smp_affinity_list:5
/proc/irq/172/smp_affinity_list:6
/proc/irq/173/smp_affinity_list:7
/proc/irq/174/smp_affinity_list:3
/proc/irq/175/smp_affinity_list:2
/proc/irq/176/smp_affinity_list:8
/proc/irq/177/smp_affinity_list:9
/proc/irq/178/smp_affinity_list:10
/proc/irq/179/smp_affinity_list:11
/proc/irq/180/smp_affinity_list:12
/proc/irq/181/smp_affinity_list:13
/proc/irq/182/smp_affinity_list:14
/proc/irq/183/smp_affinity_list:15
/proc/irq/184/smp_affinity_list:16
/proc/irq/185/smp_affinity_list:17
/proc/irq/186/smp_affinity_list:18
/proc/irq/187/smp_affinity_list:19

I think this has to do with cache locality effects, when tasks run on
"wrong" CPUs. If you want us to check perf data, we can run that.

Below patch[1] fixes the issue for us. Basically keep the cpu order if
resources are equal, meanwhile keeping the benefit of your patches for
clustering.

[1]
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -109,7 +109,11 @@ static int ncpus_cmp_func(const void *l, const void *r)
{
	const struct node_groups *ln = l;
	const struct node_groups *rn = r;

-       return ln->ncpus - rn->ncpus;
+       if (ln->ncpus != rn->ncpus)
+               return ln->ncpus - rn->ncpus;
+
+       /* Tie-break by id so equal-ncpus clusters keep discovery order */
+       return ln->id - rn->id;
}

Regards,
-Nitesh

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_
Content-Type: text/plain; charset="utf-8"


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_--

