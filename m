Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C6CCA47B
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 17:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50D0040178;
	Tue,  5 Jul 2022 17:01:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50D0040178
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GkC6WBXV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCrLOL_m20gr; Tue,  5 Jul 2022 17:01:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B50224015D;
	Tue,  5 Jul 2022 17:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B50224015D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 866CEC0032;
	Tue,  5 Jul 2022 17:01:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE22C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 624DA60E78
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 624DA60E78
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=GkC6WBXV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqCWoGzoieaq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:01:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5C1260BC5
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5C1260BC5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgbGZNkOD+uXjZGzQ72lMDdx0uiTLkeQMIfX9alVAXP7KSS8XoZvzXBtRrxLKmBdUKObPtCwfh6c3zewuH0DK/AdV/opWlGhvUYrBP07bVzTn9f1LaTWuxDSZddDEY1Ef1jUUJiKhQ6sq6rBTn//4YfgUm6WSJJX6QaYRUY1kqeJKwNxW8oA4AZ4UuHCFnsh7+QMCsDfTVIl236G7BZCXk2/0zR1e+iuTMfS7FHLVL60g9++cwdIcJZgkplrqHUjtYW6CV50dVF7SZKqqagJHk3FqqHEOdg1kpoK3l4G9hPx0sSDPTDkrmLbNM1PhaogxBDxwRiYamXzG7wyfUVOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0MFYHS48Xuak5xe3Bt8qxuxEYcY/9d4ua1fhID9C2g=;
 b=jzDw0addDn3a5DGRwPgav1m7yJi90eV08qaOBC8syufbr+q8tIMRC5yBLPFG8K4S2OK3/Gz/fZITGAFGaG/lN01d6udFrzKyyHwK1NamDomec2xScqQCv2APXmCqo4OGsSZVnd1s+viPqxskTUxg6qoLftQvprKbh0l51GiBdDvuiqQRR8wiODwern0OOyfl8eN9AU0CH4VqCR3N+txQsIni8OVD6b3/I0Bf5J/qxg6+a4R75T/C6/l+nQaExZAK4h1dylrO7cM+8Y0yFMVOvpPPYPsV/ISlOnQzberDPqGeODEdxvWgvKYe/iBVBFZzSLCYiz6xVMEiQmmk11AfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0MFYHS48Xuak5xe3Bt8qxuxEYcY/9d4ua1fhID9C2g=;
 b=GkC6WBXVTRl+WsGYr+MxGNm7WXMfoPYln5UwNsSrx2XEYleWsMWEZpqrM+ySG+eSPdpTeBO/g2JyCqWFYJuPRjpOeeGJW0T9eRRnqBRh1sijR3xQx7ZkGhCGY9OLVuS1rDPqnJfg5kKAIeovwNKrH3kmiP77HPwimYvmj1cR2EPgsF2iUn1z/KTp0JMNl5f5EfQVtx1ZfNIxqULRlZuGv9XJfo+QEruelGFL2hzdsvYBmpskoerWbIFDrHBSaYLSfWe6a2Po8iFYUnFwpt+lwK0IT6dse/KGprWlORtus0jdHadpYIYZVxlKM7b9OGYWYkHXKTHBIk8r7YfsRxtHNA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 17:01:24 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 17:01:24 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYjU+MYrbSKcBokU6ni+IvOk3zwK1qDqQggAOY1gCAAIePkIABQJ6AgABBuVCAAFRBAIAAAK0Q
Date: Tue, 5 Jul 2022 17:01:24 +0000
Message-ID: <PH0PR12MB54816A1864BADD420A2674E8DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-4-lingshan.zhu@intel.com>
 <PH0PR12MB5481AEB53864F35A79AAD7F5DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e8479441-78d2-8b39-c5ad-6729b79a2f35@redhat.com>
 <PH0PR12MB54817FD9E0D8469857438F95DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1e1e5f8c-d20e-4e54-5fc0-e12a7ba818a3@intel.com>
 <PH0PR12MB5481862D47DCD61F89835B01DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a59209f3-9005-b9f6-6f27-e136443aa3e1@intel.com>
