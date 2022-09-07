Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F1AC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 06:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 884BA402C3;
	Wed,  7 Sep 2022 06:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 884BA402C3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IDsH7lw6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGGZj6jgB7_m; Wed,  7 Sep 2022 06:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B96B40199;
	Wed,  7 Sep 2022 06:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B96B40199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55B03C0033;
	Wed,  7 Sep 2022 06:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF33BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 690304035A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 690304035A
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IDsH7lw6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lq5HtcCesBkQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:49:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A0474034C
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A0474034C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9eK5hloTta1wp36YOxf95tNfWOxPQwYCpmcF4I2j6r6DAtQNvMFD51OKOkIb2Ade2qqXB/IFqawzBMdJcdw2bq4Qs2Xzj2q487dzm2RqIzdlaKqi6nb28CkfWixsfNKF+4V9PrN/NQAWmya1ZW4q+8JZgM+3Hv7W//BtURz5b0eEBB+blUayxLkQfjzid+q4MkawOUiZkrNQYbU+BXgCyWyWI7tYAy5TKcV88fpS/wdIHGK+xN9FYD0LmigS4eAEtxVhADY153jjCO1sm/ZHEWfzW/5tfpRggiz8AvAI3VvjSfXNnEZTSRbnNU4HoCW80+JjI4Q0dA4S/2g27n/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WHcKTERWrh9XOL/K5EoOzApFETCUCkt9hA2+DPhc3c=;
 b=ck6f0jzp5XeUcb3dLbR/7cilsbCYjhuPaNRd9HdFD3kR0BQnBNoIw/zdQA+gitAzR3O+F2uKV/A2zKIPMmYmv8gFRN9lFaJrwDHDzSKUoYSvu8z057k1wy2SgJAfbd+WOZD/Vc4H+9NDsXyFbRNWgFOu8j1UV3AN+rT4MBxEwKofJ6EU+AVXQ/lY7+8Xb+PQREhzRmRGjhHUXXW4yARsDcSaZnPN1shccLrrPXU/mpxrh1pb9fZMIlWqyqa1q9PHyAmSMwkIoWJ2uTtgtU4aTPIAUDSwHH7XC+UciadfKwpBRSLfJVtaFOyV6ESIMbGewwPKjnlbqLwXip6B5J0YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WHcKTERWrh9XOL/K5EoOzApFETCUCkt9hA2+DPhc3c=;
 b=IDsH7lw6M2CA+vKo9VCd6qfE5ZzzvEjBpKvB1CRAWHLCRyZVM/mc/8XpeTVmZn0j0W+dEMhSpzRRKlogAGGApkEuyBYJQADp7N6roVbheRQ9xsSA38jgA6caFapnxxA3OejvQCUP7WbYwuRXu/20jDCRAL+StbHcZbhK3qP1nZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 06:49:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 06:49:30 +0000
Message-ID: <e4b016b1-169b-5e62-ab0b-029ebc26fbb3@amd.com>
Date: Wed, 7 Sep 2022 08:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kvm@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20220815095423.11131-1-dmitry.osipenko@collabora.com>
 <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
 <YxenK8xZHC6Q4Eu4@phenom.ffwll.local> <YxeoEr6xAtlZ+IrU@phenom.ffwll.local>
