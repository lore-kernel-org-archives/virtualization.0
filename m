Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3050FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 11:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6E8360E61;
	Tue,  7 Dec 2021 11:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TW6QTNx65VP; Tue,  7 Dec 2021 11:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D0FF60E5E;
	Tue,  7 Dec 2021 11:30:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D52C001E;
	Tue,  7 Dec 2021 11:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABE62C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87E8182AB6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Ck9vPBZW";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="TYZzRoje"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2IPFlRhRXTz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:30:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 728A482A7F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:30:37 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79Dt9e019276; 
 Tue, 7 Dec 2021 11:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=17cgiKoqTLKiwEhKp5Fmr3U2RRJUYH4Avp/3Vz8+zWI=;
 b=Ck9vPBZWQUhVwzRxSp3ahpKL1xITynE5scLh0MtIcDsqf0wikKtwudfnF3sJr3xLKiuC
 6Gi0MLAeLV4kyfkLHRtJi4KbokZsio+sINTHto3AoyGQ6XaGImZUIuBQ9kEPpsSCgWMq
 XNXIibEUZubHyaqvY9A0kRAznzmrEdu55TeuRux+jgi0u2KF9Jc2RiGLQYHnZLQU6QNF
 DUADN5Kf/XxcRwCOvty9YQUTDNJfGXp+1fboNJQtOgc6goK8rTQ00PFLVlfzQ1HCTvxp
 J88jFYnQGNseAFO3YppiiP/BVliTVjx9Gk65mZYo2JnTlCy7TYm9P/Qp4Q+CyBdYhujW kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqnfnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:30:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7BL99i186283;
 Tue, 7 Dec 2021 11:30:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by userp3030.oracle.com with ESMTP id 3cqwexj3q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Q5lYZn4dld0l25FjlWiE8MZpEvagVV1sEZbtgjlNVK2I3fFvgHrv6GN/AW4ylwAMEGEfm1+PU+ArSiBVH+0TUVM+brLPVA9KhSXJNbFBtLjN95ZGyF2rzcSgsN1g0iFOUD7qOpEaRoyFYOiLEQq4MyIfJ02jyCbxiJrDfNJkF5nFWf2sPJqjCwG8RnQ91JZHoMah9iqIwLKPdjS1CMB/Yqfh7t6535pi3zWAy2aRYZu1U4WrKua6ylxNUPuOxhck7KG+DNRllxqrYQQav4AmHNrFQb3dYaAf/KJc/tAxB9NHOQd5M7uox9N1RVpDbcVWdouiC7kAqaCR4bzTvluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17cgiKoqTLKiwEhKp5Fmr3U2RRJUYH4Avp/3Vz8+zWI=;
 b=QQhoMrAFVy+4oldXZbJeH+ggW/HTeSNnzECZuU0QV6/FJjcTqJWuBgUcBhDS9ArEEDxjKKVuUSqEOKyESG/nLiGSb0Dh/moISMrJD7osVHQoYl7SKsp9Cce2Uwsv0ysy3yiF7sFfd0/EgGyeEV6DF34IYaGYpfBnDxmZMopEO6wOSvzxV8ckIotbUxk1GqLxR1i9EtG/VqleXTDf8tZkydyUj7ZDh4XNVSd0x0DdjHz3PyMvj25jQ9yr7wW3VJswD3uaoy0JXi16It7ruyXviFEyK9NR3nmYfhIW1TLJKevYL2fAqwMpJfQfJ31NidKsYNjQoObtB6aKK4Vx+3MgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17cgiKoqTLKiwEhKp5Fmr3U2RRJUYH4Avp/3Vz8+zWI=;
 b=TYZzRojeCWzF2F2sd+jIXJ6nkD0av9cbAnPcpLhnRIvXsZnx4mYjMAVYfQySpquBS3g8tz5Gsz6iiUbrgTqfxqb0LVXcRFwTpp5F8EqMBpngmGf4jvZDVX1dqn6YQLHs0jIGwrY2HNLp6mK+nB3dN000E+ud3cYnJ2F1SxCgzhM=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR1001MB2166.namprd10.prod.outlook.com
 (2603:10b6:910:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 11:30:32 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::fcb1:e595:35ee:6233]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::fcb1:e595:35ee:6233%5]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 11:30:32 +0000
