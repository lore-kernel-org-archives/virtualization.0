Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF5C6FD1F
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 12:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C147681CAF;
	Sun, 12 Mar 2023 12:00:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C147681CAF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Yk5oHyFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODRK6YlMULLj; Sun, 12 Mar 2023 12:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2446581757;
	Sun, 12 Mar 2023 12:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2446581757
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB26FC0035;
	Sun, 12 Mar 2023 12:00:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C53F3C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93A2441714
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:00:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93A2441714
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Yk5oHyFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dv2u9Wj9zKAk
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:00:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 360A0415F0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 360A0415F0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nve7nE3+VJUprh7nIkUC3+2BytIM8xFnSn1Lyanloy0rzE6edAvV87JTsl/xCFmmbjVDRW/xg8kP13efHU8b4D+STGfUc3k1IOgyU/P7TQIUcpOdLYb0IvIJEtfVQyJqSIl9Y2bv4XNPFmTE/VvvvGuasJNH16J2gcdbD25jJmAkJkU0rjDA87wVLsPnqjQE1mfvkMeQ5dZ5LIGf7u1YRhtyE5cr49yDbe9lzMfd2kC7Q/KcQFfw33KozIDivPW8TffN92RVlWJHTjFek9Vw8FhXTfiE5iu9STEJX8npMHCJaqXkSEzXZNja0ztlGQncxnZe7hcbvruQW/XNGQXOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG2+lT2G0gVkzx3NHkVk1XEOldo0yzjB7y4qqR4tvZk=;
 b=GZCiKhUXQfKEjkqtv+fJ+bjIK0HgX6S6QFJld8EAxlL5qt3FlpHyatgkVcMaD1jTtTAG1Rinsbrhy6FN1EPWt3tEP+WeUOd4llzx6xtoaxeim7VDJpCBN3gJdyUBZsC3mVT1luyN/9rE/w9RWqhN2nPR2dS1LY1p0Gndh+PmWhhEvEzePwln5vwnZKMe5/iqIada75CPathynkxYttJiJL6ys3t1RnVHmAvdN8y9i+HjMFnDDZ7dDBbvZs2g7eb0cQkREX0nVwYYTuc8R++MNoTXX9xiK/+lJ/a8wsbuwoEVGdzhn1WvuIInNaPGzbP6iRV962ov2ngkkEdpJFoEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG2+lT2G0gVkzx3NHkVk1XEOldo0yzjB7y4qqR4tvZk=;
 b=Yk5oHyFET1UKDjIaBp1IxQTPf2cH917VU+CUX5MWyC2Eo8/uMa+a+bKsz+R7dOZGCWaugaE3fObkqKjEBsvvLT1qRGEOTrpTLBjPz9VmuYMoF8jGnEXc2yBEGEjlozPdln5vV8iElS9iNOlUc5mtWZsSNQp+DgUYTLPK1T1WTSZoHFABwC462bchgiiYe8jLLI1b//DPb4AhvXhORclQTWLPFGCGK5O0U+BcOtwYZUnoKqLfI6gd1+Cna54UdZaveq5g8hsUhAQ57Fvs+Qm6fbHrdglJ10qVdyQl6boxqmza7R4ld5Rq3vXTpprTTruwLHCkLq1jrHcYV2a0yoXguQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 12:00:34 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 12:00:34 +0000
