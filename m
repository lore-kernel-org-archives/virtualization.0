Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 09:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8759760DC6;
	Tue, 11 Jan 2022 09:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id klv--MShiCtq; Tue, 11 Jan 2022 09:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A89D606CB;
	Tue, 11 Jan 2022 09:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FDD6C0030;
	Tue, 11 Jan 2022 09:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A06C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D846081341
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="eue9Dc7b";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="KQsmfJx4"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmspjE25pOt1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A85981337
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:31:38 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8dOs7021115; 
 Tue, 11 Jan 2022 09:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xdiQj205pOvt0tHVcSLVBkZr/ivrCqNSGnvyRVemDu4=;
 b=eue9Dc7bEKZ+IQiiwjJMpojB0ftgQ5D/owrXXW+/Kjqs3O3eTk0SQL6+wrVeeWBgeQNU
 eAiu0OdwRy5HAsQK8KH/9wNGIqC5j1CjMG0cJsgmh6vAHjJgFozMB+vPrDSe68ZGkUHv
 sC4Gfu28N2uMKc+agKsEiAbzOedaM7vGXAERzwVO/asVa1XQJ0iy4hTSFT39FQuYg8+S
 vmzpncL+vWaQKFMVUxgiovmHR6A2aa/eWwVgdGGOIpUs/wh+B4ZJos2yjnS1hgNH1/Zy
 jWwVHXvOFrwuFcUqAFEBZwwBqtDY/vANmQ6NamVq/WGpWhVaPK/1BeRa1FJY+JsbBwxm WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7njcey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:31:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9A6sN053712;
 Tue, 11 Jan 2022 09:31:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by userp3030.oracle.com with ESMTP id 3deyqwtny3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO6Tg63YlmAXC0S8pvYGp/dqRq9EnM8q1TgZtwWmDJYYDuhQyzPWBNrBU2fb5fuIoCWd7AhqjMqjCDkSfS3PhXMWlpTyKMoRAb1K1CZMcQauiP7a/TOoiax2ESr8hsvVnrgWsxjWxdS0bsH9DLCWHgbjl0WOhAKxB0x9yrdJwcI3Svy8hf6Win+lavsdll5WLdwn6I+FMFdVUwRX7SpMmRdXq0id2bCXyyDzDMid4MEFVGeLoWVqxyWuWuzEjWtpG9RuS+WGluT2PGvSr7L0+HnU36xhXg5Z8N3EZLeC5q5GPXqFjyhMD45y1w4cJJLeRQ/xQ4hwnj2Gg7Pm2jpAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdiQj205pOvt0tHVcSLVBkZr/ivrCqNSGnvyRVemDu4=;
 b=jOFyyNgVkfByT2Gda1/Bjv/ZieyuP+ge0ZOcjbCXe3wcVnCOnGzDgkW37QPIJccXfX494S3Vy/XTs/a5ySo7WVZ2Jguj40rSVPCG83QwPk5QxXuF/f+8vyVR2znyMb96p9aHMm/VcW6osJnNpnIk9vdNOUcbbcA34IV3uchyjnNCnPqinfetTcULEOFL6bvykrPewx9fiQU+w4bQy/tzK5bzI7Uv5Ij975Fx166zJAjFhbIlAA+aZzzXUY+jHgQfHmpAeVsF3sXRFIAWWts4KZkGsCzHEZJpTKiFdaop5M8rIivl6bh0HjZnGz5+9oZch5A7FCZyk8NSIeh0fK408Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdiQj205pOvt0tHVcSLVBkZr/ivrCqNSGnvyRVemDu4=;
 b=KQsmfJx4u+eHk/lw6nOxWaTcDaKhqLtJeR+Qo45ORDEtqluoaoJHEgffs0W1N1UI+5HnYfLYeP46kCl1LGSVVWeXYrxayarcmGU7ertD/ovwQQSMp/7YZx3K3/LSsRDWe2Axil9X4oiX9+cqrGZ+h9PdgY3rZgH+lINqy49k/k8=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 09:31:33 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:31:33 +0000
