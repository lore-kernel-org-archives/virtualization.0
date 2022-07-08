Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA748C43334
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 16:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB898482F;
	Fri,  8 Jul 2022 16:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CB898482F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ezmIyyfd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_ibWGadeeSK; Fri,  8 Jul 2022 16:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 751D18481D;
	Fri,  8 Jul 2022 16:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 751D18481D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CFDC0033;
	Fri,  8 Jul 2022 16:23:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D7AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 708AD40650
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 708AD40650
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ezmIyyfd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Moh57Wy0IXya
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:23:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53BB74019C
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53BB74019C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKNdFDbgiuDH4UL59hQE0tXUupd6uNHZAoTl1UayAN1BEv8iOSKrfIXMnRb4Oz2HF6Ih3fserwSG8ZBDAbNYrbVcUO7WZB/CmAJt4lBhAYmpatDpjcA5Wl8Y8RljNm7V7+MJAWZ8uEBFqcmorI0gFk0T2i1aNcnkLRvtVGvbxR8Ek7ZHrZGh3G44knGWc93njJogoPER8mjEK/OKwfab/06L8mLbhhoO0i/XVwn3H9xDLcMRp/wKlmOtokTFIGN8U/76hqvP2rkLNlMxBrry3LGvSChtgXl3ZmvlEcb+ezAn7O78XZnXmA1vy4PShazG8vNVjGqmu2CVvh9yK9brKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAKN/YpVXhtq1C137PMn9Bq+t+mDhW6roraeN43xmZc=;
 b=DVoUt2qf4Hqbsn6zKzmM9YeWXz1WDbCYpZ6iCR48n1WprwCSpMamq0uhNEO0VOprY2bkAAUoAKHvURm8NuC1oW0iIV8BbKisN9GhUHOqo6Cipff2tQ/ns/XI6p46e+4pC9b2s9vsxVXXOCSNS1lGkH6H6hYZU7RdMcqQPshErjr1+yg95+GhqUf2gAbEhO+q608ici6EQnBK7CIs927pm0O1i19+NhKCU7btCXewNLRaB75BN0f18r0W4lSQvMepfnFvG3hgxWdgxhFcgLIez5mhfL3Ythuqp64dF8xFQBFom1WZM+4GagFhy2qU0fHfDYHvJkTdeygOUEfzAuDVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAKN/YpVXhtq1C137PMn9Bq+t+mDhW6roraeN43xmZc=;
 b=ezmIyyfdicLWh/gI8NW6djqT0hlhMFrGA1uMRmzdcCQbOaFwvEnTYs5stsUisUnpQN6djQKzIYfeoBhKH7b9k34c637DrvGV+6qCpPQ/p2mFhfkLdedDumpA/xAArn9gzKNI49ztneCmVOULp3mHIX8AIVJtOHc/Q4awrkPiUfhIZfNK8sJehMM19kvyP63YIV4y3ClSCS2CKm6juba4o92SGiUiUmQ0D6emr4AHOEaMIsybnNZtrcyYUcy4yMh4w9wShkiPQWixBKdXoIx3KJOu6gXNdG1cq/KEkVQeW3i9xgTdJsE3jdE7KH1wvfX6NZGRCZwhsl9o22+hZ9EZ+Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN6PR12MB1284.namprd12.prod.outlook.com (2603:10b6:404:17::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 16:23:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 16:23:36 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYjU+OpP/4aLhN20eCCMO4rbOEoq1qEloggAn4zwCAAKXGEA==
Date: Fri, 8 Jul 2022 16:23:36 +0000
Message-ID: <PH0PR12MB5481FF0AE64F3BB24FF8A869DC829@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ef1c42e8-2350-dd9c-c6c0-2e9bbe85adb4@intel.com>
In-Reply-To: <ef1c42e8-2350-dd9c-c6c0-2e9bbe85adb4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6354110-55b0-4d01-776a-08da60fe358a
x-ms-traffictypediagnostic: BN6PR12MB1284:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkBRl63OLL5wFTDOP8GtHYFxpd8frErq9GfLpiCq+7WpWDNoYSWY3f5lh5+twGOsYiXD3OBw85F6e9xih0MuR3hUBu1fJ9wtG39+TXAnKX3MNY4bE8aTDn2EVaQONcviyyTvlS5rYizYUYzAwRzdNV4i1S3rUP1i9kYuW9nWkmpSrwG6glz7rWW4H+aGCZ5QbXS0hKXcMGR7TMryXUCRo7zg4+/T9pLC5JAhqLNyXQkwaEE/F+PCssgrembVK7ci5pHgX/lvgivBw8vimFCkteNqoo/ZD/ZzMwpse9m3HjTo7f4mfkw56gdqjynNPgMn4C/rE1pL+mYbHQS39TUN6qcj0dTCk9SxpBA7yu/Wqtc3KQG1ePyAiY06ooK3XJPY5HIENrDwnyULtWvRUySfol0lP4TIUXS8X4Hdb/zxpmiiqbzm6/V5zzbOmFXdw6RrHm5mZKyD8CWCLfbD/Nw1OIBM0QCloyyK0ppKS2+vDkC04lCM90zAHv7wSP+FpuWg53mV/Fu9F8I4GmukSnIThOP9LUuu+hOgKvfeBtSSEbrh1cuYPOiRlcH6LKI6U9BijGCFzhJraJrwE1PQwRWM1PvuJ2jvzIsynaMAcNph8dAJ+cbmz87wcBB2BV0GRowlrEzWZod+cvKnNk1qXX+WWknMYi39ZC1StfNBN43LT+zIgtziS9QufHrkgggjCSWE7TMsEmSZjp8SWDc3wCUnHM4C1+CUA/LF4t2rCDTWtl4ebWT5OHFE88noApWwtOTj5LK/vGxesh4V7lWHtvA4pvh8bGFByQeEdd//atpZFns5fgiv6A38Bo7Swp1AlZd7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(316002)(71200400001)(110136005)(6506007)(53546011)(186003)(7696005)(9686003)(55016003)(26005)(33656002)(54906003)(478600001)(5660300002)(122000001)(66556008)(8936002)(86362001)(38100700002)(4326008)(64756008)(41300700001)(66446008)(83380400001)(76116006)(8676002)(38070700005)(52536014)(66946007)(2906002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZUaGZnRS9hU2ljdUNRL2lvQ1dSdHIxdWJGQS96OG5hZ2hpbmg2SCs2eG1J?=
 =?utf-8?B?U1FiTktac3pLQjVieXpHSFVwK294UXo0eW5zR2pTTFZDdEhzQTNVMHlJeWtq?=
 =?utf-8?B?aW81b3hYdkgxYXFlTkdVbWlWRWJrd3VQcGNvTzJlbmVWNFozcVpRZzVTYUFh?=
 =?utf-8?B?UHl6RVpLd2FaQTdwZHdlSVQwMjF6NDVQdXpkMitHVUpxQVRyYUZ6NWlQbHI3?=
 =?utf-8?B?c1hPSFowTEF0OWhUd2h1ZnZmTTd6NjBvYnJUUjNWdjAxdDFXRzVHUWovUk80?=
 =?utf-8?B?a00rYzRobWpMazlLbTNrd3k1Wk5qcHdEOXV2ODdBWnhMOHA5VXdaNzlYTXdq?=
 =?utf-8?B?OGttSDlZd2VZZC9lZFdNZEFUVW9BVGxJT0dBaEtNaVdIbGc0eXpQTS95VGJw?=
 =?utf-8?B?YUpYZDlmaDQybW1yK0hYWm5Wbm9VMy9qVXRzTSs1TnpKU0FjSXI1bEpjQ20y?=
 =?utf-8?B?UlFvZGsvZTJwOFRTSTJNSkp1b2pxME9mdGUxeFhmZU1OUmQ0dHBwR3JmM2ts?=
 =?utf-8?B?OTFRRm5wZnFGakdacmlQc1JBRlNXTU1wRjA0VXBFWXRESktoeWcrQzc5OW5r?=
 =?utf-8?B?bG5MMW9EZkliNTNnMkVreDlBeE44NGpabXB5OWU4TDdMUkkvL1ZNZE1ETm1F?=
 =?utf-8?B?L2dyc3Zmejc2RHZDM3U3U2pLc2djS09adytyVFAxRVlVc0k4SWt1U0ZLMC9h?=
 =?utf-8?B?NURqdk9XdE5sUmNPYlZadHVxSXRtTXFud21DQ2xEZHZNbE0yRXpJMVlhWitj?=
 =?utf-8?B?RG8xM0djMUFxQlg0Y3c3WWk2WXB0aExZQXdsY3R6SEtiVURIMjJHVUp4b1V6?=
 =?utf-8?B?MzJ2QzlUYjVqdXUwaHQ3WmlHYjZYay9KM0lxU21xcDM5cmtlSHI2MU9kd3NV?=
 =?utf-8?B?NHl1MEtQTU44RktmM3RNd3R1MkFVb3dTWFNKbTV4NE9NSWZaWFo0TStnM1RX?=
 =?utf-8?B?K0RuSlo5RWV5NEd3YStadWxpY3pPLzlIQkcya2tHcHV2Q3R3THFlRXBEbE9M?=
 =?utf-8?B?dkhiUWJLOGo2R29qMGdQOHQwN29BMDBFZVBPZW5jTWhSVE13d1NtakhXS2NB?=
 =?utf-8?B?ZFFBVUVlK0hDVTIvWDBKSmlpdjhoS3pKUGZOOVY0WG5EbStQSEQyTjVkSkpD?=
 =?utf-8?B?QkRDaUIrUGZSNGN2S2paZko1bzVHSHBjSmtaVUFSTE5EZVhuUXBESHVQZTBC?=
 =?utf-8?B?SzN2UWlONTdyVy8yL1N2anljQkF0ZkxGTVhFSmFYU2tCcWFQcnZ4KzZVSTdE?=
 =?utf-8?B?R1BqWE9reG1KdmxwcXplMTNJWlZvMjBYVVg0WnJ2aU1QeHBWRmlxeGZLc0tM?=
 =?utf-8?B?SHhqSXc1dGNIVWpoVHpnTXZLdkpsc1RiZHdoWitDRDFRWk5TS2FGTjFBcUNQ?=
 =?utf-8?B?MVlJaFU2TWNFNnFZK1B6MlNYWCtBaGRqZkI2UW4xbmVzZGRBRTNKQ01NcjdP?=
 =?utf-8?B?cFZaYnNyN2I2K2RZV3B4VkVKcklIZDVoeEZkQmxJU2RPd080cGdUMkQ3Y1VW?=
 =?utf-8?B?dnRHcXlTUmdDU1ppOHdqNENGU1FuMWVaZCsxU0pyVnRTZjQ4M0pJRVRmRFVp?=
 =?utf-8?B?TEt5OUNPMTAyaURRNHJmMzhlVDhHUDJtTVlsenFUQmVPMkRjZDhGak1wd3dN?=
 =?utf-8?B?MW1IUmZVMCt4YllFVmRLa0VMRHZKWlBZL3d4ZHRhK2tPdXlOaHFDa0NVeXJ3?=
 =?utf-8?B?SFgrSDFHcGN1V1lQMXJaY25qendBZDl1Y25QZmU4SVJUS2tha3dOQzNHL3BD?=
 =?utf-8?B?OFpYVDBMVGFPbzArUGZPR3NLV3lsdUZ3ckRnSUxqdHU1OUFPaUtvZmFBQkVt?=
 =?utf-8?B?VTVaN0lqaW5abmtFcFRnZE9ocXNqQlZma0NuQW5TN2dnRmxlemtQRk9LUmZR?=
 =?utf-8?B?aWFwZDJ5R0Z5bmtZcHJsMllNSC95Y3ljMW5ZaENoM0R4K2pBakpaL20wQjdn?=
 =?utf-8?B?NitJYU1DQm9SWUYvSVlQdGEzWWRRaXR1WlUxR0xneEk1MkZ2SDVhZE5VUE56?=
 =?utf-8?B?cjhSRXoxYXN6WitiOTZEWE5LYTBkSndDNnhkVTljR0ZtemdyT0FTT2ZpTFJu?=
 =?utf-8?B?VzBqSG53dnMyczVVMjh5ZlY2eTJLSVBIY2xLZVpPVys5Rm1YQzVPV2kzd1cy?=
 =?utf-8?Q?k7Z0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6354110-55b0-4d01-776a-08da60fe358a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 16:23:36.1949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EjqqmgBc9ldUtg6KoEKx/OZhB+Oul0LPa0JNf5bvuky4XigaOcwQf1rExkYcvSuNaB09C/f4UEZBCk+6OhHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1284
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
IEZyaWRheSwgSnVseSA4LCAyMDIyIDI6MjEgQU0NCj4gDQo+IA0KPiBPbiA3LzIvMjAyMiA2OjA3
IEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogWmh1IExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiA5
OjI4IEFNDQo+ID4+IElmIFZJUlRJT19ORVRfRl9NUSA9PSAwLCB0aGUgdmlydGlvIGRldmljZSBz
aG91bGQgaGF2ZSBvbmUgcXVldWUNCj4gPj4gcGFpciwgc28gd2hlbiB1c2Vyc3BhY2UgcXVlcnlp
bmcgcXVldWUgcGFpciBudW1iZXJzLCBpdCBzaG91bGQgcmV0dXJuDQo+ID4+IG1xPTEgdGhhbiB6
ZXJvLg0KPiA+Pg0KPiA+PiBGdW5jdGlvbiB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoKSBmaWxs
cyB0aGUgYXR0cmlidXRpb25zIG9mIHRoZQ0KPiA+PiB2RFBBIGRldmljZXMsIHNvIHRoYXQgaXQg
c2hvdWxkIGNhbGwgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKCkgc28NCj4gPj4gdGhlIHBh
cmFtZXRlciBpbiB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwoKSBzaG91bGQgYmUNCj4gPj4g
ZmVhdHVyZV9kZXZpY2UgdGhhbiBmZWF0dXJlX2RyaXZlciBmb3IgdGhlIHZEUEEgZGV2aWNlcyB0
aGVtc2VsdmVzDQo+ID4+DQo+ID4+IEJlZm9yZSB0aGlzIGNoYW5nZSwgd2hlbiBNUSA9IDAsIGlw
cm91dGUyIG91dHB1dDoNCj4gPj4gJHZkcGEgZGV2IGNvbmZpZyBzaG93IHZkcGEwDQo+ID4+IHZk
cGEwOiBtYWMgMDA6ZTg6Y2E6MTE6YmU6MDUgbGluayB1cCBsaW5rX2Fubm91bmNlIGZhbHNlIG1h
eF92cV9wYWlycw0KPiA+PiAwIG10dSAxNTAwDQo+ID4+DQo+ID4gVGhlIGZpeCBiZWxvbmdzIHRv
IHVzZXIgc3BhY2UuDQo+ID4gV2hlbiBhIGZlYXR1cmUgYml0IF9NUSBpcyBub3QgbmVnb3RpYXRl
ZCwgdmRwYSBrZXJuZWwgc3BhY2Ugd2lsbCBub3QgYWRkDQo+IGF0dHJpYnV0ZSBWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFYX1ZRUC4NCj4gPiBXaGVuIHN1Y2ggYXR0cmlidXRlIGlzIG5vdCByZXR1
cm5lZCBieSBrZXJuZWwsIG1heF92cV9wYWlycyBzaG91bGQgbm90DQo+IGJlIHNob3duIGJ5IHRo
ZSBpcHJvdXRlMi4NCj4gSSB0aGluayB1c2Vyc3BhY2UgdG9vbCBkb2VzIG5vdCBuZWVkIHRvIGNh
cmUgd2hldGhlciBNUSBpcyBvZmZlcmVkIG9yDQo+IG5lZ290aWF0ZWQsIGl0IGp1c3QgbmVlZHMg
dG8gcmVhZCB0aGUgbnVtYmVyIG9mIHF1ZXVlcyB0aGVyZSwgc28gaWYgbm8gTVEsIGl0DQo+IGlz
IG5vdCAibm90IGFueSBxdWV1ZXMiLCB0aGVyZSBhcmUgc3RpbGwgMSBxdWV1ZSBwYWlyIHRvIGJl
IGEgdmlydGlvLW5ldCBkZXZpY2UsDQo+IG1lYW5zIHR3byBxdWV1ZXMuDQo+IA0KPiBJZiBub3Qs
IGhvdyBjYW4geW91IHRlbGwgdGhlIHVzZXIgdGhlcmUgYXJlIG9ubHkgMiBxdWV1ZXM/IFRoZSBl
bmQgdXNlcnMgbWF5DQo+IGRvbid0IGtub3cgdGhpcyBpcyBkZWZhdWx0LiBUaGV5IG1heSBtaXN1
bmRlcnN0YW5kIHRoaXMgYXMgYW4gZXJyb3Igb3INCj4gZGVmZWN0cy4NCj4gPg0KV2hlbiBtYXhf
dnFfcGFpcnMgaXMgbm90IHNob3duLCBpdCBtZWFucyB0aGF0IGRldmljZSBkaWRu4oCZdCBleHBv
c2UgTUFYX1ZRX1BBSVJTIGF0dHJpYnV0ZSB0byBpdHMgZ3Vlc3QgdXNlcnMuDQooQmVjYXVzZSBf
TVEgd2FzIG5vdCBuZWdvdGlhdGVkKS4NCkl0IGlzIG5vdCBlcnJvciBvciBkZWZlY3QuIA0KSXQg
cHJlY2lzZWx5IHNob3dzIHdoYXQgaXMgZXhwb3NlZC4NCg0KVXNlciBzcGFjZSB3aWxsIGNhcmUg
d2hlbiBpdCB3YW50cyB0byB0dXJuIG9mZi9vbiBfTVEgZmVhdHVyZSBiaXRzIGFuZCBNQVhfUVAg
dmFsdWVzLg0KDQpTaG93aW5nIG1heF92cV9wYWlycyBvZiAxIGV2ZW4gd2hlbiBfTVEgaXMgbm90
IG5lZ290aWF0ZWQsIGluY29ycmVjdGx5IHNheXMgdGhhdCBtYXhfdnFfcGFpcnMgaXMgZXhwb3Nl
ZCB0byB0aGUgZ3Vlc3QsIGJ1dCBpdCBpcyBub3Qgb2ZmZXJlZC4NCg0KU28sIHBsZWFzZSBmaXgg
dGhlIGlwcm91dGUyIHRvIG5vdCBwcmludCBtYXhfdnFfcGFpcnMgd2hlbiBpdCBpcyBub3QgcmV0
dXJuZWQgYnkgdGhlIGtlcm5lbC4NCg0KPiA+IFdlIGhhdmUgbWFueSBjb25maWcgc3BhY2UgZmll
bGRzIHRoYXQgZGVwZW5kIG9uIHRoZSBmZWF0dXJlIGJpdHMgYW5kDQo+IHNvbWUgb2YgdGhlbSBk
byBub3QgaGF2ZSBhbnkgZGVmYXVsdHMuDQo+ID4gVG8ga2VlcCBjb25zaXN0ZW5jeSBvZiBleGlz
dGVuY2Ugb2YgY29uZmlnIHNwYWNlIGZpZWxkcyBhbW9uZyBhbGwsIHdlIGRvbid0DQo+IHdhbnQg
dG8gc2hvdyBkZWZhdWx0IGxpa2UgYmVsb3cuDQo+ID4NCj4gPiBQbGVhc2UgZml4IHRoZSBpcHJv
dXRlMiB0byBub3QgcHJpbnQgbWF4X3ZxX3BhaXJzIHdoZW4gaXQgaXMgbm90IHJldHVybmVkDQo+
IGJ5IHRoZSBrZXJuZWwuDQo+ID4NCj4gPj4gQWZ0ZXIgYXBwbHlpbmcgdGhpcyBjb21taXQsIHdo
ZW4gTVEgPSAwLCBpcHJvdXRlMiBvdXRwdXQ6DQo+ID4+ICR2ZHBhIGRldiBjb25maWcgc2hvdyB2
ZHBhMA0KPiA+PiB2ZHBhMDogbWFjIDAwOmU4OmNhOjExOmJlOjA1IGxpbmsgdXAgbGlua19hbm5v
dW5jZSBmYWxzZSBtYXhfdnFfcGFpcnMNCj4gPj4gMSBtdHUgMTUwMA0KPiA+Pg0KPiA+PiBGaXhl
czogYTY0OTE3YmMyZTliICh2ZHBhOiBQcm92aWRlIGludGVyZmFjZSB0byByZWFkIGRyaXZlciBm
ZWF0dXJlcykNCj4gPj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVA
aW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgNyArKysr
LS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJz
L3ZkcGEvdmRwYS5jIGluZGV4DQo+ID4+IGQ3NmIyMmIyZjdhZS4uODQ2ZGQzN2YzNTQ5IDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvdmRw
YS92ZHBhLmMNCj4gPj4gQEAgLTgwNiw5ICs4MDYsMTAgQEAgc3RhdGljIGludCB2ZHBhX2Rldl9u
ZXRfbXFfY29uZmlnX2ZpbGwoc3RydWN0DQo+ID4+IHZkcGFfZGV2aWNlICp2ZGV2LA0KPiA+PiAg
IAl1MTYgdmFsX3UxNjsNCj4gPj4NCj4gPj4gICAJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklS
VElPX05FVF9GX01RKSkgPT0gMCkNCj4gPj4gLQkJcmV0dXJuIDA7DQo+ID4+ICsJCXZhbF91MTYg
PSAxOw0KPiA+PiArCWVsc2UNCj4gPj4gKwkJdmFsX3UxNiA9IF9fdmlydGlvMTZfdG9fY3B1KHRy
dWUsIGNvbmZpZy0NCj4gPj4+IG1heF92aXJ0cXVldWVfcGFpcnMpOw0KPiA+PiAtCXZhbF91MTYg
PSBsZTE2X3RvX2NwdShjb25maWctPm1heF92aXJ0cXVldWVfcGFpcnMpOw0KPiA+PiAgIAlyZXR1
cm4gbmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwNCj4gdmFs
X3UxNik7DQo+ID4+IH0NCj4gPj4NCj4gPj4gQEAgLTg0Miw3ICs4NDMsNyBAQCBzdGF0aWMgaW50
IHZkcGFfZGV2X25ldF9jb25maWdfZmlsbChzdHJ1Y3QNCj4gPj4gdmRwYV9kZXZpY2UgKnZkZXYs
IHN0cnVjdCBza19idWZmICptcw0KPiA+PiAgIAkJCSAgICAgIFZEUEFfQVRUUl9QQUQpKQ0KPiA+
PiAgIAkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPj4NCj4gPj4gLQlyZXR1cm4gdmRwYV9kZXZfbmV0
X21xX2NvbmZpZ19maWxsKHZkZXYsIG1zZywgZmVhdHVyZXNfZHJpdmVyLA0KPiA+PiAmY29uZmln
KTsNCj4gPj4gKwlyZXR1cm4gdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHZkZXYsIG1zZywg
ZmVhdHVyZXNfZGV2aWNlLA0KPiA+PiArJmNvbmZpZyk7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiAg
IHN0YXRpYyBpbnQNCj4gPj4gLS0NCj4gPj4gMi4zMS4xDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
