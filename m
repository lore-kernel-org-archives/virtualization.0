Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E19C4321E
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5677660F46
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5677660F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BFA9401E7;
	Mon, 25 Oct 2021 11:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cgLvGETFmBA; Mon, 25 Oct 2021 11:25:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6330C40012;
	Mon, 25 Oct 2021 11:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41B2DC0012;
	Mon, 25 Oct 2021 11:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF00AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC0E2403A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBySytXrRjcj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:24:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 866BB40246
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 11:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGScsIVF1Yc7IlkpLKwMbRgp/4LO8jm5Gc+VmYZYIkzjCInofvHhHbfcm3b520W/4P4sCVF3akZ0zrq4qsTlzUia+73tu6L3jFnLwE60xmMNrOXU5uGlnzke+wHepCk6i6uDAWDdNizfdUGcrKalI/vBXoYzZvJ48RZ2S1Gwscqk3OV/Z0xg2xiRk4WhpETV4Qag2OAQfUELI1dFMBBLPCCtK0LQT8F1jcFcJVeZiRUqYHTNRq5wCoYBY6JhjjHRm1eqru1HlMt43ikFNpa6l8IohYBZBBx9YgJop+UwE35BpBFwTKs8/pD8tZ0sfyulIXFRNJitQLVqPWiDnCQHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIpm0tYxEQ+fwVCW4J3PNMCm+YoXGJ50/iuAXl+9slI=;
 b=XH1Dmoxg/V/gb6XBPmqYSQfFajWmt12QF6FJBP3toLyqe1RgWXW5lzy1X3xlGQ9sx0/TN/A5y3U0AIJXn60Kq09Uk38Vghr+cBL7aUCrgYYBvtW9OeearxeSu4ZcyzJ/e0mMrXQwquaMsklq15WBtbwk/yMwy5haooljb1h3Llxsvjcu+2nwtvDl0XuvjetLKP5zoojJf7P/f9v9olLoROu+c1N2Xmdj4vPvdndyTC0TxxmPQGVl9VvJfscy+V1KD3E0VlBQXb8ur5tk6Mi2mPJtR31RGAFcXxr4vgN24Z7lMYJKdWEKJhDk1kMxubBE+eD4I/Vl5R5yqPCOC7Hd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIpm0tYxEQ+fwVCW4J3PNMCm+YoXGJ50/iuAXl+9slI=;
 b=o45mj/5moXzqckRn5d+XcWYvLZ7GZQl9r4dN1b5Ncjo7RwAuyWJ2a9bvZa/1jDp8trYy0l+phWLtULzxSFpr1VMxMbvxX4vIgqxo++LjtXWPBJMyIKrigdoZCJcS5RTPhbMcYJUKbD5cDm+2Admbznx5J6fgZ1HppC0BHMow4nB3MjjDXE8/WQdkR2ywCqbCLR0SdBxWLCi16ciRueUnoepbh3YilsXs17SX+oRLb1dK48GHl758L3nqQ7S4LzLqp/r1PZgIFuPbGid+praAmEYV/lvngUkHCvSaOppo9jh83U55WgSKixpNqSfnKhgk7g2cm1mo4FEwPTIbWhnopQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 11:24:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 11:24:56 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 1/8] vdpa: Introduce and use vdpa device
 get, set config helpers
Thread-Topic: [PATCH linux-next v4 1/8] vdpa: Introduce and use vdpa device
 get, set config helpers
Thread-Index: AQHXxpmwrlEeWxrcR0+AUO4jRoQalKvjPr4AgABZxDA=
Date: Mon, 25 Oct 2021 11:24:56 +0000
Message-ID: <PH0PR12MB5481F95252760C132B49E093DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-2-parav@nvidia.com>
 <358dd349-906d-4d94-7ea1-f799d51283c2@redhat.com>
