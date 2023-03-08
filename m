Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947B4C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 17:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA06D61179;
	Wed,  8 Mar 2023 17:26:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA06D61179
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ae3chfcM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNq7kp2BlGDg; Wed,  8 Mar 2023 17:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6025C610C4;
	Wed,  8 Mar 2023 17:26:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6025C610C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 380E0C0035;
	Wed,  8 Mar 2023 17:26:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A91CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 17:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DC2A81F6E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 17:26:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DC2A81F6E
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ae3chfcM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6khcZqlNUkSb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 17:26:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C72A81F6B
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C72A81F6B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 17:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUaK6L9FHWKwFFFE7W8g/OqyLRejCtR5nDcBNYwCUKFdGVn9wmA8bRl+khJQRDwAR3mUr9WWpCo0a4dJu/Tfb83ugJWEKGjIkgzlrIKG7IdEbVps8TMB/3HUj2FKoORsjb2QxBP6dsP0JfnWBW5V58embEenQOpBlSx4t9e+Aww8OgIPwCFqMOPwzGI/059KXAJ2dyqaoLtgo4DYIpUO/nd6w4difARC1HaXZxDM6NXV2C/NT78csqydSphYv1yeR3let3aWfm+DhUmXNNQUHbaRDdFP3A/G79Jud3eiSdQcTF22AMR4622kaYjibTKUZ/f+WolnhzCTNuSiNVXN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFaHyvDFCP6Kt+vbnv/3TKmQw3jDWxyTScAhwuDeRoQ=;
 b=KHYoB/ZUB8OfwC5xxF+x2Rx2mNk310+0e9yTRt/pMdcy72aIHtsrf0aiE+bYn9XZ1ioe6J/7cjzd/XD6+CQNI3OL/Fhv9b4P/eTrZWxfLapBptiJMrkf+OeheC1ObziA6qiOY0YUCKrSkeZWuc7JG1sBlV6z5jGb/kSNQkh0qOGz6MGuxG22mNSjyvoVHixnCagMw3N5Z+UrJsO4vUm37Iy7xoKzDawMGlJwPiBpeh7fzZE2G0DUK+wtR39AfZYxNnSWzwwtcL0+Pqn+bf6Mr+GDWU8L3u4FK8tngAbIawqeaYKzZ4uY47b7m44iNNQYdirpV7VpeUBGNl9qWd2qDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFaHyvDFCP6Kt+vbnv/3TKmQw3jDWxyTScAhwuDeRoQ=;
 b=ae3chfcMKYk7UYYv+FkfaE0PRe4y2oku3Ycd5ZhlKxzh9EH6ux0aO/5lPBnjXdfQHmdWOC0dglj0el4+nkylI61NTHIt+dLP3yTdAihHVQArgZTOunATx7j7xQZIAl1tRWqnOh61Mnw7wO8XBTUJjwGAf5SHJqMQtS6KXCG3nEFjuQoKbiPPpkujQVXdhlsHN3K0ufE8LjHoBPmUESVjTSS1worB29YdAsIYj/xpaUn1tEIv3PjBKWACemjItehbmcqBX2qzp7+4c2Eyo7RorHDa2KrHsIfbioLQkdx0jwFcH6/Lk2d5VqllFgK0IrQ287XLMnrobbHTnkS0PzO/Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 17:26:40 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 17:26:40 +0000
