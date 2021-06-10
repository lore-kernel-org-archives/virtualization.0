Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF23C48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:22:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D294A6141F
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D294A6141F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E05F83D37;
	Thu, 10 Jun 2021 18:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAzrGxDNjr5X; Thu, 10 Jun 2021 18:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A19E83D61;
	Thu, 10 Jun 2021 18:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A67C000E;
	Thu, 10 Jun 2021 18:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28A60C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0376240494
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwKah5LKR-IR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:22:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2091.outbound.protection.outlook.com [40.107.101.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8D06402A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW/Uqy0bsqIYVPdY/cicB8K3qJSu+khx8VU7jXxKkSu5g2LYKY0+bpV3lazy8FIWHkaqIRIeHD7fsHWpkpqw0qAXAXVppaFBqCeNqTFmaa1Mi0P05KAnK/nq4uRgQlkKLJQ7Bk0B0DMd3P/U3XI1XFUa2Z9UKaF/6qaEG7OxfKvgejRq/sh7akyX6yZ7LgYZMv3Cakzys0yuGDyuSNb3+v2mmk8D9c+EhBUM8n/MnFm7jjGo+q0ZqrIxVnJWWG15HDX5bhiYD413QOop2r2Xd22f9dzkrP1O/gy2rs8mvr3Pvm1Amt2xAKPEwTR6pDAjwE5DtFQt9DSO4/TpJbGejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwUUylnNa6ereuV8BlegMzNl/oU85OmmhDrKlyNZflc=;
 b=Pn3UUP1bE0QHuzAJhpPtgtkWRRbvJtFixrZlgtUUbrAcds0Kng114lyWKwh1qF70qarCRFCErqTDvxFX27xLkvCPvKOzNSENJXq2kSgF7oU2xfZE6teYB3Z8CfrI9GqxYbAxjPNR12/7faiMonCe+pEsukFVTDSxc+t3ceBh/B9ipJ56nYBczbu/bgYHlvBdl3Q4/Tem6eeBwJMdNowAKLfX3M5/eYLUGDtgylVoGJ1IbR8krag0lc756E54bM+/a5WCucRDNmvPUs3WIgOt7DuEo/Lc0/umM3fojzn9E1386k+9gz9SG/evLE1b4AuUTbez7qpi9MetcZjOg5634A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwUUylnNa6ereuV8BlegMzNl/oU85OmmhDrKlyNZflc=;
 b=Y00E9v6bYn0rYsOPGnjUSiPMFSFmUXBEmblZK2hJg2C/GGeis4IKp9UVO0NNNlNo49Mc08jwED+ik4Fgg0g3GeeQD/pTCZXNsIMAxsZ8HqnYlZcYf160AJW3JUeGz8V9bRN/o6j2jXEbbM+T4nE1HdbAp36qtxQAm+LydcXRdhs=
Received: from MW4PR21MB2004.namprd21.prod.outlook.com (2603:10b6:303:68::24)
 by MWHPR21MB0509.namprd21.prod.outlook.com (2603:10b6:300:df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.5; Thu, 10 Jun
 2021 18:22:06 +0000
Received: from MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::b086:5b59:c7f1:8723]) by MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::b086:5b59:c7f1:8723%9]) with mapi id 15.20.4242.008; Thu, 10 Jun 2021
 18:22:06 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/19] x86/hyperv: convert hyperv statuses to linux error
 codes
Thread-Topic: [PATCH 01/19] x86/hyperv: convert hyperv statuses to linux error
 codes
