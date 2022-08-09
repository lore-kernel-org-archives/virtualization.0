Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2C2C25B08
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 19:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FEBD60ACF;
	Tue,  9 Aug 2022 19:18:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FEBD60ACF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N4bTrfST
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olwUiSHtxkMe; Tue,  9 Aug 2022 19:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A568860648;
	Tue,  9 Aug 2022 19:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A568860648
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73FBAC0032;
	Tue,  9 Aug 2022 19:18:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9242EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5533C404A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5533C404A9
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=N4bTrfST
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jIQHLGj_IDj6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:18:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2884400E4
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2884400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnjDuaD3PKWQuk4VZl8mYmNCf2wqqVGSwHBUGRC00IpD5eTngq3bY37WErkQue6FwD51PcG31FeXMEmjrc3srIPpQMGmgiB53L3xFxOkKyCOiEJ5bHqnsWXKASXfukAhjBPUA/XyvSyUUsoj2gXDa8fIs77SWL6ppZhAEDB4OCQJPIsF6XP1qSnaCUyh0YbDr4/yzWrFCjeJd9qB5CngyM4GbmNAkWEOeINqXuRJw0CLpAUzAWzDb33P6ca4bdew/S+Vz1aH9UxP8mv3Hlc+Q+rFjAOCeKcc1CxRVPOmdtBdH/Mz4beYbqMbqWrcNr3oz+HxTkeWb3uved7Gx0AV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FadTRl7h5yQ8mdCt4nodPbh7mVLcARxV4BK2+VDGZlU=;
 b=gS8k2Hql0jW3cGvWhgr/wU5ZPH/wBRzjWj+fZCFvSLVxutPJSUljr412SmW/4Z65KZPWpUOt/5uueqSItcjTnixQ0ML3piGzSmbaOHUTkYBvackrgc06Wkg3xv5Oo8osTdA+TH8u7sPIneF0DDf/ZkGE46OuKOCdAX3mAttEJaydjapIX6Xf4Ka1IoV/pIccQJfWo1MNjfGiwRpyXXxk3TE350aQRudCcmee9Wvb5h42ncHjRNrHDdGNNXxemLNFoiTD2iLLfC0x9x2shcZE51Vg0UG+0LQHlVlaWnkvLLQOV5VUVt6qGP3q3qVUAkj0sv82mbLA9booZAIDHWtpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FadTRl7h5yQ8mdCt4nodPbh7mVLcARxV4BK2+VDGZlU=;
 b=N4bTrfSTeY/YQrdlLpnB4EIjSpdPvJ8O1Yg0UZo8Niv2TWbpc/HcF9HoXipiNG7arl2MHVqPtuOJgQ+WIdcgKjjIlxfWzWIoV0WxArBOOvmVrHVxQ7JYCXsX8cASleVjMb6t2HuSxoTy/bzm1X+95Yfhv1aAv7S/AFwFNqi2qPKUcyJkIlRporoojQuVdWLm8ZojLlcwu8HQvppDmkA2pRGiSGypdXlYFdbhTsUzOtK5ACRc+/lE3/VjK8IOlY74r188PAFGNjMslnF/UfUR/Zkwx73dhOHiVMkoQfEcadmCcuvgHciFjetrIcTJR+99H2/hloi2geytS7gRejp4TA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 19:18:31 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 19:18:30 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>,
 Gavin Li <gavinl@nvidia.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUA==
