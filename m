Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D09C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:43:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D55064E27
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D55064E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2F60E85F57;
	Mon,  8 Feb 2021 19:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91S-L1Yiepyf; Mon,  8 Feb 2021 19:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2320E85F55;
	Mon,  8 Feb 2021 19:43:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12494C0174;
	Mon,  8 Feb 2021 19:43:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D438C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3902686542
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvFknfLh45Oe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C72E4864CF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIjVxqtP39Md31+h64OFnW43hePIJiVytFsmhr1dXlmJ5dBLcZYCZknb/ERyXWtar5KP8id2uoI656JRyE9w2VSpBFwdMDELwprZy3kAjXelZSxuhP40eqsg7dh6KIT+/A+4BdlGb7OMEvY+MfF3D57UDVCWwxZM1c/YnJrsI8ZazUk1pIMEiM97KhlV8ciR5Zy9hHrEk3FDdREQp9CS94K6le6YTHUF0zg55G/3PoW7kdG9B/UmISZ1///beErctZKfBKEcFEsjUumOoR/fbJR6r1CYqcbDdqJXOXRbh+5dZDVOc40pBG/M3933NqD8oIadpOkskkZaQFWaIhJj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UikcrzWhKuBqt7651znlZD1ZYw1+VXaAZ6mClHDvycE=;
 b=n5PjH9VUAR8SZyYWiN3VWUlY69tdUu2qAuyxaacs8tm1etxMznCo6fAW92G8vuSGto3SE8smAhsEIcCM48cz3+kgYNYpYIhxQwua7fbGrImQru6qrs5UExq3jz6Uw0UZ5kX6t+aoyaLlZVLIxDCFgC072r5qCUAj5wq04tQ4Atr2XbwFLBZKMcOcbn0ctkcNBAslhuuW30zM/eix/61mbX0ak6+qDjvT/Q05wNnRfuprVuuZHa9lUz9oBhzhoKoUHxfl8AAJwGuqOQUIAN7fGz6/OhH+QFSVAcrCSfT/wiItDdyNI6kG/SNw9b8XaTDqAe+n7VqygsBY+XeFP4oR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UikcrzWhKuBqt7651znlZD1ZYw1+VXaAZ6mClHDvycE=;
 b=A28pkI8LKf6SN7uJjiDljICAU/DjSLi5zb7zGxDnblzHVEHbh4YwFeY2FEbhY0cGSWXaDR2nqg2NteCJb55mSkdq4gAWXGC6eF75JkMHxwgEHZZC3JLWCxQuYMJ207g3CJYNAUy4/gWn/GToFq1NST+6do/hG3oGAs/NAd4ZKFQ=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1066.namprd21.prod.outlook.com (2603:10b6:302:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.5; Mon, 8 Feb
 2021 19:42:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:42:15 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize, delete
 partition hypercalls
Thread-Topic: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize,
 delete partition hypercalls
Thread-Index: AQHWv52RO39n9Z5WhEuKJPNiXbM1XKpL8Tdw
Date: Mon, 8 Feb 2021 19:42:14 +0000
Message-ID: <MWHPR21MB1593518130E3E0532894C516D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-7-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-7-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:42:11Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4396d454-b3ee-4610-bea8-7892fb4f616b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2c03f04-9aef-4722-a336-08d8cc69a2f6
x-ms-traffictypediagnostic: MW2PR2101MB1066:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10661D23774B8FE824FB5178D78F9@MW2PR2101MB1066.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0712jImLRIS0p3FGiz8rOjhg9YuTqKXMfVhI0jFBbwo+gGSp5pOlVoh4wNHo11jTi0N0vTvOxb2t5c08hKsHkd+kydoCQwxoPh2p9kzQHLKxVDu+AqR0ovHgqjCOGI7nMFUlwd21Fiz+ZOj0Kn9UrnyFm7ONPO4/Sr2m/6FwTdKS6Q1PoRh23ZUrjDvn59dPeYmeEGp3qI2mLBJZLevSl3EqkmVeXYfbaIaHmmGMkjDOGiuy3+KPQGcDer1IL+MyGN/1Zx6mOR4DGeWItCUYbdJbGSw/i1mWF3sG7ITbTxyQWmzmvUYb/58XeimXrR7/qT2TugS4DXaXP8V2Iudvc8636oarfLsEGbJR0gaZGYcn8VN9wIq06H5dVlI96s76z8+ho7zbKkvUfHMkarx1TixQEWrSEvG1jF4NprudIcLAFam2Qw4cOPmt20p9KEMH8sDRQMUQWI7bWG8ybYi2CgVcqth3sms4kzGu1+8X5rNucdNQb4FKR305oj2F28irl6/XL7hwqXS2zAtRBPMinQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(76116006)(8990500004)(10290500003)(82960400001)(33656002)(9686003)(110136005)(64756008)(8676002)(83380400001)(4326008)(2906002)(316002)(52536014)(7696005)(66556008)(30864003)(86362001)(186003)(8936002)(66446008)(55016002)(478600001)(6506007)(5660300002)(66476007)(71200400001)(26005)(54906003)(82950400001)(107886003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XWn2IjHL4aZCHx4Xs+QvAUSaPNuaBujVv9kBDaJRUzkS8ksj7mV+gUEfUiJJ?=
 =?us-ascii?Q?/Vf6t1RuWbm4viK3VquawWikueyS953qTaVUUa7Y3B+DSjaOZ5di5uKt2P7o?=
 =?us-ascii?Q?yEaQf6aEoi9sKzT8+ECuuOOf3AQTaVRpRT+jSVr/AvTIorxfm9LrgZYrhWcz?=
 =?us-ascii?Q?QWFUN38H0YlfxxYrxzp/stiFcJ1yxJBPx/mG5LCDY+IyB3/eV4kpWdRI81+F?=
 =?us-ascii?Q?8l3p0WtNTy51Ua3OBiMTYvuLR951oNFFet0iKTrWf+fVyvCQLdkBQY/lGhIH?=
 =?us-ascii?Q?W02Uj1PC+C/HSa6x55VhzoIC5bhqqkb/O7SvjzxaKxs1kRiRPJgLwPf7+KJF?=
 =?us-ascii?Q?OfQaVWm4eBDgzTGlOw3T1bZWHYQQHbzD0rSBuj30ZylyMVPujsx5rhlZtNBf?=
 =?us-ascii?Q?bE3Hfv3n9CW2MALMG+5OAOqLGErd/8vwsDhxUjCPAq/XnkhHjA5uRgy5AQxR?=
 =?us-ascii?Q?Z+4jonplig816YylRRM1WzvJc/ThA71kD9zTdqCFEAtdiPeb/Z/gcss9Exxx?=
 =?us-ascii?Q?YaReBc2oVgXI/apAehJ3lnYp8EwwI1Ou6iJUj7zSwBlyjcJ/KdMt62Y/niXz?=
 =?us-ascii?Q?CEVcGapXkNz7NFyc1Z2hRtn4FNK+XI5zEokVI4HE8Vb02bckuibHRJ/QABfp?=
 =?us-ascii?Q?LA4IHHgGaOImVjtinpjlbYLQ4sjAD+hoLBbIQLEYVOLUF8Nik7LV125YeSMA?=
 =?us-ascii?Q?E12pydr6XWeUGOCULIGwfhe8aR5fljsC7QjsO+tNjw0U44rB9n0hZCuftew2?=
 =?us-ascii?Q?ReiE0Xj1HwUByVTOuSmrQPMAiAJVs+cJwrZgrrWTJLseEdfhBxjdJeGv+N1K?=
 =?us-ascii?Q?cMrvZVjHrHWnWcMY64wdu5zdtdZkbkq7FOZTXtwop56a7Yeixey1fWImvzq5?=
 =?us-ascii?Q?NSaPQoZ0HwjHyMUhHqRQacAcvxQZWcw3weRPbLnPsc+Wqb6/OeqdBsWHo7ON?=
 =?us-ascii?Q?sKCEpDa3F9EUXxY3pWwsgQpG+WbZKtBvQxeeo5r6ILW5lPRPWQ1sxV4dW5vA?=
 =?us-ascii?Q?MED5pKTcUFkKzY1pvGiYh05XWYzlou5xSSIKwMg4fdN3nohyfM9uSArREp1m?=
 =?us-ascii?Q?VqbpqAWE8b1roHiHgfExpBXsQPbQc4Tjb1xkHHk1IbtK0MpwoxHN7XLju0Fb?=
 =?us-ascii?Q?4lnn//cHnr8XA9lHi1XiSr5g5xU0OJN9vVQf+p3aYNqSx9Vgm0cjNDy00/cW?=
 =?us-ascii?Q?UqJfNf4lAG/r/33EFgB9D5IA0tI2PHtLD6EbAKIHlonERk0gv68QxRCRaAh5?=
 =?us-ascii?Q?CoUDBp+S7ZZn63vjoeN2jdgm4IgQ5bG25tps5g5nOvffLiYJCkQGIwlFFGS6?=
 =?us-ascii?Q?Scih14qtHsr4GCCmaMsiJ83V?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c03f04-9aef-4722-a336-08d8cc69a2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:42:14.9440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJQksYse70KdPoUsj7HgMDnxTbIMpKy9816bwUmyt8ApRgnTQZmg7SptJRt746tBR4/I+S7AToasy/uWVASSWV+CM3t8A148ypOKPsmDAXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1066
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

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:30 PM
> 
> Add hypercalls for fully setting up and mostly tearing down a guest
> partition.
> The teardown operation will generate an error as the deposited
> memory has not been withdrawn.
> This is fixed in the next patch.
> 
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h      |  52 +++++++-
>  include/uapi/asm-generic/hyperv-tlfs.h |   1 +
>  include/uapi/linux/mshv.h              |   1 +
>  virt/mshv/mshv_main.c                  | 169 ++++++++++++++++++++++++-
>  4 files changed, 220 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 2ff580780ce4..ab6ae6c164f5 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -142,6 +142,10 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_CREATE_PARTITION			0x0040
> +#define HVCALL_INITIALIZE_PARTITION		0x0041
> +#define HVCALL_FINALIZE_PARTITION		0x0042
> +#define HVCALL_DELETE_PARTITION			0x0043
>  #define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_DEPOSIT_MEMORY			0x0048
>  #define HVCALL_CREATE_VP			0x004e
> @@ -451,7 +455,7 @@ struct hv_get_partition_id {
>  struct hv_deposit_memory {
>  	u64 partition_id;
>  	u64 gpa_page_list[];
> -} __packed;
> +};

Why remove __packed?

> 
>  struct hv_proximity_domain_flags {
>  	u32 proximity_preferred : 1;
> @@ -767,4 +771,50 @@ struct hv_input_unmap_device_interrupt {
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
> 
> +#define HV_MAKE_COMPATIBILITY_VERSION(major_, minor_)                          \
> +	((u32)((major_) << 8 | (minor_)))
> +
> +enum hv_compatibility_version {
> +	HV_COMPATIBILITY_19_H1 = HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X5),
> +	HV_COMPATIBILITY_MANGANESE = HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X7),

Avoid use of "Manganese", which is an internal code name.  I'd suggest calling it
20_H1 instead, which at least has some broader meaning.

> +	HV_COMPATIBILITY_PRERELEASE = HV_MAKE_COMPATIBILITY_VERSION(0XFE, 0X0),
> +	HV_COMPATIBILITY_EXPERIMENT = HV_MAKE_COMPATIBILITY_VERSION(0XFF, 0X0),
> +};
> +
> +union hv_partition_isolation_properties {
> +	u64 as_uint64;
> +	struct {
> +		u64 isolation_type: 5;
> +		u64 rsvd_z: 7;
> +		u64 shared_gpa_boundary_page_number: 52;
> +	};
> +};

Add __packed.

> +
> +/* Non-userspace-visible partition creation flags */
> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(8)
> +
> +struct hv_create_partition_in {
> +	u64 flags;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	enum hv_compatibility_version compatibility_version;

An "enum" is a 32 bit value in gcc and I would presume that
Hyper-V is expecting a 64 bit value.  In general, using an enum in a data
structure with exact layout requirements is problematic because the "C"
language doesn't specify how big an enum is.  In such cases, it's better
to use an integer field with an explicit size (like u64) and #defines for
the possible values.

> +	struct hv_partition_creation_properties partition_creation_properties;
> +	union hv_partition_isolation_properties isolation_properties;
> +};
> +
> +struct hv_create_partition_out {
> +	u64 partition_id;
> +};
> +
> +struct hv_initialize_partition {
> +	u64 partition_id;
> +};
> +
> +struct hv_finalize_partition {
> +	u64 partition_id;
> +};
> +
> +struct hv_delete_partition {
> +	u64 partition_id;
> +};

All of the above should have __packed for consistency with the other
Hyper-V data structures.

> +
>  #endif
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-
> tlfs.h
> index 140cc0b4f98f..7a858226a9c5 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -6,6 +6,7 @@
>  #define BIT(X)	(1ULL << (X))
>  #endif
> 
> +/* Userspace-visible partition creation flags */

Could this comment be included in the earlier patch with the #defines so
that you avoid the trivial change here?

>  #define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(0)
>  #define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(3)
>  #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED          BIT(4)
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 3788f8bc5caa..4f8da9a6fde2 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -9,6 +9,7 @@
> 
>  #include <linux/types.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <asm-generic/hyperv-tlfs.h>

Similarly, consider adding this #include in the earlier patch so that
this trivial change isn't needed here.

> 
>  #define MSHV_VERSION	0x0
> 
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index 4dcbe4907430..c4130a6508e5 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -15,6 +15,7 @@
>  #include <linux/file.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/mshv.h>
> +#include <asm/mshyperv.h>
> 
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
> @@ -31,7 +32,6 @@ static struct mshv mshv = {};
>  static void mshv_partition_put(struct mshv_partition *partition);
>  static int mshv_partition_release(struct inode *inode, struct file *filp);
>  static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
> -

Spurious whitespace change?

>  static int mshv_dev_open(struct inode *inode, struct file *filp);
>  static int mshv_dev_release(struct inode *inode, struct file *filp);
>  static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
> @@ -57,6 +57,143 @@ static struct miscdevice mshv_dev = {
>  	.mode = 600,
>  };
> 
> +#define HV_INIT_PARTITION_DEPOSIT_PAGES 208

A comment about how this value is determined would be useful.
I'm assuming it was determined empirically.

> +
> +static int
> +hv_call_create_partition(
> +		u64 flags,
> +		struct hv_partition_creation_properties creation_properties,
> +		u64 *partition_id)
> +{
> +	struct hv_create_partition_in *input;
> +	struct hv_create_partition_out *output;
> +	int status;
> +	int ret;
> +	unsigned long irq_flags;
> +	int i;
> +
> +	do {
> +		local_irq_save(irq_flags);
> +		input = (struct hv_create_partition_in *)(*this_cpu_ptr(
> +			hyperv_pcpu_input_arg));
> +		output = (struct hv_create_partition_out *)(*this_cpu_ptr(
> +			hyperv_pcpu_output_arg));
> +
> +		input->flags = flags;
> +		input->proximity_domain_info.as_uint64 = 0;
> +		input->compatibility_version = HV_COMPATIBILITY_MANGANESE;
> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURE_BANKS; ++i)
> +			input->partition_creation_properties
> +				.disabled_processor_features.as_uint64[i] = 0;
> +		input->partition_creation_properties
> +			.disabled_processor_xsave_features.as_uint64 = 0;
> +		input->isolation_properties.as_uint64 = 0;
> +
> +		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
> +					 input, output);

hv_do_hypercall returns a u64, which should then be masked with
HV_HYPERCALL_RESULT_MASK before checking the result.

> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status == HV_STATUS_SUCCESS)
> +				*partition_id = output->partition_id;
> +			else
> +				pr_err("%s: %s\n",
> +				       __func__, hv_status_to_string(status));
> +			local_irq_restore(irq_flags);
> +			ret = -hv_status_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(irq_flags);
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static int
> +hv_call_initialize_partition(u64 partition_id)
> +{
> +	struct hv_initialize_partition *input;
> +	int status;
> +	int ret;
> +	unsigned long flags;
> +
> +	ret = hv_call_deposit_pages(
> +				NUMA_NO_NODE,
> +				partition_id,
> +				HV_INIT_PARTITION_DEPOSIT_PAGES);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = (struct hv_initialize_partition *)(*this_cpu_ptr(
> +			hyperv_pcpu_input_arg));
> +		input->partition_id = partition_id;
> +
> +		status = hv_do_hypercall(
> +				HVCALL_INITIALIZE_PARTITION,
> +				input, NULL);

FWIW, since the input is a single 64 bit value, and there's no output,
this could use hv_do_fast_hypercall8() instead, and avoid
needing to use the input arg page and the irq save/restore.  Would have
to check that the particular hypercall supports the "fast" version.

> +		local_irq_restore(flags);
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {

Same comment about status being u64 and masking.

> +			if (status != HV_STATUS_SUCCESS)
> +				pr_err("%s: %s\n",
> +				       __func__, hv_status_to_string(status));
> +			ret = -hv_status_to_errno(status);
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static int
> +hv_call_finalize_partition(u64 partition_id)
> +{
> +	struct hv_finalize_partition *input;
> +	int status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input = (struct hv_finalize_partition *)(*this_cpu_ptr(
> +		hyperv_pcpu_input_arg));
> +
> +	input->partition_id = partition_id;
> +	status = hv_do_hypercall(
> +			HVCALL_FINALIZE_PARTITION,
> +			input, NULL);
> +	local_irq_restore(flags);


Same comment about hv_do_fast_hypercall8() and about status
being a u64 and masking.

> +
> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +
> +	return -hv_status_to_errno(status);
> +}
> +
> +static int
> +hv_call_delete_partition(u64 partition_id)
> +{
> +	struct hv_delete_partition *input;
> +	int status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input = (struct hv_delete_partition *)(*this_cpu_ptr(
> +		hyperv_pcpu_input_arg));
> +
> +	input->partition_id = partition_id;
> +	status = hv_do_hypercall(
> +			HVCALL_DELETE_PARTITION,
> +			input, NULL);
> +	local_irq_restore(flags);

Same comments about hv_do_fast_hypercall8(), and
the status and masking.

> +
> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +
> +	return -hv_status_to_errno(status);
> +}
> +
>  static long
>  mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  {
> @@ -86,6 +223,17 @@ destroy_partition(struct mshv_partition *partition)
> 
>  	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
> 
> +	/*
> +	 * There are no remaining references to the partition or vps,
> +	 * so the remaining cleanup can be lockless
> +	 */
> +
> +	/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
> +	hv_call_finalize_partition(partition->id);
> +	/* TODO: Withdraw and free all pages we deposited */
> +
> +	hv_call_delete_partition(partition->id);
> +
>  	kfree(partition);
>  }
> 
> @@ -146,6 +294,9 @@ mshv_ioctl_create_partition(void __user *user_arg)
>  	if (copy_from_user(&args, user_arg, sizeof(args)))
>  		return -EFAULT;
> 
> +	/* Only support EXO partitions */
> +	args.flags |= HV_PARTITION_CREATION_FLAG_EXO_PARTITION;
> +
>  	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
>  	if (!partition)
>  		return -ENOMEM;
> @@ -156,11 +307,21 @@ mshv_ioctl_create_partition(void __user *user_arg)
>  		goto free_partition;
>  	}
> 
> +	ret = hv_call_create_partition(args.flags,
> +				       args.partition_creation_properties,
> +				       &partition->id);
> +	if (ret)
> +		goto put_fd;
> +
> +	ret = hv_call_initialize_partition(partition->id);
> +	if (ret)
> +		goto delete_partition;
> +
>  	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
>  				  partition, O_RDWR);
>  	if (IS_ERR(file)) {
>  		ret = PTR_ERR(file);
> -		goto put_fd;
> +		goto finalize_partition;
>  	}
>  	refcount_set(&partition->ref_count, 1);
> 
> @@ -174,6 +335,10 @@ mshv_ioctl_create_partition(void __user *user_arg)
> 
>  release_file:
>  	file->f_op->release(file->f_inode, file);
> +finalize_partition:
> +	hv_call_finalize_partition(partition->id);
> +delete_partition:
> +	hv_call_delete_partition(partition->id);
>  put_fd:
>  	put_unused_fd(fd);
>  free_partition:
> --
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
