Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D1DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 00:34:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54BC22E03
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 00:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54BC22E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C527087127;
	Tue, 26 Jan 2021 00:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dMV-H8WpA5R2; Tue, 26 Jan 2021 00:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4609E86FC5;
	Tue, 26 Jan 2021 00:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30D43C08A1;
	Tue, 26 Jan 2021 00:34:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF743C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DAFA486A25
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7N7aGSE1nAx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:34:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 27AEB86853
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqZj0gN0oF0ZjMZL02hsKZmevHYI7wQ3asGU7Xg/rN6mX4VnUB0vY5ecHoqrn+2x6JXDSCZLLuP0Un71BwrLMrSfVDBLIqC7K3ADay7PlGhaHsF3hD8sjv+OM4G75pJ9IvYUMBefhVkCI9iM0x9VcrGh++8TPZSp2YBf9LymVSiZlWLunk0bo79RUNPuLAFCpaWXNBKhIcWtP05S90aHW6AkuH7MbARAzkYHZ4alf43jWH2LbnrQcCRJmrBvl6Slj6BezjCWFDgElcSiGQCCjQSftlovgqO07eRtpQ5wihJ7Cp/iB1eQBccx9h/rjUiJJtFpxtBgNMeXogJXvpHoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KVso1EnpGDs0m2cb3xmmc+znhRBTh6oCdLcXVA1H1o=;
 b=Yh3/OF1shqKJ6Idx38PSnh9MDy5s+MzViS53fJrrPEwYN86gKHigfYe+rkuyFjfRB7HwEVzZp83KQuX7wXHsPZJw1eo4oG5T3FB2GrCqGcl8NkQEEaRZCl652OhvXXZ9SFeI7v5PzbY9B3nFw1odzz5XRDd8Qos/QmRDdjjCIgsOcVZDqvLt/G1cRxypP6gAstBy9oohqrHnjOhKo0p7gWugIhoUzAtiaGeu48YbDr7Mw7MiBeICdzSE+G1GhvJ1Qd2Rcw81yvwOweZMZcjs28Trm61ur+kMmM9TtBW9zGGKrV9SKVbPVhKc0vJyVhznRdCsaC5L0L96hWTjwPW9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KVso1EnpGDs0m2cb3xmmc+znhRBTh6oCdLcXVA1H1o=;
 b=EtFgfNvWViQCQmKd398ZnXniffgcVbjMusL7H6TtgoEKORZY8qNMkF9kJAbo7lSg6Lg8At//lPSQOxQCk9YW7Lfj0tYIL+mb0DMlySng0mqufOUu3IMTttEZ5THJ9lRz3JR7/QRlFi1PetKNx9791In/AKnKa5M/fqIrvl9R+0M=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 26 Jan 2021 00:34:27 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:34:27 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if
 running as root
Thread-Topic: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if
 running as root
