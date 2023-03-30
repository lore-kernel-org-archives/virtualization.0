Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8BC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 18:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2130142089;
	Thu, 30 Mar 2023 18:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2130142089
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fg9I9MPn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kktnUkGTJce; Thu, 30 Mar 2023 18:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 295FC4208A;
	Thu, 30 Mar 2023 18:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 295FC4208A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F328EC0036;
	Thu, 30 Mar 2023 18:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F73C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E5B46167C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E5B46167C
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=fg9I9MPn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFvUaYM-UXcm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC1ED6167B
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::601])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC1ED6167B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRxevrycPuNd8BBlO7bzreCrTW7+AveN3Twso97dDDDKKamrWEmPg30wLaGyaweRuUgzP8DwEtQwQGlhwx+b/WTkInpCAJ+ZoEwaYKSqtZiR/GLLIgnM45AkFMHLN2YCSfj0ZkL2rN/ML4xFJcLqgRDw3INjROejdAmXRhKF5C0tAKjwKnB65gGxxYBS90Kxo4LYcskaYtjdXFSEAMQ9Co8n9EeGuEAkGW2QgpXAL6zhqt3oyp7R6EUV2vLF2lDbIY0SrBnaQ0iDkmSPc0pLwi4c9hZq5PEqffsZoX36NYN/G87Yh18IRqddFwfpat1CDObf2ajqGIQaOgCl7uxYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLdpYON+bWbQFkF6VYT8pW/HBrwy1OP8lBbuEJbvXEA=;
 b=NhWZc36bakwAkeVpCmuV5QCuOE8ZALVIZyNrrlMT3AiwTdoL0y7OJOKGLLarxizHYYWeldY5auPUaFqaAn0OzddtF55jeKNc85L18ZX3MChIXepbgJAb2XfpMHY8HgwM5SY12RzLvqGHtIJTYefpyFi9GboFAiFh+l5D5/lRxL30I4UWKb+SpbW3X/vCCXkikZUvpmWsNh4RBMcAmKn5BflkD9RuvPkAN0tvDy6NN6Q0ieH6HL7geqJ6LhUCMWzKvpQNTvrKctdYhel6CoXP2vDF0ckgr1lUBkCJfPs8FnoDfbfxeZp2a4G6PAQPIAK2+rxm56P6srSoEOxQ06D2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLdpYON+bWbQFkF6VYT8pW/HBrwy1OP8lBbuEJbvXEA=;
 b=fg9I9MPnsojdYW1FHIj/IxnfPWHVshY7JxTKWOTCbuCxxqviXtp4yS9W8N+tkWjmWuqnoUtuEMnx/M5G9F3AJiZWtfLTn42wXElarkO0tYJTAXuyNJZg+DpDzxIfO+BoJxzE9gm7iOBoL7Hy+NJTZrzfBd4deuimK88aSUGJxD/fSBrfCOO6SW01TmzRpe5+okCEgRIpiKqmcycBmLq/WtJTPgz5YovvQprZ6V4Wf1479ydmYPLRImhGx6XYJLxemeN4k7rJs9gI33x2Q6WuCKpBcXYf82X7XcolMmgS5rIwOtH3p7wg1RWkUI5RnILqlZ4IK0F/8eBkq8VpNdRANg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 18:22:49 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 18:22:49 +0000
Message-ID: <7230d466-8d96-80f2-fd9a-362d965f30bd@nvidia.com>
Date: Thu, 30 Mar 2023 14:22:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] virtio_ring: Use const to annotate read-only
 pointer params
To: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-4-feliu@nvidia.com>
 <CACGkMEtCL=fF9KEsLj-n7t3LQT0ckRXHx61FqTOiXBq02Mgk1A@mail.gmail.com>
