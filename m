Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A00EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 11:43:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B477E60F4F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 11:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B477E60F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DCFC80D04;
	Mon, 25 Oct 2021 11:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYjX1s1uyNBP; Mon, 25 Oct 2021 11:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2ED4280DF6;
	Mon, 25 Oct 2021 11:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC3FC0012;
	Mon, 25 Oct 2021 11:43:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B2ECC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39B79403CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XjrY0A76ZWZr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:43:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::621])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60664403C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA9oQj5FXb8qgX5dow0JG0O1aSoEHg9DX/pHMcEWhtuiK6tQBfJKqvJI+KiyfWxSClXC/TXmU5dVfxDpv4CgmUIfRARFVZGjDs2hIG2kzuNhmIjgel5BO3hdvOqoSZcVtfxFsAY0WEbXHXXjHFdqBsDv4LIa83c/1wTbui43lMU7S/a+2OFUNL8a4MrxTqeU8yBvzztCqFFz18YpLtMsfryhz/XNtc4tw2zz3r+Npk8lMjN+NXnR8D/eJuVx7uShgq+21v3TZOHs14YsW+RFPKcmGbnAhc23qzrmM5JYZSdHG19oHADmZhgNiqGsn0M5rxbFg8Q9dN5n3QXavLrUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVjf1KfmamSw7BwoLk2AEpIP4eK72oc4+h8TC1DNDsM=;
 b=hMW+xUaToySzD3MxDtgm35MKkznAJfvFp6rNKiUCgxIpMvDvuKJ6tZnjH+NdnZQ77f2x3jpE2HtfXfWQJrgebhBs4noyhuBfq7AklXW6+61+LqfryhAmSPvFTp8SRhtt5btgAdZ3rkxBOOWw8QrPrZUefCRcjMaFTUZLAaDmTLSB5v6T2wCOWhX6aTfKVMxSHxgfMAlmgEigwzz4G4PTZPL4yzRhjU6RDAK7qEis1i2RY/+4HK8UrqT07xZyMJX+muBVIZPC7+FLmb+BbX8W3XYM81F5cRA9z+zUoVVqrcCdlbQSPmo7WcYB/AkOJ1CqDSxD9xDkcz7J5egw8Oh05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVjf1KfmamSw7BwoLk2AEpIP4eK72oc4+h8TC1DNDsM=;
 b=fDzXzFFuUfGVaiH86TNJUvqoItwG+ft1KuOue5N2oZKJvNzpXSY6EyhEZDR+w12235reMrJTUUyvsbbnZUn4M1yK/Q4sebuwjou3e9njgRPA+IIG1GF1HMDstWjdIjcv+KIRFL+PW1dELtPZ3bM+mUk5PR+zDYfp8Rc2Z/Ne5CHWmayh+9m2UgTxt/wsFEw449WofacvnplL/sskoYyAEdXu6r1KE05sBAr1D3i/lBb8RTg5MFTttdF/AgcFfHqwE28Q7NoXFSPK1S6x9QsrRhayCC77qawAbk52lSpnJZkVF4EnCoeucitWR7aHiV+XHpw1S1iFI+iUV7RVu5HADw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 11:43:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 11:43:16 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXxpmyR8cFa1w650eZ8wWHy5IdYKvjP4OAgABdb4A=
Date: Mon, 25 Oct 2021 11:43:16 +0000
Message-ID: <PH0PR12MB5481A041D8FEAEA2AD1F9A37DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-3-parav@nvidia.com>
 <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
