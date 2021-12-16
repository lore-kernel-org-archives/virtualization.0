Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A83C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Dec 2021 02:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 417B64155C;
	Thu, 16 Dec 2021 02:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x9jx4o7Iw5nL; Thu, 16 Dec 2021 02:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC66A41507;
	Thu, 16 Dec 2021 02:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91FBBC002F;
	Thu, 16 Dec 2021 02:56:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC27C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1CD682BED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="W2qLbSBZ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="LIPqof0A"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UvqUZ-EB5FQz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:56:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE9DA82AF8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 02:56:51 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFMEabx022261; 
 Thu, 16 Dec 2021 02:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YHWTNyBLagLnCQmdYS01Q0kZnNOmf/jVziQnVvUuZ+w=;
 b=W2qLbSBZYZUDni43sNHoXb5qJFRNn1uNvMwBk4QXB2YRZFAmHnKHzprXsf/6BbKpC6AE
 6Yj+/1ozBPuTzDDa0aJW1drL58pzpoUNZ5xV0WTSfafU7zPDG9tgCR/lwr8RdVqJyLyf
 ssomfM7FM0XqaVxTnLttNA6B2vBsLbmwbNoAjZ0jSEnvEMTIJhAz2IQipg2jRmqamC+P
 3mAJqvdiGYfQ3SXRwDqrvEWBHf6sh0AkrmzULiEMQmMI4IHlj7OOiuYzUxU0YOA/6quW
 rLa90pGFNCs8YlpwLwiC472FhCdpN80frNUe3ppQ/scw8xt9ckmeTDnO4Qhv2MMaY//h lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrhdda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Dec 2021 02:56:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2tmCt116470;
 Thu, 16 Dec 2021 02:56:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by userp3020.oracle.com with ESMTP id 3cvnesyuv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Dec 2021 02:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn2kUZDfCycmfxA/Y3kbdth9QW1PY6RYyaCvaFW3i80uxWUcSivg8HsNjc3W4m/WOgwMs1B8DhqEJQtsYMWbVdH7CjV0/D91zMj8ePRs+HSHCm6w3xMsMfNSzsZoizm5MHq0VxFr/RfAi3yWVlxIXf9ynbc0tpMVeZ4t9S5LOdQPmB1pEnxqgJ0N4tiVyjCK+k09wkJpOe0hlMuk7/qwaunXtP/uzmd0hW+mzxraY/JIUN12MJeiJB2PAJAOO5dJU/IA2Pwfb7BWMuHDSZTCDGUuxXx/ayNuEdn5Qx58iGcOvMUzLBIDmrtsHPml0Ui0jyMI8j7qJCreu/FJToW2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHWTNyBLagLnCQmdYS01Q0kZnNOmf/jVziQnVvUuZ+w=;
 b=SPhA8nSySD0z4f1ILFL1IxAD2/iLZHKLJ2/QZUTHq/a8K7x61f7f7IEsmgjzmxFbci20WZDMoJeuv5eLAr4nNsl7cr89QRYiIETwKsyPfgp0CYvV1iv2bMxlZufFoFZkmgRlPdF61OPmrpDMS7FEsPQz0Ui+jHXKa4HLxuJB1eJOlPjeUE4st3R2P3vsiLmgCPz1fTp1arK4joWasZoxntGxnDEauzAW6wQqq+owSwizEycwS5wnj0zpURTeAI/+q0V3jpid3H02tRLe5Q6F22Uu9JSWJ0oQo5mQIYaamnrXapJD9kS5YwRIaj/LdahM1kaG5EeQ0PO9RQiI/vz3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHWTNyBLagLnCQmdYS01Q0kZnNOmf/jVziQnVvUuZ+w=;
 b=LIPqof0AsasdUoqouJNpkOrG0L7RAe9+0tP5AjwnePPZQSiUNE5CE8SFgPyIO4BVhJOFE5ZVJyMhnj5JXgYbcZemSqBpQWVF0lYkDrtVZIAtakhhO6rPOD7vwh/EWIC7dkMifiPU3mcGAW8hGQpBajO0aU3HnL50pPUydGdabSY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (20.179.158.139) by
 BY5PR10MB4017.namprd10.prod.outlook.com (52.133.254.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12; Thu, 16 Dec 2021 02:56:46 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 02:56:46 +0000
Message-ID: <70af2d6e-bd4b-27d5-f3d9-3f745e91b9fd@oracle.com>
Date: Wed, 15 Dec 2021 18:56:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 09/10] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-10-elic@nvidia.com>
 <3c04815d-1ecc-f8e2-08b2-7f21d5149d91@oracle.com>
 <20211214082229.GE89087@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211214082229.GE89087@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc63daec-56f1-42b9-68d7-08d9c03fb2cd
