Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E454C76188
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 17:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25C9E81D3D;
	Mon,  3 Apr 2023 17:00:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25C9E81D3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lbbc08pb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifZ6j9zPwP2R; Mon,  3 Apr 2023 17:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3BB481D35;
	Mon,  3 Apr 2023 17:00:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3BB481D35
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C98AC0036;
	Mon,  3 Apr 2023 17:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34114C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A5CA81D3D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:00:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A5CA81D3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jz74KPGzHIfE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:00:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DC4D81D35
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::618])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DC4D81D35
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 17:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT0iemGYZsFjJNcaMDNRTxjf8p0txkEaaZeKuZX7iUqrODI4mNjxuIKHGteb5PPPRAe2sCQAaCcwZVF3E3+v6QsaXRNCWsY0UJ99hNz+VzUMEU12ePglzokdyJ5tI4DOM71C0itdhNl81TesOyO5IUYT4TCpzXtxAWCWB3T69cdwEHu0TQI3p8cimYWr5aAzJtJBSgsBuDliHPH+TT/rxmQDbJhveahdvUwesoVizl4WNzleGkNZlyGrwvY720Wi2Th1B9ytcmCD8bW7CV0k0zKF23rv4/4oDuy05R6Zoam/tFca7BwFU89T532FKjUKhQOImAlKDveqxNeSrjKnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6+IHi/O5Y06DGO/4AZcg1258wTa5Zu3VpY2HdcQLJw=;
 b=Ls/inSE+iZd1Rwi17OkaEVWDzAMzFiZYdiRMvUOm8g0tRTYk2bHSXUT8PxjeRq1/WUK9CMC+XmuZvHjzDkXw6Dor4sA6alf5hKsAhcnSH0Cwvp4h4Knodf4e2C/5hYSIg0sJmLA0PX3KRJm0+uu4rLJtvvSmrF59ApVPo+ueOYS4biVT7NkQ/EQpwsGZm6VC8AsrDgbz435NW/l6WAk3kfBCL3gS712k8O7i8be4cW1RAa5qck3aZ7KDlpQsIjMgZdjr5LQ9JxWe8dlx598i7yByib83EaZAyytQyiSQQSyPf211XKveTgOA8si28dMRrdjpBkHVVMGV+i4DzGEfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6+IHi/O5Y06DGO/4AZcg1258wTa5Zu3VpY2HdcQLJw=;
 b=Lbbc08pbNmjhOY7VFU8CKz/UCY5mr3TT0hKyLsZxAeDWLSJEp5SQwAP6oVEudKnXkxjcHgQyDJWE4VMVj6gau8R2GeHmmZYLCLXm+/Gf0igPpL585ducToAUObiMYLSJfT7IwOmvkFHDJfrIqsImZc5y/U5FZi+S5G22q5Wqj+pjJsdGjEVKEw8Luoyjgao1munCE7CAiQwLCdRIRqYULP49HraAMQ+gSQm4O8vYLYUUwT3TwfK+Gi9pRDIp11I71s3AX8QdD2lxYnlcSkh4rcuxcySrO2urQu19FJJTDuv/1sAQrag8n4sTEjtDQurm3vz7AV/JqMaIlkXKyYLS3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 17:00:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb%7]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 17:00:19 +0000
