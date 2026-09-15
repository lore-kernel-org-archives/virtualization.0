Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84A40245F;
	Tue, 15 Sep 2026 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442044; cv=fail; b=fRmhmXWHag1evUCp42E6aAaxoYn7iFIOFiD/PJxqOCCpV1wCD6qZPae96TUmgvcnR9xWjkEEExiV27PMQn3m4p7XJ6zCOY4zqOLT3iqppW6D6exfCwwTrcHTN201bGhDJOCThJel4LoQJx23PwbGqGFMUn/r88Nh5XnDPEyDj4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442044; c=relaxed/simple;
	bh=1YhJP6q6Rx2tAAb/t3WgDOoHzNEIb1VgVSGh/ryvXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEw5lbyEODqrTWk97+tT4Hvz44RLqSCclFuBz3okhAmfoLreWV+458HgXyV0QUYAwyt1vFTX3qHyja/dXbclXn4aQHf6DwrMt5hROkX9iEQIx/dKdz2/iX78uskMeBmvzPuQZNauNY/WgIa5mmeMel95Wn5cvFpvwm2uUKb2qSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXaKmmSq; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXaKmmSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOovFnvWVcxkAxzeiE8oqqjIZKVX3W+u+HWl7Pn7f8dyHZRdLwibRotWaESDK47PiwomOdTlSv8aAHn8vfUPYqVDMX5EiTAYuS/WpXK/TobkzDYyJ/gpyPD5IEig9jkgl+OCNFdJ2cUpWQaRmj0rULZUk53AdS34gs/pKr0yo8v4qu2BN0Xjh26lyt29pBPlqTeGvpy3AsoZkhkhsRbY9PhyxLRSzEsaZ0eNMSH48tEFhKEt2JEJMcd1W63gcIvE+IZsiGxCCS24Oxsbwd/sDTyfnqFpta694aCZqaO7Iwx9eDsV1tEoR/ZND1omhE4GWzOWf+tR+oMpFmQ/+qPgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk5k7TQ+BPjRKugTefW7dWX7IVzx1ADNBgRuGTw0IN4=;
 b=kuisb1FO+5iSZhEmsAW7eXXPNlB02Gunv383H60pDBI8KKbAhZuQLGUqKCq+8pRSIRwi3rXK3QdcmhV+G7MSkgB6ixFnhmtVjFAva2Rm3b33xRcuTOQ1PmwC+dPvRCxpDwzquX5dKKnjmEZ/+0xwsQptFzNJK/PPTHRZl4F+ZW320TqTvXmzGp9R9uGDqvYnOoGz8tucno2BbqhDwBR3JKNqYa+f31AWLrkMkUFCCf5vVg04p93Aq5wqo8xwe5NyKF0Gd0S2mA7w8niPM2mEbera79BXJtqk4OfKmQY7kOkJ9TxL+0/jSCMpbU71UHUILDI3Y9n0AgIFdr8O/xciPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk5k7TQ+BPjRKugTefW7dWX7IVzx1ADNBgRuGTw0IN4=;
 b=aXaKmmSqL1cZ/12+/AnGPtCu9hVfY2nWSdNJ+5bZs/OECSx4/lh+X6/KZY8oCWJ8a8wZcWP0OT/HbLFo5vpJfS7n494u5HsHZPkVuNBTiYqxXkDWfNa1RjLzZyDAQ4plzRF0MahMKxF7s3hZsCelLGsK9QWxneDrfJ0hs7h+6sIi0eh+8dXmeusjDG/iDbqdLW9EwPOexb2k++ZzjM3EW/eSstsBJbMqvHI2cknH0x/2MGhkCAwr8LI9HVd0eN+ALJ5kPNwfks0y+Eft/GbzGIv37lbPG/vCJOoVlTSRsqd7QGz5Fuxw+pRSJNpU4DI32P1XQ5UiK8Sf6Ny3QBPTHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 03:13:57 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 03:13:56 +0000
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
Subject: [PATCH 10/17] klist: assert static storage for DEFINE_KLIST()
Date: Mon, 14 Sep 2026 23:13:25 -0400
Message-ID: <20260915031334.1194975-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915030336.1192299-1-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: c0316fd1-1c80-4d41-f50f-08df12d76112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	eyrAosqQgzIvIAx002+kKEoK1AesvppnYTuLjt8GWu3kAXfRJbIAYQOVmLUiNd2LbdE2dcJpjXNOTpRBn7P3b9bxTLdDhuPZbs2eauk3gzL2i06ok69gUmnKtfcmdeXISq+fDZNSROENZ931kn7d7eiJc/5BhKwkHXXdJ6xLFDkCrz/n1byhETTiTlBimkjlQwVdTeLUg/AWENSBf61n7Kh9gl1YwNg8gElL9LnPUY6+qCM8ToWBiLS25hiEOBrWs7Itow+E5SbqmPB3/XKBm9uvptCa+fDUTm56m/h93c7kLQw4w97qdVkWmTuLXGIDfEKfXK6pRgw1rQPlooUq6rDhuXD4D2RWWaoWuF4uEx/65cD1iaQk2f21VUaAPs0T95KNW731ePptrk66TonlQ4CADKwdCdObx8eG8xz4id1jLAiaXQgGD3d9AGQ7PVHG9WFh4wbL89CfsR8uIQn3z1HfZKiPSntzThU5cBLGWbrMD4fOQ2PbtyiT5Y9FjDjfNZXryg/tfQfr0e8sMUdZ6CVztoGk3eLLsAwWeCs2qEV5LC2/P/yR+tMYObefnj+e6Q11OTqIXyrDehAVuYFPBw22fF2RJfXH7DOWJ4vDx7qFEYhpAphEjVVOBiwtCkien5PAhOVxU+XBQDpS0Y5H0YeD2024GCs9+G84y/77cQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYnOa1BUkoDF+fMY5X9B85RymRmIorNlyqg7CJn8mLccC5vL+cQnzr+0t9Vv?=
 =?us-ascii?Q?qH0qwoem6L6iad2oODF02RsXiLex/9OIK55NAvRjiL6l1rhtCixJc8TkDwWl?=
 =?us-ascii?Q?VYLhZnNxX8uJ+sBlvU//TiMD2VKx8MSAwsjZ8puVEyijDJORhmKPO5fakHS4?=
 =?us-ascii?Q?PxokWSBd1kmVLDjsgBfmeVBrYlRt1avUYdAWYJfBeWeQ2sDAGjEZGrmECbox?=
 =?us-ascii?Q?RlUnb39uzGeBgp7uFToZwOYn/kKZJlfS/bLRdWbzSbRU0Qsohx3FB7pGXKZ8?=
 =?us-ascii?Q?295t1pwc4+uXDuu22RoGKxsPm04YBslG06+9GMmB5dlcsdsz17SKSRW6HncO?=
 =?us-ascii?Q?5V5vTEgEoVUEA5RF6xyMUdhDkuhrJ3mTfJBG91cnDXuIuNYvF6wbwJo/525o?=
 =?us-ascii?Q?7KHGvHAcFKzUrQGHSDMyIWPOY5GGOZbjP8J1tpAGwdkujaEEey7knEewvFcV?=
 =?us-ascii?Q?Qgq67NQnwB+PLsQA7YWLYKWue4KZK+DEbVRqMUnPjR4Niwz5IDN7zt/dDAjP?=
 =?us-ascii?Q?Y2QRH1qwlwx0JMAhicLYIs0eKQDz912i0i80JkPcDpxpDnCcC+Osnb95SSPd?=
 =?us-ascii?Q?txG2ddjXtvJSCRhgTB5Qw6Arv8wZ57mYtFa75INp2AZRHucxazz1savjzp2y?=
 =?us-ascii?Q?CBjMlHLWVZ5HJVlcjXJkbBYCBqSjr5sdSQiKGjq7N5I7IGWAddjdSTAuKPxr?=
 =?us-ascii?Q?JDNBK/sf4QJvFTWz/kt5TLEWpz4d1jnNsP2QkBgMSXjsulgrSCNnLPCbLg+K?=
 =?us-ascii?Q?Npt7Xas/EiqgtdVfF189r+zwRxn2pjtl5FCFurdqQyzxd+AEzM9inaOFJ1L4?=
 =?us-ascii?Q?gcenPmJkScvEOw91jIC664FHQ3J++6XEGoBOM0+OepmOcOh0l6yuPatvwli8?=
 =?us-ascii?Q?3Xa3m/WDeakzmI13ojiZUmAztiEb/SDt2qaSck9/fzkLLLMAQuHzc7XnU3aj?=
 =?us-ascii?Q?CRo8v1GxSAxW7Lk8syBqNJm4KbCcseCXzCWqhRUQWP3SzmIC/u7RGXZ1i1/n?=
 =?us-ascii?Q?E7so+XMm9cLjzm1czg+Io6u4I6nEcPv3ehiW4rJXla0/50NuuJyxjfYMtlyr?=
 =?us-ascii?Q?cgnrJzaF9u66tnHkZgqrQWpFAeCizUlHn/W12P/c8k2oJpxYX47WscuWt+fL?=
 =?us-ascii?Q?vuUMbrqxvHijU7UAcznsMAr7xSEQQK9NuQv9Gv7sRixJqURnOMHOaoKsZoTK?=
 =?us-ascii?Q?mfh9PsfyZv/sD+EngBjiCePpxk5qm/htKmkYknf0RakiBP7+ZTGrF9s4OlpH?=
 =?us-ascii?Q?MIYaL2Ydl9tMFoTlWRnkioZzXiWXV9v70FM4rJ1iGbuWHjrQSZBxFpdIWf2R?=
 =?us-ascii?Q?AdZmVxgbLQvXleNBNUZjrwNyuFbvWVU6nnFw3InHi0DQkVMK6B1PXx4urPDn?=
 =?us-ascii?Q?uJn7zfBSaMX0Ro1NwsFXLLI/Wpk+s4iKHzLtkDS5lpgkJE/scMcCCKNpUf/9?=
 =?us-ascii?Q?NL8jxhJq2FJkaxBiiQuTc2EqWC+vqkR00qDD+nXxcMxkgS5JVL/Ag4xaqTqg?=
 =?us-ascii?Q?NeIOdlE2Pwuer0Bam2LPPxdU2xLxYfzUNP65hCYo2xaC7mZ7EZjWbrzJlcVv?=
 =?us-ascii?Q?G+f/Bfp1W01SlJys9U66ypsf2U3OBtGub7XQbK23wkqVoeEiChTVk/zrqxWp?=
 =?us-ascii?Q?mDcOlAngT/WSLLEcHRoWffOS/p/vBa46nKOfHLSWOMy9XJUDwKDdvq4GyegT?=
 =?us-ascii?Q?9Vi3C76RhGWCf4AT16AxGGDM0UkIoUwtVFU6qhONMCNvec2qfjQkoc4wlupf?=
 =?us-ascii?Q?VOMScQ3v+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0316fd1-1c80-4d41-f50f-08df12d76112
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:13:56.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNnoc6ULkEGQ5RmcnFTWTkj0Lo3CaL9fvV9SNXH9EUTfZ+JOI0O+yGQyMEkmJVSE/fTk23VfSsWgB0ad15r7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

DEFINE_KLIST() statically initializes k_lock, relying on the object
address as a persistent lockdep class key. An automatic local klist must
instead use klist_init().

Add ASSERT_STATIC_STORAGE() to enforce this requirement at compile time.
Keep KLIST_INIT() available for embedded objects.

Assisted-by: OpenAI Codex
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/klist.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/klist.h b/include/linux/klist.h
index b0f238f20dbb..5848363242b6 100644
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_KLIST_H
 #define _LINUX_KLIST_H
 
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -29,7 +30,8 @@ struct klist {
 	  .put		= _put, }
 
 #define DEFINE_KLIST(_name, _get, _put)					\
-	struct klist _name = KLIST_INIT(_name, _get, _put)
+	struct klist _name = KLIST_INIT(_name, _get, _put);		\
+	ASSERT_STATIC_STORAGE(_name)
 
 extern void klist_init(struct klist *k, void (*get)(struct klist_node *),
 		       void (*put)(struct klist_node *));
-- 
2.53.0