Message-ID: <00619365-173b-bd2c-3a9f-c6d7084631fb@oracle.com>
Date: Tue, 11 Jan 2022 01:31:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111072253.101884-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111072253.101884-1-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:806:127::22) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4371ce16-76cf-4357-0400-08d9d4e5283d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4337F539B49ACF24A09DCB99B1519@BY5PR10MB4337.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KneR0QO0mCfn0hVc+hrNuhm+c2PPqqqhGxVdstXkz25+D46slR7NYlCFCpRW/sMUJjTj7LbjQHe48dqtElmF3N20sKFJAHl2ioyZsiq/yfWhwekZVJBc4KTqMXCiyagp5jQ9jqSb6tqNSILseVFTo+kJCM+egGKMnzLQHyj8/0cWPp8OutLixIBasllZy1M+3XDP1fPxCY61WCHQav/qB6CaV9ccJLHHJMzivC1Ae+QlqX/wi22s6+d/D4+z/Ylg58KPtpuqT/t67wqj4ioyFE5mC1M5z/ChgBwEz7+ce0rrqy36RMdvXkS1M8WSzg8AbCaFO0ojMbxQKmfO1dvbb9N4cCa5kuIQxb/kA/DMPS+NnthM2wM19GHMmIQ7wXG5umMpbiEOoek8ZRb+bWmHMABiKeZ/GqT/8XCir96qyfEsTAtk/H7cwV5hcgXqhHhqNXmPZOomqJG/VTaH6m2Q/ikOc7QWsVy8HM7giky5sbdr3bmlXtX8m7hxc0O2YfJX+ZOxlWzThxWy/GiQfjdx0vJaEePVn0uWMh/ydDmmnh8sT5cttcg+V7vYH1cq0QEHMkW01jncfcgobeaJVFzgMxvRla+Th74BLGdx2DoGi6GntWPY45dIsczMpsh2safamnkHOauOKntOPNunaWUTauzmjcGrZe3GjPCl1SHGvuY29FqErPIXTcuNhkOPj1ApkJWvWC7O1/QcGotV8QSakO6Vw0fk/TYSTEfNkNsupXs5Tnv7WPeqWFXj83IZAl+C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(66946007)(66556008)(66476007)(5660300002)(31696002)(2906002)(38100700002)(8936002)(4326008)(8676002)(6486002)(36916002)(86362001)(508600001)(6512007)(83380400001)(26005)(316002)(186003)(36756003)(6506007)(2616005)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RGQXhiOVJ2bnBIb1A1anRpQ2duMHVub3BMbFV6WGNER05rZGJUYjBCQWU4?=
 =?utf-8?B?bHhuc2ZNdWNERlNpamkyZTJnRERBSnFCcFF3anZuSnowbDJQTWNNYXoxaUtY?=
 =?utf-8?B?QjFuRU9BWlFVcVNQWGVsNUV0NmZvQUFsZ1prL0JrL2ZsYldadzg0MFI2UFht?=
 =?utf-8?B?RVhSanBxQTI1OXduM2l2OFJGNzNyWHozL0o5bHlsZGJESG9KNlpKNFVWZnZF?=
 =?utf-8?B?TC82enQ2a2I0WnR4aUZRMnhzTk1tWkZ1eHlHYXlqeHp3M2h1bzJmVzlFK0gz?=
 =?utf-8?B?YkN5SEhWUDBHME9BUDVObHd4VnMyYWxLL2JjRnEwbmJOb2lYeWI3d0syS2Mz?=
 =?utf-8?B?SCtiYkJHbUJlcDZzQlZqdEl1bVpzL3BlbE5adW1Dd05keXp1dGZ4alBsaEVJ?=
 =?utf-8?B?aDVtWGxjM3I5Rkw4MDQ1VllSbFdrVlFvVkxsSkVqT05oQnZWeGM3andya2FY?=
 =?utf-8?B?RktrSTM5NVRVM0lmanZONGxmVDVVR2RpTzJKWWhCb3NEcGovcDRmck13cG9V?=
 =?utf-8?B?SlhhMkd6YkY1RkgyOUR5N25tV0hRWjk2YVMzTElIa1l3bllsc21sMDNnZEVS?=
 =?utf-8?B?NmFpdllqaVRNMU9TcUU0VGo5ZmxDRmZ4dmlRaW5sVzBYUHFpdnV4SjlLcUpE?=
 =?utf-8?B?VnlFWTRWWGluZFFYKytoMm5PTGwxODNYZnYxWWxkRW1HSGNGNEd1T2syNG1F?=
 =?utf-8?B?cjJPeDVUQmp1NzY1ZFV1NlVZZzQ5bnNrY2JYcGJKRFl3NldSVndtQXY4MVl0?=
 =?utf-8?B?RHlCemI0MUxBR2ZsRHlRYlArQWtFTzFFNzRVWm1PbTQwTGVabWZreWw0dFZG?=
 =?utf-8?B?QXFIK0dDVk5nenM2WTltMFZEKzZyT0Fab0JWUTVrTU9HNFU3Rzdic3hyRHMy?=
 =?utf-8?B?NFZDYzJ2R3dmaTdwQVdzczFXNms1YjJGL2h4YjRvSE1oYy9WUkxUMUtIM0V3?=
 =?utf-8?B?d0hWTERKeUpoK0lhY3duZDc1UHRucHdkaUxqK0tNZUVOdzFpbkh4TDF4bHBn?=
 =?utf-8?B?Rkd6OHJLSkcxdVJhRHp0MzFoRmY5VjlQcmZ0VkFUR25QSkpLcjRQVWd5T0VW?=
 =?utf-8?B?UUVTcElKVEFUMjhCMXFXck9aUE5qMkJmSnVCeVhSNkdnSUJaWGxhVFQreXQy?=
 =?utf-8?B?Nnh1VmM5TlcvMFBZWlhmaDlkNlg5U3FRM2JjRGExa2NxT0FxU24rQXdEak1O?=
 =?utf-8?B?dDlBSXRseWhKSlFzRWVzWEkzcEJhTUpJWXZ1eW4vaWZOMWtvNXRoQ2ZFbzZ0?=
 =?utf-8?B?RGtQby9wdDBTQmRlbklkYnVrV01ZTFcrWVBDdXpXMW9GWXRPVzVmTlRjcG55?=
 =?utf-8?B?TWh4cGc3b0VyWGpyMHV4UGhjenREU0dSaG5HQ0RNYnNoeWFicEdoWTBzWXdm?=
 =?utf-8?B?OHJuemIvWUlpeFhrRTRGNkEvNDk4UG5HMzQreHd2dkx6TFVyV1c4VWFqcndv?=
 =?utf-8?B?aHVBQURWVFpYejZqSW55RnVWT1RJZHVrK1RxN3NVNU5lMHNIUU9CM3FjaFMw?=
 =?utf-8?B?M3ZrMzJOYVpMK2NPK1FDRlRNNGxuL0RtRHkwbjQwaS9Cb0NackVlMlA3RjFS?=
 =?utf-8?B?Z3hyYmtOdUJ6Vmo3ZWRENElNYWpsV0xIT0haNUxSSTUxVXVyWDFuY0U4UW80?=
 =?utf-8?B?bUsvNFQreTJCcmZHV1VFUHNlMjNBZkl4OGNXTjZKYTh0Sm9MN2txTHk4VjdG?=
 =?utf-8?B?MDVzNG4vRXRCZ25DdEVEUDE2OHVCcGtWY3N0UUFsM2tRM1NIaFJSRFQ0Nndo?=
 =?utf-8?B?SmVXSjZjR2F0R1QyMGVFNGZNNlFoMVBiWjBNd1QzajJyb3pTaDFuZG4vQjdO?=
 =?utf-8?B?VVhnbFVrekJtT2MwMmpFaG84M0NSbjMxRHhKOG9lR0kvTEdQcEdNRWNwaHpw?=
 =?utf-8?B?N3ZEQ1lDRXlmSk94VlNBSXBiYlUvTGwwL1Y3TktsdVVNc2dhWE1OeVZGQUNs?=
 =?utf-8?B?OXFobEtCUXN2R3Zram1aVEhqUTc2ekhuSm1RZG5mS29oS3Q0bmRWNzh0Q0dn?=
 =?utf-8?B?elB6OXZTTW1iL2lKa0xRc3ZCMjJSY1NpQUFKZncxTmlyalh6NWZqZTF4Q2Fn?=
 =?utf-8?B?YldkbVk2V0hyT2FLVTdqcEF3dllzZDlpOXpCODAzbEMrSTdsK2E4NzVIYjBG?=
 =?utf-8?B?dDJyQVZqdk90NFpxRlIyWkEvbG9pejJ1b1d3anUyKzhWNlJwRkVYT01tOFRp?=
 =?utf-8?Q?nYIUpT5VQcrn7SNF2oX6+5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4371ce16-76cf-4357-0400-08d9d4e5283d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:31:33.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHqi99bRIKcFn0S+rNPQmtJqSCL2pAjWr2+shlxHg8Oh2msd/+ZO+u8wHKyj8RMX6hYZFBDpHXgr0yt6Y+3Jwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110053
X-Proofpoint-GUID: 4H_wu_LYtqkGxKNFEYEteepj8WfIFvGk
X-Proofpoint-ORIG-GUID: 4H_wu_LYtqkGxKNFEYEteepj8WfIFvGk
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 1/10/2022 11:22 PM, Eli Cohen wrote:
> Make sure the decision whether an index received trough a callback is
> valid or not consults the negotiated features.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>

Is there more for this series? Subject says there're 4 patches in total?

> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d1ff65065fb1..9eacfdb48434 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
>   
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {
> -	if (unlikely(idx > mvdev->max_idx))
> -		return false;
> +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +			return idx < 2;
> +		else
> +			return idx < 3;
> +	}
>   
> -	return true;
> +	return idx <= mvdev->max_idx;
>   }
>   
>   struct mlx5_vdpa_net {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
