Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B2C4321E
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 17:22:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90298610E7
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 17:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90298610E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C6F7839E5;
	Wed, 20 Oct 2021 17:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18zplXSA1-Ic; Wed, 20 Oct 2021 17:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D232283AF9;
	Wed, 20 Oct 2021 17:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5780C000F;
	Wed, 20 Oct 2021 17:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3653CC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11CF96084F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdjGmTM5h4Dk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:22:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C228260639
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 17:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k57gr5yaKHEefr5DMUtBF/gx64vXmKrQmp2Zv88wcPrO8H7bj7NEINdv72JL8JBR7VwOY3sX/wmHEt1UK2Et5d0BP0Dh1bS6ftIqaAzM2wRmpLRO73tsTQ/nUfi0GhOlkS6NyCI7VWSzRXOTo5d9OJf5ppweO58S7da/O81+E7AzVPzIVOcVvl0/LgKqg7XFq6PmnVcmj7GJo4Y3qVJWb170Y3Wxivi8g8vZPkQo/FXhkYtwDi3D9KPiR3Am4WWQlpfpdBXQhcGZr2fXpsA0gPMc+5tfkDLgXmGS/X4zPjs3C8V6eWyFzWbumG8TBhs+xAs16/60xl3EY3XKy/HNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1qZpG8ptqbie5y77VPiOpqV1HQb5pLUVW03iOwOHMo=;
 b=kphZO1vGmHEkdzHKflcVmE3rWsiDg9Be1G4ge3I8aop9SJ18k2pUl2xPgkQ9nGtdMECooeJvRo8euRIbrFNRADMd9a4axDOaAvopNY2NaiYxwx5/r60g98glvUxp2rdrQKkV5R+n4iG4xxVjfqbfeQ04EaDx0ESebXgQfrF2nwxHtX9LT49KoFeJ9ncmvK+8q7eMBDqSR4qg+MmZ3TgmXikaSNs5lXo0Wo/0u0y37NpTwnCm1hAwkP3TSrvJ+YNXjbuw4oxHmA6aFU8A3LRmZyLhGL3GkHnMb10zFgxh/bMsje1nKBWwnJfatP/aPlKMW+Q+M6gPC2j3MTK+8zWDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1qZpG8ptqbie5y77VPiOpqV1HQb5pLUVW03iOwOHMo=;
 b=GOb/6zhVrHzjmrBhricdL6DE8hZrQMoRxIsdnR/sW28BuI82g2CQGZJpYPKWCnOoj2KXWcR9cqjxL0AetvMGLgj9ocQnMvUFcawoXImj5sVx3P5ByyDQFNN2Nk6Fc3U2RPvBBFHtsffe1tdQkjEGjuij+fYIVU56c45/emN7iFw=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 17:22:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 17:22:46 +0000
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
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
 <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <654455db-a605-5069-d652-fe822ae066b0@amd.com>
 <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