Thread-Index: AQHW7yPzmjCK+zoGwESAxKKYTenmNao5F38w
Date: Tue, 26 Jan 2021 00:34:26 +0000
Message-ID: <MWHPR21MB159358DEBC6EA386763B788FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-6-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-6-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:34:25Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7119e4ab-6e0f-41d5-b63e-ad573e340f96;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 442de367-6917-4ebe-d832-08d8c192233c
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18751E277E5CA22A95266CDCD7BC9@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eSHzivG6DHnUDBHJ3IGOCIz+gA4t87ks1snlEc3Z4zojI7rRAG7qF/OM8URToZEbh06ZkLOv4gCob/NKjrVBeVdAgoXCsKPzOZi7pfDrlxojk+N2Y1y34dZu1MDF2UoP79nJo71bFn5kC9HZDdz1uecOxep9NyEl3ROTi7YTib1PgZojoBEbFm8jgqj+9FUTQFAr/Ri+HB3AERfKFt7CVh0vxUBt7u0nJeWYqEwph7k6XdnvBKv1/tED9auVR+SnXPx3nmkSNHY043zeyYCjw0MLKopP9j3L7v8V7Eue2svTqMQ71oG5GxuonUOhB2LP5xIajfPkf7u42/vir7kVgEgeq5AJ3XSieJHC/JfL0iVBbAqUUQeSJ5Mv8vd8E6EYtSQDm/kIgzlCw8iFlDin3n0aBgJp8rnjE8SC2n/uUrjJqxqJRUj5D5SsxUCj3bH4KUHakJNWVEOZIWH7MyGrX6XHN37cYxJ2DXKb4TK2rOlP14IggMzRfsLkfj2vkafkGVjpTgmo5Nn9MJSYUXIeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(66476007)(8676002)(9686003)(71200400001)(55016002)(76116006)(4326008)(86362001)(10290500003)(186003)(7696005)(478600001)(5660300002)(8936002)(52536014)(110136005)(66556008)(66446008)(2906002)(26005)(54906003)(316002)(6506007)(4744005)(64756008)(33656002)(82960400001)(82950400001)(83380400001)(8990500004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wQemKI/4tKb9u1zqTTbe5QYDq6uRqFHLGMiiPNFfLN3sl7yaQa5LN/zR/irS?=
 =?us-ascii?Q?SWXp4MzBxt+bRAE+XmfBtC0YZnM3IuAjrd5ZtXp/YD2sLE41GdZ7aPPiLFE+?=
 =?us-ascii?Q?iB1cbKCxt5IxYWRUO5RP42Ec98S+4eH/ozWoXVllWJwZretvgnfe7IOD0+tq?=
 =?us-ascii?Q?guzpLsilvgf6nYQ2IxXmKX7m2ZCBdbiNLSyxmVahz39JHS29KIhJvXrYpDzy?=
 =?us-ascii?Q?wU01GHz1WAKCJg8sqKKI6Gqt2rXuqZJKw86lskNGipjn1yMjGDO2TnFVRumY?=
 =?us-ascii?Q?+nTrVYWSAT+tuWIBIj39r37hpXuGIkSF7ciZzjM47UfaxpXEE/ACK0ozVNFQ?=
 =?us-ascii?Q?G0jVG+rLxMS6NW0r2oGx/sc32tukjYzf1vXC/GassADror4JLvcW+rPYyoNu?=
 =?us-ascii?Q?fsK6TjMtzmy2vsiwDECSx3Er5BpVj1rl8Hbftik9sgMYbn1aU0zIoUzHbkus?=
 =?us-ascii?Q?5wzsShClWnqcJKgqWI0528wbuLDKKQf9uo9iFDrF2VhVl54/mjam5UxlCKnB?=
 =?us-ascii?Q?6JpOs5NFyVXslojuO3qRYeiuZqWVRpJYT0ti86Z6MLhYXOItTsqmQN8h7brc?=
 =?us-ascii?Q?89ZZy1ODRhDYmpgltviDEX8Jo529S5nRRctcSI/LLGOIaPqvdEpIMhJrWWlN?=
 =?us-ascii?Q?US7gTRmYcNTyPREBiyUpf+FUivV9yTFOpat5WXIM0li8TBKaqBOdLkR2NS28?=
 =?us-ascii?Q?XLJy7qxksvHrtni5BWpGHnRggscThSX41iRUnsfxwkKrGKr9+MVpVwfT1La/?=
 =?us-ascii?Q?enDRWISfju1Vr7aKFbXDJWwL1HVVjGx7xoCb9/a3XFD7bMimb57dnsLXwDL+?=
 =?us-ascii?Q?TlbJrjenywImEB40/5cnCR0fGd2mjkxSFJ3h9AwCF6K7RPH31Dtrnaq+/8Aa?=
 =?us-ascii?Q?IIZRDf6vZ6TQMCz/OCG7P+40lSH/sbcdojbOh9DZH+RXz8pvg50TqKE3pueJ?=
 =?us-ascii?Q?J1RHB1TyWDma3b5KFmki4nlH0jgv4qJvesD1Wv6Rppzw4N9qcL6zGk8T/1rC?=
 =?us-ascii?Q?5HSThhwZbt1WnHQw0NhefvCRB455+yvpgCLNLUSNpI2OCReFkhwq+oqjwqCC?=
 =?us-ascii?Q?Qj2fHq8x?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442de367-6917-4ebe-d832-08d8c192233c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:34:27.1762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJ8h1xody12mhY1M4Rg8Hre2DwtiggOGBLph2Oe7QZCLMSpNfMHwPUA9ZWG4JYSIwbWhxz5z6OnvhudxbO8oagWbhiFDLSVoo5OuXTpNSkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
From: Michael Kelley via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> 
> When Linux runs as the root partition, the setup required for TSC page
> is different. Luckily Linux also has access to the MSR based
> clocksource. We can just disable the TSC page clocksource if Linux is
> the root partition.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
> 
> +	if (hv_root_partition)
> +		return false;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());
> 
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
