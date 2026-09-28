Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA04E0205
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616986; cv=fail; b=dUN8bG/1V/vm4rLFrhY5RKFiBA9PKK3p+561RHkH1FWB/p0HG5NTWOe/jkjI46E89LkBPKSylBeuc5WAEbXhWnHTbsRM4DoCNABysMfz9JFxH99VwcpALFVvnFcTldChNsbHea3pasWI3XxB67R58/jLHSUR9Qm3WA/4eVgy3bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616986; c=relaxed/simple;
	bh=o/1vZdT1U8otEGZGh0K1QBEq+7nQPuL04qFp++288As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mECnqIjqMXs2HOZWKfWo+aI+AOdc8ir4MpttSJIkcMPtUv0H7bULL+aWw76f3BCKHfTE0wJPACX4zvCKdBlXLdLv8QiLmg1aCz4yLWqkEFQNXXVFGvCYbWWzbt4fJ0zdAc0h0S6PB1et0NelP0rgVMn08bDDMY5Qti5uLQvR2KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nZ633dHh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OtsB7jSY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nZ633dHh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OtsB7jSY"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SDjDOv1697704;
	Mon, 28 Sep 2026 17:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i9omekjZhhpUh4LXdX
	NJO94apAXAXRcqbQndDCB9Vsg=; b=nZ633dHh/dBxrliveUxTdY/6a/BftnL9yl
	6FthkhDkwsp5qGCun+2CRNGjDGj9q4KdG7VznbVolzdML9gPXJjyh7b/bblfM5yq
	mcaqtASbMU0i2audVAe/G+oi7NeQ/HUkUO5NgS5iEyn+LE+ejcp/G6PsVsHdQ3Bh
	0DikQ2m3iqJaJVz8CPERmb84BUSHCjTCgzpmjOo+az0gq/mOZcejojQTWtN02exN
	YNYmA7IH3xy3J3MjTTEdqKomxaHLis+PQYZ0q7cXgw+BAvOBcBx/Jerbwnsc8Nak
	onoH47IggZ6dROitBk/IGXr/bUlGy7ifqfMPTjA6+1LpmXH6N/VQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbb9k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 17:35:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68SHZP2w020767;
	Mon, 28 Sep 2026 17:35:33 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gnnmjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 17:35:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnTFA18zeyGOs3h6Fyecpv7qmQeWVA33b2OrkjfigzxqmegS5Vz6Mkm8W9RtD+iEBPZt6o4b9T1P8WDbaerAIGXOh+4DxLxHSl7smYUDlBoZ9dKX1z9jER561GdsHBbxDzu6yrG+7jOObvpAX6ClhfnY1APVt1HQkXvBs8pMUQaS6X/UxNyhAhYWZCj3ZUdTDzfdegjOxS716bKN2nTUdSLlIL2u4pKtao9qFE1PXPQstMB47LK+aE+KpY+asLEoEnxZYx5nQico3qDberUUf/w//SvejYJ8P4m0ATtCw+jRlqlKZAkbPT1PuRS3LLhst7V5RGLSt4Vqi+gkaTBjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9omekjZhhpUh4LXdXNJO94apAXAXRcqbQndDCB9Vsg=;
 b=PJCf283Dx2uc0SANZ9e6AW81Grkosl674D8ZlZFrgwEuxetH56gzE5NFyri76xiZA8EjUMWrlQbBYzkt+KFtaOvnra0hHdzlughJsNlLYwtTgX7yA9PKaFN/W28rPnORmKiyQgGpPxB0PDGhLNKMeLQrl031xryyIhwSiua+8Ar8Sh7TtrXhjlNuRj+nO+y4Cr/qRFTgyALoGFC6un5QSWzLHNUcNcoTZuwl7J5IwIlKteFioF0uGXGYAh09rwFRP7NhKYtBOHENiP3sv9PmmXgS1tF13gZW+yrkKFCf0pIvsz4QK54bieUtUgR/mlY/4QLR+ax5IthEwtgztg1xyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9omekjZhhpUh4LXdXNJO94apAXAXRcqbQndDCB9Vsg=;
 b=OtsB7jSY9ttGLuM+ko0ptCCvjp5mIGgJ58lgyEQVjHqh4WPgZbLkjyd+lExltXW3bzIAP8x9zI4KLKVqs2hY6jPKf+qkMlti7tjR4ZESfvjaj40XsZRRhN7TEkZwaxk4gJaK1R5e3TV7L5wWc661Ot6OQM17CsIgvb1PxPp12eo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by SA6PR10MB8110.namprd10.prod.outlook.com (2603:10b6:806:43a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Mon, 28 Sep
 2026 17:35:12 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 17:35:12 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Zack Rusin
 <zack.rusin@broadcom.com>, Petr Mladek <pmladek@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
        Joel
 Granados <joel.granados@kernel.org>,
        Baoquan He <baoquan.he@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave
 Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky
 <senozhatsky@chromium.org>,
        Kees Cook <kees@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pasha
 Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav
 <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jonathan Corbet
 <corbet@lwn.net>,
        Bo Gan <bo.gan@broadcom.com>,
        Brennan Lamoreaux
 <brennan.lamoreaux@broadcom.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump
 by default
In-Reply-To: <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
Date: Mon, 28 Sep 2026 10:35:10 -0700
Message-ID: <87v77p9t4h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::19) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|SA6PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dce637-515e-47fc-e0f6-08df1d86d952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|3023799007|5023799004|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B3olBA8TRwtgF3Vlyb5jzL2e3iqOc/HPhvlpeZEyCZCFzIc/hZKnK3qBeFDP/X4/ffWpR7QGtLIbiKpqHuZ/kXKN3xPCy7dunvJgk4WDz0gdJHSmzTh7vxSOXhAtTnvCgivvOpUKeAQNHrpFR/L+t418RUFaFJpcFqY91ozIqve7yYeCi298IF9/n2XIUcj/usf/OXXXGocsn3qBDJaGKK6zJA86435lOVdUVeBAck6ykLJyLL4pDq64nZxj+I0D/dCkZMKqFvZEhljtoJ28/dLQlJh6vKWQbH05mDVRYq7oxtR2WHzl11Uz1Hi/fW37tBLXqffE9feS330/lITjV1PwcREc/qNKdswfnTKBt8yvOW2ySJDUlSl7AQOwPlj9rIVtPr9OfJax7URWmlzxyVG/cMB9p/mE+ZqRpcBPx4uZgZ6UtWvPn5tSJjZd/agOSjIKwySCSRCVUg2/gYVFMlz6l56o7oxdlxza4LQp4kqlGdryJMnR53nogbHpiVqf9Dk2YNiok/dajbZD6jaHCAfRhJWYZoRaxU4GdrBBPRIPYh6ISvKMjv2og0L5C2tN98BzE1k8cKBS3ANutvs6XNnXFMU9px7ZBrXXPqyOcK9pbWuRVTzo7ERLCZc1zqEi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(3023799007)(5023799004)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksmSogI4vfu0S4b3Ng/px1VgmEliJx59/kuceQ6q5eh+UFRuHQY+tYz//oWr?=
 =?us-ascii?Q?nnNHnG+92BwZ4d1MKdWaivp5k6MNBEwVNKPULdHo36b1mty6rz6/ZsaTdweu?=
 =?us-ascii?Q?o/VmoD5hlhnyToCPakVE8n9FoomWZMKbN07I4dQpXT6knJ7oolbGg7ydZEqI?=
 =?us-ascii?Q?24OlfChsZRqWnMfIM7HCiT4IDgmAClNK9ss6wVjVcAdN4nJP8M3swB8YmQDw?=
 =?us-ascii?Q?HuAi7iItwxPKN0161j0sugSJxZ0tXLslidUOEMOmlXWE35NIiBhHc7n+Sbt+?=
 =?us-ascii?Q?uQDJGkYGUiioXPA8IMeDDC3eTgWVMKAbdM40Aw9rvNTHYVgn2RUQg1VqeBnL?=
 =?us-ascii?Q?SigK3N1sAw6BEQN2PtzB+SeqafMa5BDUWXzwplPDKTh0UPu5o7dFhE1hvUS5?=
 =?us-ascii?Q?tB3XfHTVAxmd4HsdOI17TcopIryEJRU1GC0/hMD2d9HkFd4PWAKvUM/y8jOU?=
 =?us-ascii?Q?5/w1XKUb5F1lzq/KNBEvfHuCNDmkEl2OzfBvMrpLoxf0r7aHOMcNFGFVHtlw?=
 =?us-ascii?Q?TG0CZmCiiCOW1cB72aChv2js5rnR1rjktXcgW8mAmDfqWuRWcMFEiSvwMUSI?=
 =?us-ascii?Q?hv1pXqYAVPU5HKupXme36AaqTnzuHepz8E78VX3cpRpkX7FHkurVRWWxB2rr?=
 =?us-ascii?Q?gwvRXx3U2R84yb5MOGtdOS8vnILejXY3RlS3QK5FQ9OVfyhteNOFeMAdm0fX?=
 =?us-ascii?Q?Vt2gcfRy24c7wHn1uQTt0oOrEDDaXPnCxS1tNeVQnFdiID2Pbnr2PMCHJj4i?=
 =?us-ascii?Q?VNxLfBVzUKx6y+IglzM+Ck+/x3Udj9nhHeFgqkzZuDPgquQSmxz8F/9Nr0CN?=
 =?us-ascii?Q?GWY6WFRMXNouIsdNNh9p1t3Sb43lRmmB5Lqys1x23UXPs70Hq0ttdxF7PoqP?=
 =?us-ascii?Q?OAHuB1SjLq8/r8EX1CiRsGlSFrE4d1LLbhvPK4DOdwmcsG0GKV0fVIha9jCL?=
 =?us-ascii?Q?PsYdQmprTr+7bT7yzDkjx1e8BCe/zJZn2xNa33k80dT4E6BCdemANWoF7ZHK?=
 =?us-ascii?Q?2l84xK1aZgT7hB/ts0p26BVFlRXBeNC/ZyqrPjo+7iHrrXxHCkbX5ZNDBbMo?=
 =?us-ascii?Q?1PLe60k+fhoMPeFoMiH3EmNHWu/GuF4c4il9+XkQ3djkXEgFrGzkg4U8Bqar?=
 =?us-ascii?Q?fmTelI2K8g1ErnFFX9XmFtJFwrBqZStI3ay3mLWiuswQG18gBEeTejuZjkaY?=
 =?us-ascii?Q?WfmXpPZS5G7TIF0gvssqhlIdZe1KkEqajdFJLJ9ut2S0Q+Tekh0jrzxZPKkA?=
 =?us-ascii?Q?zCYShMAwkJspAfMyTnDw+fbs27VZmmxlNvB5zit+gFErOBtf2hopoE++j9S7?=
 =?us-ascii?Q?kgEeU9eS1cS26yOY9Gsq/PGN5joJvhQZoE5C1amdHPlpcIUyxMDnUtU7neak?=
 =?us-ascii?Q?yKOaljY3o3Sci2WFSCnMDySg3PUFAU4D9BUvdhe6Hy10QvRejzHTetD6YBad?=
 =?us-ascii?Q?ZSG8D3YOWT7X4Axm1dx9Jt2Ngz2AITlUYl2SwWra10jaQLvoe/VcQuNCdj3f?=
 =?us-ascii?Q?URHQlMMA99LKXukXEazI3/A8eHhrT8HHezlQ4FIG3ndm0njHOUXOG/OgkEzw?=
 =?us-ascii?Q?+yNpi5DpLJj5MvL2g0NlE8HqCj4VhgptP7awlUlJIVqrdIh4umPRsOlf6zjm?=
 =?us-ascii?Q?MLZ09Xv4tL7/1X89991bFqhQ3hyqhTGezoAzAlO13xuXh80PQNsG6ZzNqSaY?=
 =?us-ascii?Q?+77VYgjWCZ+rM4BEBLf/AlqYfh+2ruEO5+gDmwmkzcHWyBJYlDuZ1J5gOCoz?=
 =?us-ascii?Q?c04o/QTLujsUSZ2AhndzRjP443zNDqQ=3D?=
