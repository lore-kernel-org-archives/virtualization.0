Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD562C433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 15:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 722678100C;
	Mon, 22 Nov 2021 15:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohNFXtaNAXwM; Mon, 22 Nov 2021 15:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E2638104C;
	Mon, 22 Nov 2021 15:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3BECC001E;
	Mon, 22 Nov 2021 15:56:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD8D4C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 15:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B43B8104C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 15:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_D5x2y4Gy6b
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 15:56:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B420D8100C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 15:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMxIsL74bwZmN6Valuz5brLXzFj6feL8Wlu2q2sSbWd2x6dRQvGW595iuGzFMT53hOoDH1xjKk8GPcW+RQDMRGZhMCrsiq5soQCPXl606GdAX7hKy7UTM28pDz/OOx+JnTX0Kv4iwmbcZgzJ7k8stSUDTi35iV2D6bLy9ScPtG/KM7DFPBRbUPWoLisvNkObBicFowkcjNEZMMhLC/DTirIHgF+WYRdZ7/G9wcg/tZEqTTWgF//St+47SzkfmuTvwUaP8sm9kw+O/oUUgYklAVQkw89qDi1PhiIsmrLM7pkbsGUsgT6K/OHUcI/ds7i69SpTo9aTN6vLChhAubQaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxq1JkPf4ogcyOT6QB2G4m9aa3raf0yIZL9iAvY788M=;
 b=jxoCncwcl7Jf3HSoUf5BzVlD3ihof5G0yx11yMXXPemFWs2kmbmudEPw61sTL8M7kWXuzWTpqu2m9Ikh/isLtfJHteG7w1K8zLI/iH28h/AIyGi8ZEbEYQEEJW9yvMBRuFeeA1JCzWtfqJRFWHUf/Gfp5J/nO3H2Z6Zvu6/HA53N7qi7rkz8X5LlgoYEqnV1EMHoy8SEbcDYYAwEZrQXJWm4taLzlGDQ1u4kASWhn4XH5nxZ+BXpO7icheAFNsnrYlbuBREQ8DR3vsstLdEIxgFjJnynp3bF6APB7MvT1D0ot82jYsb9z2T+28+eg5wulizw741DhqSl6Wcpk7zd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxq1JkPf4ogcyOT6QB2G4m9aa3raf0yIZL9iAvY788M=;
 b=Od7bBlz8vTkts/2tc2Th89mG0g2YkS9mae1XYRWoZNbw3NLjxf+SpX3EQW355Sq/zUFR+wGHAq0Lo11IFBFWlQHKxVZResgqhbyazD9XDtFJJMkaCGQQCrAh3xMy1p2f1F/flboA2o0HH21VoaDg4K71VJLlbvFmgDUMgTXHrqR6oRHZOx++fgd0OuldKY4PKFCJuledf7KW1BaiVgSHMvR7BflfXR0WEocotdkO+6um+oDMP8G1hqpR+OdEGOlu1H+rdF3e8+tRm+9+b0l9wOu9HFtxVMU0FgjKX4tEJqHX6EWeAwWUnuBU0IQf/UTRcy0+OuuRtyl66iWUpVftaw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 15:56:26 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Mon, 22 Nov 2021
 15:56:26 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Topic: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Index: AQHX3EFM7M5U7I8roEu6kosjxQg7cKwKJX8AgAAE5hCABK7YAIAAWxmAgAADHQCAABDpgIAABq2AgAALlDCAAFIXAIAADOmA
Date: Mon, 22 Nov 2021 15:56:26 +0000
Message-ID: <PH0PR12MB548193CA4DE7965673AAC3F7DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
 <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
 <PH0PR12MB548147E2266D0A8D7B1951F1DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211122150704.GA88466@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211122150704.GA88466@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6296f16d-5aec-4705-087b-08d9add0a3f2
