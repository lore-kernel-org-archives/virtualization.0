Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62048C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 15:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00C8B60F54;
	Mon, 30 May 2022 15:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gJRNNczpVhX; Mon, 30 May 2022 15:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FF7E6114E;
	Mon, 30 May 2022 15:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64DA5C0039;
	Mon, 30 May 2022 15:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F5AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FE8C6114E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5U8KHY4n54yP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 932FF60F54
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:13:32 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UBGDse032424;
 Mon, 30 May 2022 15:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7UpTCjhWbsMFJ1EL7u/dnAgR6oI+b7MY6Zelos1YVZE=;
 b=k9FS0LNQuIHqO70E/nlf8rxxBMeHCbXMy8Pir6tA4No7xIeBXNUbeH6hvK9+PHxAFrs3
 xPyvw4x3XtqWRrVSl7A8bREqNCfnzkIhnigpE3nRHrr0RtznbnR/bAeG9nCedxbBQC35
 LRwXgHozo9Jc4ym9wyIA8Vo4uscKEmc35CuKM0EAZoohTjDQN0/KM8Wb2gZWRKQLomOs
 sZhIDbDG/uV/lgrkmUOhTrgJpi+XSg0a8Po7NR55UeWrksla7YXaRqDjtZkNBlpRVqXv
 yLzO7CVIojXk5r9CfMFKsmJFQURn1kqWjaCkEkxweHcHF51C/D5VywOs5WREWJEVBrSX gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahk97c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 15:13:16 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24UFA8vT027730; Mon, 30 May 2022 15:13:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gc8hub5sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 15:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdWm/WVXfK7hqTD+W3efM38xWw4k9/eg0/yWwI0uwJYZY6zXf+xCAHiN4+WZPfouLEU5qfBst0LVze6zP+B3C0PKDFRSqy7Vkdk6P9095AheCH+oOF6d+8KJe1mbSLFcMv6Pa1VLcxdGkcnV711Ztgo/lHy1AWs17TGXEFTiT5o2nvmCRxipb34o61qQZ5zITBADjzNZIEsqmUMNSgbJpgA95aGrJGVLEswCVuxiHUBOXDza3KHqzOstdiDpz/Y8zYTApi+MKOKL4eiTq95kqtJVbU387GQP6F4iWIEGWMMy+aH8KcBJf4FXXEdcPZTQdJS1dtHLGUgLm9r1/d155w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UpTCjhWbsMFJ1EL7u/dnAgR6oI+b7MY6Zelos1YVZE=;
 b=LG4qGpXAR5coN/WNMGl6AKQCFlAUsXFnwrbLaOF54N7m1hhp9fYeAABXShaArOlDzYc0Bh+UKauZcJeqKo6SfB7kqvlPiRtn4RCNPij3LfPRqV00KVxAzMKaWxY8tZd9gN3uM75camW4NBW+pAAP3bDIqOKypZQKYzqYMCxXKeWMifH+PkXRsVt1WJuvNRof8YZIp+IfiZ1s6U3mlPiA1cjcNPOBM268ZVdvB73ld/R2/ZbX5OO+UzMpf46Vry4ZK/LCd1SJi/ICoapTXIzlnllyEM/OwV/doY0CPCug0wvs+Eurer4CjnYNEoSngmjJGwvMpQfhzUT3Ttb5FDJIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UpTCjhWbsMFJ1EL7u/dnAgR6oI+b7MY6Zelos1YVZE=;
 b=hKdR5vW8uZu71wYtCsTenqf/AstefpgEkUyIQomCBgB99n98VfFSE9xdDEgMkJBq8pZxsgBq3MM7PEGCzNolpc5V6nwfQbTIqYLrNlR9u83h8j3n3cP0gcpLXsWecbx4NAKmgmvTuLxn0Zban0F+7yWsiJiQBFvuk5oQGQZtFz8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2563.namprd10.prod.outlook.com
 (2603:10b6:406:c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Mon, 30 May
 2022 15:13:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:13:13 +0000
Date: Mon, 30 May 2022 18:12:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vdpa: introduce STOP backend feature bit
Message-ID: <20220530151251.GV2168@kadam>
References: <BL1PR12MB582520CC9CE024149141327499D69@BL1PR12MB5825.namprd12.prod.outlook.com>
 <CAJaqyWc9_ErCg4whLKrjNyP5z2DZno-LJm7PN=-9uk7PUT4fJw@mail.gmail.com>
 <20220526090706.maf645wayelb7mcp@sgarzare-redhat>
 <CAJaqyWf7PumZXy1g3PbbTNCdn3u1XH3XQF73tw2w8Py5yLkSAg@mail.gmail.com>
 <20220526132038.GF2168@kadam>
 <CAJaqyWe4311B6SK997eijEJyhwnAxkBUGJ_0iuDNd=wZSt0DmQ@mail.gmail.com>
 <20220526190630.GJ2168@kadam>
 <CAJaqyWdfWgC-uthR0aCjitCrBf=ca=Ee1oAB=JumffK=eSLgng@mail.gmail.com>
 <20220527073654.GM2168@kadam> <20220530142725.GU2168@kadam>
Content-Disposition: inline
In-Reply-To: <20220530142725.GU2168@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::30) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4b3cd2-9f00-4e68-ff82-08da424eea71
X-MS-TrafficTypeDiagnostic: BN7PR10MB2563:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2563493E7BB8FE542CC14BA68EDD9@BN7PR10MB2563.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KidsgHRvndjYBmmQ+4ZPkVy6P8j2kchf5+3vPLYyjX2wCaoPbq0/gUK7N2XoZ4JBktzfgXJqK2Wp+K+qxBJp03/WRes5BeEnscFVSHU1K5n9jksTFy3p8IuvuJmRFi6z5ugm65sU2fjrorpj75u60XOwouH/1mzts6CRVC0JsseKJe4Uw2DiPD1pAv3gJQdCCYug9XaP3v9VhRihBPQXrWQtYiok7eerDjYviRb2vwXKvRALDMUP5VB6G4iTI6hRt+MTk8BrzuornoPIpPofpxyPn2YNF6IVPegrRyoohbgPohXIll8XPd+qTiDVCw7HRtNQYt44YOiKExRcYBBUC0Ybdl11EgjITHDZPxj854uJ7v6eYCAFWPmBdNU7swO7GnR+VwOwk7/IWR8/g4LmFXyiulgyqNRlQGjwYT/OIllX0sHf2jWNvpHKsDR4HQyI/NRIcn8wvKQ6di0XblGEUzk7liqmnbKulaKT0jSIFTg7iY0xlm4WcpVHgTTPXDeN14s0X+nfGq+cVSJz3rqnTPu1B34oopWQHTHt8D92PhQrhCfdbtPzxzk0SVIOHLoXhTty4750Yi2BWj/BhjeIXk1Y+ZTw1ikZ4/ZHfAsp+hnR7Jn8w5utTdMFhnIy1rZ5WmnPpVRhZupDTaNAv1RjiEUs0SUrFVdcRrQqiBeZC9icW6dvfk/GNLtCXOHOge0gtwGfw83XMxdOcL6dudUL8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(6666004)(2906002)(6506007)(52116002)(26005)(38100700002)(9686003)(6512007)(33656002)(83380400001)(186003)(33716001)(1076003)(4326008)(8676002)(8936002)(5660300002)(508600001)(7416002)(86362001)(66946007)(6916009)(54906003)(66476007)(66556008)(6486002)(38350700002)(316002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnN0E+gwZNdPWRjSGkw5fb5EswA52FGBOetrvTLGVVepsbYlgynHcIqLqtoT?=
 =?us-ascii?Q?fTB9/W5horBc3EqAo79DlwmRKD3a9RvQuQVK1RBUaIpD/lfI4a2hr242xVRj?=
 =?us-ascii?Q?jMdy/V6NuWIuTUYLjUAbT0m9ip3A+ihOt5wsxDZ53PrvksRfMDhjfiLF+bpM?=
 =?us-ascii?Q?s58JbuQwWjQgn3YTQhJhw4ZVgEDGjBOuMaoPqZUBrKelb2uMVXOgRDg6/cQb?=
 =?us-ascii?Q?KCpv3ba8yecorgqbzd/OZU5gljLxvNzjPF9OgEpzzocvbCVBKeXVVSXktD+p?=
 =?us-ascii?Q?GN3xUpAgYp3FcF/cjcAYCKKqiyuiMGhNFdNrowPyGoQpw0eck5RhHGmSycXu?=
 =?us-ascii?Q?jCNkM9EoXbvVIE5UD5wI8zurlrWIFMjCY50AGgpej0QQgoaPLN8VZre1chrm?=
 =?us-ascii?Q?hdDVHsKW6bnQ1D+vGNfDTPgxCCC03dYGIk0V1nzNZLwNzWqpNV1pEKt1Aao0?=
 =?us-ascii?Q?knsenAnBCQgDxdPCqX0RHZ5J2A3jHsmuIcUMCJw34sDPFH9SwEVF6GRRU6sX?=
 =?us-ascii?Q?lwBeA419O5XbLbjKQeXvhmBxn7OVhE18TouC3p2xmAl1qkfj19C6x4+gX2a9?=
 =?us-ascii?Q?1bNDhbHQuj38eEES3ltPpky4L93sYwTaRwRrK6C48ovCW5Oq7r/AFaUVN8un?=
 =?us-ascii?Q?JTI1Bp5Tq/V8axcFgJkZkReg4S1wlUriDkBnqQw2z4psWdC8EBlfDirXZKjr?=
 =?us-ascii?Q?kSiNXotJVRFBnluYOnsY+8UQI+3j8zPJPHEey5wn4UJGXb9yilpa24ILolMg?=
 =?us-ascii?Q?qRtEWwGj4ZTnZDyj6cLzWjanSIDD1tzetQuEE2pyra2yUUKOVh6WOW9MgiBC?=
 =?us-ascii?Q?7SzhR+gGZHnshA808G1cb+/2RaBvb6jf0sPCE/FvSwo48A5LJSrYrQpXYJ8e?=
 =?us-ascii?Q?LoeVGg/UiAl7O0Vkw4qoQG/l08XaYrq4nJAXTsEucu7YIViw/v6O43A62uLx?=
 =?us-ascii?Q?sH8bXNHwncXYMWIjyvEyQQBne5UntnDPIhzMSWE7x1HO4+otNZpvHMWRuwdZ?=
 =?us-ascii?Q?aItkHMPoGcqKVhRDQvnbgnK4CaQiQoqWi/o/gPeU6GhpMwIeS3tgYxlSr1Gw?=
 =?us-ascii?Q?SeIFDSw1x+m5ic/b9UeeC7w4yVu1XHX7l24JG8xMRvzaAWVfPocWylha64RS?=
 =?us-ascii?Q?NjfHGqDFeC8niQJSv+fZNZGhMH4KLI359NBAu5glofqARuqzfES2X11OTuCv?=
 =?us-ascii?Q?unhbNru0U1T/3URfMIYGxP3xKo2LPZAVh/vWJj4OjeUFoXp+FXdywPF1h12E?=
 =?us-ascii?Q?h2SKj8iPLUh5gXsPKMOGo9uPvTJket7xIyCqQCwoRzPlAjHrqlGzEv0oTQn1?=
 =?us-ascii?Q?36+n9TYEg5+E4/IJKdRHRedaFZzN31xAaItXHe2qfQDMh9AQBYkdW9Dprh3n?=
 =?us-ascii?Q?7QbYOOfgEaC4KJaajPLUyFaCMM6AkwoTTGxJgq+JP8Ah8B6Xog1vLOtAHqs3?=
 =?us-ascii?Q?RW4mRgHdGillVNE7MUNtRZ7KQBJnTC1OYku/cQ941hRLSU3SNYuQOZgpriuk?=
 =?us-ascii?Q?m0/L2tV05vr+BNVyN5vvIan6FG5MhE+QZ7MnapOohPYEA7aRH2sp3MSNawUI?=
 =?us-ascii?Q?VYCUUzaKm0j+eKalkzQBf1CwCHL1R7qj1DrUwhTLCOt+4AX9Ye4dqOcLzyMz?=
 =?us-ascii?Q?GaaM44wIWMJcXlfI3/ofd3sdFCvQTXNsJu0vTEiFNcD7TmpRkXbA36VwfhQh?=
 =?us-ascii?Q?030UaDNr/patZelYnDWWuVXcPeryVtKyeMl6ywf4JM2ZVbMdBwZjjHFcUh+O?=
 =?us-ascii?Q?kCTxb01/9IJhbKAoCOhChKArUsBdQfk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4b3cd2-9f00-4e68-ff82-08da424eea71
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 15:13:13.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/Rth3EtDaya7qv2WWEE6uEQ+FTpcTMJumKTmmbNlMxp2Q3IKUoDCj1lpcl+hKxb+0vI7SkWDYvr/fyslOcgP+5Odd3Q1z2SFE3ABOO0CVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2563
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-30_06:2022-05-30,
 2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300080
X-Proofpoint-ORIG-GUID: 4F7HvQZZrY3caa0gQR202vYam2K5HGCO
X-Proofpoint-GUID: 4F7HvQZZrY3caa0gQR202vYam2K5HGCO
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Dawar,
 Gautam" <gautam.dawar@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Mon, May 30, 2022 at 05:27:25PM +0300, Dan Carpenter wrote:
> On Fri, May 27, 2022 at 10:36:55AM +0300, Dan Carpenter wrote:
> > static void match_pointer(struct expression *ret_value)
> > {
> >         struct symbol *type;
> >         char *name;
> > 
> >         type = cur_func_return_type();
> >         if (!type || sval_type_max(type).value != 1)
> >                 return;
> > 
> >         if (!is_pointer(ret_value))
> >                 return;
> > 
> >         name = expr_to_str(ret_value);
> >         sm_msg("'%s' return pointer cast to bool", name);
> >         free_string(name);
> > }
> 
> I found a bug in Smatch with this check.  With the Smatch bug fixed then
> there is only only place which does a legitimate implied pointer to bool
> cast.  A different function returns NULL on error instead of false.
> 
> drivers/gpu/drm/i915/display/intel_dmc.c:249 intel_dmc_has_payload() 'i915->dmc.dmc_info[0]->payload' return pointer cast to bool
> drivers/net/wireless/rndis_wlan.c:1980 rndis_bss_info_update() '(0)' return pointer cast to bool
> drivers/net/wireless/rndis_wlan.c:1989 rndis_bss_info_update() '(0)' return pointer cast to bool
> drivers/net/wireless/rndis_wlan.c:1995 rndis_bss_info_update() '(0)' return pointer cast to bool

Hm...  I found another.  I'm not sure why it wasn't showing up before.

lib/assoc_array.c:941 assoc_array_insert_mid_shortcut() 'edit' return pointer cast to bool

That's weird.  I will re-run the test.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