X-MS-TrafficTypeDiagnostic: BY5PR10MB4017:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4017B8302C8F2E86F741E598B1779@BY5PR10MB4017.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMU8ZbRA7k/UajeuWDv3pHJXPV4GZs9/mQphI/ZayziiP+m6HPDiy9SQTHKUyOWuhsuorboRR0GDi1hiR+v2OGKv6iGndteUqiysRnUaxrqPzuyOnAXivbUL7bDhC/Jr9d/q+kmbC6UvJFuJuYAKYPeuMDlV2fhfVvf8z1GHV0k9pnmYIM50u2qKhGa4Y0DA9QqtOKAmpt+8gBwJ0LXjJAwrZIfxTW4pS3kyC2nNirTTmAqBXkaZ8bv/XSi1hndmk/uaDxmUZNQFfVgR4jyT/PfqZnb/q3OaL2KKcYilQGtOxuqpBuRFKKB4ZAe9Mxe42Ux/tKo67upgXJDSOD4ZhiKDw5fN0J8Vj78Fd4oB+XS7cCvnFGNozosaYJzycS2WNU1MZQzDbSswPZ79w6Bxu32pyh0VmvFxByIYbrJdwL8HGPTkrCUrPjusuEN1Ny1thvi+ZyrKlUpOEVJZwiqC3om0CFohE8sTCG+io5+yoUEXkwyych8PjpmsNjgUOs+WjF15TsT4vyEJxY0Lyly9Cko3DEkpfO9pMk3f205fPJ4FAJt2+3Ud/QL08jW8meBT+yuEeAzuumqFC9//ZeBlrm7bF4v7DrlbW5ygx5eQ9vCrSyE8yIO/3Yof3majy/m961FgDTse6d/grFATE2Hw5re3N4X8aOwjueCQ8KqE77K5v6XwGb7aws4fjfUg4f8wkb4NEjQcwFucIgtXGDU39p+zHdp336rUSB1JMMsDOGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6916009)(31686004)(8936002)(5660300002)(36916002)(6666004)(6506007)(2616005)(31696002)(83380400001)(53546011)(508600001)(2906002)(36756003)(4326008)(8676002)(316002)(6486002)(6512007)(186003)(38100700002)(66556008)(66476007)(86362001)(26005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2U4eUNhcGs4a1FVY2dqQlV4aVUwc3p2Smt5T3phMXRjT3ZrcDFFSXB2WlVY?=
 =?utf-8?B?blBaRkdaRmh5YWl4MVVVaDlJYmVUbHpCL0tCWUgxbUlhcXRJZjh3RUxtcmdP?=
 =?utf-8?B?Zjd5M2FVTTcweUkycWtONURDTWg0ZmgxcjZKcGk1cDhMdFE3NHR2MXl2ZUZv?=
 =?utf-8?B?TkZ4OTU1NEsxU0Z1TDZEQ0ZxdHZ3bWhRamk0c3l3ZHRTWHQxUDBnWkIzekp2?=
 =?utf-8?B?QkN2TnhDRXBPcXl1K3NVUkhkV01vWm03U3ZGZUhCbS9BaUwrbWJnZEhwM05i?=
 =?utf-8?B?cjVIbkhFWUJ5bzhHY2R3NjZhVHVoUmlIN3RvK0xEYkdTYUFENVNCcytlVm1D?=
 =?utf-8?B?ZTAzOTBVejZNU2pONG5SK1R1emd2NXMrRFpaZ3BkR3BsZjdYYk9rU2duWWM1?=
 =?utf-8?B?SC9qcjNnMHFsMWlaRkNmclQxUzdySk85S1h1bE5MNHIwRGVLdURvem9TalV1?=
 =?utf-8?B?aC9Tb1JHZGNYWE9nM2tQSWV2WjJHLzdaclc4RlBvNjFXQmN0Rk9vY001aVZE?=
 =?utf-8?B?dXh4cFl6L3ZWNUdCTktrOGoydlBUcFI3Vm1ndE9LaHRTcHdZaHM3dFBXZ2F0?=
 =?utf-8?B?ck1HZ2dqZ1lmeGpaTTAzeTZwWlRIWXZSV2lhQ2NidmpCOXBKMlB6cSsrcHAx?=
 =?utf-8?B?SGJtdGRueVFzTEppWTVpNEorakpkK1VCQjZweXFpeGF2bCtZSmtMOHQ1R1dx?=
 =?utf-8?B?Ym94UGVBbS9PaWlOR2d3V2JuckVRUzhjeVEzWTFzaHBTNm1ZOHl5aS9iWnlh?=
 =?utf-8?B?UDJZS2tqOXBSVkRFU3ZDYVNzRC9RU1lYdUR0cWF6QnE5Q3ZTNUdEVXdMdVpB?=
 =?utf-8?B?UmY1STdYekRwc2xYZWs2blgrTDJJN0NGMFFVRUsxMG1nY2FwUTZMeU1La240?=
 =?utf-8?B?N1R5T0tpb1AwZ1FGUHpCZTF6SzZUU0hldEw0Z0E0SkVxUVNQWTI5QWljZUxh?=
 =?utf-8?B?NHJlUzJnSTZhQldJK25XUGhpc2hPUlRqZGZtYjRGdVBreEZtQWpXaHR2N2Zl?=
 =?utf-8?B?NkVqYnFpd3RNM3FGRWNKMzh5cVJIUVVJS0hHRXVydURQazZwUkZaRWZyRUh2?=
 =?utf-8?B?bStHaitaVSt1RWdJNHFxcCt4MExzTEVhY1dXVEJRemRGazV5Z3E4N3VVZTlt?=
 =?utf-8?B?dmpCcGF1ZjJkTWVBejY0ek5TVmo4ZFpDOWhxNGorUmZQeFoyWmZGT1lHb1ZN?=
 =?utf-8?B?TFc2a1dKK3J1QUhNQURuS1JVK0JHTVlBS2w1STRvdTJWTXNIdW1uck5iMUtK?=
 =?utf-8?B?clRDa3dZTEhBem1FcXRVUENnUTRhamtndnVJODVwekVjRGwrUFczNExEai80?=
 =?utf-8?B?YWVuazlyeFUya1Vsdm5TOUE3ZnRVQm4wY0M1Y1E5cmswYmhuaEVONWkra2pO?=
 =?utf-8?B?dzI1Lyt3MTNVZkpXbUgyZ25xQktuM3QrWVowSCsxRUhmYVppUkFXY1A0QlQ4?=
 =?utf-8?B?V1VLZHd2TDJ0aWxpSU9DZHExcWlIUkVKd3JMRGtRcFBJSXZyTGptZVhhTDQ2?=
 =?utf-8?B?VERVaHZrRzAwbFdlaWZrQTc1ZTZVWkptTTN6RXJzY0t2cUY0VTlYUDk3bEc4?=
 =?utf-8?B?UWhUaU5zYlVqT0dreDZKVlEyQnZuQ1BwcCtqa2dnQkl4VEluWHRWc1pjOTE5?=
 =?utf-8?B?OVJENzkrM0FacldMaXo3OWFBWEVleUZTQXdIcGRSbmFPVFdGMUdOcFIrTjhW?=
 =?utf-8?B?UytDQ3kycW9UTFlyUnowRWR0VzZWeS9XWk5YZXE3MjZ0VHQweHFEcGZ1MXJu?=
 =?utf-8?B?RTJWMTVIZTZNRmhQRkR6VUZwa0FWRDE3SWp0UUdyUCtXa1hJUWdTWFQ4WXNC?=
 =?utf-8?B?MjYwSm8rRUxoS3NQdFBMYS9MRnpKaVdrUXhxVUdDMTc4OFpwY20ra1FsM1Jr?=
 =?utf-8?B?bHV6LzBJaFV1L2FRenZiajFibWRHZWRVaURUMkRWZmhQakQwMmxSS1dSMnJx?=
 =?utf-8?B?bFFWY1hBU3oyZmV1VzdDM0V5M3FyaTZ2UGtrWW9PUmpneDIySFNER1Bkdk1F?=
 =?utf-8?B?emJBUVVBbndCeWprWmxIaVdsejJRU3dJeEpic0kwbFpMUjRkUW9vRkwzQlc4?=
 =?utf-8?B?VGJCOVdFQ1BER0ZTSHAyVEtVbExkaEhqV29qWVBvTWRNcEdieEJVem13T2dw?=
 =?utf-8?B?b28rK0RSbnFkME80a1h1cHBxTWV4TDlyYW4xTVNvdlEwODZtbWlYcFgvdHBB?=
 =?utf-8?Q?+D17fLXhMt8iAl/D9bc+R3A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc63daec-56f1-42b9-68d7-08d9c03fb2cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 02:56:46.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhv52aUb6voAQrl/k0ldMUGFk+hQ2dTBaQz8YmW4wHY6wVN52ud8W9Sh6JL9VtGJBF26zlCfdMG+Bra3wryo9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4017
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160015
X-Proofpoint-ORIG-GUID: z--tUDxOGLm9kpIwqXBReCodcK0BBuR6
X-Proofpoint-GUID: z--tUDxOGLm9kpIwqXBReCodcK0BBuR6
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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



