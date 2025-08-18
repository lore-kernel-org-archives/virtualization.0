Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0E2C2359
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512950; cv=fail; b=JvK0rSjFvbqGt2qicwUhMvXUrEZLOx4efrMj57s0K7hYNp4qEBb+PrYI2zW/+Bj5HH3fLVjHii38SVYBK57/Qqq92ToIp48JmHnh2AV0bLT/bEtxF+ACPe5CX10SXAYVrzk1DSgJUXQYmuioqKmrm4OnxlmjSIwG2wEkMOvFg1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512950; c=relaxed/simple;
	bh=fOfkdZWgo1Di9WrKNDng1+Jq4r6xTWj9CDQjrdqinx0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KxmspjqSVFNa9PsKRllr8r4IEpd9v/4oP6MRazkOKZmO6GmIsTeh1WBQO7oR0jwq/vHIekp7AksUfZgc2GA+6ksRVRMpXQtyjslC70qTHjK8YW8t33Ek4TooXh8+CGTK8QW/Lc3cTvm76ij9EmX7ck88QYDNevortJaUw7YH9GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EYlmIDhE; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EYlmIDhE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekJFTYTtGbWfFHpA28NKmFDUqJoQRfHF8KLubRCP/l2ORWCqa1qevou92gQ5d4cF5GYFOUe+W1Gh56WTZYfwhRPtOmp9AqcBDWPToR53f1k9vfwTLtO/YG+qt8hXShUh20qG9evqWxA5zPwenUKe9fWs4ofFrfkm76pmBQ82GcFfZTCJZnXMghkTiqLWLCsVu/EVkGuhRjW52MpXiS390I80jZmEAqrcOB8X/Ktd3lZ00tPGJGXPDoQWAFwfh1Y8hPqpUFBsGzRJFJJmynzguvQxm4tWBI0B/+pwH5oUqnbMOHha5bz/KrPKFI9dNJMAEaxiC1YPSNSNa0HLBkKSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkGpBru/M1Plu9XVa78ANpRG0guUp3PvlwJH53RgdJs=;
 b=BTmrd/98ZEcrXzIZjQxBEEoZ/eBylU+jr+DRtJwO+KOJhF56XnTyud3okP32JIDdBxE37sDJRu9MZ8rvjXdmCBwtFeLW5XN0T5w+FTKyojJa8aZbwDO4g1qXZsiNVCl6y8nSp/JyPBRQnQzLa3i8p6mRyM7SY0UNXnZTNas/CDaOuVyJZL5Fh6+xMbCV+ucR5u6xvBNBbKdTgX16LmkPhiaXEzQPaIcrUimHTAmfFtn0yCDG7Q1zYcQaKfdIOjjfK3e4/EsB1FzPYjOHxNgef8RPXY/Rc8LwBsA6jjcMT8p0iy8jxfTxhCj4M7ChjeNWR2sNtr40ugND1Sny+MIfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkGpBru/M1Plu9XVa78ANpRG0guUp3PvlwJH53RgdJs=;
 b=EYlmIDhE6aclSobJVd9sppEIC7dLQKfkCiXc62winAHS9s2t1fPGHov9r1QsfgkE21DClhGv6R6d69W5NbVp7teUzEDC32anztVnjyzwZozYu6poE2nZSSSZTbImSLb5cAtHe60cSdndQXsvsffOYkwJKAp1HCox66AugQTo7RD9HhOkNZ6VWK24YJRsZeaqUF6qiAImFKrdmesTND0ttGinWiI8F3ERidPJNUxKWXZT52Z9QBK+/DM+oFzdJ+kySBPEvzlU5nYxsVQp6TmXWDZlaH7qi+996cCB3f3NMub8o204REW+PP6R7AMKBx8A8HW3CnCbLBNTmCCq8DZzFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KUXPR06MB7997.apcprd06.prod.outlook.com (2603:1096:d10:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 10:29:05 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 10:29:05 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v3] virtio-vdpa: Drop redundant conversion to bool