Message-ID: <80a76c11-ae7d-0220-5500-a3b22871b940@nvidia.com>
Date: Sun, 12 Mar 2023 08:00:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310030624-mutt-send-email-mst@kernel.org>
 <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
 <20230311140528-mutt-send-email-mst@kernel.org>
 <4da4a05e-4b0f-2c1e-8b58-ade2c620c868@nvidia.com>
 <20230312014705-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230312014705-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DM6PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:5:334::32) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ac6862-1e67-4cd4-4caf-08db22f162eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmILZbQqMLq1Hyrjd44MzmpLWZTciyWMcBh30U6G+gsoyZBqCkDPsh3MDZj7tPr73Qd9ng8FsOckrXMrlQFQl5OFKNfbVW4hNMCIIxjpy5cSQBCyBhkUHUFqKnHlB751y8IWwxXMY4AbjwVg1cvnXbN2ZD//dT7mSzlRCsELWwfcouWpozkrf26GnAHMcL+FZ0SEum3pt1s0+T9yZv20irvTfuBiGfJ/m+0ywKwC3gti0VpDNssFKhSNAE865qO+xaaLf116XNmt5P022/dkT6JjC6O6dh/Q7gnLxyov6lGtVLZEnm7u/QcLz7Gf7bjScq8Jhs+PzPfByPn/46bvYI3UxygwzYQJf7QAL/bwP88jbvKuAyp1zH/yu1CNL/tANDEmewr/QkkF+bmSi3oYwAN/y/epYwMswMFSpDFkQ6cYV/0BgF0ah9/Enna7UvRmmD0QotBoRBg7SxnsWZ5nY2tvHnVkP78GWqDsAkH8Wniuq3mbVmyzx02GzPTjQ9UEhamku9Tv1gbsGMvCyLhBiKCKOHqP7FDL3OUPPQ4HVJyrLSICVTZT/SPVv446knK1drkquFudx7Jtx3GIn1RpEeFufWb2XNLCIWPEM7CN4hwfkreJ+7U/5+HIXlUP/9E6M3jqvWJrZlkKGZnfwF70hYJ2eDb+tHkxUB5s0DcWCl4nKs1x1rftblBPqJpYLlJZkVL/VHoCftGJINEeHpkJTLl3/1kLwc/iEMz3y/pXOCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(451199018)(5660300002)(36756003)(83380400001)(45080400002)(478600001)(6666004)(6512007)(6506007)(26005)(966005)(6486002)(2616005)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(86362001)(31696002)(316002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhsQUhlRmVXRTE3N1RzU3hUVUR6NVZ5N1FIRzlpeHpOeXlWWHVFNTlzWFFa?=
 =?utf-8?B?SkUzT3hrdGFvU3lhRXRGditlQXJyOUhzcE12R2puamhMbFJDMmovb2hEV2lS?=
 =?utf-8?B?R2I0V0RQdElGc3QvTnRnTkc3V3Q2alBpQkttMHJJVzVKMkVzUnhxbTRLajNB?=
 =?utf-8?B?TzBmZWRvMWJtajk1UWdHbXhMRlhHRkswL1VmcTZMWjZwRVByNWxhdWV0RzlZ?=
 =?utf-8?B?c29lck5tWjRQcXhZYjZYbVI2aWw3THlJancxTjRweWJkaE5iZ3RpcDY0T25X?=
 =?utf-8?B?UkxNZ0hTamtIWS9hZFNBKzFwRzNIZEZsblBDU2xkdmdLdHZFUngzR2oxaWFQ?=
 =?utf-8?B?bllyWnZBbUdNWGFCd0J3bk1PTk1HOS93WjRwN3l4WlZxNFBQbDhqMGZhZkQ3?=
 =?utf-8?B?RGE5ZWpwaEZrcTZrTVVFbzJpeU10RGZZZ24wSkVKYmovVDZSQmduc2lna1or?=
 =?utf-8?B?WlRhRk5LUmZPaUlpWm83dlp5aDBKblcvY3JXcXgxcSt0bE5LR05kTjZXYWlr?=
 =?utf-8?B?cWtWNjRERXJ5UEplUU8yb1pQSG9vbXFPZm85bkZHa0ttQkhKM24rcFd5WTN3?=
 =?utf-8?B?R0VlYXRyeGt4U1lzQld1a0hpTXB1OVRJdzBzV1l5cGE0Z1FqeUVoa2NmdnNS?=
 =?utf-8?B?a21yVmdZcCtCelVqQUErMkh1akdvWHhVVHNhQ3pLYWhndjcyaDZ6UTRUMEVi?=
 =?utf-8?B?TTVRVmxGWnBQQzk4L3ZrN2E0bFFIQjdyVno4ZzZFZXN6NmI5OVMwS3JJREtB?=
 =?utf-8?B?TFc0NE10dnRDcklhY210SjJWWXFDSkorSEo1VFY4cFp0bTV1TkRaOGZVV2ZJ?=
 =?utf-8?B?bWpIekNvSVVoMFMyQVY0b292UkxTbWpQYmdic2F5VFErNE95WjZycFN1cmxU?=
 =?utf-8?B?OGxHdlVMQlpqZHRDSGxEOXVHTDJ2dXNrVWh6TGg4ODQxcFVxMll3NzcrOEVW?=
 =?utf-8?B?MmJPd1ZJWDdFY2xncmpzUWVaMUIrb25sVFQzaEx6SGxuY3Y0Tks0QVRpcDVP?=
 =?utf-8?B?M3hJY2lscFJBTlZ5OHZVdVFaYU1Vb1dxaGRiZWQ1V0IwekM2amxYNk1qWk0v?=
 =?utf-8?B?ZmduMTdxMFAxUllyRmJnWkdnSmJWcjJNNFNrZlA4OEtoVjZDOHpQV3B1T25y?=
 =?utf-8?B?VzVXOVZiWmw2c3FMYXFzd2RyK3pDN29WMXZVOUt0MTdGMzZSNFFwOXM0WDRL?=
 =?utf-8?B?di90OGZTcGFnb0orUXN2SUx2MHNSTi9oU0VYQk5SQjJwREpEZFltL21ZK3J2?=
 =?utf-8?B?Mkg1YlMvN1JHNjVxOUl4OUdoNVp6ZWNCL1drTUpyV081RnJhWlpyaWxUd1Ew?=
 =?utf-8?B?djR2S0R0MXo3eTU1cEU3amtsZGFEcERPcVRTbmxDR2tXTmpDR0FZWlVLR1Ir?=
 =?utf-8?B?bVBjMUN1ZnR1TmpuZG00bXBsbWw4VEsxQ1l6OXpLQ09iK0dHNEFrSHBQVnJh?=
 =?utf-8?B?anZkSjRQT1A0ekEzUDdkWW1ZMjU2THVIdHdhMm1rVWxLOGF6TjNqS0IydmpW?=
 =?utf-8?B?QjdRZElVbmRqd0pqWlFFcGhJcDJHL0hPeWJyZExIMlVuOE5NNW8veHRHVWNQ?=
 =?utf-8?B?QlVvRjJ2L3RxMjlNakZBcFpWQUtieC9LTWQyVGxQbHBlb0o0M1hOdm9ZcFdS?=
 =?utf-8?B?d1E0OHNuTllLa2NMVm1oeHIyam9WVzlTcEVWZmRMYUNYcTcxaTgyMERwSitk?=
 =?utf-8?B?VER2Zlg4Q2g1dExnOUE3dXprenA0YmliZTB5UEFOaHFDL2lwdStDakFRREp0?=
 =?utf-8?B?Q01NdkIyVnRqQndVcjg3ZWg4amYrejJKdGlmRVZwU0I5YWV4Y05XOFRxZ1Jy?=
 =?utf-8?B?MEgyUWZ6cXQrc2FwK3Btcnk3eTJHcjZpUEgydXk1elhBN0VCS1FUVkx6QWJL?=
 =?utf-8?B?NVRRQjl4OGpDbUpOSTN1bVV4dldRWG14L2I1ZTkrQVVvVGMxLzI5VVZHOU1w?=
 =?utf-8?B?NDZVckVQbUQ2WGV2WVhQRmF4ZCtUUllMdG82QjNWQ2tuWitWNlY1N1JuYU1T?=
 =?utf-8?B?TEZNTEpyaVEyNlNOd1IwYzRvTEYxOVFGTDN3Tkg5eGY5N04rcC9rUUdNU1Bn?=
 =?utf-8?B?WndmZkRRTnpzTHY3cVcwVzRXbzVWVStGVlhJL2I4eGZxMHJkOTFZTWEwbXZK?=
 =?utf-8?Q?nWOATDJg+Rq+b/Fu6ii7a/Wcd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac6862-1e67-4cd4-4caf-08db22f162eb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 12:00:34.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxBl/DlNBv/k2NnSiR46vLfs9pup+vCC0CVMTBgyevTBzTA+9eogEUOzjVab1mOeybL2L/m3g+hc6qnajAeSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
