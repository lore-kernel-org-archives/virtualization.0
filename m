Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F1C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 19:30:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEF6652A8
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 19:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEF6652A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDA8547E72;
	Mon,  8 Mar 2021 19:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XA6zeKAnW_Nz; Mon,  8 Mar 2021 19:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 118D648AB4;
	Mon,  8 Mar 2021 19:30:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C21A3C000A;
	Mon,  8 Mar 2021 19:30:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBCDC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 19:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B99582DC0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 19:30:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5iSpm5pqyaQV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 19:30:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::706])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5925828C5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 19:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctFA295ZAdLXr8jnruPagrCdKuVJp6J4EmeKwgnmwJ3VnREih4aksBVEbI8+e+m9x0ncYNQNneVclkFm5a4CKURRM554/SENoZbcGEoUq5jG5t55syuwsCnhp3jue1CoeFf9CCoT9ljU40p0EYv7eocWNzkkvkXmpKHvraIoGZ2ygVQtNFWpuC+tZ1tgMEMrhWAcpb5fzU14gYVpfy7lBxrs6zK97uPPsC9TTreRj8YESENkc+aPYXkeQRbtq7rA4jLK4JjSlyMjKklNjl7gFam69Y6Trg7XmKC9ePof7ekN+UETpO/fXcfrcnWlLvFCcugA8L08m8vJUYxZO8kDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlDwD6BXKnsB6s8NgtwD7MQrln557hxLP3nwn0LKIo0=;
 b=ghR5xrHnetG7SJyJ29hdpSDhZR1+Y1vuCUaCFXbcfyNzH4zOQu448FP3iLVfdQdBbOyqbOhMChAJwFrL6yRnbp8Xw3VyjypC3m8m8aEUO5ZjP2TRcGEdvDFVbJyE1LEUlXJLWuNoVrOWwYDWhLI6vAUfUib0WQn/c60HYFIhpQEHBt+W06SzUCausgfONCQiXEXf/nj2qTaNJ+RueCNzfP1fRDdHLGzVafEsp7PTMrzOGlHyGNPUSftikDIDCcrBqFj42C4T7iFK5LJFnofdqX8HJl9k4rNmOzOFnTQT+LbyXHg5SS9YJ/+/wjbs7me80nnmw1JDn8LzAgBh2gLlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlDwD6BXKnsB6s8NgtwD7MQrln557hxLP3nwn0LKIo0=;
 b=gDg+RyaANXUz24vkd6V2JMZsweLQ1rTxLYOz5f2cGKlepxNT9+QsC9q03pGgo5J22LxoCUPhHEjWsm5EMoJ1PEpjkFk4GDIXZpL1iNeK4nfENTXeeLa1wnX7qyalFABT/d8Dcmed7GVDo21PPuq6eUxXCpPmZkpO6lky+qs1jl0=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1770.namprd21.prod.outlook.com (2603:10b6:302:8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16; Mon, 8 Mar
 2021 19:30:01 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.005; Mon, 8 Mar 2021
 19:30:01 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RFC PATCH 08/18] virt/mshv: map and unmap guest memory