On 12/14/2021 12:22 AM, Eli Cohen wrote:
> On Mon, Dec 13, 2021 at 05:00:18PM -0800, Si-Wei Liu wrote:
>>
>> On 12/13/2021 6:42 AM, Eli Cohen wrote:
>>> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
>>> need to feel this value according to the device capabilities.
>>>
>>> This value is reported back in a netlink message when showing a device.
>>>
>>> Example:
>>>
>>> $ vdpa dev show
>>> vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
>>> 	max_vqp 3 max_vq_size 256 max_supported_vqs 256
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c       | 2 ++
>>>    include/linux/vdpa.h      | 1 +
>>>    include/uapi/linux/vdpa.h | 1 +
>>>    3 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 130a8d4aeaed..b9dd693146be 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -695,6 +695,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>>>    		goto msg_err;
>>>    	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>>    		goto msg_err;
>>> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_DEV_VQS, vdev->mdev->max_supported_vqs))
>>> +		goto msg_err;
>> What is the default value if vendor driver doesn't expose this value?
> I think each vendor should put a value here. If you don't, you can still
> add a vdpa device but you'll have to guess.
> Alternatively, I can provide a patch that sets this value to 2 for all
> vendors.
>
>> And it
>> doesn't seem this is something to stash on struct vdpa_mgmt_dev, only some
>> vdpa vendor for network drive may need to expose it; if otherwise not
>> exposed we can assume it's 32767 by the spec.
> I am not sure there's any device capable of so many VQs. In any case, I
> think use 2 as defauly is better since any device can support that.
OK, default to 2 is fine (for net).