X-Exchange-RoutingPolicyChecked:
	1KMp/lszp0dxzN9EC3rkKHMdEkWEzOT2motmpszN1LWuvIxGMV5HHm9zW00dtLsrd8unJauQlcpFoACKK40qYxlcTEI6LwQCadvnell0mP7o3gr58HxVf5SyUnLtVCMYcaBomt7alGrRxKFN9g0wk3nxxSBbTMnbWq+nrDk0DrLB1XA4rv9LFFpRWar8STmsGVPng2glqzPuyRPAFXY1Ax3sABopWijSC922+3HeWTmn36jMqXmRFtuv2s+/IfaZH4m3SEiIcnu4Y+VF6C33GR28484rX3FiPtBEtuamQSGdkB6cByfoxpuHrYNAHq+d3sCfWLPlS8hS+1obk2+Iow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0oFchRzugVEEiH8Nk56IwyHX+sjGXwOen2HAWn3b78LXogZdLJmyvBoATNgZh5NSOSeHz76x66lIFvqvmpK7Z6nDpWR68bOp6/XXZJzdxkd9bCNDzH4ayyU9gNnSipvIHRZ/tnO5Di1SQeGmemvs5KFZMl5wrR2HnULDO3dwUQQdvTDFi5Eh7SwgCf8FE8cZK6rf4wi4lBUKl/zVuN20c1CvBvULxW6DWP7Ldye7Yk1tGU6Xr33DRKTgsYlyq7A+Vs5cBBFHsfqPRYFAO3pZeG8R5xHQHXc8Zzuj+4zbLM+XczNxh3z0PWDu5LOE6YG3sJnH/rsvHP5yXZr6ueWbEv58lrr1yByKuEbE8kuo2RPV2xdsg+15qJ8EAxyR5LZkxc1Y+eXv8FT/uR0jeskgrXdTfAyXB+72b///YC5XWkXSY1DjP8fykMT59G4bNQVdH/Xo2ytaqgScypK2F9Ut1Qn5uftdakSr0eiGneYLKhzb8ksa4/yvKrbweOjm4mWPQtwD0qfw8Ewm49xD63NZMrw/biqIo3l2K2CFLVtrWqmbABc58cCx6T/kBIdzshnHU8NU4YeO50/unwkaDfX+tyBHgBLyTcR1HdFWtzAZ4w4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dce637-515e-47fc-e0f6-08df1d86d952
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:35:12.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoe3wEWIGpMU0+bhnl+FJeq33aJImhRkic2o0G2pg+w8vwESPb1wtwYwJSz68S1l6hmkaA93SZj532KWpBMfndy41RTe10WZVdVZMuzcVzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609280070
X-Proofpoint-ORIG-GUID: oBbErQBpdpnrZk4_-YqBYx68SWBSdGsD
X-Proofpoint-GUID: oBbErQBpdpnrZk4_-YqBYx68SWBSdGsD
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abaa566 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=V2sgnzSHAAAA:8
 a=6nbXSBVuLc2JSsRFcy0A:9 a=O8hF6Hzn-FEA:10 a=Z31ocT7rh6aUJxSkT1EX:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2OSBTYWx0ZWRfXx40wZedUOVkd
 lUT3tWsYRRiQjqD8Sd6tLF8VVaEfJ81WQxxu3PGlISDWL35Cgs2bIgvD1Bv59iVF1Qaw7Oqo6Fu
 u7s+g20ivSG5X6GuMEGuDGFqtf6i9jzAVAtYVM29FaX/Avl4w1hV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2OSBTYWx0ZWRfX1D9bfZP2iKqh
 1RHrRFbxKbDOaMUAHQKPrH7/iOWu1L0vzHWYnPzDvVzCz8SnCHzQQh6ptIKqcnXlQwPHXeBzww2
 4vgpjR+CJfSBLlBuqmqNMX1LtbnH17dsl0BXkx8eImgCkYEYpbuTtcWZarzaln6yNUvBQn5noQ2
 oZvXH1P+UOY6uFLvHKqodNnR8YFA7i2VejOQEXzRhXBbzgnIr0nzYyB4mIKOFW/3+LL6UClADgL
 5HjRwOtNZH0NA15FAy+taSwhzuw6oFf3B0LiNiN0J92ChndVdEEmseAMTjio/TfI6qEDuusg3Mf
 1SjTv9zAV0J7NYq6g5LsD+6gIeIwj14TXfy1b7Dp5ZUjS2qlUGgxOvwEREi33NYRmIzXqmq1a9i
 fODkM6rkqf7yo8JsmxlLINAvAWjNH/qaJ+QNwdBL+SX9V58ApqK7yWVAt8Cibx56BdvVDQ+WD7t
 eWK9bVy2sPTucbJw+v1ijxGZNG/Iyqie04MHMhDg=

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> This Message Is From an External Sender 
> This message came from outside your organization. 
> Report Suspicious 
>  
> Hi Petr, Zack - thanks for CCing me!
> Some comments below:
>
>
> On 18/09/2026 00:23, Zack Rusin wrote:
>>> [...]
>>> Maybe, we should start with something simple, and introduce
>>> one more panic notifier as a start. It might be called either:
>>>
>>>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
>>>     seems to be primary set on hypervisors.
>>>
>>> But I would rather make it more generic and call it
>>>
>>>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
>>>     more notifiers which are either 100% safe and useful or are worth
>>>     the risk before calling crash dump.
>>>
>>> We could put there x86/vmware notifiers as a start. And we could later
>>> move there other important notifiers.
>>>
>>> How does that sound, please?
>> 
>
> It's a good idea, IMO. We could start with this, Zach commented some
> implementation details below...and after it gets merged, we could move
> other hypervisors that currently set "crash_kexec_post_notifiers" to
> this list and eventually, unexport this symbol. We should avoid having
> code forcing this parameter, as Petr said, many notifiers are executed
> if that is set.
>
> (I'm CCing Stephen Brennan here, I recall he had problems with this
> being auto-set, we talked about that in the panic notifiers big
> discussions in the past heh)

