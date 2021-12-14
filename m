Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 06:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 775F460B74;
	Tue, 14 Dec 2021 06:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_meD4JMOXw0; Tue, 14 Dec 2021 06:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28E4B60AFD;
	Tue, 14 Dec 2021 06:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0C18C002F;
	Tue, 14 Dec 2021 06:40:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA44FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D30E460B69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3391ssqTGuxx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:40:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E587260AFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSX+18FFg3Fm3tBc4sKlafqoTmUfm93cmT8+SZwFKWWf49WhxwIUaNDqhK7QPSxyCnFDUNv+7EiZvUauT9fIqMPGAm5Q5cMYHmG99ezmEpURrOD1hOwjfqiGV9kTTeUgTZuLMpH9c79g1AyIud8avOcOBFEgx8CZP+LevJpUN7/vvv9nTE7DP5JbVxPWHfGT1vRfN0SPsbU5NSgPk2XskLz1va6V4YZgqTietAB/6ZZ9ig5b+ItScPtPc+gyTV/pze5eiN9mmOhLH/aOs/wjJpds6qQgLLBQqLnINHqSNTUPYPhOvbBK2pkYCAEu1JJoaZIdyT55UiLK/PrwI0I5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChpEb++teubXdB2t/jCL7tLnS0P0DbQU+V5trSm/vmQ=;
 b=gBbM95X8Yc6Kk8fcSpoIRChK2WvH32BzzjCKo/yhbUOuhFomYvFnxFsexONR36Amnuti5v55pn+y3MP54mWx7Fw33LQThv6mjodKw1HJdOu+AqSwD4DL84KvaUIytCUKQJB7+30tuFrlafczaHLB8kKZnysATq7Bt2/puuESjxCyG6+lKJrS45sU5RPtr/HWahOjx6KlqUOMwac00Gz42oaCesfgkgw5Ivad1shwNKoTg6aleWSb1gBzhqVufWqCl0NI6k0xEszmnqBcOR/PAaKYbr0QMvSg4QkHomayZVz1lU30J9SxkbP0zLQ6qXwC6SFBE+qs7EvdDRlNGOQ2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChpEb++teubXdB2t/jCL7tLnS0P0DbQU+V5trSm/vmQ=;
 b=Ax6u7U26wiyo3D5HQpt8+cnDogvsH9rVkGm39u7TLYwQgzwBx7zZdsveej775AVCdlpRGUo92mNq1zLD19uO6RlfSMNIMUEg3ZhmT1FmkvEJd4qUBbubvdtJk323te/HigBNuAYufx1PV1jhBZGCAtgHwboin94koOVOp2S9cPu/MvsCJLtQbW+TeyjAbYKD7+18F/SNwk3gB+3frT/b4w6NKj68h3EJMJpiKp3hSrXLjjli0Kj2HcwZXYsCZjrh7Su2Air8RUmd7GI+nSw3nWYQ105TxAFPmNB8ovJrr+TFTqrsz/coPo0F8mj2jxcUpJnKYvabe+zUbeTd7SS0dQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 06:40:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 06:40:08 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Thread-Topic: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Thread-Index: AQHX8C/UxE4d/Kdx8E29CbnOstyc5awxUb0AgAAO31CAACNrgIAABhjg
Date: Tue, 14 Dec 2021 06:40:08 +0000
Message-ID: <PH0PR12MB5481A9FBAC299992E23B7B90DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
 <PH0PR12MB5481B9C349742AE1E4D9F4C7DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuscm=BkWo9FpL-SWph_vMBGegTnKoyyqxUepqnbTFzZQ@mail.gmail.com>
