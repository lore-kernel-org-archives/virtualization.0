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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C75C2B9F4
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 16:19:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6A1610C7
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 16:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6A1610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAD50608ED;
	Tue, 22 Jun 2021 16:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-RTcOq_PH-L; Tue, 22 Jun 2021 16:19:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EA5C60706;
	Tue, 22 Jun 2021 16:19:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 402B4C001A;
	Tue, 22 Jun 2021 16:19:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5733BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 341D583AAB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ArptMgMz-tjn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:19:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::602])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B68FA83147
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWWq/NnCborz4ed7voSSTzFEaggfgong62DHUvV3B1RqAqZnly3ZGSuZ4t7LikhX6UtF90UPiCoJngpPY7I6Nq6aId7L0lvIIY2U8t86W9BwGoiVEVtX/qyYCrJ3BYSR14U8X4POGFGN7lBdUi2yJJhno7ffy4Z9YhCG4vdh0XmFoHx58nf7XvI5QaxWSwx5Hq9i3O6pjY5jZ+7FLcCE0czj4mdjGfrmeyIITRbzo4mK/M2s8e3gw6qRvoJepF3zxKHw1CI/MzP1x8YFPpVtq+x+pvvb9e4HujoKnWSeZHPUU/x1o0B49eA9A9g/++gwwrOeF0hMSjDoWzHpAT1o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g+udiurdmAaWYvPf3h5ytphbhOLTxkczO2A1Y0wq20=;
 b=IOJJgPwaDJDH40RG5i45jGp7mmnMYZXkTGx+eMuHQcoZSxbRaxYXDfuSYGwMHbE2gOVO24mct0sqPRrB/D+aIr9EOFfyC5y9e0dVBM3KvL5h1icpugbUWp8emcZ9n9LYinQlPcnMihf2fUQ0BUK9T+BQ3wU7M6qibCMlcvYJe9F6swICYvElrT7iosFfacPt/13wj474MrxW0mMFuu8+YQZnxr1+7Ph6kwUfDJBs5r46Mn3rtPrX3VoOt0NVaWOeSYQhXkEpBfc6Zminwg0b3q6OrJDAvs9MjXCQlGodQl0OyJ6j6kQ2HEmjuanKkmWFr7szD2SsKaJZPZOuEvBkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g+udiurdmAaWYvPf3h5ytphbhOLTxkczO2A1Y0wq20=;
 b=dfmoAhc2KeVZi9uLoE5hoakjb9pVHry8qq/PRoCjwFK81r/sj5dOQIUEDws9fE5LpTKyF1xk5LG1TL5i92XWuoqqwWQUdVEZ+aI7yvXL8RlHPbhjDqnGGoDFH2aw5aWjcwCpP9yzcPmt9MgJxKl13wgoArwSHlg1Ap/+rogNp28=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Tue, 22 Jun 2021 16:19:31 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4242.023; Tue, 22 Jun
 2021 16:19:31 +0000
Subject: Re: [PATCH 2/3] x86/sev: Add defines for GHCB version 2 MSR protocol
 requests
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
References: <20210622144825.27588-1-joro@8bytes.org>
 <20210622144825.27588-3-joro@8bytes.org>
