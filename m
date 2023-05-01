Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0FC77B61
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 16:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C223613DA;
	Mon,  1 May 2023 16:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C223613DA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tKMWbIwf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Il5u0BcxRUcd; Mon,  1 May 2023 16:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81063613D8;
	Mon,  1 May 2023 16:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81063613D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1B9C0037;
	Mon,  1 May 2023 16:53:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C21C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 16:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A2B240224
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 16:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A2B240224
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=tKMWbIwf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eUpoL3aZlmv1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 16:53:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5766840200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5766840200
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 16:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWM8EklwVFBmmodN4Hx8Hp0kYKaMwv09nHgd5mCR5A2msGyPTWHo2yjFia5NT3jAz+rNiJ7/P584Pua3Kb47Uno07O9TY3YbV+l+0qhUmeHHPc2q+jjynkOvxKmieykpU9Ma8OTMHJhgcC/7wZvoo3+6gKbDgO4tUxjev5XYMl9Ds9tth4v5E6DfVIjrdU/rCWjrAfmDD3JcMXC8kloqrdkb8qJ8m5R6V1chPz1/gMx3Bd9OR4Rfh69o3tovosfNqUEHplXObEIl1KopElu5UC04xDrl+p2EJRe8Jw1wuuC5Pg1+cwlmUMIWcOgJmIr2Qa/xpu30ZUH5CrebJpaMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck/2UnB3753Yo8oJWeC3dA5/WzD23VIgbs5udTQOTGk=;
 b=a/vdYVr8e75MB+i7/I/NDDP1LBUjZLY1DngBKY9DsKQpVU8z4W4FUhYfI9nDo56iPUFzU2/Ic8su2GcrO6Y+ZjPzVYOT6H6Pop8QccET9KJHY3EFopw5EWwgugWbwlKhcuWDB4NINxFU48ISyG0GzIcx11OORO/JWO3fK4m+Me2qx7kf0jxA7QqV538KQqtLQ52ExoKlE5v/WXbHOrA0uwHsjHfZ+sKydA2N2fSy2nZqQ8/oPLUh4I1hX3Nei7jM9ADfTJFfrfwuqZptKmGx69gj//C9dj+MxJXc9gv7BJD0zkn9iZtq/4/m74AbQRohP6jSdkC13MxCVGoEAbhmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck/2UnB3753Yo8oJWeC3dA5/WzD23VIgbs5udTQOTGk=;
 b=tKMWbIwfkuHrvw6RBhMGxRJfOBam7MQPXD6pVS4M34rWbDxQCiZcFaVW67VJni9qL88EBv1zG8931fB4rdgBtxCletxg1VnVUHjMEgtU+fHE7hzYe/0sxiS33XiEwDiiuOmmYEcJJCY8Pq3uQ/8Ve77edswcFDdOO1C4nqb+Vmyq4udfCzxEhBJQD5olUsOEY/z7nB8rrZEIFnDoWgY9RJ8S+Kw5WeE2UBCYKPfV9Z/kSVRNW0aQBFnViTtRqOkgbYOT0jdQe7uhXAet3/aZSEY39rexClsPUuiHHuy6w4Ph3v0FLcA0GdbEOgLLfkrzjcvHm8nR2KsHHlAAZo8TRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Mon, 1 May
 2023 16:53:12 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%8]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:53:12 +0000
