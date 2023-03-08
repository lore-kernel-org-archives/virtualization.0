Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F7C6FD20
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37188417E3;
	Wed,  8 Mar 2023 14:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37188417E3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WkjF3vAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9q8HvIWnHl6j; Wed,  8 Mar 2023 14:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3134C417D3;
	Wed,  8 Mar 2023 14:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3134C417D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2C9C0071;
	Wed,  8 Mar 2023 14:13:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3276C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C145840C0F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C145840C0F
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=WkjF3vAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0THdQJcB5IsU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:13:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC79C40242
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC79C40242
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhKPpJPDpZAYJMp08bTCcvALoNKL78esxvJ6A4LMLUXTccJ8fa8Ta4c5lS0otsHmH1ikH+tUS86luqO9ZxEcnmMaQ/rttKVg8SpOEPuf0h0fRzvAENv1NkBh3s1bG0IhDPi/Jt93OB3fJFkoT2NaPzJvLqMt1BpTjw9e4WJCBD6ULsoo1gAELMdpIGAFiJqEE+AuyaBI0AJM0BKa7c/zF6awPNAREZ6aukNHp/lmV0iR4D0Q+qPoFKOzBZtHVCLbZZ7ntSwNrwdicZl6wureiDqcK0d4TuhUkEnZRFMymbOPE/l0CNqAclFZTxuN9ExcPNjmvmpQe/XHwD9BfMuj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A5gVm5CX1q+DQudNh9KydGozldvto/s+BFrB6LmZdE=;
 b=IbgeottnlR1qz1t5GgZald+IltoeOBu2qf4EcMcmha5OYwjjgDUeBbgiLHSerOW0TtBKnMgVjYgoYhdAhAqtUJVyxq7TMBcZ4Is/VJfUXgeJ10GiOuMDNk+J9alH+G/PykTCyBE2JXAAdW2vfd6YvQYwgEAGXE70YoUHHPcVgKXo8I9m1H9Z3dVlfdCrJnJqNzuy7xLvzZ/GKkSUVq/tN2u/iMFdWdI+kwE5R/aaVLQM5cei+dhagq+0b8BSFy8OpKwifSVkF8HHaKg9kg3Kc2dtJ/PzW+OrHrkiQbJ2uwFo4vARpHfL6INklARJnSvMRlaW00UiHY74McAmGqYKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A5gVm5CX1q+DQudNh9KydGozldvto/s+BFrB6LmZdE=;
 b=WkjF3vAMqd6hSsw4VPadekQTX2dmGCPwGTQZMwGlRN7u3CMmoEpMZJrCsUD8B5qacC5/ZwYERJGtwCLc+YTDa6vb+G4w8nFjMmcZSSAaYGEZ8LWwDkPhNUoRfl0zhD12ba9kfEAKiZ7KwxjoxkTfhlkWzbBA0TLlyp3xVqhr5UhOOc88GAAIryQCm9+w9X8REgNlT8/88IVbVFPOTkQy270tSqROm950YlJPfeTW64JiMXQZVfqU0tsLzcP0q491nFPf3TTIx3Noz4fvqKpGZ3N8B0LQj9W1RVcI7Ohz/MOfjqcRSXg0OTBYi526suzg0afmxzLtZdlariqwwVJf2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 14:13:42 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:13:42 +0000