Message-ID: <a0d38ffa-e5dc-7e50-fc18-fc10ff19309f@amd.com>
Date: Tue, 22 Jun 2021 11:19:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210622144825.27588-3-joro@8bytes.org>
Content-Language: en-US
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0126.namprd11.prod.outlook.com
 (2603:10b6:806:131::11) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by
 SA0PR11CA0126.namprd11.prod.outlook.com (2603:10b6:806:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 16:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bfd82f8-d59f-45b2-42a2-08d9359983d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31792E8D7A8C34C126F27D9AEC099@DM6PR12MB3179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMNEGAvg7zf77M0ntyDnb6AnDuADPINaC5Mfp5LX0AO+/Clb/vLz4lHZTh+CYg/Nyo8ac44HFsrUFdCrPy8n6KjATul0Bw2iQuc7v/VLeWmx+0zzXPSPdQHgA3r+ZU/fvR3ND1u31pyjBzVB3s1k1F66RZNabuCkZPBVuiUV1/mcb7Y3cMLPM0UTRf0sMfwas+vhClB3D2pvCu8vUEL8B4kEVs36TzcSo2v3s2XKigGGIh0m/VeyScRAuyrYHEpfNl9/ymDUVVj2b72TtlDBZxpb1l2pnbGjdAhn3q3nTZ1FKFmkvFZofN4IVKCh7RNHFcFlqrMifVDNcpObBEipIhnJqcLDezhopaUOeJgDF9EqLO3cZUYmdV0KMAqDDGSBkuRh7h5kVM9d8Bb02zfk8TOSs+YIyPKF5DAhIl8Arr5CsP6heLhK/tg+qB0ITx9R1JQ7JycNl75yIk9K3Tj9R6W7cXYqODx7V//4dSmTS2c6kw3EDIIiiT3/8yZHsHl3MhjWGrhQncLldZ71CjXdPTMazkXUqCEQy6wGW9ncG+gKD6oPQStIKW9awGsKwARlq6ol/FQdCQsSqYnICPeNoACin6Yhf4R5BzcOcKC0z43eXx5cW67KPvA2ZkJ2qFt93cC4tyfa+1dS+YJiFO9HZlUGfazrcoOAwOejHsZAEoAFe4Vo7lordRnBT+JisLjH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(38100700002)(16526019)(186003)(31686004)(316002)(2616005)(7416002)(4326008)(6486002)(478600001)(54906003)(26005)(53546011)(6506007)(2906002)(8936002)(8676002)(956004)(6512007)(86362001)(5660300002)(66556008)(66476007)(66946007)(83380400001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmh6QWhvRTdQQjRzU2lCT2dNdXNiN2p0NmorZ2NyZWtsSHBnajZwaVJ6dk14?=
 =?utf-8?B?SzBveXJpQ3ZYK1RkdU0vMWRPYVkvbEVVLzNPVUNoNVhpRXlPd1VFRE03anhv?=
 =?utf-8?B?M3hnQTJ0RGJiSWI1aC9wTGM2dVdXVUNRUVdOMmRJTHNjUWlUOURkRWx2WWFa?=
 =?utf-8?B?Q2lzQ0VkS3Q1dEVuQ2hsRVpxYTNkZjVPbDFqMFYrb0xXV2kxY2xmckV1d3lG?=
 =?utf-8?B?cHVETktIZ3FWL0EyNHBGb3VVUDJwSE5GK2VWV2N3K3hMY3ZvQTRWYlRRRzEz?=
 =?utf-8?B?TkI1TllCUU94d096MjhHNFVaeG5XVmZLWlkxd04vMmoyc1FFMStjL2xvQWFu?=
 =?utf-8?B?T3Q4R0JCbUlkVDErdzN0aFdWVjNQZE1iTnAxMktUZUZoQVFiSVJ2eURTVFps?=
 =?utf-8?B?RTV6WjRxS1paKzlxLzEwbkIzSFlmVXA4WG5RN1V0QW5PZnIrTDdFZDk5QmZ3?=
 =?utf-8?B?cGxoNWRjUkhmeUhCRk9TTXB2NDRnSnZUdG5vaWdqcU1IenViUGZBNVZzQjBo?=
 =?utf-8?B?d0xjc0NRNTlmWnJWWUNMMnBSaXdRNGl4OHhSVVEvZjI5b0Nta3R1YU5PSTNp?=
 =?utf-8?B?YTdra0RndnovZVN6ZlU5TmRQTE8wc2hlR3Y0alZQREdZYU50dHlSMjdaaUx1?=
 =?utf-8?B?ZmFCK044TnQyTytQdU93K0hnTTlmOWh2RlJzb2JuVjByWVU4YTBTV00zaFN3?=
 =?utf-8?B?VkhaSlB0VFcvVVJLSVZBVGJxMzNFTXVoZ0NxcWsxRjRKcGJoNjVjdVhSVFA0?=
 =?utf-8?B?VGE1UmRvV0lkTzhTMVNwbzJKUVhoV0JMWktZSENDNE15RXZ1blV3TnVxWm9B?=
 =?utf-8?B?bmovbmFSRFJyVmxDOSs5U3ZEcGh5bUFCVEpycXJxRUppT0Y2Nm9ORW1KNTh0?=
 =?utf-8?B?MTZERzNTb25FTUVOVnB4bmFlalFOeHBqU1h0aURvK251MFVwTU9vUTlXK0Jo?=
 =?utf-8?B?UUVqRFRTNjNxa0dSdlI5Z2daN3RYakdsNjdBR2ZWS1oxVytjTnBsT1d3VWdN?=
 =?utf-8?B?bG96YkI4cTVrc2NMMUg5RTFLVFNBUjB1aU4xMmVUOXRrcmdSejkwenYxT2xV?=
 =?utf-8?B?MFpaWm9GYXlwVk10cE91OStlMmVhdUFQb2t4Z0FUNlZpbnZzOGR2SHEyYjZ1?=
 =?utf-8?B?S1JjNS9vMVJmcjBFMUNLSEY5WUQ2ZzdRSGpZWWg4VnJxSjlsYXZyZ1dyTktJ?=
 =?utf-8?B?SUV2VThVd2tTakZuZnB2aDR4eFg5Z280WEhETmcvRUd3Mi9RczB6emdyVU91?=
 =?utf-8?B?UFhGNmdMdUpBVVloc29TOTZGUldHNWRwTW5PUzlCaGE5emsxak9nNFR1cjU5?=
 =?utf-8?B?dTVVckczbVVmTTBvVlpPSUMrbFBSZDczZDFSanZITFlDZUhXWmN2ZTUrSlNE?=
 =?utf-8?B?NWk1MXhhTXd2YWlsT1dsZlhJdEMrM2gvcUdibytJQm9kRDJrQUhLRFVQR3Nh?=
 =?utf-8?B?T1hkTVhQTjROeXNtcFFDK3UvT2lNd1pIQndERkUwSUNiRjJzMEYvdDVuS01t?=
 =?utf-8?B?L291MUpuK1pab3M1Zjk0bGZIb0NsUmFnbXE5TDd5dURPamlZZytYRTBsNERS?=
 =?utf-8?B?NlhGK1N4SFFBdlZ5M3VBZW5KbjZkYXdqL1ZJblBpNVhlVm1NK0NpQVVFVUJ6?=
 =?utf-8?B?QWNzY1Rnb0ZZK0JBTXl0T3FMUXpIdEhCOUttTVdHT1IyTzc4R2NhVEI1K2Q3?=
 =?utf-8?B?QUZOdzBkSUlUaEhWc1JCTlZaS3BJQU11bEFuM2xYdU5iZjJ6eDlGdGJ3R1NE?=
 =?utf-8?Q?rIyYt0rh8yM2kLutH8ooR/OHrNqW9beWOKVD65J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfd82f8-d59f-45b2-42a2-08d9359983d2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:19:31.1707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsBStmMRi5MamEPbJirkGzYUwyxp+DldeJp/zsH2P9cPsAh588vqVAUb+pu01yo6PBARipUh5zQHo1NAZ6k9Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
Cc: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
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
From: Tom Lendacky via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 6/22/21 9:48 AM, Joerg Roedel wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> Add the necessary defines for supporting the GHCB version 2 protocol.
> This includes defines for:
> 
> 	- MSR-based AP hlt request/response
> 	- Hypervisor Feature request/response
> 
> This is the bare minimum of requests that need to be supported by a GHCB
> version 2 implementation. There are more requests in the specification,
> but those depend on Secure Nested Paging support being available.
> 
> These defines are shared between SEV host and guest support, so they are
> submitted as an individual patch without users yet to avoid merge
> conflicts in the future.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/sev-common.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 1cc9e7dd8107..4e6c4c7cb294 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -47,6 +47,21 @@
>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>  
> +/* AP Reset Hold */
> +#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
> +#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_POS	12
> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_MASK	GENMASK_ULL(51, 0)
> +
> +/* GHCB Hypervisor Feature Request/Response */
> +#define GHCB_MSR_HV_FT_REQ			0x080
> +#define GHCB_MSR_HV_FT_RESP			0x081
> +#define GHCB_MSR_HV_FT_POS			12
> +#define GHCB_MSR_HV_FT_MASK			GENMASK_ULL(51, 0)
> +
> +#define GHCB_MSR_HV_FT_RESP_VAL(v)		\
> +	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))

This should shift down first and then mask or else the mask should be from
12 to 63.

Thanks,
Tom

> +
>  #define GHCB_MSR_TERM_REQ		0x100
>  #define GHCB_MSR_TERM_REASON_SET_POS	12
>  #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
