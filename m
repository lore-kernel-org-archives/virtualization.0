Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.201.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794327858;
	b=h4WNWUdLgQM4I/3dl1Xc2dWN8PerYKhGC2VZ6VXHaEf6sVgXMkSROypFf92sF/NY65jS
	 9r1e7cvkmRh/QCABciDSbwUYI5qv32x1yGWjxEBIyv9ePgIMyOjLf/7zAdwAv3Pgi0EVe
	 qPRuDZJquqEkwga/QDJcShC/ZsxLI+riAjAXzZk/7rzGwAgk+gemWYyog+StrGZ114UHn
	 bmYUPDuS41gmRYAGtWlHhC/DW2/9VEsKrMYvFaFmI157qfJsRWZYuCT+qa1UqEI0ExnF5
	 v2BxmgPruuqVpw0ZN8vbctIV7Xpnq/6wK7SbV+89bTgE02ChxRpcVkyOIVy8rLEfN1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327858;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WuTURMt+GVaaHmOPrSsXaBKltS+dBeLJAN3zzUBJorA=;
	b=pocY/06Y3xaOfblifsv8WupNL5X2Z6kD8aEvHNBY5cx889lx/7EtAailOpH9UE5A2SNc
	 l68wfsEflgfBTElKtSxl+oF0Hisey3Q9c5aErrRIXjzme5LSexN28OQ3TmZSyAdI0n0u1
	 UB51lT+PMQo0jK2b3ZQRkMMH81Vd1+9JrFZzJWnzhAllcTJ+FHGx0rhOV9aEyTGLuKOhQ
	 2UIvpBFD8nvKDzgDcsJpzA4LBI/b+WNK++7GbQ0ZkjPOWlPfbUObLdMUqI2aNibZF42tu
	 GaPvg7Xl2OTlK76gyNr9TxGArZJ6qDzUD5L+F6wehJsMPxlrnCozGw0iSqkTmA8VotQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gudxuXxw;
	arc=fail smtp.remote-ip=52.101.201.50
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E87606A332;
	Tue, 10 Nov 2026 16:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E87606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gudxuXxw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6oaC1UzM84LXNJll3IKiOM0u9czb8aG8kGjzSlv5D9miNT1K59ma01+zxIrORkpc5jmsbbfFmBqhiUAGs4hhj+FZuhJoIBBLj1uYAfbzHDB8fFJj/2YEXDp/7GGhhcACh2R/z7vGAN92ti8U5aE2NRlsbr2DjzYL6XqE3dsfUpvfiMb3hfTxsoEPRWL8opTw00kYXRX4JGSCicBeugAHiz6JWfmFnkZteSQOrkcAq1ZdDrziKVohT95xVUYk7elv+GHSmJ2NX7XUeSqYvKzVD3JYEHiV41wiUWIAyoKouIUna55ErBgQElJcD8pQkXpJERL9WNvaHr9lkH7XL2p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuTURMt+GVaaHmOPrSsXaBKltS+dBeLJAN3zzUBJorA=;
 b=QR9TYr/4zwJhva8sX+6/jOt5R9bt3cqHKGvk7K6PwVCwCg3XRiJqieHISrllyOTI6nJPUoZyAyNk64Dwir5m6SgqWSI+gPzlL/AZt9cRsfhnDzfSXGZ/Kjfys3BnLxUKWb/J70ySjLKdNGaAFb+g2YEVLbb6OO27B6shs1mmnaE+vs1a+7m5zqrPATXR3wodFy3oH12nTIKPD783wgdws0Vox1nGzddkXW+EbxB49ALGNXKXET29azo4sCvl+lpxHdGChI9ojYziN528P/9mv3nHMBVggVOZjjeQ7tAl15cRN6srgKSl7Y+iD48yItKTrZdE5AczouLTtVXe2A0W8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuTURMt+GVaaHmOPrSsXaBKltS+dBeLJAN3zzUBJorA=;
 b=gudxuXxwLenYHGX4tZwM/W/kBPiGLYa1C2bz5eN+3jNen5nJprbWSe7JUraHS/t+Lx6Ori8TB20f8liJkPrDiGlI1Ujn639nMMx8NdDfC8kO+Iwr+lbBNDpdLq8K02MIemynsZZy9OkCRDa9OzH26YqYLuYW/xSrYQffWjO9aVeHcorZCAnsmPRDM2uSEd+dh0gwYZT8fEywLHrUfYdZYcfkCRB7geSJlCVaj7crzrJQISlrzmtnW6nUiBwYx8cQ2nbC8oIegJ3dlF/oi1wGaNHbxqvvOfLmxf+N0NekpgzT0ZPG6+aUyUVBySSqStVbjiJTcEw4SmvQBiGzqG4adg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 16:24:09 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 16:24:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Bernd Schubert <bschubert@ddn.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Date: Tue, 10 Nov 2026 11:24:06 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <3210F1F9-275B-4962-AB48-B139FA1ADD33@nvidia.com>
