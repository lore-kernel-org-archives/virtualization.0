Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCF9E82CBD
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 330D7405D8;
	Wed, 27 Sep 2023 18:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 330D7405D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GE16ZVc/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mP4LPAZR5D69; Wed, 27 Sep 2023 18:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C16940550;
	Wed, 27 Sep 2023 18:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C16940550
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBD32C0039;
	Wed, 27 Sep 2023 18:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3660AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E5374037C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E5374037C
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=GE16ZVc/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZGXp7aYqoBP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:12:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3815D400D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3815D400D9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM/vlE8jp+ao/BldbBp11iIK1oHmc+ycH1WrBEsRD/g2TVRWa1lyCPLGMHb2mIDtsjwLD1/Cer43vKeK7oXqk0et4MgQTHUzeCFjWb+AZaEksByuf6Y54eakFnP24nzk2Wb/rKxIFZUswdCRhNpMc4SmFbDJWDjlZRlI7rn2clJlJBC/EdX5FbALDxtB6xegkl4cYK6yiOIT9LUbln0CszGM7N3b5gl+W/+Lva/j8s42s3HhEngnk6G6LocLF3TEvCRBHmqrVjI7KJ2tUMVrlqweHwCSPlytexfsjnf8FIfdBZCmmUGcdQ9FvdE825nk7yNsBnWSQ+xlOqlo/eDxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDKYWKZFHbfxylclgwijl6iUn2/Lh5JlU4gNAniw+ac=;
 b=cVq489leIyqZLJ7WsJXyuH757/gRRGuktA8Byj5XxfwrTBbrt4HPz8x9B1NyZGJjyTH5CrmJ8ouf55xxSvwwmxsxmzRi1wZaUE0HJXFyI9F9mWvu6PbalgR4rifSD3WeoztILp2KGVKi0pG5KZlol7bj1vJ/KY3HzRwSNx7hPWJDoijg8qPSQOkiFFaNKtvE44wkrz6IpucRqpHVy4GB8FVAwRn6+5qL4Gzjasd1WRZrDJU6WfernKnqIAUZxaH974kTwcWIx8Lj+dYSW6y3/yKmVJwtd/CcYtPM8EMZ0tjVibLXbag7daBLyK47vjvMOZnHTkcdGz70zOECeblg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDKYWKZFHbfxylclgwijl6iUn2/Lh5JlU4gNAniw+ac=;
 b=GE16ZVc/+ds1U4WFVoS3b2emABqUytJDsNF6QJvRNJuPhbItLdrWc6lBXym7qylo5mFwuFQd0KyEmx9oS0R2Ctb6XzT9BG10feDxPDD36Y7RM1To3AV4ndBohpWDbhMF1yMzL6JGauz2U1PLP5UHmO/aaknz2J+4B5C4bC6A2coZB1YntOyD/5Zym3WH6t3U0e9tXZuBisW9e/6hL8XqZ5RnVkxZtVUjh+Ztxt1tQxJpGwgqfFPb0jDJ9M2Q+ccw5acJqataUkIFP6kChblCVVMhKHl/fR9xd8PQBUVZw8IKYY9VekhDLgYBRqOV2dK03kK7DqghTE4U6JKSXxeY1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 18:12:28 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:12:28 +0000
Message-ID: <40f53b6f-f220-af35-0797-e3c60c8c1294@nvidia.com>
Date: Wed, 27 Sep 2023 14:12:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH vfio 03/11] virtio-pci: Introduce admin virtqueue
To: "Michael S. Tsirkin" <mst@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-4-yishaih@nvidia.com>
 <20230921095216-mutt-send-email-mst@kernel.org>
 <62df07ea-ddb6-f4ee-f7c3-1400dbe3f0a9@nvidia.com>
