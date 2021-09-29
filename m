Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 11:47:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F5161247
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 11:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5F5161247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9ECBD40134;
	Wed, 29 Sep 2021 11:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GS72K92uxxjq; Wed, 29 Sep 2021 11:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E66B6400C8;
	Wed, 29 Sep 2021 11:47:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2A1BC0011;
	Wed, 29 Sep 2021 11:47:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6CE1C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5142400ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5OmWaS4UBXP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FEE1400C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:47:13 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TB4GEo017401; 
 Wed, 29 Sep 2021 11:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Z4tgpuIMI1ytyKE21nmBNWLTPoDA4C8OTU52VepE9VA=;
 b=nJkpMut3SDR/6VUWIiHZVBgfQdgjbTn5g22ffQtbCpzNe3x1NllYXQuTWJm4ufYFjYmT
 kJk2DRfZOYsfmSC+ohNSX87AoDWGvtfToUHGeD+QxfX+WJ2D8UBw1QKVKl10C1+f93o2
 a9YOTSdXa+jmlrEqEMjjo8Lh4o0rjQZPbwKHY1sNLjrCrdDCv1kapnkKm+A16B7qceGk
 pXZroIoI6e86rrBR9nkcaLjCHv7OAJ/9SqI8Z8wc/NeoM6dnbAdMXvUyVFTjobP3D2t9
 toJXj7udX14ZlRxGjxate/igAloHr222uTvqU4hMaEa+/1NOPAoM6xG2S6HOww1gmc4f Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hjggu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 11:47:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TBjevv173921;
 Wed, 29 Sep 2021 11:47:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
 by aserp3020.oracle.com with ESMTP id 3bceu5a4jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 11:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2k5WShHEkAiRTCIPcYdbXZO+lG+OKf0uprOEa1fT2Pwc0JYClgZ1rr+SUcSacMrHwmMcmQ4bQ4rr1QZnz/kJW+oEA3i3KCvlRWTe1pM+Yhpa4HYLPh0alxoFigs9iQ5RDR6PWb2rcxezmFVRCHRZ0r6NJbCvO5ECfDyv1/EoFK9b/AKTOQE6+fMGnNt8SBhBWMGTkboJznYOtOYSOzgeK5DxbkevBWSvEL+tgi8sf4XWlewvslti9+jpucRvA25tnrLFJzkAHjpcGbvsLxGHgO95XC24T+xj/8gNw7jlIPxkfc8gudU59I5WpvincHd6rgXmoi/EHvoi7CHwa7HQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Z4tgpuIMI1ytyKE21nmBNWLTPoDA4C8OTU52VepE9VA=;
 b=cqIYiu82dREMyGppn+gUA57J+taF+2+PZAbjBHhdRJaNWskZ2+Z/mJh7uAWOEYGpAdSFHIgWhIJTOuTMC+jMyUs3uJEFgBIRy48Cqdx8niW7XgEPlAdSRqQuaDMfcS9G9ciH07BO6G8Yd7XrxO/6wQBY4pPXMP6pTCjywP6xqmw+/6si7ZX6uUY4BgknSxkyEvB76a3TBHOunanruYcptDtOqBk9i+5exjEt435oBtlSpCSMU83fTc4fW6Qum8hZtbS1Hj/DmfAU/ykmKEEOcAAXuOyCHd8gFg1YKiuFOtLOTzzmUsb0UgeGjyJ2XEVUD3B1CTZx3nhiGJYn+oMD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4tgpuIMI1ytyKE21nmBNWLTPoDA4C8OTU52VepE9VA=;
 b=bF+4wcnNr6kpS8Ocs7kzuZM8LvTZPzXcKT2C/0h1pHlKXBnyvY4Uc1//rLYKG4/4RTzOm80Cdco+pWpehZBVTW767F92AjzSyZM0uVl+epmIGzlJarUJCVvdSm1iWhZvOiD8Xd9bCgRdU/ePQxORFVwc4MxHNkRY0fXJ+0mNKfc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Wed, 29 Sep
 2021 11:47:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 11:47:09 +0000
