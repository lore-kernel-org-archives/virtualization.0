Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2340CCA47C
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 16:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B05740D01;
	Tue, 12 Jul 2022 16:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B05740D01
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SmkhbLSR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNguwH869YrQ; Tue, 12 Jul 2022 16:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02C464018B;
	Tue, 12 Jul 2022 16:48:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02C464018B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA7D8C0033;
	Tue, 12 Jul 2022 16:48:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58923C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 16:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3224F60C30
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 16:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3224F60C30
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=SmkhbLSR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvUK8xB-SYa6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 16:48:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB48160B1A
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB48160B1A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 16:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0tGSgQIVJSe6JywTt0VzYQbis+qm6aw+jbwzNjk60CLE/iH0un2SsEju5hslYwwnqlWjmoBCfzTHL2XbOQemJMtr0fED5Na+jq4ZqOoBwRUHj4rD1AOhkgKJjiwB4V8NZ9jWQKI8WrhxR7+EpBTHU9dP24eyQ1r9EmkfB1wMFv3+DZJIAOdUSCfMj9cvMBF6siLr10BLOBpMxSpmlCh2OAAhvzmth//Ny/6VJLn3zYoFevStEzJobU6uWqFocDVA9f9m/DsgbV6zaBVEdUcFJaye2ADlUM4QmxrYvXD3XEMopc6C1UT4R1TXy6tW3qkmtrKBkIvJdPnzWYJw1buXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gglm6vdkgDknSlV0OrPCOvWtKcAKpHCX1PlmZpQYtXs=;
 b=TsbcvlRWBYaHFe8PdpOEEBX70z8ZAkm07bxDrnzn+Xbdma7o5fgxeCDctz5qiFnN0E68rxqrUZvToeBmFblAZiWoeEemAZT1+oxFN1SztHRB32wivgoY14v+5pwfdFygHyGAWvTbB3sVga0tQuiaGGHAx8JlEYD1aT2OgdoytmPHx2+cNBgdkGBB6ktboWbgpcWcYUvDrg00UPn67WZMvB9r2ISl6z60WgWpAUh2nO8uNgXos/Zh5peZ6eIdnRKQV6ZFeYcVgau1JApXu/7AMNE9GsJknp0NER1843f2yt3+aUY8861zNAE7LRJ9947LQiVWP2ua8Plmv/Gyl8cwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gglm6vdkgDknSlV0OrPCOvWtKcAKpHCX1PlmZpQYtXs=;
 b=SmkhbLSRjybj2/9inuQJnGLSn4bu3RYM9/iv0l9/qFhU6SivobVOMdjSf6wn+16CPR8fLT9+kWVuPJ7MkWDiSz2UYXyEo8mYtbcub9945UAiNbUgfAP7qBjuy1p/cJ1rm7einuVAa4LVTYTxaV3xlQfY5foYsRaRE4w0tXZNSMjlkqBkKpbIZBELZn3Ne0bmsMlowxxHHI75npyv3kPTdI1Bs5yfl7uzwFZhCpZkLPUoZgt8VrT4yp/XQwjr1h/ksG3Afcu2NjJIOzMPVuIkgzViHYhllViQ0E4z4RxShXmQ9eWnrvuD9jQFPe3gr+4yTnwshxVdWuFlRr7Fqjqgyw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 16:48:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:48:22 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYjU+OpP/4aLhN20eCCMO4rbOEoq1qEloggAn4zwCAAKXGEIAD0JkAgAJ/vUA=
Date: Tue, 12 Jul 2022 16:48:22 +0000
Message-ID: <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ef1c42e8-2350-dd9c-c6c0-2e9bbe85adb4@intel.com>
 <PH0PR12MB5481FF0AE64F3BB24FF8A869DC829@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
