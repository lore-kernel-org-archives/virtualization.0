Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0950C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 06:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC2B6113E
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 06:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC2B6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 458C7400DF;
	Thu,  8 Apr 2021 06:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvXobF67fsmn; Thu,  8 Apr 2021 06:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECD16400D7;
	Thu,  8 Apr 2021 06:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7EE8C000B;
	Thu,  8 Apr 2021 06:36:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5163DC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BD34406A5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0clYS10GKSS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:36:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4E80406A0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D28Uf5GNuFk/NfyoNaBu2dSbm7ich2k9raTqjpa1K5vJi7PITRVJJ4gGpcBxaJSjJlLCw6+2pdnxHyRZJEBsUM2xUsh/PEVOM/sWbIcUWrElvu/NppGIC13r5AOpmBkQNLbLSqnhzN0vL2o7UZ3N16lmTtUm9QFZNN38+TmKtZAx9Vp7T5gQbSKClA1Z5NPQD8dEVWjwPDWHIVTMi+xVuuisD7nsT+GrAQ8TpGsOpnezwg0u1tcBTLYIX+PMFT8Z76tdhhyII2Mgv6WnIS7vEPwq+CN11asSJUDwQD169qWbwj/JfupGXRzRJtXRwJ/QjHn2zI6yscWr1aDBt1ZxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOYQDMM/211WeDWBV8HBK1MeQtcfuKOfYPV8dFJSjRw=;
 b=bYAa2PoIgiRevwwPrFFxOyRs2lKdleXParNjHpfYdTGGV/a8dM3LUlbBK4PCNlJsDSU7O8hBrVs9fK4WXXm1ZTr6CkSFhTsuL/uo4NuN1nr1yv326W/iX6T/d/deEPqJtrfFJ+g8hdkNV+5blJPq1JfuGhaAw0npqND+MtwysXVAbaP63w0NlaFuR/qcFZpOyjmV6nTdVRhcSdndCX1jc6TwSqBlxKyavwQ/mizbi22Bl7wWNrpzq+Km/hMwnae9KF0QWIuqNzEXRzehqkpavXbGf8QxpUsgR/QYc6jJzZ2lRWadj60SfX9hnRzJwgtZyM4W4GiyfSg3Oq/0BLh6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOYQDMM/211WeDWBV8HBK1MeQtcfuKOfYPV8dFJSjRw=;
 b=ED8iPVjCXRsw8Zte3Her22UUWWpxPEjZq8mu8E2p7x+dRhZ7hPjmOFE03KtjzYv1mWfPC6hmlFMh1JokO+PZH67KroyZPIzbna5ULVvTRNIOfTZngzWtLhwdsyLTTOwT0QCo2gN2KSr0M4GN7PqnJymSbALL0WRf2WsIpeEAcYwM82xwc4LrChrsG8CGolkJTZ+gaTkFruOyzbYDyIVB/w3AiiT9EAoYMSn2ItNpJ+jNUyxfp/vPuLhzuQbixiGfL/7vIhScb9osVjT6GJw6K0tlTP27nrGqA7e+ILhuhdFMhm5LDQ8yuLAkPZ/WIMzR/jvhO9dEFaxPxVGcJqH27Q==
