Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E626C43217
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 16:33:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7034600D4
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 16:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7034600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A574140577;
	Wed, 20 Oct 2021 16:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eh_2BGGhDAFM; Wed, 20 Oct 2021 16:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFF3D4011B;
	Wed, 20 Oct 2021 16:33:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AAE8C0011;
	Wed, 20 Oct 2021 16:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26693C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 16:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 144BB60D50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 16:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYTM5n7-iER6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 16:33:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1CB460D4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 16:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbVoSV0r8GDgdInozEEEMh76pEfAZ6yXQIFL43B9i7IgSIxyHWsCw+7bzbeIA11TB/wy1QLGefptoUNDAhb/ipaflZJTkIoubfScQGdLMKIM2kG5cbZnZFmmAUj6+dewJe22oY9aQo3Hp1oMuDKAUnV0lcs28om3OipjLEM2aynn9u3Wg5rySbucszVhxbVKHplX2pdTIaaCSFSO8dLJwHfoGgRufWh3v8TjAuPhqYKuaWUeP2+zQjap4Ix242SmT8PIFmwIYIpzKu8KFrsh6uL98fD6qr+kwF185LZIgjQOULG7e1f/xv2Shzee0/D8cfR4Xtbz5fVAcl5w8H8H1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le6PRjWVcNiZAv9Pe+YpzbK8xwwzgS0gBiPn3/Norso=;
 b=jqm66lEcG3tZcPs0TX6nf8pgJOjFBxg32KrlUhCGcUTxO9BjjgWgw7+4gXaaiGpfxdE9pnEjAIwe6ycjBUBhs+7FOJhty9PWB/mlqHtyVlstay08jG/AhFE98wgH+luQkddrB4Bqn7IkiMhiIGO5SQ4TjNl2MUHS75bD1831Ohal6UZ88N/9iETNjSpzvrpkOJCp5IGPNDFqKZaiAmAJnpNWtPAL8jP1pfTEkeSzj9SkjMP5jVBNqh7STBbs/F3sL2hMKBeocLBlfP2I3gcPwPPorUxB9WA9ztldbVhNrW2aEUQGFuS7jABVjR74udu+O0oGHVuqq/hv/KEM7COvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le6PRjWVcNiZAv9Pe+YpzbK8xwwzgS0gBiPn3/Norso=;
 b=0Rhiw6/1NIcZi2e+wprcsE2gSatZNrHjh0j2ZnQmV877dL8kgEEDViIdtNKKg9B7vRlPCPS3U1qx6r/emBIDNMMUDtTSJWJu7wtKKEj5wwzb+fI7VjQFA6fDJyKkkaGHt8NydP9hwKNIylWtaCq7DiBouz1EfGF1hOMIsS1dVAA=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 16:33:16 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 16:33:16 +0000