In-Reply-To: <a59209f3-9005-b9f6-6f27-e136443aa3e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b49e1039-5921-4c01-498b-08da5ea7fe3a
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HOldIvMkBoENIeeXuNCggcZ5CX325+G9xBz5Ta2ZhchvcGD/kz1MvNOZVcUvyuR8eJdt4eqafCgfkcbZpKYnnv4ehL9wCxqllc3Ed2eu2dQbS3Ue/U+37REz3C4UVnGVf+6RSkZsq0rLNM3o/IJHljftBt0Hb4sGwD/x/LigaK8I1+woFVVGZYaHrKOv0fB+V2D7FS1nDt/dUxfeNUlAdopqcBp6SpnBbVtk0i0rpXOPuhhBwaRiVCdrFfYp7s0+ANrEKYlhg1BhduJi2kxJXpOyrHFk8rLTAWNCPokUuVKvJtBQQcVdnRbzMtm0cDPNg867TP/6WIk3XcPG4qSVknK/9eheN3qtrokF5huGZk05LosdWimZ0BrBC/aZbsmw4ZGsoC+MsYsMpIOY4Bh8IeLaF4tO+IfzVKxDh5QLfFXLX+dCHsbOF+12V7b78pv/H/Fvoqjd1fjYbpVKJ17pM0FaHHjvRYDZegxn6/DQIzFo8R5igQwuCWC3DPzq3Z7SnR6NKclaMyvymX2jAcy+nwX4+8cqit57SkKNaxuj5GchH5t2oTllJq0BbV8AYYNy0p81XtVEktY3V7ci/BlGMD3LMioOmlQTfwIkAKRdeISwWM5hf/sxg9YCk/nnJa0xHlkSXNy2e8/she9o8J5l7Bbg9uy4Wlfp/TygfLuewRhegKoGEqbzTIXpzJe5sGx6gFTpJvYHQIyTJgGCDmwK36L4YP6JDpmih6XXSQYKQ8n2y9YLF6iXo5rbkmzEp5yewqrN8xpZjtNKg4aoylVM5NS5do9IASMNWyx6hf/pb2uqbbzfiaFIA3VCgIBhJFBv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(76116006)(8676002)(4326008)(64756008)(66446008)(66946007)(66556008)(66476007)(2906002)(86362001)(38100700002)(5660300002)(122000001)(8936002)(52536014)(38070700005)(55016003)(41300700001)(83380400001)(26005)(9686003)(186003)(7696005)(6506007)(316002)(110136005)(54906003)(478600001)(71200400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXhiWVIxRjJTeDBPSkZGdHZDS3ZmMndEdXZ1UEV0WENGTEtNV09ieHVBT3lX?=
 =?utf-8?B?UC9jSDBsTHpJc2dmSGhPRmQzdUdOeCtCajcrV21Bc0lpdkgwbnIrYzI4QitU?=
 =?utf-8?B?akxVNDBJVUFmeU5FMFZ3QW9adVZVdXI4SFNjQkZoS1czc0xKN3NWS0NpSjYx?=
 =?utf-8?B?VkxCZnVlZmk5MnRnKy9QUDNFc2ZJR25oeFdZRjZJY1Q2c1VvbU80cnRhTDJp?=
 =?utf-8?B?MFNtNy9LbWVqcndxMDRRNVNxZ0xJWFdDWndiTGFIS3U0RStQTjNTQWpYalR4?=
 =?utf-8?B?V1hmZUhra2FqK1h1M1BKOWFuVVAwblJlREdlcGk1cnlVQjhJT0R4WjVvcS8v?=
 =?utf-8?B?RGtCR1FDS2NrZnhJU3cwQVdKNmMxM1ZYSzFmZjI3TWl4NUMydTZ4T2V1ZzEw?=
 =?utf-8?B?ZW1HNUtIM2Eya0FhQ0YwVzJINXBUb3ZwOTNmTGpUM1V1ZTdja1ozVVpob0s3?=
 =?utf-8?B?TlBOZGhjR1lHNVdWR3hGNWx1dFRUeVVILzNnYXpkYmVTbXE4NDJGWFNvcGZy?=
 =?utf-8?B?VVZ6TGtkYXFPaitwd2xPeHZndHc3ZkpaYTJMVmozajRSM1lqRldBNVB1ZUs4?=
 =?utf-8?B?SnY4OG5LV1RvcWJvV1UycWlkKzE3dDB1cXRQdE9XeVRMWnA5VHFEVFFON3Zl?=
 =?utf-8?B?UFE0cWRJeG8zV0VFWVQ4ZCtLYVFqTWEvS2NjNUZWRmtjNk9xL2ZEdUR4ZU1a?=
 =?utf-8?B?dHcySnM4cW55RmloY0lMWFRBSEptR3BWTkRSR2Y2STZ1bXpXWXBYbk1LYlUw?=
 =?utf-8?B?Nmk2ZXhFdjRwVC9WMGpNSnhFUTVkTmpwbkN1dUcyYlpNZVB4S1V2QnR4Rjh2?=
 =?utf-8?B?U1c2KzZXUHpXYlE0MUFnbE1aVzFYSi9zdURuTDlodk5zb1RvRnlhVHdSVldB?=
 =?utf-8?B?SUlMLzhVRDFud216VGJsaGNkNW5jNHBtNWNtUjRSU2Mvc3lXbzUyRVNzVUVB?=
 =?utf-8?B?b0dJVU1TWmZDdnczNGJKVUt2Q2d0Q0JCTVRoZThsa3NRYmJwVUZZM0xYRjl6?=
 =?utf-8?B?RU14d3g3c0tablVaOEt2YzZOK05YVFc0VUFKYVIvL1pGdGpob0h5QXlIYWxi?=
 =?utf-8?B?aVEzZ0w2c1MydWUwQ1BUWDYrclMrNzlLc09Nek5iWW9yS0tLQ0xYWjNiRk9h?=
 =?utf-8?B?TlRMakpDeDE0NU53aFNDL09yMVM4UmZRRDFPc1RHYlNZRDRrK1ZKczJ3aW1M?=
 =?utf-8?B?R256eXFFdkRDQ3luUWpTYUo0T3J4bjRLN29YSGhBYWl0dGlkR2lqdWF5RjNG?=
 =?utf-8?B?Y1RKY21nSmxBZ202elZlMm1QbkZIeWd1NDdUbzUwYlpSa2xOVVJtVlFrR3dY?=
 =?utf-8?B?V2VOSS80QksvNG1yanpWVnNhN1l4THhXOVIydEpDNFBpNEtrMjZkNnFVQU1V?=
 =?utf-8?B?VjNxTFdsd0hzSlh0NnVYOTVURlN2UFNxYlJQSkpHbXFPQXhuSUVGaFZhNUZ3?=
 =?utf-8?B?TjM4YWF3aHFnQWQwc2FYeFJPQkFtdTFNdVZlazNqenNBZ0dTdjNHcG5MS1BW?=
 =?utf-8?B?dzJPdTA2RVR1cXQ1RWFSOXdQelJiQlBTSDRKUFhlTkJUNGlXVXV2dUpmYklP?=
 =?utf-8?B?NEZ6TUtPS1dhK0JWRW81TGpValhaZWhPRWIxbkNzMVoya3dCTVR5ZkJETkhJ?=
 =?utf-8?B?ekNoVDQvbUwyWE5ockUyVGJLbHpRRDRHUVp1dk5YN2FDNlhETU9QNWN2cThV?=
 =?utf-8?B?U2llT2J0VXZpdjZGSVJKZ1RhSWlxNEloV2Z3YmVSR2NmR3c5ZElvYnpzL1gv?=
 =?utf-8?B?TG1mRE0rZWMrWUZ4OHlHMlE5K0g4MmtBRTlDT1VhM2JuaWY1RjNYZS9RQ1o3?=
 =?utf-8?B?NGRSV0dMc3RMbE1SZjg3VldmemdXazZMZVRWY1ZoZXlvQWhPay80cUFGZUhk?=
 =?utf-8?B?emxKSk5rTHAyZ2NnTFc0VHZQajVWUjI1dU1PRGU0R2NMM3crVHBTMjdvRlFr?=
 =?utf-8?B?NGJseEFzWjIwRE1QWkdaMVNwSC9wcmtqMUo5VUlIUUxsb3krM3BveFFYc3R4?=
 =?utf-8?B?Ymk5eGtvaTM1WDljWXExQW9VY2tqdTVQVGZmZHJJZzhacy8vaUlVb1p0VERM?=
 =?utf-8?B?UVhnU0I4RVV0OWdVNnFTUjFMcER4N2wyYkZid2ptbG5xZ0J0ck1jVW1JMEdF?=
 =?utf-8?Q?vFfM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49e1039-5921-4c01-498b-08da5ea7fe3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 17:01:24.3503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8H8kkUlApjhZHFJqda43Opj8G+0G3cdR4reUSYnRCtMsij/uEQzcNyVIhJCBJgj2bPB6P8pmxtAmfO+kF9kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4614
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bHkgNSwgMjAyMiAxMjo1NiBQTQ0KPiA+IEJvdGggY2FuIGJlIHF1ZXJpZWQg
c2ltdWx0YW5lb3VzbHkuIEVhY2ggd2lsbCByZXR1cm4gdGhlaXIgb3duIGZlYXR1cmUgYml0cw0K
PiB1c2luZyBzYW1lIGF0dHJpYnV0ZS4NCj4gPiBJdCB3b250IGxlYWQgdG8gdGhlIHJhY2UuDQo+
IEhvdz8gSXQgaXMganVzdCBhIHBpZWNlIG9mIG1lbW9yeSwgeHh4eFthdHRyXSwgZG8geW91IHNl
ZSBsb2NrcyBpbg0KPiBubGFfcHV0X3U2NF82NGJpdCgpPyBJdCBpcyBhIHR5cGljYWwgcmFjZSBj
b25kaXRpb24sIGRhdGEgYWNjZXNzZWQgYnkgbXVsdGlwbGUNCj4gcHJvZHVjZXJzIC8gY29uc3Vt
ZXJzLg0KTm8uIFRoZXJlIGlzIG5vIHJhY2UgY29uZGl0aW9uIGluIGhlcmUuDQpBbmQgbmV3IGF0
dHJpYnV0ZSBlbnVtIGJ5IG5vIG1lYW5zIGF2b2lkIGFueSByYWNlLg0KDQpEYXRhIHB1dCB1c2lu
ZyBubGFfcHV0IGNhbm5vdCBiZSBhY2Nlc3NlZCB1bnRpbCB0aGV5IGFyZSB0cmFuc2ZlcnJlZC4N
Cg0KPiBBbmQgcmUtdXNlIGEgbmV0bGluayBhdHRyIGlzIHJlYWxseSBjb25mdXNpbmcuDQpQbGVh
c2UgcHV0IGNvbW1lbnQgZm9yIHRoaXMgdmFyaWFibGUgZXhwbGFpbmluZyB3aHkgaXQgaXMgc2hh
cmVkIGZvciB0aGUgZXhjZXB0aW9uLg0KDQpCZWZvcmUgdGhhdCBsZXRzIHN0YXJ0LCBjYW4geW91
IHNoYXJlIGEgcmVhbCB3b3JsZCBleGFtcGxlIG9mIHdoZW4gdGhpcyBmZWF0dXJlIGJpdG1hcCB3
aWxsIGhhdmUgZGlmZmVyZW50IHZhbHVlIHRoYW4gdGhlIG1nbXQuIGRldmljZSBiaXRtYXAgdmFs
dWU/DQoNCj4gPg0KPiA+PiBJTUhPLCBJIGRvbid0IHNlZSBhbnkgYWR2YW50YWdlcyBvZiByZS11
c2luZyB0aGlzIGF0dHIuDQo+ID4gV2UgZG9u4oCZdCB3YW50IHRvIGNvbnRpbnVlIHRoaXMgbWVz
cyBvZiBWRFBBX0RFViBwcmVmaXggZm9yIG5ldw0KPiBhdHRyaWJ1dGVzIGR1ZSB0byBwcmV2aW91
cyB3cm9uZyBuYW1pbmcuDQo+IGFzIHlvdSBwb2ludCBvdXQgYmVmb3JlLCBpcyBpcyBhIHdyb25n
IG5hbWluZywgd2UgY2FuJ3QgcmUtbm1tZSBpdCBiZWNhdXNlDQo+IHdlIGRvbid0IHdhbnQgdG8g
YnJlYWsgdUFQSSwgc28gdGhlcmUgbmVlZHMgYSBuZXcgYXR0ciwgaWYgeW91IGRvbid0IGxpa2Ug
dGhlDQo+IG5hbWUgVkRQQV9BVFRSX1ZEUEFfREVWX1NVUFBPUlRFRF9GRUFUVVJFUywgaXQgaXMg
bW9yZSB0aGFuDQo+IHdlbGNvbWUgdG8gc3VnZ2VzdCBhIG5ldyBvbmUNCj4gDQo+IFRoYW5rcw0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