x-ms-traffictypediagnostic: PH0PR12MB5419:
x-microsoft-antispam-prvs: <PH0PR12MB5419B1493FC865D1CA59A035DC9F9@PH0PR12MB5419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkNpebOMFfeAcMNIHMuPYqKFhN/aKMi45ULxaJa8pfcaYLT1Uk3M//Fc1qk3hacByeE5LuEzNqHZ2UyjO1kVgI5aHqywmDL+A+GL9aVB+UYBrkI3e/5WiRm8cttynOrsSfEahYg0Ei8reKCWIeO3KTv7z+lQELQSqVPrDpdTE7Ef6oe16lIgc09SKUdKDAGPThKMJol08STE/J2NCpSlw7AAKFGolWS+HiHV4OihI8uaozyPnachfBl5LNsTdzGHpIEE8gD8Yw7Z6mRMB7b2ccsTJe+XvIPxGhNnTKOy46sRRk2XcdOEOxF+73prkKRxHSWbeocN7E3hsx6VH1KdUC96afBE926D5MbI4q3Wy47c7oUqFkGqgoZE1F+8KwwS5DWl4xO+bx0TZU33fB2/awN67KVXok3QQGV6ug14oVRHB0V83/4rAPov/TWARz+NQGe2VjuxgWUgQVoUbjXqa1RN6NPgog9mfHZeNCVA4vOv7VQhFAjJ8YsG5bHcSr7hHI6EzX/j3pa6xDcdEO/pxBskFDtx3GwnCG65dFrdfgntwVoX1sH17mU6p8IaCJibHyt0ojIbx8oFG4vbBmqX3SS3/GEvFny42vV4X7AHqcdtB3uAQB8WaP5aPExJ8eAIii109qMl5ZdAOcFoJE5wZA/e7CorrhcW4q6vEbjbW3TxrKBMnsG9Yo47tcVnLztH8UCZQT9RYXJGtKmgZgFcjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(7696005)(71200400001)(8936002)(6506007)(55236004)(186003)(86362001)(52536014)(26005)(508600001)(38070700005)(5660300002)(6636002)(38100700002)(66476007)(4326008)(66946007)(76116006)(64756008)(66446008)(122000001)(66556008)(6862004)(54906003)(9686003)(33656002)(55016002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JdQrXJzWOYWOSP7PVnAC1jvzo6Qo2L2et4J7ECLE/OW6CNNnX3Fsv7CWy0Um?=
 =?us-ascii?Q?kPUHCunb/75GdfJiGEO+qehhqUEmRmBdSCROWMKYZ1aOm8hfbzdHKV80DfoW?=
 =?us-ascii?Q?rf2uzNSIht3j9/3/7j3UL11qZJIZ/xvxeE9vbTskMeTgbA9Ww1ynYWSxlZ4N?=
 =?us-ascii?Q?k68om79m25Jx47n4ok2B9CAoD6nD8XZS85r9QN4CP3hA/qMAgDO332xCsCsB?=
 =?us-ascii?Q?JhlnziNW/0P4mwxbNKziXKwf8GQSmI12ST8KymevlaOjM3c4lQdZCqWFdzcm?=
 =?us-ascii?Q?ogeBax3JRnNj0AJL04YlshrjrcFCI0icW1JDYKUU5/pHbtUuxR4vsdiOxqRU?=
 =?us-ascii?Q?+gJGN5T7jfoSmb2RhMyh5vxC5FoVDcO76siwRjGkY4Hse1NSHRItFJkaHaMF?=
 =?us-ascii?Q?7pd6XQmiMCAhaLF1JgGGkM7NZTGyiYNc8W5OMNKuASuFCJBe7EDDmzroaUs1?=
 =?us-ascii?Q?L98384ELQO3Ee7pKxhjl3vOjI5PwI2UD16FV5munD2qRoe86ahCfVCwrqW3h?=
 =?us-ascii?Q?f0L7lNdSoWsIngeO5NCdbfnAzIyrnlUt7hDf/KXyTju8laZfMJU2cZUe/Hey?=
 =?us-ascii?Q?IFf55p5l2Qb3P/PXLPcjFzjIlOr7duAXmQcgY9cVNkJ6J1/WeoYKQD+5k9fb?=
 =?us-ascii?Q?/dTgXjALAZsHcYI9eV4tUqWxoVsgUiNPSQhDspnX4Q/fQ7XIk1JyE43BwGOF?=
 =?us-ascii?Q?FXVMyYRXi9vPyAy+b5GEvW8V+XeVWm1D211jvUjE2ZIEyaNOm4LO592QU6gV?=
 =?us-ascii?Q?UAQjwr5GRkAtvFygokWkCGWr/I9cn0efEuocjdLwjqOBfbH3M/yiY++3PTNV?=
 =?us-ascii?Q?TclyZesyDdLF5ZGEipZknXPafRe/opkBJXU4CkIAnLKJG9Fy2ZRsjXc4Qt/m?=
 =?us-ascii?Q?TlpEcudJ+7cu/hi8tjqpCBkCNEDThJ7+Is6zDx0Ep+QtQb4PSr6kJfA+PLPk?=
 =?us-ascii?Q?zQwbCNfML5ZmcPgbmeRtoyISi9jAfrY8yzTXwsJIkXBK9HoVQCwKNmBKBpuS?=
 =?us-ascii?Q?vmLYhMmh5c7yf/HjT/0Wew9v5Mxa7fwsTAIs57ZTOoU18Un7DWUTPgSeCNrv?=
 =?us-ascii?Q?AN1/1nIwQdYMM0dcVleC9p0r6k1uu9jIX6iUZVrOFJYMwjFrZDLPL0uVmE7N?=
 =?us-ascii?Q?6wWOsg8FMk/7GYvvns+zlj9fgMPQKypa3lrCBzblKqcD9F6jrZM3Otjfvr/7?=
 =?us-ascii?Q?zanS8/dE5pLmsDr5fipv+Tb0DB9DEBveTsKB/sQ6iUmLyncaKZF99lf63Svk?=
 =?us-ascii?Q?GLe7ffXOmaipq2tTszK7DhEF9NJjveK6Q09AZcoLO62TpeK+A3XA7ctT+9wQ?=
 =?us-ascii?Q?Y7BH3hG5+LiduUJIV/Sv3smDduwJ2+vqL0ti3Hp92snlmewg/mP/I95Ltecl?=
 =?us-ascii?Q?1jz1f0EYNB620SjF0IbAHouDs7oVKwTzelImLhVChf2DFEu3CI+WfKlIaS/a?=
 =?us-ascii?Q?PMmjm5p2zcnTDZDRp1l+FZjzmuoQvz2bkeGTG9uWZqjUDTFuCCb2zHicNGVs?=
 =?us-ascii?Q?8A39/iwTqQIh260HNBjahoQmla2nzu6+mMfZ265fYK/CkQ7QmKVhUz8l83Y1?=
 =?us-ascii?Q?oh6eR5+8OyvIkVn4xVC6xKcxerr7s3v3PpomAWLfG/ig3D+5Q7e1Yz4Bxxau?=
 =?us-ascii?Q?Z/FNx8svhtwO4Ad+KiZV5dU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6296f16d-5aec-4705-087b-08d9add0a3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 15:56:26.4488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pUMMeC2VTpybvxFfWko9oUmCVONw8JmPT6s73y7jZcPfSJWJGxmEGptJ53WF0eOeEmXbHsCVMgWAvDQGvY89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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



