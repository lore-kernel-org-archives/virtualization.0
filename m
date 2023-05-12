Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B02CC77B7F
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 23:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C9D342D99;
	Fri, 12 May 2023 23:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C9D342D99
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ImmhU4T3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A63mG0DpQ6a0; Fri, 12 May 2023 23:55:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79F5942D9A;
	Fri, 12 May 2023 23:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79F5942D9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA93C0036;
	Fri, 12 May 2023 23:55:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51F7C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 23:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77ABC6077D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 23:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77ABC6077D
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ImmhU4T3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiq9v9-9E5z5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 23:55:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA4416076C
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA4416076C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 23:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQhzP+49uUXmlzmmjKuq+ztAqbXQetfIdekuI2IBLNnBjlmvH14FiX9B4Fu4fCapUcl4soWx0fGjyBAQiVc/VVG4Tj317fwNGjZLnbSxGQ7jsRlrIOXfdRxYOY0qiZ2UaBmnWSOnDKPQUB4FFhker7nvcrz3L0KnMZKcdtR2T3/8LDEQE9LAfNQjj4ty9MJ7F1KWFTd5n935fxcXuIOy4bqhUnak/zxqx/KrB2S4/yUId1LgNQxnjOCZZkyL+ZDP2ppgMeE67D+epUB8gu8zwXMOndKPt745FBS+P71gXprmsE4VACE8DY7vC4PtkLRwUAAT3urxxarItoyjqakPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g31LwZHrV3Moff8yqZlGRoJxRISiCp1lSNxSnSO1dTo=;
 b=Z+3MvfD+c7gYPQz0ABCVVRukIFvvppUaluNSu7awJptfGjfib1x019MBV2aLS1lvuxZxmutBUkVyZT80SSgE2i9lChhSTWTsY6ax5N6x77g5+G1/B5Q9jIpqgSCxKV7PRaV0j+01x+M1HPontIzAGcuTFHbquYrF2CVLD/EYdET+Q0imwb8VqF+SER4VbXO5w7ytiw/GihdkgDAup1BZiLjru4WBOpTT4GMT6Q+IMogsyjRQhbW1IZayzVxedfnEWiQ1tnZSkN8G3JOYA9kPtGb/cE4KK4HoxqKLsR81sSDkMTRSn99PkbMcTQbTcVIalclwsu4du9G7IBBPe2tiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g31LwZHrV3Moff8yqZlGRoJxRISiCp1lSNxSnSO1dTo=;
 b=ImmhU4T36lzx/qp0Hw27/yojG3ArsIFr+ypnvpjfXy4MW8dh6A9adSxB/i+/5lczVOlyXG40vWtDP2N9i3TQNd1phhukieQZqF8fwRPgLJDVe8ByWDXBQArIzsfn4I4NeHH8OB83SmqebkOdqVAeJazML3oOjDD2NAyvUx/MW0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18; Fri, 12 May 2023 23:55:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 23:55:40 +0000