Message-ID: <0b06e686-b0d8-9485-ae00-b23f805916d9@amd.com>
Date: Wed, 20 Oct 2021 12:22:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <66acafb6-7659-7d76-0f52-d002cfae9cc8@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 17:22:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bab281-1fc6-4544-375e-08d993ee3b9a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-Microsoft-Antispam-PRVS: <DM4PR12MB507129E644B2BEDA5BD672D4ECBE9@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKPAY8h+09cfbSK+y5V9rSy3I7c5V53XRTZUX506Ann+myx3ltgXLqm3RTxv+kzgpGklZzwjcJ3eWFNZXyGEQW6z9ySSNQ+gr4LOLxsTOTIN3eayLDN0YPpNy9XeIH0/icJE8lN+MCa6mXkFQtMn4i9itC7Scat4lKtSvjaAeuZYg9cXIdXZbX84Vs+o4EHLbYy7yVubdISJAKHazxHphPbFtq0dtSg39wpJBsac/CXEv1tmjrjnsl3DSIDNhme5I31kk9B+48IMqfT5z6lzyFnlULbF2ZsSmyQwUd6Bz1IGwPRSI3Qr5HfPyivOpbRXRILA22TMnXCw/tX3pAJWE5qkytMFPi9u13BxvgXPGlhHIMKZ4//GyyEjKOyyhK5Sd2CunQMOtdaoQpDT3jEjS3xC9qsNs18hTPQ8/CWN9+0TdkK4boizl6KHhy1Gf0YCbNqiL2+6yZ6jfGBQU3p8VrLwGzy2UawK5hjkiad7kXghs6CWdmOSuyxyuX4ZKfTGOASWNxyNebj5qDd6O1tUpKGUeHk+hKe3a4EuRrBoXQwLFnF3WeLK7b0QlKl/ZHDlXYy8nRQ7Gp3B0TpMGkmEt08FSXLoG+O2Mo07eOQ79I7diZZS/vynGhhIGM5NqnjEkd1VMyw1A85j1tYhvHXABtvU0hrGknPXlZksvA1UkbpNhfb8rtJrvR0OWNMg6BExzKVPBcVTL65JBFgxovVdepJ+9y5J0x4G4lFKsVWLBaMKgfkWaurTx76CdugqglAFOg0jhOs2Why9Uy6l6QAzng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(16576012)(7416002)(186003)(2906002)(508600001)(66946007)(86362001)(7406005)(8936002)(26005)(4326008)(5660300002)(66476007)(66556008)(36756003)(316002)(956004)(2616005)(53546011)(921005)(31696002)(110136005)(8676002)(6486002)(54906003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRNUUJDRlhmVXdDOVdSVmJvTXUyMjk2OWlucmxuN3c1b3Q3V2VTSGZWaWdE?=
 =?utf-8?B?VWhpNFlUYlg5UE14RVNheEJnSW4vVlhhRGQ1Vnkra0RKZjhtbS9LUSswMkll?=
 =?utf-8?B?VlNHall1UDR3cnJRN1RsL21ld2IyMUV1NFVtN0NJNlRjelMyZWZQUzFPTm9Q?=
 =?utf-8?B?STZiWHIxdndsTFUyaGRiaGJEMmVSM3JLQUI0QW11cVZ2RVMydzE0cjdyUU1i?=
 =?utf-8?B?NjZZNSsvM09rU3A1WGd2eE1KejYyZUM2TTlvcjVGZ24xZXRIS3BTQ0dEMFpZ?=
 =?utf-8?B?cVl6ZEJJREtTdTVtS01obWhwSTFFVEVHa1RYcEVFc3htV1VZLzVLMURoU0tV?=
 =?utf-8?B?Z0xSZVJSbzZTRmpzdUF6bklyaGRJT0l6WmxSN1IwMmV4RjREMHJNOS84dzQy?=
 =?utf-8?B?OXRLa0FoSGtmMmxwSlpmN1FTankwaER5THRHZTVPOUJLN3JCSVFUNmNxSzZa?=
 =?utf-8?B?YjRnZWhRL3RaaVUrRDNDb25TWHZZSDVqZXNtdVBoaDAxTlg3Nll3YmxmaHNv?=
 =?utf-8?B?MVkrMUlrWStKVVJaTzBOQzhMbERkMVJ2TFAydGgxeENVY29pempXdnVaWEdv?=
 =?utf-8?B?TkNjSnlFbUFNMXdtck8wNUNuR0NuOXBUOUZ4ckRUS0FWSnZLT3hqSm1OOTdF?=
 =?utf-8?B?OWxMMUhQT0VBZkp3MXBhNTNjcFNXTUR1endrZUExT25zT1BYeDAvU3puTFFt?=
 =?utf-8?B?MXM5Yy9ZTHlpbmZybzFzYXVQTjFWU0ZYcEQ4VzlobFdzZTh5N0I4cjBHdGEr?=
 =?utf-8?B?ZHdkTjBYS01LM0N2STdsQjk5TG1GSWpoUFZML0YvMDZ5WlF0UVlnYloybnpv?=
 =?utf-8?B?SHlZa2U3YTdnT05kUjZvMGZsSzFGeFdRTXAxZkprWTNUNDB2QTRZKzNjUnFm?=
 =?utf-8?B?d3dRVXlydC8wV1V1SjlENFZvTWJ6eFl2Vm5ZUHVKVWc4dVUrb3NUQnk4VEhJ?=
 =?utf-8?B?MG15Y25DL3J4YjZPY0ptRkxOc0xkYzhGdFVLWmt5djlhNVNSUFAvNmRYbzM0?=
 =?utf-8?B?ZERhMWNLRE9tL3daK0duK0tVaVhmMWFKb05aWHdwMnNSUHlEVC95Wk1rVnZM?=
 =?utf-8?B?VXJIWnFrelZLSW1LcmhqSjRUZDRIS0pwNDl3Tm5FSXRlQjlVbE5BaFZnaC93?=
 =?utf-8?B?S21zYXlldmQyT1NlRDJVMEE2d1QvZ3FVVnA1ckFhNWl3dGhURHRMdElOblMr?=
 =?utf-8?B?enV4QU9pUStzVWIxYlBCTXB4TnRtenM3b0JCMXZKaTJCb1NZTGtzaEJzQXRZ?=
 =?utf-8?B?U0I2eVdjb3VISy9kR3A5T0ZxWTdJa0FGK2IwOFBQNUJlRWxLZjF6TGFWQXJY?=
 =?utf-8?B?OCszdGE2VkxJWDF5V2JhSUZBVmJJbjRqRFhYZnRvaFd0OVNTWXhzKzZ3czZL?=
 =?utf-8?B?WVQzN3RxZWlhZDQxbTIwaERnckY4cUZKbFhQc1E5a1lKSUszc3g2dzRSaGpB?=
 =?utf-8?B?YTVPZmlqbThEeTlOZTdoOHNQSkU4VXNkcnNpaHVwTkExcXJCcGhmdFZNN2RX?=
 =?utf-8?B?VTlTYXhEejZNd29pUW1abEVqRjZubDhEa1k4Z2ZzQjVVYy9Ia3BlYkJvTkJO?=
 =?utf-8?B?b050NWhqcXdWbWQzV1oxTXNVL3hvR0N1NFA3YVl2a3JFZ1IvTEJXY2xyWllS?=
 =?utf-8?B?Q2ZJT0gyYmhzNURPZ2JRME1lRm5yMkVmOE1oUHRrM0oxRW9janMvMnJQTERY?=
 =?utf-8?B?TW5aeTQ2bC9CSTdvOFAvUVAyVGhIYmt2cnlkV1Avb3BubC82SEwxTWZLNHZH?=
 =?utf-8?Q?DxFN9NL8dtffUaqCjgCZMAcznled9AzzhOOqMGP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bab281-1fc6-4544-375e-08d993ee3b9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 17:22:46.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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

