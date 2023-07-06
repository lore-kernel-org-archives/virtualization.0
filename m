Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A68EB64DA
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 00:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8354A81EA1;
	Thu,  6 Jul 2023 00:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8354A81EA1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UAIAAneK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKVlRCV6kZ-g; Thu,  6 Jul 2023 00:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE40C813DC;
	Thu,  6 Jul 2023 00:07:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE40C813DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 923D0C0072;
	Thu,  6 Jul 2023 00:07:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A567FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 00:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2792A81EA1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 00:07:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2792A81EA1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pMRBF1Zepgmv
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 00:07:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CEF8813DC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CEF8813DC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 00:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCjOg/+q8Gh8IiE2MV+NRLes92/1MH5aPAB0ktSAWMKiqgaZPrcKfzHN148fsQU38Wif3ppKq9nFTl8VCG5VFcQ0Pr2zc0kd0W7zs7jFeUS0q+yPyD0Q6yXxETgWgUi+kHXhEitG04/c4s792Sx94eImAMYxS7aneoSbDy2EybpccYOYjXqHPIA93Xt8KJYbf64zKX40WNLORS/lPFgMV6W/IZJnZV8xir5fUnykyQHUHZS8CHglGztBbFsgqolrIthSWsIYbsqIXGx2Lgfl7tXKwFdOOG+1Tn0PzYsTvs0Q7QoQDYozEC8FJqtIMUCCDZM5FwdftvyGvbZOOBm38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpP5a6cw4EeTRIq2b6GOheaVyQW5GRCg7EDcMu2xlFs=;
 b=Jio4vMh1BCi+8UpBDL631C8PpqarFirubVfD/yffEQ7WtFh2m6RN6RX9JNftBofd2OxHelJm+umLHzWWKtxaDwSQR0LV1rAvUbWtUcf1MpI7yQYanMbYL0NXCCtIqkXuvm65mPjCXwIkYejGji7GnSG1d4Fg2vE3BQCJkULYHnCBSG+xI34RWY9DIZVim4xKoOrPZMI4qATNeQant9Cdqg5AtZ/YO5M5QWzAmu42v2h4aEPUGKjQBgb4X8Z2Y3yYrbGQhOEz5ST71wqU0wjPUbkd9dHWnzgElokYYvL3oUD+KCMZpBsvLjzskSU4LmiEtYR7TktRXSrtPzrtRLtd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpP5a6cw4EeTRIq2b6GOheaVyQW5GRCg7EDcMu2xlFs=;
 b=UAIAAneKuyQ/LqikPfIC+YPcYQO1OH3kb0ePZWILEcf1eV7tU6pQjfPIrFF0KMDBNYNrDD2/jiN2l/F7a4QFAwTuQahZRiDIm/l1lzKMFTsnLFLStg0oFx6G4At/4qFqwbbBTGrLTliGJVpmrHrdIIecg+cZdCpnte+6/yF0hsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 00:07:15 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 00:07:15 +0000
