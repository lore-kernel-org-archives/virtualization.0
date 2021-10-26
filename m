Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0C7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 05:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A748960F90
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 05:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A748960F90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E3B98101B;
	Tue, 26 Oct 2021 05:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMysPE_JcDDQ; Tue, 26 Oct 2021 05:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27C3380DEA;
	Tue, 26 Oct 2021 05:00:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13D0C0019;
	Tue, 26 Oct 2021 05:00:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51BA9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BE66401E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgP8jluFqPsl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:00:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69CD4401CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBzwq+Xd3hNnrAw2jd1NZY6k6O/rLjYwuRTpsxapo/zZGkZZhgwsllG/j9UIJwF/oi407v2OlSpaL+exuKXlI9VLLzrN46lzfYEAWW4a2Lo4DPvlJ0bAOBON27Y7AuhLNI8eTc13nkeyumKlFPT0p0cOHKz4xOXPZ5W5NxzAb2suLFos/3nlBN7IenJjQnloEnQhewUyRhKWD1SvUTCMFR8qlpHJ1Gcoa4SIePu4Rtytxajw/W/BV1nn9hXNIP/YlKG/P/19LVjteHNvhvrWTd495AK9KPQvo/UT00KD7TABtbjxoxIkyNPn3iPso3nPr8meJr8MwwoP1IEo4ml2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hOZ2qh0k+sISSdD9Vvy+7QGu2cpB1h0q7PreZPR22Y=;
 b=j67xSV+WVygwg+dVEZ6lnCnfuYyUkLx8ZQivKi5BaIsc3LsbLljKEYS3Hq252JySy3YFCAyknXM4jF6gQ+NgjPUBlyd5Hm4RCb+NJsbFYaS/VVCuoBXPqz4rHkt+vWraj42KxLuLrHE+g/92h7GBOaiaETf6DySyYxD5JvJ2XlDjgy/wlmDxhtiUoagOZlRShvmysdJ9ZELOCGb7dbJdPe4TTSap4AvUfwJLqTuWHLmrXe59J82KFjs999C97AS6G+8UEKomn3DfV8QHsSLCq9MQraWOHahKhbRwlXrKRQ3TIUtVmejzHRwXrV5TWthAoGPuKyLQ2jp+BQfiSIdZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hOZ2qh0k+sISSdD9Vvy+7QGu2cpB1h0q7PreZPR22Y=;
 b=O0EvX+fpKG7g0Eto/PiN+izFDepfWyQS8NW16mTkLpLRqoGu6/AyuSQPiGiMP0mnlYpDu6yEsSmKLj9WpIWzvN1SciZOyNSOblaLkzIGvhy6HHyINqLvsaFnVwyRxP++PY7BnDBkhL8cJ3uqHqpkFdl+YoGm0Ibvqf4efQdB4ejFv7Ks4o9v6iAhTPralSN9IP3H1jj+ogdgAq9ozATDBY1ykTlHsUp0CQ0dHpGr7ateRdym0P7pJoXN96y2uD0JWi7alTOUuPK9JMxefej9NN2USS8sosgrpXiOKmoF4DCnTJ3SdYklkNwcgCsUdQgo+YR4/zI9VUSd4xE5bnyvCA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 05:00:09 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 05:00:09 +0000
To: leohou1402 <leohou1402@gmail.com>
Subject: RE: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Topic: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Index: AQHXyZ9Zee9PnHCFgkCpho/IiIavRavkuO6AgAAANTA=
Date: Tue, 26 Oct 2021 05:00:09 +0000
Message-ID: <PH0PR12MB54817E52E4B89662D73236A3DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
 <204B3436-0EFB-4722-9EA1-A43C7A2FEDE5@gmail.com>
