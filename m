Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A44AC43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 18:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B43784012F;
	Mon, 25 Jul 2022 18:29:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B43784012F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=GMaFe3Mq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrnhrrxZzyVB; Mon, 25 Jul 2022 18:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AA7840232;
	Mon, 25 Jul 2022 18:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AA7840232
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3351C0035;
	Mon, 25 Jul 2022 18:29:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91796C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B47B60E3D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:29:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B47B60E3D
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=GMaFe3Mq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUNiKrgonxth
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:29:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E4DE60E31
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E4DE60E31
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 18:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7fIs4VBEf3qgdz6sjI0XGatWjVwy8+DPBjzxFryXkRT1VYd/WjfKKp9imAU0QzcTJxuNbKCZrCeqaua0xbetAdSekh2UqhDxsDguTCgXVojVt2cSjM6/eCnqA6TEJW1PZe0qoWWM9M5Fm8fablGfmPTm9DZ4wodhIRWvm86L6tYTm9FZpiJGnuDmcgW2l8cJhjiPS7Ji7LVhNH7+UoPq4aVpIdO0S7ci8J0LVgMKTVbFMzoySZgCiqQX/AX++HTbT4QzeoOQp+i5hj/V8v7WT3a1pC3AVKl+UHSwwkSEH8Y2Ted52k6u+625uolcC6AWR0IAJ03KDef9AMBAexJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MzTf8MX1kpfFoZbkXjqiUEWY18fJeUpdw8OrN8kTbM=;
 b=RtDQYhvyJWaTnArrh4uFEAo4wdtEeMHSUFeMqYNeqaci5UjkX/V0C2fN5ip8FBuyMel5cVkqPcA4m/fZBmpm06k9BRAmErMnw8/GDL7NwdlHcuC8IJ2Wod7qgWKGWne7VG3x3G272th6IUzmHIOp1GRure4BoJvGKvCulQPoDsa317xP3oV5A0VonK70MDRuXRhuXvdzDbQTh4lB7VSQl7v7hW9X7iALB5lHaX2t+8+KYR3AbOc4P/nEBvLZwqflf3GRPtNBLgt7SZ5RXcWspk1YFTtDI2ikDk/QEXC8oOk+6ykPeLOA6kck2xfk+vaRzXcppjYHKA70VeHrxRd0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MzTf8MX1kpfFoZbkXjqiUEWY18fJeUpdw8OrN8kTbM=;
 b=GMaFe3MqTkR3KjSKifUdSFP8961/xc1LBFid4GqkhunF816LscuOup/PJ/et5lWy3Jd0QHWYVR6bVC0hZcs833UIPTpfPIOTthwXBO8I278piGoMJnk5YkivQgEbGF0gdGSbep5cXo0tUeMNK7Xw/vPZich0NHmASjr9MevIDF0=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BN8PR05MB6337.namprd05.prod.outlook.com (2603:10b6:408:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Mon, 25 Jul
 2022 18:29:26 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Mon, 25 Jul 2022
 18:29:26 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Thread-Topic: [PATCH] VMCI: Update maintainers for VMCI
Thread-Index: AQHYoEQyk/xBLr4HNE2eyPGwuSIgoq2PYdCAgAAGloA=
Date: Mon, 25 Jul 2022 18:29:25 +0000
Message-ID: <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
In-Reply-To: <Yt7bfyANrfdPxdS8@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe94fbe3-20d7-48d6-cd22-08da6e6b9a91
x-ms-traffictypediagnostic: BN8PR05MB6337:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ky0QHV7wQ0shF9ER/RhiGaEka+Z+LleAg4OnTb47Ea2OZfjvHS46xYRqZDCuhfbTAEPAM7aTCVvEPhuYi72yfJO+/awcNLnjIiwALPzmzMUPsWA3PVr+fJKG989RGp5+PWuJtCSejAQTYdhsgsvDuts+yD4sjqU1LwIDdqsEMjAXvz3urhypmkKrUnQqzHd/Kfk7Yyt0EzngJFQhI3wSHzCLb1td+zrk9P+IPAN8IQ7OpVHxhYRSqaCKPFKtsIiIVdhW39Z7sIT7IHrmCNq18elZ8+geNlgWMfy0yxKfoX5cBZDYBZs516rJ3iZJtXsNa/EcmmEHnjuFxz14sLawhCPx5d4yOoJfDGwhmDw/qNp60e7GfOME9f4/E1/Dj9EN5yk5dmwbd3/8QbiYICywhs+u/jHa5EIT7eT0H24UqgDluNZ/byuyZXDD3/7Rg9tD8i/fz28WI1c7seMjH2eDbaN15jeB4+suJqY+ZFV2Kc0v5/U1Ah+pIb1pSGCfIgdoSWb3394Ti4eatiZoTrCPbBX1rWN0AA8emJyP0yksI94E9AUYkxc9iGObGHc55jlgw3pJoVEvTJ2thPidbLPLAADFKNHDE1vNnEs2Sz3+eJd0jnkb3zaUlPNkPXghXie5ouG4suVX3xVASOvz5dHGITS3pksa39EdbiPDpP8eZXk4LS7SRGJ6Ikjc8cUjOUOmP/ej//ErcR9Ih35E54IMvSkSyZR5klt/kqUMTqkYy06Si8AVXR93oJtJqPCvqfWxMqUdpiY8QlQCkOlWV9VqV7F6AQ7vUqvBi878/8uZc9hVxu6MJ8WPTJVHXUzplKDYWlO/uMEMZlH0wFYjDYBb1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(122000001)(33656002)(86362001)(38070700005)(38100700002)(64756008)(8936002)(5660300002)(478600001)(4744005)(36756003)(316002)(66556008)(8676002)(66446008)(186003)(107886003)(4326008)(76116006)(66476007)(2616005)(6486002)(6506007)(2906002)(71200400001)(54906003)(6916009)(53546011)(66946007)(41300700001)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yvM6LNDxhLhmh6WedPsyPD5teEP5QojagkHqh0JwBvWlJCb4m1lgl2nZdezL?=
 =?us-ascii?Q?b0rpDz1/T37sDd8i0oDb043CddjnVV9unw7IP0DeMxbX8fZYF28GEKUJxYkF?=
 =?us-ascii?Q?gmKLy8dE4lH0zY1wE287gcE0PtsBaGRHWD1Mv5JFF8Q5dP+x1xjsEr+6n6YU?=
 =?us-ascii?Q?miV7BF0NkEIpMI1hdVgM/hRmKqvxFb/7p7POM4AG3tFDI4gaNUK+He8jq4A8?=
 =?us-ascii?Q?RNeXCTQSdvSZe+yWa7uhdFtVE2F0+MyagkFZHI3iriPSf8MQaprm7vdLiAjl?=
 =?us-ascii?Q?yUsonF0khdCIX6hNJnmAag/FpaqqVweMf7vpP6WmqCGqEdfHHSSRI9I4OZrt?=
 =?us-ascii?Q?iClicbO2oCFI/RIhn5zn0lcTd3NR6loNsTC9A2Dywk4G06Modli7LGmGlLEG?=
 =?us-ascii?Q?i1SUZWdFSpcxhsGaC15ib5u41rocJIL5+yQeEi4AnwN3Ow5z1B/rbqCoOb+j?=
 =?us-ascii?Q?g+inkRK/O9nDuz0ghjAukH/QQIFUku8yyWgkCC+kqN5qglOrzW15cqqG1FTO?=
 =?us-ascii?Q?RRTEuhT45MUfA9xtunoP2robvQcSZlfIwMnRyxp7df4eTrNSCsUYou6nrmvs?=
 =?us-ascii?Q?7ZixgJRngRLA50MWku6MzxIkCesntdeNaUJW7R6Pc1VMP9SCGmZqcKVcgnqi?=
 =?us-ascii?Q?rrtOoOcZ3EkGnIAHmNssJIVwvQAtEJiTtR2UW0Vsiz/aHivOMuCLV4XOSmTW?=
 =?us-ascii?Q?GvisIGy8WvXT6Ry9+Ky++qds8kgXe4GbLayilwF0P+3lhpfWli27P8mQxHSh?=
 =?us-ascii?Q?EsuuYlfUoq7Dpfc+OLnYJNz3gc9m7AocCWH/ZqDm6blPr4oV54eOGgo8fRX/?=
 =?us-ascii?Q?+11FpPJ2vQAaESY0NOLGW3xZ7iinMKo6pZynMmGe+/KlCGRXY0LR1xrsVgld?=
 =?us-ascii?Q?ZSUYDIitXyKGcI3dfBzfWVHynm//N8/D5Bd73yXvi4iK0cyRr5Qtl2LAsZdj?=
 =?us-ascii?Q?5SoENvaXB9Cm9VXHa+JPMBzJWoPzreRELMdHd44gSiegr3P5rp09L74PJPxQ?=
 =?us-ascii?Q?y4UIGKPgLk9tLOPvT6YdCDcdMTcJ34iLT0j/dss/c1fl0s4/3eZACNn/kMbW?=
 =?us-ascii?Q?Wq7LZWKH0ugRX2cYRII512I3mNtzcwh8SBrV51XBCOdheyRLIAYSGvhtxK7W?=
 =?us-ascii?Q?J3qHvQkOM4nBBEN3vqCFcljqFk0pirFz7e7k0RPaB74lC7DLRZkLAPSRQAaL?=
 =?us-ascii?Q?F73/iKt7mEoPdvCUEFhxkYCKGYw7bhWRTsRtJLwIxwu0j9MojKNqXevSS8dT?=
 =?us-ascii?Q?uCJM1ZK5IR2JUtYeHJ2W2YyIaLBVs86+4ZGWtZBNcHrCz7QLz1b7zX8rUiv/?=
 =?us-ascii?Q?8cVkHafCTpssSpMvmYd7S/pk0RvqFjn2A7taF6xPdHhAibkhk36y0mqjMZyD?=
 =?us-ascii?Q?YjkdZiLgfA0GJjoCM2IHDwhHBNsEs9O2/J+13YMtzbZTTJ8ZskvYX3xnYOr4?=
 =?us-ascii?Q?ulGRZIHjdehuyTsuDfRV29BI7PrVyIxSzPeyGaV1lrooo/d7rWqN574G6llV?=
 =?us-ascii?Q?LdK2qhDUxTT3sMSr1Prckr7kfepCF3FhQwbzktcvuvS1J9NdAnZDoOVd5tO2?=
 =?us-ascii?Q?FfvasDrT9DWafwcdCwijiq5bATq6JZMe9Ouvx44YhRc0X63rdeotApUT3cjF?=
 =?us-ascii?Q?9Qmhar5k/vydwiUmu/fLd0VZK7ndwdcDzBfLpxPDxD+4?=
Content-ID: <3E672CC9D4235C4E8DC549BD5C0B63AC@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe94fbe3-20d7-48d6-cd22-08da6e6b9a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 18:29:25.9836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpR2mlxvjczV3+yspsKo2/Y+sTYt9CnU8JxmT/ICU9FGQR5Mq3QSUrQDEGp+emrzkYAoKJkpYubJiA4mqNX8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6337
Cc: Pv-drivers <Pv-drivers@vmware.com>, Bryan Tan <bryantan@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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
From: Vishnu Dasa via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Vishnu Dasa <vdasa@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
>> From: Vishnu Dasa <vdasa@vmware.com>
>> 
>> Remove Rajesh as a maintainer for the VMCI driver.
> 
> Why?

Rajesh is no longer with VMware and won't be working on VMCI.

> 
>> 
>> Acked-by: Bryan Tan <bryantan@vmware.com>
>> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> 
> I need an ack from the person that is being removed here, for obvious
> reasons.  Any specific reason you didn't cc: them on this patch?

He is aware of this change, but we missed sending this patch before his
last day.  So, his email ID is inactive now.  Hence, it was omitted.

Please let me know if there's anything I can do.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
