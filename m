Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA76C4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 12:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC861076
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 12:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC861076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF32640488;
	Wed, 23 Jun 2021 12:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJwv9Y2Z_lUT; Wed, 23 Jun 2021 12:33:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3ABF940456;
	Wed, 23 Jun 2021 12:33:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1DC8C0010;
	Wed, 23 Jun 2021 12:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12600C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0EA0605F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7llPymj8yCFL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:33:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::609])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 966F8605EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 12:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipfIKg1jWQSSBAQvpZtkG/4eHUPq21T4VZ1f7wiAHJ40kOfPdT2nVaxmEuNmKtBhK3h+RLte32tCmBeFWjdVrkWcVEy4ettOCGBYKSSQC8HpYCISG1WmAybb/XlNoU5bWAbs/PE5CfmlbWtr3Q77NdgjsnnN1bp16Rv3PlJciuiKleOqRckyGgQLjvKrMJDFGW14VlXWUFpVBj/mObEt+xKELbOb8Qs17XhlMJd9KnfNY91Vt2F2HS9NE1y3EO07kgp8s+0TuTLym5kDJJp2ZZfirdJZ1FHmrzB2XfXDTh4XlbqDIUo+8CQ2N88zC0AA9iXP4WYaCxalTTbAs5RFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqwcoLCE5gf+7txchdEBLKfMC8F5yRIDkHnD1r9JP3s=;
 b=L7prCtoQw2XwmNaalzyU6KZXzUYCfLknSXjmY1sUaE3SRyssK7xKM+0/ygf3cAmMdRQSYYCQl3mY8PqhhCNZvYgi2PHS8ximBMo3m69ClxfR6OCCyfFhs5+nWEaA4387vkYXpoYdT4HhiTClgygDuuZ1GcUjJ2U+V92tqWnnlKzpyWGXpx8EMQeQTa7EFZzuSXS7LHksD2tIGd9DGJuzXKN86PmK99muhcgfCv2o7z9FvR/K3x8LSq/Vbkk3JPq7ns58QZck/kISfTbwOPFPaMWcRxUTMUfWk3DWc048dbsOLKuaEvad1/Gcs1kRGGACKAPpWZC+lK4Vct9SU0ZpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqwcoLCE5gf+7txchdEBLKfMC8F5yRIDkHnD1r9JP3s=;
 b=HjvEtuxpr1uZNr/crrF6e32y+SfxSnlUYT6Fu0cFpEDF0mIwDtIVswzGUwblG8e7TJxGjouOYsE7M9p9CjJCEfsW2JrFQg4aOzsGjEewQIFnz7Ms0WVfg0p9Ih+R0W46APi2/FIYqUfi5E/3wl3DHOmWyx9JTYjhZxs0I40HmDc=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 12:33:13 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 12:33:13 +0000
Subject: Re: [PATCH 2/3] x86/sev: Add defines for GHCB version 2 MSR protocol
 requests
To: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>
References: <20210622144825.27588-1-joro@8bytes.org>
 <20210622144825.27588-3-joro@8bytes.org> <YNLXQIZ5e1wjkshG@8bytes.org>
 <YNL/wpVY1PmGJASW@zn.tnic>