Message-ID: <c450ffd5-39c2-2fe1-de3f-7db45f01f7a4@amd.com>
Date: Fri, 12 May 2023 16:55:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Content-Language: en-US
To: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <20230504145110-mutt-send-email-mst@kernel.org>
 <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
 <20230512093000-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230512093000-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e2ad24-8082-4965-176a-08db53446411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sDY9Z6berPwlX70pOjN1bqSSf/dy38HScHWdP8w+RvQ75gWH77q28kpd1/xKSbpWQ9PBOmNVXzhH+nSginJCFWv2W+lqdvXwS0G60LsozVILqoHaDGJlQWknQ0cFmGCxHmvHaijCYUnnX/+rZE/hHHxaXBUISZTt242rQSUgJCn9KYAofvmAd31RkCQhV/b93VTivoUHSE69oQbzTPXqUU2B/p0VDZSibY2UTMPqQRkrIPZgSPCR4m0nJtZ/u6BqM/Yr04zSBebsk4T7snGFj4IdT68BtzkgQqXyJ2nXi3nQLrNFdjMPEWFtHqXK74RyE5qryxo0EoH6O1YhXAtf1EryCvZ/10IQzqblMODXpOVeEwziNVeXPVSiHS4EpXf5dVXnsi3vxfDZmLrEopXp0tO9WIuO5A6OwTdTUy8rl4Se882jpQ7YO8u4GRDS/yMIgcUhuXE+quECQVjv0IKMc+vA3qM0iLTp2nWq12x3j+ytKQkp/LmzGuG690NcnMJTtes9Aha2CcLFtl/RZRBAaPwvZvfP4l5NfmrK58JBDklomDc39iEKFRXdbb1mvB3nlHEXaK+W1/FFYMn4GnPrRb4/hqOUe6cDdrkHCkXEnQCwOt36bnmIqmvOOdwNkLO+D05zS9mP7882mgSjUpnCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(26005)(6512007)(83380400001)(6486002)(6506007)(38100700002)(36756003)(41300700001)(2616005)(31686004)(53546011)(186003)(66946007)(66556008)(66476007)(478600001)(86362001)(6916009)(31696002)(8936002)(44832011)(316002)(8676002)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWN2M2NHQTNrRGdDaXhLN0xhMWNiMWhqVVpSRkMwMjBHVmV4MDhZNG5yL05o?=
 =?utf-8?B?RXZhdFd3WU5sMEJPcmhLaGtKVndpRXRMcUZFbUVtSW5PY2RwT29UTmVGRHNR?=
 =?utf-8?B?ME1wSStWUVVoMnhmOFF3S0FHVngxNi81T21ZYmp3MTdIcEpSUlN5bEduLzlI?=
 =?utf-8?B?Ky8weWxDbmJnOXNSeG5QemFVV3plS0x1dzlqN2RhbGZVbnlFUEVNYjJ2NW9x?=
 =?utf-8?B?SkwxS1habXZrUUJOL3FKR1lFWGR3VVZLTUcxejRVclNleTJwakR3Vy9VMTNt?=
 =?utf-8?B?VEFwNGdiR2UwRWdEREwveG80VUN0V0o2Ym16dUR6VXRLNzVDQXhwTW45NnJQ?=
 =?utf-8?B?UHg2LzcyU2NZdVFPTUh2QmI4UEx0SXM2SkhBdzVKVU5teUpYUVRUeVZ5Wlpp?=
 =?utf-8?B?NmV0YkI1azJia2ZQcFVqa0dvelJlL0d3SDRrVXBCR2ZCNlFSR3B5VVJmMElr?=
 =?utf-8?B?MHVmckZhNjRWaFJ6bDN3Z2ZHS2FjTjdydEhqUi82aWdQVXdwUkdGRDZ4WHNx?=
 =?utf-8?B?M3RmL2JMdXhVK1JYekZMSHMvcy9iNWRCd3UrMlZYY0swdXQyWG1YN0UzdlFo?=
 =?utf-8?B?Z0ZtL21TcmV0S2RXR0hWSmMzZ0Z4UVJJZHdjNVZKUFNqdEI4NGdnS1I3S1Fx?=
 =?utf-8?B?dEUxbkxVQTcyU1E4R3VoVFJPeHh0RU96c0IzUzBzVzEvSWJWYy9nSDl1Wm82?=
 =?utf-8?B?Rm5hdzRVZlhBR2trNXppd2xLdHBIL0o2TWd5YzJCSG54WE5tUUppamZkWHFo?=
 =?utf-8?B?ams3WXJNanlXOWl3ZVU1OEYvc0JLVzBYVzBGU09rbzF1L2lJQ3EvaFBWUldn?=
 =?utf-8?B?ZTFia1htaVpvaHgyNTlScUNLSm14Q3kvRFNFSDBLMWFKTFRwdDY5UTNaSFdP?=
 =?utf-8?B?REluOHY2bWkwTXdDYS9uK1hoemtpeGpZd0JrbFdwSUZ1aDhISUNQQnpiYVRN?=
 =?utf-8?B?MGphV3QvaHN4eGY1RFJCN1c5MVNpNm1CdHhKb2VKaEIwNE5iWTl5ejZEWjlp?=
 =?utf-8?B?WXZ1RGtWQUNuVERDT2g4a2dsMk82UnoxMUh5dWVrTU5GRzlVY3FHd2REYkhY?=
 =?utf-8?B?T2J5bUUvbkRUNWE3QWpyWlRLemZMSndZNmRkbzIzdkpoODA4M1VoWXdSRW5r?=
 =?utf-8?B?TjRQTjVmWWE4U1hMaW5yaGRZdzJWTmN5NmE0L0JDNHNLTVdwTi92cmJDbFJL?=
 =?utf-8?B?KzRHaW1KcEF3N2xGU21Fd3BFSzlQbVJxSHVrVzhUdVBETlBlU1ZmdUJFRW1Q?=
 =?utf-8?B?Yk10SjlSTGNDSDZ5WFUweG9xQlVnV2R1SWtPZHNQa3dMenQ4SGRHVTJPbSti?=
 =?utf-8?B?cG1JeWhsV3ZmN2p3NHpyWTdCMG1oaTZoN0E4WUV5NGMwSGF6MEZoMlRqVHk2?=
 =?utf-8?B?N0xCUTBWT3hieHhiWXh0amFKMmhGdXdiejNGVjV4UUlyeVk5c3p5c3hoRTh6?=
 =?utf-8?B?SlI1dFNPZ1JMakhjZm9YVmFhYTZMUzh6djZrWUY1N1g0cThkS21xbE15ZXJz?=
 =?utf-8?B?RU1iNEtYN0pzQlFyMkJ2NnVGZXpsTG11Y25NTWRDOERtTnhoNVppU0JPVytl?=
 =?utf-8?B?VWp2V016M3BoM0xlS2VQbFQ1ZW91V0dQRVlLbTRadUxKZ1h0VkwrUEU4QVFT?=
 =?utf-8?B?QllWNWZ2bm5LbmFPMVhyaUw5LzZJbldKS01lQWowdU9GVldkK0NSbEN2YTg4?=
 =?utf-8?B?YzZwYjdJdjhtWmsrL0JzNGpLdnZMSVJiYXFYc0ovM0JXSmpKakwrekNLazRY?=
 =?utf-8?B?bHVkN29IQkg5VVMzaHRTb3lEdUJYblRqYVJ0VmJtdlJ0MFZ4RE5mUEVySXBR?=
 =?utf-8?B?UkEzVjEwdzU5eTZ6S09CNitldzdYdGcvZWhiQTk4N0dldDRlYTEvOUtkQUVB?=
 =?utf-8?B?NDhHRnJMNTAzQ0Q3KzM5Y2hvK0FnYlRpaUJYL2o3R2tVYWx0eHZjVmcxNGds?=
 =?utf-8?B?ZDZPSjhQSWFvL1VTc0pMdWladHRzYkZUdXgyU28rM2UxSnJTa3FoZ1kxZWxC?=
 =?utf-8?B?WE9wOFNqNk03b3NEMm85Q2VoY0tnSnErc3R3ZEQxNXZmRkRlZ0NNbllDV0RO?=
 =?utf-8?B?V3dBQzNsRGIxc3p5YzVSQ3Fhbm8yWTViK09Va0xkNzhXcTNSUzdUamhua3Nj?=
 =?utf-8?Q?RCY038x1/VgmaCjYMObE5b9kb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e2ad24-8082-4965-176a-08db53446411
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 23:55:40.6424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unxR0HHFqIgCPiVAYokZoDuXmQT2S0WTrfgFFS35sSlaZ+RFVxGvtbEy/EnA/p2IPPVuZsWXboJOHL3w2FEU2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 5/12/23 6:30 AM, Michael S. Tsirkin wrote:
> 
> On Fri, May 12, 2023 at 12:51:21PM +0000, Dragos Tatulea wrote:
>> On Thu, 2023-05-04 at 14:51 -0400, Michael S. Tsirkin wrote:
>>> On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
>>>>
>>>>
>>>> On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> The referenced patch calls set_vq_affinity without checking if the op is
>>>>> valid. This patch adds the check.
>>>>>
>>>>> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading
>>>>> mechanism")
>>>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>> ---
>>>>>    drivers/virtio/virtio_vdpa.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>>>> index eb6aee8c06b2..989e2d7184ce 100644
>>>>> --- a/drivers/virtio/virtio_vdpa.c
>>>>> +++ b/drivers/virtio/virtio_vdpa.c
>>>>> @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device
>>>>> *vdev, unsigned int nvqs,
>>>>>                           err = PTR_ERR(vqs[i]);
>>>>>                           goto err_setup_vq;
>>>>>                   }
>>>>> -               ops->set_vq_affinity(vdpa, i, &masks[i]);
>>>>> +
>>>>> +               if (ops->set_vq_affinity)
>>>>> +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
>>>> if ops->set_vq_affinity is NULL, should give an error code to err, and
>>>> return err
>>>
>>> Given we ignore return code, hardly seems like a critical thing to do.
>>> Is it really important? affinity is an optimization isn't it?
>>>
>>>>>
>> set_vq_affinity is optional so it's not an error if the op is not implemented.
>>
>> Is there anything else that needs to be done for this fix?
>>
>> Thanks,
>> Dragos
>>
> 
> no, it's queued already.

Are these queued into a repo that is accessible?  I haven't seen 
activity in the vhost.git where I would have expected it.  After 
stumbling over and debugging this same problem, I was happy to see it 
fixed, and I'd like to pull from a repo that has the current updates.

Thanks,
sln
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