In-Reply-To: <204B3436-0EFB-4722-9EA1-A43C7A2FEDE5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26beaa2d-9a5e-4d5a-437f-08d9983d7c5c
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-microsoft-antispam-prvs: <PH0PR12MB5420B3EA28E8845CD574CA07DC849@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+FvJ5EGIR29AjbcJQ5qez2K0VRQSlGl2UL3/j5aa+4v0c52oYjFSWnPUWCEshIusvn54hNh9QMUBn7JDRmyT2howAb6w6nhYpxOCVTExiisGuNUPX0yvj72K4lrTR+/Y6as304TXQ/h5uei2fkZlzpGYyqPZMvcx75MUf4tVs3/5M54JJ5YrkVkjnciVm6oCbSf6S4gbiK9oLNe/aABeZc6dMUaImP6aXPla0qNXrYj7HlME7gcQSITys1EfkPrwltY34IG35rXaC7IRbhKYl50euPWwyI/mTDlRD7/EJIfeCuwrM4qVikkkblS8OBv/NX/Kqnmrf5LjhCgMiD+++FMpcmH37O8h9M5St7QdE6QLO8kcvhyBxgL1o7bW/a/h3HdTiMnljFEUagHvG5gRhJfmHiwAPwQuVEGbUzfIdqLIh3Mgn7YDrY+KtQnJWBbQYEEvhCG0iOZiwOswQGRrHyAScut2v9yyu+S4pdReoTQ8mVMa0iZfG1isI2CC/EmEfprmk4Tj1bYErdc5Bek5Fg6U4CR8u3mVu3+1i7/L7Rqb0MoqKJrRnO1474kfZTI0O+GWz+CaFnpOPM+ZLDTLWh4NXXnbFG/58qTQqLhE1VGSy9lm9N6bIpYbH1e4+Xrk3b7aAMjh5PkKQELaEc6A+geyx1Kyt/6a+aIGZBNE6qdq6nei+RiBoOH0PSt2n7bS8SNYMRXDgIdZ/BnngZPxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(7696005)(558084003)(71200400001)(8936002)(9686003)(6506007)(66476007)(2906002)(38100700002)(38070700005)(122000001)(64756008)(66556008)(66446008)(4326008)(76116006)(55016002)(33656002)(66946007)(6916009)(54906003)(52536014)(5660300002)(186003)(8676002)(86362001)(316002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFTU3lueEI1R1pTd3QwcGhZUzRWVGVqY3VaczJHb01ZOXVrNUF6dFJrZm0x?=
 =?utf-8?B?OFExRjZvQjhzTis3QTg4bFYzazFqbXZrWjFhZHRTZ2xGSEM1SEJMSlVPUUNx?=
 =?utf-8?B?aEZ1dENkb1FkR21tbjlZR29VOHoybFVZMjhZZ2ZzaXUzdFFESzFQZmJnbzhy?=
 =?utf-8?B?VCtrVm9lRVlUSkx1citlQndUNkNWM1RwcVJRMmZCM1dES0liR0Z4N3IyaVF2?=
 =?utf-8?B?WmRJZGtnNHhtTnhuR1RwM01xZVBBZFl4YW5TRHBYYXJ1WGFGM242Yld1ZGtk?=
 =?utf-8?B?V25ndFhRM3lsZXNwVWF3aVRBVEtIQ05EUDdEdUR1alBwUFVQUmRyWiswV0VO?=
 =?utf-8?B?VFo4dFFWZG5EYURhUnJ5T1BnYVF0cVRBMEd6cXh6NXhsY3A3SDVET2sxdVNT?=
 =?utf-8?B?dXNmdU9jaU5nSHFxTzNhNFV0djBuRXRzT2ZWWkhIVm9yUEV6a1ZjL3dZOFBk?=
 =?utf-8?B?NTJXOENOVXFiSFBZNjBzQ0N1eU5abHlWSFFPSVZoTE4xb3ZJQUNOekdGWWVG?=
 =?utf-8?B?U2M2bDJoMXJtQ0JRdHAwSFcrZ1hyYTRLNHkyOGp5Sm9oYmtEMDlDOHdYSi9t?=
 =?utf-8?B?c3h4Q1pDNEJNN2hqVVo4bzdSZjYzMU9yeVRNZlpQOFRzTzlSY1dKeEU3NEdh?=
 =?utf-8?B?Uzl2d1ZnKzRiUmxVODd0ZkxySU5INlE4M2JhZ3ppMWxETE5mUi9uak5pQmdJ?=
 =?utf-8?B?WjRLb2huVEJSeFc0U1BWM3dqWWkvTklHUHRxNnRnVm83eUQ3eXh0ZVhneHlE?=
 =?utf-8?B?N0Riei9LMXQ2dU5TbFlBNnBmL2E0aGxYQy9FTUh4Q0hmKzZObjNlbEZYemRw?=
 =?utf-8?B?OHRIVm5KMTRweHJVTEN1azVzazliUXc5L2tVdkJlYmFYRjFSamNvdkdxVUpN?=
 =?utf-8?B?UDBUTWlYQ1pGRjN2bUJmZ1JVcXhwU2FScWpBekVPb3JtZTNnMTh3ZHNUUHJ1?=
 =?utf-8?B?Q05aTVR6Q2tZVkpZOUN2V1hoRTUvdFI2UTZicDZSMGRPYTFRZVRUenNZZ0hU?=
 =?utf-8?B?T3JmYU1uSDQvQytlZlBvNVFuM24xMHBVNDRnRnhHN1Y1OVcycEpYRzlVOFND?=
 =?utf-8?B?T0xpTk4ySFFhU3MyaFlxL3VCLzBxTUxCdWQ3STQvWlgvUHJmVjYvQm0rMmQ5?=
 =?utf-8?B?MERQVGFZVVZTRUlOL0FnM1dLOHJ0L0FEaE9qSG1reUVWclQvcGZiQUJsbS9M?=
 =?utf-8?B?THhpTk5iUkY4OER2ZGJmZk9ESlBiMHVlSWZTc3FBVllJVzRGbXp0bi9QTWN2?=
 =?utf-8?B?UWFoNTZNRm12RVlualdxdEJBdUdmbTU5RXM0ZFc2WVJTVktjYzlqM0QwdkV6?=
 =?utf-8?B?UHhDaU9sNTJXWjBhTGkyUkkrcDVGNVNZeW5Ib2p6QTlzVzlIY0tJTHBiM1lL?=
 =?utf-8?B?eDZNNkMram1KMm9ab2FDOGxFcWMzSDZaR3lBcmM3TVIycm51NXVNM1pIc0pS?=
 =?utf-8?B?U3YxVEMvRXJjVlFXang3a25iNHdpaXdLWWlvQUNYWHhjYXhoTEdKU0VGcm1K?=
 =?utf-8?B?d0lBR0g2ZXdpNFdVT2RoT0YrRm5odWtoMGxlVHcvRjBUUGV0ajRqZlM1dUpj?=
 =?utf-8?B?Q29ZRUhZbGtjR1lYaFVsNGNoakxLMzhCSkZhWlJXMnZnckZjaUIyOHdUaFgx?=
 =?utf-8?B?MkdXdUhzWitxTUEyMklyOTVTTGcyRTNpMDJFZ0hZZ3BHVTlOWk10UnQ3TG9S?=
 =?utf-8?B?VjJUa2V6NlJXTWlOMzBrVnVLOVkwYko5dEM2SWVPajNPNEpPdlJaM3loYmRS?=
 =?utf-8?B?U01OS090b203bEJPRm53SjJOOElBSUFnV2h1dVE3eGxxbHBsd1RBTFNVcG1G?=
 =?utf-8?B?Ris3ZDE3SmpwVVdCcm05VjltL21wMWYyK2hOZDZ1U1hEUzJLRTdXNDhlcmNP?=
 =?utf-8?B?WnViamoveFZVY25KdWpPZTFUZEI1ZFl4NmNaN1JrNmUzTXdSMjBpUGJLMHJG?=
 =?utf-8?B?NjBSSzZFR0NKR3JXakNTM2VDaE1Gd2JkTlU5ZFVOdEQwd3RGQWhuT1VRUXpG?=
 =?utf-8?B?Ym1wcFlkV3JqL1RicU5WRjZ6ZllkdHYrVlFsby9nWnFnQ05DMlNPTFdhSjBH?=
 =?utf-8?B?VW1DS0ZJNVpza0JXVUtSUXNUaXduRFZJdnJZaTZCeXU5Vld5Q2lQMCs2YVlU?=
 =?utf-8?B?RnNjQitqRndBZU5SNHFVYThzWlk4T2RUNU4zWWZYTDdkQjBSWXBSMVhsbzV6?=
 =?utf-8?Q?OZahQCW/Hpm36AOs2SBK/ao=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26beaa2d-9a5e-4d5a-437f-08d9983d7c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 05:00:09.4941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LySJRbLYQvZajcw0u3fb6oikHtReRfAkgxZ7UKtviC/COaNz/gd/vVsCELsFmVccjwzuWY0Qx+0tYozKsljC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: leohou1402 <leohou1402@gmail.com> 
> Sent: Tuesday, October 26, 2021 10:28 AM

> Which device does mlX5 refer to ? Connectx-4 or ConnectX-5 ?
> I want to test it out.
ConnectX-6 dx.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