In-Reply-To: <62df07ea-ddb6-f4ee-f7c3-1400dbe3f0a9@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a2100a-7efc-4b54-5b53-08dbbf854eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgHtkj6Zc6xCnynziNeOsJQwQ8wznfcXHlvRnJS8DYjZMzhNL6Zj9tz/ULQHU81vyZVL0TxzEOqbRB09l0MKzBtWtUGzCUdO5i0apYCJtZOfr2/0hbof/2B4JLuHCXV/i27DSoC8iZZPmgEaMn38SE9TDvefZRVSwnclXJHqd+W5SWKdbXBB7rf1t+UTdBj70Ib/8Nx2SaAmtTvUcvkAGlLHihzt2qg9G36NuXvdf3RWh7oua07/xUIWBiY+XRsyEil3IMjYS1BQC7q7zDM2gMwG543zFBSueveBkLrvigDqqJEvv+39xcb/Zykh11c5+1ZSCcH+tj3dNpq2qJpTjoE346hB4LrFQZDIV0DxLHB4xFeggHOh6lUMODz+An8ouSVp/cO4lWZgyqlDwAjOgTd42f+sSAdiUGCgQ+UGxgeQD2sTBvTPg70e4a99cI0Dcl6+UDSV7UwiSy4ntnye8xuyN4y4ZUsFX1O6DM8e4XpgviENWfYDhVt53zan4jGZYiWr2ten+Ou3PPn7I5AqBF1ZQXZxJO2NXM79O4prEMf7An7kH7rA+1bkhkMQN3Y4fRyn8/FkVZah6NYgmhI6V07sNI7d1eXdA/eObTyQ1QyYpf170duZfTMmSUxZiAueKOnfR/RZp7euSX+JYpxeaEDp+AHmGwyBuCzrsgsNNPUkc+tsR/drQbYw1FsnLDRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(31686004)(83380400001)(8676002)(6506007)(6512007)(110136005)(2906002)(5660300002)(4326008)(316002)(36756003)(8936002)(966005)(6636002)(41300700001)(6486002)(2616005)(66946007)(478600001)(38100700002)(6666004)(86362001)(26005)(66556008)(107886003)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJidDdsbU1md2NWTDR2dUF4b2dDeTJRYzcxKzhMWUtzbExITEc3WUsydUw2?=
 =?utf-8?B?Z2YxaDJpd29uTTFvTk9VRmlvVGx3WEhBOC9MQ0cyRjM0NFdBbXllQ1hoVy9Z?=
 =?utf-8?B?ZjRaOGM4SFRNWjN4bCtpa2Eyd1hqems5cU1EZm1DMVhQR0UyYlBxRy9WYnBa?=
 =?utf-8?B?SVhVNmxCWWFhN1VzSGdiVEFGWklsaS9SdlVCV3JReHJBMEVpODN0RXdaNHVQ?=
 =?utf-8?B?R2hxODF6ZDNFN3haZGtKQnVIdXkvQ2VDditDZitDWTJNN0N2dlRvNXZmZXEy?=
 =?utf-8?B?U2hydkdpSkd3eUlPWnJNQS9jdVdYM0J5WmRoMklLMWdiemdTQ1Z4Z0lMbmdJ?=
 =?utf-8?B?TFUxejlmR1JsNVZXSEt2UnJISDJ2U1psQ2lTSDhnVVdESjRtUmJGOUMwZm5M?=
 =?utf-8?B?OVhERGlLVzc4ZVg3NDdMbExoTGZXVEJlc1pzc0ExeUpIWUpvQXVLalBGa1lC?=
 =?utf-8?B?YzYzSm80bElaSnFwZWZwSEFvTndaOE52NzBrdjFyendMbmtYK2ErNE5RbmdR?=
 =?utf-8?B?VThTem9XajQwV09yRmI4S2pOVEtEZkNQTThPdE95MThyQmhONkN5WjVoUHMz?=
 =?utf-8?B?d0x3eGFJTXpYck1HK3ZRcmFHTFdrOHkyUzQyQVgvWTRmQXJ5bHFFU0pvdW5B?=
 =?utf-8?B?aDZ6TjgyR3QrQmVOaXIxQkUvQzVoUFIvNk9ha2ZRekVxK1FuWGRMZTg5NGZ5?=
 =?utf-8?B?ZDNENWNWVUV2eEFJVldYVXhKaFNzRDRKK0Z6ZGZZUkxHL2VjWlZ6TmEyTDVO?=
 =?utf-8?B?VmRhY0o0cmhEajdKNmRQOVVwYlZzbFk3TDdBdklqdmtRaDZnM3JtQm11UHZx?=
 =?utf-8?B?aFhaRm9hM3U4UnRHbFE1aGZBc0pMWnEzWHpuQmpZVG1KYnA2OFd5S2VBRDVq?=
 =?utf-8?B?RjN1VXJmSDhuS2pKMm1hU2pzNjZ0YkRPUUU1REhQaFlOR0xkZmZXZG8rNzNh?=
 =?utf-8?B?MkZTdVBhaktTK1pENXZ5U0wzaXJYWGpQOFdueE05ajVwQ0wzK2lPWk4wY3NV?=
 =?utf-8?B?SXBHdjREOERNZ054UDA0OEhxSjRFc0pxZFZjOUFMVnhVdWM2VmRIY0JrOUdk?=
 =?utf-8?B?MUY4ZkZmeDhBVk10REM2YW1aaTd2bU1mVGRrQjdKL2pqZ2QrNmdVNlRKaG92?=
 =?utf-8?B?V1BBUXhndUI4ckdnaGJnMFdMdUFES2tmZXAxUTJEd2F4WkxOY0x3SjN2S0Q0?=
 =?utf-8?B?MkNYSjA1cmUvcVdTc2dYb2tTNFNVVTkzTW00aUVxaUNTMUFpMkpwSVdiNmJr?=
 =?utf-8?B?QUF0OElIOG0zN2tKcFM2cnl6UlQ5YUZrazRnOFFZWHdlWVB1QXpUNW5RU2Fj?=
 =?utf-8?B?djIwMkU5cmd2SkVCWjhFUmFaQ1pYZ2Qxbm1PNTV4OG4zQVBWSU5jbTlWVTZR?=
 =?utf-8?B?ajV1cHk3OE5ZT1ludkxIcDZoeEZaSHVnVVJQeG1CTm9pZFdCQlBGYmJrdmE0?=
 =?utf-8?B?VW9kc1puRkVMTDIvSnFjYlhlRS9LTkdxekxkT3FQZ0F2WVVneFpqZzAvYjMz?=
 =?utf-8?B?bnh4eW04cHlmTlcrNVhXcTcwRFB4ZWIrMnVrUUt2WVVyR21wb1hveW8zZEpV?=
 =?utf-8?B?NXFaaUJ3NGdQYlhPTjMreC9reXNCb0tRMjdwSVE3OXNrYnhWNWFFUjVNSnRt?=
 =?utf-8?B?VnNRamQ3QWFocTR4dVg1ek9pQ1krQm9VR1RQQnBoQm1ROWNFcmFRbC9rb2Nz?=
 =?utf-8?B?WUJ0SDJwRGFDb3NGUGFsalJVdzVUQTJvQ2hpaDNmR2tpbGdpOHJ3dFdRMVBn?=
 =?utf-8?B?Mk9VYTFHZkhLSE5jSlZwYVNsQWMrMmRCbFhEaGJLMGdmcmg0Y3hqSW12WXpI?=
 =?utf-8?B?cFlsNnRGYkQvRzE4K1BpRjFtSkloMWVzOWlYQWxSM0Vici9oK0VrVnQ4TzJY?=
 =?utf-8?B?NkpFeGtLcU1tVmNqa2RkV1pOMVZmWmNsRXRPeEFteCtvSEY1cE5ERWg1a1Z4?=
 =?utf-8?B?YlBxZWFVaTU1dEUwUEFRR2FKZ2xpMStMcGhJU2h1bTBFOUt1VGhjVzZhTldC?=
 =?utf-8?B?QlFlMVFBdUpKdkVOZVJXNmNKSUtSMTA0bXpkMGsvQ2d5NVVwV2E5amR1T2VL?=
 =?utf-8?B?aUhXWTNIbDZMcjZWZXYrZm92M3JvOU93K1N3RlYrVVBRQ2xmbTc0TndZYVJw?=
 =?utf-8?Q?g7/v5RcxIpUq3nMNyBUHO1UdL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a2100a-7efc-4b54-5b53-08dbbf854eb4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:12:27.6542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OFTUJTu7QWaCtNRqVV2rfmWdB0mcQyZ8K3F4r7hx4pIFJbnAaekLSaWehuLIZj7gBvBmyumpDoP2dobjvOiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

