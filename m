Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB6CE7A91
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 00:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 859254046F;
	Mon, 25 Sep 2023 00:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 859254046F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=IYAXSTBB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBciXzIfpR39; Mon, 25 Sep 2023 00:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1113140520;
	Mon, 25 Sep 2023 00:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1113140520
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC12CC0039;
	Mon, 25 Sep 2023 00:56:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA77C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 368ED81839
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 368ED81839
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=IYAXSTBB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8UK6Ul3M-tnY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:56:16 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A78481815
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 00:56:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A78481815
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.184.89])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2BEAB10000459;
 Mon, 25 Sep 2023 00:56:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1695603372.755000
X-TM-MAIL-UUID: 4eebc0b7-ea5e-4847-8887-dd53043870d4
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown
 [104.47.11.169])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 B86AD10000410; Mon, 25 Sep 2023 00:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmxcBgwUTyHSD0HdMiuLlH8mvXv2+8czjhOTv5yCvginFTdT9nRNLZ8X4AJ2BSTZiDJzyJA8uGer59vOu0HsbTpWxlT01VfBvLqdl9x0lBTFGCU+ye1lF6E/bLTrSvJDFTow/YbatZhGZnWmXi2iskCqlnJ0/8dtIcCIzutEqJYPaCwxzSUA+XONDNgwXhBL/COiEPauqgGZRqB73m8lRQxYPClEFiXRb9MrhXJzcqw+gp+pq0IAxnUV/UJYLA/9oChZ/VLLGFces9bsUvUd0Qr/fU5JDZY9F4X6ehKrQMNeqc8CrCT4SeXvGyEJgSRGSKNMb7sGJTlMG2W3znJSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gy6YxWUX+mkHS6dh3UEfR7NgCX7YclSFvgsqljrmEA=;
 b=G260ySVy9UqgYTgtrDaEdjhZLklj/glhUouJzqSY8a5s/nHQGVzBtAvYdR5SPmzkRlkxbx/7Ag8UT3HD8IenZwpCmm6O6MbkZ7mre1LX6Q4Lln+yT33De/tDqLcoXEZ3r3AkBygdeULKp/WUzKf1LgGGA83G0A2W9dHvECK6IzIUH42NayHDsb/aHVRevS1/ara5h/HRu4EM4l4q1clQ/4m1PihpwI76bx1E5rn/qdvyxYXOAH5q5wJjzBRxEm1bHU8fbtAuUzmQbbGs/6lodxGNfl8yPl3ih/LO2fcmQ614Q/ev7ABuUojiikCbOtLwIDQczU7KhNu4cv5pw0fXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <f28d4604-b169-4583-b9ab-d53e6d08ce63@opensynergy.com>
