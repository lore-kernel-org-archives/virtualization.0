Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43053C47089
	for <virtualization@archiver.kernel.org>; Sat,  3 Dec 2022 01:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D73860AF1;
	Sat,  3 Dec 2022 01:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D73860AF1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=vyXXbwro
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rp1UVVswWjno; Sat,  3 Dec 2022 01:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B00560B27;
	Sat,  3 Dec 2022 01:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B00560B27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6E0CC0033;
	Sat,  3 Dec 2022 01:17:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1550C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Dec 2022 01:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BA844167D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Dec 2022 01:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BA844167D
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=vyXXbwro
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYxjnEEJ4gxh
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Dec 2022 01:17:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BE57405E5
Received: from CO1PR02CU001-vft-obe.outbound.protection.outlook.com
 (mail-westus2azlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BE57405E5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Dec 2022 01:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEi9Gshg5FfCH/jOBE7QN8agz6xQ5nffMOOrJQ/KhQ915IjGAkIaAHZSFkU/aQctHr+02YTx7XUqxUP7GtfejIKouN3yoxqMh3+23RKdJ+H5n0KHg3a+HIMlV8tjVfc3w7SOwZMo0qngFVUf4Ernfp8OrbbH/OZ1ZEf8OjlF4zlZKGEZ40Mv/fcLYpHfh98BgbVFD8GPzQt+1LQTOuY1RWCwe6KM0PONQkrSe6ELVm0qI2Y+9G6kxZre3FE5QMSKgqdHmYBZlbbMb1lkwbrwRHh+RkBlVbDh7wsp6obP7eUThLJggPaqQCUGMyMCgZWUMnhShdEjZ0qHHTx2T1UjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytiPKTrE1y98gilt7tBCXZ1+lYVmXcyVfrhjLTZSTSc=;
 b=NkbZOj95GHbVFHFUO9LaLS3DY2mYDi6cEYMydmoZ4ClDEPBeLko1bgohPLFpbRbA+kkBzlZgP+bk4ENCKAb32NPLOvUtz4wEaoEU5ONHieEVEgYMvm1nSZE7aZcQqjt3hC6dj9zaxSnVQVZfXYztXj5S06riKufRcn2RxTQEBFvcgaNJoXuCTseR5jy9zhmjSykz+NcuHSRjQr/ts49t/CL9msnVSBrU9rapDwCte43psxszqSjOUtuPmjpD5fmKOaJa51vP33XoqyYwKdPByNEC8twrR/wyFC4nygcazIf/uAO9DS8dfLiIbvW7+L1TLMDvHMCT9EgDnf771WhC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytiPKTrE1y98gilt7tBCXZ1+lYVmXcyVfrhjLTZSTSc=;
 b=vyXXbwrod+S+avS+MYFv1WYquZR/Dcf34s1w8jS4QG/SVdn+IZ3smbCNEXhz/O+avv3ozMPFbZ2piFH61ERZXH4Lxo8WpgQMGQ2VSiJ7v20StC/o6ybn0tjZNGl+5HNW7bMuPnbamPzbdanbY55KNsosg60MWT0aQjcNletzATY=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by PH0PR05MB8511.namprd05.prod.outlook.com (2603:10b6:510:ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 3 Dec
 2022 01:17:33 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1%7]) with mapi id 15.20.5857.022; Sat, 3 Dec 2022
 01:17:33 +0000
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH] net: vmw_vsock: vmci: Check memcpy_from_msg()
Thread-Topic: [PATCH] net: vmw_vsock: vmci: Check memcpy_from_msg()
Thread-Index: AQHZBqGb35ZyQ9z5mEiW229BBPzKAq5bXMUA
Date: Sat, 3 Dec 2022 01:17:33 +0000
Message-ID: <702BBCBE-6E80-4B12-A996-4A2CB7C66D70@vmware.com>
References: <20221202225818.3934909-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20221202225818.3934909-1-artem.chernyshev@red-soft.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|PH0PR05MB8511:EE_
x-ms-office365-filtering-correlation-id: 9bfc709e-1439-4fa8-418d-08dad4cc27bb
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95EFquQyGVEEzp4n+vtz43UWVkRMmNbIBJ/+r09+JtD5kbx/IiRMzI6Lfris426zC6EwXoETothPJsLi7bMcajj0BZjPvlnI+dqf1f336WA2ED+31qxVMHJT7VP5rp6KRkKFnFUTbMRc0qFczzRTpv7iNjOzlEDaneBo1CahM0xnicstWFoyhYBwQT5CFYqB38pyoC+mqn/Eh8qj8Oa//bEFST+wT6fN3yRYbHeRF9YBvkeA2dvAmcor1FFQ8YdPPxqXFZ2SxQGixn5sOpPpnD6//pJ+umn8BPbyH6kGLOY4OwQ17ZNH7EmMU3IjeKZdFDi2Wv2MD1Pb58LwFjT9L87WI1MBZ2cZXhHm5rd8x1fvQSNDvEvRSKyWVl3126KU7r3oLugZFmhC8iIWchPQAmtVVtT5Rqjuoj/ZADMK1ujWKcwpEZV/493/GGg2U1Jz+cfGeu3YA7q7eqV2nna/oNJmeYQXtb/MH2GgWHhCyvpOoSc3sDXwwhVAiGA6SjDBb6428JNQQbnPKvoJ3H87rDNkAG7IbfBNcRY29ktyNqcFfaIO2O0RcS8AMFrzC9jimRCaoV7DfbQrRYEb4fUHP4yq1b4NcKao8TxMTA9I3Wrlx8pFCdTDW8nntyiQ4GogEGyNpkdctWFdYAvtr/BgSnoa0yZmp8Hn1aAopABAm2NYU4X17BzrVpICcu9ZZGfU+bsKC86WsgUbnxSDfeWSVg3UZNp+Oh8IhBNN9TFJkGs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(5660300002)(41300700001)(8936002)(2906002)(38070700005)(8676002)(36756003)(66946007)(66556008)(66476007)(64756008)(76116006)(4326008)(66446008)(316002)(38100700002)(6916009)(33656002)(122000001)(71200400001)(54906003)(6486002)(6506007)(53546011)(2616005)(86362001)(186003)(478600001)(6512007)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?asvQdz43TSpYl+krkht9L4ZOOYOuXOhgsxzyIaJMPh22bgXTEfKDMWJtRwBs?=
 =?us-ascii?Q?CibJiCT7fHCPCGE5zpo88lgDlITPFysvbWKbaQN/SnxEIkjCoFtTvLYrDJAU?=
 =?us-ascii?Q?rBp+7pyvxwEdafC2h0ns32ksICDPpddYRi4GW7lczfR91ZxwLi5QOd2lPfLg?=
 =?us-ascii?Q?BpKM4r7Ea8lX6ZZ/CYWMyPcu7D8o8st8pYMDbekQIg8uBT1LjzwYZs0DrRwy?=
 =?us-ascii?Q?Sb/Y7v5Evdy7zl1Chrrfh2OeN/5oEzCicIgyTku4wny8c7LAVH0V/bK9fZ+P?=
 =?us-ascii?Q?dU8RGCa8DjilSdaUEQjyQ3ooDwx1S5f4xmjCge6dCgPvc6aZpMkE3IuDFXJN?=
 =?us-ascii?Q?MC5BQk0j4l6oMDv4wpQPmdHCOtubPjOj4On/XXXwO2snAcwdmJNdor138jgt?=
 =?us-ascii?Q?/Oh4lOpnmX8UrjllJn5urSg9qjL4KVXe/aCK/L4kulUQk3Bg6iPJBfk2SVn7?=
 =?us-ascii?Q?qAO1e5BvzqSXAg2Sm1Wt3//2Ebf3bt+3OwJLdUCDgBDn0LEN811zcvn25rf4?=
 =?us-ascii?Q?Bmb5qW6t9bSelnEEls+PmWQBCeVMRnn8OIfRS8tBv9OcUrkHuSRePGf9QVy6?=
 =?us-ascii?Q?xfMd8pAcuLyaU1BqjShMYGgf8aJxRsSOJLSCgO7Qlsidfm/3mjWIpzRQahfu?=
 =?us-ascii?Q?2n+ZbG/xlNPGS153Q4mqVl0MVMsemKl3+botZGrlxIYnazR5GB8l4hMKr9ed?=
 =?us-ascii?Q?nau6kZqGUh6rFxNqA4IynvRcFMLG4EMQ2yFvgg50LYqURkIPGuV80FDHhYVp?=
 =?us-ascii?Q?WePVEx3t/NytSyO5iHsV0+/SKrmbVHHQGpIoJ9CeQHkz8GIO/M753yIbCrm6?=
 =?us-ascii?Q?o8iNpdd+Qo/lTWgBL8Y/1yx714S2yYQ20rXqKQvE1koYIe4Qnq4OfLPbWguj?=
 =?us-ascii?Q?jw7drmEHEOvR+adV1tbg5F3yIT22OWwa9Hv0TKJbD4DiHGvqvGNHYkBJZoKe?=
 =?us-ascii?Q?MSOFRX3GJyQhbt9cDq+9J8kE8BMqhBBG/ObcuyWOUq9ZF1PMpn1ZG7r8XmhD?=
 =?us-ascii?Q?5vt/2UobVORlQbTg650er6ehNcUG7foef/TWfhfu4Rt2rpOxMq8hRTWhWyZO?=
 =?us-ascii?Q?Ze4jq4R6VVI++hbhH0aFbL5gdKtIfWP3PaKXfgAJve3ayFNrlZVHvAwMqjD1?=
 =?us-ascii?Q?1lr2oehYVwLXZBrshtUKwWxFxQb4N5bbIkdNwtkmddC7J3n4ZvEK/8ljjBsI?=
 =?us-ascii?Q?cS1SyDozBJreNE9QOa9kr2h2fSP4IixDnke2I1OCuGZ/rtXnRoSGzWoJ5Ecv?=
 =?us-ascii?Q?1GbivFNVB2z64D2s2KCxySTnKZzO+V5l2AQJTs2IX/T9rCPyaGBliJ3lXlaC?=
 =?us-ascii?Q?eYloG7CkXPn7/CfDupZrfwxJkuMjf/zi0iyVhz+WRms57XrPjxTeoBTIYzmL?=
 =?us-ascii?Q?kTWix0yV0DYqKmUUSfiC1e6ySC3z2S4WqZz7Ryz/tJaB+KPlqufp6dY0Kwt4?=
 =?us-ascii?Q?/7po99+1zl/5nzEWryA/myH+Lv6Pj550w6haTYRyy1FjtbQ+/0X4XvCxlHkh?=
 =?us-ascii?Q?i+TpRn/j5eaHOYSvcO8a/Kh0nj2ffdAnVmNceVHbuOdIQ3p40e7wh76ZQA1Y?=
 =?us-ascii?Q?VKdd7AjMtdgc7O9igc+CYvRcvwgKJKyZgqF97eQ2gvLThB61U5VMmKMGfWTX?=
 =?us-ascii?Q?2RKiRf+Fw0uN9/rWzVK158vqS/TTsZgM7XrXghmpiZWe?=