Thread-Topic: [RFC PATCH 08/18] virt/mshv: map and unmap guest memory
Thread-Index: AQHWv52Toe1LRVK2KUqT7h/r2T7yX6pMTc3AgC7RaoCAAAF2UA==
Date: Mon, 8 Mar 2021 19:30:00 +0000
Message-ID: <MWHPR21MB15934FDC8DBE4088E8227AAFD7939@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-9-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593A5DAB7387BDF58B99056D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <d63330fa-de83-85de-c8ec-74cc90d680e3@linux.microsoft.com>
In-Reply-To: <d63330fa-de83-85de-c8ec-74cc90d680e3@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-08T19:29:59Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fc2ecc7-f73d-4047-97d8-5bf7841fa740;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa3556d9-e92c-4c26-f2fd-08d8e2689126
x-ms-traffictypediagnostic: MW2PR2101MB1770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB17703B6460FB137903B0B949D7939@MW2PR2101MB1770.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGl5J88eU7AfyEN69lcjrDct54siwEMkcsThTdwqwFcqwZ06V729Z8juz2IQoNVDk6ywt4JZbdudg9ThGv9Ker+57Q5XMEjXZ9RBUFkipjEWoyHh10/394Fyk3z2pWrtCo2jUk9hSAsi78w7Va5HtD90nsVr4ygEu8i3HVplFEpzRjkDLo6Mf5WmOLC8e3QdOJBMqOX2R/JzU6Ks4XI+sTpaL91Ie5xrJe4iR0iSgiF9tTeiaPERpkReuZDm8UGCoSACriYpjDrgKCm8EnBVuD3tBjeQKeNSMPGhx1zGRNSVHAIJ2qF55RARyQUXiVJzOH3cavTKdASTPv1mDuOLeU04oRLdoBABtcQcrGtLYwwWRyZeKlXm90jLi0/EQJ4vm32C71Cg8c2Igge9PyKwd6j+pXPYj+r/MSGwWj8ndLRcQYR/GsaHWD9PDUaxBaf1wRJX/VKnzpnlZ7/y4o0t2EbrQLzMZ7iRqOCi2a8zshrGPo6YHaqSqHlcKSAWso9/rKCjT+8i29WovGyqVRZipGYkQmptADDsrbNXeQ3pDbTVuJs68b2R4MjA6nagM3N0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(83380400001)(8990500004)(55016002)(7696005)(9686003)(2906002)(54906003)(66476007)(33656002)(478600001)(82960400001)(82950400001)(107886003)(26005)(186003)(6506007)(53546011)(66446008)(64756008)(66946007)(110136005)(8676002)(8936002)(76116006)(5660300002)(316002)(86362001)(4326008)(10290500003)(66556008)(71200400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHA2Z2xIamhJODBwT2hmN0llN3pUbkFWYTVXMmgrY2FQb0dkcHBqVUJ2dFRo?=
 =?utf-8?B?ckxIMzBCelpESk5WUGdJMWhVbXFPeFZoekVxdWtTemRPQWFaaGFMSHV6dWov?=
 =?utf-8?B?R0RYWVBEcGh1eGltT2MxY1Nud2NQSGQ4NUkxTE1SU1g3VzNoYk80TEhwWW5z?=
 =?utf-8?B?djA5c0hlRGpESFI5bHN2TkNvUEJpblhlRG1weFg2RmN0NUlPcUgxWWpSNnVs?=
 =?utf-8?B?YmZTRndpWEQ2K1U1Z1pKMFBRSHI2MjArVjdUSU5zeVY4VkdpZEdiZVBGcDNV?=
 =?utf-8?B?dkVHRlE4a044MUJNQ3F0TWc0M1pkd09CNEZJU1lOck0vNVo5cFRjQnhHTi9h?=
 =?utf-8?B?ckhFQTB3MUpLanorN1pSdmgxV2RURm5DTkdybzdLQ2xhY05YT2Z3SHMweWRX?=
 =?utf-8?B?KzQwUlNTVWY2MUxzUzFUUXVmNisxV3M0dkpCL0VIeXlZTkR2cU9DZVdTR3B4?=
 =?utf-8?B?ZTBtR1pQazFoYm5kQjdQL05EQVpOcENTbnExa1F5VHhLbUE5ZlozYlJmQytq?=
 =?utf-8?B?QTZ6bCtTTktickQ0ZGxBVFI0TE9STlFicm5kTTRLaUVFUTBiYWFXbVZldEYr?=
 =?utf-8?B?MGFVazdTcXk3Qk04Qk12U1ZyaTIxUnVYS0JxU240ejZxazJlRjAxeGVoZm92?=
 =?utf-8?B?V3hOek0zR3kvcDBuZVBzSlNqeEhKZVhseFphM0ZuZGV3WU9aVktjeFJFSGlG?=
 =?utf-8?B?RDhGU2dWQmpLWDVYWThvOW9WTk8ramR0dTFVVFhjSkdWOURMWHZaVHlVbUtw?=
 =?utf-8?B?dENHSE82WitBZ1JDa1JnS05xSFRJaHhqc2drSUJUaERpdmdhcGw4cm5lOFRj?=
 =?utf-8?B?S3JTYm5Ba1QwSFp2Vk1PazlRZWN3RGhoNXFrVnBwcUtKZ2c1WTVnclBMQUVk?=
 =?utf-8?B?TnpNRDBiUHNIZ2txZ2VVRkJCbWQ3L2YwMzd2Z1UrLzZZMEhBM1Y1WERlZnBT?=
 =?utf-8?B?NHFhTU1HOENNZlQ0d2FpcTZLNXJRRzdOVndHQWR2a242cStuaUkzL09Sdlkv?=
 =?utf-8?B?eExsbFp3ZU1LdDhaSTZSbnNLVHhLU2o4MnZ0eGU4LzNqQXJDRlM2VFZuTjNW?=
 =?utf-8?B?blRJS3ZKMk5HRVVJOWMwM0FqYW1qU2lmMGQzNGlqZ2xJWFh0eHk0WDdVU1Qw?=
 =?utf-8?B?WUxmU29Oa1poa0d6bWZkT09ZRnlTZ241aWJ5aHZ2T0VVWjJOYjhpcFdPTllG?=
 =?utf-8?B?WmFqQWZmR05FU0hXRGFDcFRMcnkyYkNxdm9HUmVMVVZSUFRuVS85eWJKTmg4?=
 =?utf-8?B?YUxHaFhIQ0U1VnJZeEQxdnV3NVFVQnhNT1VYRDlEN2VqdzFsOXpmZjZsU3Zy?=
 =?utf-8?B?YnVZTWtZWU0xbXlsTThNZzlSc1dSUkloYWFuUXFmU1dGYVMxU3NsN2xQVGJ2?=
 =?utf-8?B?aEVMa095cUc2K2pKeUJmNjFnYS9oRnF0VWdtb25GVzJFNlJiVlkxbmNpVjVk?=
 =?utf-8?B?Q25RZjZZU2sxYVpDMHVJL3pucHhiYU5WVSt4S2RBem9JSWxyYnBpYUlTQXNq?=
 =?utf-8?B?R2dVWEtZc2tYRk40Vk91bFdrNzlpSmhXRGFVVGZVS2d0RlBFVk1MZjJ6NHBQ?=
 =?utf-8?B?SnpaZGk3UTl1Ymc1ZmZTTzJXSzVEOWo0eDIxWnkrZ1RlNGxpMjRUSmZONGFu?=
 =?utf-8?B?SitVbEkzbzhwN24yZGpXdTVhdnFBV283eWRoeVF5REtGME5ZSTdLNkdFeGR2?=
 =?utf-8?B?OTNSZk5md3RzZlM2RDZUd2REWnJLL2lrNzNmQ1UvTkV6S3RMVDl1ZDRwckVK?=
 =?utf-8?Q?qNKytNp3OckaP+m2aW3A4ex5Um4tkW1N4Xh1F9n?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3556d9-e92c-4c26-f2fd-08d8e2689126
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 19:30:01.1251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hfbx0yNGOP2zN+duv//+RjR5s2/UXfKtFz7Geax+vIOA4NauObnxDKwqjV9Qm5tkb2xLWXe8C0vJYcGHANczDhKn3laJfU1/oi/0TfudqKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1770
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>
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
From: Michael Kelley via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, March 8, 2021 11:14 AM
> 
> On 2/8/2021 11:45 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November
> 20, 2020 4:30 PM
> >>

[snip]

> >> @@ -245,16 +249,318 @@ hv_call_delete_partition(u64 partition_id)
> >>  	return -hv_status_to_errno(status);
> >>  }
> >>
> >> +static int
> >> +hv_call_map_gpa_pages(u64 partition_id,
> >> +		      u64 gpa_target,
> >> +		      u64 page_count, u32 flags,
> >> +		      struct page **pages)
> >> +{
> >> +	struct hv_map_gpa_pages *input_page;
> >> +	int status;
> >> +	int i;
> >> +	struct page **p;
> >> +	u32 completed = 0;
> >> +	u64 hypercall_status;
> >> +	unsigned long remaining = page_count;
> >> +	int rep_count;
> >> +	unsigned long irq_flags;
> >> +	int ret = 0;
> >> +
> >> +	while (remaining) {
> >> +
> >> +		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
> >> +
> >> +		local_irq_save(irq_flags);
> >> +		input_page = (struct hv_map_gpa_pages *)(*this_cpu_ptr(
> >> +			hyperv_pcpu_input_arg));
> >> +
> >> +		input_page->target_partition_id = partition_id;
> >> +		input_page->target_gpa_base = gpa_target;
> >> +		input_page->map_flags = flags;
> >> +
> >> +		for (i = 0, p = pages; i < rep_count; i++, p++)
> >> +			input_page->source_gpa_page_list[i] =
> >> +				page_to_pfn(*p) & HV_MAP_GPA_MASK;
> >
> > The masking seems a bit weird.  The mask allows for up to 64G page frames,
> > which is 256 Tbytes of total physical memory, which is probably the current
> > Hyper-V limit on memory size (48 bit physical address space, though 52 bit
> > physical address spaces are coming).  So the masking shouldn't ever be doing
> > anything.   And if it was doing something, that probably should be treated as
> > an error rather than simply dropping the high bits.
> 
> Good point - It looks like the mask isn't needed.
> 
> >
> > Note that this code does not handle the case where PAGE_SIZE !=
> > HV_HYP_PAGE_SIZE.  But maybe we'll never run the root partition with a
> > page size other than 4K.
> >
> 
> For now on x86 it won't happen, but maybe on ARM?
> It shouldn't be hard to support this case, especially since
> PAGE_SIZE >= HV_HYP_PAGE_SIZE. Do you think we need it in this patch set?

No, from my perspective, this case does not need to be handled in 
this patch set.

> 
> >> +		hypercall_status = hv_do_rep_hypercall(
> >> +			HVCALL_MAP_GPA_PAGES, rep_count, 0, input_page, NULL);
> >> +		local_irq_restore(irq_flags);
> >> +
> >> +		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
> >> +		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
> >> +				HV_HYPERCALL_REP_COMP_OFFSET;
> >> +
> >> +		if (status == HV_STATUS_INSUFFICIENT_MEMORY) {
> >> +			ret = hv_call_deposit_pages(NUMA_NO_NODE,
> >> +						    partition_id, 256);
> >
> > Why adding 256 pages?  I'm just contrasting with other places that add
> > 1 page at a time.  Maybe a comment to explain ....
> >
> 
> Empirically determined. I'll add a #define and comment.
> 
> >> +			if (ret)
> >> +				break;
> >> +		} else if (status != HV_STATUS_SUCCESS) {
> >> +			pr_err("%s: completed %llu out of %llu, %s\n",
> >> +			       __func__,
> >> +			       page_count - remaining, page_count,
> >> +			       hv_status_to_string(status));
> >> +			ret = -hv_status_to_errno(status);
> >> +			break;
> >> +		}
> >> +
> >> +		pages += completed;
> >> +		remaining -= completed;
> >> +		gpa_target += completed;
> >> +	}
> >> +
> >> +	if (ret && completed) {
> >
> > Is the above the right test?  Completed could be zero from the most
> > recent iteration, but still could be partially succeeded based on a previous
> > successful iteration.   I think this needs to check whether remaining equals
> > page_count.
> >
> 
> You're right; I'll change it to (ret && remaining < page_count)
> 
> >> +		pr_err("%s: Partially succeeded; mapped regions may be in invalid state",
> >> +		       __func__);
> >> +		ret = -EBADFD;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int
> >> +hv_call_unmap_gpa_pages(u64 partition_id,
> >> +			u64 gpa_target,
> >> +			u64 page_count, u32 flags)
> >> +{
> >> +	struct hv_unmap_gpa_pages *input_page;
> >> +	int status;
> >> +	int ret = 0;
> >> +	u32 completed = 0;
> >> +	u64 hypercall_status;
> >> +	unsigned long remaining = page_count;
> >> +	int rep_count;
> >> +	unsigned long irq_flags;
> >> +
> >> +	local_irq_save(irq_flags);
> >> +	input_page = (struct hv_unmap_gpa_pages *)(*this_cpu_ptr(
> >> +		hyperv_pcpu_input_arg));
> >> +
> >> +	input_page->target_partition_id = partition_id;
> >> +	input_page->target_gpa_base = gpa_target;
> >> +	input_page->unmap_flags = flags;
> >> +
> >> +	while (remaining) {
> >> +		rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
> >> +		hypercall_status = hv_do_rep_hypercall(
> >> +			HVCALL_UNMAP_GPA_PAGES, rep_count, 0, input_page, NULL);
> >
> > Similarly, this code doesn't handle PAGE_SIZE != HV_HYP_PAGE_SIZE.
> >
> 
> As above - do we need this for this patch set? This won't happen on x86.

Again, not needed from my perspective.

> 
> >> +		status = hypercall_status & HV_HYPERCALL_RESULT_MASK;
> >> +		completed = (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
> >> +				HV_HYPERCALL_REP_COMP_OFFSET;
> >> +		if (status != HV_STATUS_SUCCESS) {
> >> +			pr_err("%s: completed %llu out of %llu, %s\n",
> >> +			       __func__,
> >> +			       page_count - remaining, page_count,
> >> +			       hv_status_to_string(status));
> >> +			ret = -hv_status_to_errno(status);
> >> +			break;
> >> +		}
> >> +
> >> +		remaining -= completed;
> >> +		gpa_target += completed;
> >> +		input_page->target_gpa_base = gpa_target;
> >> +	}
> >> +	local_irq_restore(irq_flags);
> >
> > I have some concern about holding interrupts disabled for this long.
> >
> 
> How about I move the interrupt enabling/disabling inside the loop? i.e.:
>         while (remaining) {
>                 local_irq_save(irq_flags);
>                 input_page = (struct hv_unmap_gpa_pages *)(*this_cpu_ptr(
>                         hyperv_pcpu_input_arg));
> 
>                 input_page->target_partition_id = partition_id;
>                 input_page->target_gpa_base = gpa_target;
>                 input_page->unmap_flags = flags;
>                 rep_count = min(remaining, HV_MAP_GPA_BATCH_SIZE);
>                 status = hv_do_rep_hypercall(
>                         HVCALL_UNMAP_GPA_PAGES, rep_count, 0, input_page, NULL);
>                 local_irq_restore(irq_flags);
> 
>                 completed = (status & HV_HYPERCALL_REP_COMP_MASK) >>
>                                 HV_HYPERCALL_REP_COMP_OFFSET;
>                 status &= HV_HYPERCALL_RESULT_MASK;
>                 if (status != HV_STATUS_SUCCESS) {
>                         pr_err("%s: completed %llu out of %llu, %s\n",
>                                __func__,
>                                page_count - remaining, page_count,
>                                hv_status_to_string(status));
>                         ret = hv_status_to_errno(status);
>                         break;
>                 }
> 
>                 remaining -= completed;
>                 gpa_target += completed;
>         }
> 
> 

Yes, that would help.

> >> +
> >> +	if (ret && completed) {
> >
> > Same comment as before.
> >
> 
> Ditto as above.
> 
> >> +		pr_err("%s: Partially succeeded; mapped regions may be in invalid state",
> >> +		       __func__);
> >> +		ret = -EBADFD;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static long
> >> +mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
> >> +				struct mshv_user_mem_region __user *user_mem)
> >> +{
> >> +	struct mshv_user_mem_region mem;
> >> +	struct mshv_mem_region *region;
> >> +	int completed;
> >> +	unsigned long remaining, batch_size;
> >> +	int i;
> >> +	struct page **pages;
> >> +	u64 page_count, user_start, user_end, gpfn_start, gpfn_end;
> >> +	u64 region_page_count, region_user_start, region_user_end;
> >> +	u64 region_gpfn_start, region_gpfn_end;
> >> +	long ret = 0;
> >> +
> >> +	/* Check we have enough slots*/
> >> +	if (partition->regions.count == MSHV_MAX_MEM_REGIONS) {
> >> +		pr_err("%s: not enough memory region slots\n", __func__);
> >> +		return -ENOSPC;
> >> +	}
> >> +
> >> +	if (copy_from_user(&mem, user_mem, sizeof(mem)))
> >> +		return -EFAULT;
> >> +
> >> +	if (!mem.size ||
> >> +	    mem.size & (PAGE_SIZE - 1) ||
> >> +	    mem.userspace_addr & (PAGE_SIZE - 1) ||
> >
> > There's a PAGE_ALIGNED macro that expresses exactly what
> > each of the previous two tests is doing.
> >
> 
> Since these need to be HV_HYP_PAGE_SIZE aligned, I will add a
> HV_HYP_PAGE_ALIGNED macro for this.

I was thinking that PAGE_SIZE and PAGE_ALIGNED are correct.   If
this code were running on an ARM64 system with a 64K page
size, the 64K alignment would be fine and will make sense from
the user space perspective.   You don't want to be mapping part
of a user space page.  And 64K alignment will certainly satisfy
Hyper-V's requirement for 4K alignment.  The real requirement
from Hyper-V's standpoint is that the alignment not be smaller
than 4K.  But maybe I'm misunderstanding.

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