In-Reply-To: <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 966c3f20-2753-462c-057e-08da6426552b
x-ms-traffictypediagnostic: BN9PR12MB5180:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tViPTH178/BxwTmC8jvzZaJ3KyvtKmddcgeRtQVc9l6YjD/Q+PrmfIdXk2zaTmKT6oDPqMpF0UXBX9xauxTy/qJAQcC/84l6fOAhHmnmKKXYGR7Tfps/3YYS0YI4sqprtmLb/Nr+cFi9p+oLWJXS4FI0dFFeELetdPVQE6AeWZCneHUFlcSOJVAl9kNkPfIKCi+TjI+Sqa39GZv1GlcWi2m9uqlHDT4/GkQV7o0MYg7FF89OGzCbq7CX8F2ShsyVtzIWPkbLIP/SRJttMhnsaa5IoD50nCEZp47YGvYxOj2Om3NBNNKYfpFqlv5K8WQO7D8dExnMVAit7naIUpWsAT9ewP8HNdSU1gBidgUlimKxUZGy7fWDiHpNYOnjUaHgFuz7WkhPY9KYfEk7Z+eLDu+6/8qR13/+ELMFuWgGdl90pZs44jbHyJXDBHRQLe6YBTO3KG1d12zrHiDxjDEYZYxjn/WqoCl8CQPze0aSbRLKHFPityIA/eK4jWxko9TXENzFzbjEQRDaQzzxyv4gdkxW020geNdlWJaXWxesOdHsspdLoJT8huwEF76WOjCJ1zJM2+qCmw86Tnn7zeQ9P1XqCVowRmNUHlOR5V/qI6tZiIzemiEVczFZmupsxoYabyNMCqnUOPknJShfNPhG/0dO4mtRxrr1Wbcqnh8/qSmxEb+LF+2gvkvJARIy/Gs24Wu8U9i5jQAt7tcO3wM6LjQlusbInlemID/xhud8juefpUJKpqqn2D1nOmWH3qQmaasDOwq/ucY+Lx6PPt7+pzxnEuQiN3xBD/VZakVZYax+mUESKBJiEaGCog/E0XA+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(76116006)(8676002)(122000001)(66476007)(66556008)(66946007)(8936002)(66446008)(186003)(4326008)(64756008)(38100700002)(86362001)(54906003)(7696005)(316002)(52536014)(38070700005)(71200400001)(33656002)(26005)(41300700001)(110136005)(478600001)(9686003)(55016003)(2906002)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU0zc1ZjODFjY3U5bS9GbE9mbUJ6Rnp2VVlwVUw3RTBiMUZhakdLM2JBelM5?=
 =?utf-8?B?TkNvN0MySklXL0RDeTIzUkxlNHZKV1NIQStEYm9mYTZNS0JuQit0bFZTRUpq?=
 =?utf-8?B?dU0xdkZKaXNhYU82RFo4cEhUbXBJak5oYm1Ud1hHWm54bXphcU5rVHpjYzhB?=
 =?utf-8?B?SjNSTjk1R2NsdGN6VVh6Mmk0aDdoSSt6N0g2S2Z1eEJZbXJKNlgxWlFoanBZ?=
 =?utf-8?B?RGllb0ZvdzA5UEl6VURBMTBMUXJ0Z0ZHMk9WTFFmRnJKZ2Z4a1Z5bEx1cW04?=
 =?utf-8?B?eEJiR0FtWHlMZkZSZTQrcnZyYmRrWnlZaXpLcDdZQ213MGErUXJtVzlzMkNy?=
 =?utf-8?B?UnIvcDJ2OGpFRlMrd2N6NUN0UmptaTVtSGxmc1BZcnl5Y2pvUjFrZlM4ZCtD?=
 =?utf-8?B?bWdvSW4yQkZpbkdtb1ZxU0lNcGdiZmpJUUcxVG16TGxySmpEMVR1ejNMT3pi?=
 =?utf-8?B?MENWaFZadkVxMGFpV0dIWXhpTHFRb20vZjZubHB1RkY3SmFqMURxYXhPUmxm?=
 =?utf-8?B?ZmQwMlZXdWhlNG5Ta3pJWWtFcWpsdHl0YmJZNE1pSmU1Q0F2N3k2bmZOTDJK?=
 =?utf-8?B?dStjVXJmbVVxbnlSYWEwS0x5dWVsNUN1K2JkY2t0YjNodmpZa2lVRDlLdW1Y?=
 =?utf-8?B?bEY4eU5KNElYSGtIaEpMUGlwRGNQUjJnSXVyYkI5YWZIUjJqVnFOaHAvNUVH?=
 =?utf-8?B?anJRTUVuczdrT2E4bUdMZ0JOZ1ZqNTBHVm55YTcwWTcwTG5RbUJtK0EwbUJL?=
 =?utf-8?B?SitDSkM5RUxkWGI1VlgwMVdkV0w1UFp6K05hUFZiaGozV2QweCtzK0Nia0xq?=
 =?utf-8?B?bDhpV090UUNmcXRTS0N5N2pvcGxyUFdweUVBeS91a2VnZm16bnVBVys5TGZn?=
 =?utf-8?B?VThNYVhaSGR3OEMvNXFTeFRFSGo1S1BJU1JVbzVpY1BuMml4S21XVVU4VHc5?=
 =?utf-8?B?Q1A3UFc2bExEdGdUT242TTRudkRGc1IxWFZDWWNMb05qWHlFbklIWDJ6MFVm?=
 =?utf-8?B?TndqK0tMTHFUTHhWS3pRcWJQcjBJdTV6djQvdUc3Y3FBY0NaWkZuTE14azFQ?=
 =?utf-8?B?eDZONHVydXQxN1BGZlhwQTZMUVY1NWpQUWoxd2RTenVlSUV2TFhWTWphV0tC?=
 =?utf-8?B?L0FzWHNPTmxFUVdoczJXb3dzd2V2cCtQRDVkc09ubW1RNzBBeHNZUDBKM0R1?=
 =?utf-8?B?ajR4TXVLem42b3ZCdGNIVDdpdzJUZWtkV0Y0WWFWbDJrZnBxN1pLcWs4d1RW?=
 =?utf-8?B?UG1qdytWek9RekZhMEN4TWo0WW5mS3h1dlVBa0ZOa3B4RStBQlFMQk1jR1M2?=
 =?utf-8?B?cWVQMzVqYUovdDZ2T3Y0emZrS3hnNjNoMjE2Z1JpcUY4Wk5rd1NyMy9IaUFm?=
 =?utf-8?B?SFNUNUdMcWhnOGdqSmw3UWlMUDNOdEx3Uzc2RlM4ZFovdUJEVUxTMzllNzEr?=
 =?utf-8?B?Vk5XYXJoa1hLSWcrY3lOcHdZYXgrbzVieW1LeW5EMTRndGhhWHl1TVEzOFEr?=
 =?utf-8?B?WnpYVjVnZGtIUndMYjVPeFNLR1p1VUxIZll3c0QyZWNka0tXR21pa1pwNEhM?=
 =?utf-8?B?VTBoSUJCanduRzJORVhJQk9sR0hQcmtLQ1RXMjN6Q2pEQVUweE9kU25hQVpE?=
 =?utf-8?B?WTRuSHV3M05zOWxFKzVjaXQ2Y1pTblBaMmE2Y09INXJHcVFzbG9mR3FsSnNQ?=
 =?utf-8?B?NVdoc2FFRldmTDZWa1VNZWVmQ2lKTEl4cEhpYmg0L0QwcmJDUmhEQ0c4WVYw?=
 =?utf-8?B?Rm9HYStOT2EvWTlDMXBqVzdwdGFjSUpZNjJpODN0N0ZvQ1hZenVxa3Q1bFYr?=
 =?utf-8?B?V1RYRVFGNG9ZL1g0QWV2Zm4waTdMVnpNV3lxSW5nTDF5eVNoeTFLZVhhZmhl?=
 =?utf-8?B?citJRklaNXQwNWgwMmx5akZXVjNmcFpqdTRlcWloa1ZWaC8yOXQ0ZURCZk82?=
 =?utf-8?B?QTEzdkw5OGlBemxVaGFTRXYwbEhHeXZjNGIyUUtTLy9tRUFCU0xEemtJRXZY?=
 =?utf-8?B?VkgySFhKTUJ0U01sVHpLaUxUdkFNaGU5UFNyREc4a25kTitwYjB4djllS0da?=
 =?utf-8?B?MVJqTVl3N1RIRHdoWFdxQnlZc1FDa3dLLzN2SkJBd05yYzBrWVU2S29KWVl1?=
 =?utf-8?Q?IOlk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c3f20-2753-462c-057e-08da6426552b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 16:48:22.6451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bM4BKrJfKlDZzC9vjvoNCSqGAgnbMAMRbq1LFH5UBqW8X56t7fDII1o0zHQ8DLu5ig2IJ+O+0/0utIxTUO3U7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