> From: Eli Cohen <elic@nvidia.com>
> Sent: Monday, November 22, 2021 8:37 PM
> 
> On Mon, Nov 22, 2021 at 12:15:36PM +0200, Parav Pandit wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Monday, November 22, 2021 3:02 PM
> > >
> > > > If we go with vendor stats, how can we communicate the information
> > > > to userspace? Currenlty we use netlink attributes defined to pass
> > > > this information.
> > >
> > > It can be done exactly as what have been done in the patch, we can
> > > document it as vendor stats.
> > >
> > Yes, attribute to have VENDOR_ prefix in it.
> > >
> > > Ok, I think I get you. So I wonder if it's more useful to use device
> > > specific counters. For networking, it could be packets send/received etc.
> >
> > Yes, I equally discussed this previously with Eli as its more meaningful for end
> users.
> > We just return the device id of it along with queue number that helps to show
> tx and rx.
> > For ctrl q, it is just ctrl commands and ctrl completions.
> 
> I don't think we should mix send/receive packets for descriptors statistics. The
> hardware could process a descriptor and still not transmit any packet.
> 
> We can add packets send/recv but descriptor statistics have their own value.
> 
Oh right. I read Jason's comment of _packets_ to fast. I meant to say send/receive descriptors.
I guess you already named them as tx and rx. Didn't review the patches in this series yet.

> To summarize, I can add the VENDOR_ preifx to the attibutes and re-send or is
> there anything else you think should change?
VENDOR_ prefix and command as iproute2 command as "vstats" looks fine to me.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
