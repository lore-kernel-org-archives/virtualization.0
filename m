Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45007C77B7F
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 15:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1B35614E4;
	Mon,  8 May 2023 15:00:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1B35614E4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mPV53RzJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBlKdRmCUXqY; Mon,  8 May 2023 15:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE8B960B3C;
	Mon,  8 May 2023 15:00:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE8B960B3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE94C0036;
	Mon,  8 May 2023 15:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31CA2C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 15:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F042041B81
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 15:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F042041B81
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=mPV53RzJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id telqpeUlgjKb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 15:00:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E17641A49
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E17641A49
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 15:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3KepO+1e5+2VjDXFpbY0szQocZhtraS9ALDjcz28ve5FplwMil397EOJMw/S2zVJZ5kkg008QRmWxaM6cVukQwmGnQa6mCeoQ9ICsEmgBgqeTTPkBzIcKr2lvqCI9XH+gkAi+DiZakqdXcTZXwlQkb93Y6V6v/h7nCq7Cs7UtK4v1VI544a+EFXnTHbaNg2teOzxffg0rTFa0x7bIZPzRPdVZ3Xj115VyqqpizoILNDXhg8MOxw5DbVl6FF4J61lgLhu+0uUym1zWjVpTdIjT+BtmVUr8CoQwSLxdAWMP0zRSvO/1oE4nkri1q4AJw/o5FXLeMOFgzEQ60Ru+Uqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffok8hIsQW63zsYqbPR/sS5crKXEVo1At1D5Gg+QDY4=;
 b=UL41smXlYz/nqo0NH9lp2nj9gvVrc5zExrppmPEwIVV/Cr6G0HzTBz0zzxfriRj6APxjvZUn9sDN/3NYoh3j6HdmL1poLN4ln1lIdXPIhlbYB2jqgHgRKVIeEoFY/cPfI8x0DpsoZqp6aDYyH3GrHKQgw10U7Ifj2M9u0sRhvvk3tJLslwqaPebdh3NIlgAAMyWMlI7y5BESYzDPKEsoJpZDQY8Vp8VVW0Ap7laIh8TCHF1JH19TskgMvHmo/czwscYOHFkyPKJQqBUhWK0TxLnFWMzQHrNC+Bxc2GKFi2DMJLHSLQp/krYP5ImrREmp569Gf6+oPKRNOXTfkzTtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffok8hIsQW63zsYqbPR/sS5crKXEVo1At1D5Gg+QDY4=;
 b=mPV53RzJwm79SvjBqfawv7QXhzD57cJ0KOHp9j9VN/PHOXPd+3HwBhe3F5riaKRR3MuJ+5XLxLyJixAoPFKbjTFVDEdnAP3407Mczq3RjgfDhZa7B+ZvjwjV64GjQ0czKiuxe1HxzCSl0/JApb/1+bguMy5CKMVJbkowO5sIrN1AcHTUOQQKud22cysdwKcEz2v3QuMoBS8ykf+2cml8mAGEXFdXLO0JwcP+5EJhhHiKQeWt+NoYJ0cvRhWmvQ2Ia1GwU7d4bKJSqHB2IRB35vYZWIOLnL8ViMkexc5SNI9wnGmFSa57OAFiYEHXWILY++OwnRiq582r1588U3vkJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 15:00:15 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 15:00:14 +0000