Message-ID: <93fe4681-eb0c-d901-9497-336efb4429a6@amd.com>
Date: Wed, 23 Jun 2021 07:33:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YNL/wpVY1PmGJASW@zn.tnic>
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN2PR01CA0030.prod.exchangelabs.com (2603:10b6:804:2::40)
 To BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SN2PR01CA0030.prod.exchangelabs.com (2603:10b6:804:2::40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 12:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 755f0747-c503-4ed7-3e17-08d936431193
X-MS-TrafficTypeDiagnostic: BY5PR12MB4020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB402018710A4683E038E7C525E5089@BY5PR12MB4020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpVSScW6VjnWGG3PydcBw3BwPYkfAHbwItPHQs+fEo2lVfAuDlmwGMIZcSHpnPGFc1LnTVoyQa8/XoAhDCydwX+SrNpLQt2siIB71ZWE4WgwC3WJk1tFqHygbrHioNwiNxJw1eQHgkOXCaxg7fTPGOkr/z/GbYquqqDHjuffBba/m7NTCR9herxVQ6jlNSzTi4LG1TlxTeKogwCQ0CwLZOmN7bxrGYjkLtGgn/v35aZCVbcnSFF/vKz8aKwOC1g8Z8Fje1KBCs9yoy5uJ9MSaojSdEMTxl+ewM2feSUX47F1G2q5cgfet7N/ibv3bEhivAoX8HVjkMpFKWuemJurf2JOjRpte9Gl9f7z0PLiNmtiCJynnQumkqBtZkB6IZNZSP+nMKm97hYojxaPLIYlcypyGOrHK0BO7NSc4Jb61UvHf8fo4CRC3LYa+Lv5cz+GbiG10gKj5d5QZJJhvje2Tqcyd7dADHpDaz0XfAE04a1xtDzeBt9gdO/Os346Chk+Y1sZ/STjLYITqLZ+10EpstYcrp/p3ai643N+86wRJM9DUN7bwCPCAn4Zr9e5+8BZjm13E854cBgBbmyyvt+HA7jImFsKQsq6qSjbn7E56m4GkxYg4NeXcNBfYNT5hz40A79gqQOehJyTcZAiZX7smq6KPMgCNMp2jey6NsM2zTFlnCojrW4Z2jI//ZRPb/Ju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2711.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(396003)(136003)(366004)(346002)(31686004)(2616005)(38350700002)(7416002)(52116002)(66946007)(956004)(4326008)(8936002)(6486002)(5660300002)(186003)(44832011)(478600001)(38100700002)(83380400001)(16526019)(8676002)(2906002)(36756003)(86362001)(6512007)(54906003)(6506007)(66476007)(66556008)(26005)(53546011)(110136005)(316002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFhTE0xc0hVcTNyY1VkYXdrWGlqUmdEaE4yY0IwWXp4RE1kWVJYcC93Mnp3?=
 =?utf-8?B?MmwzSE5PQXJ2M0svL2cvOWlybTlCSk5rMWkraTJuS2ZxMENhNlB4dFFDZ0ZW?=
 =?utf-8?B?UC94dWExTElOcnFaQldmSkdLa3YxTDBkRy9heTJjUjI3WUVyZEFtd00waWpZ?=
 =?utf-8?B?WDVxMkJ5WDVqTVRWemRkTnNDbklUQXYvTk91bkRMVlpLMG1GcGpOUFJEQTMv?=
 =?utf-8?B?VTZYQllRcGMyMkVmOXhuUjh2UDVyc3JYUncvZE10bTA1YXpLUjRrWHJ1c2xP?=
 =?utf-8?B?SElhR0dxdk1CWVRDVytHZ2xvbWxlblJrOEErSjJ6b3B5Tk1FVjBZaUJ4S0sx?=
 =?utf-8?B?YjNaQUFEWXRCbEpsb1JWSjdOR0xlWEJKSUphOHhNcU5XUWlFR3lsU0Z6aEtE?=
 =?utf-8?B?a1V4U2xiaFhxKzRpSFJVaHdJbGVUU05Wem1pV0d4N3VOMVhzN2ZQbmVJczJh?=
 =?utf-8?B?V0pZQVRKRU5lQndWUCtBMjFLQVJSQW1pQ2hVcHZGQVhGU21tdEdWMGYwaFNM?=
 =?utf-8?B?dktrYmxQMDZlTDdzNW53YnQ5Mjh0bkJHc3d2WklvWWNBVXczN2ovOUF5b085?=
 =?utf-8?B?WG1JV3h2dGltTGlyWVBWNDBVYjMwU0V0WkdaVXVKYXB2Vk1RQTV6QlN3Y1Er?=
 =?utf-8?B?TnNNQ0hHSHpYWDlhdzhLdWlqMXpxbEpFdzNFemZOQ3N1TWczdEFLOHg4VkFn?=
 =?utf-8?B?WVpRako2WUFySS91QU1MeTRTRGlUTHlUSitVYjZCWGErblpEMTZqYWZ3KzEr?=
 =?utf-8?B?VDdtZHhqYm1yL1BaUFQ5VFFmdlgrZk5KT0VaMVRrdjI1aTB2OGtPZXowd0RV?=
 =?utf-8?B?NDAyeGw4dWR5UTJVZENjQlRVanFRb0IzZmFTZWQ3NTZsQ0ErWU5NbVZ5c1Fy?=
 =?utf-8?B?WU1tcml2czBPWDUzS0ErYmIrSm9nOUF1NjUzcTY0U0x6UnVUdUU1QkkrajFx?=
 =?utf-8?B?UjFUYXFhdTJRT3JCYXFvTUh4cUNxNlNiV0pBMWU4WHorcS9jMkFZd0NwZ0t1?=
 =?utf-8?B?bUszYXBTemVZRTE2dEhBRnBOWEtmNGJyVlRKb0RtVnVsZCtjV2FtWkdKTlV5?=
 =?utf-8?B?VkNGN2kyUHR5cGxyYW85L0VaOXlSRVNjQTJkWGR0dVk1WjNQRVF5VkQweml3?=
 =?utf-8?B?dnNleGlzZUxqcGNkUjJrOWNiTmJoRkZUenJGR1dTdUJsWDdUdUJxd2h3WDNk?=
 =?utf-8?B?QWVLekFSM2ZoN1RSQ0lvMVhnZEUrazlpMTd0RkdhQ25pUjJWTFZ1SHF3QU1C?=
 =?utf-8?B?a1cwUHpIc3NVV0p1Rm5SbERLZ2dVSTM2T3hnUlc0aVNqeE1odXl5Uno1eWtx?=
 =?utf-8?B?TXlMeHpyS0lwYnhRU1I0U0N6ZDFBSG1pT0Vxd2ZVejVoUlcwT21XaXRkLzdy?=
 =?utf-8?B?U25QN3pYUFBZa05weWkxWmpId0w0SmRGUk9mYUJWTmFpLzUvTVZCMEY4U1Rp?=
 =?utf-8?B?a2FMaGMyQmJJdjlLR3AyM0gxMGZNZXh2MVVIbk12THJCczcyTEovVmJiU3pY?=
 =?utf-8?B?Y0crSDFvczFYMjVDWlhXNlRPMHlkdVpYRWtIUEthVDFpN0Zmbkp1aVVxaFdG?=
 =?utf-8?B?UnVueTlUdXVUbE01T0Y0K01jRms0bm1pMnYwaUlTdmZzZXV0WFR1QTBEb1J1?=
 =?utf-8?B?N3hYRXJhT2llc1FTWWxCU3JielpEMzY0OW9hNHFtOUpNY3haTW5JNEV0SERv?=
 =?utf-8?B?YVBaTS9qMUtBbnN0cXNYYVp0WkI3TGVkdGJzQjlST3RMU0hnY0toTXB1dEtm?=
 =?utf-8?Q?byyPIvXWtyCZGJnUTXk6GR3E8MbUf12HqlIf1Fo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f0747-c503-4ed7-3e17-08d936431193
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 12:33:13.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9hxWfFmH/IrSIpTebH+8BM6xJE94g9j4htOgneXQGeDYj/RGI8x3BLpdUX9xsYmxU9K2BRHTtG97Mnn1GFzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
Cc: brijesh.singh@amd.com, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
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


On 6/23/21 4:32 AM, Borislav Petkov wrote:
> On Wed, Jun 23, 2021 at 08:40:00AM +0200, Joerg Roedel wrote:
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
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>>  arch/x86/include/asm/sev-common.h | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 1cc9e7dd8107..9aa2f29b4c97 100644
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
>> +	((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK)
>> +
> Ok, so I took a critical look at this and it doesn't make sense to have
> a differently named define each time you need the [63:12] slice of
> GHCBData. So you can simply use GHCB_DATA(msr_value) instead, see below.
>
> Complaints?

Looks good to me.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
