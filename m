Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999515FA81
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771364; cv=fail; b=WwW6OO51pBfRBkBgqiJ0uIQTZB2GSyiyItJF2ygzv48iYUU+TMmecsTbbDcfm09jOqIuI2w5DlmBGINjYOr3p/uJO2ByJayaKd95jI4AuoVbp2TuQVxUWhcOZ4W4Cob6dF1b321jXOujxSNE37NH34x2NOg2/jEGIcyIPrkUAU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771364; c=relaxed/simple;
	bh=Ss36bFUeyYK3KWjT4uJqDRS8JvxlFk7kgwlrbblBVoo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2s4wzDEpsXqlrc0d3uMHyZJBP+aILFnJJtwrQjonBV6unG9bphFKFQbZoFYikzka+EQvdCnXjE0wpcCNea31I8boTUXUXjKMPe7z7mT/uBnpNCwKkK3/JNsSNt1xOYuHOYQ2rgP50IbY6cSLeKqH4CuagnMPav5+d/ZJkiWWn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnS8lHRS; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnS8lHRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qioH0inlNTA9HJgY03okqw0o4DS/8aTmEODdUY6GFlE8wP+qSsSAR4bg19+beDHsCdEdI5SjcbUlMM7YV2EPfu3BiqgWnCv8Moz2ZYFviT+zxH8nIWjTPGlwdYvTUKkOzHEmkbbgeJVAvoRzR3zgQKyr52qlFbTPc4Mw0PkdoOcSshvxpN/7fpQutC2vvAERBAodysbQRs9MlCC5iVKDCnEqTjg9vi26uFMDgGzlqqS+50tNbYJ6loDf4eAwUozAJJI2iDK9ItQeklhuRRZ7wj/8Px0Z5Bf3sMwHCnr7yZwfLMn7A/a5upCq4sa+4J0KPFttELtAjRXYihotG+7lmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNAkq2TyL7jmkM/2KX+uUN4936cH2J0tYk49ZxeIrCY=;
 b=ervwIoFoUoM6m98TQkIl38OyR1m4SAAnjAU+fjRSZlmYtP2oPJ8Iz79oTf4ryxTpqcsmdLkJFJnvNTMEOTKqq7r+dpza+ArN+mVHqXbFRy+u0p1katbTZxO1upk0nqE6K5FZFG2qrJeqSwl2FPCryHz3Sj21prd+XzdhqZs1qXi2bumd/Z4ht8N4KUnKXPxgApQ7mTnqkvw6wXkmofQQbHIGtAXW4IJQ9P5R9qSOoW31U56XnFJnuOvknFdUsn67+LAm+cx76cChCPPcoOZwHCj/c0u5F4RPd9QhAziluYBTZozheld4yKg6VVHMadxmuVwrXhR1OkaJz8zb57WiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNAkq2TyL7jmkM/2KX+uUN4936cH2J0tYk49ZxeIrCY=;
 b=EnS8lHRSRhkGpt3mM4axJTQy+0KOe67ytk7vd+C64L1cDZXCfQDU/YN/MX2pvAIGIxBNhlF+JWL5DjyoNZlLNYqZDg0msg4RAeRG5waBpKcp4ItIkq7GBzWmo1v2YbJGd9Vz4I62FbYkJM65roGomZvYCSmubi1Cshkp2R8qVj8RXc8hqGwxauuUuDSINylyGmcJN4fAj7N0hD6VZzE1gZpx0NqXzPjRq3i5yBaSbabJpwo0FdlcYF3jlXwRcTLbRQO89yrQI+DAF/gBxLsYTftVQ6At1jXZV2SF9ZETrHMScwfr/+dViYjeqCsa4Zrqps4vfQ/WU399vl6FUDWilQ==