Date: Wed, 29 Sep 2021 14:46:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sgarzare@redhat.com
Subject: Re: [bug report] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20210929114652.GV2083@kadam>
References: <20210929113742.GA7928@kili>
Content-Disposition: inline
In-Reply-To: <20210929113742.GA7928@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:0:19::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 11:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a38c7387-bec3-4e97-26fe-08d9833ede0e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB236698675C70F01B4150687F8EA99@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1NAFgUO38fLv+6rYYW6aDp6eUuypnF44s+fI3mHr/PqPDuWMrPlJAPzX69cjGmLKCWIgQ21l7jPSIMpSUKu/5QCabDDcylPuwpjjoc+7Pyp1ouP3Jrh4GC31Xcad6KSqK2TS5+xiRMZAy3gcATuBIANdU2HQXcYtANz1m2DDtkSbK/5VBxxkPzQh8CDAK9x5MDf6EXPpNG/w9SpKX1G7p9gjFSs74+TtvgbznmEkI8w+TEevGdUZyaRlfpgLoZ76r1MMEqHazcQBR9KxXfr1ZjVVFa5OJ5TAn9hY03CLT0ZoM2WKvHUMocbQeaFP4cAHVnxum6g88ZkSyD7NmeUwVloCsHn7DkMRZWDArTcFx2OTJd+ebtn8QyodbtW1Xece9f5CbbuhiuJRV2k9xYaT9OIUCGIosrvxVWLJWXpO1GYR72I5t3kwXowXli8aDZShmTMgvyQ4XggY8g34GU2I48VNpY6BZbz+Er9Dn73Xaa+DGz0+6tQ+VPwSG/H94KW7HxZR/fdhCmyjDQRcJFfkzT+dB9BToJp9z0NV0rWZ+oqw/WGAn8ecYUpy4WV/6Fj7xU3h4PCcVpyOdZrOyDW+j9bNpItbKcKAEA44VyeFx7zz6Qanpy/0y6k/htykVS9WvyQ+FsFpLY6bxYZGyA/9AKnTZ7MnV2t6/3i2q8P8vzpiwY9j/yUq6tThiXI2jG63mpQ3N+xDJ0dKY/2nB2oqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33716001)(6496006)(1076003)(66946007)(52116002)(9576002)(6666004)(44832011)(33656002)(5660300002)(2906002)(6916009)(26005)(8676002)(508600001)(38350700002)(38100700002)(66476007)(8936002)(55016002)(186003)(83380400001)(4326008)(9686003)(956004)(316002)(86362001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jig6jnc0U+4oiGvBSffnXZ7dR4AoXnLA1i9xEr/QWcyma7Z5ocTJx4OuS6c?=
 =?us-ascii?Q?GjMyB76F2T6iDKsnnUqNmXSUHA6H6AkC9p9zjgAU+HCgVSXS5yQykR2FW7SF?=
 =?us-ascii?Q?ssKGnIMXg29Ica3p3SM2Ldh+c3w7oKQjlstCBy3ViWQxe2KfASr7fB2N94Uy?=
 =?us-ascii?Q?l4gSArVJkYGSe6srbJO00OlND0jLehEWe9dz9OkeVFF61bKUuMGzqs4+Yt+m?=
 =?us-ascii?Q?vhUxQGOizKP2O95vr7q19wOKFn9w+mPxtD0dQJlzYZIogiUOkwl/H1dmKKs4?=
 =?us-ascii?Q?p8j6LtFVCLbfExrOWGeK9HQmhAAGGCUu7/SEsujcRv6eCSuv+HsYVSDVmakG?=
 =?us-ascii?Q?McZCGjNBGXDCmy5Sju+LNJZ/jhX4rrOaWe3mWxd3vJiunZbEFiqu54DBLMUm?=
 =?us-ascii?Q?cg/lrq191zRvBZ8zloDD/cL7bY1Zfugh1Of+XNS+cRIUJWUp+cBkoyqHKNLg?=
 =?us-ascii?Q?gP5c7JJQ9DwfZ+0xI/YBurHF9ORUwPg37YwK1ZLo0rJhcdY8VquL3F6QY9tg?=
 =?us-ascii?Q?Eh7YWFpvOnU/gxCDq4i/YPTc8TrG8UceUDFS43CB3VSQTqnuXeREGxugxKvn?=
 =?us-ascii?Q?8GaR3XUOgptu3RKZTganZFHzyMl0JluCiFExXooQmGAkL+9dXC5gECRbF6XS?=
 =?us-ascii?Q?6QYkBkvukDKiN1gnK6bB2YBOvZRgeZYNIMDI8htY+MvfgFDD0kI5y0SFCO6H?=
 =?us-ascii?Q?RQTvjqWLYxkVdJjMumuRT76SH44kT7Vkttn2WPaza05dT3zCD0npwAFeI2fA?=
 =?us-ascii?Q?ykbVFcgHS/tPZT0ObgO3SPekz8CieFMCZnvOUaitrJy0OeV/9tAZ06moxf2T?=
 =?us-ascii?Q?DaK0msax7eDJaFhhnd6HySgqVs9V8X6NEIcQ0UNAuMjM/1Oj4/51MzK4s3AP?=
 =?us-ascii?Q?jTsaYu1ziKvuK+4pMvPMzsOHPoY0SdZHn63Syh/7h7tLzk8nht1eMTFyDAYy?=
 =?us-ascii?Q?xZURCNKg4XXQXzUfawjVCD+CmAuH/ClrJ2xYd8SsSH+1mRKXvBa4fof9wh1Q?=
 =?us-ascii?Q?IdmiJYnWVcBPkFXUDNXkDX2EyJzj6iZxSA3PkGxZb+ZuOl1E+Xt2uoF8Pe99?=
 =?us-ascii?Q?b6ZbMZ1q3GjFH6fnjuZjuLUuwnwYy/2TW0Xt5OWJ1OuON5y1XLchvoCUu4jF?=
 =?us-ascii?Q?MKQZaP3ZLAZIW9bxpWNYnuELzydluozxnvvsreGQqy66jf/rfCM2mP6tvb/L?=
 =?us-ascii?Q?95hB8CRUji1ZKY/opAhyR8z/bkLWozsl9HWQGkFwDaPsRJcOgdv5+Hs0JfYd?=
 =?us-ascii?Q?zlN+1J9FaHCyW5WD6h2cQTPU9WfBvjd0MVCUJkU6iwE/1YN/yMhpqboT9qOw?=
 =?us-ascii?Q?TQnWVhrroKRThCdTDApwgFqN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38c7387-bec3-4e97-26fe-08d9833ede0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 11:47:09.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztqeaENcvtMzIN8YK4dUHvV3hM+/t2NoYCZp6DnJvZud/4K6Vry+KKHliZ3SLximvrC5fgpLTgZb02BkxooQ5MwptYxfzd2FI5y1geCSsw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=985
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290072
X-Proofpoint-GUID: wMEVwPSt7IXbAxaakA77ybvOmtlNAB9A
X-Proofpoint-ORIG-GUID: wMEVwPSt7IXbAxaakA77ybvOmtlNAB9A
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

On Wed, Sep 29, 2021 at 02:37:42PM +0300, Dan Carpenter wrote:
>     89         /* The last byte is the status and we checked if the last iov has
>     90          * enough room for it.
>     91          */
>     92         to_push = vringh_kiov_length(&vq->in_iov) - 1;
> 
> Are you positive that vringh_kiov_length() cannot be zero?  I looked at
> the range_check() and there is no check for "if (*len == 0)".
> 
>     93 
>     94         to_pull = vringh_kiov_length(&vq->out_iov);
>     95 
>     96         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
>     97                                       sizeof(hdr));
>     98         if (bytes != sizeof(hdr)) {
>     99                 dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
>     100                 return false;
>     101         }
>     102 
>     103         to_pull -= bytes;
> 
> The same "bytes" is used for both to_pull and to_push.  In this
> assignment it would only be used for the default case which prints an
> error message.
> 

Sorry, no.  This part is wrong.  "bytes" is not used for "to_push"
either here or below.  But I still am not sure "*len == 0" or how we
know that "to_push >= VIRTIO_BLK_ID_BYTES".

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