Subject: Re: [PATCH v5 06/16] x86/tdx: Make DMA pages shared
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Message-ID: <654455db-a605-5069-d652-fe822ae066b0@amd.com>
Date: Wed, 20 Oct 2021 11:33:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211009003711.1390019-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: CH0PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:610:77::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 CH0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:610:77::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 16:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01b379fa-a0f5-41db-c9b6-08d993e75144
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB539102C1498A742989959C0DECBE9@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gMnQeN560BInQlUElAMbGPjgxuk3S6Ir8HDe22dyly5TXuQ1pn9S9RnXdOMWq3oVuTOvsaTTyA/T/Y+lB+SSq6ozlwafUMMoj6IEBWT+yex5GV8vmV285DPdlN2Z1aGxIIVzrnSaxtISkMio3yXkNBMprgigi+JaQipURaPNSlZDvgrf5s2JTM3cT+bG4MoO4RBUKpL4cWt/krmWfVHjdcu4dHIjh8UohXeGi9wLqHdeCuHg3wgEam+bJvD34Bw9KGMY7TTxxbJdxVIy8Q9ikBbnNWrlyNWwWDOJ8n5kB/W+lrQPXiFzmXzN09D+357PyS12vvHm9P+o1mGTpuAosTfFImWxiSzMdspGY1qDP/ADgkWlZX7NNurD8x7VdMqIxAyZrmeaWMdIOtcS5pcZS7xYhXH77heCj3MCC7lEwNDaafoyPHwXFtWgXTMAeNcPnHQSa/6bJnBSl4Tu4LjGUNMY14MQhaSsKwKCQjQGXCdvX+lXQN35mnI5pfruWFCAIbdZvP+FVoKEUM8ZahCBLAdfNn+jYVl0j+3pZKcIxbjphYxDeqUpHTPKgWK1vxLdaokUibEkChiSNrD5pu1Rdbn1Zbyan9k5Cik7hGG2ZgazP4cBjXrnZY5owgCQbk4OoXck6UdABZqOrfM+Yabe3gRD4T5ZYLape9X1PhjjY2+tldA0qUIeemd3jhA8pRs8VOirk+ldxxNKDTrDVMckc0UCLfoJ/75VIy9/k5UMmC1AEF/KugcsGrQexbJuLcRLg8AcHdQ3HNl5aaCkvi4x4RubollOHoZWbiLJUETnEBvOnSL/hguFtEomazqjR19Pt0HWFewU/SNXpArnnMRHwRlBn1xXFB0L1C3PGF4Ot4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(45080400002)(66476007)(86362001)(110136005)(53546011)(7406005)(26005)(316002)(2906002)(7416002)(16576012)(36756003)(31696002)(66946007)(921005)(186003)(54906003)(83380400001)(4326008)(508600001)(8936002)(8676002)(966005)(6486002)(31686004)(5660300002)(38100700002)(2616005)(956004)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njd5eXIwME5tenhxaTlTNUlDRVI4ckw5Mmkvakwrb2pZUFFTV29tR3cyMUp6?=
 =?utf-8?B?SlFlOHpvOW9XN1JMcGhrLytJODQvQ2ZPalBzU3ptTnRYL3VOaXRQL1gvcEsx?=
 =?utf-8?B?YUlETjJLZ1ZHRWhhNTVxTWdMMWc2MURVdUVEWi9MbGNQMjY2bFIyVXBpVVJU?=
 =?utf-8?B?b0pEK1NnNnNMR3RmaEFqdmRwK0dsNVI5dHBNWGpIWVFTcDVacUpDcjhMRDg0?=
 =?utf-8?B?L0ROY1ZvSUpzbHlwRlhYZytsOC9wdHY3MFFIL2d6SS90MzgzZ3MrMUhBOTUz?=
 =?utf-8?B?Zkp6ZE9IakI5c2g3M0pyTENHTzhrb0V6bjNWU2h4MmU5QmFnQUQydFVZamNu?=
 =?utf-8?B?bVQ2ckpvTlI5aGxWYUVQb3pZL2d3NXg2YTZwRnMzaGJJNUJldlFrZFVHYkZ0?=
 =?utf-8?B?YVZwWGUyTTNEV0RlV3VFV3E5V2JBWDNmWUtHY3FleTcvSDBWczJESWNjVW5X?=
 =?utf-8?B?S1oycDZCcjZ0MElRWXMxSGE0czVuRFFSZFZDaVh2clFrZDZyN3FCRmRmWUUr?=
 =?utf-8?B?dm5TQUVEUUMrVlRhcWFKSW1HbDZxM05yNyszV25FZUk4SytqQmo0NTNDejNU?=
 =?utf-8?B?VEpxenFlVUgxZG11VlFwclVKblZMZEZRTTZ6YkNYa3N2aTNoMnZxd2hmbHB6?=
 =?utf-8?B?UDJPREFoRzNtRFRiTTFNZkF5SFJPYnIxQ2REQ3p5cjNWRSszN3BJV2hLZHp6?=
 =?utf-8?B?ZTYxTm1IbUNqNEJBSzg5eGM5akU2MW1LNkZPZ1ZmY3dHOFZuQ21jMEdURGdS?=
 =?utf-8?B?c2c2OGlIbFdvcDdpSXlUUmxPOFNKaUU1cDJBeFJVVzFDMWF6Nk9wUlJuY3M2?=
 =?utf-8?B?STZRUVVMdU9BZ0FNdlQ4QzFMQ3RHSWJKaENKR25JK05WM09kTVNyWU5CVnVW?=
 =?utf-8?B?M0hHUHZwdHUrNkRzZWFsNDhOUERJTnRSRzZSMFJVMnZ0VGR0VXgwRndmNm5Y?=
 =?utf-8?B?eTNYUTVVWmFQcUVhaERCTHdWVWFkMm1OeVJtZnNrMkFMRDZJUWFwNEsxZkwr?=
 =?utf-8?B?djNhYU9MTWRzMU9KNFYxdUFOV0FLUXdxTm0zbVRsTFFFN2s0K0lpNWtTNEFy?=
 =?utf-8?B?TTU2aEc1YUFYUTlCUXE3RW1pVFBOTWRxZ2FwS0t6UXNyNmdRYUpFcWFHaENZ?=
 =?utf-8?B?cmk2eGpDbk9mTjlvRGNLN054NUJDck9OMHh5S0VCQnZYSFdkQ0dmWmlqWWxp?=
 =?utf-8?B?STFjRXhLYTlXTHhiWlBoTnI4WFlVSkpvYWpubWFhUkwvODREcVh0V21nK2dM?=
 =?utf-8?B?STN1Q1NpVlBUa2lHSWR6Vnhza1grSGRvbjd0WlA0WEpwQTFhZU5uWEdBcXBm?=
 =?utf-8?B?cVBQUTE2TWp5NWM4M3lRNDZxbjlWRUNQWTU1a0JGZ1RyZTA1bXhYbzZZSS93?=
 =?utf-8?B?QlRvczkydG50VTJxQ0Z3cUtibFFtT2tRWitVakJUaVBmbkRjdnFzbGhvQWJD?=
 =?utf-8?B?bDZ2eFh4OS9HdWFmSzBxQ0syb1ROODU4US9tdTI5SkxuWUxrOVRWbGRCekJV?=
 =?utf-8?B?U2RKY2V0U29uMi9yRGI3NEZHdlFnTnBKcXB3NXV3c2xBVmE5VHpuWFA1Q2FQ?=
 =?utf-8?B?dW14MXRYc2NSdW52ZHlZTXdRWVQ3VHNJcDhiSW44aERteUhVUnFKbUovSmlk?=
 =?utf-8?B?T0lyTjVqdUU2MFZlVUkwZzFZZXV3Qm9CbHhpeEszNWhRRk1GOHZ5MmhEempv?=
 =?utf-8?B?VEZEYi9NY2xHVkFpalM4ZlQvWlRuUE51a2hGNW9NbGNZVXI2RlZaNWlSTmtK?=
 =?utf-8?B?SDJOeGNlN1RkVk5zcDRIeHV5MEtPNDZkaytsUEJGSlJZcnJ0QmZXbjA1Q1hF?=
 =?utf-8?B?eXA0R1ZrT0tnMUZ4MzV1QnZ3dmsvQzlpNXRnL21sWUcwREtuNWg0NjJGZ0lu?=
 =?utf-8?B?akovQUVRWTE3V2QybFoxNkJSN1R6QjFXa0YyWEZQTWowaGNDdTRXSzlnOFB0?=
 =?utf-8?Q?7n8cs8ypMao=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b379fa-a0f5-41db-c9b6-08d993e75144
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:33:16.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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

