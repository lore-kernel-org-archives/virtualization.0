Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B40C433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 07:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C311784471;
	Fri, 25 Mar 2022 07:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOtxfFseNw8q; Fri, 25 Mar 2022 07:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C38F8446E;
	Fri, 25 Mar 2022 07:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30186C002C;
	Fri, 25 Mar 2022 07:45:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B38BC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FBEE41C8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkypHFDmmBD4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:45:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDCE841C49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9+Ub0BTa7yqz0F5a5caUoc1ktE1hkjwndMkvMCM+JSPw29OprmQIu9yJTOhZrOzxldv/J9joAfOMpjH1hmqm/PlIIvb5MFDWcbG4rEIzQirHCB48Kr+oXmlyuFsrqlRZLWFy+ZvsoA3zfGCDJJbf8ZrzddeQSic/OZjH2SgKXbBh2v6Zl+bhkrth0GQRL6XtIR6rm6+ElDmfgstZNV7Ocjh8cRXX+YqEDYKhPsJeDgEgQj57zwGPJaEwpFgep8b6PNb0Kjqici6lkhatcc5P+vaD1LWO5jPyxlkIM/x6tsPN2QwoNaErsNNnMjKok+Ob6PuXJUtIrY5CVlybXMUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLSMGydjOr5gHGnvrSQ87odKYNkssW8EiHuRFXQUYPI=;
 b=Rv4K5hd1cve0BFFD2lUVT1aoDXiHcYdJAsaAOMb9pokD22nVxQUT3QpsdoqNWfwGC8hLgZlwGG0gVcWVjYORpOCaCyITJJ6zlEEWdHHYycumbc4JJFUwKJ33KrPbTOre+7OAIwf8MgiGc3cpweKSThjaYfO1mfqvrBlEy1vguJlpHOf3MiHsGGYToHtY2Ff5jkAWCTlUAxx1QG8Zjj+r3OCQc9tVwubmblpFhAdVnwGfPjv/blyhgTwa88hU1TCvxYXEZsQmGKKmeP8Qplg6iVF2BsS3mYrQIamzQy3J31xlxAlAbnsA47XywHwJn8/9NPaW3lxlE7LUoelM0hskZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLSMGydjOr5gHGnvrSQ87odKYNkssW8EiHuRFXQUYPI=;
 b=jY/CFU6loAz+eNc+2dpYjKKsL3MQQ2tSyXz7fcCZR1q6kUjY8Kn12+d1ykYIdaeo65T+2nMsSL/vlIsanyE+07PNxcQwkoHQvvFydd/xfjSIN4FqEX8GwktUMwcnly09rSqawZt9xAUJGF98R94l52QkQUnA3lx/dsdWG6ulsHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 07:45:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.017; Fri, 25 Mar 2022
 07:45:28 +0000
Message-ID: <982d233d-7e30-f44e-f49d-473c3c41721e@amd.com>
Date: Fri, 25 Mar 2022 08:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/qxl: fix qxl can't use in arm64
Content-Language: en-US
To: Cong Liu <liucong2@kylinos.cn>, airlied@linux.ie, airlied@redhat.com,
 kraxel@redhat.com, robin.murphy@arm.com
References: <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com>
 <20220324104928.2959545-1-liucong2@kylinos.cn>