Hi Guilherme, thanks for CCing me! You're right, I'm interested too :D
Your email arrived on the first day of my vacation, so I'm sorry for the
delayed response.

I like the above idea, starting simple with a second list for the
notifiers which are straightforward and have an urgent need to run.

My previous complaints were with code overriding
crash_kexec_post_notifiers, because that really interferes with your
mental model when debugging panic/kdump issues. Having two notifier
lists is a reasonable mental model, or at least more understandable than
silently and unconditionally modifying crash_kexec_post_notifiers.

I like the name "panic_pre_kdump" for my own tastes, though n==1 on
that.

I do think we're going to have trouble articulating exactly what are the
criteria for a "pre_kdump" notifier vs a "panic" notifier? Anyone
submitting a patch believes their notifier is important, so of course
they believe it belongs on the pre_kdump list! How will we draw the line
in the future?

- Is it safety? As in "the notifier doesn't take any locks"? I feel
  this should be part of the criteria. (Though I have never been
  successful in predicting what code would cause a kdump/panic failure)
- Is it urgency? As in "without this, the expected behavior of the
  system during a panic will not occur".
- Is it the fact that the notifier is communicating with the hypervisor?

From my perspective: informing the hypervisor of a panic is both safe
and urgent. If the hypervisor is configured to immediately halt and do
its own panic handling, great.