Content-ID: <7E63B8CF4B48EA4690AA573E066E001D@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc709e-1439-4fa8-418d-08dad4cc27bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 01:17:33.0721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1/2v5aQEc1f1j9Wx34IIc6w1y5ZZF2vmFfKi1qPaP81zkGUUu7kMWlw6+cxvwYQek3vKEP44kwXVx7rnwyx1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8511
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 Pv-drivers <Pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Vishnu Dasa via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Vishnu Dasa <vdasa@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> On Dec 2, 2022, at 2:58 PM, Artem Chernyshev <artem.chernyshev@red-soft.ru> wrote:
> 
> We returns from vmci_transport_dgram_enqueue() with error
> if memcpy goes wrong

Thanks for the patch.

Nit: could you please update the description?  Maybe something like -
vmci_transport_dgram_enqueue() does not check the return value
of memcpy_from_msg(). Return with an error if the memcpy fails.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f7db23a07af ("vmci_transport: switch ->enqeue_dgram, ->enqueue_stream and ->dequeue_stream to msghdr")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
> net/vmw_vsock/vmci_transport.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 842c94286d31..7994090e0314 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1711,7 +1711,8 @@ static int vmci_transport_dgram_enqueue(
> 	if (!dg)
> 		return -ENOMEM;
> 
> -	memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len);
> +	if (memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len))

Need to free dg using kfree() before returning.

> +		return -EFAULT;
> 
> 	dg->dst = vmci_make_handle(remote_addr->svm_cid,
> 				   remote_addr->svm_port);
> -- 
> 2.30.3
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
