Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6DBC4332F
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 01:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB0648332A;
	Fri,  7 Jan 2022 01:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiA_XNqmKjHb; Fri,  7 Jan 2022 01:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8915F83323;
	Fri,  7 Jan 2022 01:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE82C002F;
	Fri,  7 Jan 2022 01:50:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03FA7C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D21334299D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="UUcVbS3w";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="RsRY3gYE"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NIiJ5uZ83iwk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:50:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97C0A4299A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:50:36 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206KwnjZ009310; 
 Fri, 7 Jan 2022 01:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=asb0pEnfxEvKHB3H3u6KHKn27OQeC6V7PET7/WgoDe8=;
 b=UUcVbS3wpn/+tdfkNBeckDi8mdhCM1i2mntBdTVG/fX7Pa+0NynhXJS1DqqrOJRyZvK0
 bsFYiCVShIl1moalto3t9+ajaRo/FbxsksaXmNlyWWdR7m1Y93kDAn3Y0n0SDXo9TiFK
 I/5JCsJuByohHNfJvGVHAr4jZFBWQQE7Quzht/WRc7Si8UEMPVEsdOwlxlpMwSxQc8LW
 Bi8hWTT4hJD+zcxz0XcS+N/zOtWX/PxoCJN4kA7KlhvwyI6sSygqPzrRduB2MJ5Gp7sy
 OxG8qSHbCo0lZPIoYazjBVCziFWtax20AHOjTORxjXIGz73TQfYR1/sbgQ43f0Rs5QZu UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh8vf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:50:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2071jrJW025878;
 Fri, 7 Jan 2022 01:50:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by userp3030.oracle.com with ESMTP id 3de4vwyafs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue3EE1m9CFeaXKatuaZfcTmo7HY0nf0SIBNusDU+qZdSUe/dfMpHeej09r2FEN7s+5xcysD4ieR42fs7mm+ZuZyhHCvarkJFushr9Uo3/42KtwJIg8pE0Pdwwjy3nT0SSIpGXvvhVfLrhdTROWsQsBApHf9GMRcIa+PEzrrp5f6Bh0OYJ+nwWpCrnaLdohA1fYK6fmdvFnS6HOjTOcKmbCvmjy/14Agv/xq8xtB9oU1Bg+GZ2rYnRa/6PHsEZ8T5fI38CTIHYg2hCsbgUyRgSeJjUn5XN0jhSSKaXsCPFUj6LyWXjAXjYy21OViUyAUSB/nvYiMRvz/MYAtr+Wchrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asb0pEnfxEvKHB3H3u6KHKn27OQeC6V7PET7/WgoDe8=;
 b=G8IDqGu7pfe4uoRCd5p9sdhLH1tg1snPPIVpr4lChJZ9NTxOOcexPj8ta922ZOFTOotT8sFFgdjQWeKdXU6LzoVf6o08HyrXpUvRDl0VPFH+kjElOLioCPFMOT50RVTZunVXNDFrSxG5jnkNr3QXrO2ItoIDrxLoE/wxpOGt2jvhi2GyL8o5t5OreOdHOUvM0H4ZUdHTZe71c6xkDHw93xKYI/z0i5HzowGnRTYpAgLmJVVW8MdVTOffJ1uib3i23WG9gFJBsN0wQGpyViGg0Bi/1Svnd+gfAuyql4kRiz8YfDjvBA4a26/dsj9xgZA2riJYIYWNcmv2opOtwK046A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asb0pEnfxEvKHB3H3u6KHKn27OQeC6V7PET7/WgoDe8=;
 b=RsRY3gYENJIHreCepD1kOiciry290tsIE0/iCDYuLtZCgXjTKK+kwTAeSWnsq4etJ5m672az+6qs72cUdEIN8oVVbGOBuZag9dbIQDlqfo/r4sNpuJQDH6PctnusuzmX0qxHM+lmU8Hknp8lO2oj1zIf6xHh0LoifvyKijSw4es=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3477.namprd10.prod.outlook.com (2603:10b6:a03:128::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 01:50:30 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 01:50:30 +0000
Message-ID: <3205e802-a982-fbe2-511e-f5c28fc19b36@oracle.com>
Date: Thu, 6 Jan 2022 17:50:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031ca5ad-48d0-49ba-9564-08d9d18015a9
X-MS-TrafficTypeDiagnostic: BYAPR10MB3477:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3477C8FC8E16EA5B1AE3729BB14D9@BYAPR10MB3477.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNWcGUeNNcaoLDMQ1qXRfVxywS38B/83wTZWSpvOj8H1LZO48ja4gLcHmk7qPsNGBIR1cByRkMHy8wmODTZw5YufMiLXH7P8MHsbF+PJAe7m3wEtn5j7wP/NFtBndr+bYDdngendsrU088IYG+/JerG4CWL5jaQkjVjY8wwNrYiIlo8M3FDW9doWfhKLAbWcr8FQKxAQLRP7Pe9gQ0mPchynfIkMRiNjXPK3NTzzGAei4pb6jhra4/I1IglQWn34irgAeu+zf6Er8igub2RBPQeNf1B/ZwH4fg8HEKBsrvcalmnHV9U5j3J+rDUoeO/YepB4U8JvyKKXUJk659syUa7u7tm/d2lOY8b6Q4uHuUC/mNZw43g9VMj//KBNP6bejF5h8Z4RubinHpNXczGQW6RrrILIb+D2sVE4hUsNrXgovStSmONhpVO3kqeu92ISYXCbx29/eGtrkjUhIYJVuCeWspoYc6c2jANuJiLUYNvyvMIlQGsIMjVTq1CoTxhfADdgBJy1tJ/gf6gCekLl9c6O3Kb9x21+KbHmNZOslLNGDfFeVnMcAK3OadxqK3m5oiFXMyPTE65FdLk2tvl1ce6kKFgK8cxmxt1WQGXRUFcLH76DyXM2sDvaJ3xoFO3tCfmZaUuYGSnj7RHQ5Uw+sYINGIVB9Ss7LbRl9fdnbDSNCtb7cxe01DOzMkpSP9zQm1q15M7ZBmWN0U1rd9F6YVfO2TMcMg8gnN+dnn15Hd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(66476007)(6486002)(66556008)(2906002)(186003)(6512007)(53546011)(66946007)(6506007)(4326008)(6666004)(508600001)(38100700002)(8936002)(83380400001)(8676002)(31686004)(316002)(36916002)(36756003)(86362001)(5660300002)(31696002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0dzbWx3YjMxVjZHMDRYcFR6b1VMMktPendVK2Q4RGNMendRdEpCRjE4dFpX?=
 =?utf-8?B?eDVJU2tQMnozd3FIcWVHQi9ZSGYvanMzWm1pOUVmbm15d2REQVVaQVBGQ2ZW?=
 =?utf-8?B?b3ZMcU03ZmlFTDUya0FLVUNPbUIzM0dzUDg0R2xqVWpOZFhJV254aUZuV3Zv?=
 =?utf-8?B?ZU8wYVpiT1NvS1U3VmlaNVllVDNSMC9NSy94ZDFoaGtuNFJVRnVxVkxxK3Zt?=
 =?utf-8?B?ZzFoSGsrWXN2b25lOVZKeExpcE1kWDgyQ2hGRFJVQ1J5bzBQbVUyVWFxQkFs?=
 =?utf-8?B?a3dJTlZ6alIza2svWmNYWnEwbjZSNmdVK1QraTBBV1EreHBnM1ZJUlY0c2s4?=
 =?utf-8?B?NHlvQmFkd21CajIxMGQzaE0vNjFHMEF4U1BNNFE0dE5yM2RvbEtJL1dwaENk?=
 =?utf-8?B?cmp5YitQOS9SdnpzYngvUEVpM3lsRWI5NlFUVzV2dkJ0eG9IU3hnN0JOclZp?=
 =?utf-8?B?TDdVeDZ6aTY2T0FGaTV5amdoVU1oOVpIRGJaK0wrT3VJUVhnNmIrdGcvWTRo?=
 =?utf-8?B?RkQ2Q0E2bTArTFRSbUllaHNid2w1ZHZxd2lSVngvd0l4aGJJbWRuRUhjcUl1?=
 =?utf-8?B?azlYcVBjc01wUDhzOEp1UWVJZ0Vqa005SUpqWktlamowcHZDNzBjdkRxQm5G?=
 =?utf-8?B?TlFFNTZPc1o0OEFUc3VqSkUyOG5WdDFVd1A4dFQ3V1RZbExGcW0rcmh1TXJj?=
 =?utf-8?B?dzE4NkpHZThBVkRQYURrblp0SnM5aWF2bFY1VkVBckdPbUZUR3pHWUZnZDNK?=
 =?utf-8?B?a05yRHNDR2RvVEpxM1NCempKSktYRWJ2TGx2cXV1R2NGUTBVN3h5ZzdBY2pS?=
 =?utf-8?B?a09xOHNEWUtyeUhMUHlvbVN1eXVtOFNxMDBMbGE1aWpmb0FVTktscGtmMG54?=
 =?utf-8?B?aDlCQUVobkRjakwvdTU3b2NSNk1pN1JiRkF2V2FKTjY2L2tmRW5tY1hhUXNI?=
 =?utf-8?B?amd4a1VuU3pOeXhDcnZJM2dPd0QzUGRLQ1V1a3VxZWFvcEZqQjJWRVZSM3Iw?=
 =?utf-8?B?M2NZUFRPY2Q0TnBFNEdsYXQ5Y1Y4OWlGUU1aUjR0SXZkanhYajVUUmhLZ2tj?=
 =?utf-8?B?OWNzbkliZ1J4S2MrcmUwdDJvQlhFZEQxSFZsT2RWclNCV1ArSXlaK1ZrZUlr?=
 =?utf-8?B?RmNobldYOG9KVnE1WFM0alNvdmVFK0U5cUFPbTM5NjBkVDBPbXE1WGRud1ll?=
 =?utf-8?B?cVVNR1ZxaFRIWVovKy9Ed3JqdVA1cFVPNGdURk5RQ2hIeHY4YzJ4UjQyNVYz?=
 =?utf-8?B?SzBCM0QzWHQ3QThidUo3VkdiRi9kanVFeWswZkVVYjNzeE5wUVJhbSt0bFNF?=
 =?utf-8?B?NEpONGFxeEc2WTJGR2hUTmxSQzgzT1N5by90M2pZVUx2a0VpM21TTmhZV1dK?=
 =?utf-8?B?cmpFYkJhc0ZQSFVCa3pHWXViaGJzWVBDQWhhUFVscVVEK3NjOWFXbWEyTmFJ?=
 =?utf-8?B?cldSWG55bitkbjlOenhNcllIbGVIMTB3S3RSZFp3eDRHWXlNb1NBYnNabWEv?=
 =?utf-8?B?UW5hV05xOHJSUnRtQ1dVamxuN2FES3YxRDVvcGxCNG9pdy9LYkJxaDI0OUox?=
 =?utf-8?B?ZXdYTytDYnN2WjNHM29kL1VzNHhnRHo0TlBuNkVJTzFyOGtCQVR2UkRrYm00?=
 =?utf-8?B?bkRmUW5pa09PVWJFWVRkUDUxZnE5bmMvUFBkcmsvWlJ6OUUvOGhVOVF2S1Fm?=
 =?utf-8?B?Q2dPTzArUHBsaU04cmlRMjRuL01RMExnWUlCd1NkUGdwNmRubmdFUm9zNXJq?=
 =?utf-8?B?akJwNkJtNy9ZVmlIbjNKSlFtZ1VGL2Rzc2Z5cnFOdXl2OHpyK2JsYU9iRjRT?=
 =?utf-8?B?ai9pTlZHV0RjZmMrKzVZUzJYZ3I5L2QvRVR2YXhKOGsxT2VEYUxzRThOTmdp?=
 =?utf-8?B?NmllUGdya1RpaEhuTDRUblNJUEdFQktLVW1yZ2kyem5XWm4zL2xQYU8rUFVl?=
 =?utf-8?B?QXhxZCtYTnh0ZUtkRGNYUzN4TlBFL3Y5WFhrSnU0L0FjUndzbEVuVmNKR0hB?=
 =?utf-8?B?SVJxRm9LQkdEQkhuRkdMRnIzOGx5VkZJc2JrczN0NnBmVDVZOFlzSjQzNWFN?=
 =?utf-8?B?Z0J2ODNvZFFJVVk1Tmw0OWJMZFErZXg2ZzRaVTI4TGZ4OVNqcXJKZjRSRVRw?=
 =?utf-8?B?eWRINjQ3dUFJTzRjSko1RGdTMjNvOHBEem8zcjM3Ujc4WEhQc01ENUdVNUVK?=
 =?utf-8?Q?L8ifZZ+YVvGLWy7UXDx4wJ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031ca5ad-48d0-49ba-9564-08d9d18015a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 01:50:30.0496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4xh8rclWJacY4gToCquRGSejf/e0epSnHqA6CEpk+5yqDq0IUxi7AAo0A4cCcmdiW3CZOy6UXCY1XHjICPn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3477
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070009
X-Proofpoint-ORIG-GUID: IAU5bmJaZvNKPfzq9U4siVMKKHyDaF5Z
X-Proofpoint-GUID: IAU5bmJaZvNKPfzq9U4siVMKKHyDaF5Z
Cc: lvivier@redhat.com, eperezma@redhat.com
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

CgpPbiAxLzYvMjAyMiA1OjI3IFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiAxLzUvMjAy
MiAzOjQ2IEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+IENoZWNrIHdoZXRoZXIgdGhlIG1heCBudW1i
ZXIgb2YgZGF0YSB2aXJ0cXVldWUgcGFpcnMgd2FzIHByb3ZpZGVkIHdoZW4gYQo+PiBhZGRpbmcg
YSBuZXcgZGV2aWNlIGFuZCB2ZXJpZnkgdGhlIG5ldyB2YWx1ZSBkb2VzIG5vdCBleGNlZWQgZGV2
aWNlCj4+IGNhcGFiaWxpdGllcy4KPj4KPj4gSW4gYWRkaXRpb24sIGNoYW5nZSB0aGUgYXJyYXlz
IGhvbGRpbmcgdmlydHF1ZXVlIGFuZCBjYWxsYmFjayBjb250ZXh0cwo+PiB0byBiZSBkeW5hbWlj
YWxseSBhbGxvY2F0ZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPgo+PiAtLS0KPj4gdjYgLT4gdjc6Cj4+IDEuIEV2YWx1YXRlIFJRVCB0YWJsZSBzaXpl
IGJhc2VkIG9uIGNvbmZpZy5tYXhfdmlydHF1ZXVlX3BhaXJzLgo+Pgo+PiDCoCBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAK
Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXggNGEyMTQ5Zjcw
ZjFlLi5kNDcyMDQ0NGJmNzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4g
QEAgLTEzMSwxMSArMTMxLDYgQEAgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgewo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBtbHg1X3ZxX3Jlc3RvcmVfaW5mbyByaTsKPj4gwqAgfTsKPj4gwqAgLS8q
IFdlIHdpbGwgcmVtb3ZlIHRoaXMgbGltaXRhdGlvbiBvbmNlIG1seDVfdmRwYV9hbGxvY19yZXNv
dXJjZXMoKQo+PiAtICogcHJvdmlkZXMgZm9yIGRyaXZlciBzcGFjZSBhbGxvY2F0aW9uCj4+IC0g
Ki8KPj4gLSNkZWZpbmUgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyAxNgo+PiAtCj4+IMKgIHN0YXRp
YyBib29sIGlzX2luZGV4X3ZhbGlkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTE2IGlk
eCkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShpZHggPiBtdmRldi0+bWF4X2lk
eCkpCj4+IEBAIC0xNDgsOCArMTQzLDggQEAgc3RydWN0IG1seDVfdmRwYV9uZXQgewo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2IG12ZGV2Owo+PiDCoMKgwqDCoMKgIHN0cnVjdCBt
bHg1X3ZkcGFfbmV0X3Jlc291cmNlcyByZXM7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnIGNvbmZpZzsKPj4gLcKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB2
cXNbTUxYNV9NQVhfU1VQUE9SVEVEX1ZRU107Cj4+IC3CoMKgwqAgc3RydWN0IHZkcGFfY2FsbGJh
Y2sgZXZlbnRfY2JzW01MWDVfTUFYX1NVUFBPUlRFRF9WUVMgKyAxXTsKPj4gK8KgwqDCoCBzdHJ1
Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqdnFzOwo+PiArwqDCoMKgIHN0cnVjdCB2ZHBhX2NhbGxi
YWNrICpldmVudF9jYnM7Cj4+IMKgIMKgwqDCoMKgwqAgLyogU2VyaWFsaXplIHZxIHJlc291cmNl
cyBjcmVhdGlvbiBhbmQgZGVzdHJ1Y3Rpb24uIFRoaXMgaXMgCj4+IHJlcXVpcmVkCj4+IMKgwqDC
oMKgwqDCoCAqIHNpbmNlIG1lbW9yeSBtYXAgbWlnaHQgY2hhbmdlIGFuZCB3ZSBuZWVkIHRvIGRl
c3Ryb3kgYW5kIGNyZWF0ZQo+PiBAQCAtMTIxOCw3ICsxMjEzLDcgQEAgc3RhdGljIHZvaWQgc3Vz
cGVuZF92cXMoc3RydWN0IG1seDVfdmRwYV9uZXQgCj4+ICpuZGV2KQo+PiDCoCB7Cj4+IMKgwqDC
oMKgwqAgaW50IGk7Cj4+IMKgIC3CoMKgwqAgZm9yIChpID0gMDsgaSA8IE1MWDVfTUFYX1NVUFBP
UlRFRF9WUVM7IGkrKykKPj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbmRldi0+bXZkZXYubWF4
X3ZxczsgaSsrKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3VzcGVuZF92cShuZGV2LCAmbmRldi0+
dnFzW2ldKTsKPj4gwqAgfQo+PiDCoCBAQCAtMTI0NCw4ICsxMjM5LDE0IEBAIHN0YXRpYyBpbnQg
Y3JlYXRlX3JxdChzdHJ1Y3QgbWx4NV92ZHBhX25ldCAKPj4gKm5kZXYpCj4+IMKgwqDCoMKgwqAg
dm9pZCAqaW47Cj4+IMKgwqDCoMKgwqAgaW50IGksIGo7Cj4+IMKgwqDCoMKgwqAgaW50IGVycjsK
Pj4gK8KgwqDCoCBpbnQgbnVtOwo+PiDCoCAtwqDCoMKgIG1heF9ycXQgPSBtaW5fdChpbnQsIE1M
WDVfTUFYX1NVUFBPUlRFRF9WUVMgLyAyLAo+PiArwqDCoMKgIGlmICghKG5kZXYtPm12ZGV2LmFj
dHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkpCj4+ICvCoMKgwqDCoMKg
wqDCoCBudW0gPSAxOwo+PiArwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgIG51bSA9IGxl
MTZfdG9fY3B1KG5kZXYtPmNvbmZpZy5tYXhfdmlydHF1ZXVlX3BhaXJzKTsKPj4gKwo+PiArwqDC
oMKgIG1heF9ycXQgPSBtaW5fdChpbnQsIHJvdW5kdXBfcG93X29mX3R3byhudW0pLAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxIDw8IE1MWDVfQ0FQX0dFTihuZGV2LT5tdmRldi5tZGV2
LCBsb2dfbWF4X3JxdF9zaXplKSk7Cj4+IMKgwqDCoMKgwqAgaWYgKG1heF9ycXQgPCAxKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+PiBAQCAtMTI2Miw3ICsxMjYz
LDcgQEAgc3RhdGljIGludCBjcmVhdGVfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+
PiDCoMKgwqDCoMKgIE1MWDVfU0VUKHJxdGMsIHJxdGMsIHJxdF9tYXhfc2l6ZSwgbWF4X3JxdCk7
Cj4+IMKgwqDCoMKgwqAgbGlzdCA9IE1MWDVfQUREUl9PRihycXRjLCBycXRjLCBycV9udW1bMF0p
Owo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDAsIGogPSAwOyBpIDwgbWF4X3JxdDsgaSsrLCBqICs9
IDIpCj4+IC3CoMKgwqDCoMKgwqDCoCBsaXN0W2ldID0gY3B1X3RvX2JlMzIobmRldi0+dnFzW2og
JSAKPj4gbmRldi0+bXZkZXYubWF4X3Zxc10udmlydHFfaWQpOwo+PiArwqDCoMKgwqDCoMKgwqAg
bGlzdFtpXSA9IGNwdV90b19iZTMyKG5kZXYtPnZxc1tqICUgKDIgKiBudW0pXS52aXJ0cV9pZCk7
Cj4gR29vZCBjYXRjaC4gTEdUTS4KPgo+IFJldmlld2VkLWJ5OiBTaS1XZWkgTGl1PHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPgpBcG9sb2dpZXMgdG8gcmVwbHkgdG8gbXlzZWxmLiBJdCBsb29rcyB0
byBtZSB3ZSBuZWVkIHRvIHNldCBjdXJfbnVtX3ZxcyAKdG8gdGhlIG5lZ290aWF0ZWQgbnVtIG9m
IHF1ZXVlcy4gT3RoZXJ3aXNlIGFueSBzaXRlIHJlZmVyZW5jaW5nIApjdXJfbnVtX3ZxcyB3b24n
dCB3b3JrIHByb3Blcmx5LiBGdXJ0aGVyLCB3ZSBuZWVkIHRvIHZhbGlkYXRlIApWSVJUSU9fTkVU
X0ZfTVEgaXMgcHJlc2VudCBpbiBoYW5kbGVfY3RybF9tcSgpIGJlZm9yZSBjaGFuZ2luZyB0aGUg
Cm51bWJlciBvZiBxdWV1ZSBwYWlycy4KClNvIGp1c3QgZGlzcmVnYXJkIG15IHByZXZpb3VzIFIt
YiBmb3IgdGhpcyBwYXRjaC4KClRoYW5rcywKLVNpd2VpCgoKPgo+PiDCoCDCoMKgwqDCoMKgIE1M
WDVfU0VUKHJxdGMsIHJxdGMsIHJxdF9hY3R1YWxfc2l6ZSwgbWF4X3JxdCk7Cj4+IMKgwqDCoMKg
wqAgZXJyID0gbWx4NV92ZHBhX2NyZWF0ZV9ycXQoJm5kZXYtPm12ZGV2LCBpbiwgaW5sZW4sIAo+
PiAmbmRldi0+cmVzLnJxdG4pOwo+PiBAQCAtMjIyMCw3ICsyMjIxLDcgQEAgc3RhdGljIGludCBt
bHg1X3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlIAo+PiAqdmRldikKPj4gwqDCoMKgwqDC
oCBjbGVhcl92cXNfcmVhZHkobmRldik7Cj4+IMKgwqDCoMKgwqAgbWx4NV92ZHBhX2Rlc3Ryb3lf
bXIoJm5kZXYtPm12ZGV2KTsKPj4gwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+
PiAtwqDCoMKgIG1lbXNldChuZGV2LT5ldmVudF9jYnMsIDAsIHNpemVvZihuZGV2LT5ldmVudF9j
YnMpKTsKPj4gK8KgwqDCoCBtZW1zZXQobmRldi0+ZXZlbnRfY2JzLCAwLCBzaXplb2YoKm5kZXYt
PmV2ZW50X2NicykgKiAKPj4gKG12ZGV2LT5tYXhfdnFzICsgMSkpOwo+PiDCoMKgwqDCoMKgIG5k
ZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IDA7Cj4+IMKgwqDCoMKgwqAgKyttdmRldi0+Z2Vu
ZXJhdGlvbjsKPj4gwqDCoMKgwqDCoCBpZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVt
X3VpZF8wKSkgewo+PiBAQCAtMjI5Myw2ICsyMjk0LDggQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBh
X2ZyZWUoc3RydWN0IHZkcGFfZGV2aWNlIAo+PiAqdmRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKg
wqDCoMKgwqAgbWx4NV92ZHBhX2ZyZWVfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4+IMKgwqDC
oMKgwqAgbXV0ZXhfZGVzdHJveSgmbmRldi0+cmVzbG9jayk7Cj4+ICvCoMKgwqAga2ZyZWUobmRl
di0+ZXZlbnRfY2JzKTsKPj4gK8KgwqDCoCBrZnJlZShuZGV2LT52cXMpOwo+PiDCoCB9Cj4+IMKg
IMKgIHN0YXRpYyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSAKPj4gbWx4NV9nZXRfdnFf
bm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkKPj4gQEAgLTI1
MzgsMTUgKzI1NDEsMzMgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgCj4+
IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIC3CoMKgwqAg
Lyogd2Ugc2F2ZSBvbmUgdmlydHF1ZXVlIGZvciBjb250cm9sIHZpcnRxdWV1ZSBzaG91bGQgd2Ug
Cj4+IHJlcXVpcmUgaXQgKi8KPj4gwqDCoMKgwqDCoCBtYXhfdnFzID0gTUxYNV9DQVBfREVWX1ZE
UEFfRU1VTEFUSU9OKG1kZXYsIAo+PiBtYXhfbnVtX3ZpcnRpb19xdWV1ZXMpOwo+PiAtwqDCoMKg
IG1heF92cXMgPSBtaW5fdCh1MzIsIG1heF92cXMsIE1MWDVfTUFYX1NVUFBPUlRFRF9WUVMpOwo+
PiArwqDCoMKgIGlmIChtYXhfdnFzIDwgMikgewo+PiArwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4o
bWRldi0+ZGV2aWNlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIlZCB2aXJ0cXVldWVz
IGFyZSBzdXBwb3J0ZWQuIEF0IGxlYXN0IDIgYXJlIHJlcXVpcmVkXG4iLAo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1heF92cXMpOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdB
SU47Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqAgaWYgKGFkZF9jb25maWctPm1hc2sgJiBC
SVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQKSkgewo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKGFkZF9jb25maWctPm5ldC5tYXhfdnFfcGFpcnMgPiBtYXhfdnFzIC8gMikKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICvCoMKgwqDCoMKgwqDCoCBt
YXhfdnFzID0gbWluX3QodTMyLCBtYXhfdnFzLCAyICogCj4+IGFkZF9jb25maWctPm5ldC5tYXhf
dnFfcGFpcnMpOwo+PiArwqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBtYXhfdnFz
ID0gMjsKPj4gK8KgwqDCoCB9Cj4+IMKgIMKgwqDCoMKgwqAgbmRldiA9IHZkcGFfYWxsb2NfZGV2
aWNlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0LCBtdmRldi52ZGV2LCAKPj4gbWRldi0+ZGV2aWNlLCAm
bWx4NV92ZHBhX29wcywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5h
bWUsIGZhbHNlKTsKPj4gwqDCoMKgwqDCoCBpZiAoSVNfRVJSKG5kZXYpKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIobmRldik7Cj4+IMKgICvCoMKgwqAgbmRldi0+dnFzID0g
a2NhbGxvYyhtYXhfdnFzLCBzaXplb2YoKm5kZXYtPnZxcyksIEdGUF9LRVJORUwpOwo+PiArwqDC
oMKgIG5kZXYtPmV2ZW50X2NicyA9IGtjYWxsb2MobWF4X3ZxcyArIDEsIHNpemVvZigqbmRldi0+
ZXZlbnRfY2JzKSwgCj4+IEdGUF9LRVJORUwpOwo+PiArwqDCoMKgIGlmICghbmRldi0+dnFzIHx8
ICFuZGV2LT5ldmVudF9jYnMpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IC1FTk9NRU07Cj4+
ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKg
wqAgbmRldi0+bXZkZXYubWF4X3ZxcyA9IG1heF92cXM7Cj4+IMKgwqDCoMKgwqAgbXZkZXYgPSAm
bmRldi0+bXZkZXY7Cj4+IMKgwqDCoMKgwqAgbXZkZXYtPm1kZXYgPSBtZGV2Owo+PiBAQCAtMjYy
Nyw2ICsyNjQ4LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgCj4+IHZk
cGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIG1seDVfbXBmc19kZWxfbWFjKHBmbWRldiwgY29uZmlnLT5tYWMpOwo+PiDCoCBlcnJfbXR1
Ogo+PiDCoMKgwqDCoMKgIG11dGV4X2Rlc3Ryb3koJm5kZXYtPnJlc2xvY2spOwo+PiArZXJyX2Fs
bG9jOgo+PiDCoMKgwqDCoMKgIHB1dF9kZXZpY2UoJm12ZGV2LT52ZGV2LmRldik7Cj4+IMKgwqDC
oMKgwqAgcmV0dXJuIGVycjsKPj4gwqAgfQo+PiBAQCAtMjY2OSw3ICsyNjkxLDggQEAgc3RhdGlj
IGludCBtbHg1dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAKPj4gKmFkZXYsCj4+IMKg
wqDCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYub3BzID0gJm1kZXZfb3BzOwo+PiDCoMKgwqDCoMKgIG1n
dGRldi0+bWd0ZGV2LmRldmljZSA9IG1kZXYtPmRldmljZTsKPj4gwqDCoMKgwqDCoCBtZ3RkZXYt
Pm1ndGRldi5pZF90YWJsZSA9IGlkX3RhYmxlOwo+PiAtwqDCoMKgIG1ndGRldi0+bWd0ZGV2LmNv
bmZpZ19hdHRyX21hc2sgPSAKPj4gQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQURE
Uik7Cj4+ICvCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYuY29uZmlnX2F0dHJfbWFzayA9IAo+PiBCSVRf
VUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKSB8Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdf
TUFYX1ZRUCk7Cj4+IMKgwqDCoMKgwqAgbWd0ZGV2LT5tYWRldiA9IG1hZGV2Owo+PiDCoCDCoMKg
wqDCoMKgIGVyciA9IHZkcGFfbWdtdGRldl9yZWdpc3RlcigmbWd0ZGV2LT5tZ3RkZXYpOwo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
