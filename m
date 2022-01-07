Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D5C433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 02:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 311424040D;
	Fri,  7 Jan 2022 02:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHX-9avnt2Jv; Fri,  7 Jan 2022 02:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94178400E5;
	Fri,  7 Jan 2022 02:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D7B1C002F;
	Fri,  7 Jan 2022 02:12:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6CEC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ED3D4040D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6dgiwq7kUYx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DE20400E5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:38 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206Ku77P031900; 
 Fri, 7 Jan 2022 02:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=N7GuqBOQSFIqRzuuhcwemiCa/YOvamllc5VmnNyN3wM=;
 b=qStUBJRgYsR+IdcR3UWeIvwN3LtI5VQPTMvOGFz7YVhVauAB/+dZtwoLFVyVcm8GG7mm
 NDEWo/DK9onH1J2e999nO3lartEV2W0WdTf/wO19s6AH9BYobLfIf8hHLnzUUn1enGVH
 P4YHZisr602ABeK1vL14CTlUQORMcPtZM6z1wRRNXvhKaCLhkwG2yMskkgd2n7rXcLgK
 UJkj6659YuJlyE3F2QKAG1n4jyhLPCKXkF+6oN8G8kPVHWJBsUnMTPxpRqR3eopfz4f2
 BtcAYX1yciJaN73aBsfQx1V1Kr30OwhfofTSFghuQ81c+XY24O4A6jH7sk49MeQKT7AN hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v90wcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 02:12:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2072BjiQ119676;
 Fri, 7 Jan 2022 02:12:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by aserp3020.oracle.com with ESMTP id 3de4vvmy5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 02:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrv+E9csj52a1/lvCrFyIQONkd+uLv5YysKiiQUhbRhFOnM/ZFlE/NkwjQnYi+N7tQbrYkrouj9KJykJWTsiHVHGzPAA7Tqu116TGsQ/eBNdHAtOroANga8nxyamnK+tSLl/Vjq8PwABG79vkoxYHAcYW+6V0n/MkzYIp3WB9uKcenjymAxVxED1CWsFYEWV/Q7R6T/mxuTaw0oUsDt6wWfiVtCswsBZwQmKmAXhBAkHqAbl19Zx8hJG9r9tglgKcN+L6PhVH+VIMsDnQ2zC/gOGEgQ9vKCUmIr13JkhTzh2AbZBMyrcIg62yb9Cp/16qYGL6ub7IUXfiFLVTAFpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7GuqBOQSFIqRzuuhcwemiCa/YOvamllc5VmnNyN3wM=;
 b=cpk0ipMj6ooL/4YdHTw0fyTCmQf7gzjaEublaPCZSIkoLJs1Oic0ZdOmxVjiYhxhFVBx92iBRc1IgPyhSj9Znfwl7MVWBmMfO3+/gH1oW5oT0ozBhVq0/pDH6VkWTzsvEmHcTctd/0skPpQeI3YeUib6U+yn2SAqhphiL6m4SspVFShNQpG0mSVQwpe0EX0ZbqcZD2JAVCbdCygib/blcHyb8xKirJseOr6pRagXRRXvhUmHxkp3QibMXGHDFFItSd5kgPVToYhkeMiWZRSQGK6VC+4eE8UkbFlDgLG+DG4eCilNLE9irEtD3BL47+pqlD1X/6CABsOk/75+vmtNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7GuqBOQSFIqRzuuhcwemiCa/YOvamllc5VmnNyN3wM=;
 b=QBQLjIezV+xfAWDNvXcTr2zmwpB8dWOhYiXVvByRAd1CYkg21/ITcDuu1YQJig/JBdRGz7U+GgrTokNa9dK9vR2fxg1lzGeDKPmKhnOeW0gKAeFNeE40Y/RHg6hLylGxQxETgB8hE4H38CLia9/cLUcBPTnl6oVf8Ijo5C56Qnw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5440.namprd10.prod.outlook.com (2603:10b6:a03:3bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 02:12:33 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 02:12:33 +0000
Message-ID: <a27cf64d-3ce3-bae5-7924-8bb68e318c4f@oracle.com>
Date: Thu, 6 Jan 2022 18:12:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 11/14] vdpa/mlx5: Report max device capabilities
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-12-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220105114646.577224-12-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 905dc433-779f-4bdf-8717-08d9d1832aa0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5440:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5440AB07E5E2C8C5830BECB7B14D9@SJ0PR10MB5440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4V5o4JdeQi4Q+grt44123XL+Gv1pvQVQzhXata1l8PDw44nIu2NpC7g9yoWr1O5PiyXWMGvC2m39zmC+hzOY3Gq1meeNnF6dxEZcW20lUv9uLspk87ZVuOVWbLu6rmwv42/yboCVk/rK5yG5nhcIe79pQuK6lhdhXok1I0tqkBAsvocKMERgwfbs+jcVJqU6J2Rns7GqvcAgtpHgnsizqVggphHESy/GjqvDi3yrHeJa3bi1XT6RuFzou6VolP0MdC2adEIcoLdfHQB+i4UfWUEn+n0GOq89fhZaTaWBX/ANKFtX6ioMvM7iW16a6IdCQlWUV/Czc1a+diEMjI+sTNb6Ov0m4+w90EjclUnGEpQfWp+o/qgWf6XIShoiPBqqs4tpDTpO/eAwNNfIgG35xPlvyL0TNVRkTauNxwpdVLYT21ZlTciTLtSWruhSJUx0P27rPOWoxo55P9Efwmn5BS5SrmPJ74FDImebuQg4+lpRmNoCVD2iDk1+m2EwHecrBU2NK+J9yiyjymM/ZVwbRNS24GNvEjKwBnRjvI1Em1Jrha3nItkNGADMYDe9QLZ0LcjDoGbclDnuBuzn/T6s55zozWSDGSLdFQRqwM5PZzqmZtXEEJdO9blVKl234QTIE9PUno6Hj7EMzhaaTiAWWMtSmbXUGdthRhv99Zn+iYIRQcYa1GcLc1TAraalb7XLK6xnZYbXygab9vMf3B8HxzhfWmjPhornWC6/f7+dn18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(66476007)(2906002)(66946007)(2616005)(31696002)(26005)(508600001)(8936002)(53546011)(36756003)(86362001)(6512007)(31686004)(186003)(8676002)(36916002)(6666004)(38100700002)(6506007)(4326008)(316002)(83380400001)(6486002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VSS1dzZzhiYmdBeTA1QnhSUW0weDRzZHJrMmFyU3pEOWRrK0s5TEFYZUNl?=
 =?utf-8?B?K0J6M0RsdDRhK0puMGRyZFFScFlYWTk5SloxMmJQckZrU2haWUpCSjNVc0U2?=
 =?utf-8?B?K1ZnMlcwYzlXc05LQ1NQUEpER01BVGhuVXlQMTVwWEtPS1dtR3lBWWhLMTdT?=
 =?utf-8?B?eldPcEhSMGFqUXliUXF1K0ptY01VRUFiaTRITXA1V1VUL3l0UlcyeTB5ekFV?=
 =?utf-8?B?WHRnZFhPZitibEpCV1BmZUtKTVY3aUFadEI4V2M4ci9aZXY1Y0VOd0p3bkRO?=
 =?utf-8?B?MjBJRVpRYWZwcm84TVowNUNiaEZqWlpSSUNJa0dYU08xdzMxeGtKYUJLWWd2?=
 =?utf-8?B?THF2b1JkVldnZmZkMVhtZ2JJYzRQYmpLRFJsUkladWZUMmFFamJaMTdraFNm?=
 =?utf-8?B?U05HZlk3bEJySm84dGFQTTVZeWttejMrTnlVN3lkNy9SaDVCQjljeThNY0ZG?=
 =?utf-8?B?eDZzWWhRR3lVenJXSjhBNFZvT0hqU0VtbXBGMEdROHZpMkJ5N1lraE50cHIr?=
 =?utf-8?B?T3FkV0ZaRkhRVzJrUmN2VTE2UWlaNFhQclBZd3JsS3poZU5WTkNXVGhUbTVo?=
 =?utf-8?B?Tjc4alNnSU0xRUloL21sNVpKMjhEcGYybTQ0WkIrZlRKK2RTRnVLUEVnUmlK?=
 =?utf-8?B?Z0hkVVl5R1NpU1dJUlZ0TDRhQU03Y0tmTmQxNmJSbjZ4bFI0VmYycFdPZHFu?=
 =?utf-8?B?NUlqQWJJK3JSVHRFKzM1TmVoRkQ5ejZTSVkvT2kvT2M4cDJiaEJFemc3WU9Y?=
 =?utf-8?B?R2ZKaWdLYW5SWVFyQnJhdzl6NGl6bm83cWRnd2N1VGxWVzd6QmRQVTdDVTB5?=
 =?utf-8?B?S2wrNGJ0VzRtODJreFhZeUR0RGFlZ3piVVpVUVN5SDhSaDFubCtwSFpwK3VT?=
 =?utf-8?B?TXhLS1VZMkdRa291KzZuZ1o0UUdkSnZVbjFEK3M1eW1uN2libmJxVG9zTXg2?=
 =?utf-8?B?NTE2QUhXeUNrdy9kamtsclp6ZXh4dWEzMUFEWStmdXJUVUtWUkF3enNENU9U?=
 =?utf-8?B?MUdlWDc1Z09NQmdSaXlkOUxETGZEOXBzeUFHVTgxVmZzK2dWdmhRUncrK21t?=
 =?utf-8?B?VVE1ZEZhcXBqUmpiSVBtcDFkbGZBekRsQ1E4TFlnSzBPeEhmZHFxS1VhUlRL?=
 =?utf-8?B?SVQ5U0JmVTUrRTNBc2gyQ2d5aXBmbmlPb1kvWm9TM3R4WXRjOUZTa2FZOEc5?=
 =?utf-8?B?WkxTa0NtbVo0ejRacy9yZlZWYlJiWW5ESUJ4QUI5ME4wNjVhVWNXeTRHanZU?=
 =?utf-8?B?ampjNkh3cnNLTHE0OERhbklqTnhBckNnMDVkWnk5MzBsWU9YTEVLQlRBNVgz?=
 =?utf-8?B?RDhscEFtZmdPUk15UjA5OWtZV3pkZVdvV0FVTzV2NEp5aGpKQmpydFhkRVVS?=
 =?utf-8?B?NjluVUV3bGd6YkpLMFZyYktMRzg3OWRMalJHOG8wV0VOVURxSThuVVc5K05P?=
 =?utf-8?B?OHlKVXdKWmhFcXYwU3dUeEZTNEZ2L0ZpbWoyb2U0ejJKZVBpY2JrUFlRcUZi?=
 =?utf-8?B?a2l5b3diR2RqbC9Ld1BvMFNTS2pRT1JaQlQrTmhXUjg0ZHk3VUc4c1RDamt6?=
 =?utf-8?B?OXhKSlNIRGJ0Vk1qeklYdkcrUjRKUGdXZmo0ZDhsVGRjU0N4dC9kWFpCVy9i?=
 =?utf-8?B?SHVsZkJDUDJFSjZCdG9uYXRVS2NlczBWR2ZLQ2hoNDVnc0N1ZHN2RS96dlE2?=
 =?utf-8?B?OW9Kd1FiRFJoaTBHSnphRDRIWThDbDUrWXVIRHozMUt5bWFVUUtNdXMyam5O?=
 =?utf-8?B?R2FHT1dGdWsxVjFrZE41RkZlbGx4TjBTTWl2S3NqRDhKN3htSFdDMElNekJF?=
 =?utf-8?B?cHhBSzNDYzRmcDQ2VDZDTlN1VGlyUDdhU0JqQ1RaMGVBM2wvWk9WQjl2RkZ2?=
 =?utf-8?B?NjRLamMvRGh6cE9COFpUdE01d1l5UWJJdHZJcVlzM2piYWUxaE5OZXo1MUQy?=
 =?utf-8?B?SDVXUk9HcDRMRzdibTJTTHVEUFdZYmZiRG5Iak02MlU2SEJyZCtFSnRJWHY1?=
 =?utf-8?B?UTN6dkg2TnlFNlFPWUUxUDFkUjhGMTd3V2p5MkFCallpa2o0UWF4T216dW4w?=
 =?utf-8?B?VWIwdlNlVWhNdXJkSHZpVk5QM2xWbG9PR0p6N21WYldsaXZjZXdVZzUxNjZO?=
 =?utf-8?B?a3pFUTVFSlFJWkJqNWJKS2FQR2xkbjdJRDZEU212dDRXTDBvZXBGdVU5U3FD?=
 =?utf-8?Q?9BTKbhlNaH/OFgJJFVO9f9c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905dc433-779f-4bdf-8717-08d9d1832aa0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 02:12:33.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaQUetYVtwm9IM8Dx4rabpEaNmrqzh2DyAVssiqsTOd7TDyHNToQ4pg86nk4y3C5DjivA5HQqzUsYXGKd5+gig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070013
X-Proofpoint-GUID: eIo6e8QZERWkwL-sL4SxaNGkIJ3MqA5C
X-Proofpoint-ORIG-GUID: eIo6e8QZERWkwL-sL4SxaNGkIJ3MqA5C
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



On 1/5/2022 3:46 AM, Eli Cohen wrote:
> Configure max supported virtqueues and features on the management
> device.
> This info can be retrieved using:
>
> $ vdpa mgmtdev show
> auxiliary/mlx5_core.sf.1:
>    supported_classes net
>    max_supported_vqs 257
>    dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>                 CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
> v6 -> v7:
> 1. Add supported features
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 35 ++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ac4f6794c03c..a0f808ee24d6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1867,22 +1867,29 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>   	return result;
>   }
>   
> +static u64 get_supported_features(struct mlx5_core_dev *mdev)
> +{
> +	u64 mlx_vdpa_features = 0;
> +	u16 dev_features;
> +
> +	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mdev, device_features_bits_mask);
> +	mlx_vdpa_features |= mlx_to_vritio_features(dev_features);
> +	if (MLX5_CAP_DEV_VDPA_EMULATION(mdev, virtio_version_1_0))
> +		mlx_vdpa_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VQ);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> +
> +	return mlx_vdpa_features;
> +}
> +
>   static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>   {
>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -	u16 dev_features;
> -
> -	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
> -	ndev->mvdev.mlx_features |= mlx_to_vritio_features(dev_features);
> -	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
> -		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VQ);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> -	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
>   
>   	print_features(mvdev, ndev->mvdev.mlx_features, false);
>   	return ndev->mvdev.mlx_features;
> @@ -2570,6 +2577,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		err = -ENOMEM;
>   		goto err_alloc;
>   	}
> +	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -2695,6 +2703,9 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.id_table = id_table;
>   	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>   					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	mgtdev->mgtdev.max_supported_vqs =
> +		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
> +	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
