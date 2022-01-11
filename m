Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D003C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 01:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3618D60AC6;
	Tue, 11 Jan 2022 01:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nG149e89pQXT; Tue, 11 Jan 2022 01:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB67760ACE;
	Tue, 11 Jan 2022 01:59:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B21EC002F;
	Tue, 11 Jan 2022 01:59:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50899C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44F6E60ACE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4NQgpytyGl5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D65760AC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:59:44 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B0HrMI007277; 
 Tue, 11 Jan 2022 01:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hiu9QR/5rj0T/q21AoMMCg/Tpi3ZUBDcSxqRRyA7Z0g=;
 b=UF1VIJpXyER8eXFMcz8q9tzLM47TLIHIzoO8TpYjwpGUuEtsLIN78ZjF5PMy4magYp7w
 MV4zRm1n2HOAS5WM4U0IMRu0JoSDwBARYPXkVaFXT84EPOsILfG61sGHjHjd4RlXng/F
 PTe3mvGkN5CvLGGYEHjj4pDq6FTSrgEXJQzQm+I+hCZ3RwpqCm5IfZSMitmzETEUjRKb
 WyoMqZOVA/Qofz8R5Ok+0efS+8lJxk6ZCYYggXUO3D0NvpQ5QdrZal6b6QT2EemHqIjD
 PiDOnITAhLqhzK9N9CN3baEmSFe9ssuQ+z1/BxEH4nPMbtTMb1rAn4rEXocyP1rkPgU5 aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx1ya0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:59:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B1aRUt087668;
 Tue, 11 Jan 2022 01:59:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by aserp3030.oracle.com with ESMTP id 3df0ndcspe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5/b0f7+PvkUSDuK60u3g/e2W0Y52LS5ekYKzhvEZGSuINyJJ8CyDfqpPDMJLIapV3symLFi1ojNQm7DHc5RtH2EBWfFUh95ldUtcc+f+RQL55mondvDs+VxfrFFQKUXq2W8jdNcnRBVT+A4ikrol12u68zIA9wwN9ZIYtLyDIlAANkIMqJ5YTkziqAocYTjrVLPYSdLp2XaklpCKFG63hkfBc7cEmndhv9jj50rBnTTH9ZekqPe5fbrDlw3DUV5TlcDo3Nvl2x8kZGymHu6BM3f1ZEHVRQ4GPTagR584Mv/BAbouiSusYvbRTZimUDG+k6cX5J40E6CT2eyu6Zs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hiu9QR/5rj0T/q21AoMMCg/Tpi3ZUBDcSxqRRyA7Z0g=;
 b=AxeCr4DYi7T7nDifvbkCCb8xQ1O/4hjoy4t5WqyE733o1ZSKIh0b1xZ38TeK+W0sw9SfEFK2o5k5gE0t9KnmEacnvLH8UdA+NrQIlgLhZxXQBq4OAXg/0glwgxWVIGyvidfOEBrGJdmPNzkNGq4XwxcMvUyCmWGq4RVzgGzwzsz+jn4unLf+zF93AJx+4eakwvaCzu7frNd5rGWwU4UJrq7DdAGZlV70LN8hyUxk86l1vbN+v0xmXz3+sojJOsnPN5mYJ5rs5wMJip+joOZ3ybh3X6Ib8QHYeAVd3H1oNND9THhm3VWFqI2We5Gw1p0AEIrmPb/GMsIXC62Cdp7dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hiu9QR/5rj0T/q21AoMMCg/Tpi3ZUBDcSxqRRyA7Z0g=;
 b=DDGXxQUj4czUpnVTx87r0tViVh+MFGjb03icqZFM33YdKFbk7gSMi3kP4AboowKFl/dy2AGZQRTi9K0co0+L4FkBUWbCezziA99yB7g4jJWKCxeN7+8hmZ2Z06USePOefX3RAGJEoKqV6TJNX+T2Vnv192naRyEdkJGLeEwxFNg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4717.namprd10.prod.outlook.com (2603:10b6:a03:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 01:59:41 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:59:40 +0000
Message-ID: <ba3d534d-d1ba-549f-1b6f-e893625cdfbc@oracle.com>
Date: Mon, 10 Jan 2022 17:59:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 00/14] Allow for configuring max number of virtqueue
 pairs
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220110020122-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220110020122-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255d59ad-9839-4258-ec92-08d9d4a60780
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4717:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47175DE364384D5F0724F544B1519@SJ0PR10MB4717.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcncROoQsQpcLrwueoa5DFWlOYAe8S3CCpBhbxbLhOYxHFpumwb2wQZHtoCPclPvII+zoblnOD52A1jVycG7XTaeMnx7ChdN/D//zQiDfgxs0kPAPWQ6pIhyWTKooQSbgA5joJGALqWDYb+uPt8qADyeAclecUCyng5wfW4sk0MYpzY6qDAElNYS1ATFa6DUT9LC7m7muTw310zZJOxiPCzgURRaGGA5ZKMiHAe8rkDlBmvL2BZaaElr/h1pAnwDt9hh4+vFzyL8fJeNFov5edTh3ifyDJxXG6+8d2nWkxxC9LtT2J75TSlazPgdpK3JjBrVwVX3nKMc2VzeDflz9WrSM/2klyDPhfvI2QGuxcigXQyO9gcFjj6V/CqIh5x/MaUoNuhZZ+k7K+OZqFju8TKyN6WkGHs0XBCGbO7bv3y7IBnU/gXCZI1fzRv6Mujmu08t3ODkoG+uh0Va/OC5CjcIGJz9w9mfneDj7YxXq4IU/iYMmepWGar2x4eZ80ksG/Gg+4GzS/+W18p89IAkKFeorXdWPtfa7GqQaFMeRzRyEstaaPPkHcPbUAgDQU+qo7mU3jmSL0f/CuplwwmhVN8gOHmnJfAhx29wCpHzr0GL+YYKxDQ0R+OdFzuyqbwimewhcrhvTM7CoBsUm9DNWaqqBm/beSzApOh3xv4tO+oIizWzdBqnfg2KrmwKXLhvhrkGC8O4j78FlqoAVK3FZNFvObkJSV+8GvQanoc/d4aWkKlgPaglT1iZWrREWM4r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(2616005)(6486002)(316002)(4326008)(38100700002)(66556008)(31696002)(8676002)(66476007)(86362001)(2906002)(8936002)(6506007)(6666004)(53546011)(26005)(36916002)(31686004)(36756003)(5660300002)(186003)(110136005)(6512007)(83380400001)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFDc2hWMnlLR1ZlN2VkYitiajh3aHR5c0tzYVVlNUJQeTh3S1FQc1hmWm40?=
 =?utf-8?B?cUpXN3d6RGkzenExeVhoaUh3WEZZWHJtRG9VblpFck1sTWNoYk9mNWk2dmlm?=
 =?utf-8?B?L3IyVWd0QXdQNFlzbldFeWMvTEdxUHlvLzBCZWV5MXBjcmNDOGRIVXlrcWpE?=
 =?utf-8?B?Lzc3bE9SSDQ3c01iZWpxaFVkTGh2dU8ydmdBNlJaVG5CZlFjc2ExaHB1d2dz?=
 =?utf-8?B?RnZHMGY5TDBUNmFJQlptL25mUS9kVzRYRjFqNHMzM0JqT3ZVdVV4dFV5bVRY?=
 =?utf-8?B?MUo0R2VZMUZqZ2NueU5uekJYNVVQMUpyR3hXNW1PUkVVcTdYT1VUMHBkSG5V?=
 =?utf-8?B?Y3ZmMVhvNHFBekN2enJIWDZUNGo1Wlp1V3EzR2RGdnVVdk8vQUVTVW5Tamdx?=
 =?utf-8?B?VjBrNjFWSXdhUlczZnZWTzhiaEU0a200VVh4b1B1eDYxZi9ybmlVdENMSEt2?=
 =?utf-8?B?UHVWbENXbUI3dWtRU3I0dThNdklqOFU5UUZzNnJIYnlhbkg3b1lhZkZnMjhZ?=
 =?utf-8?B?bTV5bTlxeEp0S0NSRDF6cENITW1EWDVEa3BGYjl4dHRRVGVJendyd2YrSmsv?=
 =?utf-8?B?aEFkdjF6VWlFK2ZwL1F2emlUZ2lnUzFQOWxkbkM1eTJYd2FHcDJIdCtKaGJu?=
 =?utf-8?B?TmhNZk5zRllGMzgwa1ZZcE5XTWhhdUFxS1ZEcTQ5NWV3cmlWWkJ3TWpNMTR3?=
 =?utf-8?B?czN2STk3QVpTVG94TTFhdkN1TEVLaHRJWm1IK2VHenpMN3hYdkVvdTB6REtV?=
 =?utf-8?B?Um5lVGdQdXZyaVQ4QnVwL2RoSDl1VU1iYjhRN3Erc040K00wSWhOQzN1V3FN?=
 =?utf-8?B?OW5YbXZ5Qmd0b3IxK1BEaWZTS3lpMWVIbWhBMW93ODhPRGVZMm1UUTk1UU1N?=
 =?utf-8?B?aHBncUxraDdDVTFVRHZTWTdsSlFCSWV2M1dWSjdSM0lLT2RiVU5yTGN0NDBH?=
 =?utf-8?B?U3IrS2FMMWl1SXkzRFlJTGVHWUEzMmY3NVYwc1kwKys1dEhkWWd3S0lGNmFQ?=
 =?utf-8?B?b2ZVbjlTL2YxS0ZRdE54K2hDTXYwcDZGV0NEV1pHNkRrS3RHQ1YrenZnTkpl?=
 =?utf-8?B?djhzMHZlOHIvUjE5UFlGNzZLbDEvOVAwaFIya1FDUzdrUllsd3NDb1dXNFFC?=
 =?utf-8?B?VkNabmpXMEtodThZQ2xsaUFzOTdhVHNVcXdXYUdRV0l4S2N2QjFicmx4ejZZ?=
 =?utf-8?B?NU1PWFdlR3ErQStERk9zMk92UXBYeHlMSEowMFJnaHlwU3VER3liRm9GUEV2?=
 =?utf-8?B?UWczd2xsOTN1UEpuZkFlUzd0NlVUaGpjWjI3ajRIUUZlV01RNWk4ZjRtdW5k?=
 =?utf-8?B?ZTE3SEdhaFE4UjExeGl1RVQ0TzVpUVZXYksySHl2WTVlb2lVaDEveFM2T3Vi?=
 =?utf-8?B?eTkzeWc3d2oyY1JJaExpdk9WbFdrczNzL3hnV0NqY1Rxc0c0L0NyYWpyQTc0?=
 =?utf-8?B?clJ3b2loTDZyeVZscWRXNlJqTU5wTXdjTnlGYUZDeUNudDVLdkYzTjBUU1hH?=
 =?utf-8?B?empxZ3lrS2ZIN3dJbXZLKzlUKzQ3RkNZNXluSGlRTnBoN3lyME00VXJ5WFJo?=
 =?utf-8?B?UjNUNXpORDg1dkdBZHBHd2piZWZ6RHYwcWpXeXlrYmIrQVZ5bjBzVk8rTW9V?=
 =?utf-8?B?cEdnZUtxY2JxK2tJVFp3dEpReTVHN2pLcFhGK0hQajVtZFBzYTZjbUh1UGEr?=
 =?utf-8?B?aGZXRWFtemVtTUNNbXVIU1ZmVVpJaEEzazlvM25scGljc2xONzgxdXYycjZx?=
 =?utf-8?B?UVFRUkYrRTNhS0pMcWpscVJLQ3dPUmdaQnM0ZVpVSWpLN2dFdFpBRVJCZTdW?=
 =?utf-8?B?Z1R6UEZBcFZJbVllelVxMzhQTUVTMlVNeEVLOFVUdmkySTlnSlVNUzV3aHVu?=
 =?utf-8?B?MEV1SWJHNEVRS0NuaWYzT24yc2oxQllsSHg5SFJpdk1RaGJRdHRwYmwwaFFr?=
 =?utf-8?B?TEhzZGRtQUw1M2FudHFlbUk5YzhYREFTWjhTbDgzQlhOU3hEU01jdkQ3TERz?=
 =?utf-8?B?MDZoOURBUW9YTzdQMHpnRnZIbjFPMi9yMXdYZHk0RExaMmM1clVUQjJZVVVH?=
 =?utf-8?B?cmJIdHhtaXNqL1VYeFV1eisydGFod1BaMjZiaktITEU4STJIYjN3bFVFUGdr?=
 =?utf-8?B?MVppS0JweWdOVHhxMzdRR3dTTG1FZXVFc3FDMjBFSDRCSXB2eUJQdy9ZUHYv?=
 =?utf-8?Q?J7xpGdc9I1H8aGDME9X+vUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255d59ad-9839-4258-ec92-08d9d4a60780
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:59:40.6591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5fT3ogiyTK21VQPfkcSFJA3/ap2gzCtm4/ubt2WJcQljf0MwBH156YWtKPsnftHLZTrAKQkkZzPNJSU3A0KZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4717
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110003
X-Proofpoint-GUID: 9Y2VxbL0VPJgcMmt0TUfgNWshmDXtlCJ
X-Proofpoint-ORIG-GUID: 9Y2VxbL0VPJgcMmt0TUfgNWshmDXtlCJ
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxLzkvMjAyMiAxMTowNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdl
ZCwgSmFuIDA1LCAyMDIyIGF0IDAxOjQ2OjMyUE0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPj4g
QWxsb3cgdGhlIHVzZXIgdG8gY29uZmlndXJlIHRoZSBtYXggbnVtYmVyIG9mIHZpcnRxdWV1ZSBw
YWlycyBmb3IgYSB2ZHBhCj4+IGluc3RhbmNlLiBUaGUgdXNlciBjYW4gdGhlbiBjb250cm9sIHRo
ZSBhY3R1YWwgbnVtYmVyIG9mIHZpcnRxdWV1ZSBwYWlycwo+PiB1c2luZyBldGh0b29sLgo+IFNv
IEkgcHV0IGEgdmVyc2lvbiBvZiB0aGlzIGluIGxpbnV4LW5leHQsIGJ1dCBJIGhhZCB0byBzcXVh
c2ggaW4KPiBzb21lIGJ1Z2ZpeGVzLCBhbmQgcmVzb2x2ZSBzb21lIGNvbmZsaWN0cy4gRWxpLCBw
bGVhc2UgdGFrZSBhIGxvb2sKPiBhbmQgbGV0IG1lIGtub3cgd2hldGhlciBpdCBsb29rcyBzYW5l
LiBJZiBub3QgcGxzIHBvc3QgYSBuZXcKPiB2ZXJzaW9uLgo+IEphc29uLCB3aGF0IGlzIHlvdXIg
dGFrZSBvbiBtZXJnaW5nIHRoaXMgbm93PyBTaS13ZWkgaGVyZSBzZWVtcyB0byB3YW50Cj4gdG8g
ZGVmZXIsIGJ1dCBPVE9IIGl0J3MgdXAgdG8gdjcgYWxyZWFkeSwgbW9zdCBwYXRjaGVzIGFyZSBh
Y2tlZCBhbmQKPiBtb3N0IGNvbW1lbnRzIGxvb2sgbGlrZSBtaW5vciBpbXByb3ZlbWVudCBzdWdn
ZXN0aW9ucyB0byBtZS4KU3VyZSwgbm8gd29ycmllcy4gSSB0aG91Z2h0IG1heWJlIGl0J3MganVz
dCBtZSB0aGF0IGNhcmVzIGFib3V0IHRoZSAKY29tcGxldGVuZXNzIGFuZCBjb3JyZWN0bmVzcyBv
ZiB0aGlzIHNlcmllcy4gV2hlbiBJIGRpZCByZXZpZXcgZm9yIHY2wqAgSSAKYWxzbyB0aG91Z2h0
IHY3IG1pZ2h0IGJlIHRoZSBsYXN0IHNob3QsIGJ1dCBpdCB0dXJuZWQgb3V0IHRoZXJlJ3MgCm91
dHN0YW5kaW5nIGNvbW1lbnQgbWlzc2VkIHRvIGFkZHJlc3MgYW5kIG90aGVyIGlzc3VlcyBkdWUg
dG8gbGFzdCAKbWludXRlIGZpeC4gSXQncyBkZWZpbml0ZWx5IHlvdXIgY2FsbCB0byBwdWxsIGl0
IG9yIG5vdC4gSSdtIHNhdGlzZmllZCAKd2l0aCBhbGwgYXNwZWN0cyBvZiB0aGUgdUFQSSBjaGFu
Z2UgZm9yIHRoaXMgc2VyaWVzIGluIHRlcm1zIG9mIHRoZSAKZXhwZWN0YXRpb24gc2V0LgoKSWYg
eW91IGNhbiBoZWxwIGZpeCB1cCB0aGUgbmVlZGxlc3MgY2hhbmdlIHRvIEFQSSB2ZHBhX3NldF9m
ZWF0dXJlcygpIApmb3IgIltQQVRDSCB2NyAwNS8xNF0gdmRwYTogQWxsb3cgdG8gY29uZmlndXJl
IG1heCBkYXRhIHZpcnRxdWV1ZXMiIEkgCndvdWxkIG11Y2ggYXBwcmVjaWF0ZSBpdC4gT3IgRWxp
IGNhbiBwb3N0IGEgZml4IGZvciB0aGF0IHRvZ2V0aGVyIHdpdGggCm90aGVyIGlzc3VlcyBvbiB0
b3AsIGdpdmVuIGl0IHdhcyB2ZXJ5IGVhc3kgdG8gbG9zZSB0cmFjayBvZiB0aGVzZSAKc2ltaWxh
ciBjb21tZW50cyBkdXJpbmcgdGhlIHByZXZpb3VzIHJvdW5kcyBvZiBteSByZXZpZXcuCgpUaGFu
a3MsCi1TaXdlaQoKPgo+PiBFeGFtcGxlLCBzZXQgbnVtYmVyIG9mIFZRUHMgdG8gMjoKPj4gJCBl
dGh0b29sIC1MIGVuczEgY29tYmluZWQgMgo+Pgo+PiBBIHVzZXIgY2FuIGNoZWNrIHRoZSBtYXgg
c3VwcG9ydGVkIHZpcnRxdWV1ZXMgZm9yIGEgbWFuYWdlbWVudCBkZXZpY2UgYnkKPj4gcnVubmlu
ZzoKPj4KPj4gJCAkIHZkcGEgbWdtdGRldiBzaG93Cj4+ICAgICAgYXV4aWxpYXJ5L21seDVfY29y
ZS5zZi4xOgo+PiAgICAgICAgc3VwcG9ydGVkX2NsYXNzZXMgbmV0Cj4+ICAgICAgICBtYXhfc3Vw
cG9ydGVkX3ZxcyAyNTcKPj4gICAgICAgIGRldl9mZWF0dXJlcyBDU1VNIEdVRVNUX0NTVU0gTVRV
IEhPU1RfVFNPNCBIT1NUX1RTTzYgU1RBVFVTIENUUkxfVlEgTVEgXAo+PiAgICAgICAgICAgICAg
ICAgICAgIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIEFDQ0VTU19QTEFURk9STQo+Pgo+PiBhbmQg
cmVmZXIgdG8gdGhpcyB2YWx1ZSB3aGVuIGFkZGluZyBhIGRldmljZS4KPj4KPj4gVG8gY3JlYXRl
IGEgZGV2aWNlIHdpdGggYSBtYXggb2YgNSBWUVBzOgo+PiB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBh
LWEgbWdtdGRldiBhdXhpbGlhcnkvbWx4NV9jb3JlLnNmLjEgbWF4X3ZxcCA1Cj4+Cj4+IFBsZWFz
ZSBub3RlIHRoYXQgZm9yIHBhdGNoZXMgdGhhdCB3ZXJlIGNoYW5nZWQgSSByZW1vdmVkICJSZXZp
ZXdlZC1ieSIKPj4gYW5kICJBY2tlZC1ieSIuCj4+Cj4+IHY2IC0+IHY3Ogo+PiAxLiBNYWtlIHVz
ZSBvZiBjZl9tdXRleCBmb3Igc2VyaWFsaXppbmcgbmV0bGluayBzZXQvZ2V0IHdpdGggb3RoZXIK
Pj4gY2FsbHMuCj4+IDIuIFNvbWUgZml4ZXMgKFNlZSBpbiBlYWNoIHBhdGNoKQo+PiAzLiBBZGQg
cGF0Y2ggZm9yIHZkcGFfc2ltIHRvIHJlcG9ydCBzdXBwb3J0ZWQgZmVhdHVyZXMKPj4gNC4gIlJl
dmlld2VkLWJ5IiBhbmQgIkFja2VkLWJ5IiByZW1vdmVkIGZyb20gcGF0Y2ggMDAwNyBzaW5jZSBp
dCBoYWQKPj4gc2xpZ2h0bHkgY2hhbmdlZC4KPj4KPj4gRWxpIENvaGVuICgxNCk6Cj4+ICAgIHZk
cGE6IFByb3ZpZGUgaW50ZXJmYWNlIHRvIHJlYWQgZHJpdmVyIGZlYXR1cmVzCj4+ICAgIHZkcGEv
bWx4NTogRGlzdHJpYnV0ZSBSWCB2aXJ0cXVldWVzIGluIFJRVCBvYmplY3QKPj4gICAgdmRwYTog
U3luYyBjYWxscyBzZXQvZ2V0IGNvbmZpZy9zdGF0dXMgd2l0aCBjZl9tdXRleAo+PiAgICB2ZHBh
OiBSZWFkIGRldmljZSBjb25maWd1cmF0aW9uIG9ubHkgaWYgRkVBVFVSRVNfT0sKPj4gICAgdmRw
YTogQWxsb3cgdG8gY29uZmlndXJlIG1heCBkYXRhIHZpcnRxdWV1ZXMKPj4gICAgdmRwYS9tbHg1
OiBGaXggY29uZmlnX2F0dHJfbWFzayBhc3NpZ25tZW50Cj4+ICAgIHZkcGEvbWx4NTogU3VwcG9y
dCBjb25maWd1cmluZyBtYXggZGF0YSB2aXJ0cXVldWUKPj4gICAgdmRwYTogQWRkIHN1cHBvcnQg
Zm9yIHJldHVybmluZyBkZXZpY2UgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgo+PiAgICB2ZHBh
L21seDU6IFJlc3RvcmUgY3VyX251bV92cXMgaW4gY2FzZSBvZiBmYWlsdXJlIGluIGNoYW5nZV9u
dW1fcXBzKCkKPj4gICAgdmRwYTogU3VwcG9ydCByZXBvcnRpbmcgbWF4IGRldmljZSBjYXBhYmls
aXRpZXMKPj4gICAgdmRwYS9tbHg1OiBSZXBvcnQgbWF4IGRldmljZSBjYXBhYmlsaXRpZXMKPj4g
ICAgdmRwYS92ZHBhX3NpbTogQ29uZmlndXJlIG1heCBzdXBwb3J0ZWQgdmlydHF1ZXVlcwo+PiAg
ICB2ZHBhOiBVc2UgQklUX1VMTCBmb3IgYml0IG9wZXJhdGlvbnMKPj4gICAgdmRwYS92ZHBhX3Np
bV9uZXQ6IFJlcG9ydCBtYXggZGV2aWNlIGNhcGFiaWxpdGllcwo+Pgo+PiAgIGRyaXZlcnMvdmRw
YS9hbGliYWJhL2VuaV92ZHBhLmMgICAgICB8ICAxNiArKystCj4+ICAgZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYyAgICAgIHwgIDE2ICsrKy0KPj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgICAgfCAxMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4+ICAg
ZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICAgICAgICAgICAgIHwgMTAwICsrKysrKysrKysrKysr
KystLS0tCj4+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgICAgIHwgIDIxICsr
Ky0tCj4+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwgICAyICsKPj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jICAgfCAgMTYgKysrLQo+PiAgIGRy
aXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyAgICB8ICAxNiArKystCj4+ICAgZHJpdmVy
cy92aG9zdC92ZHBhLmMgICAgICAgICAgICAgICAgIHwgIDExICstLQo+PiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb192ZHBhLmMgICAgICAgICB8ICAgNyArLQo+PiAgIGluY2x1ZGUvbGludXgvdmRw
YS5oICAgICAgICAgICAgICAgICB8ICAzNiArKysrKy0tCj4+ICAgaW5jbHVkZS91YXBpL2xpbnV4
L3ZkcGEuaCAgICAgICAgICAgIHwgICA2ICsrCj4+ICAgMTIgZmlsZXMgY2hhbmdlZCwgMjcxIGlu
c2VydGlvbnMoKyksIDExMCBkZWxldGlvbnMoLSkKPj4KPj4gLS0gCj4+IDIuMzQuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
