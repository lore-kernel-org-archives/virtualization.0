Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F08C433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 10:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF65980D69;
	Mon, 22 Nov 2021 10:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcBYeA6V-lUq; Mon, 22 Nov 2021 10:13:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B40B80E07;
	Mon, 22 Nov 2021 10:13:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37E39C002E;
	Mon, 22 Nov 2021 10:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11363C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E32B640101
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5iCnzniQsy_9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:13:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60CEE400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjNs1Lv43a2t42tzRtRqZzE+Y2yGu6/XuzhTPnnRyE87yXCnJcmTs/AodeTonPQaPpeCJBYGePBdiNzf1/3Kq34p50RPRWHbU5djPAl0BRVy24MeOEczYHWYE0s8LYkvPmvtqYNdfi70e9ZTycBJJF1aBMeo4LJ7kb/ysbwv4ZrvXiRROyNyj6H1iwQ+o+UMVWFpdFE60ONNvrP9sSMSf90DRzNQLQgbyKpKcqMWvPZHB6yavC5AUZ9ShKdS+Az5PPvXXwEisJrL9dQPqBezTRKxiZxhAIl7Lc3lTssomWBSvCIIIn6DpvZe3gVNnD+u0kk8R9gzCkPK7kjPFKQYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OA7RXi0Mn4s5U+eFyrISbnXBCDikzut0X0wZe8w1EuU=;
 b=oPpY8fb3xXQsIjHG2Z01NY2gt6gIiy8vlTP+zT0fSkqO21a1bLHr0xVk90MEeg+ZgtkLBw9/GBl/rgViFHGJfg448kWYLq2WZkD04wfEBDjcLl304SKhh9LTZc6CLdup1twAQGYIPXHeCK62UmAoRGlx9CPk8PgTXHyf+6lsyFyPuvrqmAFyEspLWfZYs3peY+KlFDLDX7ScbjwWZSfSAvrtoSR6ekqJBPS4toAh6muhNEAp8UGdH3RJoYmG0cBvrBXBOE2J+qPppHy/kPDDqp8QUw0IlTHVKOSHOv5ePcjUvlQ0Mya3Jx76zN/K5cjvgSAY3Mxr3Kvr3caj62k68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA7RXi0Mn4s5U+eFyrISbnXBCDikzut0X0wZe8w1EuU=;
 b=VPRVCZ+tY9QgovnbFoxHe5nh8JRrVvAZ3OpzwBHkzcQj1TsZO+ROsRtTW4htWNeo/ztb2T+T2skiQGsn7K1vNgnCLCdRjYo7ZKhZWfDdZciau+06GFqWlpRK3MEPw7ya8aXH/9kyTjchXlwCmIDKNWEp1btK+Wa1hxBZxRN/kTOUO7Z8owsQAeIEmZ2GFaG3TwbqmJffIRh09uvyaj5N2vDPI07JLB09utaKxVT6nQkqZ/Iorsffi2A4RnuSGKE8SmZQXKtL2ITMPepAuha2kiEsnT12shkcDzOxGblh0dOt7EE6CjXo9odr/Pfj6T+UAtpFJYiYM2t/1YjTsKxzlg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 10:12:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Mon, 22 Nov 2021
 10:12:58 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Topic: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Index: AQHX3EFM7M5U7I8roEu6kosjxQg7cKwKJX8AgAAE5hCABK7YAIAAf40Q
