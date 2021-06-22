Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928AAC49EA2
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 16:34:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BF261378
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BF261378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B11982861;
	Tue, 22 Jun 2021 16:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlDMEJ5m5NTm; Tue, 22 Jun 2021 16:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9294F826B7;
	Tue, 22 Jun 2021 16:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 670CFC001A;
	Tue, 22 Jun 2021 16:34:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF23C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0941C82803
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2tSQAMfDmAH9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:34:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA6F5827DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZmX5a483zA/vObHmqyoneLZfPCIj98MPa+jxt4bHxJSJ27LyVQdWy22Uye1avbqDAa+kxUhfjQcfXz0QMyxM0cMEhMEcp0fza1vqRMhwd40lvgywagB13W11VRPo6z8n3aqOH92t4Uih20NGyXJSF/1cgfDAaBzdfZPogNN/jDX6WM4kampZKfZshjHGq1nz4fDQUoguK80x/K00MKThWZtFMkAztszyAH7sNpXQK6toX7cuAyUnq3oa43dtndWIOFK1l+y4FI6BFs5/dD4z+Bd+C4JGk+lPuV8vj6z7DJ84VQt+NeIAa38CbsQv11mZ8hLMVlL7vi13vutSB1DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nClrXP5j4XxGdGGEuOxqe2egyO/ZW8EsBc1J2xh17VI=;
 b=DMMrhztnZuQ6xtXo7eqL+ImOQGw8ncaYChP/G1edhz5KxQ1lQO2/C3aZuoyKOw9CPR5X23F02VWJsDE6ej7/wLedUewNMrxLPIQE3HRr9JybXjhskSQH16CCbnxBUd9DJKZCXVVO6GHWtD0m6mVNWy27KkgWn4PjB1vphj3SVCClzOkfNBviEaO9CV6cHTGCFiHT5zJo88CHRj/uBP2XVTVbDrjIgh2Msu919ALHTh5dIBlmcGvlvRP0IqeV8hyUxeTS9D+S/F/32vpxVLDaoaf/3o7u8xmkOzzZ9wfA0NXPrLDeKVSCsVxsHzO/h677FriNZz4CCDW1be0HU3op+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nClrXP5j4XxGdGGEuOxqe2egyO/ZW8EsBc1J2xh17VI=;
 b=PStBlvWqcsaLHZmpSj0R1AaGO/gnf4gSiHY+clE4fkL9tGDpfYbJBWYo00rg5Wo7q4qo3MXx+Wiry8hNvHIMhKuOYTtep7ImC0cLBMQriwFQ6Bb+cWb/ljOqaCTaQH55MZJ7Y1uZAyZalKN5EsVkvinH50ivUl7jbRYqoYsIoFs=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB3302.namprd12.prod.outlook.com (2603:10b6:a03:12f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 16:34:19 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 16:34:19 +0000
Subject: Re: [PATCH 2/3] x86/sev: Add defines for GHCB version 2 MSR protocol
 requests
To: Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org
References: <20210622144825.27588-1-joro@8bytes.org>
 <20210622144825.27588-3-joro@8bytes.org>
 <a0d38ffa-e5dc-7e50-fc18-fc10ff19309f@amd.com>
Message-ID: <e033453d-430e-17ab-ee2b-ee3b3e67c7b8@amd.com>
Date: Tue, 22 Jun 2021 11:34:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a0d38ffa-e5dc-7e50-fc18-fc10ff19309f@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.11.236] (165.204.77.11) by
 SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 16:34:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 225d4b44-f72b-4ffc-9310-08d9359b955c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3302DF0CC267857D22A0D85DE5099@BYAPR12MB3302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oI00AxXqFJcd8F4HDpg16000rv0MvILnk0VLnVZedqPuIb2zYK16N7xmD1bRJ85devyz0skHhfsu2GD4GBfoyfIkPZ/LjEqj3cNAW5tJB28cg0nroOwg9nhHUTWtml9rM1vZE7Ym9fXKrQ3B4VdfThhS5PEzJ7AB6Yc50fcdYk8LIjBg/jBS8WuhFqq8uJKNEwLxdlJf6y//hRLoJj0w4+bGJXouxfVtRnuob4EbN340dbfwOSRw6AcF62IFTtzN6RinEl1ZT0OAAI+wUeZe2iaQfivjK+2PIhoZ/wTicq+x02DzDUDF+uFC9G3gDo/WJGbP7+SVZUuqQAJ1EeO6o4JWBENiJjLKRiwkpyxFdkyZramndFEytwtJZSTUyzM4lXabdhfjljsp97H3vrxaEVNwfO+Spk4Z6esHY9pNhycUk3aakLEVVntD6osiVvNLv7yqWEjBdPHce1Ge40pnbtq87ylzd5kc+Q+R8nd8VWeVA7o9Ild6nRqcQ1sVmJDG51u+MUiee/TnOobvEj/wOxoiH7wEDq16utAdffmqJ8JZS3En4lawo1mP/n+jA46/3Qpud7bRND21auEg4idzER85eDgakg89/VqtBZtJEzMLto6zl2hKs7IFVyb4E49X6ttLyHHYJ0ZzWJPa/TybKpSESxhZt3CgziG+IjMnKempEzoTEgB6rJ1cMYzzw/4D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2711.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(16576012)(2906002)(316002)(44832011)(5660300002)(8936002)(6486002)(31696002)(478600001)(86362001)(31686004)(54906003)(110136005)(38100700002)(38350700002)(52116002)(83380400001)(36756003)(26005)(53546011)(4326008)(7416002)(186003)(8676002)(956004)(2616005)(66946007)(66476007)(16526019)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FnLzdoQXZiMVNzeU1XUGlGalF5dnNKQ3hKcjg4Q3Nxa1dOQ2FFOTNCcFpE?=
 =?utf-8?B?VStRTERQYnhWZWZjbHJjcFZCcnRYVHhiWEZkcG5hQXVBRXV6TzNwR0Z6SXBD?=
 =?utf-8?B?T0luRVV2TGJvQjZ5eXYwTVV3eVlXa3BjL0VvaHllNS9UYmZxZHYxeEE1a055?=
 =?utf-8?B?VlZXdlBFQ3ZyS2QxMnRETWNUVGxQekNhalVIdlpkQUNiSFVieVoxeEZoZEYr?=
 =?utf-8?B?RzRRb3lkcG84WnZVVU02czdhNmd6KzlVbGxvV24zN1lQdFNjaE9Ob0VKWU9I?=
 =?utf-8?B?N0VNT2hoMndndklyN2VPN0RvamVxQkdOVXpTbGYxUm0yenhsV0pScGNYWkd5?=
 =?utf-8?B?Y2NqYTQ1WmZrOWl3eGJ0bG9ieERUdHZOeWZPeUdCNWZWVDFSeTJjSURmaE9w?=
 =?utf-8?B?K1VyM2xJZ0R6eDJwWUdjT0FsR3N6b1BRQzdOLzYrWVY1OEJFMGF4RGs0MmN0?=
 =?utf-8?B?aXVMVmVVQ2FENUNTM0hKeCtLTGpYcm9oVjJ6N2hMRlhEdFZOKzVRbTJtZ1ht?=
 =?utf-8?B?bTFKVnN5MkV6T0pLNGpHUWFpeUd6dkE3YnFzcHN3T2s2anhwREQ1OG8zSGJ6?=
 =?utf-8?B?UzJCbFZ4aENGS0kxWkVRdXFZTDBZVEVVWFdVenVIYWJ3YmxTa1hsTVIwd2JD?=
 =?utf-8?B?azBFMnJadUxqa1ZWcmJjbm16MVdpSU8waFZEdXliYndUKzlYWHM1RTNld1lt?=
 =?utf-8?B?ekRhZFdyYVhHSE9BVmtNREcvM1FQaFEvNG1UalRoS2MyM2lNQzEvV1ZYVFhK?=
 =?utf-8?B?YVZ5VDlOa2Myd2hmeGxOSUNiMVpsd0xpWnltNU9LZnA5bmtFNGNJL3MzWGN5?=
 =?utf-8?B?dHhNSThLeEdzNnU0S0JnYS92NTJVcUhoZ00vN1JGS1dYajJzUWVPdjQwRWk3?=
 =?utf-8?B?WUxiRU9UOU4wSTlDSnpRcm85eEFLbDB5b0Vld2RzQURXRm1TcVNEUmdaQ2Jn?=
 =?utf-8?B?RFhodGZGN2hCSlQvaURvZzUya2dOb3FqYnJXQkllSlN1b21aWkN5Vm9uUGh4?=
 =?utf-8?B?cVZtT1VuSFpLczFHNG1mVFhJam1LWk1yYVVPME1Eb1FZQnFKdWtDbXg5YU5m?=
 =?utf-8?B?N3hhM0l1QmJjR1JNM2hSVWp5YzU0MXhVSVp3Yy9LdXpteFNvMG0xMk01NjZw?=
 =?utf-8?B?MTZYakpqenpER0srT2lIOVVNOVg5S0I0WnBRdFNPNFFwdldhU0NiT1YzNlNw?=
 =?utf-8?B?VGZIaVhidVA5eGYyekNoa2NxNGZwcEVJUE81Zkw3RVRPSDllSFd3K282cHc3?=
 =?utf-8?B?c2R1bjdFU05SSktjZitmSUZmc2YzaHAzR3M3N3g4MGE5ZXNFeUVvczVnbCsv?=
 =?utf-8?B?TC9QY3dIa2VQTWwrSUFPdHo3OTlhT1F3enhKdXRNYTA2Q25qRFFOTnBrZ2hV?=
 =?utf-8?B?ZFo5Q1IxUG1CWXZHaHh3RzBlN3RtWEJGS1kvMERQbXBEbG80WmxSeC9PcTdI?=
 =?utf-8?B?VEp0SkJrSzhWRGZway9wWGZyOGphQUlCeFVvbTg4VW03eTdFV25VaG9UWDZY?=
 =?utf-8?B?OUkwK2wyMEhwWmtRYk5RWnJZT0czT29jczBjRzRuZGFpdnYzaG9RL0dQT3lr?=
 =?utf-8?B?dlNENlA2Uy9HVHB4bkZGaVhFRTdqb3JWTThyRVkyYkdrNWpQcVZuU21DVGZr?=
 =?utf-8?B?NWg1RzVienF1dmRJMHhvT3BkYkdMZCtRZ1doa1RSSXBtdWtqTVpwdi9LVVc5?=
 =?utf-8?B?L3dmczFOM2pVQlpYZkdCWHdXVXB2aVBOcFpZVmZOYVBzN1VnTjNVYzVaaHRO?=
 =?utf-8?Q?0oGB9uugz46HW6IHqkMfXG3w5MNvxNq4XQQv0EQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225d4b44-f72b-4ffc-9310-08d9359b955c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:34:19.4649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdvhXULbSqDGeOrvMw9cdtueUHfJp0LY0Bxv9Bkx8KMFE85ukCArg97D2WwBLfPM+jxe9F/jjNfGYM8Ahxrljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3302
