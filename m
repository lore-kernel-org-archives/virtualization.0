Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB541A00E7
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738999; cv=fail; b=Xnd6iAcSYQxi1/babeV49cKw9ntkujzkAmF+KvWJ57N92QuiqOVvmK5tBS63gOtOyqwtG/S3w+XkMTD81XkizfEc4UqPOPHUAEexgF7mARtVTg+ybVwRNoQA1MjlKTTTcAzcv2erFKuC/MrJ2piEw9MDnGM8zIEYKPEA/9ROXDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738999; c=relaxed/simple;
	bh=KhdJT6G6cuPSNO6V3YNucSCgvyCeaik8Xnt3mqxFbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h28lJGhzvYC+f1uNdbzeUnogu7uaB3YvwOqC6cTI9ilAqNAI7KvFIJVFPVLQV03cqwYLNn2v9JG42+x57DfsHUkvjgJU7fsskzpZmq3sEArAu/E49wWeIFI135mJzMH/gVAdSU2kcPxg++bDEDQjlXIeo1WpjRXxXk3Hfh7o68I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BLYwrL8a; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BLYwrL8a"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65AD96084B
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lwoOQPxYIUIi for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Jul 2024 23:03:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2e13::801; helo=eur05-vi1-obe.outbound.protection.outlook.com; envelope-from=luigi.leonardi@outlook.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3914D608A1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=outlook.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3914D608A1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BLYwrL8a
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn20801.outbound.protection.outlook.com [IPv6:2a01:111:f403:2e13::801])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3914D608A1
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jul 2024 23:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvMtcIcTQpaaQ7ke7AOIyO1NARgxA//iNH20PsoiHY6mEB8YzxevIVIuVW1X7ReTvoPY7xYoHLx0XETvrMTxHE6ZiWaPvvoJaH+2o2jjzef098VT+7DgAT9N2etb8jcx5espjMz1C9mqnl/JzxvgjnkewxZQu6Yzae9+M7e/Hd4UQOFYlWSEsil8TzNNBASpoiPDchZBFzIywhi7HmrXw6hCU9Dej6bzfMPQ9p5QK6bOiacFZ8ptArmBPhJ6wXdqWBS2tmw0nqN8AsTp56acHz+EDDHM9D/xazsZkEQ5EKZnEfpPlLLW4vD+s7B0jRTovlGR6XgMAYdIFDP1oPpC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey5Pppju13kYq4n671ekdoo5C/aUqFl5pdYMwATPk/0=;
 b=xUR4njevrULupIGJnLzzo20GKAQMFydWX+cFcOHYwkEYJiFiuZXPzEi/L1axxtIwujMa5m36vUAQk0CZ0+ByR3Ex6IzxlaX6tJV3glzE2pbtuqVGhhglRZ3SfoyEdKlw8ugXuFUcy00FwCuxPW0QpumKXE18Ep/s0u3SSB6nesiipHQZL2PkUTLlgrjIEk7dz16WksQdbW3R7dOudb6ws6sCaIrYFS0qJwY4F1E7U2vuXJkA7pXV3NJ2D7p/k7E5sQFSf2nfP5QhX1kDLYYf7AaNv6V0w8JEnzsVpN+EOa8JjBz6cV3iJ1e1FgZjGZDHUPR8sxmPZeSbebVfO+S9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey5Pppju13kYq4n671ekdoo5C/aUqFl5pdYMwATPk/0=;
 b=BLYwrL8afnWlc7/9sjvy1cr5KCwToFOyPzS9E7GX2Rlo75Da/Vy/QbT2ret62lBGpS3MTPMmAI5ClRjEFU+Zcr+PlkhmYzVteTQeZwxYL37UeO9qV/4zpWZr5/66TqKbWO/cx2srhKFz50ZQIstBkaYVZdeZbML1/tuFN8PYFDbCKrsr9bZzC1OAXatU5BKOXWTkiteVMKmUjew75smQIcb38bardVbWI6Y1y+IaE2MJBUBEpWhJ2p+8DFIwUHZrK1sqJ6F0E1JUsA+cv3s+ROC5QytBunGK01g1vNdaliioohzvOCNNlxvIL22YJuEEqkghsirhIOH66GpT5TQr7w==
Received: from AS2P194MB2170.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:642::8)
 by GV1P194MB2290.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:1c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 23:03:12 +0000
