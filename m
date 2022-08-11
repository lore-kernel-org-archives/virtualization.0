Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5895DC19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 10:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C10B983004;
	Thu, 11 Aug 2022 10:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C10B983004
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=JQDeaj1c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=wzFp0WOg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u9qGPx5YLjvU; Thu, 11 Aug 2022 10:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57F0982F92;
	Thu, 11 Aug 2022 10:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57F0982F92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B9C0C0033;
	Thu, 11 Aug 2022 10:39:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BBEFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 10:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0768960AF6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 10:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0768960AF6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=JQDeaj1c; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=wzFp0WOg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVs_TNIfZ35N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 10:39:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3949960011
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3949960011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 10:39:56 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B95XPh018353;
 Thu, 11 Aug 2022 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=DwqIlx2rcPcAGeZQoD37N68KtP6C/TRbpxoarYxd6bU=;
 b=JQDeaj1cpcK4PQQ1noCtbsNB3Im2daayqs4HQ0J1Yi5PunbT0Om5hT+q8at+tc2daTRC
 OOZalCl0Tj5FcyN2yDqily02M9j+kjnJDQysTI6NL+37w/042pm6L55zrmG3Oo8RDtWK
 i5s4TZhPJc/8yavIJ8xhM3wex+R2N380FeLSsXx/e411UIRMxxcl3jx2Ofnrh0gIV440
 CghnKw3fdyoZtaklSqWH8Jwzhg+WOo2oKJM3kXZCjS0IYxovg/FQ8nMMk/DFaAp8YE5h
 9tdZUy8HiMoRAaH4tl2vNXBe9wRkdywq6wqxn8iip/p3mx9RbEq6bWCmC7MbaEMk1bZK Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgm8s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 10:39:55 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27B9KREu035368; Thu, 11 Aug 2022 10:39:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqk0mxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 10:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhnXUGFB3Cxtm8GR3Q4AIXBbcsLHlpXYO+ghsbK82l2K0WI7Ajh6WObmGkhGZI1HubivR62NcaP3C0QGfB0sJB0zd1TQnUnCleo7WNpzTxuN0q14RC8O9Vgo1/qbfbvIb6d6qJO43YvVxBIiAkhfQuhWsPHbUzUdiRGQGUeVpCECfMjs0M+jWRdugt88pvnkE3ue8QWd8+SAH9XKfs78Om/9+7bDeDXQyrEU8GcWVk59zZn+ktltpoV38zlv03RvZdrEheiD5OreHdcvOdTbdbj45lh1ZHpO1xtiPVCBy8noujPVj2rRQb4jTOohTz4/t/WzBqDIaKTSfmkhAJRBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwqIlx2rcPcAGeZQoD37N68KtP6C/TRbpxoarYxd6bU=;
 b=fXL/0+ofQg3F78ddXSS9L60+xVtMr5AitOqKOYjf1Ekf2PZ7I9Iq8wg9DEB+k3cCJVuolZR6jaCOE4DX1PH0XwL083ayjxJy0SJY2n/qPl+1YMt8uDjAcJeXQGl5Cn/b3z9yamPTSWwYzOylGUtoXpkWho26F7ljmW5TMavpBb8BPB45F1+a4zHJIS+cH+XbZZW4JffZuADL+3Lh+eu3LBehKJwo+iJiS/D1IPgAOLD1e0AQkcWQbOHNCVwq9k2NbK8RxPwFMiGnU+ULuKtNwmhUSkmOCi37SIJsui7e7t9fAMRC1+SHW3hY+AxbOhXjnRRD2BSPV9leZYeEDEtu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwqIlx2rcPcAGeZQoD37N68KtP6C/TRbpxoarYxd6bU=;
 b=wzFp0WOgj5AMQP5swBeUWysAoVIMKZQQ0vPnRoJTBF5KzKiwROpSMtkk5bzBCEf8HPE5yfX8nH+JUDRdEXYRXS+cvu9fuy7lZdU6gyfnTocF6W8Mb3jWMft1lOKCm3s4euqJGdEYQMc+d4tXnlb7WVJM0SZyLI1IVpSSMtaqYto=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2933.namprd10.prod.outlook.com
 (2603:10b6:a03:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 10:39:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 10:39:51 +0000
Date: Thu, 11 Aug 2022 13:39:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: elic@nvidia.com
Subject: [bug report] vdpa/mlx5: Support different address spaces for control
 and data
Message-ID: <YvTcabeJrDkd7/MP@kili>
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8de1be1-b7b4-4d4a-1084-08da7b85d22b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/qRdKt8LdL1OTdzWHgl0goB+66dtqFRPo6YOnRVvz/PM0Bly78ig6I3CCQfO55uoY6RPRrUYMvFyq5pE2w6QjPHrh3yFJnd82aBiNxhFHLXlvtImYLQDUd9Trq4+Xvr8Tuk37skKH59jlZfPxCHeVBQQrXOycP7CVQvRoRdxi3uo46ab9R3uzrx1I+VISWgl7Mjvc1uNoj2/DspbC+lZ3TZirnL2kk2J2MvQhJ48+tvEN5v4wleA5kpMemYKd8RIhtQjqef97ciqeDcgEbXcxd0dQXcdH7/dKi3QFHQICnzT7PdiEOuPNUbjjs7p76p9XNCwtnVOjwXnnIpreznpNq+p67jsaAcOawldyBzsAjZkuUhDcA4dXJ4wuj7rOH3ub3ho8irPcu8jLiHm+IT5xEKN8VR2z+jqH3OZqmRlRQ20UFVnq8PT/i7rhGC3/qthhonp2jasYCu216WkUA1BBrSqZgUhjGu2KgdsThxGRCYMDErVyF1+DJz6490OUqx34ChIkg73R4x6M2dBbzotCY2Nl7OJSIIlgelkZj+pUlm1aD6rFQgtR25tsKYj6UryRRnPw10R0PSu8JYREGwjIwypiEqUyDCY2PC3ZUlSCFTFf8mEkXzzZxDJ1+8m9aAmOhh/NLaICdQZajjqntJn8VAGR1GUQ2idm1PrUCSJdsbFEucHGTsKkWojmHtOlFHzZkhsgG0afXMUBZd5OmZwbjPxG2rdY12tnKHddkwv/cJ3+n47HCUsLyirULHrmA7amibRSqje9sgiIkHN+NmjX2VdIdKdKE11DHDpPh8Rxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(5660300002)(6486002)(478600001)(186003)(8676002)(9686003)(6512007)(6506007)(26005)(6666004)(44832011)(66556008)(86362001)(41300700001)(66946007)(52116002)(33716001)(66476007)(83380400001)(2906002)(8936002)(316002)(4326008)(38350700002)(38100700002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2JeJs3Erk6N62GHlaCiTxWKGQfWdlHujMce3gVqFKe4iKWIISsr4K4DDW0pC?=
 =?us-ascii?Q?lAQE+cwEjClEpZIkid2tcY3YUGRCPhi/TM62P/Nr0prsInBvab3riW47fe/4?=
 =?us-ascii?Q?gwegvFmZabK+1pZ5q2NBA1owvf95D+xtE+YSZMIwsmPykCZorVI1a2RwA/vR?=
 =?us-ascii?Q?ZVyZMwOnbqrwtOnnwfasPiIr3BBdUuh9wAwdZpqzem+1zNlTRjeg1+o+Hi2x?=
 =?us-ascii?Q?bhcWBCCffTW7KYUm7EHZhTqHoyy1tqJxRR7T2RWvFZhXWIHP6lBNLKHeBp/D?=
 =?us-ascii?Q?z9pW5npNoVaE5fsdFFzENDlECCazEWTRtPWBhbEVA4ta3VHWppK8lcfYm3Zk?=
 =?us-ascii?Q?PnOiB9siUb6Akjkx1CcdRPKF2eVBp4zCl3GiRQ51ymK1yJwJVF4zHtuz9nRW?=
 =?us-ascii?Q?7Sue0VU3B+5uolXcsPWgKHxkdOIhqD62RDnQwRiwTAIqqNQGFbZXXm455zMZ?=
 =?us-ascii?Q?KUbms95L99dxTHNRQcqig/0pSllEPo/IxIst4b1v/C4KnGdpcqkjsxHxnloh?=
 =?us-ascii?Q?2Uoo1vE7XCvh0AE30S2zN1dGFXZ1Hk5zXn1i4rjJYR2pXFAXXQqCjJWvBKvo?=
 =?us-ascii?Q?3sUY0H8ZS4ulMHKdYzdkJOJHCeUkFkqoA5x1RJksYf8UQ52THlh3/hOtGDI7?=
 =?us-ascii?Q?BfwJogAU1MEgK4+w/tjQBVS5CcZhPwtxNngstsz2rluaKCKnO1oI32WJVnBE?=
 =?us-ascii?Q?x3t3gqY/VXxTigRFOHA9qWC9ixtqJ1xh4ZHdJt6vCpqvIiorC9nvW662ZsZV?=
 =?us-ascii?Q?mn9SFPOtErbcKH/+ND/SqKP9PUxqZhh16itRK5MFuapmWZVBoccP8GEKKUPb?=
 =?us-ascii?Q?00QJ5H69Ra+VaonXbn5dSLZC3FQ3u9a19YrwPovnlXzhigqHHOCRKPyj+6cP?=
 =?us-ascii?Q?npEsaM+5tAqqAn9U61y5Iw4M7fgJup+rviKtYRi1btnSOWWvISCIeG4c8zZv?=
 =?us-ascii?Q?+Rth/YeMDDH+oBM1J2X9JIU5rXC7SdRRmpvTGYN7Q1iMk2Oq9EsuAIX1RK/s?=
 =?us-ascii?Q?FYVK80shkS1KrQ/J/0qwoT+KZD0lQysoxRZgKRnFpnwnPvUUPY8+DPCLnQiq?=
 =?us-ascii?Q?mSf0gnfB6B8DUgooqNjupiWu3Bx3nG79sbeqQDIwcN5oyxpX+539YTkwuwQr?=
 =?us-ascii?Q?jckkSXD/JcFhLY4fur3sHpjiBmfTgBGmckSJ1DFmbiVOn9+TJ2hO7gC+9rl/?=
 =?us-ascii?Q?n5n0M8gJ4yYZm1P2L6C7r/F+soKXpNCVFE9OgD6tuDLe49t5/+8TqlDGl7G8?=
 =?us-ascii?Q?nxQ5CMOWTho3LaWpA8DAtwgfBktTkOkYKJIzAVcOqLe+2baUxaWMM49uLnAb?=
 =?us-ascii?Q?t8+8v/4VF88SbeoY14YKSSyWdVbz2cgJmWQu1FxuYfISpmuNm4aTnIrE9yLo?=
 =?us-ascii?Q?cP6kD0zgDvFJjDgwnKDhrdnn0BGuCvL8huhDATKHFzAV8CWm4covkH9NmmUm?=
 =?us-ascii?Q?T6D3ySgFVbHC2n9V+VQ+MHy4U1B+WhixgWKDCtsReyNDP2eG4RTjqzOIhoRi?=
 =?us-ascii?Q?tdcusswC4l925Zik/P4oytHdxfJKunE6kyITpF6/FwmtqpYfFfmFPw2Sga23?=
 =?us-ascii?Q?HZKFhXV3oK5epxDD6UsB+xoSne10Rekdb804Q7KuHqS95yDD+v/gzE3z2liF?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8de1be1-b7b4-4d4a-1084-08da7b85d22b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:39:51.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAfMQiyvx8d2YHoGzjYW9V/8vsIzcOjw7aNdfKTNzUcaAKLigTwSKNphHBHBWLTeKdeT+q33aX1D5F+JovJz/URRYGspaXKK1yZIwnzokDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=663 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110030
X-Proofpoint-GUID: iabZR8Xrgl6A5sHsdl_8_V4ayiWkmcjc
X-Proofpoint-ORIG-GUID: iabZR8Xrgl6A5sHsdl_8_V4ayiWkmcjc
Cc: virtualization@lists.linux-foundation.org
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

Hello Eli Cohen,

The patch d5358cd0e369: "vdpa/mlx5: Support different address spaces
for control and data" from Jul 14, 2022, leads to the following
Smatch static checker warning:

	drivers/vdpa/mlx5/net/mlx5_vnet.c:2676 mlx5_vdpa_set_map()
	error: uninitialized symbol 'err'.

drivers/vdpa/mlx5/net/mlx5_vnet.c
    2657 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
    2658                              struct vhost_iotlb *iotlb)
    2659 {
    2660         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
    2661         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
    2662         int err;
    2663 
    2664         down_write(&ndev->reslock);
    2665         if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
    2666                 err = set_map_data(mvdev, iotlb);
    2667                 if (err)
    2668                         goto out;
    2669         }
    2670 
    2671         if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
    2672                 err = set_map_control(mvdev, iotlb);

err not initialized on else path.  My guess is that one or both of these
conditions has to be true and this is a false positive but I don't know
the code well enough to be sure.

    2673 
    2674 out:
    2675         up_write(&ndev->reslock);
--> 2676         return err;
    2677 }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
