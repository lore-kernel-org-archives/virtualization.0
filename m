Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09425C6FD1F
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 22:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E80D81A64;
	Sat, 11 Mar 2023 22:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E80D81A64
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I/f+l17Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrSyQIVaTiSj; Sat, 11 Mar 2023 22:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA88B81A39;
	Sat, 11 Mar 2023 22:19:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA88B81A39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3FDC0035;
	Sat, 11 Mar 2023 22:19:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF3CC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BE8281A64
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BE8281A64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVGXo7klNWRj
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:19:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AFE981A39
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AFE981A39
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW2xb/NxsZrymDfL4rbLP6URx9zBcS4O3lk5tnsoVsEiGEj/G3jE03l+a5OJ/KHlDCPRBblbDPtMEtor/0WkklRinCm9f6MrM0u9Atr7sme0WF3pRPW2Nhzf9BToWjTfF3A4CjD3DbRUwu43w5ebXGInhaBAKa/SAhYmZkCcuKOrZIvyVYmO5Q1Urrh3g1n/ZxWRnqjsn4UBD34zYEvX5z+OaFLRS+p6662nohz5Qm09LCyYdug9REnrd2hjNVi4yJUmJWl9vQ+XTL+KuzR0pALTLlDpIQSHAPbXe3GL/8HUF9toLXiHk7zWd+8+fF2Vizna8JqJxJIqWD1tdOvEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+cg7FDw1Ry3u3tjD6EVGx7WhlTfNaHNvWcqJMXllA0=;
 b=QfDceppy8t25Jlt6fOJ7FAGbTM92S46XE4Ab2oWF4HI7e+olRIrQkSCrDStE9yDUluCaT7NYuAyXsdfyhqX6ZrqmLOBLxEjiF5DB/3JMmNg/6WjSgupNnsXdNutB5IBTRPJXjpjNwdVOvmhuOJ5ukwYa9Tazr9RQphyoocgfTE34nnkaxTFTYUQRJApJnlBWC3pNvicIh7kdNW3cpko4VUNrjSe5pHG5HL+TfWLEhk16K7KUz8dJrikSlgIXdQRLdycbGcWC7eON0pwA0csK1JTAv7O/Ql5LzKxNidTrsVHC3fyfswPn+jKv0T1sSBE2riz7xSEhzd18ZAlpxWMQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+cg7FDw1Ry3u3tjD6EVGx7WhlTfNaHNvWcqJMXllA0=;
 b=I/f+l17Q232h7lmuYNCXHeW4VgzDUgu6JoHn475CN7Ps10fpZmAtUISWkDsJ1U6QuB1iTSxoaD0tNy+cdEuGsrIkhr8oHfIO06I4ibX6Z1rC1cUZms9t08rRCCtp9+axPnI3ABEqikGkYvBY6AK1UBpUxzhmrO982VCSc8KRruIG7VX+X8n+NE44x/OVsVXs0uEYRjtereC+D3d7l4Bb5ynYIJ6SV7uKSyLpgJtzm2cB7iYswL+PFgrt9iVmBq9Hd/6oSIszVd194+qXV8WzUoSWUQHNXFIUMlJ2YNblAeaAe16geFxv2yvC3DJRhh+SqKRf2b+jtiJTkLAxc2kKHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Sat, 11 Mar
 2023 22:19:47 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%5]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 22:19:47 +0000
