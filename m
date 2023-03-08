Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCC9C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 16:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF7F5417DA;
	Wed,  8 Mar 2023 16:44:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF7F5417DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ndyl+mGY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7EV0q4bxrb05; Wed,  8 Mar 2023 16:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8776D417D3;
	Wed,  8 Mar 2023 16:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8776D417D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60CDDC0071;
	Wed,  8 Mar 2023 16:44:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3C8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFC23417D5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFC23417D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQ64e3LI-OdO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:44:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 017FE417D3
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 017FE417D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFTll+nGLTEnLDcGmLl3lXX8n84xGeiotIG7xMsZXLThJ1OMgsSLMcSU73Nk7TeeB/3oRfQYMdo5TsNfCF45o0cDYDQ4EYv/b4dPczUZybJT05sMc6afSSU7memRjmpU2vTC8VklrWDwD8rcJTiztOwvPz0YgoJx/yfKWKItt/9IVsFHMM/ICdrp4fHPsySijfLAeMaRfg9TnWE0UHXhrujninbxG8oJsH8CQoHwKUQ5cI3t4cH8FF5aNdl3WJ/ApaI98kmgi5n5IocjEVfmZ89lFH6j+hcT2qvMWNgM9EhqM+DBdgVcyhAKiZPKPxdX8vK9yPx+6HcNs53n+zRRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkWsg6yKN/07w4WyrDIO4iH+lJvZvyLaA3xzdFoN/xc=;
 b=fwDHw/M4IWLQhfZcJtUq7xsPxzgQu3Q1h/0/IJL9DHWv1YT97got9dsW9UvvAwh7JXBsLzZjrB+hkCw4TJWozV5u6b1Jlm7l5IiZM85q7iqGqlJMRHr+I3NhqxeMIRftC3GlLg2xr7idJ5dwzmgOGOPMG9v8CXqq1FelDBGJUfr+Y4/pJvMXHST23wEw59Ho+JY8It1oK6XIpLNa7+2YkA78CQQQ4+wox4e3pcAq48ImSsjWQcRmPgeMvXrV4mmGj2dwBHhtfchLjmFd0oJT4hxNUUw6uXm5GI0dP1xDwnoCyE3AqEnhqKMxcttIACRUiNBuy9PXdI5eZP36SCBEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkWsg6yKN/07w4WyrDIO4iH+lJvZvyLaA3xzdFoN/xc=;
 b=Ndyl+mGYzRDyc4ONGQE9DUndzR+4IX5byRUeZi/bhBkhaEcBTOyGyegy1YXj6nqDXnvDsCylNyres7ZoaSHbAfGK8vxwWpNNfXJEKm6AGXl7kV3CwfteedkH5UfIZGvM1UHiw+eYodNv2R+XMDhAAxoGPBuw+jVHNjdkoHFuRnNu7K2+XU/pn56X1zCr6J4Qu+HNeAXKGK9YOnUb51aV8UiaNns1pVaNiU/aaOGjTbgoiP+I3ZZh22uB8oKzlMAucfKxk0hQsaM0JEQaWSwXQmj1iG1cFB5K4G8/Cy9+UY/U9bAulCQ9cEPDx9DAyLLeDiC70OU9El0ayWq/0UrncA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 16:44:40 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 16:44:40 +0000