Date: Mon, 22 Nov 2021 10:12:58 +0000
Message-ID: <PH0PR12MB54817F0EF37550ABA0D60092DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
In-Reply-To: <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 623309e1-9aa7-49af-aab2-08d9ada0a88a
x-ms-traffictypediagnostic: PH0PR12MB5449:
x-microsoft-antispam-prvs: <PH0PR12MB54493BD462BB0B8FF00B34F2DC9F9@PH0PR12MB5449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0s4xnhs0D5gXJ4htynxKuHp6j3MkGbCQZ17OyCx6Ssea/DHIkvbBcFC22DinYAfld+44eKn1h4cM8iPj7Nx5hzsYoEfxC1trUmyLKtCjcbX8udFompl0d7TGbByy1ySl0emfbbTlIx6aqXPMmreImhY0mQWMWoT0D40fM1lZA81Dx25X7NGOBjP5wmZgOIw6hW58/T00+gHFOY4tjLJydHuB8ayLm0e/BzkJwFcuH4vWKVh4j87YkHUZjIbJ0hEwLk7ZiH4vT4OeqzcfEdgOF0c81dXhbO8pS8wGDspIkfhvLb8XsXyBV2kMn1rjqSe+XITkExhsr7mDar9XsiE2Glu3uiLTUfbftcu97WiiqKzbzVv+ybnSCTIjub/t5vRq2bVSoEi4+LEjP6nLL7qzhiBJ1knd3D35ZWXHDhNRZDki75CkPdu5Aqtr6MLd3NIqyCQj/t/djWfRUJe+xaQNMmd/U19X5q8AkN308D3wF/MuKnt7kRa1fb4W7jhYAPkLUGJ2NHLzILkk7KGxiHqeTAUS+ACbtaeJff3La4Lv03cemZeqAonUkjJmU18K4Zw04fDF5JuNLDb6Y2MyKlHSBjnlEp8qDHgTf+8cRvuB8tWDp0nHyBi/kwvvPMAH1q3hcFjnYyijiEPK+syAxd6omH8szuJ0t3cri6RdGWEeNxd8LIvxILR6TpwUZblgROxbHnHXnGaWxOyX0PDcwoG6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(55016002)(33656002)(2906002)(9686003)(7696005)(6916009)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(54906003)(86362001)(71200400001)(122000001)(316002)(38100700002)(508600001)(6506007)(53546011)(38070700005)(186003)(55236004)(26005)(4326008)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlBJZy9wZXU4VlBXVm9HRTFSbUtYY240Vk15UWZqRmd6SDBZRTZIRmUrTnRY?=
 =?utf-8?B?SllVeDJHSWZWQjVDRTlxd0EydXE0N25RR0Z4Z1hpVysrWjl2amVOcVl2LzR4?=
 =?utf-8?B?d2UzZUROWm0zZ0IrMThKaDBQQlFNM1V1WkhqOE8rKzMzam9rMTNLdmJWamFL?=
 =?utf-8?B?eC9ja3N2L1B3UVBxWDBEMzFvaTBtYjNlSk9QaDA5WTlYQlArRWdvbWUxdkcv?=
 =?utf-8?B?aEFaK1p5UHBFNkNBZDdvd3NDMTdLRHh3WlgvaGc2QjBJZGdBVkZIbEJNSEFS?=
 =?utf-8?B?YWF6SVZrczJHK0VrWmJnMUtUblMzUkp2R1JiVzU5c3Fhb0tEZ1dmNEFQWWhO?=
 =?utf-8?B?NEpNSTdNaWNCRjRNRHllbUIxaGhKN1l6TWdwcW96NWwrWVBYb2xSY0ZvL1BP?=
 =?utf-8?B?T21BMVlWZUorcy9jbjh1SllML2NwVXRLanFzaktaZndicElzdmNHeHNqM1g5?=
 =?utf-8?B?N2RORDllRjczYlNoemd6N282VzFpR2IzS1BKYUx3SUFaLzRRak80QkMxS2t5?=
 =?utf-8?B?RXFkSlFIcW1uVGUwYW90eHQ1VlNnQnlUeVZTa2xCaUk1elVLNDhqQ2tJZk1i?=
 =?utf-8?B?WUZGSXlVWkJneGRUR21sb2txeS9BRjV1V1F4YkxHZzRvMitSUkdsUEk5dDVl?=
 =?utf-8?B?WEtiMFVZREIxZnVkcW84Sm9SOXFNYVFMK0ZTNTYvMVoxTkFxeFlhZExkc0ww?=
 =?utf-8?B?WE5pMGpYWDYrSDVRMWFCbFVoSjZKVC95Z3UxYlBpeUJyMGpVU1Y4SHdWMjhk?=
 =?utf-8?B?VENmYU50Yy80aEtvV0h0OUJ0V3J2SElDNENhSDFFQnZjandjQVM1L2tCUTRL?=
 =?utf-8?B?R1pSVlBGZlJjMG5jZDVyYjBSVW9rRFBwY2NGdktSUUlRQy9qZjQ5Z1RUb212?=
 =?utf-8?B?dDZyQ09yeE10ekZLU1lEV2N5QjE3Y3JhUTBBOEppOXYxbUpqYjZhakJXaHU2?=
 =?utf-8?B?UWlBNDJMVXgwUlJNVnlWY1EvQ2RLNWJUejhVYXBpTDlMNjQwZzhodzNMdW5q?=
 =?utf-8?B?ZjEySTVtd29JNDFvYlNxeHhsSEZPSHlZbDFWU010S0V6T1NHdEFYdnV1Mmk0?=
 =?utf-8?B?ZVdGdlNFd2hHSVByaGFQWjhLbi9oUTl5K2FwNXY4elpGTVFrMTc0WnRBZnFu?=
 =?utf-8?B?a0I5ZXFabmFNV1JLdGh6SGhGTWs4TFgrd1lyVCtGWlJ0ZEs5OEpkOHdoYmo2?=
 =?utf-8?B?ZXZYZlVDR2FNSldkT3ZQblpYRUswVFI4VlBzdDhmSVl5bW8vSjAyNHJ1ZHBZ?=
 =?utf-8?B?REd4SWFjTDMxdzBCdVBrUEJCci9SV2FrbUgzUjBNNWVyN2RodnU2V1FGaXhE?=
 =?utf-8?B?L25yQVRRMnVxU3IvTlp2Wmw3eXVENlBGSUFOdklTV0R1eVhCSHlmOXZCTzlu?=
 =?utf-8?B?Z2tFTVFmZllyanBYN3pJMWp4ZUlrbVlyS09SZERHNXJHN2xCQis4ZkNEVVZ6?=
 =?utf-8?B?TnVEYVEyQ01UUzYyRlE3L2cwSVJzTlVKREVvcUxwejdiVmxoK2I3N2xuK3p3?=
 =?utf-8?B?MnU0eDdqcmdScDNSRFB3eE12MlhESnViQ1E1T1FzU1V5UG9zYXVJRjJCYUY2?=
 =?utf-8?B?TTJPWiswUnZ5T0J3REVFbncvUmFTajV2MmV3TFFqZ3FpWmtJTGJlbXJDZExi?=
 =?utf-8?B?L25EZjZ4N0FRTVBqRmxsYng1Y2VNWDJ0bmdxZHcwK3FqMlRIYVNMd2Y2QkJ2?=
 =?utf-8?B?b0V6bDJ3R1JPaUk4RDlNa1l2QXl2emZITjh3a204WEhCQTNWRGhuT2dlKytC?=
 =?utf-8?B?S2c4QlBER0ZEdDc3ZXM2V0ZpRE9qSXJEell5N3VwTjR2SktxVU0xUms5a1FR?=
 =?utf-8?B?bVE2U3NFa2lWYlhDYzlrTlhWWDZyUjE1K2JaMVB4QTVOQm44TEdMTHF5bGg2?=
 =?utf-8?B?dDRvcHY4N09jTGtZMFBWRG9YNXVHcmFYbWVFVGFKRlF3ck0rdUFsQlNiVXZQ?=
 =?utf-8?B?eVgzZ0UzYlRzR01ZaElqSi8zakZDbGNuQ28zSWFsdVJUVjFxbldZY092bEt3?=
 =?utf-8?B?Nk9LSERodmM4bTNkNmQ1TVFaYkZtSXBGblFCVTRDR09Xc3Qwc3lmRVk4eDV4?=
 =?utf-8?B?VzNYK3BXcHZJS1dGMXp3d1c2TXpCa1pKQXdpZkNDYkxEMmhBZERhWmJrRTN5?=
 =?utf-8?B?NXh5SE5jdnpZNWFpcUJZQ09yWDI5M3BsL0hpeFJIVllBTjl4SWJiMnVkRUlK?=
 =?utf-8?Q?kSvnzHOJThr2Kn6wKpSmMVM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623309e1-9aa7-49af-aab2-08d9ada0a88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 10:12:58.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzTu3P4YXKA9AjLWCRL0Tib5OtCuDnEkcHJAkVp9C5HW1+BszBrEHvkZLUqwzbiQPlwQlMJm9iqhc1xibjYifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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