Message-ID: <c2c2bfed-bdf1-f517-559c-f51c9ca1807a@nvidia.com>
Date: Mon, 8 May 2023 11:00:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v3] virtio_net: Fix error unwinding of XDP
 initialization
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230503003525.48590-1-feliu@nvidia.com>
 <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
 <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
 <1683510351.569717-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1683510351.569717-1-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9601a02a-732b-4660-dbff-08db4fd4edd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAuyZ/rqrqhMx8DOtzU704LcZ4WZIq1jYRFHWtEs6B7qbTIbskHix2Ru58RwSuweIYVL2HWOylpvZqzhM8V9aXHZivRJOBn9VqwO4ekNXkrNbKukIPmsYidlZOzRJ9ZecinykipjgJbBmHLRGBeHoODZ2QC1ml2vLrz5czVnvAKZWL9oQ2V3Fm2galB/f/VfJXwSlczb2MQX1z71Mq68ntnhjcxl55Z2pqEIPR+jonbkJhyaaRDhZHejI94XVa1hO+bKD1Rv8dQcn3oIqRU3Tx2x7vyXenobceIjFvlq4/alemNC07+VQZCQ+QQ4BIbRqXWYdYV+wD+r2ViFAht0rK6/u/xdZ36OrOsOzUZItWly3jE5ZQvGJfQBycMJcmFOi0WomJpVgP6e6Hl9z1Kxe1XYKFkcNBOMDhcQJuIN4GLTpJXQWs5r+AOPlq2C4hbpZbio06DaLoR+mn1j5aNaZk1kKRDDT2Nx7Ra31PxWZT+QUMOHFpk82eOghoUSMdXgT5h0a5UGmWAI//GYfVQRy2sGWIubsaVB7uQ5B0ZV81GjyX+yzcgi1J9Uf/ngvLp9LeXrAqavayRpeAsMicnXcMUuvhgFl3iCGiz60n9SKLq5HQIbsWIbFoeyMjHf17hWS5gFYTkRWRhoYw3rkxJ7Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(83380400001)(2616005)(186003)(36756003)(38100700002)(31696002)(86362001)(2906002)(6486002)(8936002)(8676002)(316002)(6666004)(41300700001)(5660300002)(54906003)(31686004)(66946007)(6916009)(66556008)(4326008)(66476007)(478600001)(26005)(6506007)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0c3ZkhDV0IzU293QjRSR2lUMysxTEhkRDZJbThkUDFoZ1BsNVlHUmx0eER2?=
 =?utf-8?B?SWRBNWFOeFI2L2ViOXJ5S2FJM2VEeHdwZ1hIT1I3TlNMS1pEVTk4d010M0dx?=
 =?utf-8?B?bE9NdmpNYXA0Mk1qdHdhY1RhY1ZrNEczZFlIa0VlcXVwcFVWRk5UelpvRXBE?=
 =?utf-8?B?RGl4WmlkVk1aQTU5OElleXo5Q3ZmOWlrNllOK1QwTnd2aDFZMVVJRkFPRFdj?=
 =?utf-8?B?ZnFGVHE5b25UWHFoaFB6SDhHQzl1cHk4TmFoa3dobjkzYi9yd3VxNkp1Mnlr?=
 =?utf-8?B?WXNNdmxzcCtUK3BldVJMQzh1WTVIOTZ6QUNVY2p5Y1dMUkJML0Rsd1orc09E?=
 =?utf-8?B?Q09uL0ZzYTd3djBNNDlrcEt0MS9xOU5mQ3RCcjZnVm9nOWdQckJXaE5mVnh2?=
 =?utf-8?B?d3VyT3NXcFNqNGVMenRza3dyazVmYjc0Q0kzTlFzOFBycG1zZHp6NDBIY1U5?=
 =?utf-8?B?YXN3TjJVdjkwRC9zd3hqdnJhaE5PTXExQ0s3Mlh3MkpuY09tc3pSZ1RYY3dK?=
 =?utf-8?B?SXkvcFY3dTF5dGlFcnBFQlAvNm5rU1FkblRIWTZBblBzeUZ5MDlSZWJMaDJk?=
 =?utf-8?B?QVdpSjloU1RMWml3aS9SdlBFalVxbTJlM1hmWmw4cHRlMTNJOExZSC9zeStL?=
 =?utf-8?B?eDYzaHdNYlgyc295aHNrRkppMHpjVXBoeVR2by9XYW1LZzZTdlJJK1dxUTFq?=
 =?utf-8?B?SGZENUF2RzVCOFRVdlVzOUhFRG0vYWNRd3MzZEpFT1BObXZkNjlMeVBONTNh?=
 =?utf-8?B?Q1FsY1llRU9SUkNvK0gvczNDdHI4N2IyNDV4OENCQUFjWDlDbVJ6VGVVQWdM?=
 =?utf-8?B?YndDZ1E2ZWcwNWdsVW1CN044dFYrTDcyVUlQMlNIRjhkNVBLNkFrMTRaS2JW?=
 =?utf-8?B?SXA3VXE3RXd5aDVXR0JRRUdSZjIwS1JiWWQrYUxGZndnWmpwYStuRVA4SnpW?=
 =?utf-8?B?YXowMjhjalpHTm1BUFRXemhSVm1oNUtkZ1VMMU5PSVNKdHdvKzVkdEpmaVJN?=
 =?utf-8?B?a2c4bjRQT3hTTzBDMGVHbmRIR21HUlhZbFVEdXU3SmxlbGlZa3JQVW9iYVBx?=
 =?utf-8?B?WnJyK3Uwa3UxTnBpQ0ZFdUp1VU41SVduMkF1YjVRU3dPYlk4aW5jdlJFME9z?=
 =?utf-8?B?VVRtcEZ1elBYT1pWVXFnbms1c1RaV1JBQVFJRVhSMlV6U2lyVDF1M3NJLzZn?=
 =?utf-8?B?TFcxV0ZIdzZxYmZIQXdLaEVtcEg2ZGNyd0gzSGFNbkFkTkJmU3FqVklzZVpQ?=
 =?utf-8?B?Q3kxUGw5YWpSMXhCMENVam5Ga1FjV2t4OHhWaGMvci9VbG4yQSt4ZVo4YTBF?=
 =?utf-8?B?ekhxNEpSM3EzQ3ZTQTcvbnpVeXlsWWY4azJZd2NWUFdaSTljTEIvMlE5WVh4?=
 =?utf-8?B?QjFFN3NiNFJFYlZyRUhmb2VTUWpJYzlzV3l1ZjIwNk9rVUpDQmxiZC9TVmlE?=
 =?utf-8?B?U29xNEtTd0JiTER4YXpYUlN5VUQ3bEh4YlIxeWdZMDl6d1lRSnpHZWNhSnhK?=
 =?utf-8?B?TFdadWpqNlJ6Q3F6V3NrYm5PREI4cE9VRzA0TFFUY2xJSmdtVE5mR21ZWVBD?=
 =?utf-8?B?M2d6VG9Za2dWQmlMU1c3SVhtN2pDV0NyY2loaXdyOFphM214bmxTOXQ4eXNo?=
 =?utf-8?B?OXlVN0NCMFRaclZVeWEzS0dQQ1NZMnY5Qmw2dXhkYXhBdWVXVnd6anVrcnJO?=
 =?utf-8?B?VDVTM1BNN25tRW9ETnZadEN5bmRKaUU2anBibEhRVzRGUm4xaUJRRUliSi9K?=
 =?utf-8?B?NkNYRlNOUEt5TTBJSmYxai9RQ1dxMDVJS0NEekdLR2o5UnllTnUrdEd3NjRw?=
 =?utf-8?B?aXN3SENMNlBoUFNvODFsVUdFTmJaVTVvclhQNzlERzkveDBOZ0pJcGdpajBI?=
 =?utf-8?B?YktJNE9LSnA4WmlVM0t6Z2xLQ2lSTGZwb3J5eDIwSHVOTGZ4RFl0NFFUL2Fm?=
 =?utf-8?B?d1hkWGhaRUVQTklFMU9xSVlVSnNTQ1ZONzcrMlhHWURpdHcwcWpWZVQ5bHhL?=
 =?utf-8?B?NjRZeGxyMzZ0enBOYUVjOWhuWkZoZkFXVzlJTjN2UnZpV2VnTFFIMzZJTldi?=
 =?utf-8?B?YWdlMENROWU4SndBNzVvdTVKNk5lNnZid1JHQmZUcnN1OTU1clNWTEpuTHBn?=
 =?utf-8?Q?lhef6/GV9XMTXt1rphl+t61Hm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9601a02a-732b-4660-dbff-08db4fd4edd4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 15:00:14.6984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zKaBRYj82nPSqdgz5nTBrTFN/U+KeZcOI3NqqHdpzD9YJjPvFK64bgsLo0OVxeCDQMy6R8R19qKsa7uWXVCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 netdev@vger.kernel.org, Bodong Wang <bodong@nvidia.com>, bpf@vger.kernel.org
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTA1LTA3IHAubS45OjQ1LCBYdWFuIFpodW8gd3JvdGU6Cj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAKPiAKPiBPbiBT
YXQsIDYgTWF5IDIwMjMgMDg6MDg6MDIgLTA0MDAsIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29t
PiB3cm90ZToKPj4KPj4KPj4gT24gMjAyMy0wNS0wNSBwLm0uMTA6MzMsIFh1YW4gWmh1byB3cm90
ZToKPj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzCj4+Pgo+Pj4KPj4+IE9uIFR1ZSwgMiBNYXkgMjAyMyAyMDozNToyNSAtMDQwMCwgRmVu
ZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+IFdoZW4gaW5pdGlhbGl6aW5nIFhE
UCBpbiB2aXJ0bmV0X29wZW4oKSwgc29tZSBycSB4ZHAgaW5pdGlhbGl6YXRpb24KPj4+PiBtYXkg
aGl0IGFuIGVycm9yIGNhdXNpbmcgbmV0IGRldmljZSBvcGVuIGZhaWxlZC4gSG93ZXZlciwgcHJl
dmlvdXMKPj4+PiBycXMgaGF2ZSBhbHJlYWR5IGluaXRpYWxpemVkIFhEUCBhbmQgZW5hYmxlZCBO
QVBJLCB3aGljaCBpcyBub3QgdGhlCj4+Pj4gZXhwZWN0ZWQgYmVoYXZpb3IuIE5lZWQgdG8gcm9s
bCBiYWNrIHRoZSBwcmV2aW91cyBycSBpbml0aWFsaXphdGlvbgo+Pj4+IHRvIGF2b2lkIGxlYWtz
IGluIGVycm9yIHVud2luZGluZyBvZiBpbml0IGNvZGUuCj4+Pj4KPj4+PiBBbHNvIGV4dHJhY3Qg
YSBoZWxwZXIgZnVuY3Rpb24gb2YgZGlzYWJsZSBxdWV1ZSBwYWlycywgYW5kIHVzZSBuZXdseQo+
Pj4+IGludHJvZHVjZWQgaGVscGVyIGZ1bmN0aW9uIGluIGVycm9yIHVud2luZGluZyBhbmQgdmly
dG5ldF9jbG9zZTsKPj4+Pgo+Pj4+IElzc3VlOiAzMzgzMDM4Cj4+Pj4gRml4ZXM6IDc1NGI4YTIx
YTk2ZCAoInZpcnRpb19uZXQ6IHNldHVwIHhkcF9yeHFfaW5mbyIpCj4+Pj4gU2lnbmVkLW9mZi1i
eTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IFdpbGxpYW0g
VHUgPHdpdHVAbnZpZGlhLmNvbT4KPj4+PiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJh
dkBudmlkaWEuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPHNpbW9uLmhvcm1h
bkBjb3JpZ2luZS5jb20+Cj4+Pj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+Cj4+Pj4gQ2hhbmdlLUlkOiBJYjRjNmE5N2NiN2I4MzdjZmE0ODRjNTkzZGQ0M2E0
MzVjNDdlYTY4Zgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDMw
ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+PiBp
bmRleCA4ZDgwMzg1MzhmYzQuLjM3MzdjZjEyMGNiNyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+
PiBAQCAtMTg2OCw2ICsxODY4LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBu
YXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPj4+PiAgICAgICAgIHJldHVybiByZWNlaXZl
ZDsKPj4+PiAgICB9Cj4+Pj4KPj4+PiArc3RhdGljIHZvaWQgdmlydG5ldF9kaXNhYmxlX3FwKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBpbnQgcXBfaW5kZXgpCj4+Pj4gK3sKPj4+PiArICAgICB2
aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmdmktPnNxW3FwX2luZGV4XS5uYXBpKTsKPj4+PiArICAg
ICBuYXBpX2Rpc2FibGUoJnZpLT5ycVtxcF9pbmRleF0ubmFwaSk7Cj4+Pj4gKyAgICAgeGRwX3J4
cV9pbmZvX3VucmVnKCZ2aS0+cnFbcXBfaW5kZXhdLnhkcF9yeHEpOwo+Pj4+ICt9Cj4+Pj4gKwo+
Pj4+ICAgIHN0YXRpYyBpbnQgdmlydG5ldF9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4+
Pj4gICAgewo+Pj4+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJp
dihkZXYpOwo+Pj4+IEBAIC0xODgzLDIwICsxODkwLDI2IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9v
cGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4+Pj4KPj4+PiAgICAgICAgICAgICAgICAgZXJy
ID0geGRwX3J4cV9pbmZvX3JlZygmdmktPnJxW2ldLnhkcF9yeHEsIGRldiwgaSwgdmktPnJxW2ld
Lm5hcGkubmFwaV9pZCk7Cj4+Pj4gICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGVycl94ZHBfaW5mb19yZWc7Cj4+Pj4KPj4+PiAgICAgICAgICAgICAgICAgZXJyID0g
eGRwX3J4cV9pbmZvX3JlZ19tZW1fbW9kZWwoJnZpLT5ycVtpXS54ZHBfcnhxLAo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1fVFlQRV9QQUdF
X1NIQVJFRCwgTlVMTCk7Cj4+Pj4gLSAgICAgICAgICAgICBpZiAoZXJyIDwgMCkgewo+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgICB4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtpXS54ZHBfcnhx
KTsKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPj4+PiAtICAgICAgICAg
ICAgIH0KPj4+PiArICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycl94ZHBfcmVnX21lbV9tb2RlbDsKPj4+Pgo+Pj4+ICAgICAgICAgICAg
ICAgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHZpLT5ycVtpXS52cSwgJnZpLT5ycVtpXS5uYXBpKTsK
Pj4+PiAgICAgICAgICAgICAgICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgdmktPnNxW2ld
LnZxLCAmdmktPnNxW2ldLm5hcGkpOwo+Pj4+ICAgICAgICAgfQo+Pj4+Cj4+Pj4gICAgICAgICBy
ZXR1cm4gMDsKPj4+PiArCj4+Pj4gK2Vycl94ZHBfcmVnX21lbV9tb2RlbDoKPj4+PiArICAgICB4
ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtpXS54ZHBfcnhxKTsKPj4+PiArZXJyX3hkcF9pbmZv
X3JlZzoKPj4+PiArICAgICBmb3IgKGkgPSBpIC0gMTsgaSA+PSAwOyBpLS0pCj4+Pj4gKyAgICAg
ICAgICAgICB2aXJ0bmV0X2Rpc2FibGVfcXAodmksIGkpOwo+Pj4KPj4+Cj4+PiBJIHdvdWxkIHRv
IGtub3cgc2hvdWxkIHdlIGhhbmRsZSBmb3IgdGhlc2U6Cj4+Pgo+Pj4gICAgICAgICAgIGRpc2Fi
bGVfZGVsYXllZF9yZWZpbGwodmkpOwo+Pj4gICAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmdmktPnJlZmlsbCk7Cj4+Pgo+Pj4KPj4+IE1heWJlIHdlIHNob3VsZCBjYWxsIHZpcnRu
ZXRfY2xvc2UoKSB3aXRoICJpIiBkaXJlY3RseS4KPj4+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4KPj4g
Q2Fu4oCZdCB1c2UgaSBkaXJlY3RseSBoZXJlLCBiZWNhdXNlIGlmIHhkcF9yeHFfaW5mb19yZWcg
ZmFpbHMsIG5hcGkgaGFzCj4+IG5vdCBiZWVuIGVuYWJsZWQgZm9yIGN1cnJlbnQgcXAgeWV0LCBJ
IHNob3VsZCByb2xsIGJhY2sgZnJvbSB0aGUgcXVldWUKPj4gcGFpcnMgd2hlcmUgbmFwaSB3YXMg
ZW5hYmxlZCBiZWZvcmUoaS0tKSwgb3RoZXJ3aXNlIGl0IHdpbGwgaGFuZyBhdCBuYXBpCj4+IGRp
c2FibGUgYXBpCj4gCj4gVGhpcyBpcyBub3QgdGhlIHBvaW50LCB0aGUga2V5IGlzIHdoZXRoZXIg
d2Ugc2hvdWxkIGhhbmRsZSB3aXRoOgo+IAo+ICAgICAgICAgICAgZGlzYWJsZV9kZWxheWVkX3Jl
ZmlsbCh2aSk7Cj4gICAgICAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnZpLT5yZWZp
bGwpOwo+IAo+IFRoYW5rcy4KPiAKPiAKCk9LLCBnZXQgdGhlIHBvaW50LiBUaGFua3MgZm9yIHlv
dXIgY2FyZWZ1bCByZXZpZXcuIEFuZCBJIGNoZWNrIHRoZSBjb2RlIAphZ2Fpbi4KClRoZXJlIGFy
ZSB0d28gcG9pbnRzIHRoYXQgSSBuZWVkIHRvIGV4cGxhaW46CgoxLiBBbGwgcmVmaWxsIGRlbGF5
IHdvcmsgY2FsbHModmktPnJlZmlsbCwgdmktPnJlZmlsbF9lbmFibGVkKSBhcmUgYmFzZWQgCm9u
IHRoYXQgdGhlIHZpcnRpbyBpbnRlcmZhY2UgaXMgc3VjY2Vzc2Z1bGx5IG9wZW5lZCwgc3VjaCBh
cyAKdmlydG5ldF9yZWNlaXZlLCB2aXJ0bmV0X3J4X3Jlc2l6ZSwgX3ZpcnRuZXRfc2V0X3F1ZXVl
cywgZXRjLiBJZiB0aGVyZSAKaXMgYW4gZXJyb3IgaW4gdGhlIHhkcCByZWcgaGVyZSwgaXQgd2ls
bCBub3QgdHJpZ2dlciB0aGVzZSBzdWJzZXF1ZW50IApmdW5jdGlvbnMuIFRoZXJlIGlzIG5vIG5l
ZWQgdG8gY2FsbCBkaXNhYmxlX2RlbGF5ZWRfcmVmaWxsKCkgYW5kIApjYW5jZWxfZGVsYXllZF93
b3JrX3N5bmMoKS4gVGhlIGxvZ2ljIGhlcmUgaXMgZGlmZmVyZW50IGZyb20gdGhhdCBvZiAKdmly
dG5ldF9jbG9zZS4gdmlydG5ldF9jbG9zZSBpcyBiYXNlZCBvbiB0aGUgc3VjY2VzcyBvZiB2aXJ0
bmV0X29wZW4gYW5kIAp0aGUgdHggYW5kIHJ4IGhhcyBiZWVuIGNhcnJpZWQgb3V0IG5vcm1hbGx5
LiBGb3IgZXJyb3IgdW53aW5kaW5nLCBvbmx5IApkaXNhYmxlIHFwIGlzIG5lZWRlZC4gQWxzbyBl
bmNhcHVzbGF0ZWQgYSBoZWxwZXIgZnVuY3Rpb24gb2YgZGlzYWJsZSBxcCwgCndoaWNoIGlzIHVz
ZWQgaW5nIGVycm9yIHVud2luZGluZyBhbmQgdmlydG5ldCBjbG9zZQoyLiBUaGUgY3VycmVudCBl
cnJvciBxcCwgd2hpY2ggaGFzIG5vdCBlbmFibGVkIE5BUEksIGNhbiBvbmx5IGNhbGwgeGRwIAp1
bnJlZywgYW5kIGNhbm5vdCBjYWxsIHRoZSBpbnRlcmZhY2Ugb2YgZGlzYWJsZSBOQVBJLCBvdGhl
cndpc2UgdGhlIAprZXJuZWwgd2lsbCBiZSBzdHVjay4gU28gZm9yIGktLSB0aGUgcmVhc29uIGZv
ciBjYWxsaW5nIGRpc2FibGUgcXAgb24gCnRoZSBwcmV2aW91cyBxdWV1ZQoKVGhhbmtzCgo+Pgo+
Pj4+ICsKPj4+PiArICAgICByZXR1cm4gZXJyOwo+Pj4+ICAgIH0KPj4+Pgo+Pj4+ICAgIHN0YXRp
YyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdl
dCkKPj4+PiBAQCAtMjMwNSwxMSArMjMxOCw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+Pj4+ICAgICAgICAgLyogTWFrZSBzdXJlIHJlZmlsbF93
b3JrIGRvZXNuJ3QgcmUtZW5hYmxlIG5hcGkhICovCj4+Pj4gICAgICAgICBjYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoJnZpLT5yZWZpbGwpOwo+Pj4+Cj4+Pj4gLSAgICAgZm9yIChpID0gMDsgaSA8
IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+Pj4+IC0gICAgICAgICAgICAgdmlydG5ldF9u
YXBpX3R4X2Rpc2FibGUoJnZpLT5zcVtpXS5uYXBpKTsKPj4+PiAtICAgICAgICAgICAgIG5hcGlf
ZGlzYWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+Pj4+IC0gICAgICAgICAgICAgeGRwX3J4cV9pbmZv
X3VucmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4+Pj4gLSAgICAgfQo+Pj4+ICsgICAgIGZvciAo
aSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4+Pj4gKyAgICAgICAgICAgICB2
aXJ0bmV0X2Rpc2FibGVfcXAodmksIGkpOwo+Pj4+Cj4+Pj4gICAgICAgICByZXR1cm4gMDsKPj4+
PiAgICB9Cj4+Pj4gLS0KPj4+PiAyLjM3LjEgKEFwcGxlIEdpdC0xMzcuMSkKPj4+PgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