Providing the last 4KB of logs seems less safe and less urgent (though
obviously still immensely helpful). The kernel provides a huge variety
of consoles through which the hypervisor could have already received
these logs. If the system is configured not to use them... it seems the
tradeoff to not be debuggable has already been made :P
To me, that logic belongs in a standard panic notifier.

Plenty of people will likely disagree with me on that, but that's why it
would be helpful to have clarity on what separates pre_kdump from
standard panic notifiers.

> The only thing I'd like to suggest: I think we should have a parameter
> that disables running this list, which would be the opposite of
> "crash_kexec_post_notifiers".
>
> I would implement it as something like: "postpone_pre_kexec_notifiers"
> or something like that. The parameter would basically "move" this list
> execution to the same time as the current notifiers, gating them to
> "crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
> failures maybe related to the "early" notifiers. WDYT?

Agreed for precisely the reason I said above: it's difficult to predict
which notifier is going to cause a problem. Having an escape hatch to
change this behavior without rebuilding a production kernel is critical,
IMO.

Thanks,
Stephen

>
>> [...]
>> I think that without that default though, x86 oops_end() can enter
>> crash_kexec(regs) before reaching panic(), for example with
>> panic_on_oops=1. To cover that path too, I'd call the chain from
>> __crash_kexec() after the image check and register capture, under the
>> existing kexec lock. A second call in vpanic(), immediately before
>> kmsg_dump_desc(), would cover the fallback path. And I think a
>> set-once guard would prevent duplicate or recursive dispatch.
>> 
>
> Regarding this, 2 things:
>
> a) I think you could change kexec_should_crash() to "return 0" also in
> case the new list is set to run, the same is done currently for
> "crash_kexec_post_notifiers". Makes sense?
>
> b) Well, does this whole panic diag thing you're implementing here aims
> only at x86 guests ? Or would it be possible to run, for example, arm64
> guests? Asking this because in x86 and some other architectures (but not
> arm64[0]), it's possible to override machine_crash_shutdown() handler,
> and run things prior to a kexec. Take a look on how Hyper-V does that on
> arch/x86 - this could be just what you need, except if you plan to have
> it for all architectures heh
>
> Finally, if possible please keep me looped in the following patches, I'm
> very interested on that =)
> Cheers,
>
>
> Guilherme
>
>
> [0]
> https://lore.kernel.org/r/427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com/
