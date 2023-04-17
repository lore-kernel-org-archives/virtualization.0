Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D124C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 12:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F4C341CD1;
	Mon, 17 Apr 2023 12:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F4C341CD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=S36OqQ6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlENrjJn8nHq; Mon, 17 Apr 2023 12:17:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CE8240602;
	Mon, 17 Apr 2023 12:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CE8240602
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9CFC0037;
	Mon, 17 Apr 2023 12:17:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECB69C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 12:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0ADB822B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 12:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0ADB822B8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=S36OqQ6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NKnOjnECkRUW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 12:17:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06AC981CEF
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::609])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06AC981CEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 12:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8XT1hWLy74a5Ly3VICjjLvdb1iT2UAwfNnJqDdW3Pg9vLHBvwz43GIVNOE1PPmFfEK1xZVBP1YU37VZLSyMJUbhpEeb1iznQV4hghh6gyp2a7VN4hO989XUT7TE0IWN4FEUQxIdJWyNSWT6O86W0764b2i0svgGepH5xcuxwkBm2opm5hYstU2/puH/5XFmt160Tz3jPEIFNZqzD+Nx2ujBcgAG4J1ZTypCgz0M2NvD4k0x4GEPOpuklUyayOHYqOK8sNelPtl7n1hxNL0nq7V3M9y2sEWgFxK2InpoPiva9UkYxcwEKJ+WE2ulHWUcealrlVnRPMVSfZTHEpDjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XevJQ6xmykEKMDkBXdgOqvtCLid70HjTXa1x6kTrdug=;
 b=UrDUd0m/yqc0bkUtnqamopdKrdjChdg8VdqOXnuDGwgrEWz4rGVX8f2u5pS0Jw9Fe8n+K4o285WbQCrWcX2PcQQH2arHtw+JrABnDWcnsvyu2ctFsQxgrG3NZ+t2VjJHwCjkMNuFRMFI8RKr/DzV15Fo80VGnRb/7dRPrC9kwTK8WpshCqRNzSfsbPeWd2K4KRe/N4Rs0hZIUIteSogZ6prnEbDsPEEz93FvoIFMrSqr77Bc140qLl7e53lqVHClOV2iR5uaF71OnmDEYc7ygbxp4Ylx0PfvTNPUDemAgAN2K6gcb5MErK8iC6vkdLPuGF5huhlH/zhwqcwbMRtXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XevJQ6xmykEKMDkBXdgOqvtCLid70HjTXa1x6kTrdug=;
 b=S36OqQ6DcqBvUxFVPi2JpasAI76iw8i4pcVyJh5heENKyR2Bq/32EbKa2u0Q/U1tE4EYPc9jQeEjsrPvwXKGnBtoOGb67dMlY0YLvw2A5YVwEeNDSstSI3T6fOv4iEpm6tksqqFawfFOJ4infYSpFo0HvtNXe77EdSaFQHlyLkw=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 12:17:33 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 12:17:33 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH v4 1/2] vdpa/snet: support getting and setting VQ state
Thread-Index: AQHZbdpIdlYIDfgaokyFNSRlB9bj7K8vK1mAgABCPio=
Date: Mon, 17 Apr 2023 12:17:33 +0000
Message-ID: <AM0PR04MB47235881EF3003A71F886203D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
 <20230413073337.31367-2-alvaro.karsz@solid-run.com>
 <CACGkMEsd=gMTBSsLJm-Ei9vz78SxwHnpCzRfdocKFVXzD=fnog@mail.gmail.com>