In-Reply-To: <CACGkMEtCL=fF9KEsLj-n7t3LQT0ckRXHx61FqTOiXBq02Mgk1A@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::7) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CH0PR12MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: b39c5da5-ee46-46f1-d3a2-08db314bc441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xi/pahcVSgzgivRzgYzyMB/TRbrHMEMUF1u+nk17Xr2TyQFvlCL7fza4aE80vTkOLqRauGS74X9OhLpu4nPqAdpRv3voIG3xEiD5S9OJ9PvgJnKvJZQzbWR4vdOZOWqwhrc6P38KBQfMfAF7gUbLy5ba7g/bUmtjwDkJ+Wb1BWz8tGXIzzIgxSHpw6iwcncWpMc5W2ItUMnHW6gymJ0jM3fVbrzyWhJrpZJUJjjp7/tr1pGtPqgHF9zT9ef7/MtjmXbEO+GaPwTb2KMLTcD5bvxFIYPLuez9UwC82svdqp8fS4yrhYiT7Becm8Kf8QG7b0aV7oyULfGjauEuFEnPQDjuInWCMsfi0S2hs/naDzkPaJYLzZGTr9nImoFVrilAqAuBbjgsfFwVC8IEW8M3LQnnZQYEGDwVb+TMEYQO7IWhjGmTlZp1VH2tCoRG9X6HjHNS2RxZiZDf2Tk7FgR+M7r99ENpQFKJcwI9O2S58vpzU5ERl3aduZOKTPpqbBHZvceS3CUK3Ka50HatdwwYmcWQuY5fjLE+uqXbUxvgF07yDfRw42wo1UUiewFPdvpMgTVOsGbWtzNRlb0F4AGzE8tCf7TJWS1QBC1qt5W/Wo5Fty7wdFmf31Vau/nKfM+BV53+4JxcZT6GqYtDtJFJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(31686004)(83380400001)(107886003)(53546011)(478600001)(26005)(316002)(54906003)(110136005)(8676002)(36756003)(6506007)(31696002)(4326008)(6666004)(6512007)(66476007)(41300700001)(86362001)(66556008)(66946007)(2906002)(38100700002)(6486002)(5660300002)(8936002)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEoxZzZOdWtHUVdMQ01zTmZ6NDVrUGRqY2k4YTVKZDBvcU1CSXNzaDN2YTRG?=
 =?utf-8?B?ZlRhWVNYcU1nOUFTVHBuTnFwVXA2VUNZUUM5aVJZSVBHMDRlMmZKL2UwK2ZZ?=
 =?utf-8?B?RGN1TDVSREFhUEVLYUd2bytwZHlBZC9CRGNtSUJoSXpSNW94YlFsQmJpN0tt?=
 =?utf-8?B?TFhpUmRhenlzRlc3bU5ROVZyVHkvRGhyc0VKUEpFb1VhaXdldUJkUDNpM3h6?=
 =?utf-8?B?YktGSE5nUTVVdWRTSGN1bHdTdktwR1pLbjJKN2RwdzI2bXlqSU9uc1JSNkUy?=
 =?utf-8?B?TjZQSnFOR0ZkWjV0SitVeDUwSFZydVhjRWxUSDdvNGxYeVRoYTM5UlhoaUpM?=
 =?utf-8?B?RDE4TkUyUGZ0cnJ1cDlrNXJCTkwrais0T0VBUGg4NTE4d3MyKzVFejc1cnN6?=
 =?utf-8?B?TDcvVnovWGpsellhUWRlUFFpUUJsKzRXSWlpS01nTEN4VWZTSEl2SzN0YlM1?=
 =?utf-8?B?bDVkdjArc1Q4YkNJWXZHVk5UMUVMRjZwRTZYT3Rrd1NRS3lwRnI4UG0wUFUv?=
 =?utf-8?B?TEx3NkZkN2IxSHl2NDJoV2wxSGY5U0hKc0pqbmZNN1VRcEZLcmw5VG8wMnc4?=
 =?utf-8?B?WjJhZU5naklESVpOeUdLR0g4bllHUTRqZjdNTml0YjNOSWJ6c3RvbVY4SE1W?=
 =?utf-8?B?NFpnVE9yZFk0Z2UrQ0xnVlRtc2JNY05kc2h2VXhxZkNJK2gxcGl2VDJWOHBI?=
 =?utf-8?B?UnlRZm5SZ2dhd1NZQVhWNVFETXR0aCs2SGJ2eTg5TUpyeHZXZXNXa1czRlV0?=
 =?utf-8?B?bThxcGhMYjRlSXVZenJWdU9CWHV6MGQzcUd5OUYxMVM3ZUdDdUQ1bmNDR1VJ?=
 =?utf-8?B?NWFsNzk5b3BKcHo1NHdwZXJFbHZVYitUNDU0dWFsK3BQbTZLYjdhY2Vwb3dR?=
 =?utf-8?B?T0pPYkh5WEtuQm1zdGhIU0QrZkc0bDMxSnhmNitIMG5ydzNNSGJrR2ZtVHRj?=
 =?utf-8?B?VU1iaUNKNWtGRXZsZzBrMytmRDBhbUxYbDlrQzNueUNvNk5RWW1OWWxyNSti?=
 =?utf-8?B?TEJtdjcxNStFRjAzZ2M2Um9KNHRFRnlWaWpCbEtPQWU0K0JjSFYyai9ya1Ux?=
 =?utf-8?B?b01vYTVBNjYzaEh5SThKUUZSdW9iVDVMMll1NmtwUEp0azRtTXdlYms0S2xX?=
 =?utf-8?B?QTArVit4Qy94MzgrRE9yU3VtZ0hXc1N6aExHbWsxVGUrM2VSMElFQmJGUTBJ?=
 =?utf-8?B?Y3A4NTBiS0wyTStjUEZ3dVJDWnZUUzlwNEF5NGVjdVBqRGpSeERoWHV5VCtn?=
 =?utf-8?B?Z2g5YWZPVk1xN3ExOTArenpwRzdHOGRIR2h4cGJwWmxZZE9Jek1PVjV6dXF5?=
 =?utf-8?B?Z3JDbEg5OGNLVld2c1NjVHEvbkNvY25ielRXTS9QOFdmeUx6QVFyR0NmMXJW?=
 =?utf-8?B?VGZ6M1lpYUs2M25DTkswWVBqWmtFVkZXRzdtaFUvS3ZPZHZXeDFVRlYvb1Nw?=
 =?utf-8?B?alBEbVpuNUI2SnowQ09ybFRzSGo1ZGtzUHBTTm9qT0R1K3FLK3VZbTdCZmQ4?=
 =?utf-8?B?TXFiRWlGKzBSbGhWWjc5blczRzZscU4vTlRVdFJIM29lVVNVWHg4ZDlVLzlm?=
 =?utf-8?B?T3o3RmxwcVBoUm5VRmdJSjdVRDJQRE9rWUYyelFmSVpyaDEydjBLcDRITENT?=
 =?utf-8?B?NGp5QnB4TGRXT3ZENW1LcXMwQnlrWWh3cTBkOWtmMzV2ZmgreW1qR1Nvc2o5?=
 =?utf-8?B?dXZFZFk5Sk9VU2FWTmJNMXVvc3A4dnFSaFpBdFVTMHlaVWlRQWlNL0QvZWE0?=
 =?utf-8?B?eVdMTndvVm1Ma2xhUDVQQ2JzNGdSZjFuZ1BMMUxRb0FRQjRRL1I2WTJGeS9B?=
 =?utf-8?B?MDlkZDBsNmU4M0hib0tyMGEwUzRDdWkvZWQ3SW9kUUtXbWd6c0ltb0t6KzJ0?=
 =?utf-8?B?L0ozemZUcFBpT21mYUhNeDE2TDRmWVpTWVRuMlZaWGRjdW1uU3FhSDBGNU5u?=
 =?utf-8?B?WlJXUXpLTmhZOS83clZLVWQ0eUh4Z21DWlZhTmNlN1UycWhUeDczaXIwcWlC?=
 =?utf-8?B?L1piVVZZc0N1VElES05WY0lSZnhIU3kvWHZ3U3VSTTJVU1k0ZjROTUtmSlVw?=
 =?utf-8?B?V2hWYzdWYUhIRE00SHdQenBKc3BNTFhJU01lSmEycDExZVo3UjYzTm54N1dx?=
 =?utf-8?Q?9EMUxtrhZjC7iQwB6eOjxcFKh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39c5da5-ee46-46f1-d3a2-08db314bc441
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:22:48.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4PHCnAkRxgSiKTQaVvTl2qbNE1sfOUIa0V8xyQ/iLJ8QE36rYtZXpYVWmkl9SPHjExbo5bS/YGLNlohEQHupA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTAzLTE2IHAubS4xMToxNywgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFRodSwgTWFyIDE2LCAyMDIzIGF0IDI6NTXigK9BTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+Cj4+IEFkZCBjb25zdCB0byBtYWtlIHRoZSByZWFkLW9ubHkgcG9pbnRlciBw
YXJhbWV0ZXJzIGNsZWFyLCBzaW1pbGFyIHRvCj4+IG1hbnkgZXhpc3RpbmcgZnVuY3Rpb25zLgo+
Pgo+PiBVc2UgYGNvbnRhaW5lcl9vZl9jb25zdGAgdG8gaW1wbGVtZW50IGB0b192dnFgLCB3aGlj
aCBlbnN1cmVzIHRoZQo+PiBjb25zdC1uZXNzIG9mIHJlYWQtb25seSBwYXJhbWV0ZXJzIGFuZCBh
dm9pZHMgYWNjaWRlbnRhbCBtb2RpZmljYXRpb24KPj4gb2YgdGhlaXIgbWVtYmVycy4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4+IFJldmlld2VkLWJ5
OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4gCj4gQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cj4gCj4gVGhhbmtzCj4gCkhpIE1pY2hhZWwgJiBKYXNvbgog
ICAgICAgICBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gdGFrZSB0aGVzZSByZXZpZXdlZC9hY2tl
ZCBwYXRjaGVzIGZvcndhcmQ/ClRoYW5rcyBzbyBtdWNoCgoKPj4KPj4gLS0tCj4+IHYwIC0+IHYx
Cj4+IGZlZWRiYWNrcyBmcm9tIE1pY2hhZWwgUy4gVHNpcmtpbgo+PiAtIHVzZSBgY29udGFpbmVy
X29mX2NvbnN0YCB0byBpbXBsZW1lbnQgYHRvX3Z2cWAKPj4gLS0tCj4+ICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyB8IDM2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LQo+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAxNCArKysrKysrLS0tLS0tLQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBpbmRleCBhMjZmYWI5MWM1OWYuLjRjM2JiMGRkZWI5YiAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+IEBAIC0yMzEsOSArMjMxLDkgQEAgc3RhdGljIHZv
aWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+PiAgICAqIEhlbHBlcnMuCj4+
ICAgICovCj4+Cj4+IC0jZGVmaW5lIHRvX3Z2cShfdnEpIGNvbnRhaW5lcl9vZihfdnEsIHN0cnVj
dCB2cmluZ192aXJ0cXVldWUsIHZxKQo+PiArI2RlZmluZSB0b192dnEoX3ZxKSBjb250YWluZXJf
b2ZfY29uc3QoX3ZxLCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlLCB2cSkKPj4KPj4gLXN0YXRpYyBi
b29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+
ICtzdGF0aWMgYm9vbCB2aXJ0cXVldWVfdXNlX2luZGlyZWN0KGNvbnN0IHN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNp
Z25lZCBpbnQgdG90YWxfc2cpCj4+ICAgewo+PiAgICAgICAgICAvKgo+PiBAQCAtMjY5LDcgKzI2
OSw3IEBAIHN0YXRpYyBib29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZSAqdnEsCj4+ICAgICogdW5jb25kaXRpb25hbGx5IG9uIGRhdGEgcGF0aC4KPj4gICAg
Ki8KPj4KPj4gLXN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+PiArc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGkoY29uc3Qgc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+ICAgewo+PiAgICAgICAgICBpZiAoIXZpcnRpb19oYXNf
ZG1hX3F1aXJrKHZkZXYpKQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOwo+PiBAQCAt
Mjg5LDcgKzI4OSw3IEBAIHN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+PiAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+ICAgfQo+Pgo+PiAt
c2l6ZV90IHZpcnRpb19tYXhfZG1hX3NpemUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+
ICtzaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldikKPj4gICB7Cj4+ICAgICAgICAgIHNpemVfdCBtYXhfc2VnbWVudF9zaXplID0gU0laRV9N
QVg7Cj4+Cj4+IEBAIC00MjMsNyArNDIzLDcgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX2luaXQo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHUzMiBudW0pCj4+ICAgICovCj4+Cj4+ICAgc3Rh
dGljIHZvaWQgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KGNvbnN0IHN0cnVjdCB2cmlu
Z192aXJ0cXVldWUgKnZxLAo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZyaW5nX2Rlc2MgKmRlc2MpCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgdnJpbmdfZGVzYyAqZGVzYykKPj4gICB7
Cj4+ICAgICAgICAgIHUxNiBmbGFnczsKPj4KPj4gQEAgLTExODMsNyArMTE4Myw3IEBAIHN0YXRp
YyB1MTYgcGFja2VkX2xhc3RfdXNlZCh1MTYgbGFzdF91c2VkX2lkeCkKPj4gICB9Cj4+Cj4+ICAg
c3RhdGljIHZvaWQgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKGNvbnN0IHN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxLAo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhKQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhKQo+PiAgIHsK
Pj4gICAgICAgICAgdTE2IGZsYWdzOwo+Pgo+PiBAQCAtMTIwNiw3ICsxMjA2LDcgQEAgc3RhdGlj
IHZvaWQgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLAo+PiAgIH0KPj4KPj4gICBzdGF0aWMgdm9pZCB2cmluZ191bm1hcF9kZXNjX3BhY2tl
ZChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKmRlc2MpCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ19wYWNrZWRf
ZGVzYyAqZGVzYykKPj4gICB7Cj4+ICAgICAgICAgIHUxNiBmbGFnczsKPj4KPj4gQEAgLTI3ODYs
MTAgKzI3ODYsMTAgQEAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfdHJhbnNwb3J0X2ZlYXR1cmVz
KTsKPj4gICAgKiBSZXR1cm5zIHRoZSBzaXplIG9mIHRoZSB2cmluZy4gIFRoaXMgaXMgbWFpbmx5
IHVzZWQgZm9yIGJvYXN0aW5nIHRvCj4+ICAgICogdXNlcnNwYWNlLiAgVW5saWtlIG90aGVyIG9w
ZXJhdGlvbnMsIHRoaXMgbmVlZCBub3QgYmUgc2VyaWFsaXplZC4KPj4gICAgKi8KPj4gLXVuc2ln
bmVkIGludCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+
PiArdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShjb25zdCBzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEpCj4+ICAgewo+Pgo+PiAtICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxID0gdG9fdnZxKF92cSk7Cj4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4KPj4gICAgICAgICAgcmV0dXJuIHZxLT5wYWNrZWRfcmlu
ZyA/IHZxLT5wYWNrZWQudnJpbmcubnVtIDogdnEtPnNwbGl0LnZyaW5nLm51bTsKPj4gICB9Cj4+
IEBAIC0yODE5LDkgKzI4MTksOSBAQCB2b2lkIF9fdmlydHF1ZXVlX3VuYnJlYWsoc3RydWN0IHZp
cnRxdWV1ZSAqX3ZxKQo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1ZV91
bmJyZWFrKTsKPj4KPj4gLWJvb2wgdmlydHF1ZXVlX2lzX2Jyb2tlbihzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEpCj4+ICtib29sIHZpcnRxdWV1ZV9pc19icm9rZW4oY29uc3Qgc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxKQo+PiAgIHsKPj4gLSAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRv
X3Z2cShfdnEpOwo+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0g
dG9fdnZxKF92cSk7Cj4+Cj4+ICAgICAgICAgIHJldHVybiBSRUFEX09OQ0UodnEtPmJyb2tlbik7
Cj4+ICAgfQo+PiBAQCAtMjg2OCw5ICsyODY4LDkgQEAgdm9pZCBfX3ZpcnRpb191bmJyZWFrX2Rl
dmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9M
X0dQTChfX3ZpcnRpb191bmJyZWFrX2RldmljZSk7Cj4+Cj4+IC1kbWFfYWRkcl90IHZpcnRxdWV1
ZV9nZXRfZGVzY19hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4gK2RtYV9hZGRyX3Qgdmly
dHF1ZXVlX2dldF9kZXNjX2FkZHIoY29uc3Qgc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+PiAgIHsK
Pj4gLSAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+PiAr
ICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+
Cj4+ICAgICAgICAgIEJVR19PTighdnEtPndlX293bl9yaW5nKTsKPj4KPj4gQEAgLTI4ODEsOSAr
Mjg4MSw5IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9kZXNjX2FkZHIoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X2Rl
c2NfYWRkcik7Cj4+Cj4+IC1kbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICtkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRk
cihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICAgewo+PiAtICAgICAgIHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+ICsgICAgICAgY29uc3Qgc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4KPj4gICAgICAgICAgQlVHX09O
KCF2cS0+d2Vfb3duX3JpbmcpOwo+Pgo+PiBAQCAtMjg5NSw5ICsyODk1LDkgQEAgZG1hX2FkZHJf
dCB2aXJ0cXVldWVfZ2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+PiAgIH0K
Pj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X2F2YWlsX2FkZHIpOwo+Pgo+PiAt
ZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X3VzZWRfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICpfdnEp
Cj4+ICtkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKGNvbnN0IHN0cnVjdCB2aXJ0
cXVldWUgKl92cSkKPj4gICB7Cj4+IC0gICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEg
PSB0b192dnEoX3ZxKTsKPj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2
cSA9IHRvX3Z2cShfdnEpOwo+Pgo+PiAgICAgICAgICBCVUdfT04oIXZxLT53ZV9vd25fcmluZyk7
Cj4+Cj4+IEBAIC0yOTEwLDcgKzI5MTAsNyBAQCBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNl
ZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0
cXVldWVfZ2V0X3VzZWRfYWRkcik7Cj4+Cj4+ICAgLyogT25seSBhdmFpbGFibGUgZm9yIHNwbGl0
IHJpbmcgKi8KPj4gLWNvbnN0IHN0cnVjdCB2cmluZyAqdmlydHF1ZXVlX2dldF92cmluZyhzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPj4gK2NvbnN0IHN0cnVjdCB2cmluZyAqdmlydHF1ZXVlX2dldF92
cmluZyhjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPj4gICB7Cj4+ICAgICAgICAgIHJldHVy
biAmdG9fdnZxKHZxKS0+c3BsaXQudnJpbmc7Cj4+ICAgfQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPj4gaW5kZXggMmI0NzI1
MTRjNDliLi5jNDIyNTY1M2Y5NDkgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+PiBAQCAtODQsMTQgKzg0LDE0IEBA
IGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsK
Pj4KPj4gICB2b2lkICp2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1
ZSAqdnEpOwo+Pgo+PiAtdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSk7Cj4+ICt1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19z
aXplKGNvbnN0IHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4KPj4gLWJvb2wgdmlydHF1ZXVlX2lz
X2Jyb2tlbihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+ICtib29sIHZpcnRxdWV1ZV9pc19icm9r
ZW4oY29uc3Qgc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+Pgo+PiAtY29uc3Qgc3RydWN0IHZyaW5n
ICp2aXJ0cXVldWVfZ2V0X3ZyaW5nKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4gLWRtYV9hZGRy
X3QgdmlydHF1ZXVlX2dldF9kZXNjX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+PiAtZG1h
X2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+
PiAtZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X3VzZWRfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2
cSk7Cj4+ICtjb25zdCBzdHJ1Y3QgdnJpbmcgKnZpcnRxdWV1ZV9nZXRfdnJpbmcoY29uc3Qgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEpOwo+PiArZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRk
cihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+ICtkbWFfYWRkcl90IHZpcnRxdWV1ZV9n
ZXRfYXZhaWxfYWRkcihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+ICtkbWFfYWRkcl90
IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKGNvbnN0IHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4K
Pj4gICBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTMyIG51bSwK
Pj4gICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKSk7Cj4+IEBAIC0xNDcsNyArMTQ3LDcgQEAgaW50IHZpcnRpb19kZXZp
Y2VfcmVzdG9yZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4gICAjZW5kaWYKPj4gICB2
b2lkIHZpcnRpb19yZXNldF9kZXZpY2Uoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4+Cj4+
IC1zaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7
Cj4+ICtzaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldik7Cj4+Cj4+ICAgI2RlZmluZSB2aXJ0aW9fZGV2aWNlX2Zvcl9lYWNoX3ZxKHZkZXYs
IHZxKSBcCj4+ICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodnEsICZ2ZGV2LT52cXMsIGxp
c3QpCj4+IC0tCj4+IDIuMzQuMQo+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