Date: Mon, 18 Aug 2025 18:28:48 +0800
Message-Id: <20250818102848.578875-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KUXPR06MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b38e8d-4088-425b-33c9-08ddde420ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCvDyOyxgPosjCK5jbACophppwEKXiR4PRC2MY9JLHhJviGu/c2BO+O960CS?=
 =?us-ascii?Q?WGt5nRHBY8DDkcXo1OHkKbbSHiNIg52ax5mKifbGQdAYszHXpRgwrE2abn4r?=
 =?us-ascii?Q?dOaVP5FtHd65jpMsAIZwyOB3W7x5AvIIiPv2nyPk87Aje7E5UFIF//fqUI2Q?=
 =?us-ascii?Q?McL2Fwvzz8zqgD3aRFlVof2BkuqVc4HDzYWYwa7ougDh+0rL9IkDc4mkOb50?=
 =?us-ascii?Q?KKZphaz3sICSCTvwojSnQFINp1T45AXkyOwz2Glbe6lekIr6dXqJiyd48JZX?=
 =?us-ascii?Q?Najr/FANLvjK4ck2CCEb8hSlo82YPWkHESnwhDm2PRlT98QoKXuqeccPsygA?=
 =?us-ascii?Q?iMh2nmfpYhvYAE9xroLoIN0D3oPFB9g0RTAtHVXac9g4nvwQSBNOiffOpvQ6?=
 =?us-ascii?Q?oE0OrTYAPdjT7a8DGRkUiDSY/tSoCD4ve/onD5xxuqbG+y6tucWGIpFhoRQD?=
 =?us-ascii?Q?lTpaIITPyX3EkPWPlnuXLudUGPiTANRn2MahVoMAEWtMKahVsuZXDGwTLt0I?=
 =?us-ascii?Q?B//65Sqr5/sRd5ToBtaVXSVPwNtfOwCDdGbEMAWexXKQybh3dKlo0POLW9Un?=
 =?us-ascii?Q?gI2i63y2OUAXKQB29AgTnpfQcq7seZ5AeQT3j2Eh6So+7eK23QYlZ/vbwVr1?=
 =?us-ascii?Q?raOXiYQqSaiCRLnBHYSjpowTHoNe/0zR/HXsKS0DwmGN6IolZUY0OcYY+N4p?=
 =?us-ascii?Q?uop2PsVeILnBuPx/qWoMnVJlc/agpTAz98e74or7zdj/TkSIEySPsgNDsB5s?=
 =?us-ascii?Q?FIJS5OUE4Hx8Bb8NUr2YUlyPLP/VDpxPHoY+fBTMDA6ErieGK45po/MyU4Ls?=
 =?us-ascii?Q?ru34eOCzQsYnenQSNLnmeafXRFZGXlXGPKlZ+bCkLLvmID8Esw1IFf/BVcMB?=
 =?us-ascii?Q?K8X179XdsoYJYWSXHWz7tLc53ELNRKdaKtPcwM1cpA+xiUDB5oJF9zKmvBK7?=
 =?us-ascii?Q?cJ/qqF8MUG3dP0my8wROrkKj02mFZMvgGApvxRXWYnCk+l+s+a/+IJZ2RnqJ?=
 =?us-ascii?Q?F+a3EmYbtm9cij4+zpXVlY01bn92SiEFbBFoAT8oh9DMq4mz/MbFNLr/zGsK?=
 =?us-ascii?Q?ql3mxzzNeAe4+aqOnaRZ731jCg8S4FLjilLZB1ZusseSnChjEdTJMXQWHpFj?=
 =?us-ascii?Q?prP790ESWdiafQiHv64g2VTr44cBITEULNZH6LA5mE/Hp8UHeMdqLKkxyHGp?=
 =?us-ascii?Q?j/fiZu7Q4IfGahJmsvBzNyTS9DPiIhHRiVYfRyritLQ4pZEl1K+07pdm7V62?=
 =?us-ascii?Q?kQogjdAjnAEUdVDAkPTveyNgXZWA9sFLPpc18sZes823Jlhfp0zZu6zJYjr+?=
 =?us-ascii?Q?zUx/rjNCtAArJ/+2OaDnZoVv4d9D4+r0T1Oz8KUQ6JrDzpLMP+jt+haYUMFZ?=
 =?us-ascii?Q?atC42+wRhEtg+IbaiEZXNoJB0UxNPI2Vsz9AzoxzcHeZAd2CsSHtd1nlImv2?=
 =?us-ascii?Q?6DALMl4kEjwPF21llFGupDh2M4nns40mQ5A6b/ZyeDriQgtJmxCJpd0d5fAI?=
 =?us-ascii?Q?dT68dkGJx7Du/VQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKcKWnhNaKW/voayv3RNyt6JV2DIErY9PCBogBukI+s9p7zvmHz8wh6sRqpM?=
 =?us-ascii?Q?rWdVOLq7tmR9SMBGKQRbi+AU1pnU4srSPoaVI6TPP2xhcse3ESA/7YCfNaKI?=
 =?us-ascii?Q?1/jXMyokCX5nhGWIFtfHijnv+6gFrx4GOokSAw2e2EIIwx855eaSJhgB7iFi?=
 =?us-ascii?Q?jxCK35JljrD6neZQEKXSFyVmb/Er67+DApZ9djoFSrnjv9WkVwF6MXg12ITg?=
 =?us-ascii?Q?9ZyL0V1FbNq6SwxugOwFqAfavURx+3GH9f/YMsg8oBj4FwPjTWCPOMos+vrn?=
 =?us-ascii?Q?KjzYCVB4dvl9O0Xu2uDMr9mO+gwl82L2YPUcdNYxxtkq4eh1NpEgDFAHrwmm?=
 =?us-ascii?Q?jwqR3QRwG96pB0JJOZ8+HN4jg/SN1ueXVaTQqFmnEyk5zi4BaBV+/1LSZ1GH?=
 =?us-ascii?Q?/2fr6gtGY4OsKcG2YLhuOF9Geoo3dH8YmQbKluhsPbWxv6sy1WEC1c7IS5i3?=
 =?us-ascii?Q?rhbY/+HVW0lmkQMxwZX3jkKF3FygJER9wJ+BdYts6L0xQ0dQEx6tF1U9i9jZ?=
 =?us-ascii?Q?waFyvO94/Ijc124BaCepQkdinlgNB2puoxKsxxgcyPDMSL4bXWf0RvRII4mY?=
 =?us-ascii?Q?BjmLIxE572WbIFFLvqBJYTBtrwLVA5XsM3tGdj8Kq0e+KQWKTdGBRzAtwycf?=
 =?us-ascii?Q?X6mlsO6j2kGz6RCoBcKoStO2Ma3G+Fl3QVSAoNmun93VMMzT+tl0omgsk+bL?=
 =?us-ascii?Q?aiqHqyWyb5Se/laxpMxKcoL6Ey5sFzxkfLCeUPwFlLl/fZ7VOsM3VxvFF4fJ?=
 =?us-ascii?Q?pdYPLFPXwmX14m1GiN3x9n+wro+jxY4QOdkXZ0hHyojkR5eiZ4lDJXbv1+bw?=
 =?us-ascii?Q?EVuUBT4nZaqtDoHzr69mqmnktIlOQ8nucC2pT3RNBl0wZwCL1+T+sN3HNpqg?=
 =?us-ascii?Q?uzewhQeKyGI29NxFBM1f2NrWK0dIn51LsMip7yV+tTYWNcQXKl0Ci03jV50t?=
 =?us-ascii?Q?/V0sBeG8IE6sTTqQ2mLTeYaW+HpxcqC3z68zJsn6PJ/EsEI2pToA8sgFna3I?=
 =?us-ascii?Q?Ve/FhqG0T8gjSvQgTMerWmDvjdFdWIdZJVOtTm45YSBImIE/TzHIuN3pr0Kc?=
 =?us-ascii?Q?hKQB0wMB282TTcgO14mwrn0N/Mm6mxr4gacTZbPZVqnvlPjeyKvyW2YFVs2n?=
 =?us-ascii?Q?m8zBUDU95+Pv9jPhcfUOnCdLyXgZHFqTU0x/hjrXMt5IIYC0yKxPqMY2cGQN?=
 =?us-ascii?Q?31bwZ89rbtOvyuNGxIUR/FdORORjd9URyToqrxVZFuwTPeFSa5axLqDZve7y?=
 =?us-ascii?Q?ZgjEq/jZvJW7ywwlBuD4blObUxFRoxV5ExKIQncJnKJo/oeNaPqJbdJs/dzn?=
 =?us-ascii?Q?kCnA4y9iJUpXarml4iDQleF+n15siPF8F5D6WoxuWpGJUcrbrTdKWv0eWEG3?=
 =?us-ascii?Q?Wgl21wF7rdTdDcUQZUXATWVKdggQdKSK8CpCdzve6qJN5NG6jg/rNPwsjdGf?=
 =?us-ascii?Q?SvKsp1Krbh3y+1r8k+czO55JoWkuoq6B5MJ24kt99p5qLoFeS2H2exd4Pkxi?=
 =?us-ascii?Q?yMYJOJH2iSUWqhGlmSxcipQFqeqGQZ0Mann/qVPCunaI06/O+EgydOSoTtZ4?=
 =?us-ascii?Q?Il1jVhIjPzqkXQln7g9D1/2jOLrUgUQ3tvWci2AO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b38e8d-4088-425b-33c9-08ddde420ee3
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:29:05.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAZLq9J0/mBuWP2lpZANTOQkvykibVoMLGOyQ51glXwVPaypKEivyAx4w8zcA/4ztRnfUVuv2sqrCcTocTG0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB7997

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
v2: Correct the errors in version v1 and modified the commit message
    and subject.
v3: Change !(max_num == min_num) to (max_num != min_num).
---

 drivers/virtio/virtio_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..deffbac33888 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -176,7 +176,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (max_num == min_num) ? false : true;
+	may_reduce_num = (max_num != min_num);
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-- 
2.34.1