Thread-Index: AQHXVBLrzSHkHy8Ms0G5Qpvlaqm0lqsNn6Ag
Date: Thu, 10 Jun 2021 18:22:05 +0000
Message-ID: <MW4PR21MB200424DC6ACC9EAF84A56D81C0359@MW4PR21MB2004.namprd21.prod.outlook.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1622241819-21155-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6679acee-d651-4bd1-158d-08d92c3ca6f3
x-ms-traffictypediagnostic: MWHPR21MB0509:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0509C57D542FBFEF21A8CBA0C0359@MWHPR21MB0509.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:206;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKbs02Uhc6QzJ4Q6htrxmlDMXvtc4Vd9ZlwvcslelxFP/KvIa7nDOFw3Nqcb7UI6m4wLl1aF1uLhAgsODOjACMrqK3SRdziaLLF1mgaiDHW/XIvSHSs+uwVygOkSvGtVPmFAg9dev2DCfKdS5v502NcWVaeIdUSYk+KjEDRsi45WGGC/Y5NulEm7cZcMfdQ1GK5/Z6duDZvslR4GoKN0aRqHfggfpkY3HScheQ2nBSvuF89wGTcfkpJ8PYIoIll8LvRVimgsONVLRHPGhV6OC6QwOdmZ5ylLef/P7mw/h2D0uVb7dr0dPeu0fu6bJaB5NjZobqdE+EqwXCBcV5l4/vES1QH6YXjAqlODorfNteuHmGSWm6zmzBielpNZlInuIquIDol71Wo+5Q+u/vjHJ/mgBDX0hIYyiZ0k96oPZRY/4kNnEPeEAR/d3ubQ69CT9llO0roXFCLKuGdzFrqiovmCljkZ5ohlZ2LnFTYntuTdeiIV+vZ8bOfzmv9N31wPZ2RLNdY5Tp41g8ex5UXrvz1Bpw0SDq9Azy/fs2aL/blAhE43QIDZZAYHel1MRbWMh9rr4NzvyhSD3qmuIPZiPdxIPU4Xiq/mrEUCQMuegnZ1Vd8RFEzN8T/g+o+2T4Cz7K3HqI1qMXiXe3NbsnS+ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR21MB2004.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8990500004)(316002)(53546011)(8936002)(5660300002)(107886003)(82960400001)(82950400001)(7696005)(186003)(4326008)(8676002)(66476007)(83380400001)(66556008)(66946007)(64756008)(66446008)(76116006)(54906003)(33656002)(71200400001)(478600001)(122000001)(10290500003)(38100700002)(110136005)(86362001)(2906002)(6506007)(52536014)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bsvqCBrWWL4xptcy1xIL3Kf4zGjpSKTXwjaCD3QOARoxdi/vCk6Z+HmsmKli?=
 =?us-ascii?Q?s/d813JSnkAAXY0FQR9MW3nzPvulj7B6adzTtUSdCk25k7p2hQkoHf7oEX0c?=
 =?us-ascii?Q?A4djVHUYY+6tOSvuBqL/M2SrChmBCJDo7FIeLhVGdzyIfw1xbXn7QoLygvE2?=
 =?us-ascii?Q?lDM85Fdf2+rZ6cP40wek4IGtAg4Az1Bspkjp2lyL6SCBw/M6eQt8AgH8y2Ow?=
 =?us-ascii?Q?I1ogsmo48h2zsSPe5os1vlF1R23cv3pQJMWvGqmwuhJ7kzF0IQus98rOgPEL?=
 =?us-ascii?Q?oxd2fFUmwxJPrFsk1chq1oUZWQzjpQ5Ii1xiC2Ixa/LtN1dVQrOXx7oMtqcS?=
 =?us-ascii?Q?mAA7WquEXVbcQ4mh4Iw1UYYMhXAKWUwRXeOMcgdEpGsNgZ78N8Zj71m+JIcb?=
 =?us-ascii?Q?Mf6GmjnvLd80GpqMDDIBk7AKqT+YJTNEf0znYVzitCeISUbjGTeMVgqyuqPH?=
 =?us-ascii?Q?yATw67Kn6jgbr9lXs3YrM6GaNi68Wfj39Xk3N3Qfk1h4Ye8jETQv5FheRUjV?=
 =?us-ascii?Q?DkbYT0CTx0u6lFBYeX0ARM3LOrTZFcWQYEK0AHmbyR42w0IhX42Z0/03XnzO?=
 =?us-ascii?Q?RtWet4ADdrOZH0wip1KYPCzHtsi4NjY6xTu3NDOldPd3HQk/J6TZ1rF3CCFH?=
 =?us-ascii?Q?TyiXlvButx5ca9d3zNJWOHOM69jfdQe2yEQRVRTfCETmIdodh6bh8hqLTRjr?=
 =?us-ascii?Q?WN6kryHu6La0WrykEy0FmlWw1EZo80KJwwpy+Q3HMLbfvzyAsr3fK8v94B3M?=
 =?us-ascii?Q?wYNLq3pkDBgy1FBL1lGOFE6DEFoDASpJSUpsiNPgsRXrlqJxg9LMJSTr314/?=
 =?us-ascii?Q?N3PMq2r6f1DPBwdq4Ufqvy3yd6mpZxyNVNuSvj4ic7v5tX/ONOHudQq5w5mD?=
 =?us-ascii?Q?MRLgjta3jrQdN/yxuAAPJNjl7SOIDifqTTkSB6x4Ftodq7e7DHlVl3jDtmiN?=
 =?us-ascii?Q?1HYkbUmNh/teFmgS31NtPIFNVnNopbOUlvNHirinGiYySflLLU2XKEKeN8hs?=
 =?us-ascii?Q?yE1pqp+XAkQDLIfTxg0enL8TZINjGBMp39p00rOrQMNDr4VkW/UMd5iGNa9l?=
 =?us-ascii?Q?WNxLSksf+Wo+qm0Q8CtOSyUhxvfFnRQKfGLDZzJyQLZR8RGi++UGfGwUpebi?=
 =?us-ascii?Q?xihmfZjHuF8XpI75RFe18CZa4M6m3uBWDn3NzNywP1PsEltaJtO3TrFhfve0?=
 =?us-ascii?Q?AmNdP+QwpFx7ozUTkMxR1zy0VBGNfs4rzgND6n86sAvfS6ajlV5DhQ8Xb0Ub?=
 =?us-ascii?Q?RtM89nF1knvj2cRZ5LUscf5Whgl5ksFWgjHY4iE4XAPTPj+1lXTijmxAXHyQ?=
 =?us-ascii?Q?YLVb+ehvd47xYimmz8WrKLg6zJ/Gnehm0cNRfCc2oyOawX/8qlwV3B8Pqujz?=
 =?us-ascii?Q?OZh1X7UzjbCi+Qh92rJtTTlbUndS?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2004.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6679acee-d651-4bd1-158d-08d92c3ca6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 18:22:05.8661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnvpvAPpoDYEq3pQQ8k5ycZSqfBbWKNcf7FS9GYNolysQFfdtJhWe2bEbN80lYUt5KtKvmyc51gjf+2O7td41rggsdrsErNVoOwgMFAOgu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0509
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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
From: Sunil Muthuswamy via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> -----Original Message-----
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Sent: Friday, May 28, 2021 3:43 PM
> To: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org; Michael Kelley <mikelley@microsoft.com>; viremana@linux.microsoft.com; Sunil
> Muthuswamy <sunilmut@microsoft.com>; wei.liu@kernel.org; vkuznets <vkuznets@redhat.com>; Lillian Grassin-Drake
> <Lillian.GrassinDrake@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 01/19] x86/hyperv: convert hyperv statuses to linux error codes
> 
> Return linux-friendly error codes from hypercall wrapper functions.
> This will be needed in the mshv module.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h   |  1 +
>  include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
>  3 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 68a0843d4750..59cf9a9e0975 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -14,6 +14,30 @@
> 
>  #include <asm/trace/hyperv.h>
> 
> +int hv_status_to_errno(u64 hv_status)
> +{
> +	switch (hv_result(hv_status)) {
> +	case HV_STATUS_SUCCESS:
> +		return 0;
> +	case HV_STATUS_INVALID_PARAMETER:
> +	case HV_STATUS_UNKNOWN_PROPERTY:
> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
> +	case HV_STATUS_INVALID_VP_INDEX:
> +	case HV_STATUS_INVALID_REGISTER_VALUE:
> +	case HV_STATUS_INVALID_LP_INDEX:
> +		return -EINVAL;
> +	case HV_STATUS_ACCESS_DENIED:
> +	case HV_STATUS_OPERATION_DENIED:
> +		return -EACCES;
> +	case HV_STATUS_NOT_ACKNOWLEDGED:
> +	case HV_STATUS_INVALID_VP_STATE:
> +	case HV_STATUS_INVALID_PARTITION_STATE:
> +		return -EBADFD;
> +	}
> +	return -ENOTRECOVERABLE;
> +}
> +EXPORT_SYMBOL_GPL(hv_status_to_errno);
> +
>  /*
>   * See struct hv_deposit_memory. The first u64 is partition ID, the rest
>   * are GPAs.
> @@ -94,7 +118,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  	local_irq_restore(flags);
>  	if (!hv_result_success(status)) {
>  		pr_err("Failed to deposit pages: %lld\n", status);
> -		ret = hv_result(status);
> +		ret = hv_status_to_errno(status);
>  		goto err_free_allocations;
>  	}
> 
> @@ -150,7 +174,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  			if (!hv_result_success(status)) {
>  				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
>  				       lp_index, apic_id, status);
> -				ret = hv_result(status);
> +				ret = hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> @@ -200,7 +224,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  			if (!hv_result_success(status)) {
>  				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
>  				       vp_index, flags, status);
> -				ret = hv_result(status);
> +				ret = hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 67ff0d637e55..c6eb01f3864d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -169,6 +169,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
>  int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
> +int hv_status_to_errno(u64 hv_status);
> 
>  extern bool hv_root_partition;
> 
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 515c3fb06ab3..fe6d41d0b114 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -189,16 +189,28 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
> 
>  /* hypercall status code */
> -#define HV_STATUS_SUCCESS			0
> -#define HV_STATUS_INVALID_HYPERCALL_CODE	2
> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
> -#define HV_STATUS_INVALID_ALIGNMENT		4
> -#define HV_STATUS_INVALID_PARAMETER		5
> -#define HV_STATUS_OPERATION_DENIED		8
> -#define HV_STATUS_INSUFFICIENT_MEMORY		11
> -#define HV_STATUS_INVALID_PORT_ID		17
> -#define HV_STATUS_INVALID_CONNECTION_ID		18
> -#define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_SUCCESS			0x0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
> +#define HV_STATUS_INVALID_ALIGNMENT		0x4
> +#define HV_STATUS_INVALID_PARAMETER		0x5
> +#define HV_STATUS_ACCESS_DENIED			0x6
> +#define HV_STATUS_INVALID_PARTITION_STATE	0x7
> +#define HV_STATUS_OPERATION_DENIED		0x8
> +#define HV_STATUS_UNKNOWN_PROPERTY		0x9
> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
> +#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
> +#define HV_STATUS_INVALID_PARTITION_ID		0xD
> +#define HV_STATUS_INVALID_VP_INDEX		0xE
> +#define HV_STATUS_NOT_FOUND			0x10
> +#define HV_STATUS_INVALID_PORT_ID		0x11
> +#define HV_STATUS_INVALID_CONNECTION_ID		0x12
> +#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
> +#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
> +#define HV_STATUS_INVALID_VP_STATE		0x15
> +#define HV_STATUS_NO_RESOURCES			0x1D
> +#define HV_STATUS_INVALID_LP_INDEX		0x41
> +#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
> 
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> --
> 2.25.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