In-Reply-To: <CACGkMEuscm=BkWo9FpL-SWph_vMBGegTnKoyyqxUepqnbTFzZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fba95e2-57ff-4f80-aeae-08d9becc9243
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5500C94432DD4B1C781679ADDC759@PH0PR12MB5500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwL1HZr1GONGM7ECwUKQZWsgF0I67NQeGQHQYIJfCO9GFArDBs45FF1ISL4L5mxD6WPDF8leLm31fz3UBbHb7bFCRlc/IsPd+co51D943TJzeAhn04bbaOA5ICrW/xhqeGaI/353bCtlNGmwFhgGr8tSoVikur1Fj876o1Nqsshl8aaRx4oJCiLJUt/Ji5TUNaY264FuzsoxCecB1Ynn9b3cSRN3X0bCY51wk4IWbVj1TdxXP8jOjO6P/uW8HA86Nq0OaxjjJELzZOCS5S64BvstlA1L6NNFQde3+KP8BuGQCtey91uOqrmHbBspkbtkkjaFtY8HjXjyVhgJ7Qz260bYME28IRJwec9yhm5W0a+kfILck2veqEzDnegoYOGc1otjH3LWh1eT7L4HHGVZn1X5VEID+SEchOzIw2IeUwZdwCXHYkGGHCbhG+/ubI0j/ad6wF97LykPb8m+PyHiQv0hyQDJA4eHeAO6iIr9Qixzl6ozHrBU8xWSKbQTOB1CosJ1uqdaYLIItwi1A9uy/bUfnVnNdPtweEjyZDOs6ZVi3vPrFi3qp2d6h7drFygINrw6PJOkkqls36BlzFHLmMO/pXEw7VwL0JLDjKNyZjNiGeo35HxQCs05m1Aog2fegwt1Hr6to1IY3QnEIrbGkI8+Rgzp9FXcWk09KIHBUidvT6HDxPApuaFZDBYAnqQsz91i170HjiGIrkwqaQEMYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(38100700002)(66556008)(66476007)(64756008)(316002)(71200400001)(508600001)(186003)(66946007)(52536014)(76116006)(83380400001)(86362001)(38070700005)(6916009)(33656002)(9686003)(54906003)(2906002)(4326008)(53546011)(8936002)(26005)(6506007)(7696005)(55016003)(5660300002)(8676002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NLVlpzMWhvb2xVU2hLbFE5N2FVS2hXUDFvNTJVT2Z0N1M1RVJpN0ZlWjdt?=
 =?utf-8?B?QjBuL1NRRHVORy8zaCs2SW5iNEFwUENFYVV1L3pOcFZVQzZXaGpFcnF3NTVI?=
 =?utf-8?B?TVNlQkVBWkt3aVF4R2JEQjloQ0RoZFUxc3p4UFIxaWRDS3dGMXNUNDlpVWxn?=
 =?utf-8?B?V2tjaWlwaml6MVM5enNjMDBPemZFelh3RnJ0cWp2QUUyNkM3ODdUcXMvSGhC?=
 =?utf-8?B?Njc0Wmc4M2d0T0h3RDUzVXBhMWJra3JpVGdPRDA0a1RlelF3b0lpd3J6aVRQ?=
 =?utf-8?B?clI3eUZ3TDZ3VWpDZVptVUFndTRyYWovdStLZFMwcmhQZ2xqbjJxQ09tdWQv?=
 =?utf-8?B?bjQzWkxzc09USm11OHRjWVZPSUdpVlZOQmtuVjJ4UVk0RitpSEgxTzdndmp2?=
 =?utf-8?B?aW80ZTF2emJEbW9nZnRJWDlZYTBqS0l1NzY3QWhwaXRXQVFFZVhjcHBEVkpC?=
 =?utf-8?B?Q1g3akNPcEVxMkZ0Q1hzRHIyWG5tR1BnK3ZyOWdOUmxUN01tb2Z4NGoxdVZV?=
 =?utf-8?B?cjdFSndlWWIyVk5lRVZ1MnhLcGRWOWtyY09kQW41ZnJGWUNGWmEyZVlScTEz?=
 =?utf-8?B?YUg0ZU52Rml2Wjd1TEp0UVNlTzRrR05OTVhIMjhDNHptbkFGVkN4dWNmbi9h?=
 =?utf-8?B?bWJERWtNeU9ZbGp6YjZTRHVRZ3hpUEd2Y3I0cGJUUlVJaVQ4bGdWcUJDV2ta?=
 =?utf-8?B?WldraGdidU5iMUdZUGJSUHBvaGpHd0wwM1NPZU9MKzdOZnRRV09kRUhlaitr?=
 =?utf-8?B?QXBMYzlsYkFUZXcxUWdkd3JIVVZHem83RmdkWm90ZFMwd0RNZTZVZHpMWTd3?=
 =?utf-8?B?dEtzbi9GRlpaWGxjQjhoT1MvZE43QXMzSjJJd2djYVE3dWhUQmtMeVlwUVJS?=
 =?utf-8?B?Tmp3S0wyZEdSMVNGMVMyOTNtb1A0azUrUk9waXdtQkNTTXhSZlhjWSttZkdi?=
 =?utf-8?B?TzV4S1NXeWtRSmRDRGdHcWFDUERzd0RJVXo5bkpqV2MvYy9tRDZ1N3cyVTF1?=
 =?utf-8?B?ak4yQTNSd0IzdTdhcTZINUViNW01VmpkYktmS3JFYk1UQlFKV2h5RXZ6SHp2?=
 =?utf-8?B?UWhxVDEwajRuUCtpNnpzUGtJSmloRURvTnFuWDBXa0E3NzdCTjdsZnNQTmMx?=
 =?utf-8?B?c1Z4UGl3L0RoZy9RaWozUjZRalNwWG1jMFFSNm5FOTBqeXBNc1pSTk9POTc3?=
 =?utf-8?B?NG1xcnZZTktleEpYcDI3amNScnpyNHJBeTBKQWk0aC9OcXBVdUI0bXpsMGs0?=
 =?utf-8?B?UWl0TkdYckdrVGkwSHVvVTQ0ZnVRUm5EVG0rZ3RmS3FpTkRDU05wNjNIeHNp?=
 =?utf-8?B?eDV2ZzZFRXh4c3dINmF3dHkvbUFaYXMxT09YRS9sUlU5aURTSjBvUkxmWTFH?=
 =?utf-8?B?UTArVnRxK1kwU2JKaVQwVDQvL281ZFNvckl3alAvUHhxS3JmT1BITEZaaWhI?=
 =?utf-8?B?RmZ3M3JqZDViMEJzWVVUUG1uM0xxT1pjYjYvQVhhUnNxMEx4UGlsK1Y2cldk?=
 =?utf-8?B?S3E3Y3VMcHI3QlI0bCszUE5QQTgwUGtORUdDanRvenpQODNyZkx3anl2QnVN?=
 =?utf-8?B?c3JiTmFYSHRuSGx2aXJnRFlBNDNZTXZJN01odW4rZks4SjcyN1p0VXdLajJM?=
 =?utf-8?B?cnNnc29UanI2Rm1xaytDQkt2Y2pNenNhMG05aXJWWDFKZzhUWGZ4dlNZUy9S?=
 =?utf-8?B?UnpZOGpHSDQrUEJRRnVLNHRTMzNFbkZpcXAzcm5wWExJZUM1dU1BZW1sMWtp?=
 =?utf-8?B?emlqenZsb0N0YWpBWTZ2RjNaS2k2ZVVUTTZKL0Z0QURBbXdQSWZwYjJIaUY4?=
 =?utf-8?B?MEk3Nll3MU1xbEFSaGNObE5MdXljMXdmOFBvQk0xeXNrQW0rUmV1TVVkdkYv?=
 =?utf-8?B?VndCa2ZLbzAyY0RZTDNPbTFUS1p3ZXV5Q2tqKzNBVlk1SVNzN3dCcEw4RmRO?=
 =?utf-8?B?dXJuZ2hNRGVKOHB1K1pQL3BTdVBlTFhteW9DdUFSZ0pzRVc5WTE0QStmNmVD?=
 =?utf-8?B?SFJ5K2p3ZlhueUluMERwMVk3WVJlMGNvVW1DTEdKWDVIb2RWWEsyNVNEaUxr?=
 =?utf-8?B?b1lZMnhvRk5tZFBzOENyRWNFRzMwUHBrSjlpTTlxcmhkQldQa3pJRGhKUzJ1?=
 =?utf-8?B?NlRpZTVtNWxRdlIrVE0zQkR0SExzZDBJTHExa1A1OWZrNmZqZlNGQ2ZPOE1S?=
 =?utf-8?B?V0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fba95e2-57ff-4f80-aeae-08d9becc9243
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:40:08.4916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/P47+2rVDQgZLymDeWwbYo+nqwGkiopRRivvz45giyz9p5msEWF6CcLlDNs/iN9Zox1Z+3doMoUDMUNZ7QN9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Eli Cohen <elic@nvidia.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, December 14, 2021 11:47 AM
> 
> On Tue, Dec 14, 2021 at 12:11 PM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, December 14, 2021 8:47 AM
> > >
> > > A question, consider the parent support both net and block, if user
> > > use
> > >
> > > vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1
> > >
> > > How do we know it's a net or block device? Or do you expect some
> > > block specific attributes to be added?
> > User should pass the virtio device id of type net/blk etc when creating the
> device.
> > No such in-kernel driver exists so far, so when it is added netlink interface
> should be enhanced to accept the optional device id.
> 
> So the plan is to reject the dev adding without specifying the device type?
> Looks fine to me.
Yes, this enhancement will be only for those mgmt. device that supports multiple device types.
This ensures backward compatibility and also avoids the burden from user to not specify this for mgmt. device that support single type of device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
