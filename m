Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE6CC6FA99
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 13:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E0C460F64;
	Fri, 10 Mar 2023 13:21:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E0C460F64
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cr4rs1+C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4q8qugdFfBRz; Fri, 10 Mar 2023 13:21:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EC0F60B8B;
	Fri, 10 Mar 2023 13:21:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC0F60B8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73A25C0035;
	Fri, 10 Mar 2023 13:21:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 707BCC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AB9B60F64
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AB9B60F64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hZYWwrQ5HlO2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:21:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBB0360B8B
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::601])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBB0360B8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUbvr2ah0aS7m8cstbj87cm8ivVL7jkOX6goxuKDOAewLMBjGR1KKVfGjCY7tz+9O6/gpIJwparDJYNtiZb67dfIpzc1uUkCQ4BzFX53NoZEI6OEObEdMFWsmePNkLfPaYlQ8NTXdtmuMZ3ZDVbaHVQodKNJ17Li2e6IHuNILrPrJf7RpR40wvp1jDGNr7dyEndu8f7aL4/SAazHkUBaAiLWZHMf/TBoQDxB9cM3XUM9ON3+2uHvYi+ChOv5yH4IXpFLo4StLjFxBqdwhJ4wE9OWJ14PI/DrlijAlMke9+Jg8vGeC2wcoslFSYMFJs+tKxuWC22vz5aw/j6OKAHjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqTvkNImgR/6KNDiUp+7G+xMu5AXqZjh3oF7sLQMCWw=;
 b=WEnq5FKBSDv59OxMVYCU5yvapb6fBHPgZUHyKmY6loi2BqKDE3VUXYD6cU62jPVMlbbcyyGBbgI5QxjPJX1A1cTlrmTVhbf5yDlv6eeyk83b5cIWxt2Tnq5V/lAnB9/LB/qtd7PaC74N4AN7pPTSTKPu6iyf/KOzCZQerzdErlwKU5mysXN4Dp5W507ftDieAfIa92HJ//mdxChlLxZkpOXeTT2KqHdbFa6p9QSsHmqgORFUHmByKbkcymup5AR7SzKJ+stxAYa0Z543G0XMgVWZpM3ETnoNdTsmD3qjzUKMMf+SxhwfskK7G1yqGLQbL+jSwpF9p2JWe877cyUU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqTvkNImgR/6KNDiUp+7G+xMu5AXqZjh3oF7sLQMCWw=;
 b=cr4rs1+CZeRjl+MZUI77vavYb2ZmLRmgSxoxvUJECu84HAWUWC8fG8a8ATQSa2bvf35K0SP4oXS/Da+Pa2BGG720rJ1D8twizUdUUfLZWrx0KZ0Xvd7kkBlrHYvyr+UwhIUdiBpPLmJREKgMz9bz9XrVRrQDNhNo+8B88mPC9ztRvkoIykTV57Ea50d74uBh23Ghxb5KkSGWxfEjEbYY4xRikk7Zs+4rd59TkjgPSHJk3D/onfj4c2uaG/XvQdcaYIY0q9qqWLpvoGA+qGh1YRZe6DSoEK0sULKTgMnPx8OW69fZ1Z9OT1Sn3R6g7MHPCKOwX/fLT+bclgVxUk3W1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 13:21:36 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 13:21:36 +0000