In-Reply-To: <YxeoEr6xAtlZ+IrU@phenom.ffwll.local>
X-ClientProxiedBy: AS9PR06CA0231.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a15cded-a3fe-4c42-17cd-08da909d1d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTKD38tvPBubZulcOLnuSoh19Qlo12y5rAyJFrFsl7nim68X6gcMDEnpSBUM4o52Up3RhzJZmJR5/uEQ0HiOoprFnMNHM+YMHqVzjMv3hGNLXHCl5DWLAnzJDRj8EIfSSez+m6arBP/YA5l430fsOlRk8vrBUvJ6KLNhg0+5GinXHRCrzAqDCicESBsUo72NbLP+jTSBGgtxGz7mK92tl72ABoCJ+lsDRDkHFF8RQxCHaCTfy9z9Pun6plV/hUnaVNlECTms6olwEuCL+wRhWgzydvGkx51mwiRhUEpFL20qc6w2jwg0WM8qNDZGY8VIiRn9fw6DZoPVvzNRGwnHp7ffMNiQEdO7TC+z3VUAh1JuTp5G/Bn/MoBxKlfy7mZuDjn4IpbOtC0mQk2Yf50Z1a+i3pW5CmGECDZznrWl+15JQmD8KHua0ePGYgxRtgNDaZcG56Ue9y/LmQzb+zfGHBwadMmtkVN/M7xcF2b4/DjbYszvM3tRmNhfQCT4lSSTDZGNVG+U/8m83bj5lFY+GlvE//QmmHj1+oYSXMjRwwqe3eAsXZJVI6JI6PWIlumG4QNKDFbUdxXJRxafKkbmGI1h7IE5pWmr95tRPyFrD33+R+DbC3sCvpCj+q68HZjwg7YPG4HLFtSqSGQpsVZnHrevDh7n1t3QIhBuKMLOOx/xH4zgN0o1/o5B7b97P70RNiigfHK0YSja6hInCY76lZDenx9nABqgJeTcR1k308Ee48NDINaToGxR2OKlRI2H8FzBQUlVSv8ybyrchaJrpXspdAq/51XFBecfKJec6rHV5eDtGYOUOu3C8vmamd7q4kT6F7YdcxZeqAQ+iaSkVJ0zJbdujk9w4wGRo5mgs58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(45080400002)(31686004)(38100700002)(41300700001)(316002)(36756003)(921005)(110136005)(31696002)(66946007)(66556008)(6506007)(478600001)(83380400001)(8676002)(6486002)(966005)(66476007)(186003)(66574015)(86362001)(8936002)(2616005)(7416002)(5660300002)(2906002)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdoZ3RJOUk2bHh5TUNUcU9vWUJvVFlzWGNwVWVsc3RIakQyeXh2bk5oeUpi?=
 =?utf-8?B?UU5vZnIrelNBYXFhWEVYaXBxRVk0STJVVEM4ZzlZZWlrLzBnQTBZWnNDMUVS?=
 =?utf-8?B?dzVXdlRHUnRzK2E5cEM5UXVPeGdjcXh3YUV3R1gwSlN3Tkp3eG92akZsWXo1?=
 =?utf-8?B?dWZEeVJQWWx3Wk1wVm5iTDN1MmZEWFNVeHFKZUxrUlJoRnRURzRVNk8yYkZW?=
 =?utf-8?B?NFRsTVduUHJNVXkrSVRDa2RyZjJGRE1YcnpzL3l4NjJCVXl1cU04eThiYzFW?=
 =?utf-8?B?S3NUYVNVYW1IMk9ocDlOUGxLUkRoTzdjV0pITS9WSHFQNE1NdVVMYkFoU2h4?=
 =?utf-8?B?Vjk0cFdZdnZRdkczbVVvMUwzeWN0ZmxJSVpWSFZ2T1lDMCtaU3JLVDJJcVVK?=
 =?utf-8?B?bDFPb2RBeE5ZdmVQdFk1TGFwc2hhcysyQllpVHlqYWJTY2htZm1vSDYyTUFY?=
 =?utf-8?B?S3IyRUowTjlWa2NnS2V4MGMzZjhqQW1FTFdPc0RLdFpHaEpRRkNGTGJ2OExQ?=
 =?utf-8?B?RVVRVjUxTm0rOExvMEU2VjZCYnBXSEtXOC9QSnBabkphbVhveStQd3BkMGo3?=
 =?utf-8?B?bklkMU1pdGFGM1ZSVklYWlQxS3c0RDh4MzliNjJsd3JFWTI2VzhCMXdNVWtI?=
 =?utf-8?B?c2xVQVIwNjFEd1ViZCtrVWZFMnhudUJlNFVVTDZ5c2Y2ZGNnQ1lKZ20wQzZk?=
 =?utf-8?B?ZzF3NVpDdzA4US9QcTNxYjlCcnRYczJCb09hd05NdU9zb1huTHM1dHhvUzJn?=
 =?utf-8?B?dXlSaThrb01MUy9NV2Zsc21WdWZLQ3V5bVhoTnlBbS91S1F3ZUdZRGx6dk1N?=
 =?utf-8?B?VlYzNTIvajE0YlJuNFRybVRYakUrcFR6b3FiU1JLSnhzemlrWkdvRDV6TGZN?=
 =?utf-8?B?dllhaVlXMm4valFDcDFFNEovdzMxOUNPNTM2THV0Z3ppS0Q2VmQyUllPdnVL?=
 =?utf-8?B?Y3gxOTVQd1drSnlzYjkzSUhqQWROQzlwY1pnNFZ4V2ZUV2psbEZkQnBUd01l?=
 =?utf-8?B?Z0ZwcForWEl2WEhFZ2RXK0lNUHhCQ09RWWhSVnFMaFBuRmswdDJXeC9hcDVy?=
 =?utf-8?B?MThzb2VOaHN5dkdpc3o1a0cxT1lOa05Fb0xkdUdiR3NGcHl6ZGVzYm41U2Nt?=
 =?utf-8?B?R3FzWjEvS2U3VzErdkJtdmFIRU9qOFZQWmhFTkNuVWppWm1Da1NWczNWSW9i?=
 =?utf-8?B?a3FhaU43aXUzS1N3Tlp6V080VVRhQ2YxYmV4dnVQU256a1FNOE1sdmkvWVJ3?=
 =?utf-8?B?MnlCQ3dmM2NPN2dYakZUL284cGx2dmZReUp4YWZzaGJKNjFTNnpBN1ZFTkJW?=
 =?utf-8?B?NTZ3b1VseTlzTHBjMEs1VmlJS3NySkFQK280b2lmZ2EySzhMNzFJSTZaZlpv?=
 =?utf-8?B?b1JZUDhVKzRhSUhZSmR5R29MeGRpMlpJd0RiNVQvSUoyV2s4bFpGazNYVnVN?=
 =?utf-8?B?ZitZd0tZbnFIZjJxcmJkTDlISThqODlaQS9WUXpmcFkwcW9YQ1dydVZyZW9C?=
 =?utf-8?B?bFU5bDNEODdvSXd1SDhQeVBKSi92NzhNTEVRcmx5MWpPMmlUTW5JZEk3bTQw?=
 =?utf-8?B?T0RzSE5ZOU1Rbnl0cmNTdDRaVkhhUkQ2dmt4WUxwRFVudmdJdVpNWW5UckZs?=
 =?utf-8?B?ckkvWFg1ZGtkS3BCWGdRd2JlUDh4c3VJR0p6RDlXMFVwbkpmTjRXbXJEdExt?=
 =?utf-8?B?QkZJWG5INnExUDFCN2VPdGF2N09oZXptdWdsdUwvN0Z0ZFVGWUFkN0gxckZq?=
 =?utf-8?B?bkYrSlU5TnhvVERFNFViQlFKY0VESXNlT1FjcW5JM0l0UEo0akVCTFZZZndP?=
 =?utf-8?B?OUdUZGtPWlFPVWt3NFErZTlhRHEvODRDSm1teGpyKytJYnVpbkZNWnJST0Qz?=
 =?utf-8?B?QzBvelE1UGNjRTFDU25CTDMvMUU1SnNLVVIxMnhaVnlNZUZuM3A4MFM4dlV4?=
 =?utf-8?B?V1d3N3czaVhCR1dUQllpSDd3anJ5c2IzbDc5Q3ZnODlSU2Z4ZzQxdGVnQWNy?=
 =?utf-8?B?cDB0a0taSzZnUENLTGo2WWM4Qkx5Zm9sRW5iTjFoZVpOYVh2Yk14MWFlSVJw?=
 =?utf-8?B?c2M2d05iSFdlTUtiZUltdW9zVWkxOW1xM3lWOExFTjd0bEFzdGxVMmZwVjQ1?=
 =?utf-8?Q?XzhleFf6c9AhkerYmFT99RmjI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15cded-a3fe-4c42-17cd-08da909d1d54
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 06:49:30.4849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epol+vKQuw/TwnFN9oslkMqY5iolbaSKns7ypQZPNCDAoL+iB77dMd8FATb07QjB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMDYuMDkuMjIgdW0gMjI6MDUgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFR1ZSwgU2Vw
IDA2LCAyMDIyIGF0IDEwOjAxOjQ3UE0gKzAyMDAsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4+IE9u
IE1vbiwgQXVnIDE1LCAyMDIyIGF0IDEyOjA1OjE5UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4+PiBBbSAxNS4wOC4yMiB1bSAxMTo1NCBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoK
Pj4+PiBIaWdoZXIgb3JkZXIgcGFnZXMgYWxsb2NhdGVkIHVzaW5nIGFsbG9jX3BhZ2VzKCkgYXJl
bid0IHJlZmNvdW50ZWQgYW5kIHRoZXkKPj4+PiBuZWVkIHRvIGJlIHJlZmNvdW50ZWQsIG90aGVy
d2lzZSBpdCdzIGltcG9zc2libGUgdG8gbWFwIHRoZW0gYnkgS1ZNLiBUaGlzCj4+Pj4gcGF0Y2gg
c2V0cyB0aGUgcmVmY291bnQgb2YgdGhlIHRhaWwgcGFnZXMgYW5kIGZpeGVzIHRoZSBLVk0gbWVt
b3J5IG1hcHBpbmcKPj4+PiBmYXVsdHMuCj4+Pj4KPj4+PiBXaXRob3V0IHRoaXMgY2hhbmdlIGd1
ZXN0IHZpcmdsIGRyaXZlciBjYW4ndCBtYXAgaG9zdCBidWZmZXJzIGludG8gZ3Vlc3QKPj4+PiBh
bmQgY2FuJ3QgcHJvdmlkZSBPcGVuR0wgNC41IHByb2ZpbGUgc3VwcG9ydCB0byB0aGUgZ3Vlc3Qu
IFRoZSBob3N0Cj4+Pj4gbWFwcGluZ3MgYXJlIGFsc28gbmVlZGVkIGZvciBlbmFibGluZyB0aGUg
VmVudXMgZHJpdmVyIHVzaW5nIGhvc3QgR1BVCj4+Pj4gZHJpdmVycyB0aGF0IGFyZSB1dGlsaXpp
bmcgVFRNLgo+Pj4+Cj4+Pj4gQmFzZWQgb24gYSBwYXRjaCBwcm9wb3NlZCBieSBUcmlnZ2VyIEh1
YW5nLgo+Pj4gV2VsbCBJIGNhbid0IGNvdW50IGhvdyBvZnRlbiBJIGhhdmUgcmVwZWF0ZWQgdGhp
czogVGhpcyBpcyBhbiBhYnNvbHV0ZWx5Cj4+PiBjbGVhciBOQUshCj4+Pgo+Pj4gVFRNIHBhZ2Vz
IGFyZSBub3QgcmVmZXJlbmNlIGNvdW50ZWQgaW4gdGhlIGZpcnN0IHBsYWNlIGFuZCBiZWNhdXNl
IG9mIHRoaXMKPj4+IGdpdmluZyB0aGVtIHRvIHZpcmdsIGlzIGlsbGVnYWwuCj4+Pgo+Pj4gUGxl
YXNlIGltbWVkaWF0ZWx5IHN0b3AgdGhpcyBjb21wbGV0ZWx5IGJyb2tlbiBhcHByb2FjaC4gV2Ug
aGF2ZSBkaXNjdXNzZWQKPj4+IHRoaXMgbXVsdGlwbGUgdGltZXMgbm93Lgo+PiBZZWFoIHdlIG5l
ZWQgdG8gZ2V0IHRoaXMgc3R1ZmYgY2xvc2VkIGZvciByZWFsIGJ5IHRhZ2dpbmcgdGhlbSBhbGwg
d2l0aAo+PiBWTV9JTyBvciBWTV9QRk5NQVAgYXNhcC4KPiBGb3IgYSBiaXQgbW9yZSBjb250ZXh0
OiBBbnl0aGluZyBtYXBwaW5nIGEgYm8gc2hvdWxkIGJlIFZNX1NQRUNJQUwuIEFuZCBJCj4gdGhp
bmsgd2Ugc2hvdWxkIGFkZCB0aGUgY2hlY2tzIHRvIHRoZSBnZW0gYW5kIGRtYS1idWYgbW1hcCBm
dW5jdGlvbnMgdG8KPiB2YWxpZGF0ZSBmb3IgdGhhdCwgYW5kIGZpeCBhbGwgdGhlIGZhbGxvdXQu
Cj4KPiBPdGhlcndpc2UgdGhpcyBkcmFnb24ga2VlcHMgcmVzdXJyZWN0aW5nIC4uLgo+Cj4gVk1f
U1BFQ0lBTCBfd2lsbF8gYmxvY2sgZ2V0X3VzZXJfcGFnZXMsIHdoaWNoIHdpbGwgYmxvY2sgZXZl
cnlvbmUgZnJvbQo+IGV2ZW4gdHJ5aW5nIHRvIHJlZmNvdW50IHRoaXMgc3R1ZmYuCj4KPiBNaW5p
bWFsbHkgd2UgbmVlZCB0byBmaXggdGhpcyBmb3IgYWxsIHR0bSBkcml2ZXJzLCBhbmQgaXQgc291
bmRzIGxpa2UKPiB0aGF0J3Mgc3RpbGwgbm90IHlldCB0aGUgY2FzZSA6LSggSWlyYyBsYXN0IHRp
bWUgYXJvdW5kIHNvbWUgZnVua3kgYW1ka2ZkCj4gdXNlcnNwYWNlIHdhcyB0aGUgaG9sZC11cCBi
ZWNhdXNlIHJlZ3Jlc3Npb25zPwoKTXkgcmVjb2xsZWN0aW9uIGlzIHRoYXQgRmVsaXggYW5kIEkg
Zml4ZWQgdGhpcyB3aXRoIGEgS0ZEIHNwZWNpZmljIAp3b3JrYXJvdW5kLiBCdXQgSSBjYW4gZG91
YmxlIGNoZWNrIHdpdGggRmVsaXggb24gTW9uZGF5LgoKQ2hyaXN0aWFuLgoKPiAtRGFuaWVsCj4K
Pj4gSXQgc2VlbXMgb3QgYmUgYSByZWN1cnJpbmcgYW1vdW50IG9mIGZ1biB0aGF0IHBlb3BsZSB0
cnkgdG8gbW1hcCBkbWEtYnVmCj4+IGFuZCB0aGVuIGNhbGwgZ2V0X3VzZXJfcGFnZXMgb24gdGhl
bS4KPj4KPj4gV2hpY2gganVzdCBkb2Vzbid0IHdvcmsuIEkgZ3Vlc3MgdGhpcyBpcyBhbHNvIHdo
eSBSb2IgQ2xhcmsgc2VuZCBvdXQgdGhhdAo+PiBkbWEtYnVmIHBhdGNoIHRvIGV4cG9zIG1hcHBp
bmcgaW5mb3JtYXRpb24gKGkuZS4gd2MgdnMgd2IgdnMgdW5jYWNoZWQpLgo+Pgo+PiBUaGVyZSBz
ZWVtcyB0byBiZSBzb21lIHNlcmlvdXMgYm9uZ2hpdHMgZ29pbmcgb24gOi0vCj4+IC1EYW5pZWwK
Pj4KPj4+IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnCj4+Pj4gQ2M6IFRyaWdnZXIgSHVhbmcgPFRyaWdnZXIuSHVhbmdAZ21haWwuY29t
Pgo+Pj4+IExpbms6IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnd3dy5jb2xsYWJvcmEuY29tJTJGbmV3cy1hbmQtYmxvZyUy
RmJsb2clMkYyMDIxJTJGMTElMkYyNiUyRnZlbnVzLW9uLXFlbXUtZW5hYmxpbmctbmV3LXZpcnR1
YWwtdnVsa2FuLWRyaXZlciUyRiUyM3Fjb20xMzQzJmFtcDtkYXRhPTA1JTdDMDElN0NjaHJpc3Rp
YW4ua29lbmlnJTQwYW1kLmNvbSU3QzM3YTdkOWIwZjkxMjQ5ZGE0MTViMDhkYTkwNDMyZDNhJTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzk4MDkxNTQ3MTI4
MDA3OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFt
cDtzZGF0YT1YTjZ3RmlXYzZKbGpla21zdDBhT0NQU1RzRkxsbWtVakQ5RiUyRmw5bmx1QXMlM0Qm
YW1wO3Jlc2VydmVkPTAKPj4+PiBUZXN0ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9z
aXBlbmtvQGNvbGxhYm9yYS5jb20+ICMgQU1ER1BVIChRZW11IGFuZCBjcm9zdm0pCj4+Pj4gU2ln
bmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNv
bT4KPj4+PiAtLS0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29sLmMgfCAyNSAr
KysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9wb29sLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29sLmMKPj4+
PiBpbmRleCAyMWI2MTYzMWY3M2EuLjExZTkyYmIxNDljOSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29sLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9wb29sLmMKPj4+PiBAQCAtODEsNiArODEsNyBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnR0
bV9wb29sX2FsbG9jX3BhZ2Uoc3RydWN0IHR0bV9wb29sICpwb29sLCBnZnBfdCBnZnBfZmxhZ3Ms
Cj4+Pj4gICAgCXVuc2lnbmVkIGxvbmcgYXR0ciA9IERNQV9BVFRSX0ZPUkNFX0NPTlRJR1VPVVM7
Cj4+Pj4gICAgCXN0cnVjdCB0dG1fcG9vbF9kbWEgKmRtYTsKPj4+PiAgICAJc3RydWN0IHBhZ2Ug
KnA7Cj4+Pj4gKwl1bnNpZ25lZCBpbnQgaTsKPj4+PiAgICAJdm9pZCAqdmFkZHI7Cj4+Pj4gICAg
CS8qIERvbid0IHNldCB0aGUgX19HRlBfQ09NUCBmbGFnIGZvciBoaWdoZXIgb3JkZXIgYWxsb2Nh
dGlvbnMuCj4+Pj4gQEAgLTkzLDggKzk0LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqdHRtX3Bv
b2xfYWxsb2NfcGFnZShzdHJ1Y3QgdHRtX3Bvb2wgKnBvb2wsIGdmcF90IGdmcF9mbGFncywKPj4+
PiAgICAJaWYgKCFwb29sLT51c2VfZG1hX2FsbG9jKSB7Cj4+Pj4gICAgCQlwID0gYWxsb2NfcGFn
ZXMoZ2ZwX2ZsYWdzLCBvcmRlcik7Cj4+Pj4gLQkJaWYgKHApCj4+Pj4gKwkJaWYgKHApIHsKPj4+
PiAgICAJCQlwLT5wcml2YXRlID0gb3JkZXI7Cj4+Pj4gKwkJCWdvdG8gcmVmX3RhaWxfcGFnZXM7
Cj4+Pj4gKwkJfQo+Pj4+ICAgIAkJcmV0dXJuIHA7Cj4+Pj4gICAgCX0KPj4+PiBAQCAtMTIwLDYg
KzEyMywyMyBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnR0bV9wb29sX2FsbG9jX3BhZ2Uoc3RydWN0
IHR0bV9wb29sICpwb29sLCBnZnBfdCBnZnBfZmxhZ3MsCj4+Pj4gICAgCWRtYS0+dmFkZHIgPSAo
dW5zaWduZWQgbG9uZyl2YWRkciB8IG9yZGVyOwo+Pj4+ICAgIAlwLT5wcml2YXRlID0gKHVuc2ln
bmVkIGxvbmcpZG1hOwo+Pj4+ICsKPj4+PiArcmVmX3RhaWxfcGFnZXM6Cj4+Pj4gKwkvKgo+Pj4+
ICsJICogS1ZNIHJlcXVpcmVzIG1hcHBlZCB0YWlsIHBhZ2VzIHRvIGJlIHJlZmNvdW50ZWQgYmVj
YXVzZSBwdXRfcGFnZSgpCj4+Pj4gKwkgKiBpcyBpbnZva2VkIG9uIHRoZW0gaW4gdGhlIGVuZCBv
ZiB0aGUgcGFnZSBmYXVsdCBoYW5kbGluZywgYW5kIHRodXMsCj4+Pj4gKwkgKiB0YWlsIHBhZ2Vz
IG5lZWQgdG8gYmUgcHJvdGVjdGVkIGZyb20gdGhlIHByZW1hdHVyZSByZWxlYXNpbmcuCj4+Pj4g
KwkgKiBJbiBmYWN0LCBLVk0gcGFnZSBmYXVsdCBoYW5kbGVyIHJlZnVzZXMgdG8gbWFwIHRhaWwg
cGFnZXMgdG8gZ3Vlc3QKPj4+PiArCSAqIGlmIHRoZXkgYXJlbid0IHJlZmNvdW50ZWQgYmVjYXVz
ZSBodmFfdG9fcGZuX3JlbWFwcGVkKCkgY2hlY2tzIHRoZQo+Pj4+ICsJICogcmVmY291bnQgc3Bl
Y2lmaWNhbGx5IGZvciB0aGlzIGNhc2UuCj4+Pj4gKwkgKgo+Pj4+ICsJICogSW4gcGFydGljdWxh
ciwgdW5yZWZlcmVuY2VkIHRhaWwgcGFnZXMgcmVzdWx0IGluIGEgS1ZNICJCYWQgYWRkcmVzcyIK
Pj4+PiArCSAqIGZhaWx1cmUgZm9yIFZNTXMgdGhhdCB1c2UgVmlydElPLUdQVSB3aGVuIGd1ZXN0
J3MgTWVzYSBWaXJHTCBkcml2ZXIKPj4+PiArCSAqIGFjY2Vzc2VzIG1hcHBlZCBob3N0IFRUTSBi
dWZmZXIgdGhhdCBjb250YWlucyB0YWlsIHBhZ2VzLgo+Pj4+ICsJICovCj4+Pj4gKwlmb3IgKGkg
PSAxOyBpIDwgMSA8PCBvcmRlcjsgaSsrKQo+Pj4+ICsJCXBhZ2VfcmVmX2luYyhwICsgaSk7Cj4+
Pj4gKwo+Pj4+ICAgIAlyZXR1cm4gcDsKPj4+PiAgICBlcnJvcl9mcmVlOgo+Pj4+IEBAIC0xMzMs
NiArMTUzLDcgQEAgc3RhdGljIHZvaWQgdHRtX3Bvb2xfZnJlZV9wYWdlKHN0cnVjdCB0dG1fcG9v
bCAqcG9vbCwgZW51bSB0dG1fY2FjaGluZyBjYWNoaW5nLAo+Pj4+ICAgIHsKPj4+PiAgICAJdW5z
aWduZWQgbG9uZyBhdHRyID0gRE1BX0FUVFJfRk9SQ0VfQ09OVElHVU9VUzsKPj4+PiAgICAJc3Ry
dWN0IHR0bV9wb29sX2RtYSAqZG1hOwo+Pj4+ICsJdW5zaWduZWQgaW50IGk7Cj4+Pj4gICAgCXZv
aWQgKnZhZGRyOwo+Pj4+ICAgICNpZmRlZiBDT05GSUdfWDg2Cj4+Pj4gQEAgLTE0Miw2ICsxNjMs
OCBAQCBzdGF0aWMgdm9pZCB0dG1fcG9vbF9mcmVlX3BhZ2Uoc3RydWN0IHR0bV9wb29sICpwb29s
LCBlbnVtIHR0bV9jYWNoaW5nIGNhY2hpbmcsCj4+Pj4gICAgCWlmIChjYWNoaW5nICE9IHR0bV9j
YWNoZWQgJiYgIVBhZ2VIaWdoTWVtKHApKQo+Pj4+ICAgIAkJc2V0X3BhZ2VzX3diKHAsIDEgPDwg
b3JkZXIpOwo+Pj4+ICAgICNlbmRpZgo+Pj4+ICsJZm9yIChpID0gMTsgaSA8IDEgPDwgb3JkZXI7
IGkrKykKPj4+PiArCQlwYWdlX3JlZl9kZWMocCArIGkpOwo+Pj4+ICAgIAlpZiAoIXBvb2wgfHwg
IXBvb2wtPnVzZV9kbWFfYWxsb2MpIHsKPj4+PiAgICAJCV9fZnJlZV9wYWdlcyhwLCBvcmRlcik7
Cj4+IC0tIAo+PiBEYW5pZWwgVmV0dGVyCj4+IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jw
b3JhdGlvbgo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cCUzQSUyRiUyRmJsb2cuZmZ3bGwuY2glMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2No
cmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDMzdhN2Q5YjBmOTEyNDlkYTQxNWIwOGRhOTA0MzJk
M2ElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3OTgwOTE1
NDcxMjgwMDc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0Ml
N0MmYW1wO3NkYXRhPWJHWjFPQXhMJTJGZDk5TnF1NDlzb1daVnF2dlVLanVENm42QktrQWhNdjRm
cyUzRCZhbXA7cmVzZXJ2ZWQ9MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
