Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023083.outbound.protection.outlook.com [40.107.44.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1B273D8F
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938605; cv=fail; b=afyDKkbHuhmeZayIbTiB4x4ph8S/nm4Vuq6/xN4uBniQPuLv2G0XSs47sDFnoMASGFFFXGD3pFKOxcdUpCcaAqEs5WgmohZeD0tCioTYAISEvlBVhIaBsGx/A9q4Nl7MBhGaIQPl2ZL6k9E8Y2xOM0WhfSaxc0UsyqZ5O3tkHJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938605; c=relaxed/simple;
	bh=JSXEW86K6C9R1F7Gl6Mrr99G+XGX0Mqyptuse5PhvO8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QEHzq91tzxAyDdoDA+x69EAA2RLBOSTGVNSeRXgVlni9e+rA0mhFy5JN+clxn/cTRvwNlAzJjBcw5nJRGYxDlUawCaBvtbixNwG6J+hrSGR1WLlXWPfe9fw/IgK5kv4AXgM1glSM6kEY/YQAId/tll3ZDvhB5GZfXLjV8EbgUCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=QHCP73jh; arc=fail smtp.client-ip=40.107.44.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="QHCP73jh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8j1tWlMPYsOWj//4IHEp5oH5hYUu/eR3Fx3W8X7GMfM4Na4a4+v1sRGUQ/knMbRgtWTvXPftGbjXuOPiX5cww/E5vudrRdxBHqoU+wtCvNJD6L9xxyuhgyvkrD9zRob3+0guJJL3dEAszON1XxFivBLWERIA5pj25q7jUQbPNZACL8yQgQAwf8SAaEbPzsJ3gl1F59SrxR2hKOVcSGIg8Z4DmnZmnwzssJPWALny3OUot5zCyg+rVnm1qminT2pTzglVoMiM9TMayesH0i5cCtPg5KUpEE7AYHCsJs1dAE9c1YjjemyQCuoVchBIKgTXs4WN/rUf1SF6X/nM3nC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0z0JHaLpdb7mXb46/SkS7ewAa//p/IOvRy3rqQYnmo=;
 b=zMSyUjUsZx+7hfGC/On62YvaT/FwB8IIfYug4VAb2BOzyQODCgGXN3T7JLtNGTsuPJjFWK/IDXI636Ikn63ZWWQjspgU+kWSd/Ryia//nJQFL/kZ6QTU+CVJAkKLbWeLdE2vKUbYpUVmvc7CE5qVUMuKlECHcijryKVmZb8K3qo+zaSLnL5a5m8SNvQ3pHnlSlWP52tlDktdC4seEpRKcfYt0zILnxnII++2xLFR381TnukEtOUnrOtD0zjG0jZRxg3LK744M0cq1VkAfFqL4xyd6WMKXOrjSgMbXFI4ZTANKgG9WSMYYH6cOdS+uel3w/CG5SKizEzQSz9B7+YO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0z0JHaLpdb7mXb46/SkS7ewAa//p/IOvRy3rqQYnmo=;
 b=QHCP73jh5zdph4zrZXng7hnY0U5HRcpxSGTZnhhpno4uJ5I5by6IQYmkRZIw480X1HBefSB9a+BuVkk7hFwppWxWnkB2y/KkCaPOFuLp1DDeLr2WVzvY8tbCw4DNIpYLTR4O7YP51BtlUJ21U19dHYeK59gA9ondX4+eaZQcrW4UBwX7Knok6EqU0NtyT5aEPJ6LGIBOhFPAijAJ3QV9Fs/Ehq/TAu/V4JENmGXTJ91GyHEZA6IuHNKLZxgVL0KBlErU4tCKR0ucDK+ogS6IMjNj+wxs95gLjeNFPbyI2+4EuAM1aEDBwyVwV9a333V1t/o1c9xzFOODGDqbUljsMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com (2603:1096:101:4b::13)
 by SE3PR06MB8072.apcprd06.prod.outlook.com (2603:1096:101:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 02:29:55 +0000
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259]) by SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 02:29:55 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] The vdpasim_net_work function handles both transmit TX completion and RX processing. A descriptor is taken from the TX VQ at the start of the loop, representing a buffer previously used for the TX path's initial read from the virtual network device. This TX descriptor must be completed back to the Rx queue at the end of the work loop.
Date: Wed, 17 Dec 2025 10:29:18 +0800
Message-Id: <20251217022918.225-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To SEZPR06MB4998.apcprd06.prod.outlook.com
 (2603:1096:101:4b::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB4998:EE_|SE3PR06MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f0a0ec-246c-47dd-1ae9-08de3d142a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/HHpiYyj4L8NJ8hdIyPuTzsioNdeIkCGztQxamueWPhpBG3k1PErOuijaV1?=
 =?us-ascii?Q?6UcWot4qiWYwFvbkWdmx8pNOwVr1xaW/uVnPPEdmH+F5p2Le1quyQ5TzkqZN?=
 =?us-ascii?Q?V3WwZJmR+5MBDzglS8pKb7SnORb17+WdXO77AWJ7ZeYns5KTpWZYx516b+4L?=
 =?us-ascii?Q?31/S2830e7KVgV4ieIlhuX2FObotCP5Wk3rdzyvT5bIevG+MbGEext7vSsWL?=
 =?us-ascii?Q?LJYL45YxH+lfm/seTfgrq6jfV6uXmmHJeMmpDdqmI6R27vzU/4EduIx5nhI3?=
 =?us-ascii?Q?QvUVxUIALHfPmraMRTBbZyRhQG2u4vzcNbus3B2+ZqXRnoortzFJV+RbR5Fx?=
 =?us-ascii?Q?jgpPWoxHGrIE0Psu1xw9FKVeaJ4RFkBWgXmkqaHVypA/JixAxSxUgPIkEQ1g?=
 =?us-ascii?Q?ZY73P6jjjljwpsLGTvoOAVA0pjpYYNSDHTyW3b7jzSLESSldC3e05MW1bX7j?=
 =?us-ascii?Q?d7IYCT1qu3BNzBt+tbBVzew01uLuSkC5fWBKcD0YqdHCED5r7TDBkCf08f/x?=
 =?us-ascii?Q?jqsDgmcYsLDUzWvvfiNPB/SB1nFQfGzlsqVScAGuoFrOondaqry/apF9tAhu?=
 =?us-ascii?Q?7QGLOYFb2ife6Cp3U/T1RL0lXkZbcfDQcisX4k53BCBWG8/szavIlt0u3Rx4?=
 =?us-ascii?Q?fSZW8RfHhJYz6kvrgeVnxiCk0i0InvFQIE2IYGscBMOFyLlr0OxQQ2HJCwgU?=
 =?us-ascii?Q?mmvJcnRjLO6eOv9OMdVYjVo47H7pi18yRfXJXwRBFhOLcURRrQvqNjAMXR9z?=
 =?us-ascii?Q?90LQDQu5mniOhD2kPhIR7gHZJz5rbZAHXL37HeloSwYG/GlxXg++7ZGDFziM?=
 =?us-ascii?Q?WvfXhsG3qezs6hneP1FN/tgU3CyQEvHVw8rzCIoYPUxM0SNbI5duONj5utAC?=
 =?us-ascii?Q?C1QUp/2ePRUSkA0O/UFvEfJTzS6LAQky1qlp5fv90p0HCv2FqhriNhfLOdlB?=
 =?us-ascii?Q?KOyaWLgMMiFk2GuOGhz3A/nyrp/jrYpv5XBcKCdBvwXgZ2X21kG/Azksv5/9?=
 =?us-ascii?Q?pzAMMOY1umkuzBvKTHPANmyLTL/dmpTNqFyytWBnlXgVD4edWps3b0wvFy2L?=
 =?us-ascii?Q?6y1xd+zujSrJ1w2vJcTm7MAjYoKNGAbekfzq1VU8swADYhHW30LBCUIYSDGW?=
 =?us-ascii?Q?Lz47qEqLwI2q1Krf0f02i/yNFQNE7U3Y6tcbEVmMNEWqMStuJTGmh3LsLiAV?=
 =?us-ascii?Q?m06zPJeHvAAsmTWdMdki6X7tJA05Tpe5urv41XvdUvuLpkXsyJQop+wtYZyP?=
 =?us-ascii?Q?iaR3ylV4OxyMvB5ju6RkoUDyHPMSPkU0Ji1zX6Hvfc3O0nygqAyI2ssSezoQ?=
 =?us-ascii?Q?FXYPOTnNEm9WOSs9qjoqZnw9Kj+dwixcufrVpJj2F/gEXfV2nfqp+HYuqXay?=
 =?us-ascii?Q?8XPeZwwDn4SS7vbBKkpr8Dg8oxYOaKNifaCFOlUqX7AKsKPfVsJt2PSTmHSp?=
 =?us-ascii?Q?ngczKc1DKPBFV01ZS5pQNFxXLI3hbENf02ZBTngV8hKqgghFu0hRKuFBOthV?=
 =?us-ascii?Q?Lr40Wm6VOTfYjNxgXmZdloqvJRvlHbXUebKt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB4998.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mo/7d5LhPkCNDwidzkR3MX0AuP+93OA1RG895aIUTZap0Y6FVk+0POxx0NUy?=
 =?us-ascii?Q?X0EmHLLsmrX5b+/aXJEDr4sfpUTNpj4XraRImDe0SS+6KrLmpye6P1sgiQKm?=
 =?us-ascii?Q?PAzfNL3dmimgYk5pDbU6c1P9/E0UZ3H7TlLPS0aRwl4EzcTSpy/RdG32wHCD?=
 =?us-ascii?Q?H/EGfSId+GLRcFl8xrSmH9Wc/G5mOPCEN+1oxdF+4nZnWzcVCYHL6pACknnE?=
 =?us-ascii?Q?A8mI7JAFsyN6edIHHF+g602NUbcbg92NG80g1zV9E/OFRS4gUrUyN9m6pfxA?=
 =?us-ascii?Q?ER5v9r0AOmsgcSJH4T5TIp5BbMtDTdy/+m7fOtqZA4wP9DTCzDvr75kWSnSt?=
 =?us-ascii?Q?9lJNISGmLNiZAzy5SeQWs8jTH36/MvKKernQSd0m6KhnancPsBO+aMHIRcIt?=
 =?us-ascii?Q?m+AzQkyz4yiK80iO5CJJfGSNjK0m6KAnAPnJHIvd/YfZvEAfmLMWir4kkLmn?=
 =?us-ascii?Q?kQjUMnd1JCoSfJjPWo9YRhyvc7lcsEuf5L8WPWFXh2e9bAiFzMCs6enjznMH?=
 =?us-ascii?Q?4MdQWM35he+aqVyyN8PcCD+qlZBd7EduhUmWjBCrYF2tEYmVAKGaFoXucbb2?=
 =?us-ascii?Q?voi7JBv4oT7hSwML6OwW4lsShrMUa7oA8psUqiBAQmJ/keLcsr7GaijnxmoS?=
 =?us-ascii?Q?y+Ey4+VwxGUG4wDZccmt67o0rcx32+fhVsrRlvek5ycnuUYJwfsgdH+3Xa0r?=
 =?us-ascii?Q?upnW9n4TQV8FiIR3Qsgms4gDmQ22Bde+5FJyRulwVcYcTz1c3vDjLnnrovY4?=
 =?us-ascii?Q?CVeBZieMJDOGPz++0+BuJumoPBm8orcaJdm4haS8uxLMRoNtqT3M2DTW9aN1?=
 =?us-ascii?Q?42UZGqKrR0hQ/yPZDkd67fb9pisMcChl2hRaIpp+FrGq0SyqIF3mtEo50Itg?=
 =?us-ascii?Q?+PXmG3GCN6nSGGGDL+f6Gn7+kpvE/daDiAsTqvrPm3o5AFsbY1KXU0GHT0EA?=
 =?us-ascii?Q?Q3Th1gVUZ/unm3+VyrXWBrFwaMDDVhhePoL1wFY/LOsxNbvFpqAzgFy0R+Nl?=
 =?us-ascii?Q?5TUUaNb5hk4pI9ONfveujELd4A9aXobQG4vaPyc1VOP+BDrjHUt9VVTaiBh1?=
 =?us-ascii?Q?BXgmqU1w5CFLKYZLWA2nYnAFEE6LsL0dXs8Nm27fKT9zx4y209BTrMrZ39m9?=
 =?us-ascii?Q?NXHLOjjBhHio8iJHbFsffy5LWHnXdPS/f7Jw6bWOCy3/Xydj1zoylmMz17ad?=
 =?us-ascii?Q?msOlEHVsq/4b+eVsdWk0i95ILYgKzGBi8qyZwYfKnZlfMogUJs9FAhSqV8tK?=
 =?us-ascii?Q?SJ78UlCtxZ8j0MrufyXhDGSzAiywNzPv9ZcNnUZEUqsQwwD0dAWIeItN46Md?=
 =?us-ascii?Q?hYV5Z7mSSVf4bBOJwUU5dX9/bBLJ740uYMCOYeF7x0hpsG40udTcO/0XD1zN?=
 =?us-ascii?Q?5Xb/TemdIfl/ojrXngT5G7CqPY0InaRNBKybnDOounDaNqhbX4yeB/PdxRIm?=
 =?us-ascii?Q?fAo/4zMH1nWZKMYrbdmw2LZhYLo/x6w89LK80zSFHLHy9rmfqajSLO0SCKLD?=
 =?us-ascii?Q?psXxgXVlBUUNBnOksrSH2Vvq01Bp3KCgQVyv8VhZEt8dGSkpfTt4S5/IqV24?=
 =?us-ascii?Q?lzc9d+naxmFywnthkocRj3li4Yd29Pt8b3mbNVpCH+Z7QKxbIsNC35dH4Vxs?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f0a0ec-246c-47dd-1ae9-08de3d142a17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB4998.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 02:29:54.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR6bU+eLFVZ68wrr3mMBkFUbkESYTtwZc6pBvpzYLnJeYnypIv1P/g/KKjpC/SF3gaV/h3Y3DPtYFMCpVfuZlhFak9zvMTx9CtqJIofDnVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8072

However, the error handling logic was flawed:

1. Read Failure (err <= 0): The TX VQ completion
   (vdpasim_net_complete(txq, 0)) was performed, but the unconditional
   break that followed prevented theprocessing of subsequent pending work
   items (other descriptors) in the queue in the same work function call.

2. Write Failure (write <= 0): If data could not be written to the RX VQ
   descriptor (e.g., vringh_iov_push_iotlb failed), the flow would 'break'
   before the TX VQ descriptor was completed. This led to a leak of TX VQ
   descriptors, as the work was never notified that the TX buffer was
   free to use again.

This commit refactors the control flow to ensure:
a) The TX VQ descriptor is completed back to the rx in all error and
   success paths related to the current descriptor processing.
b) The unconditional break on read failure is removed, allowing the
   function to continue processing remaining work items
   until the loop naturally exits.

Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")
---

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 6caf09a1907b..298bd6e8e0a0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -242,22 +242,22 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 		if (err <= 0) {
 			++rx_overruns;
 			vdpasim_net_complete(txq, 0);
-			break;
-		}
-
-		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
-					      net->buffer, read);
-		if (write <= 0) {
-			++rx_errors;
-			break;
+		} else {
+
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
+						      net->buffer, read);
+			if (write <= 0) {
+				++rx_errors;
+				vdpasim_net_complete(txq, 0);
+				break;
+			}
+
+			++rx_pkts;
+			rx_bytes += write;
+			vdpasim_net_complete(txq, 0);
+			vdpasim_net_complete(rxq, write);
 		}
 
-		++rx_pkts;
-		rx_bytes += write;
-
-		vdpasim_net_complete(txq, 0);
-		vdpasim_net_complete(rxq, write);
-
 		if (tx_pkts > 4) {
 			vdpasim_schedule_work(vdpasim);
 			goto out;
-- 
2.34.1

