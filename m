Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 17:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325936138F
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 17:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 325936138F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0083282CAC;
	Wed, 20 Oct 2021 17:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWZtLa3omxAa; Wed, 20 Oct 2021 17:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6600282C21;
	Wed, 20 Oct 2021 17:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49ACFC000F;
	Wed, 20 Oct 2021 17:26:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9BA3C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9746640584
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6LuAeTucx7v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:26:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF4A34057A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx2EcZua0ojw0BzKen6FxlF+OzRJOUkmAH83E0TC3fF6gnny4HM0fo48xKkxiF4myeBFgvLaEp8JiIfk1Zvfh8zhQwc47OE01tRPEH/1JH0wgZYyc0Y23wWMA6+aLvjCTzLFGorvwWgw8ZCknvmRX74a1EIL7zGlnBohW+xn9IunIGMVyhuazulTSy7+FwCisBo+s6Fu+Rk6imURwrKC4129r5MeS/DVQfIDzXXtChYGZYWH1q8laArkiL/doJNH73i4T254cM+mXW+Xy/ywK7oNwm0FU4BprCBSks6xvIUJ8ILgA5gnZTzOiQXcehBv0rs1vGfedhsv9Zo/HUO4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpAcJkx2zC8LdsbwxMe8SN9vYo8iAQp6cKmAWVC/V6A=;
 b=IXnGOykcpLPSx/tVJjPGIl9fORwt8z8cQDq7fahSX0AFVQVazUcLKAA9wVlK+TYNhPNo9EpJCOJDFFHGPJ9nrm1MqR80Z3tsqL2T0njYBSYuezU1FXdP8ihjkJ59Aoy0lsgM6rStbsJKJkUS+ZDfYoxn/YSa4OQqkvb+O7OzMDlZC+hqnWI4XWJmcRc+ne4WrCPThWCWoCxLr4YJOUiJ0RWGgQ25VkLrLW7AXm315EHzCFKdY8DsilbuT4hG/POXofCVlawY53u/LbfHQY1iIogGVfomnbf24T0QalEewzUDjCGMPv9CYm4aSN6xuW8phlny5v9XFtrexBC1v2LYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpAcJkx2zC8LdsbwxMe8SN9vYo8iAQp6cKmAWVC/V6A=;
 b=UKda+SsuhxDvTLK7mdrtpGFB9XPdmWqRDIHRSndnPmcm3yq4yAzuEy2NJ+WDokKOmtwu3Hcj/BbsF4pcASPc51kT6S5aQKobvR+dR0FBA/YofBivBVV8FYA6+6wZTlx/t1gIxMpAZlwqhVkM5LjwfPjwV1GwOA649aurQoN5rM8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 17:26:35 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 17:26:35 +0000
Subject: Re: [PATCH v5 07/16] x86/kvm: Use bounce buffers for TD guest
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 James E J Bottomley <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, "David S . Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <42f17b60-9bd4-a8bc-5164-d960e54cd30b@amd.com>
 <0a9c6485-74d8-e0fc-d261-097380272e07@linux.intel.com>
