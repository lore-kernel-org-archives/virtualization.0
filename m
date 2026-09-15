Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838743F9278;
	Tue, 15 Sep 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441448; cv=fail; b=mYSCIMjDViWgawEf3SpwY1OnTOYgqHTF9LaBUCh6xIZF3lau655Zly2E7H+LBZUhFVJPxL7+B/AORit/9WiYmrU/loeQTuyVYHjGe8tiE3ZdA/pkQnPmJdpj+twXEjKmstW1u3cx1X4M6W/GZW2bHvR5Bf1BSEXWckNr3IuhZTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441448; c=relaxed/simple;
	bh=UutLaYPxqvttvISNOMxDWkZuSoWto8KJaW8ZaMUZ8Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OONqEyL9rgf/ULV/TTzBAKIPjLHxwemD3EJMAZU2r5wLyZRZogjpcUFPU96fmIRR2bhKPYkKxz6y5rrLrcZ3b4zbRaXbMKk/cUYd3uiHcs11x52w1Z117nuAarf3iGa9g6zdHOxxOcO9AMR7h33Jd+TH8wr3T9gPUcOHHP1maJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgiGIa+3; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgiGIa+3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBTnQ1xbyDIc+6vAbpbihp73UuGFRurlhgAKoEkvNiPYEBoEju56gctsaBAzdMTOuCWYInanXg0uNQKB515p38mhXEkAfni/sZXvP32ICXxGML15BBoDUBqtb95Q4ViRy7+wV6Tz9IS8c15B0NwBDGHS+jMvvAfF0NsbCOqH1YvKtDGJ67QHRa3o2AbpbaYPqm9jp0zgRRZ/4xAB+kMPQOKdXgBNaww71KzCbmMYz7QHyIYwqxxFBRGIkoO5o/MOH4f+5pRQyZHgdqLhj6z3Sdmfgdn+T9TwmeubJ0Ww1N7HeWr8mTtHfPRqt7d0BJq220epqUWdNDPMAGz13QLPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulyHw4oZ448FQqvFWSJJVv66MGmnHaoH74pheuM0m08=;
 b=d18g3dkGqZyfRzaddaV0ofgoUEVXwfpPOZCGAzmYz5NyxZrk5sXv2JtFQ4OHVIT1sAqzsIlkYU8qp0xpCWVSAxKxvrx6+xaBKq2F5PU8fTGSELnJYE6pOxkmY4gad32YscOyAzhKQplPjuY1ssziRTMholJPXDrBjBWnMkX6NeDW94rzafZLnyziW96KfvPd0tNi9hfhtoMzVfuvRezbW5YSgUn13hibu+/18T11u/hNI7Z3BoChaUiTTsTyhG5wiy4KpkBIuJUjRwlwOhqwDX/UuWgLAXtdxftqfuhnGffrY5EGatrGw221QE+hEYkzp8OyPw55+ataY/E124nZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulyHw4oZ448FQqvFWSJJVv66MGmnHaoH74pheuM0m08=;
 b=TgiGIa+319Laf+IK9XIyHgKEJVCNbtK+trBRRwIky1kSh1f331ZG31FpM10cItp+M4o9YR7QfFBHh7Isi3u9GUbQEMZKD32l1/aS4MuXka4DK6A/Klin7w1iqJSKMy4RtGvNQOmlNGevK/hITxMX+6hE2aIUinAjY9lEZ8tdu1dKI11oS9jYURTpnMsn45uuZ4JLFb/AbSa9GhqzUOPmah12JvX5sYRiEXhVJ576wFpKB7NmuRmEhbWjWmU8e+ebHkOLnZnbf8Fy/0TEEl6t04amx5XviF+SBI/cIf9IvZm2WZ1TeE44Th6QDmtm4zBGoJc0QnqKsWkS1ETbApoGbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:03:57 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:03:57 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rt-devel@lists.linux.dev,
	llvm@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 02/17] locking/rtmutex: assert static storage for DEFINE_RT_MUTEX()
