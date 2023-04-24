Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F0C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 21:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52747417F2;
	Mon, 24 Apr 2023 21:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52747417F2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tGPZqAJk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-QAhqwKj2SH; Mon, 24 Apr 2023 21:48:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AFC8404BF;
	Mon, 24 Apr 2023 21:48:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AFC8404BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A326C0036;
	Mon, 24 Apr 2023 21:48:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82650C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E524407D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E524407D7
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tGPZqAJk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8dfCaV6z4D2I
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D35424062C
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D35424062C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj4CyUuhT+nCrP3DWDr5WSbIkFhw6R4j+HXVJ+yWtUbDA7fS34QchTnMYmCCSnFyKSq4h4vrEEQ4f/+RhSQ1OVn5YB/OvMdt7Ensw75T7j2x4R1ECNDWm+WOxdNodEQVS0ZuQ5Dyysc4VcaXgIivJ1L6vEIy6dyl7rOu1mM+vIxDXErAMBqgjZhI4cTB224bnUc6OmHltDbzq505yImvYpTNpxpvUifvy9YVt0EdrhL1pTFGtrUB31+i1pkElybQaAlktgmR3S/12U53R6UJGAskCeE+2v9hVGerBAa8wXaSl7ods37bHnqhClUuVghrGUC1EgtURiDA0hPZiXqFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bguDR0CHo7FIM/ZIo+20+aLPot59S4F+Zm7ZCuA/RuY=;
 b=A5oc6kuWK33oxQJPNF0SDgJJIyVhbqUH/NX09DNt0O+noU3uNCwmCOP1z9e9U+gkD+9jOtFga/t8YJqQ5rJxJ0pX0Dqwp+Q1SC2SX/pT1OdLhS14L+MtYd5RDyjTZi0rbSZDgg3JiVRJ6J4simLGieNfBMWN+eZGUY8WWVfjMsLwgyFzkP7G5t8RfWqMc+cUWx4k+YX9YazzteYVc/urs2w78URiIgPt2i1KLk2pHslMzgjAbwU0zqryZWPq7HiFS8CyhUC95mSwANwd6iTmk4j7rOPEM/k9rCJgRMZa1Dv64Gtb355u6ixDEXQXjwQ5Hmb5XUg2baSKmWTPsxk4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bguDR0CHo7FIM/ZIo+20+aLPot59S4F+Zm7ZCuA/RuY=;
 b=tGPZqAJkwwCormvg51sNPc85d9a0HzdKVjvQGz2NqpM7NK82hFGNzt4aOW2wemGJPlZXxtn1xTYsSdrvTQaOYtw9dgiRTFSQkNm3GjxkSUtVxXV3feAxAqm+X8JlFOoTbMKwlvRex7KDdOnqHrXSi6njZI5J8msEEr6pfjnY1nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 21:48:17 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 21:48:17 +0000
Message-ID: <e7ee20ac-ce1a-e29d-e6be-605a5eeb6c1c@amd.com>
Date: Mon, 24 Apr 2023 14:48:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] vhost: support PACKED when setting-getting vring_base
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230421195641.391-1-shannon.nelson@amd.com>
 <20230421195641.391-3-shannon.nelson@amd.com>
 <CACGkMEsSyZFzB8k1Fpep35Yc7iLL9xmB52BG6F7gnC7ABGZ_5w@mail.gmail.com>