In-Reply-To: <20220324104928.2959545-1-liucong2@kylinos.cn>
X-ClientProxiedBy: AS9PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb4acae-cbbc-4dbe-49b2-08da0e336e05
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272983E7777DF1962501054831A9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4zEB7ZMPrztq8B1oYzUA9ljTltG8Ke4u5NyqvQhwoa3FM1IWjA/BiV/HpUhz8liBCyHzJtauxu1aup+g8aDTvFn6XSsY7CoYFFC7iuuCqgGn4w8oPIrABvdrCQPrBw2kwzh0uYTSzMcE5INtzr4iVdMC6bMrjCZOhDqZusOnKW7RZmlL2z8NL7/3jRvvqW+VbCktSWASPV4DwibREZFwoxaE/JcLhSzhUXERx6zbifvzGmJdZIiKU6UMW6kSe/RtU45p2bgXa8cEHOW7+11boI4gRy+T7kpiUQ6jFxs75qHlRiEPXVPc3QYSNdMubWwFsoLTohExGEwe1E5fE9RLozG2+REBKBLniYGP3TFIv4v5ED9dppmtxYAZJJSGSInq8i08KRXdUykYBPrNOpAmxoy+5QJ3r3AFZgsx2Ce5ASkXEzaYvMR19H6rVIOGzAoLzqxRUQYhT5GtMuqx7cRyfWYRJ/Z9bnDiVQZr/2OK59c5ukX9jotjDULKmk7lFxxNHrpd02U2HtsKUmgZIBJkVg1TEq0JwR0sTlbSwhadRz1erG0ngLuuG8wFmgWCAeb219LFDOT8RE7lUb9+upcJkgKUjTHX1+5QFSn/nIEDybfnTY3naiWnq6Eyp0p7drLSe/3yudxbdDqyoJ5ZGB053UpfSs4FnsrYpCRtyAD9qorSL+3gRuD6KdMEg5WxTG+t3SqycpJoSzRsJn2fFgG44UMNm9jBLum4DphsP3/lYa7xgxEoaPh3/mbWCTrExLc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(26005)(6666004)(6512007)(38100700002)(31686004)(5660300002)(4326008)(8676002)(7416002)(36756003)(2616005)(8936002)(66946007)(6486002)(186003)(66556008)(66476007)(316002)(2906002)(66574015)(508600001)(31696002)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dhOUsvUWlZWmIyVmQyUDIrRzljZSswNmsxYmV5V3hBVUhvYXFWcG1nS05v?=
 =?utf-8?B?ejVSOGxDNUNuZ1JrVml0aUdMYldCUCsybWJDY0R0blFuYy81ODhFZGZSb0Za?=
 =?utf-8?B?RmgzeDB0cHNsclVuZmhyT3FyVnBnbndQODFCK0VFQktSalgxU2VxU2tWR2lR?=
 =?utf-8?B?SDkwTWppRldzQVBRc1JtZGNkSFBjSW9RUjZza0QvZlRMejM3cFhicEIxMVVp?=
 =?utf-8?B?bWNlVUovTXlFNDlYV0RoZGF6YkpwUWZ0azg3aks5N0g1Q2U5eXNRNnp6S3pC?=
 =?utf-8?B?TWludVdkaThOMDVMMjBxckxyNVJJOGV6Y3YvTW9lV0NSbThnckcwV0ZxQWk1?=
 =?utf-8?B?QWJZdWtGWnFvOTg1cVJDZzFIWTdYYmJoMWE0R0QxU3FBSStlejlCaVpYUGFu?=
 =?utf-8?B?RUJZY2pRUzB3ZjZWWWYzMlE5Um5PeG1sRmRudzdpNVU3bFRNR1pZT2ZQZVFm?=
 =?utf-8?B?djRPVFZWWkE2UGNScUYrQXlQbkZ5WlEzUGxXY2hXZnNhM1U0VFUra1dmVFVx?=
 =?utf-8?B?Y3dVUHIwRVRjcS9yVnNZcHp1RHRDMjVSTzdYazUwYWluc1BFWmdOMlJ5ZkpT?=
 =?utf-8?B?VW02OXZkc2s2L3BQVVZoYThFTmlsVDlMM0Yxc1RVVDlqeWlHQUdPY1dtM3VJ?=
 =?utf-8?B?d1NWVEVlRnBIbjZ5M2ZoYjVPRkozV25XaHJsVTB5RUlvNkoxeWY0QVd0ckpl?=
 =?utf-8?B?dStNZjFJS1BPajlHZHU5MVk4alJMOGtNcGE0Z0ZodTlxQlBWdEkweTA5NkZy?=
 =?utf-8?B?YkZhbDJicTNheFVuelNaZUJGTVFHaloxTkg1aHpmdFI5TjIrSjk0RTYvbjJX?=
 =?utf-8?B?VHJUWHcwTEdjRU50Qm1OYkErN1NrbDNaK1pPZmMzUWNDN2oxMWt5WFRFbTFu?=
 =?utf-8?B?b1V4UHdEU2M3UWVJRzBFY0lFYXBkcitVak1WbzlnQy9uK2VVazFsemtycGdK?=
 =?utf-8?B?WWVMMlVsclpPKzFiaW13L0E5MDRCNXBUR2FjMHFnL2pQUGZDME5PUWdjUHZK?=
 =?utf-8?B?RlF3WUp0R0RpSmRyQ0RveG5wVm5Ndm5SdnhzUnpHNW1LbnFmUEJNc01OWXJI?=
 =?utf-8?B?dS9FVm1CUHBTK2NsNzl1emZjL2dlR003N2d2Mlp4T25aeG5HSkNwdDNLc1BW?=
 =?utf-8?B?a1JSYXdsTHB1cEo0SFVxREMwemVsR3Z0cGZTamwrdW00aTJndXVGV1hOZjIx?=
 =?utf-8?B?OW9kY1dwVVZES2pUTCtZbVI5WmJCTEpwTC9wYzRyb3ViRU5yV252YzdjclR1?=
 =?utf-8?B?cVNtV3VJbW9kbDd5aHFISHRoYytnWFB6aGp4RERISmk1OHdiZ0N5UXgxU0FO?=
 =?utf-8?B?M3N4K0pQSDZETVQwaVluWU1XMU1KdGlWS3pPQVZZV2VKUHZjSXc5RHRVYXcz?=
 =?utf-8?B?a28zOThTNWVPdWJPRVRLZzNLUlA4TlRzZ3RRWk5zQzJobXZJOCt1dFRzWGFP?=
 =?utf-8?B?alZ0UTNOWU1rQllpZHFXNXRYOHYyejZ3bkRjZGJOT3Ird1ZWM1QwbCtlazQ4?=
 =?utf-8?B?blhUZVczdGs2NHE2NGFRWDAveG5NVWRCZlhTQVRjOGhjZG5pY0VNZkpWRS9B?=
 =?utf-8?B?aDk3WmZLNnlqSGo0OGY0K2dyNERjWXJNeDFKMDBDVlZYSHNGVzB0ZTNpSll4?=
 =?utf-8?B?b0lJTjJKVDJueUZUcGg0UFlzcWVrTFgzMVhIWkc4UVdDRnAvY0p3Vyt5TDFM?=
 =?utf-8?B?dE55WkE2VGwyVEJlQUV2QVZPbU5EUEQyeTgzbGhyQXR0Vi9LVklJbDNML3Iv?=
 =?utf-8?B?MExYemZzZ2w0aWxvNkhUSVRSU2pSenpVczZNK04rU0xuVUNwb29zMnF6MTEx?=
 =?utf-8?B?ZVhlT3QyKzY5OC9aajg3bithb2Q1ZTVYZFllVk1LQjBnRjU4c2xPd2psNnRE?=
 =?utf-8?B?cXh1RGpDd213R1F5OEhLVlhqMFRmQlZPTUgwZDJsU2tpaTVGdGt4Y3M3Umh5?=
 =?utf-8?B?NkVWempuUEU2cU9BSitYM0plUkErM21Jb1hkbjkwNjBrVU85Y29kampqL3Vy?=
 =?utf-8?B?Wm03cGIwUlpDbXp4c1hqZ09LS09SRTNpRGhqZTAzM3FPQjFMRWlGdUFNV0Zo?=
 =?utf-8?B?T1FCamVEY1h0bmNyODh0cjR4Rko0cFdPbCs1WU90TzNodk9pcDVnVlYyRjhU?=
 =?utf-8?B?Mk1Gc2dydDdZdnJ1NTNRSFBkR2xNKzM4KzFjSnVNQ3ljZHQyNm5WM3lRbTJS?=
 =?utf-8?B?dEpZcXZLU25tS2hZNUJWVVZHSkthelgrUDZpZnRPR0VwZHBnZm8zVmZ3d2gr?=
 =?utf-8?B?UFFXbTQyeEl5dWVFR3AyZFpLOENMYjNDeFpwWEVCbzlLVmoyWFBZRFB0ZXJX?=
 =?utf-8?B?NHF2UFd5RUlYVVNianFxR2YyeXl6azJnY0pGVGppMHlmL0x1R2VRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb4acae-cbbc-4dbe-49b2-08da0e336e05
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 07:45:28.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Laj1mut3KWwdhBkUtIFWXrAAtID8n+GfsiDkQeApuenigs0Ub6AfOibhinWrQW4T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMjQuMDMuMjIgdW0gMTE6NDkgc2NocmllYiBDb25nIExpdToKPiBxeGwgdXNlIGlvcmVtYXAg
dG8gbWFwIHJhbV9oZWFkZXIgYW5kIHJvbSwgaW4gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uLAo+
IHRoZSBkZXZpY2UgaXMgbWFwcGVkIGFzIERFVklDRV9uR25SRSwgaXQgY2FuIG5vdCBzdXBwb3J0
IHVuYWxpZ25lZAo+IGFjY2Vzcy4gYW5kIHF4bCBpcyBhIHZpcnR1YWwgZGV2aWNlLCBpdCBjYW4g
YmUgdHJlYXRlZCBtb3JlIGxpa2UgUkFNCj4gdGhhbiBhY3R1YWwgTU1JTyByZWdpc3RlcnMuIHVz
ZSBpb3JlbWFwX3djKCkgcmVwbGFjZSBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IENvbmcgTGl1IDxs
aXVjb25nMkBreWxpbm9zLmNuPgoKTG9va3Mgc2FuZSB0byBtZSwgYnV0IEknbSByZWFsbHkgbm90
IGludm9sdmVkIGVub3VnaCB0byBmdWxseSBqdWRnZS4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L3F4bC9xeGxfa21zLmMgfCA0ICsrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX3R0bS5j
IHwgNCArKy0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ttcy5jCj4gaW5kZXggNGRjNWFkMTNmMTJjLi5hMDU0ZTRh
MDBmZTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfa21zLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYwo+IEBAIC0xNjUsNyArMTY1LDcgQEAgaW50
IHF4bF9kZXZpY2VfaW5pdChzdHJ1Y3QgcXhsX2RldmljZSAqcWRldiwKPiAgIAkJIChpbnQpcWRl
di0+c3VyZmFjZXJhbV9zaXplIC8gMTAyNCwKPiAgIAkJIChzYiA9PSA0KSA/ICI2NGJpdCIgOiAi
MzJiaXQiKTsKPiAgIAo+IC0JcWRldi0+cm9tID0gaW9yZW1hcChxZGV2LT5yb21fYmFzZSwgcWRl
di0+cm9tX3NpemUpOwo+ICsJcWRldi0+cm9tID0gaW9yZW1hcF93YyhxZGV2LT5yb21fYmFzZSwg
cWRldi0+cm9tX3NpemUpOwo+ICAgCWlmICghcWRldi0+cm9tKSB7Cj4gICAJCXByX2VycigiVW5h
YmxlIHRvIGlvcmVtYXAgUk9NXG4iKTsKPiAgIAkJciA9IC1FTk9NRU07Cj4gQEAgLTE4Myw3ICsx
ODMsNyBAQCBpbnQgcXhsX2RldmljZV9pbml0KHN0cnVjdCBxeGxfZGV2aWNlICpxZGV2LAo+ICAg
CQlnb3RvIHJvbV91bm1hcDsKPiAgIAl9Cj4gICAKPiAtCXFkZXYtPnJhbV9oZWFkZXIgPSBpb3Jl
bWFwKHFkZXYtPnZyYW1fYmFzZSArCj4gKwlxZGV2LT5yYW1faGVhZGVyID0gaW9yZW1hcF93Yyhx
ZGV2LT52cmFtX2Jhc2UgKwo+ICAgCQkJCSAgIHFkZXYtPnJvbS0+cmFtX2hlYWRlcl9vZmZzZXQs
Cj4gICAJCQkJICAgc2l6ZW9mKCpxZGV2LT5yYW1faGVhZGVyKSk7Cj4gICAJaWYgKCFxZGV2LT5y
YW1faGVhZGVyKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX3R0bS5j
IGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfdHRtLmMKPiBpbmRleCBiMmUzM2Q1YmE1ZDAuLjk1
ZGY1NzUwZjQ3ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF90dG0uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX3R0bS5jCj4gQEAgLTgyLDEzICs4MiwxMyBA
QCBpbnQgcXhsX3R0bV9pb19tZW1fcmVzZXJ2ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwKPiAg
IAljYXNlIFRUTV9QTF9WUkFNOgo+ICAgCQltZW0tPmJ1cy5pc19pb21lbSA9IHRydWU7Cj4gICAJ
CW1lbS0+YnVzLm9mZnNldCA9IChtZW0tPnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsgcWRldi0+dnJh
bV9iYXNlOwo+IC0JCW1lbS0+YnVzLmNhY2hpbmcgPSB0dG1fY2FjaGVkOwo+ICsJCW1lbS0+YnVz
LmNhY2hpbmcgPSB0dG1fd3JpdGVfY29tYmluZWQ7Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2UgVFRN
X1BMX1BSSVY6Cj4gICAJCW1lbS0+YnVzLmlzX2lvbWVtID0gdHJ1ZTsKPiAgIAkJbWVtLT5idXMu
b2Zmc2V0ID0gKG1lbS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKwo+ICAgCQkJcWRldi0+c3VyZmFj
ZXJhbV9iYXNlOwo+IC0JCW1lbS0+YnVzLmNhY2hpbmcgPSB0dG1fY2FjaGVkOwo+ICsJCW1lbS0+
YnVzLmNhY2hpbmcgPSB0dG1fd3JpdGVfY29tYmluZWQ7Cj4gICAJCWJyZWFrOwo+ICAgCWRlZmF1
bHQ6Cj4gICAJCXJldHVybiAtRUlOVkFMOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
