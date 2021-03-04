Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBFCC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 23:59:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC06664FFD
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 23:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC06664FFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 606FD83760;
	Thu,  4 Mar 2021 23:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2ol8UQSOltv; Thu,  4 Mar 2021 23:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0979E8352B;
	Thu,  4 Mar 2021 23:59:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3547C000B;
	Thu,  4 Mar 2021 23:59:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02905C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 23:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDC1F6F584
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 23:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-Zjsd1W7XkV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 23:59:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC8ED6F52F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 23:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neaT7Eb1Mr1F7MOPBZ3CoGxLcRfezG3Ugmf4CjV5osSYUOPtO5L2CD+kMsywJpzOliGobzc3F4JHL/xzPgS7CkNVBBbdnlRdLzK2IfQ4zSOY3IDO2MiDiFflXVNki3FUw5QOS4aZNjBKT/EvnkMm9hRmsgPi3NZGuHcZ33VsIYsBj15jlobCrW+ZqyC29oWFrQVu86BDK2H+zhePpTG53ZJtyt33rJVLXWocfLMsTy2AkKATGCS3r7qjw6AxlNSKiuLsrIwYRvIF36f8OSZug9NuJTiYfxfKnc8h8ObvCVLRoDFBdOSGEF+aCDLjYV5RAMw1RO6ef0Ggogc6ydDrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQvfzouemzlKH6fPAw4oJSaukSZ17aPqAwlO0Pz7VE=;
 b=Mrc/E1Ahbb7yj8VMDwpGwOdaUAUyWqa9r7Hq8H9RoONIsbW2fZsbQ0xwjwpLtQDCZU91qtv25y0bJ+w55PpJs62LF3wBNlRvmKdwgQY/MHgeZ+FV6V4EgJ0f04/oe/4gsxkHaXyePQpA9ADPmUiVQwkoynfzUjNe/Px2s3cxH/revZNRo90xRcgX8pNlF1JLQNOPSbkVlltP35xS4hGls0+CUnv9RVE61fKXMZgnzKBa+TC+s9gMTLLfX10LFSg/JA47/a0rFF9Q5VLTTwWKDGJFIGgjMqe9HZXMNjegz3Em6sWJd71RwhMvUFYK1N4DG0c5rJHkdQ7GjtkD0cmpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQvfzouemzlKH6fPAw4oJSaukSZ17aPqAwlO0Pz7VE=;
 b=fHI0VQ6tDYtxRbo57LlNm6zwpwYHVeXQDNKCBn988WhL8AE6STcgQxJiFLBoR4oVV8sD+W4biQHxWzjLhPJlllQg/uXhG3CIM7O6tcc9wN/CPmYG8O3LAdecCAm3p2PZPwew6whmaof9J5MQKMkMZnvfpKEkI136KQZ59GsNfDI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0908.namprd21.prod.outlook.com (2603:10b6:302:10::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.17; Thu, 4 Mar
 2021 23:58:58 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.024; Thu, 4 Mar 2021
 23:58:58 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize, delete
 partition hypercalls
Thread-Topic: [RFC PATCH 06/18] virt/mshv: create, initialize, finalize,
 delete partition hypercalls
Thread-Index: AQHWv52RO39n9Z5WhEuKJPNiXbM1XKpL8TdwgCkxh4CAAAEL4A==
Date: Thu, 4 Mar 2021 23:58:58 +0000
Message-ID: <MWHPR21MB1593060CD27B9AAA10862833D7979@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-7-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593518130E3E0532894C516D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <e6cc796d-f9ee-5203-95a9-05906f95d3f8@linux.microsoft.com>
In-Reply-To: <e6cc796d-f9ee-5203-95a9-05906f95d3f8@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-04T23:58:57Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f5c14bb-864e-4434-a8eb-256a611d347a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 249ef088-a906-47bd-bbc4-08d8df697a23
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09085D227A7740754A65E550D7979@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fIC4EUMhROCGbHmjF8PPh5bG/vVZfszWprF6w4sTRj7l2Ainxs63FYH5JnKVhDFlxm7ZsF0CQ3QNJT+FUcj6xbWujShrQv25Zzc7e7IY/fNXxGDAde4ixB4bOupMqwBAoeYjMMjdFa7MKz/a7WKO7/oK9GsXmD4vnTs1d8X+sCL9ahYiGgYtv7tPE8NLkdzcl3Mlrf1t7wcIc9asVD6Hud6kUfo9sd7kF9Dt7Gz6DpSxLqIo9Mpe5uHj8UJUSla+cnN5MDnMQpD+66lRZmw/JPwEQ7k+9KjUyNLrmpJ0dbWMrIw+Z+0mGPKeMp4s3eNhzoF1KaAz2rboCXWRIx1GjSZ3FQaxLmfe2iPyObYgPxGC4WDdfn4PyvqGy5xCrmXeEUuSV3TQjvkQHLR3WUOjQmRx+43TXHjhQED97QJS73gIxTZXfDdhKIpwsqQwGRpj6Unoxua9YG2bYwzAaYK7cposBCEFHh0D6uUN40ZblUZoUxEbC2VU/n6Kr+yD6AbZeBhm6Nogcru1rZptLX7dfBzgqB9VvhVDxlwEikpIy/j3eWyqL55dq1MMX8lmOOms
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(66556008)(76116006)(66446008)(66946007)(71200400001)(8990500004)(10290500003)(54906003)(478600001)(33656002)(2906002)(64756008)(7696005)(66476007)(4326008)(110136005)(83380400001)(55016002)(186003)(9686003)(82950400001)(82960400001)(53546011)(8936002)(5660300002)(86362001)(107886003)(6506007)(8676002)(52536014)(26005)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkpwSTFwbGVoYURvWGJHT1Rka20yQXBXSjE5dVVsR3ZQb0FBeFZ6N2Q3bnFz?=
 =?utf-8?B?ZHZVRjFldEJjV0QvL1JzK2Ntb25SalBLd2RPc3NVSDllbFNHM05wdEpvVWhK?=
 =?utf-8?B?ZDhuUkE3Yi9GSUlvcTMyUzZnSVdub2ljZzZ3WWhIbzRsWDRYWm4rZ0k0UG9h?=
 =?utf-8?B?NnM5cCtUOFpuV0hGZUcvY0swKzhrVFRpYll5aFM4endNaG0vTzFONFFFR0xE?=
 =?utf-8?B?aDlqMzM4Qko0NklNbXFpdnYwd0JoelFJbUt1VFpGeUY2T0dqRXV4WlI3c1BL?=
 =?utf-8?B?NG05djVPZHhvS3hwNDdMVVQycWttUzRySlpCaTdBWCtvSWpPZFIrMlR5T29B?=
 =?utf-8?B?SHl5OVM0NjRxdjVGeVphVGlJVVNsTHpHOFdYUE91MStlVVNyVmE5T3ZnYmF2?=
 =?utf-8?B?VXdsblArcC9vTmJ4eDl3M0hBZ3dNV0JlQjQ5WEJ6ZjBUUkNvWGdqWms5SmNx?=
 =?utf-8?B?THE4K0VVOUUvQ1dKQ2RQY1pCM3d6SndWcjMvSnhmYnNzaHdLalBJMGNaWkYv?=
 =?utf-8?B?a2V5SVpLYlBhK0xCV1hhdERUK0w5Y0VKQmZCNWczbW5BSmFMSGxkc3dUTVJy?=
 =?utf-8?B?U2M4aXNYVFhFZ21IRk8zZWdTMU91K1llZENxTFN0UFdsSzZuTFFEZlJ6dTVv?=
 =?utf-8?B?WUxYWWIvSFByT2pxTkt6SCt2MGx5bDFwdmUvSG9nSmhWUHVsYVR0RUI0L3lZ?=
 =?utf-8?B?MDdvUVBYeC9GdDNhMU1POFcwcHFrKzBNbVJ5dEthMlBXQnZpYTVNYlMrLzdT?=
 =?utf-8?B?Y1NTenJ2MFJ0b0o5YzJlbEdIVmd2SWM2aGoyeUZIUUtyTDNiOFhzWWlxZUp5?=
 =?utf-8?B?R0FJVXBNYTdIY3VYdlBxczhHUkxaNk5DODA3MXpPcSt3eXNacEtoK0hsSlhi?=
 =?utf-8?B?V1pyY3JEYmJSc1dmODhVMDd2OGNUc2RxR1pwMHN5dnJWcGRjVHMyZXI2a1B2?=
 =?utf-8?B?QVJiODk0MC9vNnc2OGpXeE1OdEVITG80OU9BWThtRGhzZGt1Z1BxZEc0K1ZM?=
 =?utf-8?B?SHNwWjhBVjNmUUxxTDNzaHQyU3JOeVkrL2k3cHpaMzZUN1M0dFBIUWxRY29u?=
 =?utf-8?B?RVlEWDE0SXQ3L3lYR09GN2Vwczl2U09lc2Y4c0ZodXJwbnArYWlNU2l6QVZS?=
 =?utf-8?B?NCtlUExZNkZrUjJueXdBRXhBc1VVMnozQnBLb0tqajdsbEpNdWQvNlV1OUc4?=
 =?utf-8?B?NFRHcGkwdTFzTFNyNFZtRGhHT2pEc2o2ZGNpakkyTm5ZYTl1R0dmOFUxSTR0?=
 =?utf-8?B?UzJjRUU3NWczYmxYUExWZHRSNmU5QlVEUU5xazBUalpPYi9JbWU1MU8zeXAv?=
 =?utf-8?B?bEtHRitCcHdZWFY0aHQydUNrSjhuemc3ZUhkVXZERm1pTGEzSXpxS2pGS3Nw?=
 =?utf-8?B?MldjTzNwQ0FMR0Y0R2JNbTludW5pQnlnbGxrd2pzamx3U3F0VVVjMnJPSVZ2?=
 =?utf-8?B?b3pCUmpzSFA1S09nZDk4K1Vra0N2TjVzRDhXV29uVm5FellLMXprSGtpOTk5?=
 =?utf-8?B?RWVnNVV3WjZVNThJcFhmSDNib2V2U3JwSUNzd1lBOFpJQ3FHcE9RWmVhOEtU?=
 =?utf-8?B?K0ZkWjMzdUdkWlRPQVl2azV6V0NSeU1Rb2FXcjFhTHdOTExsQ1F2b3BBKzhX?=
 =?utf-8?B?MmIzMzBrTFJ5anlYcnJFYWJLTDBPYjZrTE1FU0tjV2p3MWpBT3VFNHBCUzFH?=
 =?utf-8?B?YytoR01YSGI5UGFITTc5cFJjS2lpcENjdW41anErY3phQjFGQytIbnRrVm1K?=
 =?utf-8?Q?Iu+hRNSqIAC3Cie043hO8vizstErBII6TRvX8Hp?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ef088-a906-47bd-bbc4-08d8df697a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 23:58:58.5897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNZobscYgBW+ukzDiFK9S3dAcDan+0UKH2oELaGAJmxD7/ocffATnpObQJPqbN3zYQjKEArn1xdZl2IodBjVTeWK4qkHvWBeTfQ4AyENQDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
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

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, March 4, 2021 3:49 PM
> 
> On 2/8/2021 11:42 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November
> 20, 2020 4:30 PM
> >>

[snip]

> >> +
> >> +static int
> >> +hv_call_create_partition(
> >> +		u64 flags,
> >> +		struct hv_partition_creation_properties creation_properties,
> >> +		u64 *partition_id)
> >> +{
> >> +	struct hv_create_partition_in *input;
> >> +	struct hv_create_partition_out *output;
> >> +	int status;
> >> +	int ret;
> >> +	unsigned long irq_flags;
> >> +	int i;
> >> +
> >> +	do {
> >> +		local_irq_save(irq_flags);
> >> +		input = (struct hv_create_partition_in *)(*this_cpu_ptr(
> >> +			hyperv_pcpu_input_arg));
> >> +		output = (struct hv_create_partition_out *)(*this_cpu_ptr(
> >> +			hyperv_pcpu_output_arg));
> >> +
> >> +		input->flags = flags;
> >> +		input->proximity_domain_info.as_uint64 = 0;
> >> +		input->compatibility_version = HV_COMPATIBILITY_MANGANESE;
> >> +		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURE_BANKS; ++i)
> >> +			input->partition_creation_properties
> >> +				.disabled_processor_features.as_uint64[i] = 0;
> >> +		input->partition_creation_properties
> >> +			.disabled_processor_xsave_features.as_uint64 = 0;
> >> +		input->isolation_properties.as_uint64 = 0;
> >> +
> >> +		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
> >> +					 input, output);
> >
> > hv_do_hypercall returns a u64, which should then be masked with
> > HV_HYPERCALL_RESULT_MASK before checking the result.
> >
> 
> Yes, I'll fix this everywhere.
> 
> >> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> >> +			if (status == HV_STATUS_SUCCESS)
> >> +				*partition_id = output->partition_id;
> >> +			else
> >> +				pr_err("%s: %s\n",
> >> +				       __func__, hv_status_to_string(status));
> >> +			local_irq_restore(irq_flags);
> >> +			ret = -hv_status_to_errno(status);
> >> +			break;
> >> +		}
> >> +		local_irq_restore(irq_flags);
> >> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> >> +					    hv_current_partition_id, 1);
> >> +	} while (!ret);
> >> +
> >> +	return ret;
> >> +}
> >> +

I had a separate thread on the linux-hyperv mailing list about the
inconsistency in how we check hypercall status in current upstream
code, and proposed some helper functions to make it easier and
more consistent.  Joe Salisbury has started work on a patch to
provide those helper functions and to start using them in current
upstream code.  You could coordinate with Joe to get the helper
functions as well and use them as discussed in that thread.  Then
later on we won't have to come back and fix up the uses in this
patch series.

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