> Sent: Monday, November 22, 2021 8:00 AM
> 
> On Fri, Nov 19, 2021 at 11:09 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Friday, November 19, 2021 8:12 AM
> > >
> > > On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > Add support for querying virtqueue statistics. Supported statistics are:
> > > >
> > > > Received_desc - number of descriptors received for the virtqueue
> > > > completed_desc - number of descriptors completed for the virtqueue
> > > >
> > > > A new callback was added to vdpa_config_ops which provides the
> > > > means for the vdpa driver to return statistics results.
> > > >
> > > > The interface allows for reading all the supported virtqueues,
> > > > including the control virtqueue if it exists, by returning the
> > > > next queue index to query.
> > > >
> > > > Examples:
> > > > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev stats
> > > > show vdpa-a index 1
> > > > vdpa-a:
> > > > index 1 tx received_desc 21 completed_desc 21
> > > >
> > > > 2. Read statisitics for all the virtqueues vdpa dev stats show
> > > > vdpa-a
> > > > vdpa-a:
> > > > index 0 rx received_desc 256 completed_desc 12 index 1 tx
> > > > received_desc 21 completed_desc 21 index 2 ctrl received_desc 0
> > > > completed_desc 0
> > >
> > > Adding Adrian and Laurent.
> > >
> > > It's quite useful but I think it's vendor specific statistics.
> > These are vdpa device specific of Linux.
> > And are very generic of the VQ for all device types.
> 
> The question is what happens if the parent doesn't implement those statistics.
Only those statistics to be filled up by the vendor driver that it implements.
If parent doesn't implement any of it, usual EUNSUPPORT is returned.