Message-ID: <591e0566-59e1-71d1-684a-fd1240b2eedc@amd.com>
Date: Wed, 20 Oct 2021 12:26:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <0a9c6485-74d8-e0fc-d261-097380272e07@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: CH0PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:610:118::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 CH0PR03CA0330.namprd03.prod.outlook.com (2603:10b6:610:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 17:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d09b0a-9341-47be-9875-08d993eec43c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5214CC75060FB975567CF46DECBE9@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwUaOOrppXIz2ZZHhtClOgpkboVgeJvHAdD9pUZQA1YIsEwfiGeHF0t4o/M8GaWyVPteLFFeANGMZCq6rXR+kyICKcibYGcp17eXU36v4bSyFvZsZRApPbQ/YR87xAIhHJz5Vawp91fDH5/gey0sG01gzpod/18bFrOucuJLgBUvpuB0s2vbSclO/ZcanMdtCpyp8EaC/ru4ZiMKiC8fXWJ9m6SrkMYG1ZgYYPzCRoiryPtsYjkZphGMd2RkhzRG5eCg0fd/FulWvu1qd+/ZWLQYPfYDtg0hhC/8Tk2fvQr2REr9p59/0fC+rnLUpU8lN/rIHHUfZgltHuHwZ2aO3d/wV92vgXK7gVimqhp1VfXwBcePGU6Y+XON2ZkAruecSQLC2kc7aXwqsVPyoWn6R2NhevAxRVp+OXUnObn2e6DwdbzlfBGgzflvxSAH017BMJ07D2uVVbt2glnvlu6jBB32d12U1CZkTBnO0iIY6w7UT8TaRuu0bK7iTO0V/8GYC6eyKwKIizlXk214TrU2dFzizbcLiyMZ2Ytz2UroMu49dqeO81Y9EdFFFhprLOB+A81HQxoYT+1vl+AY+RGxBErlrkaCacs0gh+syTElmFwyRo1inUKoGgQYHdLJTV0aTorYV9FM4zvnivLeBfRk3xVmxMGtga7Ud+WK4Fd4oSM/F7Xfnx58EMiJX45o6RTrh6v9JlpA26nv7UYBeXIeFqDdoKi69/IEwzsSRIzc5GXmB9mcJHqBXNNSyoPsGBEZKmPkit68S/ohlAP06WRnMlvycf6F++v0jMla2cX9VXU8t2NQQrjbIdxlySN/tkRccW22R9HDJ3fKhK2G+lbn2aJ/ml0Wj0BoDH8emwp34jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(66476007)(921005)(83380400001)(66556008)(508600001)(110136005)(54906003)(2616005)(66946007)(16576012)(53546011)(7406005)(86362001)(8676002)(5660300002)(7416002)(8936002)(31696002)(316002)(31686004)(36756003)(38100700002)(186003)(2906002)(26005)(4326008)(6486002)(45080400002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBSQ1l4aXdNZks1a1FTckVxL3J1MVlGTGJRZUttZVBmUU9ON1NNSmc0c2k0?=
 =?utf-8?B?clFIMlVYZ0NTUm9HWUtiZEZoeHZYT21SNFh5WFNySitZdVdHNy91VXVPb3NT?=
 =?utf-8?B?SVI2b0NBalVjRDVaWEpqUEU2MjlLU3hGQjZiZ1lQWURHNmkxSGNNUmFDeDFL?=
 =?utf-8?B?TTdQTFpUa2JxNzVxS0xBZnlQTE16dFVCWUpONWI1bDRPOXdwY1BGeDJiQngv?=
 =?utf-8?B?bkExSFdOVmZRdUpIc1NaMHpyUWhwREhIMDN3WkNwTTlTdWRwNXhkUjlPellN?=
 =?utf-8?B?OFNxdEZydG1MNUZhc2swVjFHcUY5SUxiNzh1WXR3SDRMcHlyT2JhQTI4ZG1r?=
 =?utf-8?B?dVFxY3hlYldlSHRpNkhVeE5DZitSTHZ1TCtRV2xyMjlobDlqVXoycXBLSzNI?=
 =?utf-8?B?bjhxZEZGUXY2NFV5RUNpS28vYktlRHJTUGRqUUxlV2ZjV1FjN2ZaZGlRc0tC?=
 =?utf-8?B?L2UwUC91Q1NBMVpRZnVQMTI5ZUlKbXBvVHhQTkJBNzN0NVhQeFlaZGVobm1H?=
 =?utf-8?B?dDAyUHMwekp1N3QxNllhVUN5dDNIRU1Ra3FMZlZPNitDN0tmMjB1R0t5NjBk?=
 =?utf-8?B?c2Fqb0pVRDEvOG5kRDJCQ2hZU2JYdWFWeHJUekVSUGlubERFQ3lXRVl6OWVo?=
 =?utf-8?B?eU5UTFlEc2VoSHZMMXNRK1lHdWpXMkMvS1FoSUZ6NGpBSFBQcExvbTBZL2Z4?=
 =?utf-8?B?TjFHZGJCWDMwVnpKVTN0V0k3OG5aSXdHM1VmYTRzUzlhdHordU5GR2oxaGdN?=
 =?utf-8?B?VzNTSWkzdWFUNk1YSFJwMHl4U1dnVFhCUFZNTURvdlh0eFAvMHBnaTVVTktI?=
 =?utf-8?B?a0FyOTNXU1RwRTFaK3NaaG5oVG5WYjlOR3B0VGlFVVEyK2pVeU1yRnU5dzZx?=
 =?utf-8?B?NklQQlN3b2thZkRLUFh3NkpQNC9HT1lhajQ2bzhySzQwZW1Ec05uZE1JMmtS?=
 =?utf-8?B?WTNiMUxkSkJma0dXREVhK053eEhscFZnU3JGQlNhRkt0T0JYYnRlNzEvQWFs?=
 =?utf-8?B?Rmh3RWp2TUhKeXZjbTM0Tlp1SVcwQnF4bHpzZCtUd2NkU01iN2pyRkRxRnBB?=
 =?utf-8?B?MWtMOEZYclhBei96czR6MDJvTTlBNXJsV2FVcVExZVBTM3kvaFRRQmVDY3du?=
 =?utf-8?B?Vm9sSlRBTURoNFVWc2pDeFN1UmhnKzRuNFZaUHl5Ymx4ZVZmMi9jU0pyR3Jn?=
 =?utf-8?B?U1ZPSzFNUDU3NlllWWlPL0ovQUJsYWFYYmNrU29IQTNnV2NRN2RyTmh0Q3FK?=
 =?utf-8?B?cVFZVVRDakZIYnhJdEVYVTNhYllBMlZBVEw2QnFsYkZvVUZYeml4TWh2d2NS?=
 =?utf-8?B?RXMyUmVRZWxxZ2F2SjJySlRJVVZ5aDc5ejFmeFphZVlHSU9ZNFVUS2djRlMy?=
 =?utf-8?B?QVRJUUVlcDJTaUIyMHNjWEU1Kzg5VWVtTmI3Nlp2dGVZNlpCN3JLak5IcC9G?=
 =?utf-8?B?ZlNxVmNHRXMzL29XdmdxUkxXMUtOcE0wVytWWHE0eHRwN2YrY0wrUnFpV2Jy?=
 =?utf-8?B?Znd2NGhyRDJqZ1NWelBRQy84Vi83L3JRUUNJZHhsdGQ5Rng2ZjFoNDduN0Zn?=
 =?utf-8?B?WTVLaE8zVjgzWWVMNlgvd0doZ01zMUpoWkZxYkIzWE1vSkFrWWtyblZ6bStS?=
 =?utf-8?B?enlsWlpBNnF6WWhwYXhpbWVGZVpldk41UFIyOWFlVDZ4c3lIOFJVK1BRVzk1?=
 =?utf-8?B?REVBajNWVVFzUm5jZ2tsd1BLSm1QbmpsU3Y4V3EvdzBXVVZmd25INURUemxO?=
 =?utf-8?Q?Aa3RgpVcuMvfnwjmrWxZIy+QR3+mAgVLUxyGKRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d09b0a-9341-47be-9875-08d993eec43c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 17:26:35.5979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
Cc: linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 linux-alpha@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Peter H Anvin <hpa@zytor.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTAvMjAvMjEgMTE6NTAgQU0sIFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15IHdyb3RlOgo+
IAo+IAo+IE9uIDEwLzIwLzIxIDk6MzkgQU0sIFRvbSBMZW5kYWNreSB3cm90ZToKPj4gT24gMTAv
OC8yMSA3OjM3IFBNLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKPj4+IEZyb206
ICJLaXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPgo+
Pj4KPj4+IEludGVsIFREWCBkb2Vzbid0IGFsbG93IFZNTSB0byBkaXJlY3RseSBhY2Nlc3MgZ3Vl
c3QgcHJpdmF0ZSBtZW1vcnkuCj4+PiBBbnkgbWVtb3J5IHRoYXQgaXMgcmVxdWlyZWQgZm9yIGNv
bW11bmljYXRpb24gd2l0aCBWTU0gbXVzdCBiZSBzaGFyZWQKPj4+IGV4cGxpY2l0bHkuIFRoZSBz
YW1lIHJ1bGUgYXBwbGllcyBmb3IgYW55IERNQSB0byBhbmQgZnJvbSBURFggZ3Vlc3QuCj4+PiBB
bGwgRE1BIHBhZ2VzIGhhZCB0byBtYXJrZWQgYXMgc2hhcmVkIHBhZ2VzLiBBIGdlbmVyaWMgd2F5
IHRvIGFjaGlldmUKPj4+IHRoaXMgd2l0aG91dCBhbnkgY2hhbmdlcyB0byBkZXZpY2UgZHJpdmVy
cyBpcyB0byB1c2UgdGhlIFNXSU9UTEIKPj4+IGZyYW1ld29yay4KPj4+Cj4+PiBUaGlzIG1ldGhv
ZCBvZiBoYW5kbGluZyBpcyBzaW1pbGFyIHRvIEFNRCBTRVYuIFNvIGV4dGVuZCB0aGlzIHN1cHBv
cnQKPj4+IGZvciBURFggZ3Vlc3QgYXMgd2VsbC4gQWxzbyBzaW5jZSB0aGVyZSBhcmUgc29tZSBj
b21tb24gY29kZSBiZXR3ZWVuCj4+PiBBTUQgU0VWIGFuZCBURFggZ3Vlc3QgaW4gbWVtX2VuY3J5
cHRfaW5pdCgpLCBtb3ZlIGl0IHRvCj4+PiBtZW1fZW5jcnlwdF9jb21tb24uYyBhbmQgY2FsbCBB
TUQgc3BlY2lmaWMgaW5pdCBmdW5jdGlvbiBmcm9tIGl0Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
S2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPgo+Pj4g
UmV2aWV3ZWQtYnk6IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT4KPj4+IFJldmlld2Vk
LWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBL
dXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiAKPj4+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2Ft
eUBsaW51eC5pbnRlbC5jb20+Cj4+PiAtLS0KPj4+Cj4+PiBDaGFuZ2VzIHNpbmNlIHY0Ogo+Pj4g
wqAgKiBSZXBsYWNlZCBwcm90X2d1ZXN0X2hhcygpIHdpdGggY2NfZ3Vlc3RfaGFzKCkuCj4+Pgo+
Pj4gQ2hhbmdlcyBzaW5jZSB2MzoKPj4+IMKgICogUmViYXNlZCBvbiB0b3Agb2YgVG9tIExlbmRh
Y2t5J3MgcHJvdGVjdGVkIGd1ZXN0Cj4+PiDCoMKgwqAgY2hhbmdlcyAKPj4+IChodHRwczovL25h
bTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlcm5lbC5vcmclMkZwYXRjaHdvcmslMkZjb3ZlciUyRjE0Njg3NjAlMkYmYW1wO2RhdGE9
MDQlN0MwMSU3Q3Rob21hcy5sZW5kYWNreSU0MGFtZC5jb20lN0NhZDg1MjcwMzY3MGE0NGIxZTI5
MTA4ZDk5M2U5ZGNjMiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2Mzc3MDM0NTQ5MDQ4MDAwNjUlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3
TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdD
MTAwMCZhbXA7c2RhdGE9bFh3ZDUlMkZobm1kNVFZYUlFbFElMkJ0VlQlMkI2MkpIcSUyQmltbm81
VklqVElMYWlnJTNEJmFtcDtyZXNlcnZlZD0wKSAKPj4+Cj4+Pgo+Pj4gQ2hhbmdlcyBzaW5jZSB2
MToKPj4+IMKgICogUmVtb3ZlZCBzbWVfbWVfbWFzayBjaGVjayBmb3IgYW1kX21lbV9lbmNyeXB0
X2luaXQoKSBpbiAKPj4+IG1lbV9lbmNyeXB0X2luaXQoKS4KPj4+Cj4+PiDCoCBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tZW1fZW5jcnlwdF9jb21tb24uaCB8wqAgMyArKysKPj4+IMKgIGFyY2gveDg2
L2tlcm5lbC90ZHguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDIgKysKPj4+IMKgIGFyY2gveDg2L21tL21lbV9lbmNyeXB0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgNSArLS0tLQo+Pj4gwqAgYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRf
Y29tbW9uLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrKysrKysrKwo+Pj4gwqAgNCBm
aWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tZW1fZW5jcnlwdF9jb21tb24uaCAKPj4+
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHRfY29tbW9uLmgKPj4+IGluZGV4IDY5
N2JjNDBhNGUzZC4uYmM5MGU1NjViY2U0IDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbWVtX2VuY3J5cHRfY29tbW9uLmgKPj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21lbV9lbmNyeXB0X2NvbW1vbi5oCj4+PiBAQCAtOCwxMSArOCwxNCBAQAo+Pj4gwqAgI2lmZGVm
IENPTkZJR19BTURfTUVNX0VOQ1JZUFQKPj4+IMKgIGJvb2wgYW1kX2ZvcmNlX2RtYV91bmVuY3J5
cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+Pj4gK3ZvaWQgX19pbml0IGFtZF9tZW1fZW5jcnlw
dF9pbml0KHZvaWQpOwo+Pj4gwqAgI2Vsc2UgLyogQ09ORklHX0FNRF9NRU1fRU5DUllQVCAqLwo+
Pj4gwqAgc3RhdGljIGlubGluZSBib29sIGFtZF9mb3JjZV9kbWFfdW5lbmNyeXB0ZWQoc3RydWN0
IGRldmljZSAqZGV2KQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+PiDC
oCB9Cj4+PiArCj4+PiArc3RhdGljIGlubGluZSB2b2lkIGFtZF9tZW1fZW5jcnlwdF9pbml0KHZv
aWQpIHt9Cj4+PiDCoCAjZW5kaWYgLyogQ09ORklHX0FNRF9NRU1fRU5DUllQVCAqLwo+Pj4gwqAg
I2VuZGlmCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3RkeC5jIGIvYXJjaC94ODYv
a2VybmVsL3RkeC5jCj4+PiBpbmRleCA0MzNmMzY2Y2EyNWMuLmNlOGUzMDE5YjgxMiAxMDA2NDQK
Pj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC90ZHguYwo+Pj4gKysrIGIvYXJjaC94ODYva2VybmVs
L3RkeC5jCj4+PiBAQCAtMTIsNiArMTIsNyBAQAo+Pj4gwqAgI2luY2x1ZGUgPGFzbS9pbnNuLmg+
Cj4+PiDCoCAjaW5jbHVkZSA8YXNtL2luc24tZXZhbC5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4
L3NjaGVkL3NpZ25hbC5oPiAvKiBmb3JjZV9zaWdfZmF1bHQoKSAqLwo+Pj4gKyNpbmNsdWRlIDxs
aW51eC9zd2lvdGxiLmg+Cj4+PiDCoCAvKiBURFggTW9kdWxlIGNhbGwgTGVhZiBJRHMgKi8KPj4+
IMKgICNkZWZpbmUgVERYX0dFVF9JTkZPwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxCj4+PiBAQCAt
NTc3LDYgKzU3OCw3IEBAIHZvaWQgX19pbml0IHRkeF9lYXJseV9pbml0KHZvaWQpCj4+PiDCoMKg
wqDCoMKgIHB2X29wcy5pcnEuaGFsdCA9IHRkeF9oYWx0Owo+Pj4gwqDCoMKgwqDCoCBsZWdhY3lf
cGljID0gJm51bGxfbGVnYWN5X3BpYzsKPj4+ICvCoMKgwqAgc3dpb3RsYl9mb3JjZSA9IFNXSU9U
TEJfRk9SQ0U7Cj4+PiDCoMKgwqDCoMKgIGNwdWhwX3NldHVwX3N0YXRlKENQVUhQX0FQX09OTElO
RV9EWU4sICJ0ZHg6Y3B1X2hvdHBsdWciLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5VTEwsIHRkeF9jcHVfb2ZmbGluZV9wcmVwYXJlKTsKPj4+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9tbS9tZW1fZW5jcnlwdC5jIGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYwo+Pj4gaW5k
ZXggNWQ3ZmJlZDczOTQ5Li44Mzg1YmM0NTY1ZTkgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL3g4Ni9t
bS9tZW1fZW5jcnlwdC5jCj4+PiArKysgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jCj4+PiBA
QCAtNDM4LDE0ICs0MzgsMTEgQEAgc3RhdGljIHZvaWQgcHJpbnRfbWVtX2VuY3J5cHRfZmVhdHVy
ZV9pbmZvKHZvaWQpCj4+PiDCoCB9Cj4+PiDCoCAvKiBBcmNoaXRlY3R1cmUgX193ZWFrIHJlcGxh
Y2VtZW50IGZ1bmN0aW9ucyAqLwo+Pj4gLXZvaWQgX19pbml0IG1lbV9lbmNyeXB0X2luaXQodm9p
ZCkKPj4+ICt2b2lkIF9faW5pdCBhbWRfbWVtX2VuY3J5cHRfaW5pdCh2b2lkKQo+Pj4gwqAgewo+
Pj4gwqDCoMKgwqDCoCBpZiAoIXNtZV9tZV9tYXNrKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsKPj4+IC3CoMKgwqAgLyogQ2FsbCBpbnRvIFNXSU9UTEIgdG8gdXBkYXRlIHRoZSBTV0lP
VExCIERNQSBidWZmZXJzICovCj4+PiAtwqDCoMKgIHN3aW90bGJfdXBkYXRlX21lbV9hdHRyaWJ1
dGVzKCk7Cj4+PiAtCj4+PiDCoMKgwqDCoMKgIC8qCj4+PiDCoMKgwqDCoMKgwqAgKiBXaXRoIFNF
Viwgd2UgbmVlZCB0byB1bnJvbGwgdGhlIHJlcCBzdHJpbmcgSS9PIGluc3RydWN0aW9ucywKPj4+
IMKgwqDCoMKgwqDCoCAqIGJ1dCBTRVYtRVMgc3VwcG9ydHMgdGhlbSB0aHJvdWdoIHRoZSAjVkMg
aGFuZGxlci4KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9jb21tb24u
YyAKPj4+IGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfY29tbW9uLmMKPj4+IGluZGV4IDExOWE5
MDU2ZWZiYi4uNmZlNDRjNmNiNzUzIDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2Vu
Y3J5cHRfY29tbW9uLmMKPj4+ICsrKyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2NvbW1vbi5j
Cj4+PiBAQCAtMTAsNiArMTAsNyBAQAo+Pj4gwqAgI2luY2x1ZGUgPGFzbS9tZW1fZW5jcnlwdF9j
b21tb24uaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgo+Pj4gwqAgI2lu
Y2x1ZGUgPGxpbnV4L2NjX3BsYXRmb3JtLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3N3aW90bGIu
aD4KPj4+IMKgIC8qIE92ZXJyaWRlIGZvciBETUEgZGlyZWN0IGFsbG9jYXRpb24gY2hlY2sgLSAK
Pj4+IEFSQ0hfSEFTX0ZPUkNFX0RNQV9VTkVOQ1JZUFRFRCAqLwo+Pj4gwqAgYm9vbCBmb3JjZV9k
bWFfdW5lbmNyeXB0ZWQoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4gQEAgLTI0LDMgKzI1LDE2IEBA
IGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+IMKgwqDC
oMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4gwqAgfQo+Pj4gKwo+Pj4gKy8qIEFyY2hpdGVjdHVyZSBf
X3dlYWsgcmVwbGFjZW1lbnQgZnVuY3Rpb25zICovCj4+PiArdm9pZCBfX2luaXQgbWVtX2VuY3J5
cHRfaW5pdCh2b2lkKQo+Pj4gK3sKPj4+ICvCoMKgwqAgLyoKPj4+ICvCoMKgwqDCoCAqIEZvciBU
RFggZ3Vlc3Qgb3IgU0VWL1NNRSwgY2FsbCBpbnRvIFNXSU9UTEIgdG8gdXBkYXRlCj4+PiArwqDC
oMKgwqAgKiB0aGUgU1dJT1RMQiBETUEgYnVmZmVycwo+Pj4gK8KgwqDCoMKgICovCj4+PiArwqDC
oMKgIGlmIChzbWVfbWVfbWFzayB8fCBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9NRU1f
RU5DUllQVCkpCj4+Cj4+IENhbid0IHlvdSBqdXN0IG1ha2UgdGhpczoKPj4KPj4gwqDCoMKgwqDC
oGlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9NRU1fRU5DUllQVCkpCj4+Cj4+IFNFViB3aWxs
IHJldHVybiB0cnVlIGlmIHNtZV9tZV9tYXNrIGlzIG5vdCB6ZXJvIGFuZCBURFggc2hvdWxkIG9u
bHkgCj4+IHJldHVybiB0cnVlIGlmIGl0IGlzIFREWCBndWVzdCwgcmlnaHQ/Cj4gCj4gWWVzLiBJ
dCBjYW4gYmUgc2ltcGxpZmllZC4KPiAKPiBCdXQgd2hlcmUgc2hhbGwgd2UgbGVhdmUgdGhpcyBm
dW5jdGlvbiBjY19wbGF0Zm9ybS5jIG9yIGhlcmU/CgpFaXRoZXIgb25lIHdvcmtzLi4uICBhbGwg
ZGVwZW5kcyBvbiBob3cgdGhlIG1haW50YWluZXJzIGZlZWwgYWJvdXQgCmNyZWF0aW5nL3VzaW5n
IG1lbV9lbmNyeXB0X2NvbW1vbi5jIG9yIHVzaW5nIGNjX3BsYXRmb3JtLmMuCgpUaGFua3MsClRv
bQoKPiAKPj4KPj4gVGhhbmtzLAo+PiBUb20KPj4KPj4+ICvCoMKgwqDCoMKgwqDCoCBzd2lvdGxi
X3VwZGF0ZV9tZW1fYXR0cmlidXRlcygpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBhbWRfbWVtX2VuY3J5
cHRfaW5pdCgpOwo+Pj4gK30KPj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