Received: from DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 06:36:48 +0000
Received: from DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::4d1e:778d:d6ee:b2cc]) by DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::4d1e:778d:d6ee:b2cc%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 06:36:48 +0000
From: Parav Pandit <parav@nvidia.com>
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: update of MST's linux-next
Thread-Topic: update of MST's linux-next
Thread-Index: AQHXLECVCdcghg/OOk2pkQpqeQmhdKqqKWUA
Date: Thu, 8 Apr 2021 06:36:47 +0000
Message-ID: <DM6PR12MB43302B601B185AA04619642FDC749@DM6PR12MB4330.namprd12.prod.outlook.com>
References: <20210408062941.GA2383@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210408062941.GA2383@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d374e7-06a4-40ae-a89c-08d8fa58af73
x-ms-traffictypediagnostic: DM6PR12MB4140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41408DD00F437BEF95E588E7DC749@DM6PR12MB4140.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzSKtf/9JvcNBCkidFozOwTMdybhQybQ/27ElkOm6X7irqtAz8LtrAlvic/nw4cZ5qK6lHijLaSC9xOKOHd4on4gxSfkjZrprc0Yon3ArLQmlETHTGwpqK+A9a/h8uPwIWF7pkVBD9cSfIfjhSidNRb6ew7D90Q5HP9WcCFz7lA5uvsd1ywNxqrUY0DpG9GHwJZJyBoa9LcGzVKcIE295Uf4eVGt5p3Ugd1H2AMKIF1h+6VDZmfF9+N4Zg+8QpUhBUCzGXbVzVT2l9CGMsoh2jE+Qc6Oi4k9uSUNaF79o+rlnG5Z0w+RSglAikvIOLbciFgRD90FL2wOdlXR+d3Bx3FyCLbWjscsq/R/LqunvHgLXgGvMDRmiqZ/ZOR8jJJ4onMZr4oRlBZGXWIY8DNwJNb8kpi+zoGT0kPiCSMeVf5Nk1npnaNh4ch/1URhOiuctnVa+vlHABi0vULcMXrOi4KSV9QSqSJL9jtU5h7xyJNOS2iflKfZGVjBYQIGnJrzAfprpe2P5CGfldCF03tUJlIvs/Sa36ta+uh+RpmhzYXnYdoFj2+YCioVvmsR9P7KqkjPisfQFbmjRBCNdjMIm6YvamgRZnU2AkjVZyrOLMLDO/OahQ0RNYPYpjVxpkA40dtn+IKIIyjPB13lRYciXj4V4Ws15etW0ubbapwrT/Le1l7SSRfPuxp3u7+iX4SsOJfwgm62xK11s7gSEW1Q2sjoECnjGA3i7fksAgdQ2DA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(8936002)(7696005)(478600001)(966005)(83380400001)(5660300002)(9686003)(8676002)(55016002)(15650500001)(71200400001)(86362001)(33656002)(110136005)(66476007)(2906002)(6506007)(4744005)(64756008)(66556008)(66946007)(66446008)(38100700001)(316002)(76116006)(26005)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PHGKN1RbPJDKEqrZLqvjCuSO/KP5nFclQN+A1WC3HC5mF+yqDfRHNMVxJ9hk?=
 =?us-ascii?Q?QQQij3LBRTq3Ba5KUDYOUBuBAJXCNNGJhEZ/u3V50fUmoIPrR8Tq7Fipp//s?=
 =?us-ascii?Q?eUFa7pAFjVplDvIqYu5XtZCd/C16fDzslTYLxcIDJaXqcR3xnWKYbB+8CcXb?=
 =?us-ascii?Q?8TWxDI/im10Zk0monL4DrdRVTjbEmdi0D2Dg8DEyWWan3Fhy+BdJNyYDM5kI?=
 =?us-ascii?Q?igks+tIPgwid3fG+DeO47+Zz1T42b/KM/IUicKjN0+q3HGoafcDQu1JF516Q?=
 =?us-ascii?Q?PLDg/qU/zZSqakOwMPvM0OLw5RdyrS+3/+kZ4al+FKh7WyI78rvHRojhGqYo?=
 =?us-ascii?Q?H9jbvHQZQ630SHlchSLNiyD8VWo3QOCc5BEA7WvzUxiDyoFBCxBvbP/7hPwc?=
 =?us-ascii?Q?zOOXASikdK8/9qbiu7bFCLUhzG60ZnPMkjBhWGMFaEfHezRSkKM7kRiiaSTe?=
 =?us-ascii?Q?qYNYto1Cd03cqHnFgFqDrn1WqAWO6BCCEw6+SWLoBGZYQPHa2vB3WWpPbGto?=
 =?us-ascii?Q?rm6bqqjcKeHWXtGAuP5siv6Bpvk/ekWkMSz40K2VTGYGPWM8m3LHajiQxwP5?=
 =?us-ascii?Q?BenNNeJMV9QVlGKEnaAUvwYJwduXalr2S+NJyoVGuJcVM7F963zkJ/bH1i0L?=
 =?us-ascii?Q?LvUGHKIcR6mDrYWP35w/Omk+FAB51JVvQcgdAxHJXTh6dNSJm3zk+vROORk7?=
 =?us-ascii?Q?/WPNP1egeFuFp2+2ocvdgLZQZodsVyFPN06e5Dgjm+pkTgX/h3QnI3SFYy3H?=
 =?us-ascii?Q?sC2wpS1PPqNYXO8MHb2wg/2jZ5wwb7B6xhfoto7cKIJmTB7zNzfZBNCSa+4s?=
 =?us-ascii?Q?R/Eg9FY28GRYtaCOoS+eSrT/Tbt9g9NaT4pE/ducLT+FGDtX1ffaFESy5Ir4?=
 =?us-ascii?Q?B28BMxLGn452qe4q24mEey6dHJ8gpRWgOEukV3ulwM4ZrS0WxSz8LPJ60i+w?=
 =?us-ascii?Q?J/0GUZCiXbkIvvjl8r89iQRqnoLxCJy6kRAQF6R33wMTStQiNJXk0FHYoU7M?=
 =?us-ascii?Q?znhM4NSUFghXVJmMKivyTjesM5hdw5Jj1C3VzbnW5IQ0NdeX2FVj6d5QaBfv?=
 =?us-ascii?Q?U2bjP4bs1qPRjYr7uMexi96DKcMZ56aV0kSQbSGkJelQa28NxzqE02pjgU5n?=
 =?us-ascii?Q?Eb1E4+QBROgp6rEAOIPeOCzAf+sx9o8hOYVYWSmg+fmxHs4weR3mZzBXLwdv?=
 =?us-ascii?Q?AuaQwztyjh6eMdWD2ajRH1Vts9g8SwBU5WP7+z6yPtO7iKY+kU5tgSda9E9y?=
 =?us-ascii?Q?Uzum1OaDm8dWwPK8/Q0ZuxBmOGemEPT/F+HF/dYZYy8pNL/JVr1PJZ+cWtbf?=
 =?us-ascii?Q?voaai335EdkDLq2lev95aaVx?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d374e7-06a4-40ae-a89c-08d8fa58af73
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 06:36:47.8522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4Dx4/pNo0t37cbZxdva3yutLfZvr3NczSEkPsZeskqfFv2J2gTBb7i+DI7+ChvjjAJnRI7rkyoSdONmAMQ/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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

> From: Eli Cohen <elic@nvidia.com>
> Sent: Thursday, April 8, 2021 12:00 PM
> 
> Hi Michael,
> 
> can you please update your linux-next branch with bits from other
> subsystems? There are fixes that we need to send and rely on code from
> those trees.
Having vhost's linux-next upto date with [1] is best.

We at least need till commit [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c1ef1959b6fefe616ef3e7df832bf63dfbab9cf
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