In-Reply-To: <CACGkMEsd=gMTBSsLJm-Ei9vz78SxwHnpCzRfdocKFVXzD=fnog@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DBBPR04MB7690:EE_
x-ms-office365-filtering-correlation-id: aff1adbd-1eec-444d-739f-08db3f3db953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDQ0A8+tMw95X+D8w7cqI+yc3879ah7n2RjkhxYqGHDVbPkwOWpUjuuFHF+lsq9CSyvnAyXt8a+A7Rz9o+sjScY16ZJDHax4jHFuv3Mk4tV+yDmDqixj5kSp/eZ/1gpcewvu2IWLNDiUBkTfezavG8kdpVqHS4dDNLHazkP9rHbaTY7yu//x0wHbmDUmTpLtCRTpzoXHEYCG2p2G1nxPzhBxQpgVYIjt6rKcWOuXP6V4AwoAetcPe+xMmkbhTp3c31lnHpYxw/zk/SVScap4u+KqP36XxY0ho7v4xgFJpvCzBiQu6qpL97TQHF2P5TRBJbvHbHM1hxOvGeTfz7Ysj7jC91MHjrh46ekH8SMoWs4Ci1ju0WozYiXs0E2FnMb6j7Gc1pkV2yeuTR1hOSVcHDzq8rkwZCLudaZIAnrfPoPQDKUOfKvudeHekfKELv37Cj1bmDsOXTdbj0bKqUDtkzrH9zCSPTs4yvYWv0gy5GW8oQeTCK0Z8CHjmMMGbkcsiB7zd0zZdocNNrqi358/BK7T9IW3UNcaU1sCaPs3Fm/emEtAFfK9KHu7bZ+AKognDhqCPNzmvlfOUYCgNX8X2lduPmM3BXKcZZih7GAYPsa2ot0W5Y/NycKaP0tiTEkZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39840400004)(346002)(376002)(396003)(451199021)(316002)(4326008)(38100700002)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(91956017)(558084003)(5660300002)(44832011)(52536014)(7696005)(71200400001)(86362001)(41300700001)(9686003)(6506007)(26005)(186003)(38070700005)(2906002)(8676002)(8936002)(55016003)(478600001)(33656002)(110136005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bWiuQkDokDQsVxvmNBd8L5awnlvV9U35z8/hmHVkPP34x1AF4Vl/iHIqlB?=
 =?iso-8859-1?Q?9PbFdx7jWka6cYeA3a8tYI6tAOXXjA9pxEkKHmOvKSbOmyLmzqvviVAmTh?=
 =?iso-8859-1?Q?CbZPRWgz/MTd4lM1YnepcgTASBwdAftnZjHOgKxBgJ5BnR+o0xabnxQLnb?=
 =?iso-8859-1?Q?QV7KojH338SWTCLbzDczBqbCoZWF+mxJ5DdAxUfGuHj2tiScmvW186WwFR?=
 =?iso-8859-1?Q?r9dXzNKa6QT1WURZwaOLF/KvYgV3Iwp1H9dsijIIePHa0gUd50mz3cWS5i?=
 =?iso-8859-1?Q?V9T1gADl85DNGnSLqMxjwLfgF7rZQXz09TvCiDyUp+DS0hcJ5b8/902KKv?=
 =?iso-8859-1?Q?xoLL3HRQndrnZAez2JtfOMajQmJA3+KPi5rRW+p4ybsLObzVXzKNCAciDh?=
 =?iso-8859-1?Q?rVBNtDHIYa+AMgE9wh6TrDv8vDywxCOSQY30sGEEn3qPDcJ9VM3nD0dMDH?=
 =?iso-8859-1?Q?xc+XauPtscWSecPyYrYGQpVAqiBhvAg/yWENwO/j8XU83fYhBpIU0gKZL0?=
 =?iso-8859-1?Q?XM9Stm/OxMzqhj8KOOe2kMzRfF6IlaX5uFR721uchDl6gr+KQBl1to4MPC?=
 =?iso-8859-1?Q?wDMcuj0IJfyHpf0pRD7pi3WhC9aH4QzxHanAUopp7fHdyjzLv5tEpkSr/N?=
 =?iso-8859-1?Q?sRqPs+iqjTYlJ6Z6Ehy3HES8pBWY6PomIeVHP2Puy+5d65OTjxo6P2j1O0?=
 =?iso-8859-1?Q?IyE61fF7yBwZa1bJtDcAsVbvZtbxBWVj5cW6ZHYQtTqs+AvPph0BeCq3z0?=
 =?iso-8859-1?Q?Y0QLkLFV00NOn6EoH1H7xUZfBqm0LZQhHbbhGPX1o0FmXvG8ohMJKkU1/d?=
 =?iso-8859-1?Q?b+A6P/VpUmSrA0tpbdM2Al6gX6fd0PqnPVJzin1NSiPE7svbmd6CiKkNPn?=
 =?iso-8859-1?Q?r70W9i6nMtPi+AwTACaJrH9NjPRk+4qlaiYY4WLe0rl86/uD4yK8W7OUWG?=
 =?iso-8859-1?Q?tBaE5Cfrk9OnWUKXBepcvx+smyrmCPXsjxT/4CHjRg6WMWeQYmMQk9pSkY?=
 =?iso-8859-1?Q?TVzeCpVQDC1ZS0VWJRIWozda7o57kRCMbYVb7+q5e0r4lHWwldTdtYbsog?=
 =?iso-8859-1?Q?A1xr1mtqdq3u6gLyI6yBrA2Bl5/II5Kqfb0ZNexP2nSQiC9KER5acak4K5?=
 =?iso-8859-1?Q?44m1yOMVQoXTvDszbV4qSFteL3cQOzj8PsK2qL3Fkaifh3ZS50oZxf6YQ5?=
 =?iso-8859-1?Q?DZcl2fIBhd3Vfls6avhy1Nkyg3H6yWtxERsknv71+v5LudWiuLemE0+3XS?=
 =?iso-8859-1?Q?NEkFNHZhSNyVddR6VQDaSL5ys150Tp9bNp7zJLRJcPMxZDfHZh3xNo4uRM?=
 =?iso-8859-1?Q?v0ne8D+lyzncZDdPrFMHidukFKgwiiFbad7yReHTgUcahYNXtfO+qIg/vn?=
 =?iso-8859-1?Q?njgPo6dzhSmrxATU8eo3wxgDu9m1CWcQ1pWF6sV/ZvFlefv4/8VJoKTN7u?=
 =?iso-8859-1?Q?2P44HJ7JwLbl6MTW+4Bh4hii1EVujnSFOPyzJn6cR/P5DZNHPIuS6K5AIY?=
 =?iso-8859-1?Q?kgF2vNdTGTb/qsxGLixwJEVjFWrhf5hNuwHYdHgljZ/evp/ZhWLJD6CEQY?=
 =?iso-8859-1?Q?zTQRcF56ieou5y2DEZ92iRVhHwUzdPb8oZS2COJRhbKUO4ht1uk45qHBb5?=
 =?iso-8859-1?Q?8lDabB2StxZILcTq+3nm0yigVX6zEfi/WN?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff1adbd-1eec-444d-739f-08db3f3db953
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:17:33.7434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11ThQIU+FtPk4M0D/4zsOQ8C9dMslaa25lzrql8jEY1R6flwpE97nSlc5uJPqrT4wpwBiK7fGbbmLiMaGpRnDJKESWTO/9N6HCaRyzIusbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 

Thanks Jason.

BTW, Michael, I see that you merged the first version into the mst tree.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