Cc: brijesh.singh@amd.com, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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
From: Brijesh Singh via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 6/22/2021 11:19 AM, Tom Lendacky wrote:
> On 6/22/21 9:48 AM, Joerg Roedel wrote:
>> From: Brijesh Singh <brijesh.singh@amd.com>
>>
>> Add the necessary defines for supporting the GHCB version 2 protocol.
>> This includes defines for:
>>
>> 	- MSR-based AP hlt request/response
>> 	- Hypervisor Feature request/response
>>
>> This is the bare minimum of requests that need to be supported by a GHCB
>> version 2 implementation. There are more requests in the specification,
>> but those depend on Secure Nested Paging support being available.
>>
>> These defines are shared between SEV host and guest support, so they are
>> submitted as an individual patch without users yet to avoid merge
>> conflicts in the future.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>>  arch/x86/include/asm/sev-common.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 1cc9e7dd8107..4e6c4c7cb294 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -47,6 +47,21 @@
>>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>>  
>> +/* AP Reset Hold */
>> +#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
>> +#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
>> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_POS	12
>> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_MASK	GENMASK_ULL(51, 0)
>> +
>> +/* GHCB Hypervisor Feature Request/Response */
>> +#define GHCB_MSR_HV_FT_REQ			0x080
>> +#define GHCB_MSR_HV_FT_RESP			0x081
>> +#define GHCB_MSR_HV_FT_POS			12
>> +#define GHCB_MSR_HV_FT_MASK			GENMASK_ULL(51, 0)
>> +
>> +#define GHCB_MSR_HV_FT_RESP_VAL(v)		\
>> +	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
> 
> This should shift down first and then mask or else the mask should be from
> 12 to 63.
> 

Ah, that's good catch.

Joerg,

Please let me know if you want me to send the updated patch or you will
take care in your next revision.

thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
