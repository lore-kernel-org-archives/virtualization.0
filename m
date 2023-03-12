Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FB3C6FD1F
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 12:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFFAF415C0;
	Sun, 12 Mar 2023 12:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFFAF415C0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h3iPkSyZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jm1Uh1mxObT2; Sun, 12 Mar 2023 12:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4A6A414CD;
	Sun, 12 Mar 2023 12:05:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4A6A414CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9098AC0035;
	Sun, 12 Mar 2023 12:05:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D79DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A48E98175C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A48E98175C
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=h3iPkSyZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XYDTVa7yqVH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:05:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9BEE81757
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::607])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9BEE81757
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 12:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+Rakqn/zZrsSu9CPrWNQhT2aQbjFxNRDprCBTSkwv+e2DRTPxTt9p3krDgr+QGEeNvGvHDMDfhFKc8qTMOjdg+flNIbcpu7Bw3Q7izIzHVDf8gVc80Kg27069kWvJ9OMUcE5YcSxecoksCrPOsm56upIbGToodtMlueGWqOJUGpEqQzMN+ojEQjAYaGmo1J05EI0B05/Z/8t4xaWDEDt3+kl/PGNax57Glmo2YetsvVKa4DpVTMWuJ+YLDG3bcO5OGntVcMo/LPNH18smugkVoEUMhjFhXZ/GekU57pOlAWmvWf5c+ng8v+EitjV10r8+lZ/rTKHlKzUqOpyaeTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K1OxDGoSplUXZp7djPL80ULL9zZom/q2Op5XX0/OJk=;
 b=OMCSCTW/bDwaMQ8VZCIXNZyLAvJsP8ZytQH8Z6haK+6ojqtjOh+5Ef/VxLdtXA5NbTZeS/xJN3n9TWxccVspOzTE5ZiQmSBLSVsKm62RMJnc4fJ5SDr3ZYjsCLzw6wrHbAoR2/p7Eo89vXhYk3tnki0dR/QanVpKCFzlg4Iiz5LZTUb/8eRM+wK0wVamjbQjnDg1FbIE3+1UPU7cvRYCTfFncyCpMkZ0wlqbf+k5gaiDXm9Oj7UPdaQD/0RbRJg4xFKtQgUUb+vEz8gTHlFU16jt+VVimVLLVeRPURTPlMOltJMJT1yVr2jmxEYMUsRUpiTMDMTcBobB89i865i9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K1OxDGoSplUXZp7djPL80ULL9zZom/q2Op5XX0/OJk=;
 b=h3iPkSyZdM6R9HtF0VdO4vFZU8HfGlK05X4BiA52jDzFK8AReWd6dOOmGo/4k3Ms820lxQvzkNWM0oDiRsJUTBrETNHlMXBgNlYos0hLM3csE//Q/Jz8qczmgYRnsjRHMUrDc52BAJjdg1nlFkMvdRvZwzxYArzqnc+zlsZVelgBVh3FsDPHMCZAh3riMaaZGfg22WjTJElTduWQdmFReEUklw8PrCnXUqIaQF7adq0tut+yqzl3J+8alA+VJsllusX1sUwSY8RhT3gPlnJ2unCMLyowQ/fBS61Vj0gjlL/Dw4B2g30zb0yJ3NVl3DJ1GiF+CBksC/UvYfEuTXqF0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 12:05:10 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 12:05:10 +0000