In-Reply-To: <CACGkMEsSyZFzB8k1Fpep35Yc7iLL9xmB52BG6F7gnC7ABGZ_5w@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL0PR12MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbdc19d-544c-42c4-5efa-08db450d9cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00SMGKgfrIsfefGwUZmcuGxowXunpze/prbnq6JVKMsZ8hp1zcG8o/lfmV9zDdsOTAG7SsaEZzzalTcDlvNnig7feCO7Trtg5/cm4tXjw/MxD2Eh80Kuj33CzUQfJlPryTugV8c40zWQPavPuKd7m3a35fipgpVQxpH7zR5SoeB/dMa7omlBG4PhVbMW0mEfhnqIUX0RNZ1oWoFYMLJsxpN5m/dtoDC69k1DvI7w6EyROHUJrm0f+/VXuCfeFXpLJRDpSD+EzZO3VxC/qAMIgAyLxOjBbIt7ohtQ6fSsr6+2jP+piJHZXEUXU9A4b+bHPj3IQ6KITG0XH94+0hYYm5c8ZHFKghQ+Wxu99ZUpQATul9/zYnYkQZuXK8gOIBPNQ3eY2PItyfYFGqGGu+s2GHCcRZhvbxyvyUl+Np/sLD+m5dc6Nnm+3ac96curojKoBxBSMDX8zU1KpxlGk5Egy3ypYsaHKGVwta+RjSeorytAmtgk60n+vLWt6MxX0ZcY2UQWZcy0qtLUg30wUzAUu9Hh8wEo7UQCxAiqYyRu/rWERuMsBIBShuNCFX4fv8Y6/2u0TasvkjdmwNygpCfz7lNicedHq/tRrVQ+iPmsdNDwvbBC+FCA1Ubd9zuUq7Nd5Xr7m6Mtotz8cBrzbQvT8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(31696002)(66899021)(86362001)(36756003)(186003)(53546011)(6486002)(26005)(6512007)(6506007)(4326008)(6916009)(66476007)(66556008)(316002)(44832011)(83380400001)(66946007)(2906002)(38100700002)(8676002)(41300700001)(31686004)(5660300002)(8936002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekx1TEllL1ZXNUdnNnBRWWNMZFF2bzZxaHc1K1duY24xaUQyVHhmQnNnRkN0?=
 =?utf-8?B?WFJqbXBRdTlqZHN2UjlidDVEakNMVWZVdVFMenAyMU56ejZuSzV2ZWhkUzd1?=
 =?utf-8?B?clZRUlpNZjlvK1J1akxmZXpMaGpLN0ppaTg2cHpWdmRUVUxZSkdCeWM4a3ov?=
 =?utf-8?B?cG8ybmRPckRid1doYk83azN3MkxwYjA0S3kvbHZvK1A5YUN1ZFNOcWRobkV4?=
 =?utf-8?B?anB6bjI2Y3lIakRQR2Q3NFdCd1A1ajUwSlozYk43T0FyK2pENHhsckZWaXo5?=
 =?utf-8?B?ZkEweGVmdmFXS0ROQTliRlRHNnJabkdHbEp4YXlQY3F3UTFzYUlLVGtjSTB1?=
 =?utf-8?B?aDhwSGxlcTZqa09oaVVydktsZVhGOVpETXNqRlczVXdZQWVyMStwVFBPTy9Z?=
 =?utf-8?B?TXlyVUJwQ0cxbWpkaDRMS1BVWnliK2t4S1d0cmFCcWVJdnpwUmIvVmxMeVdK?=
 =?utf-8?B?a0t4Njl1Rm9OYnpSanhDUFQwRzJUYWx3Sk02aExyQzgzQlBBNXVnU1hYekVi?=
 =?utf-8?B?eUl3MWtRK1BZZEdPY3h4dXM0QTBqZ1RvR3ZJdmJ4Z0JMcHlXTi9Mb1UvTCtP?=
 =?utf-8?B?QmZpVVhSV1JnUkttL3l2TWxoL2RncmkzdWs2YmJFbEFtclZ3UFFScEl0em9v?=
 =?utf-8?B?K0Y0ZzNISEZ5YnQyQVNRc1Q1M1RLTHI2TEZCVEJzaTJDT3dVU1F5YjJJWTRB?=
 =?utf-8?B?d2thSjBSUW9MVHBLS3ZxSDhLaVRzWTZuR1FLczk1d1AxdjJDd3ZSQ0s1Qm94?=
 =?utf-8?B?dWdyWCtYcjVHclNGRE1sRUNtaVZrQVYxOUxHckI0VWMyRmhyQ0N1REdTUjV5?=
 =?utf-8?B?elFwNk5OK1ZwRXJxU3ZNRXRub2xSYTUzT1VFZUROSG01RHNBajdUTWNHbnpi?=
 =?utf-8?B?SE1HN0NIY0E5NCtmeHhoejdRNkhzMlZpWElFa1RIcUgzb2xlZVg0NlJkMVkx?=
 =?utf-8?B?eXZlQVhsZXB5bk5hdjNRZk05djVFZXgwVXc0SE4vcHhUSXo0VnJVY2FEQkR4?=
 =?utf-8?B?NDR4aUZtejBlYXJHSkFrVVZmaE9FYUplcjBmSDlKWHQrdkUxUDlxWFNGUFVn?=
 =?utf-8?B?alRnRDBTamFrYnlJMDlMczZLQWNhanlzVmpudlFWcTl3NXpjTzliSm8rdytz?=
 =?utf-8?B?SW9maGtuY0N2TG9RbE91L2c0dGg4aTQvZWZCbzR6VS9JcEl3ZmVKdVg1dGcv?=
 =?utf-8?B?VENLa0FFaU9CbVVTQnZUNzExbEZJQ054ZFRoSFpTTWpPRmdsZVNYakVUN1RV?=
 =?utf-8?B?OUtVMkRtejlTVnNCTS95Yk90NzA2ejh6clZBMHE3bDYrK21HV3cxaGVKbG9L?=
 =?utf-8?B?NWhsdyt4dlEwWU9OSU9FZUFQMXkvQ1BLR1U0VG8vQjRibDJjZ1hZWXRIRU5V?=
 =?utf-8?B?VWVmbC9pa3ZqRHZNOHlINXVKQ0x0R1gzNnJzZ3U0Ri85WWF2VFlIYlJrYytt?=
 =?utf-8?B?NUt2ZStwWUNPSmk0cmxWUlNWYUVqb1dlNGJoQUVHb01uZEl2K29Dbkk2RGRv?=
 =?utf-8?B?Wms5a3BoZUtMVjVlRWJFYmxGTFhZMGVkeVMwLzhSYzg5SnJ4aEp1REJSTkhZ?=
 =?utf-8?B?Y0IxbWJySlF5MUdBaVQ3dVBhekdvbzhrUDNLSFU3cWtHR2dLQUgyTVdZVDAy?=
 =?utf-8?B?Z2Zodm54TlI0R2VxL2lobzE2ZXFRVm80MEFTSTR0MkFXOFhXemYzaUR5KzVU?=
 =?utf-8?B?SmlhQVVJdEtvdTlPY0N1VEpuYWM3WUlBS2txVmdiV2JWbjJ2Ti9XRnZYd0sy?=
 =?utf-8?B?bUpwMVd3WXVSM3BTbE13Y1M5dWpZZDYwY1czb25rQ3hVcnBQVDV1NzYzaWlM?=
 =?utf-8?B?eXNDZHVTWVBvamNDT1IwdTR3Rk1qSEcyN0xZYXlRODAxR0M1cGtvZUNKdG52?=
 =?utf-8?B?NmY1RWwyQW9jOTdQUWdpZkdWWm5yYmNNM3NwZWdKMHNTd1gyYzY5dnpUcktv?=
 =?utf-8?B?cURxZENMc3I1SHArcW9oazJua3F2OFhmMlV6V0ptUkhoaXFxbmh3SzdqYmw5?=
 =?utf-8?B?MEFKb0o0R1BENlZyMnYzdm9TNkk2OU1vUzROUWF5N05RQ0tOdnBpZ2c3aHpF?=
 =?utf-8?B?aTRlNk5MRkRyUCtybm1kSXJkUkxnWFhhYXdBRXE4aS9IRytvaGhmalNHRlc0?=
 =?utf-8?Q?oWDaRZTwsT+SUfuwl+AY3fs3U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbdc19d-544c-42c4-5efa-08db450d9cf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:48:17.4332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvhJLr6lNzYsuXA94n/0aA/6GSjBB9yUfMRZzYLBb4JWXAvJe5XtdujTpNCrRNGI4muOFV12Q2oxsh4CkvUteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNC8yMi8yMyAxMTozNiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBTYXQsIEFwciAyMiwg
MjAyMyBhdCAzOjU34oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+
IHdyb3RlOgo+Pgo+PiBVc2UgdGhlIHJpZ2h0IHN0cnVjdHMgZm9yIFBBQ0tFRCBvciBzcGxpdCB2
cXMgd2hlbiBzZXR0aW5nIGFuZAo+PiBnZXR0aW5nIHRoZSB2cmluZyBiYXNlLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPj4gLS0t
Cj4+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMK
Pj4gaW5kZXggZjExYmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gQEAgLTE2
MzMsMTcgKzE2MzMsMjUgQEAgbG9uZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2
ICpkLCB1bnNpZ25lZCBpbnQgaW9jdGwsIHZvaWQgX191c2VyICphcmcKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHIgPSAtRUZBVUxUOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7Cj4+ICAgICAgICAgICAgICAgICAgfQo+PiAtICAgICAgICAgICAgICAgaWYgKHMubnVtID4g
MHhmZmZmKSB7Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsKPj4gKyAgICAgICAgICAgICAgIGlmICh2aG9zdF9o
YXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtICYgMHhmZmZmOwo+PiArICAgICAg
ICAgICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCA9IChzLm51bSA+PiAxNikgJiAweGZm
ZmY7Cj4gCj4gSSB0aGluayB3ZSBuZWVkIHRvIHR3ZWFrIHRoZSBjb21tZW50IGFyb3VuZCBsYXN0
X2F2YWlsX2lkeCBhbmQgbGFzdF91c2VkX2lkeDoKPiAKPiAgICAgICAgICAvKiBMYXN0IGF2YWls
YWJsZSBpbmRleCB3ZSBzYXcuICovCj4gICAgICAgICAgdTE2IGxhc3RfYXZhaWxfaWR4Owo+IAo+
ICAgICAgICAgIC8qIExhc3QgaW5kZXggd2UgdXNlZC4gKi8KPiAgICAgICAgICB1MTYgbGFzdF91
c2VkX2lkeDsKPiAKPiBUbyBkZXNjcmliZSB0aGF0IGl0IGNvbnRhaW5zIHdyYXAgY291bnRlcnMg
YXMgd2VsbCBpbiB0aGUgY2FzZSBvZgo+IHBhY2tlZCB2aXJ0cXVldWUgCgpTdXJlLCBJIGNhbiBh
ZGQgaW50byB0aGUgY29tbWVudHMgdGhhdCB0aGVzZSBjb3VudGVycyBhcmUgbGltaXRlZCB0byAK
MHg3ZmZmIGFuZCB0aGUgaGlnaCBiaXRzIGFyZSB1c2VkIGZvciBhIHdyYXAgY291bnRlci9mbGFn
LgoKPiBvciBtYXliZSBpdCdzIHRpbWUgdG8gcmVuYW1lIHRoZW0gKHNpbmNlIHRoZXkgYXJlCj4g
aW52ZW50ZWQgZm9yIHNwbGl0IHZpcnRxdWV1ZSkuCgpTaG91bGQgd2UgY2hhbmdlIHRoZW0gdG8g
Yml0ZmllbGRzIGFzIGluIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlX3BhY2tlZD8KT3IgcGVyaGFwcyBq
dXN0IGFkZCBuZXcgZmllbGRzIGZvciBib29sL3UxNi91OCBsYXN0X2F2YWlsX2NvdW50ZXIgYW5k
IApsYXN0X3VzZWRfY291bnRlcj8KClRoYXQgbWlnaHQgYmUgYSBsYXRlciBwYXRjaCBpbiBvcmRl
ciB0byBhbHNvIGRlYWwgd2l0aCB3aGF0ZXZlciBmYWxsb3V0IApoYXBwZW5zIGZyb20gYSBuZXcg
bmFtZS4KCnNsbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