Message-ID: <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
Date: Fri, 10 Mar 2023 08:21:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310030624-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310030624-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN6PR01CA0030.prod.exchangelabs.com (2603:10b6:805:b6::43)
 To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8091bd-87a1-48ec-b6fa-08db216a5fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJY8NklPe+oR2qghOfV9/dgMTJQgaelRUXH69fbpdRYteEipfGk2oaxMjkHHR/VztTkh03U4IXq80WNLjtBJvtMXEmN/XIu7DnyhUllS4cpbm5JteYHPPY1fsxRKMJ3e944KyiPpiymrD6cH1Z9qwp7YaYeRJZrJHigT1WLgz+7ZrzJ1ZS0RmoE+4n2Qm3hUXJvmCs9pupXtPugvnsM6ZHpFUWAR7aDGyDY8PxSp/OQF4cJxb+1ZgsWqhnsRxHYDhT9He/pXOK03IOMHIEYR9llgRxKh83wSvm4JZZoyw/i7qWybGJC9ev09oN2hJQgia6S/QAEv3FlQtObZK8S5SLzwNAH53zJYyUDSNT6YoXDtJsWRrnUPChnuxzT8j0YY2vAlDRZNSGVFlUm4o1u35AW6X9jk3tYHUB6Z9sSHTbRB8llxYJFK1/CyHbv/m+P63cMOMCz32XAB8i+C/cnx9XqZuGFijyu1rmTfgQTRHs7bbg+VT1ZP3f1OLZJUjefuUpewk4aYIYW5HClyzgLeSQc9kz9+IqW8F1SO76PmBZwSqM1I0NnlqQ3dHCpFt7B7+JC21WgYNhUH0CRgL+5gLMwxLRnwBUVZXKkmCpSefYL8+q6O6cA3AcRjJl1IR9wDcv31Z5NGtEnuHU+yi/np6CaAZAsPhG19H0P4Hml7TKmunVGNL0DHiWIvJIrDHLenRObtUSBBhz/xAuQYgenP9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(83380400001)(31686004)(2616005)(2906002)(5660300002)(45080400002)(66556008)(4326008)(6916009)(66476007)(26005)(186003)(66946007)(8676002)(41300700001)(6666004)(38100700002)(36756003)(8936002)(86362001)(478600001)(6486002)(6506007)(6512007)(966005)(31696002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akljQitIalFCVS8vb25MN1JtQ2pNVzRESFlIWEpuWmNBNjl3Z2g5dUh4emlo?=
 =?utf-8?B?SldYOWk1OU5TdDBpemVTNk15WHdPLytMOVJEODVEVER6ejE2cHgySzdzdGE3?=
 =?utf-8?B?TGd4dVV1SzlkaEdYY25icHl2bkFqanNHcUI3K1U1dDZHWC9sYmRWL1pMaXd3?=
 =?utf-8?B?Y2FqU2U4bHFCNkFjSU8waSsxa1YvdzE2OGV6RmRjbmNyNWI2bnJmalVKMDlU?=
 =?utf-8?B?ZUl5bG9SZmw0ZFc2S1JTV2E2R21vTUc1VWFKNkI3dXBXcm0zM3FhaVh1Rkll?=
 =?utf-8?B?RUc2YU1SY056Nnk2MzJEcUw5cWNrN281RStmcVl2RTNJdEJoZ0RCSi9zek50?=
 =?utf-8?B?UGRac1ZPMGZEVzR2cVNZRE82M0ZUOTJ4N1hnN2FObXZjbGVvNU42WWVROSt2?=
 =?utf-8?B?UXFUVTFQeUplc1creHlFVVpFaG8xdFJpWUI4cG5YQ0l4dE9aa2VVVlVrbS84?=
 =?utf-8?B?ZjkyeEJPV1FCc3BaMGhpa2FZTjhjVlZrVGxuaitlc3RTc3lNbFBMZnNYOCtq?=
 =?utf-8?B?M0QwdFEwakhwQUM3SGJNTW9BQUJNR3pZVWY2d2Voem9UR2p6a0tiUVdmVEtu?=
 =?utf-8?B?TWs2QWJYWlliWUJaSStBZ0VmYzlycnNCS1BlMmNSbGFKaHg4NEJSL2R1Q2Yw?=
 =?utf-8?B?NTdNV1NxTXVPNHN4MG1sMWZhZXI1RWZFdU8wNXU2TGxveUl2a1FKMS9XTThM?=
 =?utf-8?B?WWVIYmFDaFBCMm1JNG5aRmpKcXJKR1hWUm1OUU91WUpFQ2tCR2FpdWRQMzZM?=
 =?utf-8?B?bE40eW9hYmF2d2J5TzgyVXp4ODNra1Y0aFVGaVkrcW95MVk4MDhXNHFMeHdL?=
 =?utf-8?B?SHRES0VVa0ZuTjlNZ3ZMNFhJZ1RpRU9RVzhJNjdJVVYwMytMclBkWTFvbjBL?=
 =?utf-8?B?eFRtZmVmNlpRNmpJU0xHMWhxVnVRd0xMeUZVZVJuM0g4c3ZWQzkrekJOa2NX?=
 =?utf-8?B?aXhpS3hCRzVwdFlZallkcGVUa1J5WEpoS0x6Wm0vSjNHeE5UNDdBY2RJN0px?=
 =?utf-8?B?UGhBOVM4MHlNcmM0SHFJaGNtRHRZc3ZYaFJESHNUMmdsZVBJYkVZVE8wUzZU?=
 =?utf-8?B?aURzS3h3bzBCTTZhNmRyQTVFclZaTHRSVkVxNXJoT1M3T0dPdEVEcG9zZUVn?=
 =?utf-8?B?QThnOU5DVW5FenJOdTA1ZFVFWStxM1drak10VjNGV1A0bHFiZHNxSHVDeFB2?=
 =?utf-8?B?TjI1WjdlWXRRRG5ITjdhVFJWb1NiM2lYYWtvYWFYV0xHczhQcnBCbkFRSFpM?=
 =?utf-8?B?ZU42SFhYVjg2bnB2c0hlSTFLbnMvb0NNTmhNcFVKOVJGSGs5QzJlWDcxbi9o?=
 =?utf-8?B?L2lKRDlRdGJwWElDWU1vSHZobDBuUW9hSU9qR2VmWEpiMmYvUElnT3FtNlBS?=
 =?utf-8?B?YzJNZ2pEUEI1cXBGZ0N4K3FocFkvUWJzSjF0YVVwUnNtbTFSQjluWGhURm5x?=
 =?utf-8?B?dFc2dGQvWDIyWjYySjZNRXcrRHpoUm52TlltWjk1OXlHd0c1QlJEZC9RTlRs?=
 =?utf-8?B?NFZYY285TDlQWnNiWVA2QVVmR0pwSE0zNjNyYXdkRC9rM3BzM2FmdEpsT1FO?=
 =?utf-8?B?WTNXcnc5c00yT01YMnlrcjZiVnJZaEhON2xPbC9QdlRtQ0E5TTdFVnJYdnFs?=
 =?utf-8?B?c21QK1lXa0plSjhMV2hzSXdzUHQ0WDM5TFh5eWVzSVlBYytwWGo5aTVyUTZ1?=
 =?utf-8?B?QUd5Z3N0c1dqb3VZU2Fla2dzNzJUaEJmWDZPeExQbmJZQ1FEN0plWXp0QXFM?=
 =?utf-8?B?bnIxN3JIVHVtaXQxb3hDR2ZjUVRNZDBRbzVKS0RnR0hZd1VLd3F2SXRuYWti?=
 =?utf-8?B?eTZrT1BLRmU5YVE4WW41QnlGVG1XMUlMcUUwTUJUdDJvem1TODlocU91N1N2?=
 =?utf-8?B?RjBld2xNWStVemlBRk5MTVRjVnNaUUphQU4vQVdiNk9KUXlYT2k5MlFzcExR?=
 =?utf-8?B?Rm5waEZrQ3FxOEwraDZpUjIrTERwbjFyUHc2MU1vZ0FBZjlZai91YlU2aW5v?=
 =?utf-8?B?RndFYkJFUXFKcERIdVZUUmdWVHZyS0Njbzdvd0IyUEJjVmZtTVpsakFncW5a?=
 =?utf-8?B?T0JuK0p3UDVPOUFhcTBlVWpxWlc5Y2syRnlkUFRtU0dBQTJRVGpjTHNqNVl2?=
 =?utf-8?Q?xX+O70TSBRy4rR1WfxLVocv+9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8091bd-87a1-48ec-b6fa-08db216a5fd2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 13:21:36.2669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EguKfAH/4UFQDWQMyxKgMFAWh8gfNT85tVqKEpFq/QiBxNqskgOrmbH0vgNtPhCsdRy5NmiiDaXEoXYXZrg+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
Cc: virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 2023-03-10 a.m.3:06, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
>> This patch series performs a clean up of the code in virtio_ring and
>> virtio_pci, modifying it to conform with the Linux kernel coding style
>> guidance [1]. The modifications ensure the code easy to read and
>> understand. This small series does few short cleanups in the code.
>>
>> Patch-1 Allow non power of 2 sizes for virtqueues
>> Patch-2 Avoid using inline for small functions.
>> Patch-3 Use const to annotate read-only pointer params.
>>
>> [1]
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv6.2-rc3%2Fprocess%2Fcoding-style.html%23the-inline-disease&data=05%7C01%7Cfeliu%40nvidia.com%7C08831607a6fb4f58881408db213f8638%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638140328946332918%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FnD4GINUds2HLLo47aY5Ps%2B9nKWPW2XRI35z1Hp0yx4%3D&reserved=0
>>
>> All of the patches have been verified based on the kernel code
>> commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> verified how?
> 
Hi Michael
1. Applied the patches on lastest kernel source(44889ba56cbb), compile 
and install the kernel, and use iperf to test traffic
2. To validate this change, we tested various virtqueue sizes for packed
rings, including 128, 256, 512, 100, 200, 500, and 1000, with
CONFIG_PAGE_POISONING enabled, and test by iperf& ping -f and all tests 
passed successfully.


>> Feng Liu (3):
>>    virtio_pci_modern: Allow non power of 2 sizes for virtqueues
>>    virtio_ring: Avoid using inline for small functions
>>    virtio_ring: Use const to annotate read-only pointer params
>>
>>   drivers/virtio/virtio_pci_modern.c |  5 ----
>>   drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
>>   include/linux/virtio.h             | 14 ++++-----
>>   3 files changed, 31 insertions(+), 36 deletions(-)
>>
>> --
>> 2.34.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
