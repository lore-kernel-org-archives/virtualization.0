Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794327923;
	b=MeZtoD6APlTdyvexkOBR088n370BYrzohO0JbW41+GbPHx74xC1rEOilxsfvLqn6lhkm
	 Zt36VTRxcpg73dzBb5VF3EVImgPJk3x3tBLSOqQjYqORM2leYlZB01b1iGlRjpP7DvI+d
	 EBD9b0OHh/xjGVgzlmz6weMRWKavarx2JbpFy5yAGZDjn4eeonSQW1zU2UImC+il9vPKZ
	 jaeEzufah1idoYnUKg3jNvvitDliEm8Qp8NLCJLdhxYFG+Yw9dtSErBDX/yvEj1EoNldB
	 M1E3uP87arO0LD25C5xXc/KrXeqSp7slqNzFH6uEHHa/Sspk3qcA+w4vnirLS0sXA9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327923;
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
	bh=xVQ1Gad4wlBLHpJLvsZR8WLtZuc4RJ1B9UQYRoHfJAU=;
	b=Z+pdIVoQHg1Hy0WXkhSSgZ58yJ9bIoTgvH+EqeJZX80QXXcJ4uONWPMOAjXpC1okec0u
	 S7NWNbYiyKjIHrHHqjuASQgNqn9yd6BQoxwK9nkdkSw/ch2oiGhGfqvaqlo7VdtAxX4i6
	 74fgh2sGnK8OThz7W2ELaStuq6k9FcyQN6aEv43MfVMv2lSY1+VB3yrBWjtyFf7NRItdB
	 76pD3gEuzwOf2KhinGPMChFUKrTrxsWuWBLthmJ16OH1y2++6pYhluWaY+5ZUIQrg7Rb2
	 O8plca89Ji5PY8zpFd/K6woYNpORUjUSMBYeChV6esbeyyGtsA6LvKWWAt99OYFTnwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aPF037iZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.50
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9660A2601;
	Tue, 10 Nov 2026 16:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F9660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aPF037iZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0s5h6IXB7Bv/3+tU1/t17p8hZBu/lsYf4AIP0WqX2ip+XdqG9yDRq7PFIJjWBdOZTlc7BjjJ4BJ75s35QFHcaH5OkBQaCkd+3kPgw4OOK0rxnwtLcdaFfvB+3KAIhgwbuze+r9XUTJ2C4tP1v9NbpzfohxvnSrUpQFwfysZAfA+/RdLxwsBNiKIzYDaIoHj5zH+R/fL4Ly52IbOb4WZ58nl+uNHprAjryG96oKHfW4lQZ/VeGkBzq+hlZiWDk1qr807WFu5aOK1THOpUKJ4gkBGfn0RDRhRbOseXYbK/LWAszWQazEJEQzgCWzb2EyD6r6qc+pSl4lNTKEm8D6o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQ1Gad4wlBLHpJLvsZR8WLtZuc4RJ1B9UQYRoHfJAU=;
 b=eG6CPPFc03BYtPOGLbuv4B51q7nNhhIwOa18ACKnSqhxWij5gkLQt7+kuhoPhkYG5+L3IrVAmFK+lJ5Lu/RZrxRN5b+/GPVIvmc42CRX78HzJGbEKpYewU8Cn1D7PSB0oi2hoiZyIjDH/ev5xHyR5JJbqga8YQEwvzbZO+s33GozVqmaeGVhW3VRqorXgSbxPiaB2MCOF2gOsooiMx5VnAhhiwFk/8EOMB5fZt4v8OyQ36RzTMn4uBtJYrKRiTk5YfagHAcSoTf3u0XszAM54OVU6poXs6uN2IluHNuKqbD6zeCrOJnFkeEV9ce8hsMCcXFvpcc+xmQcAklbBiYMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQ1Gad4wlBLHpJLvsZR8WLtZuc4RJ1B9UQYRoHfJAU=;
 b=aPF037iZgw11r4OYxU+Yjc5IvwEDLIFPYJ0qmaymBA+Do/IqC2LCMkxQ8DgRRpqIg5nb171ypW2RAOmMZtrRNtqwowyWvEMexQue4eUJJwu66HMyir04Cnos/R6ZmTVc2ZGg4E/uYHTjrpOOUmrYhEktOTS3ZiDH49PK+T8SgefsItKiLelr2yZY1UFq/UTZfD3d8YHpVT+G2WhvFA5eFx2Htl/uA80eQUrjjRTwzKelfH+OiDluPuKVwl8h6k6FRbbI2VF2yLToAQejXaLNSRpa0UZXbtcbOkjWkYnmNBn5U2NjOBWnfoti0/U53DAUXePnC3wxE7IUT3hx5gDw4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 16:25:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 16:25:16 +0000
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
Subject: Re: [PATCH 2/4] fuse: don't move pipe buffers into the page cache
Date: Tue, 10 Nov 2026 11:25:14 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <E2659C58-E0CE-4078-B959-D3F61C042AD3@nvidia.com>
In-Reply-To: <20261110145241.536019-3-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-3-kas@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: MN0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:530::19) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 49400587-862d-4c08-5d9c-08df3f473439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|261026140227099003|11063799006|4143699003|261028144727099003|56012099006|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	W8jYALF9ssjT0fsNS0CZBUJ2glyIS6t1HyIO1llcVWYQeWoUCqODyJyGE34rYjBnFLt5RT0x0RP1wFLx0PWUwUr1REVs6diz9SbhJ/E5+UGgVpWjyeIpSJ9HbmJraO+nMnLNSGYIAFsrb89Jka4X1s41W22ZqjE1A5EshvxJPRoihglqLXkF4LihjLgEI+uLKoy7/setGr6oUiNyTBw30Sys2xyNiS/Nuh9RthO4UDfyBvNWvLGFp3FHR25I3Q/KMCA+AgEfkMVnPlvgzyu9kZfj5HbzVkUsg+J5E5xC/6Fa3zN0K1M5BeD7kfF2tw3ia8Y21xfY1lA/KrHMdsg9FZnTacDw8ielEzPMIj7o3PmTVxgkdMZCY9bhzS6DsnGMoAprgL5fhvEdaMQNRQDQiNBEA2LAX8mz5BThBFMdUfKlHh1o2SMgcSbKPtQQ1PHQyx9z5jGBPOclsK52fvW2/DNWYloXOolNhsGBIVykq2J7lcx/Tnpy8RkFkiAezbfE4X/+9iD0Bw7ixZUpGm5NVQ9yByByc30uriRWcCepbj8PUNMMCLncKUHxmyWo8H/4g7V91se2WsKPHHrHk6cWDyoBu/LDJCqCcYUnuAXiVBX9vbiSl0f59EJwQlt2PwEU+XfBDHcGhYXLaumQEzRlF2002TDoFOlFPdLY2q2iA9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(261026140227099003)(11063799006)(4143699003)(261028144727099003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026121527099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFtCxfcRNL3ntni4crmxqyWedXy+I39g5w3t2/tEctBCFrhqWUCokcFM7X6H?=
 =?us-ascii?Q?UDtyF7i5LTDK6ZQRcL0zV6Znh3l1HwQrB85BK6sG8JuKeJb+vCpzv6s+9qgc?=
 =?us-ascii?Q?xBDJaHVKFszejptUPmSo9XiiFEjC8s+cjB3soviJYVqZHtjyxuKv9nK8niUC?=
 =?us-ascii?Q?UQJ8Xpm7z/yY5h08c9p9JwIUs9lyLQYXlNlioEEop9GTcUZZywgalrU5CM93?=
 =?us-ascii?Q?SpGrx4IP/8s7QbOZx/4ov534h90p+Cy5yp2RDF3JfgFO1pth1kMsRKt/Jdys?=
 =?us-ascii?Q?g0Ccf32lNA4sXP88BoyLyWWqQWpRcNEIOgzwZ7tof272M/QehgeJkrGRrg1f?=
 =?us-ascii?Q?hQn1OW10W5ug20yzQkRSVxmc8GeaBw+TwRtyHZEKsjPoyjOYx+NV+RaDfo7G?=
 =?us-ascii?Q?idKs/C2eSSXuQtjUtlb/PtDyR/Shwb955ui4RuUUEeH4fhg05B7o4ILesMmt?=
 =?us-ascii?Q?5LKZHmNQ4Lf4xhncNHXt3x6xyaDQmpSYklUvgaeBC2K2MUIHvWj9rKOZGjkr?=
 =?us-ascii?Q?mIKO+7M5vYzNILFiHUpcF1XB1mM286P5NMuQiprP7xCtCIDGULEO2IH2yPlZ?=
 =?us-ascii?Q?/lHJiHjNhVKVtlgpPZ+BsF8WGecFuoCCiRtda7z+zXxCcQkNctXZZnUL5qeE?=
 =?us-ascii?Q?KDKQfRmcFdTH3cy+3tLNkg7ddOcguXK9H9qfDa7BNVyqUDRs5+AVurMU0Cy1?=
 =?us-ascii?Q?S2mYwehcGRrIaaBcWo8yMBJIRsU1wbmaT3Yedp3hc8bqBUohBM0OrPgWdT4K?=
 =?us-ascii?Q?/oSNjqmNS/pflqY/P6Yt8NGMi4qo8Wh3KCPLcsi7g78XTu4lgxMW/b5vx6qZ?=
 =?us-ascii?Q?ap4L3zS01uzfCbt/IzYF0D83kLt7DX1C/02dx1VmBJ26P/MJcUlOGsQVXpa+?=
 =?us-ascii?Q?bgoyGRswnXK8saJ0S9lI0nrwITAINjEgiFuhzE5owXo6tWnWzd//GImH4BBs?=
 =?us-ascii?Q?HiyhOfBm7VZuSC9bOTCMKczA3vHnDYzDeEK+9CiIVwVTf/3AJDBhrx/ovwJ8?=
 =?us-ascii?Q?P5n3dMabyX1sg+kceJ11XGSZfcw+voTh1FpFGXtBdLfj7+f8rUyrc8nlID3d?=
 =?us-ascii?Q?lDIu2LBSKPvUzFz6QjLOrxxh6hOM+o/aOKR4n928FJ0/7tv+t/tPogrI3w2Y?=
 =?us-ascii?Q?lvIFK5RPVuwDHIUBtKOhmMuggoI/H0dbkYhdzMl37MZJTAsQfeh0vg1fQQcb?=
 =?us-ascii?Q?Yts5VbUBy4L26h3oOuHFcBcXxOtU2qPHKKMwAhCl3V+Z0QNGNCQlMKLqt19N?=
 =?us-ascii?Q?2+VIJid0QBualFqg5p1uspYVh9OLRW7hfF290pBpXx3kyVbdg+BlFF1UjXyI?=
 =?us-ascii?Q?id0V55gozLmJBCp0xOWD/nTeeI4br5oc0Qthri5J/xmvrOx0jdihRbD/9HHH?=
 =?us-ascii?Q?BW4MT0CleugMremID87dXyU1UjYCoXRT+JQEVD0qVhD92c2Hyzp5omicclfB?=
 =?us-ascii?Q?KEsPzv1i2jzLo1Id4g65JKFcXUtMCVVJdlt4RczB9M/nktxytkKs63ajdhw5?=
 =?us-ascii?Q?bDtnSzX0OpJQkq7BHdodKEOyXTwsG7amIdwsiUo8LguytD7tdrLQQEsZ1z3Y?=
 =?us-ascii?Q?hs9srQp6044ZeyoZ0+Kwe/OFdgYLlIhA9/IvPHaFfg5BM7Me/ZO9haApnreM?=
 =?us-ascii?Q?JTlMYQiaj5W40GX/nTDezT0oZeieW3euVTy1UBG9AHQoe5s24pJItQ/oF4gm?=
 =?us-ascii?Q?+62JS5JSV7sSgjLEKeOAaZD9Tp0KCqdoMGbBqFwrBTbW4BzR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49400587-862d-4c08-5d9c-08df3f473439
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:25:16.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr5Yvu7Kb0f77kzVIez6qS/+Ii0p5BP8RyCsATwfi5hLqNOyFdbxovJcstW5EhEi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On 10 Nov 2026, at 9:52, Kiryl Shutsemau (Meta) wrote:

> A splice() into /dev/fuse with SPLICE_F_MOVE lets the reply to a read
> request steal full pages from the pipe.  Each stolen page replaces, in
> the fuse file's page cache, the folio that the request allocated.  The
> page can be a page cache folio of another file, a page written into the
> pipe, or a gifted user page.
>
> Always copy.  The server sees the same data, and the move was a hint
> that splice() never promised to honour.
>
> Keep advertising FUSE_SPLICE_MOVE.  libfuse fails the mount of a
> filesystem that asks for a capability the kernel does not offer.
>
> Preparation for removing ->try_steal() from pipe buffers.
>
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  fs/fuse/args.h       |   1 -
>  fs/fuse/dev.c        | 144 +------------------------------------------
>  fs/fuse/file.c       |   1 -
>  fs/fuse/fuse_dev_i.h |   1 -
>  4 files changed, 3 insertions(+), 144 deletions(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