In-Reply-To: <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae6d5f41-e3ed-47e7-8598-08d997aca23b
x-ms-traffictypediagnostic: PH0PR12MB5451:
x-microsoft-antispam-prvs: <PH0PR12MB5451E4E5B1A5504F3763FAD4DC839@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQGs5tkzDF14uDGhOyl/y8zlevN62n6NbaSJK2iO5PjDqmZysKsHemQ6MM8PygDB3FjIqRuc7B6eSVbKrC00nOYgAho6SsAuSHkAvUbfywNDm01tjXb9v/yGlFw+k43rjf/7aJoF46WNgZK7qB08BAfkZAssZFjYlZ/TL16/2FJU4vlAQvnGQCb9xgwrJLmNVmH+S5smvktJgiK/ziUVntK1wgFOJe+rc99e82PD0J1W9/LKvDCgzBoOHMb/DvlGSN25uFhMVz3vsXhoJ1+FqBALLnRV0rpHZRwwGm/tuqshojSVvFu1OZXPj9Rhu0RqvSbljY+RBTwYNKf5r4ilIjJeETg6+4VCzrsr85od/BS98arcmrxuJLBkuL0QTtCNiu7tAwcIYznJkywkL6nMOpLsA2iX3gah45D1jkidpFCd6tNeCDozCCILOt/OhK48dCwGA/qpIWqqLPxzuPZhi2uRmHocviiM3xzZWr5tneWJs3pxRL4ZNfYwqYEvoPhVIsxF1XBBc+RzsAOh7OszUG5LYZBVEltTB4X+x5YQr/mwvLQhgPF356zlBaLB7DcFwwuQUlqj2rBiVSD2v/3s4C6gyec9TwRRD6xgi3DZV6SekFQ/h1p7UVAvCDpxc5gKh1Mx0klNFE3BdJFAgL40QZTZ3WLWhirACit/aGWOd5DHzWSVYDIjC9WWCGiCh3/qbLd23rFtwqY1AY5XGdRwGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(107886003)(508600001)(8936002)(38070700005)(4326008)(33656002)(316002)(9686003)(2906002)(8676002)(55016002)(54906003)(86362001)(52536014)(4744005)(122000001)(64756008)(66946007)(38100700002)(71200400001)(66476007)(66446008)(7696005)(26005)(186003)(66556008)(5660300002)(110136005)(76116006)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?em9ObzNnWkNFdzFjUk1QMmtJT1cydVJaU0lhRmNVdVVMbnNRZ1ZlOWdW?=
 =?iso-2022-jp?B?bVVHcHF6RjIvTWRjSG50eXhHSGtkNkxjMGhYelA1NkNKUzZzK0ppTis2?=
 =?iso-2022-jp?B?ZUR0QUNkbHdHQWwrZTlrVXBHa0RuTFozSjF1UE4ydnBJaXYxVGZNaTlB?=
 =?iso-2022-jp?B?YVdrLzhVZnZmempmc2YvVmtDOVpQcEJ3dDRIbTFuWlFqUVJ0Zk5qQytL?=
 =?iso-2022-jp?B?a0ZHL05BNXpSSTVpVmxwV25tUFhXUVhTS1U2aEJkZFNQdlRnQVFjNXBS?=
 =?iso-2022-jp?B?MjFES1lOWjFlK0hCTWtuc2Q2K3Q0TlcyMWZKaE53TzdJVjdRc29ZeXlG?=
 =?iso-2022-jp?B?cGRzZFR1WTdmQXlSVVRZVkUwWXRQZVdBWk50aWpJUkV1Q2ozOHE1TEU0?=
 =?iso-2022-jp?B?WlYzcTd1c0xpazByZjlXQ2lyTENTcXdna0RIcFU1Nk1Pcnl0OWN1bG16?=
 =?iso-2022-jp?B?OHhSakcxMDR4LzB0T2NvS1FVUmZ5QlR2ZU90Nnd2Wkw2ZlRHNUpySUVw?=
 =?iso-2022-jp?B?aFFqa1Z4bXV6bDJzcktBb2NORURLVWd3SVNKTTlSeGxqL2pTYTRwOEN5?=
 =?iso-2022-jp?B?cHRIWVNwWnF3WHZQVE8vMVR1S015aWtHWW83TXV4Q1BwZ2FzblhJd0ZJ?=
 =?iso-2022-jp?B?Ym90STBqb0F5U0dwVXZrZWtXN2pHSVZ2dTcvcGlZNVIzNUNUT2xnYXhI?=
 =?iso-2022-jp?B?WXZidFdYZlpYaGk3YkM1VlJhQnpXYkhObzFHZHZtVGIzMXZpMEFXdGEx?=
 =?iso-2022-jp?B?NlBTR0p6amI0S2szY0daSHRNck9WSlFQb0RHWWJHbG43WG9VL0VYeFZX?=
 =?iso-2022-jp?B?a2xHQW40bkRYLy9VYTYxcERleUpVb0lzRExWeG5FdUJVbWV0M0Y5aGRW?=
 =?iso-2022-jp?B?L21FdnVvZ29MaXJCaG9GOElxZEh1Vk1UMmR6SERjcnFKR0hXTTVHTDNX?=
 =?iso-2022-jp?B?UElFSHpvV3BZTmR2UlFMYUdlNEtsTHJJV3ZvOFp4MVNKcHF0MDVDU2xQ?=
 =?iso-2022-jp?B?SW5BQkhaRVJpL1pZd2VSazFTcEdxZnVwM1JraFYwbUc3cVFJdWpsdHE4?=
 =?iso-2022-jp?B?Yzhaa0F5K2ZaRmF6VHg1c0hYUzRKK0d4WS9OUVJvWUpWQlpZVnB3bVpK?=
 =?iso-2022-jp?B?N0VhKytzd1daMVF0NjdPblVaSXN3QkJ3Y1lmOXhLNG9iaHpHWDBSb2VF?=
 =?iso-2022-jp?B?RFpKVE1TMDY3UGNicDl5WWREWlhaYWdlcmxPajB4MnE1cGdaZkVWcEsy?=
 =?iso-2022-jp?B?YlF6bEJpUjZWQVZCc2hmN3h6Um1xTDViNWhZc2MvMWtmcVQ3NUZQbFJw?=
 =?iso-2022-jp?B?azZIMXpRY2ExcXhrSGJLR0NyOGhtYjlkelk0d0dhTlN6Q05xa3J4Ym9y?=
 =?iso-2022-jp?B?Y0lhUVhudTF3Nm9yc1NoTytPU0FiTjBJdkZyYWhxbVZxQUt1cnA0a0Za?=
 =?iso-2022-jp?B?U3MreitOcnEvNGdhSnNQbVNYMG92UkxOYVZoOURwc2JNazVaODdKVG9V?=
 =?iso-2022-jp?B?blpibHg3dFRpUkZRcHdUS3UySXgyNmVhUmhlU00wSGxGYXVWSlB3enRN?=
 =?iso-2022-jp?B?TE01MzJyUkF1TnlnMWZ2RFQzNzdIQi8rVWg2K3Q1MlJsbzRHbFNaZFEr?=
 =?iso-2022-jp?B?S0o1Rit0U0lxbXpuTVRhS2RTby9EQ2s2eEhZa0VOUjQvTjQ2SXYrRnY4?=
 =?iso-2022-jp?B?TEloSExpUzlsbUVSSEdoRjhOcU45Q01nZVd3bVRUSGtnUVNoMCttZXV3?=
 =?iso-2022-jp?B?UUQ1RUorRzBCL01YU3lkcFJRQ0hGaHV4bS9tQmVtREdPeVdRdThzOUV1?=
 =?iso-2022-jp?B?QlpmYTZwOU5WSWNVclMxZHB2M0QyUGc5ZFpvOGpWWFR1K0hsTGFwNzlT?=
 =?iso-2022-jp?B?QkJiZDBTalRqTmtSVkp5enhyZVZNT0xRTUZ2NUJZRHdqZWZLL0VLbVhp?=
 =?iso-2022-jp?B?ZG1yNnNsb1ZwTUhtaUpCdFl6UzBSZUp2cjMvdXowTWJ3QnVRemJOQVFo?=
 =?iso-2022-jp?B?MGRrVlVZUFQ0SXFRMUY0OFRycHNiSDdiendoSmduWEJscC9oNXhpalNW?=
 =?iso-2022-jp?B?WS8vZlZDZ2M1VURIMlVTeUJ0WHl4d3JuaE51M1dldjRkUmVLa0c1cDIr?=
 =?iso-2022-jp?B?VU9OWHF4TG5VaVUrSnZ5K1hrdU5LUGllQzl5Qm9RQ2YwM2FBbENqRExY?=
 =?iso-2022-jp?B?MDVEK3g3OXNYR2ZPYjZpTXQ3ZTdiNXZaTWtCcmpMOUs2a0wvMEVFanlJ?=
 =?iso-2022-jp?B?RE5nQU5LRERXc2IybHgzWDdRd296OFJrVFlMNFg3RnJxWUg5Y0k1ZFJB?=
 =?iso-2022-jp?B?SzBoY25IYlREUDNyZXlXWmcvcDhQWHJxQnlJL2pxS1dlRDlVUWVBWE1z?=
 =?iso-2022-jp?B?NG1ibHc9?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6d5f41-e3ed-47e7-8598-08d997aca23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 11:43:16.0390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdRCGHOl65r+Zm5ws84ThMzytBJcZv6NGAcHnPz0b62v5kHaGrX6gIv5jYxxKbVP7Yw75/84uZV8RPx4dnPOYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, October 25, 2021 11:36 AM
> 
> 在 2021/10/22 上午12:35, Parav Pandit 写道:
> > Introduce a command to query a device config layout.
> >
> > An example query of network vdpa device:
> >
> > $ vdpa dev add name bar mgmtdev vdpasim_net
> >
> > $ vdpa dev config show
> > bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500
> 
> 
> Nit: it looks to me this patch doesn't expose link_announce but
> max_virtqueue_pairs.
> 
> Other looks good.

I recollect now when started working on v5.
Above commit log example is correct. Max_virtqueue_pairs is not exposed for the vdpa device as this field in the config space is not valid.
It is not valid because this vdpa net device is single queue.
So this commit log is accurate.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