Received: from CYZPR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:8a::27)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 08:55:56 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:930:8a:cafe::84) by CYZPR10CA0015.outlook.office365.com
 (2603:10b6:930:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:55:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:55:34 -0700
Received: from tuxedo (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:55:24 -0700
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Vladimir Oltean
	<olteanv@gmail.com>, Breno Leitao <leitao@debian.org>, Jiri Pirko
	<jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Petr Machata
	<petrm@nvidia.com>, Matthieu Baerts <matttbe@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>, Hangbin Liu
	<liuhangbin@kylinos.cn>
Subject: Re: [PATCH net] selftests/drivers/net: include lib/sh/*.sh
In-Reply-To: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
	(Hangbin Liu's message of "Mon, 07 Sep 2026 15:28:09 +0800")
References: <20260907-selftest_lib_defer-v1-1-8af94645aaa3@kylinos.cn>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 7 Sep 2026 10:55:19 +0200
Message-ID: <87qzj5xwy0.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf9bf81-a5c8-44c7-5d41-08df0cbdd416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|7416014|376014|36860700016|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7qkGPfZPlSTGcZOjmRyILpFZqM3eWMmM+hRTpElw3fCBaM/zWqA8nlw2W5YbH0vvtHBtg/UrYMAHqdtONgpX9tuzATU4UXEwTD2TPjgO8y7ELBKrqCqdv7aWAGQiaTv8scs77iHamWqrQMVG7aiBAf3DHUOOcXIuDLhNDgN9nQ6ZnthExJKleXgxce2xtYrdGLYsoQXHa/0Jna5uhWhgD4AMOb9a/5cm0a6Qjih4rSTCv6kAjVkwNSa0mZFxw59eH+eenPVAXZGxNmMLT4aHCxzsbxHOpQbjsov3IIzbh14UWlQbxPADVzyEoL7SZZkDhl6NrYX1VlhbInl/VspeqSa6glKxxRDyDmRrU4J/vbViRk0c9IKcEIfjEElyNA72+J9akFMq512rPky6lWcLBVPlJM2EauM109HBddS+PVpZvsky9dQZ1PIhWTT/wVgBIxVdC0R88RXI9Aj6UvVKmVmMiu/m65ldVipHmsXVuXR6GQt+RhWrZu6szoXHhsFAlHEwUvegUrsGIeVEv84c8Ie7OMpig7COl7W2tpE9s5o4fU2hySFYSJ4hp9YpcUrqNBccJfdVDnfN7wXkGlFC/0Qc2z6fkjpucF21+wAaQr+HI2pGQOfGKep0BcVYF9MBMhl85rNusCgNohYsJfsej9hrFFLiRH2AGxSg5j+lTcdF9FhSW/OJWffYA7eIR+BCAm/63XmSxCck0iB5FvuoSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(7416014)(376014)(36860700016)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E+FkIuI3qzWrA5yjSQOxsT0UA3KuD+HF/W3nQ98I62ZlknRy+fHxY/5MO5lwPbl8+kyRGu80CtmwWxEsRA7vuWRdtcrnqUfbKbVProvueFJbYlDywh0Tj/bc2Udz6W1jSFWFBOjVY5mfmijzwETPUy2whafCDyQhd164LHyqBHXGmqVkzfnX2JQHfVV6AXNqWyUyVjRPukvy8ueAPeln+khbImQHEqMvKiOSkY/bYScsekgG65HyqxYxCnafd2/V5Cg4wbb/cF7ZwC7Rh56IvvpPy60PYbXRCT2Hc2tUg6DsVPo4TrnAt3aMcUAhRxn8kI+mXq6t9YJmZ+COjRJxnHfnsnzgYKC13v2zWzWWW43VujwPoHiuCY3+QkXo7UGe9zbvU3oJTY6OTNu5ic6e96bpnx9/QaOwwPtmPNUNiLLtJkYJHYm8wq387VIE7mBI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:55:55.4706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf9bf81-a5c8-44c7-5d41-08df0cbdd416
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043

Hangbin Liu <hangbin.liu@linux.dev> writes:

> From: Hangbin Liu <liuhangbin@kylinos.cn>
>
> When I tried to install and run bonding selftests via:
>
>   make INSTALL_PATH=3D/tmp/kself TARGETS=3Ddrivers/net/bonding \
>      -C tools/testing/selftests install
>
> Some tests fail because net/lib/sh/defer.sh is missing:
>
>   /tmp/kself/net/forwarding/../lib.sh: line 5: /tmp/kself/net/lib/sh/defe=
r.sh: No such file or directory
>
> One option is to add defer.sh directly to TEST_INCLUDES. Alternatively,
> follow the approach from commit f72aa1b27628 ("selftests: net: include
> lib/sh/*.sh with lib.sh"), which pulls in all .sh files to accommodate
> future changes to the library directory.
>
> This patch adds a wildcard to include all shell files for drivers/net
> tests that consume net lib.sh. TEST_INCLUDES is also sorted to avoid
> ordering=E2=80=91related problems for future modifications. The team driv=
er is
> not affected by this bug, but we use the wildcard for it as well, rather
> than listing only defer.sh.
>
> Fixes: a6e263f125cd ("selftests: net: lib: Introduce deferred commands")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

Reviewed-by: Petr Machata <petrm@nvidia.com>