Message-ID: <5a764dff-fb42-c205-bc6c-a1061d9b30bd@nvidia.com>
Date: Sun, 12 Mar 2023 08:05:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
 <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
 <20230311140355-mutt-send-email-mst@kernel.org>
 <1bdcad80-eca7-9a6b-1375-1ddab3e6bae8@nvidia.com>
 <20230312014544-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230312014544-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DM6PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:5:14c::19) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 820067de-906e-4665-cb72-08db22f2072c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRq0IAr1/3VnM4Jp210pzuelpSWkZBNflt40ZBPHb+2V4gEQm2RKARnurMGY6xsoo3zoAfEu6DVxpp4bgNQOsd/DqGnpzYGDoL4a95Xb4Bj/Jqc7L0TOBe/Dk7DijiBbVQNONNcY3qY3o+eAPJ0zrZtJ9Z0ENFWkcHnYGNWssayEramUpzMcxwg8RWw5/Ys634EJZVkcvAQLm2+Zsj1oJaOVhPd/iXIPHd+DpAf/vtUnFKRq8f/uWaLX6k1gbvXOad2uzLeAaD37B7eacXQO4+H//V+dlLyrFUyFLQkxwNTG32EiSygRVEnz7Q4Bwfxvcb33y7TmHbW5bGP+A1W0Toaxu3FBiNaDSt9GvOswPQtUPS3MFfPWh8PWDb1wzrVdFaxTVcKzZsFvQdMLbnZdY6f+MWmTDa3FFPsi1a5DMG5OMz9NbxZlicLahUugPRUY0AKQLf2I5IlZdfI2fbSJRr9tK+e3XFbyjkktF+8KZxOGUe1PKOtH/+YaiqfxEXkD0t/nmmpSMCiqPB2i+/To1qBupudmlDXey9+Nm/UJqc9CeNL4LRaW8f8rOKrQs2S2ONcd4l696djYV+BPeOIHiFw4gYIEX8w6YbgCl9BQUB8bK1pMw2l2OYK8VhemugEAS2oCg8lIQKl8ThZF8jaG7T+m4n08iBweWIYT/ZaznlzNn61LF9pwsdCfJ7NmdnpWYlDSMeeRkiw6JAFZ4sjpy4dp/I7UWd8wWHTvtbwP3Fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(39850400004)(346002)(396003)(136003)(451199018)(5660300002)(36756003)(83380400001)(478600001)(6666004)(6512007)(6506007)(26005)(6486002)(2616005)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(86362001)(31696002)(54906003)(316002)(38100700002)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERwYVVWRGliVHhFdTJzYTErNGNmRmJYbkpHMk9QOXRQekxnMFhyUk90YkNH?=
 =?utf-8?B?YnZYbnZUSlA1ZVdtTVRIYmpJR2hiQnkzdHJPVEZic0gzdU9senNWODd3UEpL?=
 =?utf-8?B?SzdhUWtYSXg3Vi8xVE13ZmFEYWY2a1BvMGRGRVh2T2s1aTEraUhNaDlVSmxC?=
 =?utf-8?B?U3lMd3Mwb2ZmRFptL3hDTE5oMmVsMVBkVC9qU1JkWjNVdTI0aS8vcCszL01q?=
 =?utf-8?B?WmVZazNvSnFwUzFYT3pha1JlOCtpT1gwa3VVUi8vUGZSb2lHbEdkdWNwbExx?=
 =?utf-8?B?bWRrZTJGSklIbFVyQXRzL2Vwd0o1U3pzMDZXQ2hiTlJiai9SK01KclJjV2hX?=
 =?utf-8?B?UkFaVk8rd2dUYVZHb21xcm1jTFgzaC85OFp5QmVEbVp3RjY4cXp6RGV2ZHlM?=
 =?utf-8?B?SUMyRC9JSE5XcDBzcS9ET0puc04xWDFMTzROWHUvTFNoamN0Q2VIREZCYUJa?=
 =?utf-8?B?RG5NOTBwczB3UitQSkRsM1NYWVI2eDNGOGU3MzlhdFJFMERUU1Y0bUlSSnVT?=
 =?utf-8?B?UHBNSjJWU29sanVSWHFBL2JTUG44dDUzMUlHSjNQRndrd0cwRVgvUEQ0UFlV?=
 =?utf-8?B?Qm51WDNOM3BEMkhBNEl0YjNUT0gva3hRZXFDQTVjL2NFcWRBcEF4b3BZcUNl?=
 =?utf-8?B?THIxR0dXR3NETWVQR0EvR3A4WmVrekFRTHFkV2xSdzFjT2NZMkxVTEEyalZI?=
 =?utf-8?B?SXJ0SW1RTTIvKzNpZTYrRXlSNTVhTzAxL29xMVh0Wm1BTVMrRWZ2ZGt0dlZp?=
 =?utf-8?B?cHl0aTFLOGpvVVg0ZGdXSkpsOElxYlV2M0RFV3pRNC8wZ2FkRWFnbTluZzF6?=
 =?utf-8?B?clNxY1htV1dMYkpyeHBUcmtZMk1BaGQ0Y1U1MW1QZmgrMU9aL2lqZWEvSHpi?=
 =?utf-8?B?aHZYN0txSmFnY3c5SnJGNlV3K04zZWkyV05LRFBxZHJGR01sYmdweUM2M1dZ?=
 =?utf-8?B?VFc5Q1pVTFd2YWhMT1d1TTN6UWtTaW1PYjQ5MU9qckpSSXlkS0pjNmtUcGsr?=
 =?utf-8?B?VzlCaHorZ1hWbHVpeGhTYVV0eWpaNUljeW1ZeEhNQk1GVmp0U2MyaUJ3T0h1?=
 =?utf-8?B?MkhMam1XVDVZcnZGbVJnYmg4T1lrMms1N0s2bGRQbGFQTE9kclNpWWdxZ051?=
 =?utf-8?B?dW1Pc1ZnT2lzSE1vUDFWZnM4bWhrMEx5UmJKQXRqVDBkYXJxRVNmd1JzcVRy?=
 =?utf-8?B?cTJITmc5dy85bGRiYnFIK1VwUVc2Q203T3Y0SXhKczVUZ1h3RW1lMzBZRFNK?=
 =?utf-8?B?Q2RtTEdrR2NjV1lhS2ZXMm05VnZyb1UweEFJeUxHMGZPV2hERGFER1NvcUhZ?=
 =?utf-8?B?MzhrV2cxNE10ajVGQnluZUlRUGxNR2NXNW5pajZRRW1LZlZOL28veEVlS2ky?=
 =?utf-8?B?REtINW0yWGRkdkdBRGhPL0VncmhnSmxRZ1UrWUJpVFdTWXZ5NEVweDVFSVN6?=
 =?utf-8?B?cU9USWdUM2FyTWZ4cW96SXpGQThaVW03WFBrbk5FKzR6WnNLU0h3blE0V013?=
 =?utf-8?B?MEZwclVsWHg1RGFMR1ZYS0JBTStCN28wS3d0RzV0d2JwSjhsb2RpWWVSVE1G?=
 =?utf-8?B?YTVUcGoxb1Z0VHU5WXg3Smh3QUJpcm9Zdkpob2hXTmVNTFZYc3c3QmJuNWxK?=
 =?utf-8?B?VVpha2taeldhSjdEaGlzWDRwUCtIZjFJeElKNXZFTXB5c2JzQm84ckROSlZH?=
 =?utf-8?B?WklwUVRvZjVSK0dsckVYMHZqVmhYY1R5R0o5MkVmSVd1d0FOcXE5eFBSWlJT?=
 =?utf-8?B?a1BJck0vSnAyRTBJZzNjNkFaRHFpRGZTOEVZbVluMG50ME9ucmQ4UnJtb3FZ?=
 =?utf-8?B?Rkcza1pub1lURkNaQ0JoVW5KM2NWSVEyTkFxSlR6V3RIaHplbGIvOUFHUGQ4?=
 =?utf-8?B?SDNmakZERmdKS21DMmdxZ3ZkNnI3SldEYzM5SjNsSzZUa1VRd0dkVEVWY3d5?=
 =?utf-8?B?NUY0bVdRWTNsVU5oRHNTUmY2NmdNN3gzaWZ1WVkvM3pmUVhQRWtOaE1ncG5i?=
 =?utf-8?B?MTVUYzFjUUgzZ1pHbUU0QnE2Q0RFMXV3K2dhT0U1UnY3dm1hUUdvNlNUZEl1?=
 =?utf-8?B?MDh1OXBLbkZkVyt4cDNhOTRqUW5VbGN0c2g2NElJUjR5cThlMzFXbDF0L0V5?=
 =?utf-8?Q?63X8dIRwkS/fHRd9iqBFFAvLt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820067de-906e-4665-cb72-08db22f2072c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 12:05:10.2425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWUm4/HlECcVvxqWpr17EDe2+b0p0bkSkfbABLJoYHCsLnBjQm15El43gt8EAlEgFXezrtuMkPIc1FGMtVNjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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