Message-ID: <9db042bd-1bf9-9664-cb01-419be1a2f209@nvidia.com>
Date: Mon, 3 Apr 2023 13:00:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/1] posted interrtups support for mlx5
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20230403162039.18932-1-elic@nvidia.com>
In-Reply-To: <20230403162039.18932-1-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:806:125::16) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa977a4-739f-4d23-986b-08db3464e773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JElBZJcfKVF55HZS2VJ28iGqGCGL894gWpi8gcIl2mJGprdnYA9cUSMJHwHys/bX1oU3J+UX5IKl8mIifDjPxmwwX+Fqw71kxtJ4p5EYzDfZ/MofHuMdLrJtTYWunZovDhWhxplaGlk96OSduCO0DmSENHsinm8KlYNHV8jEHUW0My9ZUm2wzUnrLxvjz29iw0+WmoPAecrGx+G0Ncj4VKUPiAj8F8QX+HRlW098ZwewWpdcSlTcXawZApOuZ5ZHc+4hDqx8wg5yAbbr090aY+qO7Hj6DN/KYxKGkF0TnZumiTC7GHDNudCxvw3w5Y3WbY/iBqsALa7+WWQmxK2UA0e1jlu2UQi9rTq+uA03KDFPqdl1TGpWbZ1pTDFTkJGDaewfqaTMjmmWVrrNnYhtKpnPdBrl35FbScz78ExmN5TUAuT/+GYU4+ElyJ5FfuQTDWCSulw+CugetYy5hwLLoOR12Mrb3874NgyqIAh7v9j3POHYUMWhbznnUJH+wlWGcCrpMBEqLdheoIVzMvnixC6+TtXmCf23AgNO0oUArVAsaaibJDO0SYNwP056skIPqNmpmXjExggcTBqWrtfwl6C/ZBdFhu5KHDJmXe9wjgf4tMFLc84lMhI34v6SVhqhj140AuoMO98fClMv2lgSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(31696002)(86362001)(41300700001)(83380400001)(31686004)(6666004)(6486002)(966005)(107886003)(6512007)(53546011)(6506007)(26005)(8676002)(4326008)(66476007)(66556008)(66946007)(186003)(2906002)(36756003)(8936002)(2616005)(38100700002)(5660300002)(478600001)(4744005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1aRFF0WFNDZnFSTjJyTUdlNmMzTmFUbTVvK25RYkpaWERyRndSOUp3UnQ3?=
 =?utf-8?B?Y2FhcDV1amJoK0tsWWNnSnhTOTlWWkdzVkN2NGQ3d2FKTm9VMzV2MlEwVG55?=
 =?utf-8?B?SlgwNXo3SzNHb2tIQ3piakNpSm1LUlVtZ2R1NGlSaG9rUkZIejVVejNNNVlz?=
 =?utf-8?B?SGNnaHZ4UzZUc3Z6ckdFL21QeW9PaS9jYjZRNkhlTWdSVlJSMUI3QllzY0gx?=
 =?utf-8?B?NmxHOHNwbjNQemNlWHZMRFRCcHlnb1BMY0h6Ym0renZCQlE4L2JiNG9QUWJN?=
 =?utf-8?B?MTAyRXNscXJ5dVZyYkxNTHU3SkkwOWJtVE9EaGdOdWVKVmRtTmR4MGtxTGNK?=
 =?utf-8?B?eUN0aFlHclVmd3l0anRDYlRVaXNQa0I4cVJ1bzJKOTNGSGxTbGhWOWtoRmdC?=
 =?utf-8?B?WWxicnNFaWlpVEQ0dXJIbDIzeXZXQmhrTkJWUG1xc1d4cHdQelhWVWhBaWJP?=
 =?utf-8?B?N0tvb3M2RVBPaExDbzdJSEtSMERpKzdhaVE5MU96UE8ySGoxU1pMVnNjWlFy?=
 =?utf-8?B?RDlmUVdoU1pQWk5ieERtaUV1d0tsWWRWTjRqaWlhR1JMOWYra2t2cFI5SlZs?=
 =?utf-8?B?clBqSSsyZlNEQ1gxSWpidDJuejQxQzdxeXVpdDFhcVFjTjZ5TmRobUpGUWw3?=
 =?utf-8?B?RGlsQWRFL1NFQkRTcENxc1AzVngvKzNMSUpNKzI5bkNZRVZnWlN2dElJZWg2?=
 =?utf-8?B?MG0rNDdmdThDaGRQUWVZY2ZTS2QyU3VZN3hvY2lpZXlaWGlQYzlsN3c3NFZ0?=
 =?utf-8?B?QXAxb3RGT3pZSTZWYTRVYU1iMjNpTEN4Tk9KOUI4bk83RXF6THhPdC80UlVC?=
 =?utf-8?B?V0F1ck9naVNUc1dyTTVlcEtTZ0ZvdjZFRXpUc2FBUGl0Mk1OVXVwdmpjNVJ3?=
 =?utf-8?B?amxVdUx2ZjhRVGFBRTNWdWR6UFJHa3Bld2NDNHJaMGZqQzlocHhoUXM4enlU?=
 =?utf-8?B?K0QzN01XMDZsaE52OC92ZHNMbldQbDhsazI5MkJOaVU5TW9KM2JNemZXUFZ2?=
 =?utf-8?B?YldaNUFIOTVWM2xjZ2tpTjJobEJ5UGtUUDhEU1ZuNjZxTWdnRHd0T214TkY5?=
 =?utf-8?B?dlV5SjNMcFZiNnRpbHg0aFB2M1Zpa1FsL084N0hLRU1ZTlIvbTdLaXlNYWpK?=
 =?utf-8?B?UkJ2RFF0ZUpnVXkrUTVvaE9FOHJ2NTN1ck0rRWlFektuc3NrTkhBSFg0cTFV?=
 =?utf-8?B?aXk5UUJXL1FSbU9zSUFSbmI5WU9CZGt0REtvcnlDUW5GeWdQckhPbzVjQ2Jl?=
 =?utf-8?B?djZxVzN6SWQrc0dFRTdsMVFJNTBua1FEUmoyMW9ieUJXMWFXS3JKcTU1cVlx?=
 =?utf-8?B?Zk0vVndYRGlWRHFuREM5MGRiZmdmR3VsRmFqOWFtRlpNMldnbTF1TGh5MVNN?=
 =?utf-8?B?ZjRBZGpsU3poM0MvdWViZ1lHclIrTGFVL0l3dTZYR21EcHZxUGpqcXpVbDk5?=
 =?utf-8?B?aWZkWFJMdVZoM0IwekFHRjRTeHVMRERSdHZCc0h2NVhCNXhxZFRsTzV4MWhS?=
 =?utf-8?B?bUk2VSttdU83UVk3MmR1MWlxQS9WSFJiUkIrNDJYL0hSU0VFZjMzYWUxeGNB?=
 =?utf-8?B?Mkh3eGtXRk9RZEJLKzFRZ1pydHZPd3IvSnA2T2JPN3FtcHNmcnRmMVRZdG9C?=
 =?utf-8?B?T0hvSDBHK0ZPbmp0TUJHTnJJRFhxa0Zrb2tpSnZaTy9aRlpWTmlMZUpoTG05?=
 =?utf-8?B?azBZdzhDdU5UWGEyTXY2Y1dsekc0SW00Q3RwNGdvYmhyRW9FVUVwRlVReDIx?=
 =?utf-8?B?bFNBUW8vQ3JiVFR1bTJiZ0E1S1VBUnRVcVdpaWlEQVlaak1FMlpxUndtYXFW?=
 =?utf-8?B?ZmdVamFIOWdoL1VONTRJVVZnNW91QUsvK0dYK1U1OTQ1VHVHbis5TTB4Um1m?=
 =?utf-8?B?ZEc5UmtyTlJwcmNaL3UwWW1OVVc5aDQrbHhHc1RHTkFpVnVKNVhmaHluMThq?=
 =?utf-8?B?VVdna05FdzZMeUFUc0ZZUlBzMFZiR21Vbm5wTWlVblFVSDF3dFhFbkRmeC83?=
 =?utf-8?B?U1grcjdqL2hkaURmTjhMakg4TlIyMmh5TERmSjljbzU4RHZLUVFwaUhUTytY?=
 =?utf-8?B?bWlSZGl4aXRKS2JpZmV0TlJLRVV3amUxUmd0Rmo5b3NhbzdwN2hGWlFZSzQ1?=
 =?utf-8?Q?DnxPBFWs42QC1JRcj3qH2Vi06?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa977a4-739f-4d23-986b-08db3464e773
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 17:00:18.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YVyzHCV7tF9m6Q/pZ8EA8bnZXyF7REq+f7K7YMlnmsb593LRIlj2ej+l6+sXeMFr0J49ptZRVCKxW5U3JW34g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
Cc: parav@mellanox.com
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 4/3/2023 12:20 PM, Eli Cohen wrote:
> Hi,
> 
> the single patch in this series adds support for posted interrupts in
> mlx5.
> 
> It depends on the patch series already accpted can be seen here:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230324231341.29808-1-saeed@kernel.org/
> 
> git pull  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
> tags/mlx5-updates-2023-03-20
> 
> Eli Cohen (1):
>    vdpa/mlx5: Support interrupt bypassing
> 
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 139 ++++++++++++++++++++++++++++--
>   drivers/vdpa/mlx5/net/mlx5_vnet.h |  14 +++
>   2 files changed, 144 insertions(+), 9 deletions(-)
> 
In subject

s/interrtups/interrupts/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