Date: Mon, 25 Sep 2023 09:55:51 +0900
Subject: Re: virtio-sound linux driver conformance to spec
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org> <ZQmt0Z8lbPMuFzR+@fedora>
 <20230919102250-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230919102250-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: OSTP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::13) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|BE0P281MB0050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8c8c0f-c095-4192-4e63-08dbbd62352c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgjsumsjLePo4Zvef+bq1EQG4faX0erXGxITmmADTzK3Hx5e7aU9QR2vJPjwXvd7s2LIxjPRyC8n0IY9Bz7HABa+KMJUwtBFkbWTbJMeuX3C0cuTU4s82wss9iFfadarkWnx+6xza18+x5zVDNs86JI94/w01LNPahePImqS7V6rAsvp2MfDdVBactWhnuJxXOZQGn6pjJPz5Nx09moTXAZrW4z0SDq9uS7vUqZTQ7dRutIzkSj4j+Q9SZ3N20I0nzZEy6n1EO3PkqA5mZoOisqGq0Ftzrm4mZji6hPQEnHYMFygNaEAgivNoBAPmzCjgxMD1k/fwhzN7z7jl3TTOQpr+h9tHrfAuTR4tMJCrnM/5cm81HzCmqEHCOhpbNhIxugCpDO74D20Gb/UyrioRvDJ1m+7D1T2s6DvGQmoUo/Je6BKmYvXylmYuPXKGPuVeK9H2YCUqqsemwVR+lI3ZjM8K76WeEsasW25+EtqZkchrqY8JkxCtvkehaTQJDQmrYhIHfYT4ThmpKjthgmcfa7acUuKq2324J+DI8JPJta2TeGqSrWfazTlecYNjFd9n2ctgQmv3IHPEv/m1A2y7lxUprXnohnep/s/IrEw29DuZE5UqX8d2ZE6bzXyJqVENI64f2EVzDfRxrd1FHuPZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(39830400003)(346002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(26005)(8936002)(8676002)(4326008)(41300700001)(478600001)(5660300002)(66476007)(42186006)(66946007)(110136005)(66556008)(316002)(53546011)(2616005)(2906002)(44832011)(36756003)(38100700002)(31696002)(86362001)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZuQkRub1pnSm5icnQwVWVxSGxSUHYwMnZnYzZuWkIzcXpOZXppclh5SVZz?=
 =?utf-8?B?WXdCRHBycGgxSEk1QzRCUUNhRWRZcDgxT0M0dzdsSTZHK0U0QVdRMlQvbmdk?=
 =?utf-8?B?OU5lNnlsWlFmK29hVGpOOGgrb2Q2dDI3UFludmoxcEtYN0xwVkJoQXZHMVVS?=
 =?utf-8?B?YVhiNGUvbjlDZUVoUWt2elBVUFFDR05nWURwbXlYZWJySnNxK2ZCNGpmTDNx?=
 =?utf-8?B?VC9HdElwbHREdWM1aFhDaWloQTFyeDdEQnpEc0U5WTlhWlpHSkxUeWgzTnlG?=
 =?utf-8?B?UkpmT2pRUXRlYXZzaXc4OU9TM3VnbHpjTWNCT2k0OXFNRTJaRWg1cGJMWFgx?=
 =?utf-8?B?b1pvQ2Y0QjVwSGpxSjFpSTlDcTM0akd3TXZlUUYvVVhPYnJPdG1qMVBMakZX?=
 =?utf-8?B?MWZMd0FGbjd2cGdlcWE1NWhzQkxpOCtXSFFuTUN1QS9JQTM2WnRETy9JYUxT?=
 =?utf-8?B?WnRKcWFkTTM0aTVaY2tTa1B6N1pwQVlROGdXZmhJS3cycGwwVXRvdWcxYmpo?=
 =?utf-8?B?eDRIeldRYmpDZ1RZTmI5SitXL3hraWkxak4zN216UktTR3VQSlBKV1h6a3k1?=
 =?utf-8?B?bi8xU3hSbG9Ka1lNckhJa1YxeUcxWWswOHkrUmJrc3ZsTndScTAwbEwzNEZy?=
 =?utf-8?B?aG44aTNpeTRaNlVWbDF3aUFtOUNrRFZBYzY0S0tkbHJ2NGxaTXlVMVRPdDVI?=
 =?utf-8?B?MG11eUFURWRJdDk4Q2U3MS9QZTFLblVyU0hhUmN3bW4yNk5ZQUJjY2oxWmVp?=
 =?utf-8?B?Z3dGYmpmbE04TUg1UjVLUVgvdk5icWhEcWhqVExEclVlaWFVRi9Mem9ZZ2xM?=
 =?utf-8?B?eEZjRGNMZDdneExQTFdxcEl3cDh5SHZxS1dHMGpReHRHby9OOFNxQ1ZCWGRi?=
 =?utf-8?B?L2lVd2MrSHFhZC9GT25UQ0VzN2oybUI1ejZ2RnZQNjJEU3Z1aCtwSjZIaVhI?=
 =?utf-8?B?cUZadXVHZUFzTUZiMWdzbkFOZzBHYmhSd21zakhqVTc0Tjd6R0IzZlM2WUIw?=
 =?utf-8?B?RWx1SkFES2JHOU03a0YrWWhOYTBlUjZxTnVkcWtnWmlZYVYxY3VlUW1hQ1Ev?=
 =?utf-8?B?VExQMjJYbkVHQk9WaVYwOWVVNDN6Y1hMekFkMlorZ0MzQ1crQzk4dXRYSWVa?=
 =?utf-8?B?TXVvaVcvREk5NXNwRHQwTXJ6WGcyenlxY05FMnpXTHo1Sm1yMGZMMkMvL09Z?=
 =?utf-8?B?S3RpU0sycXpKMy9NRnNHalRpMklQVEJIZ2VTOGNyd2h4Q09BK0dlbTJMVDBa?=
 =?utf-8?B?N1hieEdyTzl6NjNzVkF3cXoreFJCNGczVTFXWU1UakpOUWpCdXJtMi9YVk9l?=
 =?utf-8?B?RFRGekR0YUdtQThwaUxEQ2hkUDdnb25KMGhMUXlReEljUG1FY2NQcmZjalNo?=
 =?utf-8?B?S3krMFNqNExBeEprZ3RpRDRwTURnV2JVMUJVRDdHWU5Xcm9OdmdobkJqWkRC?=
 =?utf-8?B?c25veWpZSGxWdXZjRnZrTTJSMmJUS2M4RWUwR2JrdlZma3NiZ0d4VHJ6VGxB?=
 =?utf-8?B?WVNQZEtnK0pqdnVKRFBZUGh2eEV5QlQ5S1lhdWpET29hRmRoZ3RPemM5Q2tN?=
 =?utf-8?B?VnkrYjlRYW1yVmo2OHNhRmFXbXZCa0hoL241WVUrak1GeFRtN1pWMGpjcDMr?=
 =?utf-8?B?eDlpNW1IUVhUcEQyK0JrK3RGMUtkSkpxUlA0UFJhdjFmY1Z5a1liM0hwRkl5?=
 =?utf-8?B?cnFCc3hlMW1PWGhENk4wdGJQc09neFplMDg1MnljZzRWMFR1VlFCRk5uVHVY?=
 =?utf-8?B?cjB2TUpYM1hYWk8vZnJXZzdyRWF1bVNOYWxNRGRqZGZpeHY0MGFZc1BVOUJQ?=
 =?utf-8?B?eEJnR0g5QmtFQ0tWenNWOVBVd2F4ZVFaMlE0Nys2VUtqVldYZGxMV2NCOHBP?=
 =?utf-8?B?a1lkSFkxc0lsblJNYU5wSy9odDN1WEkrc09PZUNDZFA2MThnMTl1UTZucXdw?=
 =?utf-8?B?SlhWLytwTERRYU9uWWZwNlA3Sy9BZXlGZlVvLytCcGtQd3ZVYjdKYmtLdEsr?=
 =?utf-8?B?WmwxNGxGQ3hET1NuajAxenFrODJPQTlRdGtwSTd3M1VsMDZBWU55NHNNS0Na?=
 =?utf-8?B?bzdVZXg1bTBwU0ZkY29QYnI0YVEvUUpCVmxUYmpyRFNPU2RwTW5pK0Z2K3JD?=
 =?utf-8?Q?1Y7Us6hpUFMFg9UtuQA72m8JI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8c8c0f-c095-4192-4e63-08dbbd62352c
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:56:10.0998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqkUQoN+1MT+85cK3+d+zfPylGKaL4uAAuK6IRwVSzew2dVBVLFrqdc1qgIZP4H7OzCBOQMsulMiq3xGZuZi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0050
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27896.003
X-TMASE-Result: 10--24.508000-4.000000
X-TMASE-MatchedRID: fE0JoqABJp1TzAVQ78TKJRhvdi92BBAuMKBMviil9LIrHeGVS/Qy54Jb
 qOf8l3HTPXE7GzZeNWoQjSTsX7NxDl9un4KO0k1IeJchdZcr1K17tzq0SRd7O6EvKeC1YDuQuud
 R5w9ehBNGkY/PHLh2BQ4Sol+Ip7tU0MrvUXTHeZlLviwaHYb1sc5hvaZoPJ3CMmXeT28VArw58p
 R4itKLvyRF+Q8qR9T8R1ssKMDNxzQST566OvwT1twy9mwTudtiOteHVGUMZ+CS/GH8zyFDN3wcv
 ncZ8K8Y6T3UnvkW+41xJG6QrBblRXgGdyaWvchNCI8Pr2jKCJvuB3lKociGMpxT0ucAo6R2NMgx
 5bGmq5IFduY6poIyikyJMLMqRzztx10k8QqyoAwRLjqoJJt/9ZlRCkgBbO6Xa1P8Ik1zBcXCWXL
 d4w2EwNvIAMT/07OiB73xunbyKrpnME/Jsn/m+g==
X-TMASE-XGENCLOUD: cecc0c96-6aa9-4da8-bcb8-8582258001b6-0-0-200-0
X-TM-Deliver-Signature: D1A0F828712B5ABE2B51C128AC9D5E38
X-TM-Addin-Auth: m7NAWOQrKtsCc30V6E+pxXdwYv1OEwEIWk02nhC53Iqiyx4gL4RICTyeXRu
 0do1A7KzM0o8Ij2Df1bQrbTa3/KGNxEFQA0MhyEyEuKp8E4+oKK3/zUFuKzBSJii9ScdEjsRcn+
 JSeEOpbaiWaq6pp9egKOcfrZ3ZjUk36epFU07aF/Pj+L4y3Y9IxzqIOOt7tMfGdvRYHOBpaQOhS
 ys1MYZprDT7MH9itfCV5BOYUcJIq6ZxT3SrfSfhw1h279pkKNGZaSVmAHbhqM/mLhBzwgzXQFGL
 0YDZrmayB8XuAYA=.El+RfzcGUgCohZx/KNKDRsmC5HM6CUoEMYxoeEK98f43295djd5ITuEXcd
 Q1O0DC95sFesFR/tFkiiaO6zdNRAPRIXnHCg/9gzdoTq2eq4lPMSf0CRSqnoPIXZDPjRpHZdda3
 g+oDlP5EG2s+7Pyb63Ixd1ufLGeKH6c4aIdGkCdmpdaKOtvdGv5It0eyiNESHqsLzFNaz4Qix5f
 rSWKdsBbXDx+ZmB9yW809Sf8mD0LVUGMEbhnNmSmCLiUeq89Em7XoLGxmiTlgsKafdDNtGmUVO3
 TK5uiVxegjPLUjrjB+eaJZ41rLZHbd1bwxc4V0XBeXUyHX7sZAONSQtzDfA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1695603373;
 bh=QPPSuCfsyNwIkr2kTH9TzxOz4mhfhlgAE9+Kta7Pp1s=; l=2091;
 h=Date:To:From;
 b=IYAXSTBBWvDgZVII5mFTpS11r8CwHnQ45zg50q6OvbBFfCCqL+afqBhVfI8rk1xGi
 F6akZ8Gp3zx4hUh0qqsn/is3GyBfzOClHYW3tHkP0YMrAMu45Ur2pWNHXyuvbKqlJX
 e5KMpTkdL1LH5Ro0pVypYvrvVmxXia0+Qj1Z1WJ1WlYWZFcCFbaN+iPKOgED3flf9z
 cbaolMmOAyTEiNRfxqQTqK2N+1PCHaK/cbx67cpa6eQz3md0KawQORumbB3sUqee9J
 IVWwwX5ZM4twXmAjtbNnR8sNperYPFvr56DJNThZwixckBPzLdGK8541SXdWwC44m/
 yCgnrv6a8DaxQ==
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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
From: Anton Yakovlev via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hello Michael,

On 20.09.2023 00:52, Michael S. Tsirkin wrote:
> On Tue, Sep 19, 2023 at 04:18:57PM +0200, Matias Ezequiel Vara Larsen wrote:
>> On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
>>>> Hello,
>>>>
>>>> This email is to report a behavior of the Linux virtio-sound driver that
>>>> looks like it is not conforming to the VirtIO specification. The kernel
>>>> driver is moving buffers from the used ring to the available ring
>>>> without knowing if the content has been updated from the user. If the
>>>> device picks up buffers from the available ring just after it is
>>>> notified, it happens that the content is old.
>>>
>>> Then, what happens, exactly? Do things still work?
>>
>> We are currently developing a vhost-user backend for virtio-sound and
>> what happens is that if the backend implementation decides to copy the
>> content of a buffer from a request that just arrived to the available
>> ring, it gets the old content thus reproducing some sections two times.
>> For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
>> `Front, front left...`. To fix this issue, our current implementation
>> delays reading from guest memory just until the audio engine requires.
>> However, the first implementation shall also work since it is conforming
>> to the specification.
>>
>> Matias
> 
> Sounds like it. How hard is it to change the behaviour though?
> Does it involve changing userspace?
> Maybe we need to fix the spec after all...

Fixing the problem Matias described only requires changes to the driver. But
we will need to restrict applications from mmap()'ing the buffer. Applications
will be able to read/write frames only through ioctl() requests.

I think we could expand the sound specification to add support for shared
memory. Then it should be possible to implement mmap() support on top of it.


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