>
>> A generic vdpa op
>> (get_device_capability?)
> The point is that you need this info to create a vdpa device so I don't
> see how it can be a vdpa device operation.
I wonder if this info should belong to mgmtdev rather than vdpa dev? It 
should be visible before user ever attempts to create a vdpa device.

>
>> to query device capability might be better I guess
>> (define a VDPA_CAPAB_NET_MAX_VQS subtype to get it).
> Why limit this capablity only for net devices? Any kind of vdpa device
> may want to report this capability.
I thought what you report here is the max number for data queues the 
device can support, no? The control or event queue that is emulated in 
userspace isn't much interesting to users IMHO.

User needs to take the hint from this value to create vdpa net device 
and specify a proper max_vqp value. It's rather counter intuitive if 
what they see is not what they would use.

Thanks,
-Siwei

>> -Siwei
>>
>>>    	genlmsg_end(msg, hdr);
>>>    	return 0;
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 9245dfbf1b08..72ea8ad7ba21 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -444,6 +444,7 @@ struct vdpa_mgmt_dev {
>>>    	const struct vdpa_mgmtdev_ops *ops;
>>>    	const struct virtio_device_id *id_table;
>>>    	u64 config_attr_mask;
>>> +	u16 max_supported_vqs;
>>>    	struct list_head list;
>>>    };
>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>> index 23b854e3e5e2..1b758d77e228 100644
>>> --- a/include/uapi/linux/vdpa.h
>>> +++ b/include/uapi/linux/vdpa.h
>>> @@ -42,6 +42,7 @@ enum vdpa_attr {
>>>    	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>>>    	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
>>>    	VDPA_ATTR_DEV_FLAGS,			/* u64 */
>>> +	VDPA_ATTR_DEV_MAX_DEV_VQS,		/* u16 */
>>>    	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>>>    	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