T24gMTAvMjAvMjEgMTE6NDUgQU0sIFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15IHdyb3RlOgo+
IE9uIDEwLzIwLzIxIDk6MzMgQU0sIFRvbSBMZW5kYWNreSB3cm90ZToKPj4gT24gMTAvOC8yMSA3
OjM3IFBNLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKCi4uLgoKPj4+IMKgIGJv
b2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+IMKgIHsKPj4+
IC3CoMKgwqAgcmV0dXJuIGFtZF9mb3JjZV9kbWFfdW5lbmNyeXB0ZWQoZGV2KTsKPj4+ICvCoMKg
wqAgaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX1REWCkgJiYKPj4+ICvCoMKgwqDC
oMKgwqDCoCBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCkpCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChjY19wbGF0
Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCkgfHwKPj4+ICvCoMKgwqDCoMKgwqDC
oCBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9IT1NUX01FTV9FTkNSWVBUKSkKPj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gYW1kX2ZvcmNlX2RtYV91bmVuY3J5cHRlZChkZXYpOwo+Pj4gKwo+Pj4g
K8KgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Cj4+IEFzc3VtaW5nIHRoZSBvcmlnaW5hbCBmb3JjZV9k
bWFfdW5lbmNyeXB0ZWQoKSBmdW5jdGlvbiB3YXMgbW92ZWQgaGVyZSBvciAKPj4gY2NfcGxhdGZv
cm0uYywgdGhlbiB5b3Ugc2hvdWxkbid0IG5lZWQgYW55IGNoYW5nZXMuIEJvdGggU0VWIGFuZCBU
RFggCj4+IHJlcXVpcmUgdHJ1ZSBiZSByZXR1cm5lZCBpZiBDQ19BVFRSX0dVRVNUX01FTV9FTkNS
WVBUIHJldHVybnMgdHJ1ZS4gQW5kIAo+PiB0aGVuIFREWCBzaG91bGQgbmV2ZXIgcmV0dXJuIHRy
dWUgZm9yIENDX0FUVFJfSE9TVF9NRU1fRU5DUllQVC4KPiAKPiAKPiBGb3Igbm9uIFREWCBjYXNl
LCBpbiBDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQsIHdlIHNob3VsZCBzdGlsbCBjYWxsCj4gYW1k
X2ZvcmNlX2RtYV91bmVuY3J5cHRlZCgpIHJpZ2h0PwoKV2hhdCBJJ20gc2F5aW5nIGlzIHRoYXQg
eW91IHdvdWxkbid0IGhhdmUgYW1kX2ZvcmNlX2RtYV91bmVuY3J5cHRlZCgpLiBJIAp0aGluayB0
aGUgd2hvbGUgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKCkgY2FuIGV4aXN0IGFzLWlzIGluIGEgZGlm
ZmVyZW50IApmaWxlLCB3aGV0aGVyIHRoYXQncyBjY19wbGF0Zm9ybS5jIG9yIG1lbV9lbmNyeXB0
X2NvbW1vbi5jLgoKSXQgd2lsbCByZXR1cm4gdHJ1ZSBmb3IgYW4gU0VWIG9yIFREWCBndWVzdCwg
dHJ1ZSBmb3IgYW4gU01FIGhvc3QgYmFzZWQgb24gCnRoZSBETUEgbWFzayBvciBlbHNlIGZhbHNl
LiBUaGF0IHNob3VsZCB3b3JrIGp1c3QgZmluZSBmb3IgVERYLgoKVGhhbmtzLApUb20KCj4gCj4+
Cj4+PiDCoCB9Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYyBi
L2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMKPj4+IGluZGV4IDUyNzk1NzU4NmYzYy4uNmM1
MzFkNWNiNWZkIDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYwo+
Pj4gKysrIGIvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYwo+Pj4gQEAgLTMwLDYgKzMwLDcg
QEAKPj4+IMKgICNpbmNsdWRlIDxhc20vcHJvdG8uaD4KPj4+IMKgICNpbmNsdWRlIDxhc20vbWVt
dHlwZS5oPgo+Pj4gwqAgI2luY2x1ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+Cj4+PiArI2luY2x1ZGUg
PGFzbS90ZHguaD4KPj4+IMKgICNpbmNsdWRlICIuLi9tbV9pbnRlcm5hbC5oIgo+Pj4gQEAgLTE5
ODEsOCArMTk4MiwxMCBAQCBpbnQgc2V0X21lbW9yeV9nbG9iYWwodW5zaWduZWQgbG9uZyBhZGRy
LCBpbnQgCj4+PiBudW1wYWdlcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX3BncHJvdChfUEFHRV9HTE9CQUwpLCAwKTsKPj4+IMKgIH0KPj4+IC1zdGF0
aWMgaW50IF9fc2V0X21lbW9yeV9lbmNfZGVjKHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBh
Z2VzLCBib29sIAo+Pj4gZW5jKQo+Pj4gK3N0YXRpYyBpbnQgX19zZXRfbWVtb3J5X3Byb3RlY3Qo
dW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMsIGJvb2wgCj4+PiBwcm90ZWN0KQo+Pj4g
wqAgewo+Pj4gK8KgwqDCoCBwZ3Byb3RfdCBtZW1fcHJvdGVjdGVkX2JpdHMsIG1lbV9wbGFpbl9i
aXRzOwo+Pj4gK8KgwqDCoCBlbnVtIHRkeF9tYXBfdHlwZSBtYXBfdHlwZTsKPj4+IMKgwqDCoMKg
wqAgc3RydWN0IGNwYV9kYXRhIGNwYTsKPj4+IMKgwqDCoMKgwqAgaW50IHJldDsKPj4+IEBAIC0x
OTk3LDggKzIwMDAsMjUgQEAgc3RhdGljIGludCBfX3NldF9tZW1vcnlfZW5jX2RlYyh1bnNpZ25l
ZCBsb25nIAo+Pj4gYWRkciwgaW50IG51bXBhZ2VzLCBib29sIGVuYykKPj4+IMKgwqDCoMKgwqAg
bWVtc2V0KCZjcGEsIDAsIHNpemVvZihjcGEpKTsKPj4+IMKgwqDCoMKgwqAgY3BhLnZhZGRyID0g
JmFkZHI7Cj4+PiDCoMKgwqDCoMKgIGNwYS5udW1wYWdlcyA9IG51bXBhZ2VzOwo+Pj4gLcKgwqDC
oCBjcGEubWFza19zZXQgPSBlbmMgPyBfX3BncHJvdChfUEFHRV9FTkMpIDogX19wZ3Byb3QoMCk7
Cj4+PiAtwqDCoMKgIGNwYS5tYXNrX2NsciA9IGVuYyA/IF9fcGdwcm90KDApIDogX19wZ3Byb3Qo
X1BBR0VfRU5DKTsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRS
X0dVRVNUX1NIQVJFRF9NQVBQSU5HX0lOSVQpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtX3By
b3RlY3RlZF9iaXRzID0gX19wZ3Byb3QoMCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbWVtX3BsYWlu
X2JpdHMgPSBwZ3Byb3RfY2Nfc2hhcmVkX21hc2soKTsKPj4KPj4gSG93IGFib3V0IGhhdmluZyBn
ZW5lcmljIHZlcnNpb25zIGZvciBib3RoIHNoYXJlZCBhbmQgcHJpdmF0ZSB0aGF0IAo+PiByZXR1
cm4gdGhlIHByb3BlciB2YWx1ZSBmb3IgU0VWIG9yIFREWC4gVGhlbiB0aGlzIHJlbWFpbnMgbG9v
a2luZyAKPj4gc2ltaWxhciB0byBhcyBpdCBkb2VzIG5vdywganVzdCByZXBsYWNpbmcgdGhlIF9f
cGdwcm90KCkgY2FsbHMgd2l0aCB0aGUgCj4+IGFwcHJvcHJpYXRlIHBncHJvdF9jY197c2hhcmVk
LHByaXZhdGV9X21hc2soKS4KPiAKPiBNYWtlcyBzZW5zZS4KPiAKPj4KPj4gVGhhbmtzLAo+PiBU
b20KPj4KPj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1fcHJvdGVj
dGVkX2JpdHMgPSBfX3BncHJvdChfUEFHRV9FTkMpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbV9w
bGFpbl9iaXRzID0gX19wZ3Byb3QoMCk7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAg
aWYgKHByb3RlY3QpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBjcGEubWFza19zZXQgPSBtZW1fcHJv
dGVjdGVkX2JpdHM7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY3BhLm1hc2tfY2xyID0gbWVtX3BsYWlu
X2JpdHM7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbWFwX3R5cGUgPSBURFhfTUFQX1BSSVZBVEU7Cj4+
PiArwqDCoMKgIH0gZWxzZSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY3BhLm1hc2tfc2V0ID0gbWVt
X3BsYWluX2JpdHM7Cj4+PiArwqDCoMKgwqDCoMKgwqAgY3BhLm1hc2tfY2xyID0gbWVtX3Byb3Rl
Y3RlZF9iaXRzOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hcF90eXBlID0gVERYX01BUF9TSEFSRUQ7
Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+IMKgwqDCoMKgwqAgY3BhLnBnZCA9IGluaXRfbW0ucGdk
Owo+Pj4gwqDCoMKgwqDCoCAvKiBNdXN0IGF2b2lkIGFsaWFzaW5nIG1hcHBpbmdzIGluIHRoZSBo
aWdobWVtIGNvZGUgKi8KPj4+IEBAIC0yMDA2LDkgKzIwMjYsMTcgQEAgc3RhdGljIGludCBfX3Nl
dF9tZW1vcnlfZW5jX2RlYyh1bnNpZ25lZCBsb25nIAo+Pj4gYWRkciwgaW50IG51bXBhZ2VzLCBi
b29sIGVuYykKPj4+IMKgwqDCoMKgwqAgdm1fdW5tYXBfYWxpYXNlcygpOwo+Pj4gwqDCoMKgwqDC
oCAvKgo+Pj4gLcKgwqDCoMKgICogQmVmb3JlIGNoYW5naW5nIHRoZSBlbmNyeXB0aW9uIGF0dHJp
YnV0ZSwgd2UgbmVlZCB0byBmbHVzaCBjYWNoZXMuCj4+PiArwqDCoMKgwqAgKiBCZWZvcmUgY2hh
bmdpbmcgdGhlIGVuY3J5cHRpb24gYXR0cmlidXRlLCBmbHVzaCBjYWNoZXMuCj4+PiArwqDCoMKg
wqAgKgo+Pj4gK8KgwqDCoMKgICogRm9yIFREWCwgZ3Vlc3QgaXMgcmVzcG9uc2libGUgZm9yIGZs
dXNoaW5nIGNhY2hlcyBvbiAKPj4+IHByaXZhdGUtPnNoYXJlZAo+Pj4gK8KgwqDCoMKgICogdHJh
bnNpdGlvbi4gVk1NIGlzIHJlc3BvbnNpYmxlIGZvciBmbHVzaGluZyBvbiBzaGFyZWQtPnByaXZh
dGUuCj4+PiDCoMKgwqDCoMKgwqAgKi8KPj4+IC3CoMKgwqAgY3BhX2ZsdXNoKCZjcGEsICF0aGlz
X2NwdV9oYXMoWDg2X0ZFQVRVUkVfU01FX0NPSEVSRU5UKSk7Cj4+PiArwqDCoMKgIGlmIChjY19w
bGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9URFgpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KG1hcF90eXBlID09IFREWF9NQVBfU0hBUkVEKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3BhX2ZsdXNoKCZjcGEsIDEpOwo+Pj4gK8KgwqDCoCB9IGVsc2Ugewo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGNwYV9mbHVzaCgmY3BhLCAhdGhpc19jcHVfaGFzKFg4Nl9GRUFUVVJFX1NNRV9DT0hFUkVO
VCkpOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIHJldCA9IF9fY2hhbmdlX3BhZ2VfYXR0
cl9zZXRfY2xyKCZjcGEsIDEpOwo+Pj4gQEAgLTIwMjEsMTggKzIwNDksMjEgQEAgc3RhdGljIGlu
dCBfX3NldF9tZW1vcnlfZW5jX2RlYyh1bnNpZ25lZCBsb25nIAo+Pj4gYWRkciwgaW50IG51bXBh
Z2VzLCBib29sIGVuYykKPj4+IMKgwqDCoMKgwqDCoCAqLwo+Pj4gwqDCoMKgwqDCoCBjcGFfZmx1
c2goJmNwYSwgMCk7Cj4+PiArwqDCoMKgIGlmICghcmV0ICYmIGNjX3BsYXRmb3JtX2hhcyhDQ19B
VFRSX0dVRVNUX1NIQVJFRF9NQVBQSU5HX0lOSVQpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9
IHRkeF9oY2FsbF9ncGFfaW50ZW50KF9fcGEoYWRkciksIG51bXBhZ2VzLCBtYXBfdHlwZSk7Cj4+
PiArCj4+PiDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiDCoCB9Cj4+PiDCoCBpbnQgc2V0X21l
bW9yeV9lbmNyeXB0ZWQodW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMpCj4+PiDCoCB7
Cj4+PiAtwqDCoMKgIHJldHVybiBfX3NldF9tZW1vcnlfZW5jX2RlYyhhZGRyLCBudW1wYWdlcywg
dHJ1ZSk7Cj4+PiArwqDCoMKgIHJldHVybiBfX3NldF9tZW1vcnlfcHJvdGVjdChhZGRyLCBudW1w
YWdlcywgdHJ1ZSk7Cj4+PiDCoCB9Cj4+PiDCoCBFWFBPUlRfU1lNQk9MX0dQTChzZXRfbWVtb3J5
X2VuY3J5cHRlZCk7Cj4+PiDCoCBpbnQgc2V0X21lbW9yeV9kZWNyeXB0ZWQodW5zaWduZWQgbG9u
ZyBhZGRyLCBpbnQgbnVtcGFnZXMpCj4+PiDCoCB7Cj4+PiAtwqDCoMKgIHJldHVybiBfX3NldF9t
ZW1vcnlfZW5jX2RlYyhhZGRyLCBudW1wYWdlcywgZmFsc2UpOwo+Pj4gK8KgwqDCoCByZXR1cm4g
X19zZXRfbWVtb3J5X3Byb3RlY3QoYWRkciwgbnVtcGFnZXMsIGZhbHNlKTsKPj4+IMKgIH0KPj4+
IMKgIEVYUE9SVF9TWU1CT0xfR1BMKHNldF9tZW1vcnlfZGVjcnlwdGVkKTsKPj4+Cj4gCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