Message-ID: <eff34828-545b-956b-f400-89b585706fe4@amd.com>
Date: Wed, 5 Jul 2023 17:07:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
In-Reply-To: <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: acc1374c-d8c2-400e-8d97-08db7db4f447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFucxTUXfxArMCgQrwF26LxSbb3GI0A7/O7nfJ3wYYsmsOUER491HsEHeAinZjv+J4+JvsPXdsVkOSynH4MwG75Gl6bRrGxuGc+aJ7qYjRPoSdSYz78Sv6KKcOWJzq7COHbJxfSvrVTYgVheL7vtVFxvwZgyjcr+SAetP4geZnvGFpE/ljqa3rqsIxaFu5dg2JOp8vneyQnktpMeMON6spgd8dQ5RaW8nRrupqssbL9aFauL6DcjIdoAnA7ah/dx/QeEqY4Y6GFntLRWzc6uhlo6HbHMc++1H4nNhYR68RrcuObcWXt7xMha3HFKiKCYyOKgC29jFHvyaywXdnYIae3DF5CcskCESKN0OnEz+6NqFD65Z36lFisYwDwpp1wGjWPELJR6EPzbmXnTQ58frhXY6WbralnN4ipLenWoZ8PRjgmp9xmCJWoeVo42dlJW0SFyGMLTJyxN8lHqC2Pvb9b6RXoPjLnbcNEQ5N1TAlHMbNfR08IHsUTTaIoTvvW71gUYMdsSW5l8o2/OmjqMMUsUa0k1t6zYj2yBOuLhr4AdZwwEJ12eu10fI9ah3Sdw8pz2oI2G5DvUTu2hsflSGsEmnto6Z9mYDs1AEGxF5ovcI1IoB6921UI7PEY8l6oZJarc+lyzig1WcpNIc06hXDdhSmg0H/v7mm1q1nG4RJD9GOBySgEf/hc9/QY11mUB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(8676002)(66899021)(41300700001)(5660300002)(44832011)(8936002)(36756003)(6666004)(86362001)(31696002)(31686004)(478600001)(2616005)(26005)(6506007)(53546011)(966005)(6512007)(186003)(110136005)(84970400001)(66946007)(316002)(4326008)(66476007)(38100700002)(66556008)(6486002)(83380400001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpSSGdSdDJIb0tsVTVtQXJ2TGx6Q0VkT0p5NkprbUR6eHI4UmQxRXlZOFpF?=
 =?utf-8?B?ZVdibnlYaEZUaGlMV1llNVhtSDZrRkUwTHRVRG5yUnBFM2RVTS9qVzF3N2tu?=
 =?utf-8?B?WldvdjR5Zk5qY3FBNTVaN000WjFoYmNYdWlNS1cxZWZrY05YRHJwMjlkYStz?=
 =?utf-8?B?aDJvZkVvUEV4cjFXNlhOaW41dUdPWGs3L2NtU2w4VzQ0M3JYVDA1SDdscEtw?=
 =?utf-8?B?SHVWVzJyR3ZVanZZWUlUU2dhTkRJSlVNQTAxR1VsQld5bTdoMTNhSE53WkNa?=
 =?utf-8?B?blkzaUtMV3RIK3JyaVZjSGVtQXdWNm9VNTM1R0pWM0pDNXZFQ0tTRjYzendp?=
 =?utf-8?B?SjE4d0RPOWl5RFFqcHc5cTZVdXd1c0JPVy8ydWR2bUowTytVYThxaDE4dE8y?=
 =?utf-8?B?MS9nM0pnMFFxc29ZdGtET1Z1dFBYYVNTQ1NDNWt0ME1aMGZqdVBxbE1LQ3o2?=
 =?utf-8?B?QWlTTXBaR0NpekVsUmMydHhFcnFmdDRETUgwYVIzdTA1QzVQQ3dKdUtjYUxR?=
 =?utf-8?B?bjlTUGxoRExSWCtXVkNicDlhc0ZkRHVtN2tBSzBnQUhjMXMvVTdSWDdpZEtk?=
 =?utf-8?B?MW1IOVJoeXMxN1dBeUxaZ3plcDhtSmN6bXB4VlNLakN4NS9IUHUrN25VZjk0?=
 =?utf-8?B?K0VxLzJneVNmUlg3Qjh2NmxwcVpKV2JSLzRIbWZrQ3gwem9vMnN2SHk1ODBx?=
 =?utf-8?B?amRmdkp4cGtORWt4YkFhOW9DRWpCblBGVWloT3lzemlJWFhuRWNSN1R0bklh?=
 =?utf-8?B?SXJabURUODN0MmhXZG1zTnlvaTZaTWI5VGZZR2M2cThoVDhPenlJQ2podmJI?=
 =?utf-8?B?SVFHR0Q5UmRkSUI4NlJsYmdIUEVjRmJGOU9mTytOUmw5VlhRU2R6TkJXSjVQ?=
 =?utf-8?B?di9pK0ZPTy9hVnN2SksrV29vanRNM21YZ1hxaXJZeEUzSG03S05JbXBQcEJo?=
 =?utf-8?B?MXNSd0JkWTM1MFhaOFZheStFcEpJd3dET0MzQWdYSWtRamN6bWp6VU04bWJR?=
 =?utf-8?B?djJ4Y1gxSlhpZXB0Y1RwdjMvYW10U3U2elhldEFiZHFBQTlSOUlVMlQvMmU3?=
 =?utf-8?B?RHpXNXpraElGb2ZqanVPWWpjSXB4S3N1S1h2SXFwV2JmdDI2ZFNDRzRIa3hr?=
 =?utf-8?B?VjZVKzVyc2JLd29sRi9ZdmZXYk5hWmRpVStYbFliYlFnZ3ZaUVY0SlBWYnpP?=
 =?utf-8?B?OEFLRkMzeDYwM3BTRlhVYlkvdFlyZ3c2amJFNlYxcGgyeHJFQ0tpZmNkdytr?=
 =?utf-8?B?NGZZRldwZC9VK1Ftemh6cWdYWmcwbTNzbklUSUcyVG1YVlFqQzloYmVSb2tM?=
 =?utf-8?B?eDJvSC9OL1ZSWUNDM3B3b29CMkswQkZJUGJLM3JTcEdhTHVsc2NHamp1aEFV?=
 =?utf-8?B?M1l6QjVNOXAzYVhUZld2d3BpUEhkUFQ5WUFYTWFWUVljTzk1S0FYQm5JSEhp?=
 =?utf-8?B?REFabzdoTGNCODVVclJDT2pFRHRoNkxvTHBjanFLWEVFQm16aDZSUk8yYmtP?=
 =?utf-8?B?NG1DMXE3TEFlU00vQjNHSXIrd2E1NHo3dlBNbytFYkhUWVRiYjdHd3JwOTdo?=
 =?utf-8?B?bXlkVlNBWmpCbUZzT1Q1cTl4MWdGUDJGRFd1b0w3S3RrcU9pVG1IRXBaaWN0?=
 =?utf-8?B?bjZnRGRmOEFQSXRGME53WU8zM000V1hnSUE2dnBHbm4vWkRJV3RzSTF0Qjlp?=
 =?utf-8?B?TVJwWitpejJVbVpuVjhYNk5XYWtPNHdTTERUbXpEZDdMMldod2ZEZnlGWUFY?=
 =?utf-8?B?Mmwzc1VzakJkRFljOXhkeCtIa2xzamZPRlNvWktZQmE1SWE5MS9rcy9YN3Vw?=
 =?utf-8?B?UzU5ZkFBa2xnVE9vMWdSRjRKUmZPYXVSU20vUUNMS1B6ZXp6WXZyYlM1QWhM?=
 =?utf-8?B?czR2TE9VS2wwMWd4V2Irc2IvMFVMSndkaWlDNzd1SzBtM2dWVGZ6WWg0UUtT?=
 =?utf-8?B?c0I5bWJMbElEMldvNGFlbzdmeTJrK0lJMElyNlRmWFBWVnhSMHJUcXNYdHlv?=
 =?utf-8?B?UGJkd3RzT05ZRFFVK3NtZEluNXNuVEhuOUFmL3lrV3BwajRrZzFoR3A0MVhk?=
 =?utf-8?B?OC9LSzJGVVhXcXBMQWZNRlh5MEJxa2NwV0Y1ZFZXU2FYalZiM1RtSFBnKzJz?=
 =?utf-8?Q?TGVjBslVLsd0vaKCpGVqUWwuH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc1374c-d8c2-400e-8d97-08db7db4f447
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 00:07:15.0687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXuvAtj2zfKb/Xf8o2cGF9QYI8KZBdp344Z9TfnPMybTPtstVVdQog2PLGqx3InwIl6cqAwpOKysyZyySGooOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNy81LzIzIDExOjI3IEFNLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKID4KPiBPbiBX
ZWQsIEp1bCA1LCAyMDIzIGF0IDk6NTDigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMTo0NeKAr1BNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4KPj4+IE9uIFR1ZSwgSnVs
IDA0LCAyMDIzIGF0IDAxOjM2OjExUE0gKzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3Rl
Ogo+Pj4+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4KPj4+Pj4gT24gVHVlLCBKdWwgMDQsIDIw
MjMgYXQgMTI6MjU6MzJQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4+Pj4+
PiBPbiBNb24sIEp1bCAzLCAyMDIzIGF0IDQ6NTLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4+IE9uIE1vbiwgSnVsIDAzLCAyMDIz
IGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+Pj4+Pj4+PiBXaXRo
IHRoZSBjdXJyZW50IGNvZGUgaXQgaXMgYWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5k
IGl0Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBbHRob3VnaCB1c2VybGFuZCBzaG91bGQgbm90IHNldCBh
IGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+Pj4+Pj4+PiBvZmZlcmVkIHRvIGl0IHdp
dGggVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBub3QK
Pj4+Pj4+Pj4gY29tcGxhaW4gZm9yIGl0Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaW5jZSB0aGVyZSBp
cyBubyBzcGVjaWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRoYXQgYmFja2Vu
ZAo+Pj4+Pj4+PiBmZWF0dXJlIGJpdCB3aGVuIGl0IGhhcyBiZWVuIHByb3Bvc2VkLCBsZXQncyBj
b250cm9sIGl0IGF0IHZkcGEgZnJvbnRlbmQKPj4+Pj4+Pj4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVz
IG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPj4+Pj4+Pj4KPj4+
Pj4+Pj4gRml4ZXM6IDk2NzgwMGQyZDUyZSAoInZkcGE6IGFjY2VwdCBWSE9TVF9CQUNLRU5EX0Zf
RU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBiYWNrZW5kIGZlYXR1cmUiKQo+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+Pj4+Pgo+Pj4+
Pj4+IFBsZWFzZSBkbyBzZW5kIHYzLiBBbmQgYWdhaW4sIEkgZG9uJ3Qgd2FudCB0byBzZW5kICJh
ZnRlciBkcml2ZXIgb2siIGhhY2sKPj4+Pj4+PiB1cHN0cmVhbSBhdCBhbGwsIEkgbWVyZ2VkIGl0
IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPj4+Pj4+PiBXZSB3YW50IFJJ
TkdfQUNDRVNTX0FGVEVSX0tJQ0sgb3Igc29tZSBzdWNoLgo+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4g
Q3VycmVudCBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IHRoYXQgc2VtYW50aWMuCj4+Pj4+Cj4+Pj4+
IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2VzcyB0aGUgcmluZyBhZnRlciBEUklWRVJf
T0sgYnV0IGJlZm9yZQo+Pj4+PiBhIGtpY2s/CgpUaGUgUERTIHZkcGEgZGV2aWNlIGNhbiBkZWFs
IHdpdGggYSBjYWxsIHRvIC5zZXRfdnFfcmVhZHkgYWZ0ZXIgCkRSSVZFUl9PSyBpcyBzZXQuICBB
bmQgSSdtIHRvbGQgdGhhdCBvdXIgVlEgYWN0aXZpdHkgc2hvdWxkIHN0YXJ0IAp3aXRob3V0IGEg
a2ljay4KCk91ciB2ZHBhIGRldmljZSBGVyBkb2Vzbid0IGN1cnJlbnRseSBoYXZlIHN1cHBvcnQg
Zm9yIApWSVJUSU9fRl9SSU5HX1JFU0VULCBidXQgSSBiZWxpZXZlIGl0IGNvdWxkIGJlIGFkZGVk
IHdpdGhvdXQgdG9vIG11Y2ggCnRyb3VibGUuCgpzbG4KCgo+Pj4+Pgo+Pj4+Cj4+Pj4gUHJldmlv
dXMgdmVyc2lvbnMgb2YgdGhlIFFFTVUgTE0gc2VyaWVzIGRpZCBhIHNwdXJpb3VzIGtpY2sgdG8g
c3RhcnQKPj4+PiB0cmFmZmljIGF0IHRoZSBMTSBkZXN0aW5hdGlvbiBbMV0uIFdoZW4gaXQgd2Fz
IHByb3Bvc2VkLCB0aGF0IHNwdXJpb3VzCj4+Pj4ga2ljayB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBz
ZXJpZXMgYmVjYXVzZSB0byBjaGVjayBmb3IgZGVzY3JpcHRvcnMKPj4+PiBhZnRlciBkcml2ZXJf
b2ssIGV2ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRlcmVkIHdvcmsgb2YgdGhlCj4+Pj4g
cGFyZW50IGRyaXZlci4KPj4+Pgo+Pj4+IEknbSBvayB0byBnbyBiYWNrIHRvIHRoaXMgc3B1cmlv
dXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUgaHcKPj4+PiB3aWxsIHJlYWQgdGhlIHJp
bmcgYmVmb3JlIHRoZSBraWNrIGFjdHVhbGx5LiBJIGNhbiBhc2suCj4+Pj4KPj4+PiBUaGFua3Mh
Cj4+Pj4KPj4+PiBbMV0gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11
LWRldmVsLzIwMjMtMDEvbXNnMDI3NzUuaHRtbAo+Pj4KPj4+IExldCdzIGZpbmQgb3V0LiBXZSBu
ZWVkIHRvIGNoZWNrIGZvciBFTkFCTEVfQUZURVJfRFJJVkVSX09LIHRvbywgbm8/Cj4+Cj4+IE15
IHVuZGVyc3RhbmRpbmcgaXMgWzFdIGFzc3VtaW5nIEFDQ0VTU19BRlRFUl9LSUNLLiBUaGlzIHNl
ZW1zCj4+IHN1Yi1vcHRpbWFsIHRoYW4gYXNzdW1pbmcgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSy4K
Pj4KPj4gQnV0IHRoaXMgcmVtaW5kcyBtZSBvbmUgdGhpbmcsIGFzIHRoZSB0aHJlYWQgaXMgZ29p
bmcgdG9vIGxvbmcsIEkKPj4gd29uZGVyIGlmIHdlIHNpbXBseSBhc3N1bWUgRU5BQkxFX0FGVEVS
X0RSSVZFUl9PSyBpZiBSSU5HX1JFU0VUIGlzCj4+IHN1cHBvcnRlZD8KPj4KPiAKPiBUaGUgcHJv
YmxlbSB3aXRoIHRoYXQgaXMgdGhhdCB0aGUgZGV2aWNlIG5lZWRzIHRvIHN1cHBvcnQgYWxsCj4g
UklOR19SRVNFVCwgbGlrZSB0byBiZSBhYmxlIHRvIGNoYW5nZSB2cSBhZGRyZXNzIGV0YyBhZnRl
ciBEUklWRVJfT0suCj4gTm90IGFsbCBIVyBzdXBwb3J0IGl0Lgo+IAo+IFdlIGp1c3QgbmVlZCB0
aGUgc3Vic2V0IG9mIGhhdmluZyB0aGUgZGF0YXBsYW5lIGZyZWV6ZWQgdW50aWwgYWxsIENWUQo+
IGNvbW1hbmRzIGhhdmUgYmVlbiBjb25zdW1lZC4gSSdtIHN1cmUgY3VycmVudCB2RFBBIGNvZGUg
YWxyZWFkeQo+IHN1cHBvcnRzIGl0IGluIHNvbWUgZGV2aWNlcywgbGlrZSBNTFggYW5kIFBTRC4K
PiAKPiBUaGFua3MhCj4gCj4+IFRoYW5rcwo+Pgo+Pj4KPj4+Cj4+Pgo+Pj4+Pj4gTXkgcGxhbiB3
YXMgdG8gY29udmVydAo+Pj4+Pj4gaXQgaW4gdnBfdmRwYSBpZiBuZWVkZWQsIGFuZCByZXVzZSB0
aGUgY3VycmVudCB2ZHBhIG9wcy4gU29ycnkgaWYgSQo+Pj4+Pj4gd2FzIG5vdCBleHBsaWNpdCBl
bm91Z2guCj4+Pj4+Pgo+Pj4+Pj4gVGhlIG9ubHkgc29sdXRpb24gSSBjYW4gc2VlIHRvIHRoYXQg
aXMgdG8gdHJhcCAmIGVtdWxhdGUgaW4gdGhlIHZkcGEKPj4+Pj4+IChwYXJlbnQ/KSBkcml2ZXIs
IGFzIHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPj4+Pj4+
IHRoZSBhcmNoaXRlY3R1cmU6Cj4+Pj4+PiAqIE9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9SSU5HX0FD
Q0VTU19BRlRFUl9LSUNLCj4+Pj4+PiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBzZXBhcmF0ZWx5
LCBhdAo+Pj4+Pj4gdmRwYS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1dCBub3QgdHJh
bnNtaXQgdGhhdCBlbmFibGUgdG8gaHcKPj4+Pj4+ICogU3RvcmUgdGhlIGRvb3JiZWxsIHN0YXRl
IHNlcGFyYXRlbHksIGJ1dCBkbyBub3QgY29uZmlndXJlIGl0IHRvIHRoZQo+Pj4+Pj4gZGV2aWNl
IGRpcmVjdGx5Lgo+Pj4+Pj4KPj4+Pj4+IEJ1dCBob3cgdG8gcmVjb3ZlciBpZiB0aGUgZGV2aWNl
IGNhbm5vdCBjb25maWd1cmUgdGhlbSBhdCBraWNrIHRpbWUsCj4+Pj4+PiBmb3IgZXhhbXBsZT8K
Pj4+Pj4+Cj4+Pj4+PiBNYXliZSB3ZSBjYW4ganVzdCBmYWlsIGlmIHRoZSBwYXJlbnQgZHJpdmVy
IGRvZXMgbm90IHN1cHBvcnQgZW5hYmxpbmcKPj4+Pj4+IHRoZSB2cSBhZnRlciBEUklWRVJfT0s/
IFRoYXQgd2F5IG5vIG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVlZGVkLgo+Pj4+Pj4KPj4+Pj4+IFRo
YW5rcyEKPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+IFNlbnQgd2l0aCBGaXhl
czogdGFnIHBvaW50aW5nIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9tc3QKPj4+Pj4+Pj4gY29tbWl0LiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBzaG91bGQgc2Vu
ZCBhIHYzIG9mIFsxXSBpbnN0ZWFkLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDIzMDYwOTEyMTI0NC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5l
bC5vcmcvVC8KPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA3
ICsrKysrLS0KPj4+Pj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+Pj4+PiBpbmRleCBlMWFiZjI5ZmVkNWIu
LmE3ZTU1NDM1MjM1MSAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMK
Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+Pj4gQEAgLTY4MSwxOCAr
NjgxLDIxIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZp
bGUgKmZpbGVwLAo+Pj4+Pj4+PiAgIHsKPj4+Pj4+Pj4gICAgICAgIHN0cnVjdCB2aG9zdF92ZHBh
ICp2ID0gZmlsZXAtPnByaXZhdGVfZGF0YTsKPj4+Pj4+Pj4gICAgICAgIHN0cnVjdCB2aG9zdF9k
ZXYgKmQgPSAmdi0+dmRldjsKPj4+Pj4+Pj4gKyAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmln
X29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+Pj4+Pj4+PiAgICAgICAgdm9pZCBfX3VzZXIg
KmFyZ3AgPSAodm9pZCBfX3VzZXIgKilhcmc7Cj4+Pj4+Pj4+ICAgICAgICB1NjQgX191c2VyICpm
ZWF0dXJlcCA9IGFyZ3A7Cj4+Pj4+Pj4+IC0gICAgIHU2NCBmZWF0dXJlczsKPj4+Pj4+Pj4gKyAg
ICAgdTY0IGZlYXR1cmVzLCBwYXJlbnRfZmVhdHVyZXMgPSAwOwo+Pj4+Pj4+PiAgICAgICAgbG9u
ZyByID0gMDsKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgICAgIGlmIChjbWQgPT0gVkhPU1RfU0VUX0JB
Q0tFTkRfRkVBVFVSRVMpIHsKPj4+Pj4+Pj4gICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91
c2VyKCZmZWF0dXJlcywgZmVhdHVyZXAsIHNpemVvZihmZWF0dXJlcykpKQo+Pj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+Pj4+Pj4+PiArICAgICAgICAgICAg
IGlmIChvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAg
ICAgICAgcGFyZW50X2ZlYXR1cmVzID0gb3BzLT5nZXRfYmFja2VuZF9mZWF0dXJlcyh2LT52ZHBh
KTsKPj4+Pj4+Pj4gICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBBX0JB
Q0tFTkRfRkVBVFVSRVMgfAo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPj4+Pj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpIHwKPj4+
Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0spKSkKPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcykpCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4+Pj4+PiAgICAgICAgICAgICAgICBpZiAoKGZl
YXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4+Pj4+Pj4+IC0t
Cj4+Pj4+Pj4+IDIuMzkuMwo+Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+Pgo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