In-Reply-To: <358dd349-906d-4d94-7ea1-f799d51283c2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd23088-e966-4bed-bd68-08d997aa12c4
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-microsoft-antispam-prvs: <PH0PR12MB545067EB981D936DA4C00104DC839@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHV//wBEyMdXepsWQVfqHrK+6pPSJx6DgoY5LPFv00OEu61giUXwn4NHxKR0P+fQd2Dxf51A7mHuvOD5WXVvnA+pE7x2SqYEiNqhGPNt54dxSfZZkRyl+SIWo336N5poPgfxp7BLinq+vaN+9uKbhvdXzWM3s+gLaHRXIyYbCILZb+SVhtHWY1kKbj6fXpZ+o/PgI341zyEP+1p2wf63tIoqZ1ARcuGtkfotjXFspJMWl3b/uWL/UMyyrVk6CvS9JyXLnmzDymh93s597kni5i5K/63VSpBb6GAocewLlxFOv4wBquD+Xxk6BAAB2L0Rya35SaPVxK5xq6fxr88teLyaeGA51c/N0bUDHGSCx6IaF6U1/gSXpzNef09/NwtYq7wrlpB1tdFghna6zREAwX6eZQPeX+NyHM95s6fy6+aSSwByaXx9eGYV7K3OX/CugI8RP8iLGqG1eb9QNOr6WCfSKmajrE+mpJyAyuiLPN4wYPdWdlneVI0ovjqfPT9xJu21ptcOsZ1TZbuFVImUlvBHyB5AEsbGSA0OI6fhEdCbpKjX7/a9UqjzkUQZs8GcQeyFyjD27qkH0LFYl/2TTHU6GXuL9To7zZ2/MU5fy0WHyusNzG00Hf2iid0kOyTMDSuUuae1mLxfMnnPHmvS2svmPU/kylxpoPUXVfT+aUTOh6cB1h/csVEfHSNLN1XsWfFMuS40jU/MVWs3M9X2Wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(26005)(6506007)(107886003)(7696005)(71200400001)(186003)(55016002)(38100700002)(66476007)(66556008)(66946007)(76116006)(316002)(5660300002)(4744005)(122000001)(52536014)(66446008)(4326008)(38070700005)(64756008)(86362001)(508600001)(8676002)(8936002)(54906003)(2906002)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U2lWSmNGTkpqMFdpNDFNdndYMnZqak9XTXZ0Vzh5d2Z3WHovVENQakJq?=
 =?iso-2022-jp?B?cU5jRWdkRWY4T0toN1p1SmUvazQ0bDdzbFdNa2RHWXMyNE5PWithUVBK?=
 =?iso-2022-jp?B?c2Fha3l1c0lHSEdPcUJaakwyemJJTC8yZ3F1R0QrZW9mU1ZrMXNtck9l?=
 =?iso-2022-jp?B?YTc1Rnl0NjZncmlwOHdvRTdZK0pVbHR6K0oyS2cwS1pPRDJwaFFLOEdG?=
 =?iso-2022-jp?B?YWtPZ2syK1VnYzdDTlhubStEak1nU2FEM3NKaVRiclJuQWs2blJRREt2?=
 =?iso-2022-jp?B?Mm50MHJvUEdONmlmME1CbUpRdGxUSlNWTmY3TCsyTEdiTGttOW5tRWxl?=
 =?iso-2022-jp?B?dVVEYWlwd1MyY0RSeTQyQktGWDRTbm5ISTd3ekdjTXhZQTk3Umh4akJy?=
 =?iso-2022-jp?B?OXVIQU91RzZOSStxd2V6Ni9BYWlweW1zU2U1SktFbGxmSFhha2FOOVky?=
 =?iso-2022-jp?B?elRMMWUvcmNZSVErc2hET2dOWVpHYU9xcElZOE9JSUpEK0czUGhKSTVF?=
 =?iso-2022-jp?B?K3NHVG96WmxzVERpRCsxOW9RTGdrbGpZcW1BNGhUR3JPazlkS08rMWM1?=
 =?iso-2022-jp?B?d0ZXbFY1ekc2T0RyQXNtSS93dlpWWjE5cWdFK25aWnA4UXlhaWRHRGcw?=
 =?iso-2022-jp?B?MlNSL2M4NzhUNHE2NlE2cFE4U1RxaUM2QnVjV1VQdVo1NmhwMjZtMUxa?=
 =?iso-2022-jp?B?TDdkaVpKZHh2ODZiMHFzUml1WXE1N2NtM1A0R3RPbmhxQlZyQUx6dUI2?=
 =?iso-2022-jp?B?bnk3bGtjSzErT1B6ME5qb3dCdENLVldrRVFiVCtMbDNlb3BGcGVuVDE4?=
 =?iso-2022-jp?B?bG5uNTdGQWREcXJaLzJOdVFkNmh5aC9BN080TXpVaEV6TjIyYUw3NmxY?=
 =?iso-2022-jp?B?K0pQbXV2NDZyV2d0eTVZTi9nUG5CTnZQUStNQlZtN2NxV2VEQ2xHY2E0?=
 =?iso-2022-jp?B?aE9WOVh5QUJKcUh1cXRhOVpIVzNKMXpTNWpqUzlNOS84T29LZVVpY29t?=
 =?iso-2022-jp?B?U3RGUjkvbE00Q3JYbkU3WHR2RUQyZ0ZvTFZIOVRXdjQ0bGUyN2l1NjNo?=
 =?iso-2022-jp?B?aEpOcjMyb3oyRVN3T2FtVDZkSXNTNWFFL0lGeVdnUXpPeXVXdS9lYW04?=
 =?iso-2022-jp?B?K2lzZmpDR290bngvT0RrNUtlOEpJQktMU2d2eHhLdXJtZzBTT0tUQlV6?=
 =?iso-2022-jp?B?M05zeDRrUlQ3Y05ScndiVy9LcnZVVklvQXRuQ2VSbXR3bDJsbGJ1ZUYz?=
 =?iso-2022-jp?B?ZzZMS1h5cGRtU0N4UFpFTHBFeWRBTEpHdUp6d21FYkUweWx0aGpBS280?=
 =?iso-2022-jp?B?VlZjd0ZJVTVCWDN4bXdGdE5saWorcmJ0bUV1VmJJNkpFNEw0N01wVTdL?=
 =?iso-2022-jp?B?SFphaTB4Y29nTDZiYWVoQkUzREw2YXBlV0t5REZQMXRxY0dmRHVoQWNn?=
 =?iso-2022-jp?B?Z1dQY2tHajZySlkwRUVaY3M1blV1Ykg5OUlZY3RJNzl6U1FMbnFRRGlK?=
 =?iso-2022-jp?B?VVZRRlBldkNkRkloR1ZSRUdPQnpvaEV0VzlkVDlTTnVRdGp6YkgrR3ll?=
 =?iso-2022-jp?B?V0xIVTZhNytQQzJmWlJ4aTRtSkhpU2JEUTdzVXRubWZtOEg0ZDEwbTIv?=
 =?iso-2022-jp?B?TlF2ay9sUXdhR05WcklnNmF3WnU4dE03WEZtZmlhN1NUQ2wwS3lYNDQv?=
 =?iso-2022-jp?B?QkZhMHZqZkZILzU0Qy94TzVUUS84V2Y1TjhOZ05XQlJLNXZWMmFQaFRF?=
 =?iso-2022-jp?B?eVdGMzhvdm4zSzR1Y202ZGxVa3RoZkpobTMzZFJMZWRqQ2dycmpnQm1O?=
 =?iso-2022-jp?B?OEEwclpNaWFmY3pidWxuQmIyU2RrRjNxUFl0dEVTbE9mZVFEaHlXK3Bh?=
 =?iso-2022-jp?B?TGR6aTVYQjZaUnQyTVg5OXdxcXlkbGlxd3o4dXgvYmlmU0JUNnlqc1hn?=
 =?iso-2022-jp?B?VWdOZlhVcjd2R1duUUFZNVN6MlprU3VhaUhJTlI2M1VtTmROVG5LNTJB?=
 =?iso-2022-jp?B?dXJsKzF2NkxEVmN0aVo2bEN6NTJkYXFyYVdhcDl5L1VMZkZ3VnJjRFlH?=
 =?iso-2022-jp?B?bE01aVlNNktYdmhQNG1wSkc1RDZPeGVKamYxODMrOEsrTTN4YnM4NkRk?=
 =?iso-2022-jp?B?WnFLZGRKVUR3Mks5NUZrb0o0b2w2Ky9QNmtYNE8xVUd5bkF0Wm5HV0Q0?=
 =?iso-2022-jp?B?bE9Gam9sSkd5N0Q4dkJVb0pHZ1RYVUdIRFdSS1h3dFQ5UDAzTldaL2lK?=
 =?iso-2022-jp?B?TTQ0TmhTRlZ6VHpIcC9vMjB3Wi9ERmdRZE9tQW1sMFoyRlJNTGNvWjNU?=
 =?iso-2022-jp?B?cENCK3RBRXprTUxNMEZLeGpBR05VZFNLc25XQysxaE1NYlFHUnFWWWsr?=
 =?iso-2022-jp?B?WmJSU1k9?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd23088-e966-4bed-bd68-08d997aa12c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 11:24:56.3867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeHlwIczpy1MBed7l9gMFAhojN3aJ1foLusq8rz5Upm+kSfhBCOUTqB3h3EZKqsxtRJQyhoDCHANPYGV6Sgtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
> Sent: Monday, October 25, 2021 11:33 AM
> 
> 在 2021/10/22 上午12:35, Parav Pandit 写道:
> > Subsequent patches enable get and set configuration either via
> > management device or via vdpa device' config ops.
> >
> > This requires synchronization between multiple callers to get and set
> > config callbacks. Features setting also influence the layout of the
> > configuration fields endianness.
> >
> > To avoid exposing synchronization primitives to callers, introduce
> > helper for setting the configuration and use it.
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/vdpa/vdpa.c  | 36 ++++++++++++++++++++++++++++++++++++
> >   drivers/vhost/vdpa.c |  3 +--
> >   include/linux/vdpa.h | 19 ++++---------------
> 
> 
> Do we need to change virtio_vdpa_set() as well?
> 
Yes. Sending v5.
Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