Cc: virtualization@lists.linux-foundation.org
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 2023-03-12 a.m.1:47, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, Mar 11, 2023 at 05:19:43PM -0500, Feng Liu wrote:
>>
>>
>> On 2023-03-11 p.m.2:06, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Mar 10, 2023 at 08:21:31AM -0500, Feng Liu wrote:
>>>>
>>>>
>>>> On 2023-03-10 a.m.3:06, Michael S. Tsirkin wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
>>>>>> This patch series performs a clean up of the code in virtio_ring and
>>>>>> virtio_pci, modifying it to conform with the Linux kernel coding style
>>>>>> guidance [1]. The modifications ensure the code easy to read and
>>>>>> understand. This small series does few short cleanups in the code.
>>>>>>
>>>>>> Patch-1 Allow non power of 2 sizes for virtqueues
>>>>>> Patch-2 Avoid using inline for small functions.
>>>>>> Patch-3 Use const to annotate read-only pointer params.
>>>>>>
>>>>>> [1]
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv6.2-rc3%2Fprocess%2Fcoding-style.html%23the-inline-disease&data=05%7C01%7Cfeliu%40nvidia.com%7C329325e3773c46e5cadc08db22c5bc87%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638142004918816377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=57roDDMfOEOIuEo%2FqgBgUklMBGHfdSWRI0KTRXQCNgM%3D&reserved=0
>>>>>>
>>>>>> All of the patches have been verified based on the kernel code
>>>>>> commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>>>>>
>>>>> verified how?
>>>>>
>>>> Hi Michael
>>>> 1. Applied the patches on lastest kernel source(44889ba56cbb), compile and
>>>> install the kernel, and use iperf to test traffic
>>>> 2. To validate this change, we tested various virtqueue sizes for packed
>>>> rings, including 128, 256, 512, 100, 200, 500, and 1000, with
>>>> CONFIG_PAGE_POISONING enabled, and test by iperf& ping -f and all tests
>>>> passed successfully.
>>>
>>> Given split ring does not support non power of 2 how exactly
>>> did you configure non power of 2?
>>>
>>
>> Hi, Michael
>> We can implement the test by modifying qemu; 1. force the
>> VIRTIO_F_RING_PACKED feature bit to be set, 2. set
>> VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE and VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE to the
>> value of non power_of_2, 3. remove the check of is_power_of virtqueue, then
>> qemu can create the required virtual device (non power_2 size , packed
>> virtqueue device) ;In this way, any length and packed ring test can be
>> performed;
>> remove the modified code, I can test split vq, and can see that the size of
>> power_of_2 can load the driver normally, and the size of non power_of_2 will
>> give an warning and fail to load the driver
> 
> Sounds like a plan but what exactly did you do previously?
> You indicated you tested non powers of 2.
> 

Hi, Michael
It is not just a plan. Previously, I have already created the 
non_power_of_2 packed virtqueue device and the standard split vq device 
for test, and after startup, I performed related tests using iperf and 
ping -f. This time I will construct a split vq device of non_power_of_2 
virtqueue for more abnormal tests

>>>>
>>>>>> Feng Liu (3):
>>>>>>      virtio_pci_modern: Allow non power of 2 sizes for virtqueues
>>>>>>      virtio_ring: Avoid using inline for small functions
>>>>>>      virtio_ring: Use const to annotate read-only pointer params
>>>>>>
>>>>>>     drivers/virtio/virtio_pci_modern.c |  5 ----
>>>>>>     drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
>>>>>>     include/linux/virtio.h             | 14 ++++-----
>>>>>>     3 files changed, 31 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>
>>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
