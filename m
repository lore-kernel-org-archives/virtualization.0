Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489C1C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:34:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D743E61078
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D743E61078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 986E482E14;
	Mon,  9 Aug 2021 07:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4f1wMwtZL-c; Mon,  9 Aug 2021 07:34:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CE8382B51;
	Mon,  9 Aug 2021 07:34:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC521C001A;
	Mon,  9 Aug 2021 07:33:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB592C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C65C840178
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8u-uBagnOHX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:33:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D158D4011F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlqJIcpzds52bxEfFY45TYAaHzU0xtkyOWXKy6Vmrp4B58GIfb/v81X31+0QP0hVedkFTe7I8LPSY6490m70QHj7E97g2qc8zqNTqNvM0KR9tml1XyCp3vQIS+5zVvHiGmr6H6Dk75Porm+gLQoNOckriU+n8K5birVplomTCiE3wCFoLk62lC4JhtsPzWx/IIW7kf7JcRoZdhMVMHDdBkajPaf8KYd7lKea238wvC94Y9yS/41TwCZwLuZsEL6mPkrB+g+enov9pHFsus5/HFrzVaOo6mRVH7U+h+LhuxajMTfrlpOGVNSSZ6jXgziSU6MEGZxDb8pw/KGW4STxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRj9CGJOOJH1lTi/SxkToxjXuHLBl6W/qOu+UWLm13A=;
 b=ntv1xJNPMOC0ciAC7TF5PAsc+AfJo5cjLW5qpiVtzSTL11VXtlW+wDJvNih4rsTM3nuoLfA4fmSK01xpkeXpIYAOT0FEiv/hneG4rQGbjQmU3RA2QlkQ1NnU4n/QXhdDOuCx135h4AwaxhGrgEA4iAtxP78n3XZaNfZ55lD1ifXXolwSW+51qZjX99w4qL8JOckqZpDHLka5WMTs2b1qmDOTPya8EPVk8Zr79Sp0f2ihOicfU0piPGszzmBDW0r49bbeNe+NDGMpZH5VSP7K3uznvHtXyE8iASJE2M7OkF/9apEXXOAg1yaiVCYG7ZrZIAWWYjZ1QgFVqGMaCLIhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRj9CGJOOJH1lTi/SxkToxjXuHLBl6W/qOu+UWLm13A=;
 b=n+nT2TJdScZRjjFo4SX7cgUSV12jQ4JnTuZe/nTgEVLyXUTHTzJeeLqxjDylAgeRKK0whDHum3F4gJaynDfSlg/jJw2cikM4HbUmN4EZLQE4qUZgOvb1PLYRdPOJH/NZ9XXeCSjdyv+hSouQfVGwOPpTGC5DksipXLeC0mBW08Q1ZLs6yvC92F/fPnX/v8juwKMgg4/d3GL5pch9AkGS54x+grbuLQ4cSWuf5TGZsg+h7ynn6fm6z6ySOp1bmBCQ8OhDvzc6fIyF9U1+pU+jji2UCzUoqUQ0DH6vXvuIxPiGptfz9rjiQ2bJxHTG1iKIXEdUr9ISnd1M6B7IFYB1CA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 07:33:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 07:33:56 +0000
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v3 0/4] virtio short improvements
Thread-Topic: [PATCH v3 0/4] virtio short improvements
Thread-Index: AQHXfjyEgkBpWMMsPk+MOQpth6qjnqtZajIggAe3oACACcLwcA==
Date: Mon, 9 Aug 2021 07:33:56 +0000
Message-ID: <PH0PR12MB54814E4657560159AB5910BEDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
 <PH0PR12MB54815548E4E659AE8A023702DCEB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54813F761DEA56B792B29E0EDCF09@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54813F761DEA56B792B29E0EDCF09@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31366eb7-927a-4001-d1d4-08d95b080b90
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5481E15BBCAEB2665B6123F4DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5Jp5JYK1l6W4DxhGXa0mirCCGntob1o0S5wmpiXF1hlBGrh0aj0DtcaK0rZwu5OP2ByrwcfHSP8HnaOllR/KK/eTz3x/yAgiFEtnsrr/cN/mEy7couM/IclzRpeDMuxN0aWZJTys5WRgQ1PHr24+UU/js0Nsn2D8Tc496caSsS5mkXJxtb612XIt2YxEVzqgs0BCBitVdiTWDeXs5XaKBz/C/BQRw/r0Q52SssVKjNRcn0DOsxj7k9oWb2x9n+0mg8a/AORq2qhlc8Ct1vxvkJL0vggNnAah98Jar+ZGs2Gkg8l3YrWfCpDJMKKxhzZXOa4lrWVj3AtjC9vVY7boUjHRkuPaUHmcPzXmXlUKxeCPWu3qkeU0acf4kVpU3KIDyvXgoK/eLXHASfXZcDKoRRad6YiYTSjo49+nZDV45CxQmGkeAKyXfAQpCDDc4AUaUJO4LSDNtCPWQ1rZ9wHxG3kkHfHaoBtBiWBgPMk1KMMUxk+RAc3EKW3QG5ea+4PQRFe6pClYhXorXlHfyX8uN+j19bpSYw4XUYHcoICTTzfbMDAjqBWuL4Kpj89xs+vtxR5TrNAcoOpSJlUyaD2KLAU03XLO0C2SxZqp6CqrSNLziYyG851UrMnXJEWLvAQhX0Gdm2nUuwRadXJ0PrzuPyYBcEx/nagicIQvokY7rS3HiUAz2cFJZrstj/fhuVtJHAIY0u6avwdnDJrKy0aBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(55236004)(5660300002)(52536014)(71200400001)(86362001)(6506007)(53546011)(7696005)(4326008)(478600001)(9686003)(186003)(55016002)(26005)(76116006)(8936002)(38100700002)(83380400001)(122000001)(64756008)(8676002)(2906002)(66946007)(66556008)(66446008)(33656002)(38070700005)(316002)(110136005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZSXZUbDjkr/ST68jxepdZ8UNvc0Jndw9s/vOXawhuOUMQvNaPwpB6F0ix9U4?=
 =?us-ascii?Q?u5RHCFXeAzr4iH3PaDPmQUb/1bavhlou00w63zBsS7TwLLYegI6gsNLvOI53?=
 =?us-ascii?Q?q75TcKS00cjxvLywDhXm4wjGmc0uP1gUfguZBamcUnNHPAJ27GSC8mdcrI0S?=
 =?us-ascii?Q?mN/D+bz+AgTBXdFMUbuP9zu0My+PLJ1bB4OeF2MAMXLqdAX4Hh794q/vQ9PX?=
 =?us-ascii?Q?N6SaFY2TMx+3qmjaReJT3MskLQMlpnQvSpKknOUdw6aKddTwub0kdLCgVXPi?=
 =?us-ascii?Q?vkuzdSC25oUtW92wB1WM3jNo+/okUiZAmypyZeTKWrsB5+sfOicoUFVLB3FS?=
 =?us-ascii?Q?KmwWWt5ngBItMNDC7/cc9Va5+KsHHLm62W2Vavxx4/KSIQjLMDFyQlRHBdqV?=
 =?us-ascii?Q?Ma+gb/wdLru0sXyceSDim4JCz7pBOt2CF2uFS3eARrOY21qcnfOfj01WEoyw?=
 =?us-ascii?Q?sBje9l+i99uevJ4beVuBBEDnAqv14LkIML3p/Rs7Rs8U0Ewe7/4duxOAEvCd?=
 =?us-ascii?Q?HGmSUkTQ6S85MEW4fJ2aP482sJgbmjVkXPE4Rl1JMB/nTxo/+BM4XgybRt1P?=
 =?us-ascii?Q?5Ebgk23okl0+OprC4Fd6Lr0VX5LrBivG+D+CO6rt18fcogQqHvzZ5eFk70Ot?=
 =?us-ascii?Q?7mmXv14xkglb2XlEuUUFPeICo06ww7qejNic6uBLnaOfxV2uKnoiHd+ma/eh?=
 =?us-ascii?Q?U6uHIT5968jJFMYB0Q6DX0+TkzgXdtdodLJZjI6KkjvNvPyw99AXaZeSEvSt?=
 =?us-ascii?Q?u8VVx3JzWWJN6VTnzcjbFltlCSZ8F1tg1oACb4mnbuoeQFQb5gXq4uqJW9z6?=
 =?us-ascii?Q?WjYPdm3OIqMZ5wOsW0qoMPmQTfrHNR47CQp+i0Q60ZPAr7srcO5I1DDYIP9c?=
 =?us-ascii?Q?fm0H0tcMAfisQxRu0Wrh7HEZ9YGkX0A9QRFoSVWovUfT6yMN/zLbMsLjSqxT?=
 =?us-ascii?Q?1tDd0iv4zu2etDFvZCK+hurupGLxRv7RHWIhjkgegYZOaD2GBOqFDj8xURLG?=
 =?us-ascii?Q?ZZCrpns0x+JOzmrEK0ioYJxvPg7Se8p/iHnjO668eJni8LNpusDf6PEUexd5?=
 =?us-ascii?Q?Z1YLEPOYA6QEcZMTNhQ7Q6dW++YvuekVMKImi56hvRMTtd5WhVJIbpD/UXwK?=
 =?us-ascii?Q?sXoVS5aleGGnEPqK5vgmYuBB0OclF/U5sas1Qk/zkSunOv9lzBFz0KH82T3s?=
 =?us-ascii?Q?q20WrKwDjey0IW7NQ8e1xzTokjYVZ1qwnAzJkW+7txnMz4pX+lHO5ur/gETi?=
 =?us-ascii?Q?NauTtCqKcokY9saEJJLyFkD6o2v/fquDymEBB/SVpQWYNWjSdRSvZEzYSrzB?=
 =?us-ascii?Q?92vfAyKi/7yv7jI52LXAGnSg?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31366eb7-927a-4001-d1d4-08d95b080b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 07:33:56.0327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rdw89C9PF9ho8MwlJLRZSfurOxxmmWzxq+2XHuT/JNfPd4per0INmbqP4rN843Ahy/oXoSAFygIo4G6N21mqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

> From: Virtualization <virtualization-bounces@lists.linux-foundation.org> On
> Behalf Of Parav Pandit via Virtualization
> Hi Michael,
> 
> > From: Parav Pandit
> > Sent: Thursday, July 29, 2021 10:09 AM
> >
> > Hi Michael,
> >
> > > From: Parav Pandit <parav@nvidia.com>
> > > Sent: Wednesday, July 21, 2021 7:57 PM
> > > To: mst@redhat.com; virtualization@lists.linux-foundation.org
> > > Cc: Parav Pandit <parav@nvidia.com>
> > > Subject: [PATCH v3 0/4] virtio short improvements
> > >
> > > Hi,
> > >
> > > This series contains small improvements for virtio pci driver.
> > > The main idea is to support surprise removal of virtio pci device
> > > when the driver is already loaded. Future patches will further
> > > improve other areas of hotplug.
> > >
> > > Patches 1 to 3 prepare the code to handle surprise removal by
> > > marking the device as broken in patch-4.
> > >
> > > Patch summary:
> > > patch-1: ensures that compiler optimization doesn't occur on vq->broken
> > >          flag
> > > patch-2: maintains the mirror sequence on VQ delete and VQ create
> > > patch-3: protects vqs list for simultaneous access from reader and a
> > > writer
> > > patch-4: handles surprise removal of virtio pci device which avoids
> > >          call trace and system lockup
> > >
> > Any comments to address or will you please take this short series?
> >
> 
> Can we please proceed with these series?

We want users to stop facing the call trace and lockup.
Can you please respond to this short series?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