T24gMTAvOC8yMSA3OjM3IFBNLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKPiBG
cm9tOiAiS2lyaWxsIEEuIFNodXRlbW92IiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNv
bT4KPiAKPiBKdXN0IGxpa2UgTUtUTUUsIFREWCByZWFzc2lnbnMgYml0cyBvZiB0aGUgcGh5c2lj
YWwgYWRkcmVzcyBmb3IKPiBtZXRhZGF0YS4gIE1LVE1FIHVzZWQgc2V2ZXJhbCBiaXRzIGZvciBh
biBlbmNyeXB0aW9uIEtleUlELiBURFgKPiB1c2VzIGEgc2luZ2xlIGJpdCBpbiBndWVzdHMgdG8g
Y29tbXVuaWNhdGUgd2hldGhlciBhIHBoeXNpY2FsIHBhZ2UKPiBzaG91bGQgYmUgcHJvdGVjdGVk
IGJ5IFREWCBhcyBwcml2YXRlIG1lbW9yeSAoYml0IHNldCB0byAwKSBvcgo+IHVucHJvdGVjdGVk
IGFuZCBzaGFyZWQgd2l0aCB0aGUgVk1NIChiaXQgc2V0IHRvIDEpLgo+IAo+IF9fc2V0X21lbW9y
eV9lbmNfZGVjKCkgaXMgbm93IGF3YXJlIGFib3V0IFREWCBhbmQgc2V0cyBTaGFyZWQgYml0Cj4g
YWNjb3JkaW5nbHkgZm9sbG93aW5nIHdpdGggcmVsZXZhbnQgVERYIGh5cGVyY2FsbC4KPiAKPiBB
bHNvLCBEbyBURFhfQUNDRVBUX1BBR0Ugb24gZXZlcnkgNGsgcGFnZSBhZnRlciBtYXBwaW5nIHRo
ZSBHUEEgcmFuZ2UKPiB3aGVuIGNvbnZlcnRpbmcgbWVtb3J5IHRvIHByaXZhdGUuIFVzaW5nIDRr
IHBhZ2Ugc2l6ZSBsaW1pdCBpcyBkdWUKPiB0byBjdXJyZW50IFREWCBzcGVjIHJlc3RyaWN0aW9u
LiBBbHNvLCBJZiB0aGUgR1BBIChyYW5nZSkgd2FzCj4gYWxyZWFkeSBtYXBwZWQgYXMgYW4gYWN0
aXZlLCBwcml2YXRlIHBhZ2UsIHRoZSBob3N0IFZNTSBtYXkgcmVtb3ZlCj4gdGhlIHByaXZhdGUg
cGFnZSBmcm9tIHRoZSBURCBieSBmb2xsb3dpbmcgdGhlIOKAnFJlbW92aW5nIFREIFByaXZhdGUK
PiBQYWdlc+KAnSBzZXF1ZW5jZSBpbiB0aGUgSW50ZWwgVERYLW1vZHVsZSBzcGVjaWZpY2F0aW9u
IFsxXSB0byBzYWZlbHkKPiBibG9jayB0aGUgbWFwcGluZyhzKSwgZmx1c2ggdGhlIFRMQiBhbmQg
Y2FjaGUsIGFuZCByZW1vdmUgdGhlCj4gbWFwcGluZyhzKS4KPiAKPiBCVUcoKSBpZiBURFhfQUND
RVBUX1BBR0UgZmFpbHMgKGV4Y2VwdCAicHJldmlvdXNseSBhY2NlcHRlZCBwYWdlIiBjYXNlKQo+
ICwgYXMgdGhlIGd1ZXN0IGlzIGNvbXBsZXRlbHkgaG9zZWQgaWYgaXQgY2FuJ3QgYWNjZXNzIG1l
bW9yeS4KPiAKPiBbMV0gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGc29mdHdhcmUuaW50ZWwuY29tJTJGY29udGVudCUyRmRh
bSUyRmRldmVsb3AlMkZleHRlcm5hbCUyRnVzJTJGZW4lMkZkb2N1bWVudHMlMkZ0ZHgtbW9kdWxl
LTFlYXMtdjAuODUuMDM5LnBkZiZhbXA7ZGF0YT0wNCU3QzAxJTdDdGhvbWFzLmxlbmRhY2t5JTQw
YW1kLmNvbSU3QzBlNjY3YWRmNWE0MDQyYWJjZTM5MDhkOThhYmQwN2E4JTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzY5MzM2NzIwMTcwMzg5MyU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1VR3hROXhCaldzbWV2
N1BldFglMkJ1UzBSQ2hrQVh5YUg3cTZKSE85WmlVdFklM0QmYW1wO3Jlc2VydmVkPTAKPiAKPiBU
ZXN0ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGxpbnV4LmludGVsLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vhbi5qLmNocmlzdG9w
aGVyc29uQGludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50
ZWwuY29tPgo+IFJldmlld2VkLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5h
bi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4KCi4uLgoKPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvbW0vbWVtX2VuY3J5cHRfY29tbW9uLmMgYi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9jb21t
b24uYwo+IGluZGV4IGYwNjNjODg1YjBhNS4uMTE5YTkwNTZlZmJiIDEwMDY0NAo+IC0tLSBhL2Fy
Y2gveDg2L21tL21lbV9lbmNyeXB0X2NvbW1vbi5jCj4gKysrIGIvYXJjaC94ODYvbW0vbWVtX2Vu
Y3J5cHRfY29tbW9uLmMKPiBAQCAtOSw5ICs5LDE4IEBACj4gICAKPiAgICNpbmNsdWRlIDxhc20v
bWVtX2VuY3J5cHRfY29tbW9uLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4K
PiArI2luY2x1ZGUgPGxpbnV4L2NjX3BsYXRmb3JtLmg+Cj4gICAKPiAgIC8qIE92ZXJyaWRlIGZv
ciBETUEgZGlyZWN0IGFsbG9jYXRpb24gY2hlY2sgLSBBUkNIX0hBU19GT1JDRV9ETUFfVU5FTkNS
WVBURUQgKi8KPiAgIGJvb2wgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKHN0cnVjdCBkZXZpY2UgKmRl
dikKPiAgIHsKPiAtCXJldHVybiBhbWRfZm9yY2VfZG1hX3VuZW5jcnlwdGVkKGRldik7Cj4gKwlp
ZiAoY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfVERYKSAmJgo+ICsJICAgIGNjX3BsYXRm
b3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUKSkKPiArCQlyZXR1cm4gdHJ1ZTsKPiAr
Cj4gKwlpZiAoY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfTUVNX0VOQ1JZUFQpIHx8Cj4g
KwkgICAgY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfSE9TVF9NRU1fRU5DUllQVCkpCj4gKwkJcmV0
dXJuIGFtZF9mb3JjZV9kbWFfdW5lbmNyeXB0ZWQoZGV2KTsKPiArCj4gKwlyZXR1cm4gZmFsc2U7
CgpBc3N1bWluZyB0aGUgb3JpZ2luYWwgZm9yY2VfZG1hX3VuZW5jcnlwdGVkKCkgZnVuY3Rpb24g
d2FzIG1vdmVkIGhlcmUgb3IgCmNjX3BsYXRmb3JtLmMsIHRoZW4geW91IHNob3VsZG4ndCBuZWVk
IGFueSBjaGFuZ2VzLiBCb3RoIFNFViBhbmQgVERYIApyZXF1aXJlIHRydWUgYmUgcmV0dXJuZWQg
aWYgQ0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCByZXR1cm5zIHRydWUuIEFuZCAKdGhlbiBURFgg
c2hvdWxkIG5ldmVyIHJldHVybiB0cnVlIGZvciBDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQuCgo+
ICAgfQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jIGIvYXJjaC94
ODYvbW0vcGF0L3NldF9tZW1vcnkuYwo+IGluZGV4IDUyNzk1NzU4NmYzYy4uNmM1MzFkNWNiNWZk
IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMKPiArKysgYi9hcmNo
L3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jCj4gQEAgLTMwLDYgKzMwLDcgQEAKPiAgICNpbmNsdWRl
IDxhc20vcHJvdG8uaD4KPiAgICNpbmNsdWRlIDxhc20vbWVtdHlwZS5oPgo+ICAgI2luY2x1ZGUg
PGFzbS9zZXRfbWVtb3J5Lmg+Cj4gKyNpbmNsdWRlIDxhc20vdGR4Lmg+Cj4gICAKPiAgICNpbmNs
dWRlICIuLi9tbV9pbnRlcm5hbC5oIgo+ICAgCj4gQEAgLTE5ODEsOCArMTk4MiwxMCBAQCBpbnQg
c2V0X21lbW9yeV9nbG9iYWwodW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMpCj4gICAJ
CQkJICAgIF9fcGdwcm90KF9QQUdFX0dMT0JBTCksIDApOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBp
bnQgX19zZXRfbWVtb3J5X2VuY19kZWModW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMs
IGJvb2wgZW5jKQo+ICtzdGF0aWMgaW50IF9fc2V0X21lbW9yeV9wcm90ZWN0KHVuc2lnbmVkIGxv
bmcgYWRkciwgaW50IG51bXBhZ2VzLCBib29sIHByb3RlY3QpCj4gICB7Cj4gKwlwZ3Byb3RfdCBt
ZW1fcHJvdGVjdGVkX2JpdHMsIG1lbV9wbGFpbl9iaXRzOwo+ICsJZW51bSB0ZHhfbWFwX3R5cGUg
bWFwX3R5cGU7Cj4gICAJc3RydWN0IGNwYV9kYXRhIGNwYTsKPiAgIAlpbnQgcmV0Owo+ICAgCj4g
QEAgLTE5OTcsOCArMjAwMCwyNSBAQCBzdGF0aWMgaW50IF9fc2V0X21lbW9yeV9lbmNfZGVjKHVu
c2lnbmVkIGxvbmcgYWRkciwgaW50IG51bXBhZ2VzLCBib29sIGVuYykKPiAgIAltZW1zZXQoJmNw
YSwgMCwgc2l6ZW9mKGNwYSkpOwo+ICAgCWNwYS52YWRkciA9ICZhZGRyOwo+ICAgCWNwYS5udW1w
YWdlcyA9IG51bXBhZ2VzOwo+IC0JY3BhLm1hc2tfc2V0ID0gZW5jID8gX19wZ3Byb3QoX1BBR0Vf
RU5DKSA6IF9fcGdwcm90KDApOwo+IC0JY3BhLm1hc2tfY2xyID0gZW5jID8gX19wZ3Byb3QoMCkg
OiBfX3BncHJvdChfUEFHRV9FTkMpOwo+ICsKPiArCWlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRU
Ul9HVUVTVF9TSEFSRURfTUFQUElOR19JTklUKSkgewo+ICsJCW1lbV9wcm90ZWN0ZWRfYml0cyA9
IF9fcGdwcm90KDApOwo+ICsJCW1lbV9wbGFpbl9iaXRzID0gcGdwcm90X2NjX3NoYXJlZF9tYXNr
KCk7CgpIb3cgYWJvdXQgaGF2aW5nIGdlbmVyaWMgdmVyc2lvbnMgZm9yIGJvdGggc2hhcmVkIGFu
ZCBwcml2YXRlIHRoYXQgcmV0dXJuIAp0aGUgcHJvcGVyIHZhbHVlIGZvciBTRVYgb3IgVERYLiBU
aGVuIHRoaXMgcmVtYWlucyBsb29raW5nIHNpbWlsYXIgdG8gYXMgCml0IGRvZXMgbm93LCBqdXN0
IHJlcGxhY2luZyB0aGUgX19wZ3Byb3QoKSBjYWxscyB3aXRoIHRoZSBhcHByb3ByaWF0ZSAKcGdw
cm90X2NjX3tzaGFyZWQscHJpdmF0ZX1fbWFzaygpLgoKVGhhbmtzLApUb20KCj4gKwl9IGVsc2Ug
ewo+ICsJCW1lbV9wcm90ZWN0ZWRfYml0cyA9IF9fcGdwcm90KF9QQUdFX0VOQyk7Cj4gKwkJbWVt
X3BsYWluX2JpdHMgPSBfX3BncHJvdCgwKTsKPiArCX0KPiArCj4gKwlpZiAocHJvdGVjdCkgewo+
ICsJCWNwYS5tYXNrX3NldCA9IG1lbV9wcm90ZWN0ZWRfYml0czsKPiArCQljcGEubWFza19jbHIg
PSBtZW1fcGxhaW5fYml0czsKPiArCQltYXBfdHlwZSA9IFREWF9NQVBfUFJJVkFURTsKPiArCX0g
ZWxzZSB7Cj4gKwkJY3BhLm1hc2tfc2V0ID0gbWVtX3BsYWluX2JpdHM7Cj4gKwkJY3BhLm1hc2tf
Y2xyID0gbWVtX3Byb3RlY3RlZF9iaXRzOwo+ICsJCW1hcF90eXBlID0gVERYX01BUF9TSEFSRUQ7
Cj4gKwl9Cj4gKwo+ICAgCWNwYS5wZ2QgPSBpbml0X21tLnBnZDsKPiAgIAo+ICAgCS8qIE11c3Qg
YXZvaWQgYWxpYXNpbmcgbWFwcGluZ3MgaW4gdGhlIGhpZ2htZW0gY29kZSAqLwo+IEBAIC0yMDA2
LDkgKzIwMjYsMTcgQEAgc3RhdGljIGludCBfX3NldF9tZW1vcnlfZW5jX2RlYyh1bnNpZ25lZCBs
b25nIGFkZHIsIGludCBudW1wYWdlcywgYm9vbCBlbmMpCj4gICAJdm1fdW5tYXBfYWxpYXNlcygp
Owo+ICAgCj4gICAJLyoKPiAtCSAqIEJlZm9yZSBjaGFuZ2luZyB0aGUgZW5jcnlwdGlvbiBhdHRy
aWJ1dGUsIHdlIG5lZWQgdG8gZmx1c2ggY2FjaGVzLgo+ICsJICogQmVmb3JlIGNoYW5naW5nIHRo
ZSBlbmNyeXB0aW9uIGF0dHJpYnV0ZSwgZmx1c2ggY2FjaGVzLgo+ICsJICoKPiArCSAqIEZvciBU
RFgsIGd1ZXN0IGlzIHJlc3BvbnNpYmxlIGZvciBmbHVzaGluZyBjYWNoZXMgb24gcHJpdmF0ZS0+
c2hhcmVkCj4gKwkgKiB0cmFuc2l0aW9uLiBWTU0gaXMgcmVzcG9uc2libGUgZm9yIGZsdXNoaW5n
IG9uIHNoYXJlZC0+cHJpdmF0ZS4KPiAgIAkgKi8KPiAtCWNwYV9mbHVzaCgmY3BhLCAhdGhpc19j
cHVfaGFzKFg4Nl9GRUFUVVJFX1NNRV9DT0hFUkVOVCkpOwo+ICsJaWYgKGNjX3BsYXRmb3JtX2hh
cyhDQ19BVFRSX0dVRVNUX1REWCkpIHsKPiArCQlpZiAobWFwX3R5cGUgPT0gVERYX01BUF9TSEFS
RUQpCj4gKwkJCWNwYV9mbHVzaCgmY3BhLCAxKTsKPiArCX0gZWxzZSB7Cj4gKwkJY3BhX2ZsdXNo
KCZjcGEsICF0aGlzX2NwdV9oYXMoWDg2X0ZFQVRVUkVfU01FX0NPSEVSRU5UKSk7Cj4gKwl9Cj4g
ICAKPiAgIAlyZXQgPSBfX2NoYW5nZV9wYWdlX2F0dHJfc2V0X2NscigmY3BhLCAxKTsKPiAgIAo+
IEBAIC0yMDIxLDE4ICsyMDQ5LDIxIEBAIHN0YXRpYyBpbnQgX19zZXRfbWVtb3J5X2VuY19kZWMo
dW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMsIGJvb2wgZW5jKQo+ICAgCSAqLwo+ICAg
CWNwYV9mbHVzaCgmY3BhLCAwKTsKPiAgIAo+ICsJaWYgKCFyZXQgJiYgY2NfcGxhdGZvcm1faGFz
KENDX0FUVFJfR1VFU1RfU0hBUkVEX01BUFBJTkdfSU5JVCkpCj4gKwkJcmV0ID0gdGR4X2hjYWxs
X2dwYV9pbnRlbnQoX19wYShhZGRyKSwgbnVtcGFnZXMsIG1hcF90eXBlKTsKPiArCj4gICAJcmV0
dXJuIHJldDsKPiAgIH0KPiAgIAo+ICAgaW50IHNldF9tZW1vcnlfZW5jcnlwdGVkKHVuc2lnbmVk
IGxvbmcgYWRkciwgaW50IG51bXBhZ2VzKQo+ICAgewo+IC0JcmV0dXJuIF9fc2V0X21lbW9yeV9l
bmNfZGVjKGFkZHIsIG51bXBhZ2VzLCB0cnVlKTsKPiArCXJldHVybiBfX3NldF9tZW1vcnlfcHJv
dGVjdChhZGRyLCBudW1wYWdlcywgdHJ1ZSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChz
ZXRfbWVtb3J5X2VuY3J5cHRlZCk7Cj4gICAKPiAgIGludCBzZXRfbWVtb3J5X2RlY3J5cHRlZCh1
bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcykKPiAgIHsKPiAtCXJldHVybiBfX3NldF9t
ZW1vcnlfZW5jX2RlYyhhZGRyLCBudW1wYWdlcywgZmFsc2UpOwo+ICsJcmV0dXJuIF9fc2V0X21l
bW9yeV9wcm90ZWN0KGFkZHIsIG51bXBhZ2VzLCBmYWxzZSk7Cj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX0dQTChzZXRfbWVtb3J5X2RlY3J5cHRlZCk7Cj4gICAKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