Message-ID: <4da4a05e-4b0f-2c1e-8b58-ade2c620c868@nvidia.com>
Date: Sat, 11 Mar 2023 17:19:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310030624-mutt-send-email-mst@kernel.org>
 <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
 <20230311140528-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230311140528-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 663c870b-70eb-4a21-9085-08db227eb8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78jvjYuA0kAyTan3BzU3adyx7psJC8fZWZG1lm+Y2Cn3LpGRCGg8c3bSKop71H+2tbHVkX1hsznYr/zClCACR7fxy7ZoFrLpYYGBDqkvuT6YYkdA85ozfmeKAnn3xI4t8tkoco7z/b3uJ/vYR7O1r6+3gsezbcR50JKDT/cqiDFL/i3kXqZ+D+yK8F6pOaKXg6Rq43pEmN+bO2F+h11ISFkxytjorkiADGjsy3UTTF3WBjZUmdu7Ipj66afKM0krFiUB8RIt+oKR6wy7iE0jNgajcZsLVu90zd3gS7lESHqvovHYA6UO5yAF9tsCsEIq6kArmSUEnyWYl3X7tSQIUAvY3wEl3PQC4fgdo0IuOhYiURv/NcVugkQlqzz8FkQBEsF70GZwkCEVha7OovYo8TDoQ448LS4djnU1dK841Vfral1l+jT2kyx3v+uaj7NSWjKQo7kB4PkVrtltF85YN0UvmyTCCKyTVCo1as1M8nbonz77za5bYUhkywuL57dbb/RzZCntLUtX0oVessrFMxuAnzzq1JWcP6o9Esea3ilw/OeAbag+dHT47wigirI1QCXYbdxoKtozd+sg/NW56uC0EkB5T2pH2VV6BlqRbp/EtaDD/Cl6AL229RuIiEbAztkwXaiz6ymAlZewV+LcgttRJ0o+ZnmtSKhfwakqpq+/JqiItjx5r/wMIDbIU2sOV28t+16koiJg9F4VvS+UIBXHhVbSXjIi/fX8NsFJX1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199018)(31686004)(5660300002)(8936002)(2906002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(45080400002)(478600001)(66946007)(66556008)(66476007)(8676002)(966005)(6666004)(6486002)(4326008)(6916009)(2616005)(316002)(186003)(83380400001)(6512007)(6506007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW9Ed3lWZ202NHJnQ1BVR0JzRmhrOGdYTzBWQVNsblFQamw0VzlXMFl1bmh0?=
 =?utf-8?B?MkR6K1M2WTk2WWhQUWZWaUh1SFlBNkNJcytnRXAvMEJ1RzFVVFdaY1gybnhV?=
 =?utf-8?B?TFZseG9pRkV6OU4yRzBWTjAxWUMyeHhkMDU3VDVmUk1oUGc2SGQxVXJmYlZP?=
 =?utf-8?B?czhaZUNjNTRna3dGbVNxdHE3STEzSmljYVlIaGkyd3RJT1JTVERVcUFIS21o?=
 =?utf-8?B?Q1hZNSsyYjBwL0RvZVpjbnFqUkszVEwvajZLUDhsaGtOTmJSQlRHZk50eEo2?=
 =?utf-8?B?akZ1azJBSWVZelNMK1l2c2pMczFJWEZDRHBpRmcyVEk1bnZ0eWZjK3lzcGRQ?=
 =?utf-8?B?bXBvbDAva2tmODNQWkdJeExEMzE3RngxZ3h2QWJYZDc5VzFkRjBpT1Y2VnYw?=
 =?utf-8?B?MVVTRlV1NzBQSEIzMEdSOUdlMGpzdktieTV3L2Y3M21zN3NIYS9FZ2xwNEla?=
 =?utf-8?B?ZTZIeFZSMVg1K1kxT0NSZm5hSXE0b3AzWHRXckRNdWMveGJmT1pWeXhNM1Zm?=
 =?utf-8?B?WERCMTdTZnJzRC8yZ1IveDluSlg5amsvaVo3TW44ZFJGSUNTMVZlT05ldTNC?=
 =?utf-8?B?WVI5RDNkS2o4UE4wMlV3dksxRDdzQUZQbmRmRitaZzBiVmQzc2JXMG5rdzA3?=
 =?utf-8?B?QTI5Ri9jMDFwYy92SE1mYUp2UVA0aXoyTXhneDd4NmViSTR5VDFQc1UrZE9U?=
 =?utf-8?B?dHdsd3VsN0dKTVVHRDRPalQ3Vm1Rbmxad1JVSk1jRlFSVDVNWHYvdUZIUnFM?=
 =?utf-8?B?UHlQYXJKVlJ1VjhhZFlWSmpGbUZGVWhBeVdHb1dzTzBJaTcxWFNyd2c4MzJD?=
 =?utf-8?B?K00zejFXRmt1cXlTVlZsMFR6bVR2Q3cvT1Qzbyszczl2VUtQSXNpYkxCMTRy?=
 =?utf-8?B?ZCtBTWcrUHRyL2dUL1JQY0QzTitueVViTEtwSk80OHZPSFZObDVJMUNWSzgy?=
 =?utf-8?B?U2hBSThSY3pkQTJwNCs2bTRaem5meFpvRHZXbUxoVzludUpWcHpTVjlMeHB5?=
 =?utf-8?B?TGJoNFNVZm84aXhaU1V0MTNVMUNFemNLZFF5cEJYeU9VTVA2SGxFWEFXSXpz?=
 =?utf-8?B?MWNtdlZSUG1wbFpoSzBvakxXTW4wSlBjZnNIQ2xZNWUrQkZocTlKQzNGS29M?=
 =?utf-8?B?b1hzakxpMnc5Y1FocWRseFRqSkg4VVV2c3NqN3BMSWFPSTRRSThlaFVUMEUz?=
 =?utf-8?B?UW9zVjRQRldadjYxNzVyd1JmMXR0QjlOSk9Pd2lBbTRJaXNvUGxTNTJlZEo5?=
 =?utf-8?B?a2hrNmxuNVBTSzRQbXc5VHpXY2tPWEJZWGRyU2ZEcGhCa2FDL29jR1FRbitL?=
 =?utf-8?B?OG40VUJoa2orbjc2Q2NxQ3lUWjMyQlhsV0VsWmlpYWNJb0YzeVZkOXV5MmZK?=
 =?utf-8?B?ZGdtOWFNbjAyWG4zTVdPbER4YzlIRFpyNmtGY1FQNU1EQ25qSXNJMEx6VjNR?=
 =?utf-8?B?dzQ0ZGFEM1VUbS9VNEU0bDR0dWZxNnhFQ1g1cDNLUTBSeENnNzBDNmRMUUdX?=
 =?utf-8?B?cXU1dWxIVFdDV3Y2K2x3cUt5bU9Qek5tRFhZVExTTXJWN1dON2hhbXRMZjZj?=
 =?utf-8?B?b0pUV2grRTFTZW16eFoxWDVnRXJwSXg0T1haSzhHdjg2OVNJRFd4bHJnK3lx?=
 =?utf-8?B?Z3VwWlpVMHlKSU41bEpkYWIxY0ZKMEgxb0xDbjYxQ3Z5N0h5eC9qZEJKSHRI?=
 =?utf-8?B?Ui8zcVJka29VbXR0N0xnYnVmR2FHMjV3M0dTVDZRc3ZMUEkrcnZpSzc5VzQr?=
 =?utf-8?B?Q0xJZ3ArTzhKRTBhRW5zczdFRmV2KytHaGhRRTBiSTJZQmxLL1hiN0lKTUtj?=
 =?utf-8?B?bkQ4ZUxVUFhibk5TdS9uaHBsaWhIR01Pb1cyV0FwZjQxY2hPclZ1R21NWFFE?=
 =?utf-8?B?dS9ubDFGL2tocmhZNG1nYzU1NDZqelRWZXhzTTZTNGZpNmtKNG1yTmdmai9Y?=
 =?utf-8?B?bStoLytrbG9QS0pzR21UN3g3dkdCcmUvelZiTmY0TEF0UmRGMHFneXZ1QWJx?=
 =?utf-8?B?M0Yyb2k2am5GSVB6YktKTnFIOURNeVVNVUs3OGpBTHJBVjZnT3NOMndSVEV4?=
 =?utf-8?B?ZSs3SHFwYXVwOXZLd25yeFg1T21yOTdJNFZ4Y2xUVHRZdU55UWQxa0pKM01y?=
 =?utf-8?Q?rHsm32/JVzAi4OKsWPGZAIsVZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c870b-70eb-4a21-9085-08db227eb8eb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 22:19:46.8288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3rC+8sDtIzsihnJNR2U8wD44amn3x4wbefvWzvB6OtY0slhAQxU2/FsWIPG9AU30Er9tdVqxq8nz9jyWwBbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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



On 2023-03-11 p.m.2:06, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Mar 10, 2023 at 08:21:31AM -0500, Feng Liu wrote:
>>
>>
>> On 2023-03-10 a.m.3:06, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
>>>> This patch series performs a clean up of the code in virtio_ring and
>>>> virtio_pci, modifying it to conform with the Linux kernel coding style
>>>> guidance [1]. The modifications ensure the code easy to read and
>>>> understand. This small series does few short cleanups in the code.
>>>>
>>>> Patch-1 Allow non power of 2 sizes for virtqueues
>>>> Patch-2 Avoid using inline for small functions.
>>>> Patch-3 Use const to annotate read-only pointer params.
>>>>
>>>> [1]
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv6.2-rc3%2Fprocess%2Fcoding-style.html%23the-inline-disease&data=05%7C01%7Cfeliu%40nvidia.com%7C6cd34740c4674c1892f608db2263b300%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638141583834629671%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=IA0QCCKjHnYiEk2vPlZ5WjlXs1CMXDphyyqTYnbqQqo%3D&reserved=0
>>>>
>>>> All of the patches have been verified based on the kernel code
>>>> commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>>>
>>> verified how?
>>>
>> Hi Michael
>> 1. Applied the patches on lastest kernel source(44889ba56cbb), compile and
>> install the kernel, and use iperf to test traffic
>> 2. To validate this change, we tested various virtqueue sizes for packed
>> rings, including 128, 256, 512, 100, 200, 500, and 1000, with
>> CONFIG_PAGE_POISONING enabled, and test by iperf& ping -f and all tests
>> passed successfully.
> 
> Given split ring does not support non power of 2 how exactly
> did you configure non power of 2?
> 

Hi, Michael
We can implement the test by modifying qemu; 1. force the 
VIRTIO_F_RING_PACKED feature bit to be set, 2. set 
VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE and VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE to 
the value of non power_of_2, 3. remove the check of is_power_of 
virtqueue, then qemu can create the required virtual device (non power_2 
size , packed virtqueue device) ;In this way, any length and packed ring 
test can be performed;
remove the modified code, I can test split vq, and can see that the size 
of power_of_2 can load the driver normally, and the size of non 
power_of_2 will give an warning and fail to load the driver

>>
>>>> Feng Liu (3):
>>>>     virtio_pci_modern: Allow non power of 2 sizes for virtqueues
>>>>     virtio_ring: Avoid using inline for small functions
>>>>     virtio_ring: Use const to annotate read-only pointer params
>>>>
>>>>    drivers/virtio/virtio_pci_modern.c |  5 ----
>>>>    drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
>>>>    include/linux/virtio.h             | 14 ++++-----
>>>>    3 files changed, 31 insertions(+), 36 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