Date: Tue, 9 Aug 2022 19:18:30 +0000
Message-ID: <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
In-Reply-To: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35012462-a92c-4bb2-b303-08da7a3bf209
x-ms-traffictypediagnostic: PH7PR12MB6540:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: josoRNHlgzbGU6xXPyIqSJwO+JbhoVFZ29NQmlzYdjmmpPO/TP5JIWnGDthZxIqO+B7rdH4dBZC+PG/+NWVrBhK7pSoo9lPNOkFEsvonDfBf1lu955Llt3QXq7kxPTfbbi5H/PSbiO1fgGoprjm2iPSm92UPZWDmo3DPmFL7c1la/iHhGK6ZozYrFjBQQG6OqYD1LJfHdOcP/wEljtDDJ2drNaS/w2Fb0v4SQ7esQAjWBiRFDV/GCfHkqDaNpemgwC0WrZ3oh9Jwn9OPNFii6Rx69kIgQ9tFYTZWW8D2RU3l9lR7HiUeFnCk93sdEgE1DKxqZzc2op4HvYkNp4jYJKdbbvWw0ix5dk/hPGezkgH0Lg+/byHwy+veVCzD36RB/MyCEFl2YLjXr8sWEcq8WNWZzphESoDmRAZ4UXmeHHHlZ8BlnxEftqsO+nXPIZSaJNvsyzRacJ/wSbDNs+SzLgJLW5I2oq/vxm9VTurCl6xignrUWw4A3e4mU6pZ4ADSeXRvdrudWEI7hRTF2xbtafv4S5ELlVILTtDBLVIIJ55JzXoi4demS4Y/OOCfEIorMdRp15AfeBo35RMOzhy6fEcgF9AQCXR+OJTc/j5oA3lhdX7T2g20JDcXpQeyoj9GfZKldhCnvlJzDNChgjstnVvVQiRDzxUC+eGhI4aESmjBUh3uUT5TH1GEzcPRj7ptCJ9IEBQ+8/nFsiksgL1ZAQjDuvjgTN+4tJFUdO6eSkQ4TRqDCj5sus9zZ62GFCccprQSw0RV/ph0CYPeMYIkOSMC+T1SkiWewPGfHFJl+xXYxqqplAgT1Eb87HW4+6LB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(2906002)(7416002)(478600001)(5660300002)(41300700001)(76116006)(66556008)(66476007)(66446008)(4326008)(8676002)(66946007)(64756008)(55016003)(71200400001)(316002)(86362001)(33656002)(7696005)(6506007)(26005)(9686003)(54906003)(110136005)(6636002)(38070700005)(186003)(107886003)(83380400001)(52536014)(8936002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3p3MG5MdFM3SDNKOEd1dFp3bXYyRGRzc01wZEpZQnpyek9XMFhqZlNiYnJP?=
 =?utf-8?B?RlBlQnRCQmRhRE9XYXUvZS9pMUx3UXBTaWNFSkk0b2VRTkdtNkZ1cmNzSjk1?=
 =?utf-8?B?N1E0MGFuaGh3TlFUbkxBN2Q2a1Rnbm9LS1BHS3JyOFllYnBFVHR2UFZkeE1I?=
 =?utf-8?B?NG5yNkpZWTFwSEdHNDNRRVIwanZ4cTlNcFJudzZnNEcrUVBjTHArZWlBZWNB?=
 =?utf-8?B?TFFpc09qaE5xQTdhc0ZXWlQxZUNYcTd5TFEvalhHQjZsWVNVZDNRVHZkYWNm?=
 =?utf-8?B?d0VyY05GWnJqLzdlb096OFo1SzkxSzBjYzB1Mklkc2RCTWptcmY1WFBQOEhr?=
 =?utf-8?B?RTFLdmF1dUg3dEFxS1N2SllWbURDVksxNEJ5N2F5dm5wN2NBeksxeVlMd2lR?=
 =?utf-8?B?MHFqTGRreldjNk00VUZyaE5Rb01DZjBkWi9GM29iVG1KRVFkdzNBMXF6OHN5?=
 =?utf-8?B?UUdlZXBhc1VrY0JiOTF2ekh6YWtxNW9qdFMwbXZkbUJQY1FWUmFkU201a0Nn?=
 =?utf-8?B?SjNIa09vSGxPbjhLMnhrVXdDZjlhUGt6aGQxZzNHUTZMcjJRR1VzQy9oT21v?=
 =?utf-8?B?SjlCT3JvbGxhL0RwL2R1SUJXc2N4cEViQWVhblc4UkR6dDl1RzJOVFEzUTlY?=
 =?utf-8?B?am5oT2E5TjFqM09sSDhMK3p5d0dRWlBSRURlbzdORHdiSjcweGdTeXU5cTBn?=
 =?utf-8?B?UFdOWkZWRUc3eU5DWFpIa1BZbkx1TisxWVNWQVUxMCtaM3J1b3lyTzBiUVVT?=
 =?utf-8?B?MEVSbFQwbmNnYS9VM2ZKZS91MERTTWZxb1hrQ3AyaExURDlybFNnYnpqS0ZC?=
 =?utf-8?B?ZDdDOUJMcnZtaE1SSzVGSlFNV2pDODUxanNzSWgwejJIOFNpYTZsM2lWM2tM?=
 =?utf-8?B?OTg0cFY2TTkxdUluaXFsem9YRkljbG5vcUtOU1U5ZVdjRW83N1ZLVnhFMmxB?=
 =?utf-8?B?MGRTUURMMVU4WnF4VHlUUW12Y1VZc0pOa29yL0IwckE1ZWJ3Mkx0cHRVWDBW?=
 =?utf-8?B?NzBjRTgzY2UxcTF4UTczNktQUE1hbWhLZGlyZnhlckMrOEdMZjI1cXYxckp5?=
 =?utf-8?B?ZzZMSHRyUlR0VzJYRVFKZWZxSFpZN1pIZXdPVXpuMThRYVV3QXV5Z1ZOdVhX?=
 =?utf-8?B?Q0ZkOGF5bVZxMFp1emllSHhmTFpMN3dsT1pxNWRwK1ljaU8wSGVCU1VtTVgr?=
 =?utf-8?B?UzVGek40Rk1WdHF3Nk1hdGZiOW1pQUt6aVlQWVR4YzVJcU5tVDVUMThjbHN0?=
 =?utf-8?B?d3RGaFJnOXFuenYzeUZzTnlaM3F4ZjVSMjFpVy94bS8xQjI2VWl1SkJLanVl?=
 =?utf-8?B?ZkJyM1VIQ1NRQitseGlScDhmVnFlTmIyNk1pd2E1Q1ZoU1pTamIwOWsrL0d5?=
 =?utf-8?B?WDdzbkUyd3lwNU1JSkxkWFVrZ0FjQWYrc3dVQTFtMzJPdTQ1czFrVGsyVmNt?=
 =?utf-8?B?OXFEQnlycHpHNDJoeWVmUlpFd3pQY3J6bW9MOS9GMHIzc1gzRXNpRVpsaTBm?=
 =?utf-8?B?SWVwVFdraHNiSEhGMjdGdnVqYjdOanI3RDdWVEhvUnpKa0kwTk1wMkVkVTVU?=
 =?utf-8?B?UEJMKytqeFNZVng5NGVjOThqcXlTeTZhQ09VN3c1ZzA2SzBaOGoyT1dmVHQr?=
 =?utf-8?B?ZEMxSDF3WEZ5ZG9HV2tuaklJOTkxK1g1ZHpJTDlzQWJ1TjJaeWZKdmh3Z01V?=
 =?utf-8?B?d1hBQjNoazNnWXlTZDFvbnViVU50aFJMN2hYcjJ2TjVkU2d2REx3YnNVa0RF?=
 =?utf-8?B?eE9oODhlYkVRY1FyNXNYQUV5cFJNZEZaaVJONzRpRDFHNDNaNjRkd1NNNmxy?=
 =?utf-8?B?Vy9lclkySGNkL1MwRW1zWTI1T1A3N3lhS01rNnUvQ2kzSk50NnkyRWdKeVRy?=
 =?utf-8?B?eGRjSnloTFF0VE9CZjkwZHlnQUhQbU42N3Rzek9aY2dLMUlyRG5xRllIWXgw?=
 =?utf-8?B?aktVOENsd3R6elZ2UVByb0pNSkExdDBkeWIxcGdOZWFtZkROUlVydW02a1lS?=
 =?utf-8?B?UEZwL3dxTWFjUjd3YmhjM2VUU09DcUVSZXVwanU1ejZOUHVpNmJITTBhM0J2?=
 =?utf-8?B?YUgyZm5hTUZyRG9jOVVOVkxTWE1lQWxLak1pazNvTWZrTFhEbE5QRURUeHVW?=
 =?utf-8?Q?Zt34=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35012462-a92c-4bb2-b303-08da7a3bf209
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 19:18:30.8103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRpvlBIcdUYQhXCpr3SkGE0tD1VDmvKhY8ivvJBxyF86qbyqMUK97QUTTaAMzjPAaeGKYbgpXz5MH7FjAydq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA5LCAyMDIyIDM6MDkgUE0NCg0KPiA+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDI6
MzkgUE0gQ3VycmVudGx5IGl0IGlzIG5vdC4gTm90IGENCj4gPj4gc2luZ2xlIHBhdGNoIG5vciB0
aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBnb2FsIGlzDQo+ID4+
IHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiBndWVzdCB1c2VycyBpbnRlbnRp
b25hbGx5IGxvd2VyDQo+ID4+IGRvd24gTVRVIHRvIDE1MDAuDQo+ID4gV2hpY2ggYXBwbGljYXRp
b24gYmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0byAxNTAwDQo+
IHRvIHNlbmQgcGFja2V0cyBidXQgd2FudCB0byByZWNlaXZlIDlLIHBhY2tldHM/DQoNCkJlbG93
IGRldGFpbHMgZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQ0K
DQo+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBh
bmQgTVJVLCBpbiB3aGljaCBjYXNlDQo+IHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVj
ZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUgd2hlbiBtdHUgaXMNCj4gbG93ZXJlZCBk
b3duIHRvIDE1MDAgZnJvbSA5MDAwLiANCkhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1YdSB0byAx
NTAwLCBzYXkgaXQgaXMgaW1wcm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mIDE1MDAgYnl0ZXMuDQoN
CkRldmljZSBkb2Vzbid0IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNl
IGlzIFJPIGZpZWxkLg0KRGV2aWNlIGtlZXAgZHJvcHBpbmcgOUsgcGFja2V0cyBiZWNhdXNlIGJ1
ZmZlcnMgcG9zdGVkIGFyZSAxNTAwIGJ5dGVzLg0KVGhpcyBpcyBiZWNhdXNlIGRldmljZSBmb2xs
b3dzIHRoZSBzcGVjICIgVGhlIGRldmljZSBNVVNUIE5PVCBwYXNzIHJlY2VpdmVkIHBhY2tldHMg
dGhhdCBleGNlZWQgbXR1Ii4NCg0KU28sIEkgYW0gbG9zdCB3aGF0IHZpcnRpbyBuZXQgZGV2aWNl
IHVzZXIgYXBwbGljYXRpb24gaXMgdHJ5aW5nIHRvIGFjaGlldmUgYnkgc2VuZGluZyBzbWFsbGVy
IHBhY2tldHMgYW5kIGRyb3BwaW5nIGFsbCByZWNlaXZlIHBhY2tldHMuDQooaXQgZG9lc27igJl0
IGhhdmUgYW55IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
