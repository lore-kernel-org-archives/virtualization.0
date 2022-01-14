Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E23CC433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 09:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FA5F60F3E;
	Fri, 14 Jan 2022 09:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HafIZsGS7t9V; Fri, 14 Jan 2022 09:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBC46600C5;
	Fri, 14 Jan 2022 09:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E047C002F;
	Fri, 14 Jan 2022 09:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0048C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDEF160784
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3RTlFzWTpLh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 243E2600C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:19:59 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E92G6v002492; 
 Fri, 14 Jan 2022 09:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SwJBGQJNlXvqg+yy/l238zMDLahR41va+y/lbRvSDL4=;
 b=BEowDQ0I+488OJ6ThyxfKTMjqyIGLFaBQDZgI+s97ONb2aKXcWNShimS3uCvrhttj9+g
 IqSP+aTvOoBe23qGrxfMrBIMC18CsfeXFTykFgflA8Mk5KIkNoe1QEDmKXTHbOkC0xBa
 JdJ49hRLh3GDAr3XvXOYHBbKmWozOoAHtLECikPDCkFxR7NdAGsSmWfEM1WZzB2ZN5yC
 EA0oZuoODPGSXG4vdhNaSq98M34bnHF/HI+Yvj0NHA8xHoUol2hnBx5/9YCIxl10fezt
 FlyUGDBMedgtjU8W8o4P1dWRbcAfcc/1QwNIDPiurBRV7XEYuUnxSsK/xssaygj7xbMY Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djkdnu93k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 09:19:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20E9Ac5S169226;
 Fri, 14 Jan 2022 09:19:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by aserp3030.oracle.com with ESMTP id 3df0njb059-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 09:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNRz++DFL3hV6UX2EmK094I3W9a5/nrG2nkzqUIWvCBgPXRrjMFOb+b4B8DCnDe1/UJsMuR2OIvxjLukfdC/gsC55m11jHad0SPC/BI1apYyVOSYwwkwjHX3MqpAPm11I+6TkN/Gxm3i1fKKDL7BJx4J56r+mcSPMeEggMLB+yf/tSJak0y/lwpYPTyT9MWcpZUb1HqX+MVSD7C6fUCygmA8yF3sXeLCc2IhnWYqpLfUXCgFUO9CgKID8JoPcl41hPyX+v1+Q4TZ9v6EyFk9uKMhOFg1BXDNfsnrplmE8vNRrmd5HiZtIIcMB5PQrntxF12cnXYclqSDvb1Qwo29rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwJBGQJNlXvqg+yy/l238zMDLahR41va+y/lbRvSDL4=;
 b=jc38hKC8zjCFTZM3rc1PYDsy9KPyFA160MifYjR/EMIdE58Gr7RFUVujMtXoTaIZoXlV9PcfqKlNSM+0i914FzYp1ueu8k7TmVIv4eIb3dstbcuovc6QPGhoUZ7NgWZzlG0uQW/keStFJWmY2coatoYp0RLjhmtRhqZE471pp/lkniGcwWkezATzhhdnUvknHM4cYJraCGPpOWBFfPxqROiNtiWCrUFqpd8z04e6UzNm4JYJ6SRcCvTZhZQvomfikqsRB6iudIsHtnNtKhVtGKAZ9ZHt60o9Am1AeQeZWlOmISpePHStuRF1diblCzR2JoqJYtizjhDpLVElxx3f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwJBGQJNlXvqg+yy/l238zMDLahR41va+y/lbRvSDL4=;
 b=BYwVdNHDo3B4rQOdTzyJjbocUTkS8AHPWkqfO685hbqhMwhwu8w8HTN5haseCJz8hoDqO6v6cV7/OUfS35dhxS/umYAHf4hXVa6bKgdUwlN9wp5jE3+4u3LeUwkxQjbYhn/wvHfs/l3C7XexExsDhEEFgLBTTA5bXQg+diEFlxQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM6PR10MB3898.namprd10.prod.outlook.com (2603:10b6:5:1ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 09:19:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 09:19:54 +0000
Message-ID: <f636863f-89bb-2525-2aff-57bac07e3fc0@oracle.com>
Date: Fri, 14 Jan 2022 01:19:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] vdpa/mlx5: validate the queue pair value from driver
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-4-git-send-email-si-wei.liu@oracle.com>
 <20220113015815-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220113015815-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a7e794-b710-40d8-5472-08d9d73f06d9