Message-ID: <7f50c3e4-f377-3adf-e4ba-35c323d0a50e@nvidia.com>
Date: Mon, 1 May 2023 12:53:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v1 2/2] virtio_net: Close queue pairs using helper
 function
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230428224346.68211-1-feliu@nvidia.com>
 <ZE+0RsBYDTgnauOX@corigine.com>
 <9dba94bb-3e40-6809-3f5a-cbb0ae19c5b7@nvidia.com>
 <20230501101231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230501101231-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN7P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::22) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: f06db849-88dc-4b83-c51d-08db4a648caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxqWHjzFRlq+JzoEdHq0VADbT8oWvxiiAy43PpR960aOT0P16liPpAVQ2RclPexhtAYNVDKduvRKvDFSwLqvfD/59WoS2eWT/3kziEpK8EbcW3PWD8PEd7kHfu7GfMG0RxqoWPY3eqzO7uTRMGxHd0cG9M8Z3YE7WkDC122XUvyuOaUsqbRL4gvKoFXGvRsHp66UJU3O7ohEfhHvll+MphFv8V743HFoCkIaPcp4ygokGH3ZtcgSSF1j+HKj4xTihKAVYDLoijbPz7ENsIGsqh614/MLvZrQl5sqDcS4rYJ4vZcJPsmvFnzUqOWzWz3gyc+qpPxW8nuFq2X9I42tguUeobpA837YB16Gtga8CK/Vb2ffgBagYn7QitjXZxYRtY9A+eQxafSIQh0TPN8vfLywJD/e6PeqX+TyhFqpxGaK9n97oCK2EA9SmPE9XKuVAY6aj5VpJZiHQGKQFDdQOiCRfvR0fs8OPgHuN1LXx7WSnKvpD68nGHsfk4KWJDat/qNW2bi1UhaMlVX0JRs3gcrzAs2l5N2BNc6o3leg1GsxqbOpvsUrBbkn+s/wE1BUiyYcHTcLpo6B4r/fN69qgMph6lTa0Iw53jMzio3PHP+LKmEGxCW0lX9J62KFdrFg3TAbk+4QuOcu5uYh0cz6Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(6666004)(107886003)(6512007)(38100700002)(26005)(6486002)(6506007)(2616005)(186003)(36756003)(8936002)(2906002)(66946007)(66476007)(8676002)(66556008)(478600001)(86362001)(31696002)(5660300002)(54906003)(6916009)(316002)(41300700001)(31686004)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWg4T1dMZ0VmQ3FXUjN2U3Roc0tjaXRkS3hYY3B6eEpya3R1Z25lRDd5K2Np?=
 =?utf-8?B?a3NNcWs0TFE0VEdpMHVINnNVMnJMWmNxTERYaFlpZDZJcVRYY2hmYnI0STVh?=
 =?utf-8?B?dDJLQjRQUW5TelM0OEIvYVF2eTRlbllndmo3eHlWNFozRGdmcE1FYy9lQ21Z?=
 =?utf-8?B?dnZCRkNFRmpqV3FPQjM4eTZBSnArMElpbFlaMjM2NFMzRW43VXl4Tjk0aWRS?=
 =?utf-8?B?VnBKVUxxaHZVREF2ZjlxdlNpNEZjTnVscFpNanc3OXRCcGpVbitmaW1kZGFG?=
 =?utf-8?B?MHJFSS8rMElJWTNCNjFtb2Nzd0VyaVQweHlLOExIOGxlSzJyZEo5V2N1eWJi?=
 =?utf-8?B?enFVL2FHanlFYVQ3Yk5uaTZuUjllU21qT0NJUFpyeGVnZWtFVGRhVlU4Wlo2?=
 =?utf-8?B?MFplR0RLZ0JXZ05IdkxFaXF1OVZidHhCTnNtTnVkaEpmdndLbXltWlRiM29Y?=
 =?utf-8?B?VDBrSHQvaHFwVW5YdGt1WGIrUVhYV1cyQno0WEdoYmNQL0pCNHg1eGppd294?=
 =?utf-8?B?R3pnVUw2ZmtKVis4OFRGVTN1L1BvV3VhbHRVeVhMYnMwNUw1RitMODhTNGZI?=
 =?utf-8?B?TU1NbUNUcHFtRHZ2K21kLzhDaGNiRFo5ZEd4Tk5vSS8raEFXaDJ1TUp3VytN?=
 =?utf-8?B?aVRJTFlIRTd0ajlZWHRDcFBDTkp3Z0tkYmFhTCs2REtXaDJraGNMbU5DK0Zr?=
 =?utf-8?B?d2NpdXg4N0lEdWtFZ1RtdzNMZGlUZGlPMVJ6NHBDc0VvRytMcU4wSytBUUYy?=
 =?utf-8?B?WERvSEluMjROUXBVSzA1YnA0aUpsdFowb2JHUnYrNTVhcWpXR00xUUxmK0x0?=
 =?utf-8?B?WTRyVFQ0U09LUlJPbndkaWpvK0h3UGh2ajY2SWc4TXFwWFJQOVU4YmRRMm5y?=
 =?utf-8?B?YUhKemJtK05ldzZHWGFDbWxza2hhMDlhMk96OG9aQzVtTkIxS0xITzNMbmtT?=
 =?utf-8?B?c3dJalNOZUFJWmZ4RWxXVlZBNGsrb3RHTzIwcG1HL1JFd2pnTVlwVjlydnRk?=
 =?utf-8?B?RUlHUS9IUEdqTWJSaUpUQm1kcSthQldmeEM4clhScUtCelNrU29OelFOWWNq?=
 =?utf-8?B?cXJZM2Nwa1N5cHlWNXd2TGxXa2R3NlppQ0liQ0ZoblBveXZDc2VVY2VwRTdQ?=
 =?utf-8?B?ZnRyaCtLT2dDNk5QaUszUm5ITytoSTlXV0hTNlNxUDk3Vi9uT1NGMC9CbVFk?=
 =?utf-8?B?UFk1VHFjYmp3UVdGUndxdHNaQ3BWUmNxVk15cmJBZmtKK05ycW1vdk9SdXhU?=
 =?utf-8?B?UEF3dkIzTmh5alpic1Z2VEg3YWllYzdCWG9wODRwRHRudXk5N2JXQ09aN29a?=
 =?utf-8?B?YTVmT05tRk04ZlpRVjN5dnpEOGhqL2tqVDB2b045Q3lTLzVta1hUWmhKVnJ4?=
 =?utf-8?B?Q2srRlp4UGtET05CVmw2T2JxZE1pbG5UWnovazhWSEVkTG91b2Nsb2Q5b2RI?=
 =?utf-8?B?emVCeFBSdHBjTkUrNUZjdkRXWUtCK1ZEZUdTRng0RzI1MWVTNThaTXRjWGJF?=
 =?utf-8?B?YlZEMjMzbkt4Y21zc3VudGtwZDdBeDNxeHBtVXdWSXUxNjM5SW9Zd21lWEFB?=
 =?utf-8?B?NkpRVnEzSGxqRUlpbm5ocXFLTG9DTkFxYStrTzJpNXdIbHkyR0p0bE1WaUUw?=
 =?utf-8?B?bDFObmlyL1JjaGp4dWZPeW5aS2NCU09kQUdTMko1M2dQK1RyOTNxVDkyUDU3?=
 =?utf-8?B?ZEY3NzUxNkl4QU9nM1NOd2ZmSmRUcVU4Mnl3amxQZjJDcWtBL1htajA1aEZr?=
 =?utf-8?B?ajEzQUpTM0h2Qld1d3RWRVp6VFdCbitjQzVWem1maDBFTHpONGdsQkw2SEh6?=
 =?utf-8?B?QXVsY0c2d0ZBQXU3Y1JSZzFMRmxQR1kxNWhBemJpcjhCN1dtSVJ6SWRRWS9D?=
 =?utf-8?B?cnpqL3g5Q0tzNUhMNStGU2dubVplT0ZsSCtIeU40dDE2K2tFbHNtR0tJSjMv?=
 =?utf-8?B?V0FleUFTYTRTbEt4ekI5VERkV1IxbEYxM3lGK2hpeStvNFhTTUJEMkJHZ1Bk?=
 =?utf-8?B?UURheWtqWFdyaDRzQWFUeWkxRGtSbzVNYW4ybWNJY2w1RVF0QnVKS0VqWTVw?=
 =?utf-8?B?MENrK05UZWh0aTNqcjl0WFpxTG15QThZWEwwUEp6MHQwU3NLL1BRZzV5Yk5T?=
 =?utf-8?Q?20G57lA44jFL2/zZn7Evxh7wf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06db849-88dc-4b83-c51d-08db4a648caa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 16:53:12.2580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo+366i21Vpc5ZO8rptJvpsRVsrWBi8bsBi8DErNai7DL7KGZy6GN+iigJoPal6DYGbBTNmQgei5ToISZpncIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 William Tu <witu@nvidia.com>, bpf@vger.kernel.org
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



On 2023-05-01 a.m.10:14, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, May 01, 2023 at 09:58:18AM -0400, Feng Liu wrote:
>>
>>
>> On 2023-05-01 a.m.8:44, Simon Horman wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Apr 28, 2023 at 06:43:46PM -0400, Feng Liu wrote:
>>>> Use newly introduced helper function that exactly does the same of
>>>> closing the queue pairs.
>>>>
>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>> Reviewed-by: William Tu <witu@nvidia.com>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>
>>> I guess this was put in a separate patch to 1/2, as it's more
>>> net-next material, as opposed to 1/2 which seems to be net material.
>>> FWIIW, I'd lean to putting 1/2 in net. And holding this one for net-next.
>>>
>>> That aside, this looks good to me.
>>>
>>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>
>> Will do, thanks Simon
> 
> Nah, I think you should just squash these two patches together.
> It's early in the merge window.
> 
> --
> MST
> 
OK, will do , thx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