> 
> >
> > > I wonder if it's better
> > > to use "vendor" prefix in the protocol, then we use this instead:
> > >
> > > vdpa dev vendor-stats show vdpa-a
> > >
> > May be. Lets evaluate if stats of this patch are generic enough or not.
> >
> > > Or if we want to make it standard is exposing virtio index better?
> > >
> > > qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N
> > >
> > I did consider this option a while back. Shows indices are equally useful.
> > I think we should show that as vq info, along with other VQ attributes (addr,
> len).
> 
> That may work but it looks to me the receiced_desc/completed_desc is also per
> vq.
> 
It is per VQ but statistics of a VQ and VQ config are two different things and also mostly consumed by different entities.
For example, prometheous and other similar entity will use VQ statistics.
Prometheous etc statistics collector often makes frequent queries for it for which a VQ address is of no use.

While VQ addr, indices etc will be more used by the developers/debuggers etc.

And it is better not to mix these different info under one netlink command.
 
> > $ vdpa dev show vq
> >
> > But showing indices are not less statistics and more current state of the
> queue.
> > For example roll over of the indices won't cover absolute number of
> descriptors processed for the queue.
> > And even if we make them u64 (not good), non_developer end user needs to
> keep using side calculator to count the delta.
> 
> How about exposing those raw indices via the protocol and letting the vdpa tool
> calculate for us?
With wrap arounds it wont be able to calculate it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