Message-ID: <1eb860d6-daeb-c2a7-e9dd-9d1c279afb50@nvidia.com>
Date: Wed, 8 Mar 2023 11:44:35 -0500
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
In-Reply-To: <20230308110235-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc0b3af-082f-4879-bb9d-08db1ff46929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HebQTnHjaS8d7Md6N+eGwA9+pt0IhhAFr0aBEK3HS6Di5fSMKxg+JWR94YZu5H3ITtJegao2SXibm8o1ctUEZJwQ8vbAK/7jetwuxueeP0+NJpsmCpljgqeMMwMB4XSJqvdy7pWcTqS0y5dbapckz0nt2BfM+fguAQ94Qug2ht/Iqv1skuI0ekHe6Jdg+TXbHv4GGfseDYH9svFoTspTnOxtAkc56tDmvg8+C6KpWekl3XJmjmAxNJfe/YAdd6GHXq4UG30VJhBrugNYfAoF625BPf6WvbllXOfFiCHaZB9nNoYalbD+RTGzuq6XLlz9bWVfgAoUS9WUzSPQtGgFwNgzqCpKtDlAvF/nn5wbdLrqgXOeoAy+aPxs+kWucfukzZxNXYIbvb/VGKOfw8XcbFZHGCvir6zHErGzMIXLTg5f3VX7y21SRhoOxOxu/VXeZyX9l7zbBa8fxkHF+LFVkXep3sh4+lpmgXGlSEUvwzIslWlDK7E7SZRAfcGq4v2NOFDWCrHpiY6yJumFmeAl1ErY8nle+7dSbiI6Z2QIKEObqrqjGhWMgvZ/s80CORxy/n2oKYoBnNGdGkVg9BxPGdxtJNUv8gSkpM5OPhAwsYkpuB+svTeGCcm40hfex4RDra3YY0Z1knnY0NBRNf5hFTFcrix8F3bqu8W78BfNDrZNyHEoGzvljH1b5jgB5yoGbhq8S3C4EGt8a/dAwAUtPTyjC8KAbOy0U31NUCDTM4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(84040400005)(451199018)(2906002)(186003)(5660300002)(38100700002)(4326008)(6666004)(6916009)(8676002)(66946007)(41300700001)(66476007)(45080400002)(8936002)(26005)(6512007)(478600001)(2616005)(53546011)(66556008)(36756003)(316002)(54906003)(86362001)(83380400001)(31696002)(966005)(6486002)(31686004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FCODBMWmQrbUl1aDJwY3h1OXlwZGxBQ0djRE95Y0ZUajNnYk5GbnBUQ3FZ?=
 =?utf-8?B?OEVCQWJFWkFXL0dvc3crT2lScTFtTk5yZlV4eGNib3FxVVhNbFdhcWI1OExo?=
 =?utf-8?B?WHNoNkQzZnd6bGljb0JNY1IyZ21zOFJ0WlJSZWxnM0UwWjZaWkpVMEVtMGJN?=
 =?utf-8?B?eWdoeUp6dFlxWFQwcmQ4UVVQOHNSRHNsSXBwNkwvS1dWMlVNU0d6WWFvL2ZV?=
 =?utf-8?B?Ry9EcXFMUzFkSjNHb2VZRG9tQXExMGhrVkpEWjNtNlErUU51bG1ERDNLN2Ux?=
 =?utf-8?B?aVJyQ0xkeFVSQXhIcENuSUtlbWpneiszTW50U20zUkVLRnpELzBtVTB2UEtX?=
 =?utf-8?B?THk1OEVIYXR4NzVOZm5qbjZNU1d6OTBiOStZU1g5V2w2bHRCV1Q3cGdsZllm?=
 =?utf-8?B?dnQ1clFJcTA1WEE2Tmp5Z2tZOWd0d2FoNzlsQjh1d0NWSVV2aDhUcllpOVNr?=
 =?utf-8?B?eWs0WlBmUXBPcDFvQm56QzlxUWJGTk5rSzJobDEzamZDa3k1K1FuNFUyMzk2?=
 =?utf-8?B?U1Z2dUtDem5KdHVBRUcwcXR2K2QzRC9lK1owWXRPK1VzY3BQK0lCNy8vR2FT?=
 =?utf-8?B?WjhhNTJIL29kNUJidUZJcXZqWmVkU0NpYjFZSDlVckV6NEE5NCtkeWp4K2Zl?=
 =?utf-8?B?L3RzTUVaNjYzQXo4dk9VeE5UejlMMmRFNGRHbXJSeE5JOFhhdkUrb2d1eSs5?=
 =?utf-8?B?ODZhUTh4b0xRTlVaYW92NGk0Ti9tSHI3K3lOdGhiWjNiVHZsKythVC9STzFN?=
 =?utf-8?B?THJRUlBkNFNScmdhWFFWclVwMGRzeGxBam9YUFo2dlRUeGszeEc2cmdNQWZi?=
 =?utf-8?B?TmhoaFpYMDIzSmxXNDJ4b0NlbWRXeUlZbXQ5K1RJcXVPazNYWXVpNHU1aE43?=
 =?utf-8?B?M3g4T0lvY3JPcGpYWFE4cEYwOVg1WGdaUWVoNURKNUdleW42aXBGWE1WSktq?=
 =?utf-8?B?aVJ2M3hXL1hWL29hL1dkaXhiN3kzZEhLZ2tvY0VlS0xHS3JFaktoNTZYOEJK?=
 =?utf-8?B?UDBRVzFCbENIK05ZdWg4am9UaHorN1UvTlJqNXg2Vjg3bXc4eDJBOEE0NmVk?=
 =?utf-8?B?T3hRSjhpczU1czhUNldMczFIMTkzaW1jOVJFWU9WV09DS2NRNXExaXNLdWhB?=
 =?utf-8?B?R29NNCthMi9uUUpMeEV0aVBHOVAybElRd1NRSzFNU3YyQzFYSzg1UnRBM0Z4?=
 =?utf-8?B?c25oVG5nbDVqL29IUHVtZzQ5WWd6VzRKL0RjS0NRbnZEWlM2TWJxT3NrUU55?=
 =?utf-8?B?akJ2djBWV3lVeE5tVDFncXg1TGJBTmd5TzNoWGNLZ3FSNlRNdWtsY3hBMlVJ?=
 =?utf-8?B?Z0daZ1VYOEhsMXpMM2srLzBRQnZVWHJiMU1ram1WMGt3TmtCazRKblFlM0JX?=
 =?utf-8?B?RHN6bXNtYjluS2VxUG1aOGJaSUNVYXpzNGIrOFhPOG9kclZ0STNGOXB0dmlD?=
 =?utf-8?B?RmkwU3lQZ1EySGRDdWJ3dldjNk9ENUpzOXdtNFMzN1RHTjRVeDdEVW4wRm5k?=
 =?utf-8?B?U3ROY3BRVkwrMEFYTGhMMVJzN0h2OGNwN1IwenFsclk5KzJFT1FpWlIrZmti?=
 =?utf-8?B?NGlMTGUrMzNRRWZBTmxBWnp3MGlnOUpVdjlldFFmRkdBMjJ6cTBtVDN3REl4?=
 =?utf-8?B?eUpMaUdxQlIrOGJ5azlyM3R3OUhuQ0lXbmk0aWx5TXZCS0lJckJkc09aZ0xM?=
 =?utf-8?B?NVNXTUFXYVpTZ2hKUEZhcnpEQUJwUk1ROHEvUzg1T1p4Q0VDNi8yYkhiaVJR?=
 =?utf-8?B?WEcxOE80UXZ5MFJocno5VFgxNW80S3orbjNDcjRCUEFBbUtpMHMzaVFmQWdu?=
 =?utf-8?B?T0hMc3R1RWdRckxObXd6aU13bGRTWHFocnVHWVFPejFIK0V1Mjg2b3RvWHc5?=
 =?utf-8?B?TlVlckVJVjFuaWM3RUZFTm1RQWpmdFV4OHhUQU83UWd1ZEZyNjFmR1YrcHZD?=
 =?utf-8?B?c2t0dTdrQy9LMEoyQzFLMGJodmNZSTNXTzB0eTJPN2ZteEg0YmxXZFRCQ3hD?=
 =?utf-8?B?UnFzUnZZUXZHempwVmpWWnpzWDloTE13SGQrcnlYdjYyenBoN0t3cWxaOWpH?=
 =?utf-8?B?R3pvNFBPQ2t4QkhIVnNBTWtxbzFVeXppZzNZN3NhTmJ1YkxJOG5Jd1pnQ1VJ?=
 =?utf-8?Q?aI7790o6Ufl/lddNa4BgqqivB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0b3af-082f-4879-bb9d-08db1ff46929
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:44:40.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mn4u+TanSxMxk7hBU53pc11G37DlFkTEmWuBWln+AiKQGe4ceernuNlNw+fJBJ7tK/gFqBM6yK04/LNn8+Cog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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



On 2023-03-08 a.m.11:25, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Mar 08, 2023 at 10:59:57AM -0500, Feng Liu wrote:
>>
>>
>> On 2023-03-08 a.m.9:13, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
>>>> On 2023-03-07 04:14, David Edmondson wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
>>>>> writes:
>>>>>
>>>>>> Add const to make the read-only pointer parameters clear, similar to
>>>>>> many existing functions.
>>>>>
>>>>> In many of the modified functions the local variable that is a cast of
>>>>> the argument could also be const. Is there a reason not to do both at
>>>>> the same time?
>>>>>
>>>>
>>>> Hi,David
>>>>
>>>> In order to prevent the content of a pointer parameter from being
>>>> modified and increase the readability of the function, it is recommended
>>>> to add the 'const' keyword to the parameter. This is not necessary for
>>>> local variables and non-pointer parameters, as they are only stored on
>>>> the stack and do not affect the original value or structure member
>>>> passed into the function. Therefore, in this case, the 'const' keyword
>>>> is only added to pointer parameters.
>>>
>>> This makes no sense to me. If ytou cast away the const then it is
>>> pointless.
>>>
>>
>> Hi, Michael
>>
>> I really don't quite understand your point of view.
>> Is a local variable that needs to be add const? Can you help to point
>> out the specific problem/point ?
> 
> I just repeated what David said.  Basically most of these functions use
> to_vvq which uses container_of which in turn loses const qualifier.
> So your change is poinless since rest of code accesses vq through
> to_vvq.
> 
> What to do? I don't like the idea of to_vvq_const.
> So I propose a version of container_of using _Generic
> which preserves the const qualifier.
> 
> 
> #define container_of(ptr, type, member) \
>      ({ \
>          const void *__mptr = (ptr); \
>          static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>                        __same_type(*(ptr), void),                        \
>                        "pointer type mismatch in container_of()");       \
>          _Generic((ptr), \
>                   typeof(&((const type *)0)->member): \
>                   (const type *)(__mptr - offsetof(type, member)), \
>                   default: \
>                   (type *)(__mptr - offsetof(type, member))); \
>      })
> 
> 
> I'll hack it up in a day or two and post.
> 
> 
Hi, Michael
Ok, I see. Thanks for your explaination. I will push the next version of 
this patch after you post