X-MS-TrafficTypeDiagnostic: DM6PR10MB3898:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3898BBE9F9DA2ED5441A92F9B1549@DM6PR10MB3898.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dk8mjJJViuatDtHKaMcAYQYdcWzEfnMnKbL5gey8xRZN/t+lcxDQsNf3Kbcdi8w+a/DPbeIC5c3ZZHQnreON76feVQx+v73w12PFJ5HBqO7Fx+5RduftON/eXBzDK9i0vKAx1iJqbnJ+mlMdAhPuFao8PMKmtcWvV+NyP4HTjS/t4aP2ghsmVdzBb3kh1Vi6hpBBf4BXq05QG32RixEazafaVSRMqUgk4vPkyZ0LSs3c9CnV1Soewu1wcmPVjVHPXMWJ6jo15O/n/RVLNjAT82iqSvHN8FnU5BvhA0VHu2F1FgrgdJqF/bjNTXDEQG6rfHqX+iRq5PMRET+BYxbq1ing4M9F3ayjS1/KOMGewl/PkO2Al38lfvkAwmYLVV16m36zAGQxn0DlbWCmcukyF1yMfdGm5aIyD3bHGxabaHaZUxLtDdkzDX31l7T5NzA6bf0aLY409uB0I/2m7Jise3AZuQivfqNlFUji6PFdFisRHxdYl+BMAbqETXyXg7K7a1e60LcKj2eX6MmA3RzNF3hy703xBrUol4lePFoHfEx5AhlLPeu/uQHFqdWTVS6fStMiPaq1nZ7okbb+1QoX5EnWx8TjzyB8R344XNKPS9mNq7axToDLqdfzqjp9jQueVPuMspiFKBTrneiuNmmTJwJUgvH5JNtqeTspLo/WFXL2l1yftXGNRCRJ9b06VxSx2EzzyIeXfSAXsOkxafGGf8Ra9tH6ag7Tvx6QA+kToLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(186003)(8936002)(316002)(83380400001)(26005)(66476007)(8676002)(86362001)(4326008)(6916009)(38100700002)(36756003)(66946007)(6486002)(508600001)(2616005)(36916002)(31696002)(6666004)(53546011)(31686004)(5660300002)(6506007)(2906002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdKQUtwS0RJSExFSTZjWlFORkJhaHZjN3hBN1pjRXVDL1pNWkhJZFlFdjBl?=
 =?utf-8?B?K0hJNnNwWnQydnU5RUZ5Y3ZxZklidlBlL2tzc1FOQm0zUllWR0JteHpVWGoy?=
 =?utf-8?B?N3M4N2RIazg3RWM4SENXcU5VYnVhSDRWcDk0NThUUWZ5MnZHdW1CVmM0NFhS?=
 =?utf-8?B?bGM0WklrV2ZwVDk0TzZPOFNWZjNxMkczb2ZwVVdoQmtISkpQU2VUdnJmZUlE?=
 =?utf-8?B?MU9oVVozOTJDa3I5OFh1bE91aXhEdkwyR1cxMlRHSU8vSE1rNGFzYzljbndG?=
 =?utf-8?B?aFdQYlN5OGR4aU1DV21FMnNCdnVPTThDdU0zMHlPZHBTbkg1aHpKVkZzQjRJ?=
 =?utf-8?B?ZDdqZEtYMEh2V1NnejR5ZjBvaWc4TVdkcUYwamFmQ1p0cDA2d3g2S0RCTXI2?=
 =?utf-8?B?UkdwVHdwaFZqVkwxdWV3Q2lnVzE0TzlzT1dCVkJpQ0dmTUczU2RoZE5VWEtE?=
 =?utf-8?B?MEhSanBlVTFrbnViVVRNaHFveVlqQWtxQzBUYlhUSTVrOWZzb2JrRG9rNUFw?=
 =?utf-8?B?SzhzWDZGbjhYVldHcHJMMEV2Zm5nQ3JmcEs2a3FWdmhyR3pjcnk2ZkJOclV1?=
 =?utf-8?B?azc4UEhhMUxPWmxvV0dBa1d6bFhJVjFrT1puL2VpMEh0SUlMUXNQVXdnQWtJ?=
 =?utf-8?B?T0NKWjl1NWdTdmt0NVYvZ0xlcGhRQ0RQc25ybDJoOUdQbjNhWXI3RW5mcU4z?=
 =?utf-8?B?NUNZcXM2a1BYVXJZWjMrbzJTc1czeUh3R3dVZCttMXRVTFhiT1RQQU8ybnQv?=
 =?utf-8?B?OW9nbjZ2eDhMYmY3Wlp0Nk5lZFZ1WE11MUh5cXhpdkF1eW5rbVFWVG1DQncy?=
 =?utf-8?B?RXQ3eUtYSVNqeE9zS0NGWGh3TDlWT3puakF6SEpCUndxYUcyREVEUUNNb0dM?=
 =?utf-8?B?bTA2R2YzSk1mOW1iZHY5RjRBMXdDczBMRDNhQTlOMGkvZU1XcG40a3Q1SlBI?=
 =?utf-8?B?US9HL2hTSm9OZ0ROMUZiNzlFSEgxejNyZ2d4c0t3TDQ1cFNKYXNzMXk4V1Ri?=
 =?utf-8?B?Z1MxQ2ZMOUhMUE9pUUNHTk5IYURNcVpUZTdwckRHdDgzZHZHdDUrNHh5RTNN?=
 =?utf-8?B?ODNKU2hhK3g1MVA0SHBUU1hHZGV6T1Rzck8rRWRhNnpRYy8yays2ak1tSnU2?=
 =?utf-8?B?clVaK0NjYUxVMnBtRURTOW5oLzdaa0lTVzdBYmNxalEwb1N4VDdQOFhqNVFG?=
 =?utf-8?B?NDRCdGhmZkVSamVZdkJ5QVhYNlNEREVqc25CSHgwZk4vV0Y1YkxnZndvNWtI?=
 =?utf-8?B?YUZicHRSRTJDUytCYWI2YUs4TFRMVjZtRXRuZnZvbmVacDdJMjJpR2ZVa3JD?=
 =?utf-8?B?QWtVOEt2K0tOWVhQSHUxVG1TOGpyQytIZzJ6MWxnNk5JdjNBQmt3U1ZkNnc5?=
 =?utf-8?B?b2xvclFsSmxyOW9sTThwSThaMWh3QTdHUEtCZ2pMVUp4cnZVSUVSSnJWVGE0?=
 =?utf-8?B?SUJuZjN5eFZKNnpUc2hCYXZqbURyRkNGWHFEVnAzT2xJTW0vejVEMlo3M1pR?=
 =?utf-8?B?Z1VWR0dXbUsxai9JUlphRmh5bVZWU2ozSWM4MXhRYWlHdlhxa01yT1VFZkQ3?=
 =?utf-8?B?YVZYQjVUbXZWbHBySGs4VS84ZlcrWTBNdTZQVkw0cXZyQUtFeVFHNE5xMkVu?=
 =?utf-8?B?R1J6dXZXOGNaZ1lZdEt6NVZ5UnkxZEhJTnBXN0lJOVF3STNub1RaK2UrYklM?=
 =?utf-8?B?SHg4cnlHem9POHlkMjU3SkNOLys3OWt0dm94S3NTMURud0xuT01uQkwxTHdo?=
 =?utf-8?B?ODRTdzJkbmthUVpuZ3FmU2FEU3pwOVFrUEhBSDl3dFF3MURhV1NwTXJqb1JY?=
 =?utf-8?B?MThaaURwQXVTQ1RFT0c3cGhuTWR6eSs4WEJIN2MrWlhwSW9MYk5oaTE4WC9J?=
 =?utf-8?B?UVBqT1JiOTdiUkZCNS9Ka09wb05YL1lRQ3YrRW1EVXc5VlY2eHBmWDhCTUZF?=
 =?utf-8?B?RlNpelUydGpya1lJMEpmZUxnTW9xRi9pVFMxMlRRNXk2RGVjUlV1dTJrblZt?=
 =?utf-8?B?TFNITXgrcnRQM3JNV3pNaGc1MFZVWEtmYzNYZFhzWnlXeWV4Y282enNVbzRZ?=
 =?utf-8?B?cFExbG5BRjUwcmhVYTN3ZjRoVXF1MGJQWnpHNmpxZjQ2T2crT05PSG1zZ1lG?=
 =?utf-8?B?cjVKdTBYQk5LWXRSWVdnd2h5RTQ5YXkxaTJCQjVxMkpHb2VQYWw0dFpGZzNp?=
 =?utf-8?Q?q8Y7CJq6ZEiWf0ViHgE1/lg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7e794-b710-40d8-5472-08d9d73f06d9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 09:19:54.9328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yb6yMuKvUfQW+TmOCOY9Yf0DrRuGqs6eH36E4J+Y/UmmA3ytO7AGkUGeYS5eHLDX2VHXQtRTfLtPQ85Ls2Dj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3898
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140062
X-Proofpoint-GUID: mjIzGgubG5msw045D2J2WHBc3VnUgo-w
X-Proofpoint-ORIG-GUID: mjIzGgubG5msw045D2J2WHBc3VnUgo-w
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 1/12/2022 11:00 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 13, 2022 at 12:10:51AM -0500, Si-Wei Liu wrote:
>> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
> Add motivation for change in the commit log.
>
>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 46d4deb..491127f 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1563,11 +1563,21 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>>   
>>   	switch (cmd) {
>>   	case VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET:
>> +		/* This mq feature check aligns with pre-existing userspace implementation,
>> +		 * although the spec doesn't mandate so.
> And so ... why do we bother? what breaks if we don't?
Without it, a malicious driver could fake a config multiqueue request 
down to a non-mq backend that may cause kernel to panic due to 
uninitialized resources for the queue. Even with a well behaving guest 
driver, it is not expected to allow such kind of change.
>
>> +		 */
>> +		if (!MLX5_FEATURE(mvdev, VIRTIO_NET_F_MQ))
>> +			break;
>> +
>
> this part is not described in the commit log at all.
> is it intentional?

No, I can add it.
>
>>   		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&mq, sizeof(mq));
>>   		if (read != sizeof(mq))
>>   			break;
>>   
>>   		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
>> +		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>> +		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
>> +			break;
>> +
>>   		if (ndev->cur_num_vqs == 2 * newqps) {
>>   			status = VIRTIO_NET_OK;
>>   			break;
>> -- 
>> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