On 2023-03-12 a.m.1:46, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, Mar 11, 2023 at 05:25:04PM -0500, Feng Liu wrote:
>>
>>
>> On 2023-03-11 p.m.2:05, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Mar 10, 2023 at 10:23:16AM -0500, Feng Liu wrote:
>>>>
>>>>
>>>> On 2023-03-10 a.m.8:36, Parav Pandit wrote:
>>>>>
>>>>>
>>>>>> From: Feng Liu <feliu@nvidia.com>
>>>>>> Sent: Friday, March 10, 2023 12:34 AM
>>>>>
>>>>>>
>>>>>> - if (!is_power_of_2(num)) {
>>>>>> -         dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
>>>>>> num);
>>>>>> -         return ERR_PTR(-EINVAL);
>>>>>> - }
>>>>>> -
>>>>>
>>>>> The check is still valid for split q.
>>>>> Maybe the right place for such a check is not the pci transport driver.
>>>>> But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.
>>>>
>>>> Hi, Parav
>>>>       I think you are right, I checked the virtio spec, only packed virtqueue
>>>> can use queue size which is not power_of_2; so, I think the check can be
>>>> reserved only for split queue here, something like
>>>>
>>>> struct virtio_device *vdev = &vp_dev->vdev;
>>>> if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)
>>>>    && !is_power_of_2(num)){
>>>>       dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>>>>       return ERR_PTR(-EINVAL);
>>>> }
>>>>
>>>> I will fix it in next version
>>>>
>>>> Hi, Michael and Jason
>>>> Do you have any comments on this?
>>>>
>>>
>>> Hmm good point. Which raises the question: so how did you test it then?
>>>
>> Hi Michael
>>
>> I will construct a non power of 2 size packed virtqueue device to test
>> whether the driver is loaded successfully and whether the traffic is normal;
>> at the same time, I will also construct a non power of 2 size split
>> virtqueue device for testing to see if an warning is given and the driver is
>> loaded fail
>>
>> The method of constructing the device, such as the reply steps in the
>> previous email
> 
> Okay but previously you said you tested ring sizes 100 and 200 with
> iperf. How did you construct these?
> 

Hi, Michael

After the driver has been successfully loaded, I will use iperf to test 
whether the network traffic is functioning properly. I will start the 
iperf server on the peer-end and the iperf client within the vm. I will 
then initiate a data transfer to perform the test.

> 
>>>
>>> --
>>> MST
>>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