IFN1bmRheSwgSnVseSAxMCwgMjAyMiAxMDozMCBQTQ0KDQo+ID4gU2hvd2luZyBtYXhfdnFfcGFp
cnMgb2YgMSBldmVuIHdoZW4gX01RIGlzIG5vdCBuZWdvdGlhdGVkLCBpbmNvcnJlY3RseQ0KPiBz
YXlzIHRoYXQgbWF4X3ZxX3BhaXJzIGlzIGV4cG9zZWQgdG8gdGhlIGd1ZXN0LCBidXQgaXQgaXMg
bm90IG9mZmVyZWQuDQo+ID4NCj4gPiBTbywgcGxlYXNlIGZpeCB0aGUgaXByb3V0ZTIgdG8gbm90
IHByaW50IG1heF92cV9wYWlycyB3aGVuIGl0IGlzIG5vdA0KPiByZXR1cm5lZCBieSB0aGUga2Vy
bmVsLg0KPiBpcHJvdXRlMiBjYW4gcmVwb3J0IHdoZXRoZXIgdGhlcmUgaXMgTVEgZmVhdHVyZSBp
biB0aGUgZGV2aWNlIC8gZHJpdmVyDQo+IGZlYXR1cmUgYml0cy4NCj4gSSB0aGluayBpcHJvdXRl
MiBvbmx5IHF1ZXJpZXMgdGhlIG51bWJlciBvZiBtYXggcXVldWVzIGhlcmUuDQo+IA0KPiBtYXhf
dnFfcGFpcnMgc2hvd3MgaG93IG1hbnkgcXVldWUgcGFpcnMgdGhlcmUsIHRoaXMgYXR0cmlidXRl
J3MgZXhpc3RlbmNlDQo+IGRvZXMgbm90IGRlcGVuZCBvbiBNUSwgaWYgbm8gTVEsIHRoZXJlIGFy
ZSBzdGlsbCBvbmUgcXVldWUgcGFpciwgc28ganVzdA0KPiBzaG93IG9uZS4NClRoaXMgbmV0bGlu
ayBhdHRyaWJ1dGUncyBleGlzdGVuY2UgaXMgZGVwZW5kaW5nIG9uIHRoZSBfTVEgZmVhdHVyZSBi
aXQgZXhpc3RlbmNlLg0KV2UgY2FuIGJyZWFrIHRoYXQgYW5kIHJlcG9ydCB0aGUgdmFsdWUsIGJ1
dCBpZiB3ZSBicmVhayB0aGF0IHRoZXJlIGFyZSBtYW55IG90aGVyIGNvbmZpZyBzcGFjZSBiaXRz
IHdobyBkb2VzbuKAmXQgaGF2ZSBnb29kIGRlZmF1bHQgbGlrZSBtYXhfdnFfcGFpcnMuDQpUaGVy
ZSBpcyBhbWJpZ3VpdHkgZm9yIHVzZXIgc3BhY2Ugd2hhdCB0byBkbyB3aXRoIGl0IGFuZCBzbyBp
biB0aGUga2VybmVsIHNwYWNlLi4NCkluc3RlYWQgb2YgZGVhbGluZyB3aXRoIHRoZW0gZGlmZmVy
ZW50bHkgaW4ga2VybmVsLCBhdCBwcmVzZW50IHdlIGF0dGFjaCBlYWNoIG5ldGxpbmsgYXR0cmli
dXRlIHRvIGEgcmVzcGVjdGl2ZSBmZWF0dXJlIGJpdCB3aGVyZXZlciBhcHBsaWNhYmxlLg0KQW5k
IGNvZGUgaW4ga2VybmVsIGFuZCB1c2VyIHNwYWNlIGlzIHVuaWZvcm0gdG8gaGFuZGxlIHRoZW0u
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