Received: from AS2P194MB2170.EURP194.PROD.OUTLOOK.COM
 ([fe80::3d63:e123:2c2f:c930]) by AS2P194MB2170.EURP194.PROD.OUTLOOK.COM
 ([fe80::3d63:e123:2c2f:c930%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 23:03:12 +0000
From: Luigi Leonardi <luigi.leonardi@outlook.com>
To: ameryhung@gmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: amery.hung@bytedance.com,
	bpf@vger.kernel.org,
	bryantan@vmware.com,
	dan.carpenter@linaro.org,
	davem@davemloft.net,
	decui@microsoft.com,
	edumazet@google.com,
	haiyangz@microsoft.com,
	jasowang@redhat.com,
	jiang.wang@bytedance.com,
	kuba@kernel.org,
	kvm@vger.kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	oxffffaa@gmail.com,
	pabeni@redhat.com,
	pv-drivers@vmware.com,
	sgarzare@redhat.com,
	simon.horman@corigine.com,
	stefanha@redhat.com,
	vdasa@vmware.com,
	virtualization@lists.linux-foundation.org,
	wei.liu@kernel.org,
	xiyou.wangcong@gmail.com,
	xuanzhuo@linux.alibaba.com,
	Luigi Leonardi <luigi.leonardi@outlook.com>
Subject: Re: [RFC PATCH net-next v6 13/14] virtio/vsock: implement datagram support
Date: Fri, 12 Jul 2024 01:02:00 +0200
Message-ID:
 <AS2P194MB21709F0B79D6FB686D373B199AA52@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710212555.1617795-14-amery.hung@bytedance.com>
References: <20240710212555.1617795-14-amery.hung@bytedance.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [bubQ4t3BhOrcK8ElVNEmwde1g2LjRP5/]
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To AS2P194MB2170.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:642::8)
X-Microsoft-Original-Message-ID:
 <20240711230200.9740-1-luigi.leonardi@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2P194MB2170:EE_|GV1P194MB2290:EE_
X-MS-Office365-Filtering-Correlation-Id: bba13848-c049-441d-a94d-08dca1fda35e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	C6lscFQqpIO49xnDKcRYfginOV96xgr5N+evYut+qOQeH6/yzRqqb4ardcx1hA2PS6hxjDfe3kh8S0lcJ5xzidvkFFrOZK6y9z5mdm3g3rp6r1O1yAteJhcEI61slqLASUdxZe0aCGlbOF/pT7KI/dAivncFMpaqgy2aKaRZNQJ0iGqwke3yETOXLgsWrvbgC48mHFvPKEE3QvwWq3cOEFB4/xU/E+yhPRBFHFzf1iEzZaIR/K/mof2IPkGSXp5HjDkmF6IHutjQ8piarEASPxHHfXP5O20ghiLeN4JDl6ENOsllrYIE6LjV3xKpn0Pw0XvInCZovAh48armx+eWOWlb4eYxOLs9JZ2lHzEle+Uh298I8IesdaGtkYcnkivr3L3lb5MVXnvwfzFOimqxzzDpYrakX5DE5c5UhW5KQ4bb/RrkoOtAuCqmt21ukUQ8bX6R4C4y6u/4b/VV56g2ZeC5yXoKoTS7OthSx+VS4a65yhBFVx7GeK91xkUnhsJhYJOz4MZ9eCTkek4ZrIm3c6h8PEMae6wDQKg6xiXkfOCzsGHAvOGIAnenpDOATj1G6UwZ+YyB3ySrcgAOCJc6tiTndhNqsKYII0Zuj2y/l0yq6tKmGXRQF49aRnPSizWj2Nm7ONtzI0mjXMGbAHH4GJFKeHxKOPOtpmmgql67KL7Ev8Po0pxsg79jGkYCh3xDsGvDsoRHrf5737408dKiaUtXRXfCKDu1glJ9J9yScN/AEvYB5fX50skufPUOB+nXW70ADuCGKjJP0XEw0Ng86p4Ud6EUf/VjgJngV+myx2I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57858njTtXcLx1ZnQuGgTfUJk4N91jFqcy+BQFihGZOJqtUmb5HSrvO2YVXy?=
 =?us-ascii?Q?o6PTgJlPUvmB1FwB8xzUbnfEAY++ZTHfJwdMRslI0uRPpJcbpihPUgNB+5Ju?=
 =?us-ascii?Q?NwcWxikzWfdACebMorOY3TSL8a9lxz16z4jHUuHBYPPfrNevq84/pKF8pe4x?=
 =?us-ascii?Q?lN8u+Ic/KRDwSDWnJF8r7RbjuI1v5anMgxQAkg0zjAdKseiKSBJpKPXlngHD?=
 =?us-ascii?Q?qXGkhvCdxy516bFKu8skHOCVW36Q3MJunc/04jUM7DxcdJAjQOPUZzqC9K/J?=
 =?us-ascii?Q?w5ygSrME/GxqhgkevQAkz3SekVd19ShNuaQh3jLxg1Cl1o3+xfoIKxRxCO6M?=
 =?us-ascii?Q?kX9+RYsWiZFdMwVoM9D44fBCUiSc4SwvHOuEwdcVUitPDVqyDqGJ8j03QwFm?=
 =?us-ascii?Q?ecyyEna5gvYOWpg544yIycKPwqKkY/41W9eGJGXUVZEBxIAMNCsGlZQLHzHM?=
 =?us-ascii?Q?NZClfy6VSmcpP5/UrO0kq2GxDvBMvKTaRj35p27iWEHzuS30wWToUECm+DGR?=
 =?us-ascii?Q?RYIizdp3EipMHDJR7nZmPLXhTN3rt+HmmgUzF1TAcIHa9CD8E4PsNA5GHy4K?=
 =?us-ascii?Q?5fXjEiRPkLZxNpxPhXgsJ3W1l5ivm0PoecR3an7+S4dc4W1RTYCrMOGhQZij?=
 =?us-ascii?Q?iLtKzfdseklzm63SYxoXDfOQmWJfeC5+9gRp7qDkO9jjA+qyEQadenzEmDR1?=
 =?us-ascii?Q?y62AQKwl9i24AerVFmitwy+hqBys9cMwjShg5HuGw4iFDdA5rpdX6GhuAphg?=
 =?us-ascii?Q?C0+0+IXLto5jrWW9DQ3YYPFtUVs32U5esB53LEpS4SExbdEbkLYK+hSkyGlR?=
 =?us-ascii?Q?qabIjwmOijNgySdB+Rcd0opiocTJ8B0i8xuYHvY/AJXtsEfoX6jh0eLC93Fp?=
 =?us-ascii?Q?7YopXYqBquD/fgu1m3QqG4xiVhSs1z1VUtetr/622TqEzZXt9OoFSekVY6j2?=
 =?us-ascii?Q?fTUBfuD84nRuWuIZpzMYAtS2XwlMsXSrR/MnrWQLkrmSZGkOz9Fc3xK1wLBm?=
 =?us-ascii?Q?AdsdYmx/SAeI47wS8SyBCRDEMOZPBrhO/nl5QD3Kx8jxJLwtq1WeHivOm39Y?=
 =?us-ascii?Q?68zI197PnStsf0LzDOmLeqRd/iJuPsOBwZom5hJknP4G7RWkUQvtuiQLjNZ/?=
 =?us-ascii?Q?J3UiLiQLGTbALVMuDn94T5VLlHflElc2OgZ09r2lYOzAiPxxmGOAWI+NdkNf?=
 =?us-ascii?Q?Pg+0u2b3VuGs98uFCO9Qbly6GJk+NMoHIBccURR8foOgq1uKPk9dloycgD1Y?=
 =?us-ascii?Q?/TYKHqCjC3GjquzHMtKF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba13848-c049-441d-a94d-08dca1fda35e
X-MS-Exchange-CrossTenant-AuthSource: AS2P194MB2170.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 23:03:12.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB2290

Hi Bobby, Amery

Thank you for working on this!

> This commit implements datagram support with a new version of
> ->dgram_allow().

Commit messages should be imperative "This commit implements X" -> "Implements X".
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
This suggestion applies to many of the commits in this series.

> +static bool virtio_transport_dgram_allow(u32 cid, u32 port)
> +{
> +	struct virtio_vsock *vsock;
> +	bool dgram_allow;
> +
> +	dgram_allow = false;

I think you can initialize the variable in the declaration.

> +	rcu_read_lock();
> +	vsock = rcu_dereference(the_virtio_vsock);
> +	if (vsock)
> +		dgram_allow = vsock->dgram_allow;
> +	rcu_read_unlock();
> +
> +	return dgram_allow;
> +}
> +

The rest LGTM.

Thanks,
Luigi
