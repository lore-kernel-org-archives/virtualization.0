Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA45C6377B
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 21:17:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E8A61001
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 21:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E8A61001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCC19607F1;
	Wed, 21 Jul 2021 21:17:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EV_NQdU3ECM2; Wed, 21 Jul 2021 21:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55D68607AC;
	Wed, 21 Jul 2021 21:17:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34FE2C001A;
	Wed, 21 Jul 2021 21:17:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7835BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 21:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C656607F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 21:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bs8xfe1fUnnh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 21:17:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2079.outbound.protection.outlook.com [40.107.95.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 359CB607AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 21:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST5CU+btcpaOJV+xPpbGFnZhyp/+Pna3m6tzfyTg1d90LJck+04pPLGght9NwlpMwJvks12BUYd1Zsw+/hyEr9F18cK+fbVSC0AoQjZG6A/tcevLCQYDyeTAho7KNRCWS+KJrwnxD4FQ5izMkaKWfeddjp0GQYSBW0AjsMkYfQIWEkQgtGMSKrDLANDvKX10KzerR5KJvemn6NHuL0O3EiPOckhuCHBiJktuCLZAI0Cz24M6pmRVsYDFOwzkDKDqhwY3XtyukeyZ+UhbClX36jJEwR7ATW5F7vWEUuJTf6A+Ih48T6ivfZsTCAG4ETiDnEQB+vezwRE3R28/VFpA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+qkSGxcmLTfG0eDpBfX0+qiJAwxc3MsmwMXfR2oBmA=;
 b=QqtA/2sf9jhPqQ9ssR3bSgEOrbIvwG/hQTJbHNjEU+femAyOsHbDfzLIHmw7pnE+wKF5E0Ov79sCRSVWdQggKVE4UP5G7Wz3rhi8gYo98d4ldno2L8LGDKUboOUzMPessjUIPrUqRUqtVnvjJZwBpMvSA2ZTwxA0OMWyNaLgSmZN6GmEQYkeUcohoy2TuW5/+A+CpG5K8iTUYflcXowQDKZO06EWC4oUES9LsVuX/T0aor0+vYA+0jTwQbJYIfA7HauyKU7Ewi6md+6GRQSHR1jVDFuE+E+CR19M1Qm7fra+3zRrhMfcZzQI6+3ObjAHWW7yBvoUj5H0j+jkf55Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+qkSGxcmLTfG0eDpBfX0+qiJAwxc3MsmwMXfR2oBmA=;
 b=ZHHyW6fNY6sajifXjhEAmu3KSNN9UWIzxVLjrnA+lwy5p9O6QgTlfY/8XCEsE5P1vfXR957i8M8v3bPPvAj6OQCGlgrKT/JMdtmo2eH+IfV0+rEoaTd2DP0PIBHRsj362bypfCnBS03zSrP7M8NNcdx4aoDucMT+tG9xBmXrXDA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.32; Wed, 21 Jul 2021 21:17:41 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 21:17:41 +0000
Subject: Re: [PATCH 04/12] x86/sev: Do not hardcode GHCB protocol version
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Eric Biederman <ebiederm@xmission.com>
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-5-joro@8bytes.org>
Message-ID: <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
Date: Wed, 21 Jul 2021 16:17:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210721142015.1401-5-joro@8bytes.org>
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by
 SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 21 Jul 2021 21:17:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ade37281-6cd2-4a06-0c9e-08d94c8cf928
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5413A78EDB749733D74224CEECE39@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCKoYgpSZL/OpwOapXNZYNvUS9vJkHaCGvub9oMHGCtUJXyzmMotkbohZn5RGHot6qYaxMVHLnGfcZMHswSEgSOhOzcDAG5AE+x6CwQFQva75xPjfkvQMppd03FxMShHrZLyhtfcVEYwuuYiCyIbSwJa43stwfcia2FHWbmH1OOwUag4UpVC5tkX9WCSEaO2g84g954fdd75lIezlb9x6zn3nG8xgtBMCa4im6dM3BewlX/TnenF6li6ZiQlQrt1A9033CAB/keXa07S7UbZ4a6R5WMxneNk+53MLu/QBbfuRMzyvA5beE8QRuem6elXmdoktMtN4wCuYgVFHLtfDU4IaM9Rvw4JoMIGH8fAZUPOqeK2idEDLlWWm9693Ms22GQ7k3qobDwFarLVf93MN4o0Z0U+ADMMxjjDFSws7uGFw8Ijoz1HmeT9YpuNn88noaPWuwGCijlyjT5Q02gur/0lTzuxsa84ewSbXqYRM1IXlpFSYvnSusWsQEH1Ekm51iNkuo7FtkwxvPfI8+jPijyl76A7Z3uEiI+qU8oN7kV+tGhvTbMcB3ubHgeuIpXd1psZ0aau9a9eRc43uc4ibMdSPheLhf0AFx4zxXZ10D6/VRnVJ62M8dz0moOV9HwuOXtP00mzW7ST27xW9ozRtUiDzmC4KzuagV/K2S2CeGAcRVr9j2BhteJ0JthtC6Z4gBkjluNUVm30utj71qGQo/KjskM20MVJRwqn1UT68oYfivkSk9fWaLuiSxBpUY88
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(36756003)(38100700002)(31696002)(86362001)(8936002)(83380400001)(4326008)(53546011)(8676002)(5660300002)(16576012)(66476007)(26005)(66556008)(7416002)(66946007)(186003)(110136005)(31686004)(6486002)(478600001)(316002)(54906003)(956004)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1LUzRZeUdsREVMM2JHL2hvVWpzTmhjOWRIS210dXNLdjAvZ251OWFxNGxQ?=
 =?utf-8?B?ZzJwSm5qejV6MjlCWVZtNms2QXhZaUlINWZEUmREWmg1MUorcHBvbkZ4RW84?=
 =?utf-8?B?QXBDS1hvWnAvNmtpejhMZUZ6bkVxbHJWRnAwTCs5bjNxak1ZeTdLN0ErcURJ?=
 =?utf-8?B?UEs3MG01cmJVUlhyVEtLYkJwRno5N1ZkY0srSUJ1dlJpcms4emNjMUg3SEJw?=
 =?utf-8?B?RFdVOUo0aDlLRTU2SlhsTEhxemtKVG9QdjRSTForaFVjNGxrSXZmbkdTcU00?=
 =?utf-8?B?Y2l3cVJVYStENXFwY1dkRStIMCtCb1p0UlNwZWFMcUhPbnpVSDBqSVJsNm1Y?=
 =?utf-8?B?STBKNVJUVTFKOVJ5S2xMeStKUDFwcUFrWUlQdTdhR0xIN1dzYmdPNi95NE8w?=
 =?utf-8?B?aUpLdk9nZ3dCWmpPalgxRG11ZGFsaVdJMFRvaGVYa2JKdHJDYXN3V3NWTHRP?=
 =?utf-8?B?SmcrQThQaXg5WVVQTDN5TStlMjlFVmpXTGtQSkFmVXdBY2IzMnpkT2oxc2J3?=
 =?utf-8?B?M05VeG1JeW45RC9QYnZlRkZkZ054Q2M5aEtnWERaZjgwenRIRjN0Mk5KS2VP?=
 =?utf-8?B?aUNkb0V2Q3k5Z2hZUjB0RlBZODVCV2tCQnNtK1YxdDJzbE8xQ3Q3M00yY0dO?=
 =?utf-8?B?TUFNWUJ4dmJBN3E0Mkp1VmN5U0tXM29FWUFza0wvNCt4Y2w5VXN5a1dQYlh0?=
 =?utf-8?B?MXJHR1JVOU9iWGdMeDI5d2lxaFIvR2NvL2tDR1RaN2ViRnNGdUx2b3V5V2ZQ?=
 =?utf-8?B?Q1luVVRIaEVlcmk2K3lNTzRNbTJXdmdWZnVwejcxN296Y25wdVY5VXNlSTRF?=
 =?utf-8?B?dnBUeUhoamFsY0QzaDUyQnNiSzRWbWpvSXdqZS9pOFNWYW9SVVljK0JSaHFC?=
 =?utf-8?B?WmhiY2xoZlR5SVlvWXJKZFozTUNGWTcyQ1BsOTR2TmhvQWpMSnh4QmNKQ3N5?=
 =?utf-8?B?KzBmamlpY0tSTzVITW51dkoyQXJqRkcvRkpyVU1pbDF6Z3BxMk9mOFRCWFhW?=
 =?utf-8?B?US9URnBYcDh2cENUWlo2THhWMlJNTnhUNXZMcTZRWCs3UWtodUJRKzVqWUxC?=
 =?utf-8?B?eC9zZGE2TVFERFBCQnQweisyRDl6OUdOaWpqbmFXSHRkU2w3ckUrcVRsZURF?=
 =?utf-8?B?Vjd2ZVNZOWxPaXoydm1ydmprd1FpNitSeWROUkRwS1RYOVAyUFp5MnFlMXha?=
 =?utf-8?B?SEdoSEFjOGtWOHZGcUZBMEl4QkFnR0xCbHVncTlGS3o5Vk9VMTFNYVU5ckFL?=
 =?utf-8?B?ZUkvWDdTd2tCSEdkVmV6UzFuODZCTnRMNzVOVzJSQytleDRUMS8rbmtLOGN4?=
 =?utf-8?B?KzFzL21zNjVaUVlxR2JlUkFQWjUwUTk2VFBNR3paaDlHVVRXK25ZeG93bHNE?=
 =?utf-8?B?VkhMRzFPVGNwOXNiaWVGcGhBSzhXNVdtNXlLNEFJNkNPN3NYQUFxNytWN1Fz?=
 =?utf-8?B?STdjR1BWcTNTdEo0cDNaSTkrRFJOQ1Nxcm83Z2ttUk1oTlc2blpzbVdid2tE?=
 =?utf-8?B?UDF3QTU3enlvaEVGOUljd1hzb1dUdzZPUWFMZmVKb1NrSHJlRUNVbUpXQ01z?=
 =?utf-8?B?aFJBSDJTcEJ4Y2c2Mk9YWmhQanZBeTRvV2dmT0VOb2RmZHJrM2hMR2xPZER2?=
 =?utf-8?B?MzRVL3pwYVk4bVk0b0tUemFzZzB2M2IxaWZiUHc1dmhWdzQraTJYamVLWlY3?=
 =?utf-8?B?ZE1iZjgwUVVNZ3hGS3ZTTThoTldINFI0cHlWVFozMnJJaHNXUk5WOEhEdXBQ?=
 =?utf-8?Q?VzbIlsMlYOTb9/tJ9HwOPMm014I2L/tL8yBa/Dy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade37281-6cd2-4a06-0c9e-08d94c8cf928
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 21:17:41.1309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iPkJuLHNLE7q41GfmjuHActjg00e8OvXmtpDfk6/OUjgzkBF0l+InwvU9M5Ht5E7erNR4/+c2oXhtiMekzSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

On 7/21/21 9:20 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce the sev_get_ghcb_proto_ver() which will return the negotiated
> GHCB protocol version and use it to set the version field in the GHCB.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/sev.c | 5 +++++
>  arch/x86/kernel/sev-shared.c   | 5 ++++-
>  arch/x86/kernel/sev.c          | 5 +++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 1a2e49730f8b..101e08c67296 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,6 +119,11 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> +static u64 sev_get_ghcb_proto_ver(void)
> +{
> +	return GHCB_PROTOCOL_MAX;
> +}
> +
>  static bool early_setup_sev_es(void)
>  {
>  	if (!sev_es_negotiate_protocol(NULL))
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 73eeb5897d16..36eaac2773ed 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -28,6 +28,9 @@ struct sev_ghcb_protocol_info {
>  	unsigned int vm_proto;
>  };
>  
> +/* Returns the negotiated GHCB Protocol version */
> +static u64 sev_get_ghcb_proto_ver(void);
> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -122,7 +125,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>  	enum es_result ret;
>  
>  	/* Fill in protocol and format specifiers */
> -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> +	ghcb->protocol_version = sev_get_ghcb_proto_ver();

So this probably needs better clarification in the spec, but the GHCB
version field is for the GHCB structure layout. So if you don't plan to
use the XSS field that was added for version 2 of the layout, then you
should report the GHCB structure version as 1.

Thanks,
Tom

>  	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
>  
>  	ghcb_set_sw_exit_code(ghcb, exit_code);
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 8084bfd7cce1..5d3422e8b25e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -498,6 +498,11 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
>  /* Negotiated GHCB protocol version */
>  static struct sev_ghcb_protocol_info ghcb_protocol_info __ro_after_init;
>  
> +static u64 sev_get_ghcb_proto_ver(void)
> +{
> +	return ghcb_protocol_info.vm_proto;
> +}
> +
>  static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>  {
>  	struct sev_es_runtime_data *data;
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
