Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 20:45:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AE264F85
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AE264F85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 412EA4ECFF;
	Thu, 11 Mar 2021 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JceeYVbZx9s; Thu, 11 Mar 2021 20:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B19F4EC3C;
	Thu, 11 Mar 2021 20:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 167B6C000A;
	Thu, 11 Mar 2021 20:45:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA68DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 20:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D51A1430B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 20:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgIL_MpnvXIa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 20:45:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2115.outbound.protection.outlook.com [40.107.244.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56F5A431F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 20:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7VKG6iN8TcW6oDFY5wo/tIysv7Q1Y1mIYullOAFDR6nK6rrpn3nQW0qDl0VLNT2TYkZq85uqpgPaKoaPSUjujDTIUAL+j990Hi+EVzKwbr9pO5XzAb/BMC+B1iaPO1PsTcM9eDfrL1sOYdlRV/5h0wSP2yGzoHOQMVipAvb8DhsJs876wl7KZrRKU9P5PA+Po5ihiNVu1i1tTZ5iSDmJusRxuQa7+qdSpmMNno/ku1TIJtGIO6CXkDh8F4VhCWHvE1F2nnSZ23i82WETx3+7f2ko5+keJt1g9GMjIdfck0/IsIfuRt5C3L0R3C1wqUqKPBTqSE8cKR55I8xXDf6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq0db7WPUwYxkbr0L7U39OlwmgKR95IETNFSEJX/Eto=;
 b=odBu9eslc3hZek05nrtMyegdYW+PNSktzMnEVzkYfM1VtDC1nIk3BJqxMLp/F3FbfHhTnNAmJKa0N+2BsFbdDjR8ydkggh6LNr7xv0eIezFpkhWQ1VUC/CIII5C7h2gTj0Zp9t8xSk6TXJrrXdIPInRHiXPzUGW9G2VSGGWfX0R7RlZFUUFJ6h5kVfGTeBGNEeOVbx0LDs0unaVZaElDRxpRwYUQwYqBMM4r5ogkIhrE2mI58ngoPdkT7bqNXaYeS8lmTkuEgRXh/aduBK3oh7ztx21Wpi1OloaYffsh2Dut0xYCBZl40jyM8aHqqpDmcxcgjWl6MNv0oFOsvRhjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq0db7WPUwYxkbr0L7U39OlwmgKR95IETNFSEJX/Eto=;
 b=fQpJsggheGRHQfOiUV/4yObF5m7hGb9yek9Lfx0Sjei+wR6p8mHjSWAv3xzJ+AyySOQ5mL9SgvmJH7QxAuitvfpCSPVIFZBI0VpXSHJwXTGd1dwi8RLgcvqZurJ2vTjrNUzzqGK8mnYVEpjam8Lcfr8C3QP0dusJBKzLRHf+E3E=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0286.namprd21.prod.outlook.com (2603:10b6:300:7a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.11; Thu, 11 Mar
 2021 20:45:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.008; Thu, 11 Mar 2021
 20:45:30 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Topic: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Index: AQHWv52Sf16Ua5UbGEyERkZGDy8rgqpN98MAgDHk+QCAABFkcA==
Date: Thu, 11 Mar 2021 20:45:30 +0000
Message-ID: <MWHPR21MB1593DACDA296E8DAC5D8BC78D7909@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-12-git-send-email-nunodasneves@linux.microsoft.com>
 <MWHPR21MB1593EC8F1ACA57299AB5016AD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <9e06a119-880f-5199-903b-056675331d6f@linux.microsoft.com>
In-Reply-To: <9e06a119-880f-5199-903b-056675331d6f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-11T20:45:28Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c330553d-a3fa-4b52-bafb-5d76f7bbe704;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f91ef307-066e-476a-1309-08d8e4ce9bec
x-ms-traffictypediagnostic: MWHPR21MB0286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB028670766298858E5523159AD7909@MWHPR21MB0286.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ta3GsT1cp7Z0bEDIauYIfWD7yaN/K6bRX2kyKDaPRW4g6UuffTgikJnsW2nM8OpFA7YnPkD9ya5puOO8zpzZ5xY8di7ggcF40SHQHprnDBy6kenC6YnrD1cyYvaVZRFPuEX2HUTT9fzX1icWzVR7IEN+Oe4XinrkyXZagqYNMlWqoSh1OXhdn6R7WR7rfeV772rKGdArpUMKTQDEeVDneDvoJkeWoV8Z4lmggOyap7NCsD1Dsbmedn1t/6t7I7cMzoROtFEVWpyA0LMQ/bkzkkDyQaR4QJvpihH+R7JkNQIcPw01ylZ90SqK2J9kMp76m8UypAm0XU0aZfVAc/NII0glg4L7mtVcAYKd8a95ZxyAOq+RAFQ0PxA6h1w1q0BRzSkMfj6+2a/7qpT/RVv4ZUnqvyRIxrN8VA8fWB7GSicr4IYSMMN14rX1XD+7EcjOvTrjIR0bj6rEVPslzPl4b4cTYYUXzE2xN/JGeLB7cNbpfLejkc2sbx5X2rfcfsaIg4FOOjo4L67lTl8TNgfhDShT7xA00hS6k89L3fsdrVw/NvVbVQ5Bos9ZL1uFBVmk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(107886003)(9686003)(53546011)(82950400001)(66476007)(33656002)(6506007)(76116006)(71200400001)(66446008)(7696005)(478600001)(82960400001)(64756008)(316002)(8990500004)(66556008)(10290500003)(66946007)(2906002)(86362001)(52536014)(4326008)(8676002)(8936002)(15650500001)(54906003)(5660300002)(110136005)(26005)(83380400001)(186003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?R3FFdUtpRVF2MktqWC9lWGlwTzExVWxwdXRWYndDQnpSUUZnaUZlVEVQNUJF?=
 =?utf-8?B?YW5VTjZDYW54aW1BQ2NIZm1WaWFNRjE0ejdxblpYeXp4aHNzR1lBOUZoNWRC?=
 =?utf-8?B?MFkyS2dzUXpzU25OdVZmUkFmcStsbUl1dkR0eFI0d1QxRFhXYjgyemFPcDNZ?=
 =?utf-8?B?SHJjR1QxUkkyTG5NV05BQ2RtWWZRUVp6MkMzSGxRS05xbG1oTmJlZkRoRGJP?=
 =?utf-8?B?VHhYSXUxelUyMlpPeTFrbXQ2S3VTOVhmaXBZaUhYMTUxMk40dXg3blltVktX?=
 =?utf-8?B?MCsvcHdCZGh4eDd2SFBBd0xtWTdBaS9pcXZQYTY0OVY1RFZIaHVWczJlWUhi?=
 =?utf-8?B?eTVYRTU5VjA5dzBINmpxdXUrMVhjTVIvc0p4L2pwbTFJSmZhWUo0SHRLVGMv?=
 =?utf-8?B?Sm81diswT05oQ3Nld1NWRUhESWJuQ3RNWEg0Q3dUamdWb2svREs1b3dtU1Ra?=
 =?utf-8?B?QUZoUTVFSlhlcTVhTjgvYzJ0NDlvWUJXeHN0Yld3TVp1OVFjUG5lREN5R3Zq?=
 =?utf-8?B?NDZaTXVmRUlneDdWbThGeHBSWHlLcTVSWDI5dWVFU1d5KzkrcFFnWEhQTVBu?=
 =?utf-8?B?QlpOdStKaTMwWWkycFdib2VneUNNUTFmU3N2bHBzZWtoVEtoektFSTlHYkx5?=
 =?utf-8?B?eEU2K29hWnN4aHJteHBBRHFrdUFLNEpkUUVwaFB6Y2lBZ0k1L2FpYkEyT1Mx?=
 =?utf-8?B?eHFSa3B2d0NZTVBvdld3OUZpUjZWbStxR1JoUjcyYzZqRi9hZXFoNlprZXBI?=
 =?utf-8?B?VlZwT1I5dU9sY1dkUE5TRVEwbkVyS1NheW45ck0wMlRoVmhQNDdsbVhnY25J?=
 =?utf-8?B?Z1RwTE5sQXgwcFZhN1daWERtTEJ0d1lOdkxGZm80SVlDQTRrUzZONm02Rm02?=
 =?utf-8?B?VSt4L0lLZ3lrdnJIVlFlbDB3K0tQbFZqWU0zR3dlenFxejFBckVDUWRnQWl6?=
 =?utf-8?B?eGc0cHRudWszaFhLR0VpaUQ4a0lNbUtzS3VwN1o3VHZMSFpMdjZCd3N2RmxL?=
 =?utf-8?B?SUwxVGl5UkRTM00yendtNHB3b3ozT0NwZmpwa1ZrR0pVays2T3g2T1lDNko2?=
 =?utf-8?B?NEg1K2x6SUhoZmZZdFFIR3Y2UUFwMER3MURwMzByQ0FKR0x5Z25PZEMxdUVH?=
 =?utf-8?B?NktZQ0pkYTdMbXpvL2RseWNaOXhoVzRHdG1JeVAyNUIvTkJJL3hBZTJ2VERR?=
 =?utf-8?B?QUF4d29UZFlQaFJUMmF4dU1rbFFiRS9pQ1l0dGl3MStDMzNweFZZZlJVdWRv?=
 =?utf-8?B?Vm9rVGl6T251VVdSbjU2bVhyL0RhblpsaGlIUkl4SVJEdW93Q253b0RaVDBT?=
 =?utf-8?B?a0htRFR0b0pXQVJheVA1aW1PR3FqeEVIUm52TFJUN1ZnSlNSN2FoTnRZMmQ2?=
 =?utf-8?B?RWw1cjQ4MFNhY0o4Zk95TEMzam5Oc3FNMkRlZEgzWStrUytzMXkxQkUyVDlC?=
 =?utf-8?B?RVg4OWwyWERFWEpTOHBpbE9NdzJpU0k2bGRJcE5ENnZFMXFYUlhpZC9ON2E3?=
 =?utf-8?B?SWVGZkptbGJyTWkrYlBoUEgrZERzZDFpM2J6Z091V2YzVEFSQldEYjgvSGFD?=
 =?utf-8?B?T2NrQmUzTzVBTjY4OVNYY0ZzeEVqby9PRkxGMXR3NXpGNlloWkY2aHZ3aDdq?=
 =?utf-8?B?Mk1JZmVEWTFka2xOZnViTWlkSytmbGNWeUpkeWltUGFnajlaUWFkOTFYcHNl?=
 =?utf-8?B?SERMRmk3R3pXRU1kd2UrZVk1SS9aRUQwdElaaW1uOVdTTnRlaEtLRWlhSFRo?=
 =?utf-8?Q?P61Um/rl4ehbbt+0Vk9Kj33ye2XmzubxSzDEek0?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ef307-066e-476a-1309-08d8e4ce9bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 20:45:30.2411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctiuR1ivK1HF0fa9sV3JD7t5/l1n/6ac5MYYCT7PFhcXMtTjMmZWcy0lSdjKT8bn7bKm2juyMbgoJk897yP+EjXUGsBAr7e4lcpuK76gFBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0286
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

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, March 11, 2021 11:38 AM
> 
> On 2/8/2021 11:47 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November
> 20, 2020 4:31 PM
> >>
> >> Same idea as synic setup in drivers/hv/hv.c:hv_synic_enable_regs()
> >> and hv_synic_disable_regs().
> >> Setting up synic registers in both vmbus driver and mshv would clobber
> >> them, but the vmbus driver will not run in the root partition, so this
> >> is safe.
> >>
> >> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >>  arch/x86/include/asm/hyperv-tlfs.h      |  29 ---
> >>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 264 ++++++++++++++++++++++++
> >>  include/asm-generic/hyperv-tlfs.h       |  46 +----
> >>  include/linux/mshv.h                    |   1 +
> >>  include/uapi/asm-generic/hyperv-tlfs.h  |  43 ++++
> >>  virt/mshv/mshv_main.c                   |  98 ++++++++-
> >>  6 files changed, 404 insertions(+), 77 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> >> index 4cd44ae9bffb..c34a6bb4f457 100644
> >> --- a/arch/x86/include/asm/hyperv-tlfs.h
> >> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> >> @@ -267,35 +267,6 @@ struct hv_tsc_emulation_status {
> >>  #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
> >>  #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
> >>
> >> -
> >> -/* Define hypervisor message types. */
> >> -enum hv_message_type {
> >> -	HVMSG_NONE			= 0x00000000,
> >> -
> >> -	/* Memory access messages. */
> >> -	HVMSG_UNMAPPED_GPA		= 0x80000000,
> >> -	HVMSG_GPA_INTERCEPT		= 0x80000001,
> >> -
> >> -	/* Timer notification messages. */
> >> -	HVMSG_TIMER_EXPIRED		= 0x80000010,
> >> -
> >> -	/* Error messages. */
> >> -	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
> >> -	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
> >> -	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
> >> -
> >> -	/* Trace buffer complete messages. */
> >> -	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
> >> -
> >> -	/* Platform-specific processor intercept messages. */
> >> -	HVMSG_X64_IOPORT_INTERCEPT	= 0x80010000,
> >> -	HVMSG_X64_MSR_INTERCEPT		= 0x80010001,
> >> -	HVMSG_X64_CPUID_INTERCEPT	= 0x80010002,
> >> -	HVMSG_X64_EXCEPTION_INTERCEPT	= 0x80010003,
> >> -	HVMSG_X64_APIC_EOI		= 0x80010004,
> >> -	HVMSG_X64_LEGACY_FP_ERROR	= 0x80010005
> >> -};
> >> -
> >>  struct hv_nested_enlightenments_control {
> >>  	struct {
> >>  		__u32 directhypercall:1;
> >> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> b/arch/x86/include/uapi/asm/hyperv-
> >> tlfs.h
> >> index 2ff655962738..c6a27053f791 100644
> >> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> >> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> >> @@ -722,4 +722,268 @@ union hv_register_value {
> >>  		pending_virtualization_fault_event;
> >>  };
> >>
> >> +/* Define hypervisor message types. */
> >> +enum hv_message_type {
> >> +	HVMSG_NONE				= 0x00000000,
> >> +
> >> +	/* Memory access messages. */
> >> +	HVMSG_UNMAPPED_GPA			= 0x80000000,
> >> +	HVMSG_GPA_INTERCEPT			= 0x80000001,
> >> +
> >> +	/* Timer notification messages. */
> >> +	HVMSG_TIMER_EXPIRED			= 0x80000010,
> >> +
> >> +	/* Error messages. */
> >> +	HVMSG_INVALID_VP_REGISTER_VALUE		= 0x80000020,
> >> +	HVMSG_UNRECOVERABLE_EXCEPTION		= 0x80000021,
> >> +	HVMSG_UNSUPPORTED_FEATURE		= 0x80000022,
> >> +
> >> +	/* Trace buffer complete messages. */
> >> +	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
> >> +
> >> +	/* Platform-specific processor intercept messages. */
> >> +	HVMSG_X64_IO_PORT_INTERCEPT		= 0x80010000,
> >> +	HVMSG_X64_MSR_INTERCEPT			= 0x80010001,
> >> +	HVMSG_X64_CPUID_INTERCEPT		= 0x80010002,
> >> +	HVMSG_X64_EXCEPTION_INTERCEPT		= 0x80010003,
> >> +	HVMSG_X64_APIC_EOI			= 0x80010004,
> >> +	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005,
> >> +	HVMSG_X64_IOMMU_PRQ			= 0x80010006,
> >> +	HVMSG_X64_HALT				= 0x80010007,
> >> +	HVMSG_X64_INTERRUPTION_DELIVERABLE	= 0x80010008,
> >> +	HVMSG_X64_SIPI_INTERCEPT		= 0x80010009,
> >> +};
> >
> > I have a separate patch series that moves this enum to the
> > asm-generic portion of hyperv-tlfs.h because there's not a good way
> > to separate the arch neutral from arch dependent values.
> >
> 
> Ok, but it should also be changed to #define instead of an enum, right?
> I will do that in this patch.
> This requires a couple of changes in other files in drivers/hv
> where this enum is used.

Because of the other uses of the enum in places that don't depend
on exact structure layouts, I left it as an enum when I moved it.
When one of the enum values is passed to Hyper-V, the enum
is assigned to a u32 field, which I think is acceptable.  You could
do the same with the other enums your already have -- keep the
constant definitions as members of an enum, but assign to a u32
field in the structures that get passed to Hyper-V.  There may
actually be some benefit in that approach, particularly if the enum
is passed as an individual argument into some function(s). 

Others may have an opinion on this approach .....

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