> 
> 
>>>>
>>>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>>> Reviewed-by: Gavin Li <gavinl@nvidia.com>
>>>>>> Reviewed-by: Bodong Wang <bodong@nvidia.com>
>>>>>> ---
>>>>>>     drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
>>>>>>     include/linux/virtio.h       | 12 ++++++------
>>>>>>     2 files changed, 18 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>> index 806cc44eae64..8010fd1d2047 100644
>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
>>>>>>
>>>>>>     #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>>>>>>
>>>>>> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>>>>> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>>>>>>                                            unsigned int total_sg)
>>>>>>     {
>>>>>>          /*
>>>>>> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>>>>>      * unconditionally on data path.
>>>>>>      */
>>>>>>
>>>>>> -static bool vring_use_dma_api(struct virtio_device *vdev)
>>>>>> +static bool vring_use_dma_api(const struct virtio_device *vdev)
>>>>>>     {
>>>>>>          if (!virtio_has_dma_quirk(vdev))
>>>>>>                  return true;
>>>>>> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>>>>>          return false;
>>>>>>     }
>>>>>>
>>>>>> -size_t virtio_max_dma_size(struct virtio_device *vdev)
>>>>>> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
>>>>>>     {
>>>>>>          size_t max_segment_size = SIZE_MAX;
>>>>>>
>>>>>> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>>>>>>      */
>>>>>>
>>>>>>     static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>>>>>> -                                        struct vring_desc *desc)
>>>>>> +                                        const struct vring_desc *desc)
>>>>>>     {
>>>>>>          u16 flags;
>>>>>>
>>>>>> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
>>>>>>     }
>>>>>>
>>>>>>     static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>>>>>> -                                  struct vring_desc_extra *extra)
>>>>>> +                                  const struct vring_desc_extra *extra)
>>>>>>     {
>>>>>>          u16 flags;
>>>>>>
>>>>>> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>>>>>>     }
>>>>>>
>>>>>>     static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>>>>>> -                                struct vring_packed_desc *desc)
>>>>>> +                                 const struct vring_packed_desc *desc)
>>>>>>     {
>>>>>>          u16 flags;
>>>>>>
>>>>>> @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
>>>>>>      * Returns the size of the vring.  This is mainly used for boasting to
>>>>>>      * userspace.  Unlike other operations, this need not be serialized.
>>>>>>      */
>>>>>> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>>>>>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>>>>>>     {
>>>>>>
>>>>>>          struct vring_virtqueue *vq = to_vvq(_vq);
>>>>>> @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>>>>>>
>>>>>> -bool virtqueue_is_broken(struct virtqueue *_vq)
>>>>>> +bool virtqueue_is_broken(const struct virtqueue *_vq)
>>>>>>     {
>>>>>>          struct vring_virtqueue *vq = to_vvq(_vq);
>>>>>>
>>>>>> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>>>>>>
>>>>>> -/*
>>>>>> - * This should prevent the device from being used, allowing drivers to
>>>>>> +/ This should prevent the device from being used, allowing drivers to
>>>>>>      * recover.  You may need to grab appropriate locks to flush.
>>>>>>      */
>>>>>>     void virtio_break_device(struct virtio_device *dev)
>>>>>> @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>>>>>>
>>>>>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>>>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>>>>>>     {
>>>>>>          struct vring_virtqueue *vq = to_vvq(_vq);
>>>>>>
>>>>>> @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>>>>>>
>>>>>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>>>>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>>>>>>     {
>>>>>>          struct vring_virtqueue *vq = to_vvq(_vq);
>>>>>>
>>>>>> @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>>>>>     EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>>>>>>
>>>>>>     /* Only available for split ring */
>>>>>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>>>>>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>>>>>>     {
>>>>>>          return &to_vvq(vq)->split.vring;
>>>>>>     }
>>>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>>>> index 2b472514c49b..36a79374e735 100644
>>>>>> --- a/include/linux/virtio.h
>>>>>> +++ b/include/linux/virtio.h
>>>>>> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>>>>>>
>>>>>>     void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>>>>>>
>>>>>> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>>>>>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>>>>>>
>>>>>> -bool virtqueue_is_broken(struct virtqueue *vq);
>>>>>> +bool virtqueue_is_broken(const struct virtqueue *vq);
>>>>>>
>>>>>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
>>>>>> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>>>>>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>>>>>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>>>>>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
>>>>>> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
>>>>>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
>>>>>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>>>>>>
>>>>>>     int virtqueue_resize(struct virtqueue *vq, u32 num,
>>>>>>                       void (*recycle)(struct virtqueue *vq, void *buf));
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>> _______________________________________________
>>>>>> Virtualization mailing list
>>>>>> Virtualization@lists.linux-foundation.org
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fvirtualization&data=05%7C01%7Cfeliu%40nvidia.com%7C7dc87cb48ac44bead13808db1ff1d29a%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638138895717817297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=ZT5o%2Fs2TWQT6yP7tUUDnV4ojKgKtUmEzSVpnDTs5PtU%3D&reserved=0
>>>>> --
>>>>> Woke up in my clothes again this morning, don't know exactly where I am.
>>>>
>>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