Message-ID: <a3f4e89b-801c-6f4d-e9bc-a420ff4221ae@nvidia.com>
Date: Wed, 8 Mar 2023 09:13:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: virtualization@lists.linux-foundation.org
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
In-Reply-To: <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
X-ClientProxiedBy: SN7PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:806:f3::23) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d236ae-f4ec-4ba3-7bbb-08db1fdf5299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9jqoCOPbYdYBoy85A12sniL3oxBHjeeU3k36x9BIEbOcrUGDmsi3tLuYWkrnR0p6HZSpkfh6ha1nVa3lbVliMWG1HTtlR49MHjBjHFjAs8t7y3oGQHVxbqiv3BMKo6ILrdthCXMZtYFrgL2GfJtlDu9BSAZoh3o3amGFVdg1pwhzO+COWJkZ9ESyThTXtJEmU8xsGC+eay4zCAQ+V6ylWCA7VpY5tPeQK81oTWarzMvaG0SWif0LuGziclxpTyNl9HiJk1s6h1TKbiAG2+oPD7XNAiBauFUE307dYLdVarJdTStcHe+biFW7WZRat9DzG3nB8TkiNeu1gi+yflwwyqTHlKKNXkT/0RUrf7kzMcgOP5DzAy24wmUASIkGwm7h6yZDiMz5imDhxZaQ/htrYtMPGHNJdxJJsFFpPGKS2Ra+cag/hh1ikpd+BIqnqu9x3ZGx9Z2kMZnYhxwMNa27AiKIyMDu2qdOf/N+REGOOoYEIAoRvvtBEyKWEGvzl02uf833z8S6h5ChCM4T1iT/UIjur+9TKByzJ5cjJImtHPWdeyknKWbS8eSjXztT6XUzARqsLZAJuSp7OpbuiFsQ7NePJxIa4tbaQkD8YQ49ccfoeznSMJKp7yeSQtowKQZc4sz2cjifUVqsJFX9iZKp5p5l1JbdObZshCQE7OP8Z/c0tQXT4LykJDxFjV21CKWB2xUFvV+CI61lA3Ofti4As5q2KmsVi5MIpNM/fRbLkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(31686004)(36756003)(26005)(83380400001)(45080400002)(478600001)(6506007)(38100700002)(316002)(6512007)(5660300002)(6666004)(2616005)(6486002)(966005)(53546011)(186003)(41300700001)(66476007)(66946007)(31696002)(66556008)(8936002)(6916009)(2906002)(86362001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEd3QlppWHNVdVRjNktXdWt2ekhzM3hlMG0yZnNsL2EyR1UreFlwYzVacGN0?=
 =?utf-8?B?aUJ6SzZQZE9JRURQQTFNUjUyUFZ3d0RIL080dDZaQlZWZkpkSElYT24xRklP?=
 =?utf-8?B?VW50MzVFTU4yejBzcnZ0LzJPMGoxTkFlYkRWdzd3VWFZNnBjR0dXUTlkNFNN?=
 =?utf-8?B?b2dBL3dVL1ZsOC8xcGZuSExiV0hOcjkzNkxoV09IUXdhTVVyVm0vUWxuMEF0?=
 =?utf-8?B?bGFWKzJ2RGthVXIvRm5BejVJUTdWTFpBMEsrNXZDQlpqckI5c1FhTlE3OGcw?=
 =?utf-8?B?aWpXNG5TTHRLVU5EZXRPVjlKWFRUMXZnbEo0SkdOSXg2R2dQQWtLRHFWTDFs?=
 =?utf-8?B?UGhpTm40ZXcvQWxsU1V0VVZiMzFhWk1TTDZOYTNkajlUYS90OFgyUE5SMzVk?=
 =?utf-8?B?cTdKTUg2VVE2UDBacWpyRmxqcVpZSG1mRzRPRUpibStVYi9aS3MxcW9NOTZa?=
 =?utf-8?B?UzQ3UlFTTzgxK05pNlZjc2s0OVFVQnhLK3dDVXo1WndyZDRPWTVHM0VCc2hF?=
 =?utf-8?B?UnN4bHV2bEVxSW14bWE1b0xlM2x2QkJ1SWg0WVk5ZkhzNGpvNTdBUExNaTV4?=
 =?utf-8?B?SnNOVkcrbGR1MHdjU0NmbkhVNVhKYVFma1lUTzBWaFV5QjYrajhBSjRkU0hC?=
 =?utf-8?B?bW5OOWkxTFJEY2hiakdKMlJERVRSckZSODVGSkdGWStpa1JlQ0ZpNHlmVnBB?=
 =?utf-8?B?dkJ0TVZTWm96YXBlejVDRisrNS80N2YzU3NLY1JkSDVEcE9DUjBTc2dDTm1x?=
 =?utf-8?B?MzZ6cUNicVF0MjEyRzU5TkNXRUhmeG9YY1dvQVBaeGI0alpOK1JWZElkdWF4?=
 =?utf-8?B?dVVYbGtMUitVR1crdGhpMGtFQkd2L2lBR2h1WjNaUm1BVkFYOWk4UE5HWSti?=
 =?utf-8?B?c3YzbzBTZ3BYeVVmUThla3ZDYTMzd0pnMC84WGNRTm53VHRYbThvelN2UHhD?=
 =?utf-8?B?T1hzMWhNcjdJZ25Sd24rMzJCaWFSM1ZVZUtLQUJCUCsvVmJkVGVQcEZSWG1U?=
 =?utf-8?B?NUI4SkVmY3FJL3ZaVFBPMjkzOFRoekxmNDQxUU5jeHN2T3BBZWU5VXNMVmJp?=
 =?utf-8?B?YTRoQmVmUjZOVEEyaVY5dGJtZVJ6cVBnV0tyVm1ZMlFRK1lhZGlVOUMvT3NK?=
 =?utf-8?B?RTJHcHIwSkRVdWNVcjNYT0FWN3BZcU5mNWp3Y3lxTUpMSVlZM2lGSjRGU2dG?=
 =?utf-8?B?MTUrUVBGYWdCaktQYlVvUGxwSUVST0o5UVZVYlpmaHRaMm55czlBTUpDQmk1?=
 =?utf-8?B?Ry9zQUZzRm9YN2RkU2dSKzh4NE1tQm01VG1LRmRJbGZKL21vQURRMlRBNnZm?=
 =?utf-8?B?VVZmRW1lM1VuS3BGeWlBTkVYc2xxUGU0RitPU21GTDVlQjNuQUNXVTRzZXZy?=
 =?utf-8?B?T2FhVkh0VnVXZ01OV3JMQ0pEQjBlbzhrN1JrR3BnMVYrbnJWaTdNVXhnYk9J?=
 =?utf-8?B?ellHMkYvTVBGb3FLZUxHcE1paU83Y2ZzdSsxdmhKRzRjUWRpaElzaStjT0dE?=
 =?utf-8?B?elovL1h1eDR4Z1d1SVdhVjZFaHdvL3pieHhzN3cvMFkxWSsvTWI5UUFVRVFD?=
 =?utf-8?B?bThYa0JGZWJ0aERlYndqWDFwQmNGY1l6SG1tbmYrQTFieHlvVnYrZm9aNTlJ?=
 =?utf-8?B?OS9yNWZjQ2dzUkttRnFyYWkvaUFGZUdDRW9GTk5oT0VxOFVESGlzZDNZUXpL?=
 =?utf-8?B?QVJzbUlRQ1d3M09LVStyenFLUjBKTU9GbDVVQ2k2dXpoVmFML2FKN1BROE42?=
 =?utf-8?B?b2F5bUFVdDg4eDVnbXhxYkRhVW03OU5odythOWlIc29KUmo4ZUZUU2ZZQitC?=
 =?utf-8?B?cmE4eEhNazljd0JrWktoWGJoaW5wMzd6c2JjcHVsZXd4cjdxME8yQnRtUVFN?=
 =?utf-8?B?K0lrd0cxUEdyRjhvcG51cDRGUEFlMjh2d1NockZ6N2x5VURRSTRyQkd1Yk9G?=
 =?utf-8?B?QmE1U2haZGJCSDNiZDA3d0NEV0VxMnBDQS9SaGl5Mnk1MHFYSkVLSEltQnVi?=
 =?utf-8?B?aFZnaExjQUY1bTJCdmxlMEpXcC9mcnJKZTFTSGY0Q2pzRWowUzVwZlgxZi9T?=
 =?utf-8?B?SmpLTXI5NVJJZjBJS3B3NHhOVzBzNU9Rb0MyL3ppSjdVd0ozMFZ1b2VQU2tk?=
 =?utf-8?Q?zZRbBQjXl+Epdh6WX6jCLcBGR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d236ae-f4ec-4ba3-7bbb-08db1fdf5299
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:13:42.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Tp2ER9fayCbWwFYobX+/Y1pIFFbazlYDj0b3B8aV/FE5XHvV1RAL9KFL4BhRWXY21N2FxL8Sj5PYhEfBaot6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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

CgpPbiAyMDIzLTAzLTA4IGEubS45OjA3LCBGZW5nIExpdSB2aWEgVmlydHVhbGl6YXRpb24gd3Jv
dGU6Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMKPiAKPiAKPiBPbiAyMDIzLTAzLTA4IGEubS4xMjo1OCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMKPj4KPj4KPj4gT24gVHVlLCBNYXIgNywgMjAyMyBhdCAxMTo1N+KAr0FNIEZlbmcgTGl1IDxm
ZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPj4+Cj4+PiBBZGQgY29uc3QgdG8gbWFrZSB0aGUgcmVh
ZC1vbmx5IHBvaW50ZXIgcGFyYW1ldGVycyBjbGVhciwgc2ltaWxhciB0bwo+Pj4gbWFueSBleGlz
dGluZyBmdW5jdGlvbnMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52
aWRpYS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amlyaUBudmlkaWEuY29tPgo+
Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4+IFJldmll
d2VkLWJ5OiBHYXZpbiBMaSA8Z2F2aW5sQG52aWRpYS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogQm9k
b25nIFdhbmcgPGJvZG9uZ0BudmlkaWEuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+Pj4gwqAgaW5j
bHVkZS9saW51eC92aXJ0aW8uaMKgwqDCoMKgwqDCoCB8IDEyICsrKysrKy0tLS0tLQo+Pj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4+Cj4+
Cj4+IFsuLi5dCj4+Cj4+Pgo+Pj4gLS8qCj4+PiAtICogVGhpcyBzaG91bGQgcHJldmVudCB0aGUg
ZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwgYWxsb3dpbmcgZHJpdmVycyB0bwo+Pj4gKy8gVGhpcyBz
aG91bGQgcHJldmVudCB0aGUgZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwgYWxsb3dpbmcgZHJpdmVy
cyB0bwo+Pj4gwqDCoCAqIHJlY292ZXIuwqAgWW91IG1heSBuZWVkIHRvIGdyYWIgYXBwcm9wcmlh
dGUgbG9ja3MgdG8gZmx1c2guCj4+PiDCoMKgICovCj4+Cj4+IEFueSByZWFzb24gZm9yIHRoaXMg
Y2hhbmdlPwo+Pgo+IEhpLCBKYXNvbgo+IFRoZSBvcmlnaW5hbCBjb21tZW50IG9mIHRoZSBjb2Rl
IGhhZCBhIHN5bnRheCBwcm9ibGVtIGFuZCBjb3VsZG4ndAo+IGNvbXBpbGUsIEkgZml4ZWQgaXQg
aGVyZQo+IApTb3JyeSwgdGhlcmUgaXMgYSBtaXN0YWtlLCBJIHdpbGwgZml4ZWQgaXQKCj4+IFRo
YW5rcwo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5saW51eGZvdW5kYXRpb24ub3JnJTJG
bWFpbG1hbiUyRmxpc3RpbmZvJTJGdmlydHVhbGl6YXRpb24mZGF0YT0wNSU3QzAxJTdDZmVsaXUl
NDBudmlkaWEuY29tJTdDMmQ0MDYzODhlODY2NDA3YTNhNjQwOGRiMWZkZTg4MTklN0M0MzA4M2Qx
NTcyNzM0MGMxYjdkYjM5ZWZkOWNjYzE3YSU3QzAlN0MwJTdDNjM4MTM4ODEyODU3MzkxNjQ2JTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9b1hv
amhOdHhNNFNLQXp6bmF3UVNJR1UxMVhxYmhWQ0NVRkI2RFhKb29JUSUzRCZyZXNlcnZlZD0wCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
