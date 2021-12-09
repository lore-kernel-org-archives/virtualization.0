Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490AFC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 00:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D82A381775;
	Thu,  9 Dec 2021 00:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0qa9eDQjHWs; Thu,  9 Dec 2021 00:59:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6850381815;
	Thu,  9 Dec 2021 00:59:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3494FC001E;
	Thu,  9 Dec 2021 00:59:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A145BC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8975481815
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jiVmvXeqjFuN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:59:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65FF281775
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:59:33 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MiI8A025476; 
 Thu, 9 Dec 2021 00:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hgW2SiTil2/rsyVBwAcbz0Go7HH9Png8IR0dtj+ctyc=;
 b=gbGuDrzora7zP4nQQfFNkRconQD3RhJ0IqlQp+TBPfI/QjjUIhRuH2GcCieAz/vrk5yk
 F7pek91bxWYWoVdJMBJL1WTViWvsCMR5rHykgpp9OD8aewxK//GLqvF84P12m1CZr6yh
 0FAXFKAdhWzUqTMhBP+tKRyogJonFbPHugsQbYblPCLiIRtj9duJ/+9gOi7zM4pIPkO7
 POH3gF6QZnkaJPC0uhtkEkLIUVNkVZwQlRp6vA0DKMtPXxbuNu9JEHQgF5OC1rBm3GA3
 P7GuZfHz8MiYgT6JZe4G9+98/WTQxEcln5VELf0ipwUYnayugo64Hr7J3G1RrxS5E0gU jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1j57d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:59:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B90pFMj031223;
 Thu, 9 Dec 2021 00:59:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by userp3030.oracle.com with ESMTP id 3cqwf1as88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DllCIGrviA69G+moqTHzWaJP0vGx7VPxz2FGxg9pJiVl0XzgxY8jaaH+hHzo3MNjg0Ytm1ewHBT8gKLjGYwwmQ28HKHKFPcTyv8R2DXQ66wZCdcIpkkWYies6FVnUJd5PsIjZiqtP7v8oumFVD7GQEVh7NH3b3d9adDULZqEAKA+Ma5AD3h4arD2mtpGxySwdj0xR7gxYdsZ8SA/MwYQF1X+Y3APBGKqhKICDIt5xvlaZt9bTmdPjLkfAZDCAzas3q1Ssu646LbT90C/dbcFJI/C0FgSsn7DZ7dNRm1K9nYci9ycMNxEPitbwvmT+Ni3BtVVH63IETfQbgkCferhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgW2SiTil2/rsyVBwAcbz0Go7HH9Png8IR0dtj+ctyc=;
 b=h8foBuYeTQfIdLcgHFpLEo9zzejwwlwmKPhxvEdGb5v1BxN8ukYqH9FK1+qC37rdb+Rr1OJcSVE1F01OVNdjBzGVdYtCSUX4MAn/X6IkcX9xPZHQ7/fSxVNLOz+V3Sr/6X3gJ+rDFlfFCoejZfNfWH04M0ZlJBKWjPG39Yqua0IDWX92QeaLEz6P7NbL0nb8F31dfKHUWDJ8TPE1PmCkf/Uo7ylq34ZHd0C92JGX8/I2O3BOpyKw5gYzjnX74Qu0euVpy0K1XNvx68wz8/9Xi603SDrKKMwis5KL4CjugM7QAo5+qnFhRYlLygOHc+doe34MhBRVzlm4fHAr0lN8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgW2SiTil2/rsyVBwAcbz0Go7HH9Png8IR0dtj+ctyc=;
 b=Sj4a8++ur7uVnXyHEdof/EW25QJYnlz6xMdjtIatpjL4qaHpe9Zp9/OQ2jsl7GlSbiY9w5c4deORZsBaTIhYChuQkfxwxmaewR/Cb2US9+e2hu/bYi9BCUaAoIoRA/afDcdKBfTFGojBDsGERM9IKJEs4zfzRprQS0xMGbcIB3Q=
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by BN6PR10MB1378.namprd10.prod.outlook.com (2603:10b6:404:44::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 00:59:29 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::2821:50ec:dbc6:9e3]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::2821:50ec:dbc6:9e3%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 00:59:28 +0000
Message-ID: <d5c417f9-b55f-02b7-d141-aab913495657@oracle.com>
Date: Wed, 8 Dec 2021 16:59:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 6/7] vdpa: Add support for querying control virtqueue
 index
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-7-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211208201430.73720-7-elic@nvidia.com>
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e74e01-22f3-4039-6879-08d9baaf26e4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1378:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB137835C78C67E2CF2B251878B1709@BN6PR10MB1378.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3iWTXv+ZzNw0eLsb6qk/AyzPmsEzT/3rT4mY3n7mAp+i30lpRkanPjCLGSVN9BsErYypjg3KSsAntbR3JEBWzLNe8wvG5MEqO+sQzoOvBcDu4o3xAmkwdcPbUbOcjOTBouYNhXlLvWhNRxZwweMMsE61ONnR9dLG1TIC5HS7X2wtZuUtEhwlsQ/BOLhmBWzieJiJW131fdB6hzRP+DhcyT21DjPzjpKJ0AC4qMsvbIyfFPpgkjpC60tFmcUhOOmn0GcVtBdpq1AodMWwEi7yheHCxtl6NhWOskG78PbvOxKcJ5MkFyh23rOzUSs7V56v4aED4gPWOCCXm2scioIHjWe3EJaJas4fsaU4HkvR5GDjIrftbg5vl8Gqik3MQAGFNwlbEZ1YCN+jKyK21NOW1bv5CAmGwv42l0cA/pe1Qh1/WKTvHN2fyIC8pa8ZSxsmzdxQQ2wWjG2PbVS9qzdDHGhsfVhGBzIFTBn6EWmMbV3ygMTdW19pblAaGwNL2lJ/qcCOw9WRWRV+2BjThV7UU/0viwOF+eOiVmweTTrLfXptWVoxVWBHE8Ck/ArrCQI+O5rKK4SeQPftO6ILWCuGPc4geDfVnw95Y15VI73RhCVudp/tyzmKW+rQMYSGNwjPy12ZQB1/Ed2vjv3LXefMCxrwFyNV9RawTxwTnJuVLs+FoqPFZ+/Ogtk9/o/8I46GbSDoTZW20xJ7HAE0ZseHnLnbkuXWUoRllYkQegxh+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3283.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(83380400001)(4326008)(66556008)(2616005)(186003)(5660300002)(2906002)(66476007)(6506007)(53546011)(66946007)(86362001)(6666004)(26005)(6512007)(36916002)(8936002)(8676002)(31686004)(31696002)(36756003)(316002)(508600001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My92S0IzbWUyS042Q3VTeVg2UHRlT0ZreWhNOExYeStuSHMwa01MUkV1MGF0?=
 =?utf-8?B?QWVrRlpUUjJ2OGpRSVk4U3hnaUEwdExCY2E0cWNSYWpwRFJOWkFZSUVlQWZx?=
 =?utf-8?B?aVhyVkRTTG5xMTBqRUJDalpvRzBVTEZWcWFhMEFHRzJQWmRJdDQ1enZJakV6?=
 =?utf-8?B?NGZpS05iWGdZRFpHU2ZqbzF0NU5iMUh6UWNBL1ZMTVZQdCtlc2s3dS9iUm9Q?=
 =?utf-8?B?TEtEWTYxUFYxcjZsYUI4cDVRWXRCc3lOaENTRHlUTFFCZDRnZTgxamNJVW52?=
 =?utf-8?B?S0h0ejB0eU5HM0pzN1M3ajdCYlZjMzhFaHpmWUFMTWpLTURQb3NOZVgxek1q?=
 =?utf-8?B?cnlDanJ2U1paSE1MWFNib0VSd2FKT2ZiS3FMUkwydXNNdjcwTHc0QjhnaWRY?=
 =?utf-8?B?S1U1Q2JUNDFYcWVLelFySTZCdURhTVBHcU5QdjlUZDJkdStiT0F0WFhERzJz?=
 =?utf-8?B?S1hZZmQ1QkhmYm9RWFlEdGs2ajAxcXRIUlQ3Nk5HSnI2czNic0ZhNGhyTnlD?=
 =?utf-8?B?dlFhNG5LMnZvZlJmS3kxVytPcmhmSHMzK3VPSjdodE55R2Ivb3FlNFVYeWZ3?=
 =?utf-8?B?S3BhSnVxdDN2ZGZQT1BvWGRQRjRDVFE5TVRMaXFMSGxTV2htWlFHa0U4Ukt0?=
 =?utf-8?B?RFlRK0FLN1JwL290SjJuR21hSlVjYVpjTmxEalJ1T283MjdSd3lGYXhtczNm?=
 =?utf-8?B?UW1qTFEzUytmQ1BiQy9NOWp4andwcmZSV0o2VHkzc1JsUHFxcXlrMDRIQnVH?=
 =?utf-8?B?UVgreTZOclRXTE5FckFyUEI2YnpjUjZmWFh1cGxjMUlCNWJRcE1oRWE5S0lF?=
 =?utf-8?B?YW1QMWV6aG5qdnNoNDFieXA3VjFIQTF5NDJuYWViMW52UVE5ZmNFY0ZtMlNH?=
 =?utf-8?B?bk52M1M2TTBXSVpCaE9WRHUwSUExTXNFdnhvaVVvTkxiTTVmUitHUEEwcXBz?=
 =?utf-8?B?NnFwWG5RQ3VyUU02TTV5NDN0SmljTEJENC83STB5ODQrSktPR3FtM0swYWFL?=
 =?utf-8?B?NzJ5SlEvOWhvalVrYlFoV09WQnpMcG5QOHZQcHdtbWxFMk1PcitwSTU1RnI0?=
 =?utf-8?B?eFZqQ3pCVi9EbTlYN1dFdGlFMzgreitKQ2ZhdDdGa2xVVXBZMzhIWkRrR0sr?=
 =?utf-8?B?eTNVNklKYnlMZTdlb1VEZ0NOMHVDbnhYR05ZVmtZeWdLOE5MNk9Sdk1IZE92?=
 =?utf-8?B?TGlsRWl3Zkxya0tHSExRQWF2NkJlUmhyRHJxaVNqUjkxL1FmajJhVHVjSW5j?=
 =?utf-8?B?NXlaTlpaTk1Ed3lZdnp0SVgxdWhzS0YwSDluSHNoc2lyalNMSkVUVTRhTkw3?=
 =?utf-8?B?MnlRUFdBT0dhanRqNzVhdUV6d2F3SlFzUTlKWnpMcm4yWUVhZ250akhBVlQ1?=
 =?utf-8?B?Z21XdUJNYitGaXduQzA2VWR4U2JTWWVZa3lWeGZJQ1c0Tk5MSDVkL3NQZ2NN?=
 =?utf-8?B?NXd5bkw3aDUxK1ZYbktEbVU2bGtySG9UOHltU2VaVXBacWhDU09McWxWNGd0?=
 =?utf-8?B?M3AzWGlJZ2l4OUxOdTVTZ1ppL09OZDh2MlZUOTdJZUZIbWZRT1dOTUFhb0VY?=
 =?utf-8?B?MU1zajFlRnRlLzF6dm8yalQ0dVZZNTJIeGNUL1laSDl5T0JucFhidGthQmVh?=
 =?utf-8?B?bklwdTdkaXFPRzY0Y1o4UmFhUlYzQ095bEp5TkdoelpNZ1o0OURDNWJ2UWlS?=
 =?utf-8?B?Tm5leTJFR3lmMHRFNzFLTm1FdG0xVHBJdGxZOW55U2tIR0VEVGVuNGFoNDZl?=
 =?utf-8?B?d1NseDBwOWh0a3orc2JmTzVjMjdwY3pJbm9HZExEOFY0WWZIREI4dGVlZDZY?=
 =?utf-8?B?c0h6dTlRaEoxREhvYi9OWU5nWGhwYU1UWWVUMmo4UHFRVUxXWG9TZkNrajhm?=
 =?utf-8?B?Z0pDYkVQamRvdmVsNEx6eG9Uc2FIMzgwSUdqYTNPR3UwUjJia0RMQTRROW1z?=
 =?utf-8?B?ZS9yekNuUmYzSjcveEU0akR6THJqZFdwUWRCL3ZoZTFwOWt0Wkd2MHVsdWF3?=
 =?utf-8?B?S0dkdjkrbndoSTR6aDduRnJpczFCREVlc2NaejIzMS9ia3FURjFmOTUvQXY5?=
 =?utf-8?B?ZzFhVDIvY3FkSy9DSmxVY3I3VkowYXo4VkVTUStpalBlUGJtWVFoUGQwa3RZ?=
 =?utf-8?B?Tjh0Kzc5Ymh2SGgxTXE4aG1BZTBzV2dCM1JUTGxBWmU2YnJMbktOQnEzYm5n?=
 =?utf-8?Q?V3wqoITzEa4QvNR4oSijCjY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e74e01-22f3-4039-6879-08d9baaf26e4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:59:28.6590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqQ+JxYMkVHnpMyd6XHviUNGeC/1LRANnOPIwuCS7aaILZ6ehLrItARs6jLAghyxeeAZZb0LkcF7nNjediEafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1378
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090002
X-Proofpoint-GUID: YtZbSb_wOED83i1js7PSti1-_vizhFkg
X-Proofpoint-ORIG-GUID: YtZbSb_wOED83i1js7PSti1-_vizhFkg
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


On 12/8/2021 12:14 PM, Eli Cohen wrote:
> Add netlink attribute and callback function to query the control VQ
> index of a device.
>
> Example:
>
> $ vdpa dev config show vdpa-a
>    vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 5 \
>    mtu 9000 ctrl_vq_idx 10
First, I am not sure if there's value or a case showing that expose and 
trace the guest ctrl_vq_idx value (running state) to admin users turns 
out to be useful. Previously I thought you want to expose it to QEMU but 
it seems this is a bit redundant, which can be deduced from max_vqp 
passing up to QEMU. Second, I don't feel running states such as 
link_announce and ctrl_vq_idx are qualified to be configuration field 
that can be displayed in 'vdpa dev config show'. Could you please 
clarify the scope for what kind of info this command should cover?

-Siwei

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> 1. Use logic defined in the spec to deduce virtqueue index.
>
>   drivers/vdpa/vdpa.c       | 25 +++++++++++++++++++++++++
>   include/uapi/linux/vdpa.h |  1 +
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 3bf016e03512..b4d4b8a7ca4e 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -712,6 +712,27 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>   	return msg->len;
>   }
>   
> +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> +				     struct sk_buff *msg,
> +				     struct virtio_net_config *config,
> +				     u64 features)
> +{
> +	u16 N;
> +
> +	/* control VQ index, if available, is deduced according to the logic
> +	 * described in the virtio spec in section 5.1.2
> +	 */
> +	if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +		return 0;
> +
> +	if (features & BIT_ULL(VIRTIO_NET_F_MQ))
> +		N = le16_to_cpu(config->max_virtqueue_pairs);
> +	else
> +		N = 1;
> +
> +	return nla_put_u16(msg, VDPA_ATTR_DEV_CTRL_VQ_IDX, 2 * N);
> +}
> +
>   static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>   				       struct sk_buff *msg, u64 features,
>   				       const struct virtio_net_config *config)
> @@ -730,6 +751,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   	struct virtio_net_config config = {};
>   	u64 features;
>   	u16 val_u16;
> +	int err;
>   
>   	vdpa_get_config(vdev, 0, &config, sizeof(config));
>   
> @@ -746,6 +768,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   		return -EMSGSIZE;
>   
>   	features = vdev->config->get_driver_features(vdev);
> +	err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> +	if (err)
> +		return err;
>   
>   	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>   }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..2e3a7f89f42d 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -34,6 +34,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
> +	VDPA_ATTR_DEV_CTRL_VQ_IDX,		/* u16 */
>   
>   	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>   	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