Date: Mon, 14 Sep 2026 23:03:20 -0400
Message-ID: <20260915030336.1192299-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::25) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 80949a91-fc2f-4378-e804-08df12d5fb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7Leu/6VmRQQdvEDiIVL82HCGEcu3KozIVfzZNIgvm79/ecjR2vs3b2M4vnDr6aeh114kOaqXelEtdXWY9kkO0D2dlT3a8EYFquc2LRIcjNBZgJQjS4q9fq/7E3BFpZeEfEyqh8MvYfDVPWykrh7+f6Z6gcjCZtCRqhiqqV85rdCCS5t//mTDUikboka6dWLI3K8rPEpmYlP6g/rwXi1WBNjHVDTh1BzdZiuMWPT75ST5jqByh07TRpoNsTgERq8ojEueLG5cmHKsGnpyVp8K8VjeUP7zijKmHF6h9Hn5kJEZEH31YbWd+ViJtdw17DuOI3Q9suUVC4loUAF4/yW+hg8k1wMUrB0DwRAgMgJN+MIcHayHPWDZBjtRzzhXhEe99qBjyjbClK+PYWArIVJqAcZG8MP4glpnyxs3+ya7aihm82QZFB9kBd1cVkym3HPphQSO4zupsIei6nuDBoOz2sz4DdyyolsR2PmS055p3PeE07NU1rMWu2UP+x608tcXSBQu8ouSQ/s90TYR1PcFGJu/itX4Ode9u/ykzPm3z2Qz2g1GM1VWR2X3RHfZYC7qey4hNzPTWUcj/BDGsywF2UPgVEZA8LGCcmEeOylsXie3g9jjEPpzDt2KQLl4qGAMHLV6nWWc1Ux+NJufLWm1sWzwRW6IcEj7fSYpJshqitI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2ZV3TocVue9OorsdcxudfoqBqiqFk4oqpLBus/9j5BQLzn/nlSM8r6ETqPs?=
 =?us-ascii?Q?ywuPSkqAcrXu01o5m+szxs2ktAZADc5e1LlJXDxgJdVBmFjtihXlDMb9SN7P?=
 =?us-ascii?Q?K47P6fnPYUNvyzILmMV2z+3hmBV9zjQ0HUdlGb+POB9dE4v95R21x7ALfZjG?=
 =?us-ascii?Q?KpYYTQviiHXWOS/2igjG4t5UHjGc/FH6BeQeuQ4y9fon1AtspCBoKGm36KDj?=
 =?us-ascii?Q?Na6VS7swhOpqqXIH1NHb5S07l3kgjyXcgMtN8m10CEGwj5Yvl2h73XGZnUil?=
 =?us-ascii?Q?cWN8w1Ya4FHnEWXs5Dlk173o885lvrn7vKkEHohu43gnHwgwyANtSnmnZe41?=
 =?us-ascii?Q?f39sdylrvxnMtTQS8GHk2k+KL2hIhCh7c8EGYTbHX4cs00KGHD8GoQ4QWG4L?=
 =?us-ascii?Q?ueHr4GE27dUyqY2cjW5Sx6/WQ1Yay+GO/qOhRFbbtFk7cU7sSPbgyJxLRZO6?=
 =?us-ascii?Q?W9AC6kjio/9jPlZWischMaD7f4h8pEQxKx8l72L1zkuydysNhFtRK6dcBzCH?=
 =?us-ascii?Q?+vSXwmjg5f1Dc94Hhw5Efe014vMlVxGLG6MlWfdmm6Yr97xE2ZZZL/VGidlX?=
 =?us-ascii?Q?NK2KMQL1ckpQsXXcoBMmbFiGG/zhbbmOWWrktCabSAJiwRriIhlCQ5vA/m+I?=
 =?us-ascii?Q?sLcgKi3MJT7wWKhulP0q0Se38icZh+uS6U5qfc2K2SNmsfdy7ZLoC5EkwMNB?=
 =?us-ascii?Q?GOXgaaCL0Di1zciiJkZmiB4PTknsq/1QMkD1G7C/LPlnZvunA9Cgvc4DdiOB?=
 =?us-ascii?Q?qdNk9dRQJqZmQ9Orlf2iIDcaPlMUgFZpBe58NVorDJjAwftfR28MMENkjvJL?=
 =?us-ascii?Q?UScFdBzW/wLgYBF9V+p2VXGDOzKmm67wodhcLmCRzrs1wuunbBIjQFwvaNl+?=
 =?us-ascii?Q?edK+m8D9rOuLcPbktAvYY0d9QOuX1GV2lv5O1exaeVz7IOiiU8uSKGrvSXxa?=
 =?us-ascii?Q?OGoEq4xCXw88/q268wPYKg8/uGpR01166VSKXj6YIuKFSLGYxMJ9RAgj8uzG?=
 =?us-ascii?Q?XqeEDF/4VcX05M4fa7jrj4Z05+RtRdgOQ2De8kMLAv+3WNXXgd5+nQWW5Iud?=
 =?us-ascii?Q?GQzvJEcePRypYY35ZeNkmbkP0EAlu1ZlMXWR8JlSTXtYvkOrJpb3DoRJX+RP?=
 =?us-ascii?Q?LGbSS+wkfTRT0sxRZ7u+RiTbts9HHZdIwsIaEeNY/RoWqaI3HPKfBBgF4QDz?=
 =?us-ascii?Q?HitAcUiy+qKlbtcTGR/8oMy5kfIXblGPg1ZP3ArU/Ep9LpIPW4/mREn3HnXI?=
 =?us-ascii?Q?TXmVn2X7mr1pwtI+W/LiLBROgUM331vuvc/MEVPXE4QpKZHf6aZvWw1YOnyP?=
 =?us-ascii?Q?zw+WaVbLSjvyYxSGaBoXi2uJM2RmLeq1aqlK6DL2OqkRdecfwLfjRBBYflv4?=
 =?us-ascii?Q?6mGo7sUafAT3UELgY9bNwr/UUYRl8NlD9bvgYiUtK7fgKY+hdrrjBXMbp1Ot?=
 =?us-ascii?Q?Pqak0D99d6Zry9zBLbwwqy2mlRqQJBDYmCK/lJeAJKF6Vz57yNd+lS0beYfA?=
 =?us-ascii?Q?wn84/aIItWkaQ27CONTXOH4mNfmYn/CmUJfzR0dc+PhroYHaJoXPoPagmMMV?=
 =?us-ascii?Q?eQSIMBx4MkCOKdBpTAISnxaZOVnKAv6Bo5kTNmPMe66EzdkZc6wbUGY9Ly8D?=
 =?us-ascii?Q?/RSI1lh1dvqUtaJR1tLmsZxgzy3rz0wTSipWi0qLIxbz3URwh6vXNEh956X5?=
 =?us-ascii?Q?wWywRDSkpTgOfGP62DU/iUiilkAAkPu4SAliXfZNgfjETcE6sO8VRfqBMoqL?=
 =?us-ascii?Q?WaST7bel6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80949a91-fc2f-4378-e804-08df12d5fb78
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:03:57.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDqINFCfJ2/kITqwbEtV1DWRrt1rVU0qBGU3moyOst41efDtk0VDYAA/DI2BiTaibbjT1fmvSmTDnGEI5ZIUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

DEFINE_RT_MUTEX() statically initializes both the mutex lockdep map and
its internal wait lock. An automatic local object cannot supply the
persistent class key expected by this initialization.

Add ASSERT_STATIC_STORAGE() to reject automatic declarations. Such mutexes
must use rt_mutex_init(); file-scope and static local definitions remain
valid. Leave __RT_MUTEX_INITIALIZER() available for embedded objects.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/rtmutex.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9e1f012f89db..495509d82c88 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -105,7 +105,8 @@ do { \
 }
 
 #define DEFINE_RT_MUTEX(mutexname) \
-	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
+	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname);	\
+	ASSERT_STATIC_STORAGE(mutexname)
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
-- 
2.53.0