Message-ID: <2490f89c-1abd-4973-198a-78426f446d69@nvidia.com>
Date: Wed, 8 Mar 2023 12:26:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com> <m2ttywzzxd.fsf@oracle.com>
 <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
 <20230308091321-mutt-send-email-mst@kernel.org>
 <4c031230-c0ac-7809-a85e-09f07c3f7e06@nvidia.com>
 <20230308110235-mutt-send-email-mst@kernel.org>
 <20230308114919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308114919-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DS7PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:5:3af::7) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: c13f6c16-f7ae-4341-5f39-08db1ffa4730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtO5XE6lr7e8wkxDAcdHaxFPKOaFbxDm2+TN9GUQ9GoWMLXszhIxF6jShzd1JRVkLfvwe+5ivjFBLGkLhzETxUTQR328unoek9U366E0o3T3WjLFPbwUHijim12/3deZh+l/H/0Pog070m2yV/349xE+kFbuKD/uf7pGaL9kulU3ntfdW81fJVRfTZynfnbx4bLgZphy94VNe/QznFd+LggS3whPNHcST7PmAWjbqwljvdSx3qeHnCV2h+h6pXsJ7DmBQF5SY7sc37pHsd9gXMkWUpnMiPVtIzSxaTpOvC7T+RbioPZHsogvszW7Dz93ewabpYNF/oz6c52vWIWTMnmvraMC4OueKw8tIUFNYN+pzkv4hAqsnfF8frfZo38w0RoG0ZcMxJOA3qDNsUahTEbaqhEF7aO7XjCip6O5b6xMnQBFLt3YjuYDKOVd5S/YbTVW6EYqE/Yi/oL8x8uQUGDR6JrBsGgp9Teeo+J4SXi8bbmvQOYavcBP9px34zngWrgdYTMSDSWlEtxDxfoaKxQfNxPXve7JJ3+UjQsBPscHqwslCFY/12P6udrEGuiVwXRExRDc/94IxhT4plVdsRAWDzr+LFbbd9XZtSd/mqknjRnAKs3lbPZwtsE+Q2Q/8Bm5pa0I2vsAiK/32if4euiP4XLGHpwBuf4QHYbPLfTjxNFomKR35O4Xjn7Yw+S1JlUb3meFOFHHJWoPmLWhmFJCGeqGMUUXPVFLOswVHa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(84040400005)(451199018)(5660300002)(478600001)(53546011)(6512007)(186003)(26005)(6666004)(83380400001)(2616005)(86362001)(2906002)(6506007)(6486002)(31696002)(36756003)(316002)(66476007)(66556008)(54906003)(4326008)(6916009)(38100700002)(41300700001)(8676002)(31686004)(8936002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJrS25kTXdtY1Rub1hJeDdyWHV1TzdkT2l6bE5DRGNuTnFPd3R6bzJ3RXgx?=
 =?utf-8?B?b3oweGZNNkFaUnNGT1VVczd1Lzc4dGdaVlVmbkdVc2ljeU5tZWdHd0FQdEN3?=
 =?utf-8?B?aWFDOHhKRkJ3RG9Wa01KWm1PVWYyclA3ZEdtSGJ1SE9mNWxEejAzaEVKblRI?=
 =?utf-8?B?YnFaUHkremI2MkNqWWVLdHhyOHg4LzhsZDJnT1JnMU9NWE9NV0tmS0podWdk?=
 =?utf-8?B?S3Z2ZUdIR0QyZzQwVndQQWZsY3lzQmgvWE1sSWFoTE50MzdlT0tIUElJYlNG?=
 =?utf-8?B?cUtrc0I1THFpamF0d0FZajdwNjlqb1dmSDJBcG1kNGhqcmpRNmsyMHFqcHZT?=
 =?utf-8?B?OWEvbFRQUitJc3Q3aHdNWEY1YVp1NXVTZkZUV2M5U1BUdkw2L1hiR2pmZmx1?=
 =?utf-8?B?aCtaQ1R0WUl6SmVFVFlCbVBxcVNHR3BOYTA4RlE1L0pZWGd4RmlaOVkrK2xM?=
 =?utf-8?B?eUp1c0NETUlvdnpsRVdrOThmNmNLOVpCUEl6YW5VanZqUHM0R0tIRUppK1FP?=
 =?utf-8?B?YncwdzkySXNmM0NURmlRUlpsTkRISmpzTk5qTHlSVVZndmtscTJmekY1NUdn?=
 =?utf-8?B?cmphRlBIUlFwVHdHRkI5NDRXMnRJbi9Cem1PQ3lOTktBd3h3T0dyRVJjcTV5?=
 =?utf-8?B?MmsvcHRXRk5LL0xyb2RiNHoxUnpqclptdHE0eE0ycFFDNStaTjhZTkxrZXNu?=
 =?utf-8?B?Z1BVY09tSWUwekVlRDhyenh0M0VJRVJkYW1heE1LT1h1U0FEaGlNeUZGMk9K?=
 =?utf-8?B?Z2w1QVIzWUF5dm92OHU0RXlyaS9JNW9wWTdIdWQ1YmxnTjNha0FXa0xadXNm?=
 =?utf-8?B?ZWxBMjRiMG1GZjZ0U2V0b05ZdGwwWjlzbGxuMXJBWGFxL1hJRkZSazNOMjY2?=
 =?utf-8?B?VmViM2ZRNVgwT1p1MTNRWEpiMjAwSUI5dlFjT08zVEh4cWZ2MmUzUjZGNHF6?=
 =?utf-8?B?SkRzQWorWlFlY3V2MEJJSVRiYUx6RnFJV0VaTFFsTXJXeVFoYUZZR0NEaENw?=
 =?utf-8?B?ejdEdmZIbzJPbU50U1JwRm4wY2hQN3JqN0xIUG5UajhQY3NBVzFObzh5K1Uv?=
 =?utf-8?B?cU9FdnFYK2NHMUZnQ0UzVS9EelkrMDNSMUxCaUlkWFRlWTNkRzJjeVpvT2wy?=
 =?utf-8?B?ZkVZendNRVY4alFRUkc3bmNLazIwQXhjZUlyMnRMelpZMkJkUFRCRGp4S0VB?=
 =?utf-8?B?SGtKcGlUd2E3cng4bVlMeDAyM25BcEw2a0hmZ2txclZEUm1ZZ3haMUs1VmVx?=
 =?utf-8?B?RDdmaTE5cnU0VHJSVFloTDYvQlYzTlJrNURTVkNTUWNHNk1rb1RNNkUzOU05?=
 =?utf-8?B?OGppNHVjRXFrMy9XcFBxREhCQzlBem9UMnhIblg1Z0RnMDgya2U2bXRhRkhG?=
 =?utf-8?B?czlMbVloOFNEVzZIUW54L0J5RzRaMllTTk9Cd29wNFN0TmFEQ09xaTM5WFd5?=
 =?utf-8?B?b0ZnNmhJKy9SNDVGVnBuU0x5TDFEcFhaZFllTzVtZzR4SUZKTnFURzNzNDBj?=
 =?utf-8?B?M1pNN3VOY0wyUUVPZXJnUndFYmhuOGZwc2pJSVYrUzJVS0ZIZm9QVWhxQjRT?=
 =?utf-8?B?WHpuSDhwMVJHS0pRMHUyN0RUQlczalM2WmRBR2dTUU04dlB0R1ozbmZPYWJE?=
 =?utf-8?B?YTJiQU1yYW9ZWmdxNktPZXVSR1JNVGg5aHU2Z3NFVitlM1ZqNW81Zis3T2hn?=
 =?utf-8?B?bmx2aktnQ1VFSHMyWGNvOG12SEZJWW1VbG9vNXlWVzAvWUtVR0xKSVIzWTVC?=
 =?utf-8?B?c0U0N3o4andWZTlxOHlEVEUra0t4MStnOXFVb21CMGNoNTdkTitvanhuOUlE?=
 =?utf-8?B?NUZkeWdGUi9pNTIyNmVUbyt2dG1JNmRHdE50S004dC9pY2lWb21zWDcrejlL?=
 =?utf-8?B?OVFCUkIvNnRNODZzc2ZiQ0w2WWJuUlZaWnlYOXdsenRxZlVDcDBGeUtZWDdm?=
 =?utf-8?B?dlpMMjc5Nk84ZzBTcERhMUd3L3BOdFdjczV1QmorWnlFb0pMWXhndEppUE82?=
 =?utf-8?B?ZGExRXMraE1vcFlnSEJZMHU5b1daZFp3TFJISndrN0VmWnRjb013RkNGdTk4?=
 =?utf-8?B?OVpDMWxoWnBaK25QTnIyYW1ybHRPOGF0Z0kzYkZMZzFUMXM5MFV2Tk1MV3hD?=
 =?utf-8?Q?rQD7pTLuedDXreVT0qQL+OSZt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13f6c16-f7ae-4341-5f39-08db1ffa4730
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 17:26:40.1100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICNQorHXf0CNjuYlKTo8wmQb33082mVupIqWWzSPby6Xr7Z3uY+bBEo4E626pSIeucxq738s2Fe/9jJqXWX0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "feng.liu.kernel@gmail.com" <feng.liu.kernel@gmail.com>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
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



On 2023-03-08 a.m.11:49, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Mar 08, 2023 at 11:26:04AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Mar 08, 2023 at 10:59:57AM -0500, Feng Liu wrote:
>>>
>>>
>>> On 2023-03-08 a.m.9:13, Michael S. Tsirkin wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
>>>>> On 2023-03-07 04:14, David Edmondson wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
>>>>>> writes:
>>>>>>
>>>>>>> Add const to make the read-only pointer parameters clear, similar to
>>>>>>> many existing functions.
>>>>>>
>>>>>> In many of the modified functions the local variable that is a cast of
>>>>>> the argument could also be const. Is there a reason not to do both at
>>>>>> the same time?
>>>>>>
>>>>>
>>>>> Hi,David
>>>>>
>>>>> In order to prevent the content of a pointer parameter from being
>>>>> modified and increase the readability of the function, it is recommended
>>>>> to add the 'const' keyword to the parameter. This is not necessary for
>>>>> local variables and non-pointer parameters, as they are only stored on
>>>>> the stack and do not affect the original value or structure member
>>>>> passed into the function. Therefore, in this case, the 'const' keyword
>>>>> is only added to pointer parameters.
>>>>
>>>> This makes no sense to me. If ytou cast away the const then it is
>>>> pointless.
>>>>
>>>
>>> Hi, Michael
>>>
>>> I really don't quite understand your point of view.
>>> Is a local variable that needs to be add const? Can you help to point
>>> out the specific problem/point ?
>>
>> I just repeated what David said.  Basically most of these functions use
>> to_vvq which uses container_of which in turn loses const qualifier.
>> So your change is poinless since rest of code accesses vq through
>> to_vvq.
>>
>> What to do? I don't like the idea of to_vvq_const.
>> So I propose a version of container_of using _Generic
>> which preserves the const qualifier.
>>
>>
>> #define container_of(ptr, type, member) \
>>      ({ \
>>          const void *__mptr = (ptr); \
>>          static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>>                        __same_type(*(ptr), void),                        \
>>                        "pointer type mismatch in container_of()");       \
>>          _Generic((ptr), \
>>                   typeof(&((const type *)0)->member): \
>>                   (const type *)(__mptr - offsetof(type, member)), \
>>                   default: \
>>                   (type *)(__mptr - offsetof(type, member))); \
>>      })
>>
>>
>> I'll hack it up in a day or two and post.
>>
> 
> Oh wait a second. There's already container_of_const.
> So just use it in to_vvq.
> 

Hi,Michael
    COOL! Sounds good! Will do that


> 
> --
> MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
