Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF7C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 18:27:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62BD6117A
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 18:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B62BD6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69F33407B8;
	Tue,  5 Oct 2021 18:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhmXtJ8-Z2tI; Tue,  5 Oct 2021 18:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A49F1401D4;
	Tue,  5 Oct 2021 18:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85883C0011;
	Tue,  5 Oct 2021 18:27:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7849C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 18:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A28B083D94
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 18:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ejWcjQOB";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Wa2wnT6h"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4o3k2aJ611vC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 18:27:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96BCB83D93
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 18:27:11 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Hs6Aa024407; 
 Tue, 5 Oct 2021 18:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BjDL3ImFwuFma6rNli0Wk7gLS69YZdhYE/7UxZL3x/A=;
 b=ejWcjQOBCtmc5YvNlharOsIoLImZ7UtdECVPVUO/UnrrJZjTpE3aPMuT1iD1cnI+Mxc4
 t3KAFfsYAzWXURsJIzEnnuDKJgk4yKAkPkC9PfQx0w5Y+p1mZQEvH2AoviYP2ttMB608
 xX8SBlH1ATRxzdrHRUzPnFjYiFdIL0yvVcoWQNaofxedHbcQjFiggtWVeYTSWdcQEVml
 WLtI0UQYbVRZywup+IfsSaO5/U0UUnT6CMc7xK/xxq5MTcx432hyJBRn5FHldy254uSg
 xzk9jgIaUoEM1homIc6BFw4VJpjeN3ZoC3IgwFUpuUQJ8Lgk3jE6h5m7mdSHH2kEJYa2 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg454hywc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Oct 2021 18:27:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195IAKTc101077;
 Tue, 5 Oct 2021 18:26:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
 by aserp3020.oracle.com with ESMTP id 3bev8x560d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Oct 2021 18:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhfndxYIkKf5bSuSE1yGBIGmz/LP1oCkx0ZCejGeDWlxkhHUq9IgzV6mmp7w8iNk+xbewznq9MqESlyLMNx39OF863Uqs0e3UVo2O7ev+h2qJGNqWW//ULcliU6qfEIygO4qTDQoSujRENfvHY76G83er6qLFwICJuMc28DTcBnywKfoiSOajhlZm5wGorq2NrXJUz841aV+CnSzj1BZ8I2p5TfyN0TKA9QknRcoLhF/HJ08Pe54kJ9cAALr9fJD/RdjzAhtlKUvpL+CoI3R+oY8TUfXTMcj457IPlm9UVwVMe+SoKVROg1mrSydd8a7oJDRmic2GcYJ8HS+u+4pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjDL3ImFwuFma6rNli0Wk7gLS69YZdhYE/7UxZL3x/A=;
 b=Q4Y5rrvKppLjUvjeJQ7kazzHcYrbldUeItGSYSgIh9S6jLFYMKRny+Ksg+ahEmYUFE1T3loG5BeQ2yhI1OZHw695HeKJrkE/jtUN5w7RkMiPG5MmfXZJuoOXRROXKMTmQiiPwcXH0iQIzXmLrSUzcKuNRU2/I6n/nh7kXLYppNR0vCM5Zu5IeENeOOnezkoTfvJd1fYRpWGbXG+FVa9Y0AmOaAb11gvZ1awhqMlfiYo+imZeemxvFirYpafBdqeKCVQdtzflck3fSA8qLd475kUFRgDsTZlZdvhHr+4pvCgVn7TcBC0W+VorY7d3ir+54E4+hQt7dyJyOz/ZKQz3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjDL3ImFwuFma6rNli0Wk7gLS69YZdhYE/7UxZL3x/A=;
 b=Wa2wnT6hnspGb0j0tcSSqL7cNJJnlCT3UTQjKzwf7loUWkzr6/+QRI0AWsVjflnZM2KTN0ToTXBFGAZdFkW07zPYvO69+KhFT9xtp6yf/2rP46s9HlxJCJ7WHmNCgXRdnjoYHwdzpovG5KPqIG6m091GJZtE8+26CSUtNAhqSMU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5451.namprd10.prod.outlook.com (2603:10b6:510:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Tue, 5 Oct
 2021 18:26:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 18:26:36 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgrn5nyk.fsf@ca-mkp.ca.oracle.com>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
Date: Tue, 05 Oct 2021 14:26:34 -0400
In-Reply-To: <20211005062359-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 5 Oct 2021 06:42:43 -0400")
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.19) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.13 via Frontend
 Transport; Tue, 5 Oct 2021 18:26:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91cd959-54a6-4cac-77e7-08d9882daa35