CgpPbiAyMDIzLTA5LTI2IHAubS4zOjIzLCBGZW5nIExpdSB2aWEgVmlydHVhbGl6YXRpb24gd3Jv
dGU6Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMKPiAKPiAKPiBPbiAyMDIzLTA5LTIxIGEubS45OjU3LCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4+Cj4+Cj4+IE9uIFRodSwgU2VwIDIxLCAyMDIzIGF0IDAzOjQwOjMyUE0gKzAz
MDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4+IEZyb206IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPgoKCj4+PiDCoCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9hdnEuYyB8IDY1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4+Cj4+IGlmIHlvdSBoYXZlIGEgLmMgZmlsZSB3
aXRob3V0IGEgLmggZmlsZSB5b3Uga25vdyB0aGVyZSdzIHNvbWV0aGluZwo+PiBmaXNoeS4gSnVz
dCBhZGQgdGhpcyBpbnNpZGUgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyA/Cj4+
Cj4gV2lsbCBkby4KPiAKCj4+PiArc3RydWN0IHZpcnRpb19hdnEgewo+Pgo+PiBhZG1pbl92cSB3
b3VsZCBiZSBiZXR0ZXIuIGFuZCB0aGlzIGlzIHBjaSBzcGVjaWZpYyB5ZXM/IHNvIHZpcnRpb19w
Y2lfCj4+Cj4gCj4gV2lsbCBkby4KPiAKCj4+Pgo+Pj4gK8KgwqDCoMKgIHN0cnVjdCB2aXJ0aW9f
YXZxICphZG1pbjsKPj4KPj4gYW5kIHRoaXMgY291bGQgYmUgdGhpbmthYmx5IGFkbWluX3ZxLgo+
Pgo+IFdpbGwgZG8uCj4gCgo+Pj4KPj4+IMKgIC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2ZXJ0aXNl
IHRoZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVyIGFwcGVhci4gKi8KPj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggCj4+PiBiL2luY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaAo+Pj4gaW5kZXggMDY3YWMxZDc4OWJjLi5mNmNiMTNkODU4ZmQgMTAw
NjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPj4+ICsrKyBi
L2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+Pj4gQEAgLTEwLDYgKzEwLDkgQEAg
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcgewo+Pj4KPj4+IMKgwqDCoMKgwqDC
oCBfX2xlMTYgcXVldWVfbm90aWZ5X2RhdGE7wqDCoMKgwqDCoMKgIC8qIHJlYWQtd3JpdGUgKi8K
Pj4+IMKgwqDCoMKgwqDCoCBfX2xlMTYgcXVldWVfcmVzZXQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qIHJlYWQtd3JpdGUgKi8KPj4+ICsKPj4+ICvCoMKgwqDCoCBfX2xlMTYgYWRtaW5fcXVl
dWVfaW5kZXg7wqDCoMKgwqDCoMKgIC8qIHJlYWQtb25seSAqLwo+Pj4gK8KgwqDCoMKgIF9fbGUx
NiBhZG1pbl9xdWV1ZV9udW07wqDCoMKgwqDCoMKgwqDCoCAvKiByZWFkLW9ubHkgKi8KPj4+IMKg
IH07Cj4+Cj4+Cj4+IG91Y2guCj4+IGFjdHVhbGx5IHRoZXJlJ3MgYSBwcm9ibGVtCj4+Cj4+IMKg
wqDCoMKgwqDCoMKgwqAgbWRldi0+Y29tbW9uID0gdnBfbW9kZXJuX21hcF9jYXBhYmlsaXR5KG1k
ZXYsIGNvbW1vbiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3RydWN0IAo+PiB2aXJ0
aW9fcGNpX2NvbW1vbl9jZmcpLCA0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAsIHNpemVvZihz
dHJ1Y3QgCj4+IHZpcnRpb19wY2lfY29tbW9uX2NmZyksCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
TlVMTCwgTlVMTCk7Cj4+Cj4+IGV4dGVuZGluZyB0aGlzIHN0cnVjdHVyZSBtZWFucyBzb21lIGNh
bGxzIHdpbGwgc3RhcnQgZmFpbGluZyBvbgo+PiBleGlzdGluZyBkZXZpY2VzLgo+Pgo+PiBldmVu
IG1vcmUgb2YgYW4gb3VjaCwgd2hlbiB3ZSBhZGRlZCBxdWV1ZV9ub3RpZnlfZGF0YSBhbmQgcXVl
dWVfcmVzZXQgd2UKPj4gYWxzbyBwb3NzaWJseSBicm9rZSBzb21lIGRldmljZXMuIHdlbGwgaG9w
ZWZ1bGx5IG5vdCBzaW5jZSBubyBvbmUKPj4gcmVwb3J0ZWQgZmFpbHVyZXMgYnV0IHdlIHJlYWxs
eSBuZWVkIHRvIGZpeCB0aGF0Lgo+Pgo+Pgo+IEhpIE1pY2hhZWwKPiAKPiBJIGRpZG7igJl0IHNl
ZSB0aGUgZmFpbCBpbiB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxpdHkoKSwgYW5kCj4gdnBfbW9kZXJu
X21hcF9jYXBhYmlsaXR5KCkgb25seSByZWFkIGFuZCBtYXAgcGNpIG1lbW9yeS4gVGhlIGxlbmd0
aCBvZgo+IHRoZSBtZW1vcnkgbWFwcGluZyB3aWxsIGluY3JlYXNlIGFzIHRoZSBzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnCj4gaW5jcmVhc2VzLiBObyBlcnJvcnMgYXJlIHNlZW4uCj4gCj4g
QW5kIGFjY29yZGluZyB0byB0aGUgZXhpc3RpbmcgY29kZSwgbmV3IHBjaSBjb25maWd1cmF0aW9u
IHNwYWNlIG1lbWJlcnMKPiBjYW4gb25seSBiZSBhZGRlZCBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9t
b2Rlcm5fY29tbW9uX2NmZy4KPiAKPiBFdmVyeSBzaW5nbGUgZW50cnkgYWRkZWQgaGVyZSBpcyBw
cm90ZWN0ZWQgYnkgZmVhdHVyZSBiaXQsIHRoZXJlIGlzIG5vCj4gYnVnIEFGQUlLLgo+IAo+IENv
dWxkIHlvdSBoZWxwIHRvIGV4cGxhaW4gaXQgbW9yZSBkZXRhaWw/wqAgV2hlcmUgYW5kIHdoeSBp
dCB3aWxsIGZhbGwgaWYKPiB3ZSBhZGQgbmV3IG1lbWJlciBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9t
b2Rlcm5fY29tbW9uX2NmZy4KPiAKPiAKSGksIE1pY2hhZWwKCUFueSBjb21tZW50cyBhYm91dCB0
aGlzPwpUaGFua3MKRmVuZwoKPj4+Cj4+PiDCoCBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2
aWNlIHsKPj4+IC0tIAo+Pj4gMi4yNy4wCj4+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiBWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