Date: Tue, 7 Dec 2021 14:30:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: fix memory corruption in vduse_dev_ioctl()
Message-ID: <20211207113012.GI1978@kadam>
References: <20211207104614.GA21381@kili>
 <CACycT3tTao93MvoU6eGf3i7mEjfxm-kBAGdGRghUb_AuCeUnwg@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CACycT3tTao93MvoU6eGf3i7mEjfxm-kBAGdGRghUb_AuCeUnwg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by
 JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22 via Frontend Transport; Tue, 7 Dec 2021 11:30:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2c95813-ae2b-44a6-4cbf-08d9b974face
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2166:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB216642351B96DBE8C47A3B278E6E9@CY4PR1001MB2166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adMuyL/kZZ/vhg4f8MxfMuwC7+LeqW3sbJn6PQeQAJe88zDB5K6dwBwO9uN6zTcTVyCXcaZCvS/1Lnc/W+sFJ3c2Jeih2FNWCjT8KbFY3E78dKa0XjJ/GHjOcu/CewVflPEV9zYOoCb4Zm2sveaSx5NXgOTvQBTxtttr7psrIL2/q2bUisLuGgoOGtvxcPtkKVHGQi8Srqq1b78ArRmHSSUe6RbN5JW/YKWFD1WTmPQqBG9vVolnLYF35yut40PnHyhFpremSfOkqWtP6eqwicZy7opAjd3AGL2NE/Z34LCB/puoogBBdwSrTUossI0niuYltfIwmafqWaXsEOwY8vq24ADXsaDDS4xb84FvTFqVg1UV6HLSoNb0ie45ZsFgpDX3pDyCMfecgRXiv47XqFwANZriMwuh0GrtCZAyrVTTFmUGyZT3XZXOzBs9GmeU4pQIX2a14/ZeKhCKKXI04I+JdeYfmj/JfS8cle7psaeaARBLOsW1ZpzMQUpGsOuOd81M8TTDD7uxoyqCLl+D95aIHWALwRdqhN3ECnY0b980IRFKuaBzi46pcOq8w7trTOqmFSNjDucpI/2EGvjohduf0Hj3Kk5AInzMhImKnnXQu+5nHLD+aRaWoXpk9/rAGr0LtlsDXM332kp72kYsyhOptJe3SpOFxsDcIt1ZcR0GycACvXfFw3bIU7kUvnwh6RtKiPtPeinKtvkNTKC/8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(1076003)(5660300002)(38350700002)(6916009)(38100700002)(86362001)(8936002)(4744005)(66946007)(508600001)(9576002)(66476007)(66556008)(8676002)(6666004)(52116002)(33716001)(956004)(9686003)(54906003)(26005)(33656002)(316002)(44832011)(55016003)(83380400001)(6496006)(53546011)(186003)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0+P4ZtwE+W8KvFKV/TDT10e5lhiP5qisBaBMldovFZFjuqgAEfZP50pC5jE?=
 =?us-ascii?Q?MOcgmoLyRsxmg8ERPv0PCndgi8ikDpYF8Aulh0DgwgANi+NnhJ1kHzbEx/Z9?=
 =?us-ascii?Q?O4kFBBSpI/h0dsbsRafR7EC2QGgoltspeqAutjQ3jPfbWr8+0bI4/81p1EYV?=
 =?us-ascii?Q?FDVrAC8fQQZqUuAlNZwMBL2jaJkoFMPgZfaIwnuvabWmIdnVeExv0W6it1Ob?=
 =?us-ascii?Q?fM8IVFq7wd8idBCroFiwXnQOFHXcaVRKxAgCv5LRODgnwaaG3glyB71c06sD?=
 =?us-ascii?Q?P8O3WBTEpk2xTOhnsoljNes4lB5hl0BijOGLMx+j5nu9rQGmTVmnwo79JZ58?=
 =?us-ascii?Q?/o9g5Uu2jlvdncFu8GPWuMS0ngXmnR//js4tZwn2+Q+r6Ity3pP+vlENHoil?=
 =?us-ascii?Q?Wo9B8qwQSmFTpV2T02UXQjNo2h/B4eFtDGF7G/0+RzuXrB+3ajlcrG1Gk5HO?=
 =?us-ascii?Q?iYDYlj8e9uwrg/5nwnN3CZTCpeKZmrypcbNRxRFJmhEhQBFN+dfseSj4EO2g?=
 =?us-ascii?Q?coYtvcraxzIBDTaqVy6AeH44RHhh46FlG2f8OfCO2NK2KPucMCz6KEeIGs9H?=
 =?us-ascii?Q?caiwR4l8psFwJErehQRnDcwc1loWeEkURb4EaWDO18idSZ7mVn2kXaRi+IWx?=
 =?us-ascii?Q?lTdqhU+W4fLGE6w928tcad0C7fOqk1X+H9dqIAOeVXoalMyXsF0LqEKVLhQE?=
 =?us-ascii?Q?jfSbcATNcJXISQaODIOg1iaRRscrU6ZdutBFpEOh8EzDDJ1va8XZ8zLpDa8l?=
 =?us-ascii?Q?7SCdyvbFKLymZbwgHf8unwp+hA9WFPSwoToNUkulBTHQNgBag5yTnxB6GQVD?=
 =?us-ascii?Q?u2Bm8MAd7BWidH4nGEq53WkhG+380NoGtDfSBnEKBHw65shsYRkaXrzhL4Ed?=
 =?us-ascii?Q?zATgqbXtVeQ3Ify8J5H0Mt35EvezIpabSo4VBp2Hd/uYlvkR9ZFm50LwboG2?=
 =?us-ascii?Q?qcOJDTlvYxgL6tlPjhVIsUgw8AB/AKSZcsOz6Kd1J/t1PtE/rWObXvykdHai?=
 =?us-ascii?Q?ic6vyc3971woD+OUOMs1VnYoWZga1rxllxyCwC47nrDCZ0Px9GtXZ5U6KEXa?=
 =?us-ascii?Q?mqoXFXWLC9UQFVyWbBLYlxDWdSS6lLVq2cufzvZrevARPL+bcvbmm4+6V9zD?=
 =?us-ascii?Q?2Wx321MP8Ltp84kvHHkiS6vOeeaFzztnkzMXNgtaH4IbPbaGPvo2d8YMik4j?=
 =?us-ascii?Q?NHWDxPmC3RGnh+fecbslbUhktxF7i7QVAKfe7iJJIcHIESYt+msgCoEvrlyw?=
 =?us-ascii?Q?QEVU/5ENsTb13c3TnyxRY34OJo/jgi/Clq1gTL/5ZXqmD1oVZe3UwMDFKoJI?=
 =?us-ascii?Q?KocBaozMKyuT/ishDqHQhkxBNxAMumnOu3FYrb/wVs0nQEYX5T/QsCFjJ+Ag?=
 =?us-ascii?Q?0ddHdl+NhAdduDzpKSexgVGbbUYPSJb55DbUp4bjcNIPJ2zM7SuqWzY+d8Fj?=
 =?us-ascii?Q?uoJdwU+MQe/fJRI9mn6rBMIFTllHSOstV585lfR9LbAIQZmemJIX8VxZg65J?=
 =?us-ascii?Q?iNT+z04fAoyrBIGiSzUbBN5ZzXXjDJxqK8gyonGaSqHgxKGigLW0jQBDiHGs?=
 =?us-ascii?Q?tVgVKQ+gG0EJqu05rPciOCn0f0vJKXgluuzv6tQFybwN6JSnVElgX3F5/lwA?=
 =?us-ascii?Q?CoFUE/+thDYHzcWDMpzk87P7vedWpHUomOggtUWOaaI3dmaVq+OFuhOyGlY2?=
 =?us-ascii?Q?D8xnc9Xr6SJCwUXA9qjwksVdyQU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c95813-ae2b-44a6-4cbf-08d9b974face
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 11:30:32.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ4jDTFeDIMzfXfCGVnwsT5zWN/98wZvIlDzNp3u9slgsxv6sw/sozU5afJT1iPXtKmRvNT+/4EPW9LOSvDVyj0aKymkYyerCt2O4LTXdR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2166
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070065
X-Proofpoint-GUID: ez4Ytaj4WJFfQFbML_Pe7WlxQ_GIDzus
X-Proofpoint-ORIG-GUID: ez4Ytaj4WJFfQFbML_Pe7WlxQ_GIDzus
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Dec 07, 2021 at 07:19:35PM +0800, Yongji Xie wrote:
> On Tue, Dec 7, 2021 at 6:46 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The "config.offset" comes from the user.  There needs to a check to
> > prevent it being out of bounds.  The "config.offset" and
> > "dev->config_size" variables are both type u32.  So if the offset if
> > out of bounds then the "dev->config_size - config.offset" subtraction
> > results in a very high u32 value.
> >
> 
> Thanks for catching this! I think we also need a fix for
> vhost_vdpa_config_validate().

Okay.  I just sent v2.  I'll send a v3.  vhost_vdpa_config_validate()
uses long type for "size" so the subtract works okay on a 64bit system.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