X-MS-TrafficTypeDiagnostic: PH0PR10MB5451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB5451415DF2CC0DC019053DB08EAF9@PH0PR10MB5451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u68C/LmSHUy4GH1R5JB2AOfnq7/ydm/dblQ63XcBTQverVhN7j5mDaT0uxosZVsZ+5uNaOsCmaRA+NSNlc7CzLnclPT5Hx8WH9mkwGNToAKtQ3LpMJRRXY6tGR6iDdNHN/4yHRKwL30EiIfqE2DLAEYkWg8sRtEbwdPabJjjJjPclHE2MOsSaj8/HBnWAtC5cu6waE1IsynRwQPgJuM0hphW0ULWgf61+yuMHoILWchPeY70tHqOQ//U/4jHuPCtl2Lu+U6kILDwE9qWwBDQAcg6L0dzrjKvxMPQ1jS+qb5/1wPlbBME1jkNOu+peOeAekEeMZr5APT5Ao9YCuy/FpOmpjhTPDUhgmQjpSh0jOuQsiIiGujlJGuMLXJ+VaIUwdlVhFDxA6carTEfxxiDMkOo5ua0B0hvvkTo5dzIOTY5gT2JPg0XSrn4wLWkTr6/ncgEnnpDyejrlg8fOjsHRtvDRgLbfJjH9ZIoerO09N8pvPmeasOrM7evqs0RIy2JG2L0OdKrxnNdHmA76JAZknyxCh0nfJ2e+4eo7odMcMKuGd9YmSS+8QFfBHkzVlNbvX9lYQ9Iq/Fc0YyZR+hnL96oL8lPWbSQIbfW2LuOo9I1BQGpKQcsB/3+ihFwh9vnfMuuNuivsWzgMQAVZn+C+c03szQ0YIBL63FvG8CM9gfZUrWnmZ0mdQQhV70iLsGq6Vb/itJrBh1JwEMuXtI+sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(5660300002)(186003)(54906003)(36916002)(38350700002)(7416002)(7696005)(52116002)(8936002)(66476007)(55016002)(956004)(83380400001)(66556008)(2906002)(508600001)(6916009)(26005)(4326008)(86362001)(8676002)(4744005)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RmXNe/WQpv2+hdpUoEReVyu4Z732Uo75+YMuYaUQ7pAXpXcxzQg/Swm+/MMy?=
 =?us-ascii?Q?Pbup4scNW4oSbDb3CMhvOyJLwy+j4Yb6OHvowgHjjln4HNqlG5HN6xmiIzQd?=
 =?us-ascii?Q?aQoqkwABrsYjZGQqcCTMY1S4VGUQnpIloTdgunKppwQwMKS/U9Kuoapq7cs3?=
 =?us-ascii?Q?KkS7CCjUekokDs7FD752OKv0g3HrUvpynbf/F/V7DnZUwMeX1HnZpTgCAJBt?=
 =?us-ascii?Q?X5dlVnyNw4ohgldBlTy9ZML/q+O+oy/7el1vj2FhIOxdqhjgP2F0a/qElJmy?=
 =?us-ascii?Q?JBplC4FMLgA7itC8FsTmbHJpJgDYC8g50nquA40UynPPb0TgqPdxEkZ6MVhO?=
 =?us-ascii?Q?mIx9fbZjs7CKISJu6wEW50JFQZdPfQIddbdAY0hgvTMmHoxQEZGXeXvsBpsz?=
 =?us-ascii?Q?nlMaFCggcfQm71jX5rP9SMGuHEVi3qbo6d3NC8Srff3ca8UiD+7qAsNBBUkB?=
 =?us-ascii?Q?JsZnzVn5oMnjqsa14JqVDWK5O+qQrrY08KWHT9J3X14UE6qwIwSOf2QewWUO?=
 =?us-ascii?Q?3xUg5sd1ngZnJtjnpKap7VSZgc9Rh2xRR9lb2XjKZb7wIwKkrmfgWw7uGXN7?=
 =?us-ascii?Q?nSsjQS44btrq9oGg7RqNNKj+hJIOh/t2pGTVeJWYnrQJ7tiSB0szEwc3gJsG?=
 =?us-ascii?Q?P+GpedmkySm+T2GfcXO5qzrsOyh8KsRdj9ebVFtHtvia4x0x3Vqs8zEKjVm/?=
 =?us-ascii?Q?usWRagWjMAMYg3XrEksqxQaN2Y318LvaAEabv7NuWW9dBWIsQE6I6XCyNVQI?=
 =?us-ascii?Q?j2A21zP/GeMn+qdfksfOl5xH8Ng0x4rcWLs0VTS8tpFMoZei+6fjh5Ciyc5e?=
 =?us-ascii?Q?G2plBpNANFZ4UvbxhFv2v0w4uIsOb9eLXUsKYX7VpJ8LA/OqXlUsg6qZPYbt?=
 =?us-ascii?Q?1w8ehAhlJbirrGyj7+BsB1J22ciSSWFdVaETWKGv3ynavOuGayCTb4XePKd0?=
 =?us-ascii?Q?6tVRcAKN8GtLqFL7n/2w+Yi3BPVUIfFfDQ07Cvmkw05AHY3taK7yuYXJoWWx?=
 =?us-ascii?Q?1UwoOQ+UqrogAqUZJ8NnOvxq/iQoUkR9N/Okb1vbUJyR3MW05DlkbAZRDtsS?=
 =?us-ascii?Q?rsoiiWhFePGfXUrVsPQ2p6bfRFWEyTnW/rc5J4+l5nMdEWzQgu50kX8NV6uN?=
 =?us-ascii?Q?Zkg+e8uGgyIouwQf4sDLBTYXB6wZ5fERNqgzu2OM84Ywcwtaq2THTERih+dv?=
 =?us-ascii?Q?GKq9vYJTNYNSfHN62MrUzAiGNBQfTDrXIX/3KHonijwK0pBxfZ8VY8aCZhP7?=
 =?us-ascii?Q?143Kt3zrxef0h0W4hismeopPxZnoXzRmpY1gYdkE622z37OrC0kH2lzuHSLq?=
 =?us-ascii?Q?UClKlCN5l07W2RfHb4oLkBG5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91cd959-54a6-4cac-77e7-08d9882daa35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:26:36.1148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoBBJxyFfONysbzF42j5dC2rq5rJ+06iy9hu2QOskfe7xByAR9DVGGrSu2J1UxDaTz6H47YX8HqmbL6Ed76LW7svC5cjmtIdJbGV7c+Phog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5451
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050110
X-Proofpoint-GUID: ECDc88d3w-m91CPP-3e-rQ5tISI9veYa
X-Proofpoint-ORIG-GUID: ECDc88d3w-m91CPP-3e-rQ5tISI9veYa
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


Michael,

> Would it be acceptable for blk layer to validate the input instead of
> having each driver do it's own thing?  Maybe inside
> blk_queue_logical_block_size?

I think that would be fine. I believe we had some patches floating
around a few years ago attempting to make that change.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