In-Reply-To: <20261110145241.536019-2-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc436b7-fc16-43c1-36ff-08df3f470c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|261026121527099003|261009223027099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6VRDSEl++l27nzZi7lt3997xQr9rv8S/ydgkfsnw2pIc67WAlyuNN60yabSgAPY9vd/1YGBJqWDbrl5menk4m6WBd3ztnpN+OVOlYWgYx9KEzi+AWLC+QWCZLpJ5K2hKnqU9JhJOTx6cAKHts6n3XiwRfAYhsmsBPyrIC1rjN/BIWFPqqij38Q7MuEP5jgv0gkOkld0Ce4AkTonzxqmUgTt2gc8D4VGK6Pv4mQwyVC58wwH4rectu8WHGdeN12AULmzkMylKS0kiG/XgB6F+hmxZUzk9RnmyQ3ogJRYfqkzqlc/w1NUHQwuuCyImUixbMzMdEDAkFVIOtVEueVRZKHWaRpcCshKJjY7UnGvpy87ORomnmVVG/vAx6JJeiPP85rkuJkC+O5It328ntMAKX8dfqLsFv1gaUKpDJHFctHMhgDkU7H7B87t51U5vEVatRd2J2U34Afa1VJKWqr9Ps3LwdcKtc5a00lEXiGumhKeAQPPTuWNkp3TYowz3+xpKrRR0x3QSrn1So8cv8YuKE+hItN7OnZLNsT681yg5fn3Mtn1lJAZ2g4ruAx9vxv93dbHR7MDnyHRcWjPtEbcc8lRTuSD8apZS+26p9GnDzHBJfVW7Cu7n3/CrwEEbcGmGR1b3ucZlzQrakAJOe3d+Wn7sov/sC8oCQfw25o5UAj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfiV0texI8BFXsg2ql3DdG3tVClLbc0/GlFXRnGlc22TDCwG0lfGZuivjlqP?=
 =?us-ascii?Q?kN/bmzKiSbwnHYZA6lSinQRSf7p1UEHR0Ul6r7nIyQrkOVGG/cIlASDCrko+?=
 =?us-ascii?Q?HjjkR9s6wRFj07gFrgGoETrh2j8TKG17+WKCC/eM1Q5uzUoLjR2Nqcx9FJ5b?=
 =?us-ascii?Q?TqPfXyeYqvDz1SQ0biMR0bRIrxRdzKmtCwzt4YATQPbcOcJUp/xeIZ76aFpD?=
 =?us-ascii?Q?KWT/zxMD+i0XHS2k5fPnh5g8C4bphJIg5CGgEE67zmE/rs0SBlx1QsMQvyjX?=
 =?us-ascii?Q?ZJaASxLL4zWXNT8N+iJo6L/ZojzB8XNA+fuYMlFupGMpKBsx9z/op+puf/8+?=
 =?us-ascii?Q?C5yeUcNEKbjKBuCHN6ElDrq26w9Li6A6o8xXEIhgY3lF+iczGUJgOLcneXA9?=
 =?us-ascii?Q?FVa2r50xp3et4FJxIph+1JfGkk+EMPfhihIVNn28icFIqIeSSvgh5bMlg65r?=
 =?us-ascii?Q?Rp1hsTksyvOHKaYX7isJNKfF+TqgkB95iOZpMTFbY3W972DHDf11ExBV7GpD?=
 =?us-ascii?Q?k70tcK1A9eeqA8wUxt/Jz/QVBhgODbKx070FgwBw67KYL/tVxh6u0zhi1tu3?=
 =?us-ascii?Q?CVGH23vfKxj9yiNgIDFAdNnfuzVPL+ME4wwzMel4iavDFfz/Cu18vLahXceO?=
 =?us-ascii?Q?qbs/APTlIf1WYgB8yzDy5txIvhN3VPCC8fL0PrCdM1IMbvWtO/8YhVDxa5Eb?=
 =?us-ascii?Q?WcFeQrmUwfpiTCRRdrpDErkcyYkQ5BH/SgDaBh1FYUCK3P78/qJXlbP+MRtO?=
 =?us-ascii?Q?vWBGXC978vVyKZpE0Z5y4QdGKyJDAHbwS7zicVtpchTQhvmhiZnILv8GOco3?=
 =?us-ascii?Q?MRyNiH/rcG4NTxXpcXGdJhhGwMAQjbxfENQsJNs7m6QaVp1YZnqLn6jyUJZl?=
 =?us-ascii?Q?8XlPc66rZc6c54HPadIJjgQCOuNJ94x1JhEBGHG+U2FwImoMswmKttP/GWj6?=
 =?us-ascii?Q?x/BnABMK+ThNJCV7kkbZ3VRgaT1jXVtOvA1K/rvByv/ZypfGORSq2D1QakfV?=
 =?us-ascii?Q?j4JYwhn5mhpyhzLtMPsFLmwrz93Y2y9DS0zBLBtn3bRLsIzKYcNCKMLTRZAZ?=
 =?us-ascii?Q?k+8GyUEHq/LzGc3dv7onUc7sFD9YYlHDe8rQAiSUVYK58RrAKPdhnNh7dCfo?=
 =?us-ascii?Q?dpBwtbVcuS0PGbbUXzg8WFSO+xkvyWP81gUbDQJofgINpIBfVzvK0s11GT8S?=
 =?us-ascii?Q?gS9lG+GjyDuyOeNS/ygqRjD0JE9eifj0vSiCsIWa8lJoHZh1heSD9e8vhVhF?=
 =?us-ascii?Q?Q8Lat3YX4N7OkzueuHTHRRreBLqC/dcL3o55Etan8RPCUq53XteYgE/SgZUA?=
 =?us-ascii?Q?rfDj84Z1viNBPM/oR1D9aVwOMOA0bXLnOGoZ9n+bu5gN8MZ8Y8qWo7eJWOMY?=
 =?us-ascii?Q?QQmIjVaZ807sDH3rikx5wqOL/y0pOc2jbFwjwvzIoIAoCaP8grVW+N5wI3By?=
 =?us-ascii?Q?yI4pR0UhfHK3dXMPOsRwioAvafaniyJaZl1phucmsdYQrwr3BboxMXTp1QkH?=
 =?us-ascii?Q?IG9p9IcYsv/1120gmA/rDApL6e8PrSUK51u83Bj05+SL9Yfd4lHJRMsPMN+9?=
 =?us-ascii?Q?IsMn1BH3+CRXiGJdv/VvOorZkc3fsPR/IzH84jaZC5wjq0FgyEx6sUTj7d3O?=
 =?us-ascii?Q?Un7+4d0hyg9ILgZFfERTclcP3mw4tXD+kbodsHp/z+uw2kLWx189aVTDnsOM?=
 =?us-ascii?Q?BEqbyLhih+QACjUf+S5Sl4P1q4fUC3H/YmlXcgG5EkdYPeue?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc436b7-fc16-43c1-36ff-08df3f470c37
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:24:09.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NQOzA7teSmq/wxM/Oktyi0JtVcP6LAIiDw3gDeS4ADTf0UyiZakIAWLVcDMcy4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

On 10 Nov 2026, at 9:52, Kiryl Shutsemau (Meta) wrote:

> pipe_to_sg() tries to steal the page of each pipe buffer and pass it to
> the host as it is.  When the steal fails, it copies the data into a page
> of its own.
>
> Pages written into the pipe with write(), gifted user pages and page
> cache pages can be stolen.  The ftrace ring buffer pages that
> virtio-trace splices cannot, so that in-tree user always gets the copy.
>
> Always copy.  The data that reaches the host does not change.
>
> Preparation for removing ->try_steal() from pipe buffers.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  drivers/char/virtio_console.c | 39 +++++++++++++----------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
