Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13808C433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 06:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92E5960840;
	Mon, 29 Nov 2021 06:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-caZp9PRrxh; Mon, 29 Nov 2021 06:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A23B60611;
	Mon, 29 Nov 2021 06:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18898C001C;
	Mon, 29 Nov 2021 06:59:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0A33C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 06:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA6F94035C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 06:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ulptHFZn";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="G329sfFw"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPAL80yHHOWN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 06:59:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45A6C4032F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 06:59:18 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT6PYcK021664; 
 Mon, 29 Nov 2021 06:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G+8b1VJG8/eJsf8Oi6kSJhNJacdmLYI+yy+owMTzm1M=;
 b=ulptHFZnxrGevYN84y3xaUHlNbmmeuM6vOZldmAz004W3YwYRqHBdNwb4x+LzXWp3vJS
 wvuTY8p5Fw0kpcTh2RkN0eN32Z0XnwwTo3LrTcnpdl6NKpR9RWy+vzIqsHe8p0iixNy0
 tPxmSF1JyXm2PhKCXgxLRa1avT3y5D0qZtoGSLDfr8t2+NUEEufmCtpy5eJ3iy3fb2Aw
 0FWzW0a/sqQWFffmVl2uigArUBrJEwgLdD17px67ZoAwAHuAbIzoEQjab5v+0roRo4cS
 QtHj5wcyqdQG3YMl4zx5b/svLqnrCgKeTB98l7bg+70egDvQEtP/kYMG51eXvNrA6Nqm VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ckb3d4jmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 06:59:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT6tx3B151137;
 Mon, 29 Nov 2021 06:59:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by userp3020.oracle.com with ESMTP id 3cke4kq6st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 06:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lafEuSiOjVC4zZPsguB4M/9DxkuJl0iS+RaME3O+iTefMXd5RWNF4+ib80Gth5kKCaw4r2gkQy8fLNP+tvVgf6xuGfssW2ZWRTBJIJAOKZ0pWMVDWrlHJN5+qesTZsFu/kCghyypBdYkToBQMydBRfJfqLtQeW4WCRsAhR8MzrdHlUW7udpQpoTb5fwZ0XNAdVbBFnd3Ff8PKwvfQWs8rzylMj7v1K/XBdI9AOe7PK1Sg5D7Jk4BEKqWREqEUgfUcMS+9fwdA2nthfJdUXeiMxFeZjRQC7xnMERf0I8Jyih8R/CTyrVzMNL0cN/t7grS+Ocmzb4Ynl8MQryuZxRh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+8b1VJG8/eJsf8Oi6kSJhNJacdmLYI+yy+owMTzm1M=;
 b=LKuhDosgjWWTo+T7hWSGUgZjn1hrIVKgPtsEzodtZsnXy92w/ZJQCx1TTSBxJXcwlSGfGWa+bKtV0Bs3QP3fR8HVlZJ4gSH3FMnCEQ+E0jNINjNN0QX39VrHqWpSYN+EKqX53Rva8JmFaTtwM5m4z9rIqU19eJQeyoZc5kQCe0WLp10hF/+fmQT0kATg8pUq7irX/EK3MS1fWtft/Fxi4cx8eHKuNY0lluyJXcYwSBpxrerg1EbZ0lfjtesY24UI0pPnLSijAXN0CJer+edlApozmtBkfwFmWpxqVHc7USiDhgufNvT2LRpo4c8cP6j5oJQyzAM5vruHZ/3yYcZYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+8b1VJG8/eJsf8Oi6kSJhNJacdmLYI+yy+owMTzm1M=;
 b=G329sfFwcSpycJPb2OmGsj5FHN8kIWy04ocOaMS1cPdaZTIaa2oK09tMyuhnPwP/oG6RRP9p0qtgGIP8aa0HcVhW1JXgtwM30b/vGq0PFrNZTakaCWJXBOVKWwLJ7ztN+Q0jNivsLOyQ3Lk6LVeHMF6isB3mCARkIfJf14lCSZQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1294.namprd10.prod.outlook.com
 (2603:10b6:300:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 06:59:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 06:59:10 +0000
Date: Mon, 29 Nov 2021 09:58:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
Message-ID: <20211129065846.GN18178@kadam>
References: <20211125180915.649652-1-parav@nvidia.com>
 <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
 <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
Content-Disposition: inline
In-Reply-To: <20211128071435.GB99190@mtl-vdi-166.wap.labs.mlnx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by
 JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 06:59:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465115b3-883f-4a9b-95bc-08d9b305be9a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1294:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1294BB72325AFC864EC2541A8E669@MWHPR10MB1294.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0likCoHL4RVCM3jF0Kf03jIi+qjyeEBPng33Wg9ItbjfJycO0uPh2xO38vwYBLOxgktWRhk6XnBEEsWqo6KodcI6OuXKYc7USV4ANb++hCGuW60H47VM9qFLVSTluua3rOCkWJXxvBtttBWDeUao2Hh16gG4U6rRpmlMdjfEsM9t9duUqwS9nFKOznm2wMsPwTwTfy6jRah7PeBg4ua/i9ba3YAJseEAvgq/lQ/4eHhfRjuW34tYfH6Aeq5gNERrpcK2Bw85J9SC7gyioBbNPxPL7twCDuKNwt+W8r0S3onTDq+J5bT/ctFc5LFcdmxAqjt0Pte1pzQ7ag77yn1a/IG/z7uxNO4iBqCoABBNIQeskK7xN1JOi5oiGgYKVYM0KCjvOeQux/NXmcr5lzWZFl/zMGhfoFwYayJqOwHsqCKDQozWBxQfuQzsUsxLILvI/811f+yoQ2iFv6Hr0Aau58TfhzpDDuB9gn94ze44XS0j7cE4uwtl7Qbvrh0xJQ0HWKbbID3YCmIqyOyu7kXGybD/ns5LM4V1n2AyY0/45lFBDQBb8YEoghIEbWnm3pyfonFIjVC8cPBz547rBygfdtHUzQvkHMtuFi27XFCI9I1tCDMdRRYcjx71yODUg1hZUjkmNQwENDPRfVVuXS0E7/6HsdT9sgycfyJIQcmxAxDH+QWhFTjwp751P7BcgFBsxST7a/Hsi+3SlncfHKFLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(956004)(4326008)(44832011)(1076003)(6666004)(508600001)(66476007)(52116002)(26005)(66946007)(38350700002)(66556008)(55016003)(38100700002)(33656002)(9686003)(86362001)(6916009)(8936002)(8676002)(33716001)(9576002)(53546011)(6496006)(186003)(5660300002)(2906002)(7416002)(316002)(54906003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZtJnhXB/YIJBiGZAZiqpXL24gWi9qz3OrEwsY2XInYZc/HX6LUQ1qFhMHrc?=
 =?us-ascii?Q?15yEW0WsS/0hXZhwqbn4CvZ63PSIe7tUqkt/39yU24UAV5X//j84Kdqh8/ar?=
 =?us-ascii?Q?HJEPmo2d7bUyNxmXeJxgyphO08XpL21MtNqXlPaJgxGTyDAC5iql1cbpXobQ?=
 =?us-ascii?Q?9Z7vZaT+a/FBQTIwHPSRVX3/qQvukY185tcQcHTDS3Qzm3+PGcRiaInn8rXJ?=
 =?us-ascii?Q?BkGvzax0i3bbDvG6/RfhJ1JXuW+JgThR4SDEr/ZKPLzbW6TkQdgonUosuyc4?=
 =?us-ascii?Q?fqzUgXw0UqGIq899O8kN8AnHbe7gFyNZpp8VhtrUDiHqarUTLNrFsKLL5IWX?=
 =?us-ascii?Q?kSEsklmcYj5CbMSowSq5zxuwhgApZwIkVs4lRdncDYGeRRm2cSnJh7zXLowr?=
 =?us-ascii?Q?O+dzMQXwyoe+Pgd0V2DuhsQ+7cWC0ieB9EQYu8A1ySLzgC7a1W0E/kusWqM1?=
 =?us-ascii?Q?GEt9Y6Zy4kd/wyrcs7g1Kjg0ZyhxuyIvlNhrOCaP2xg0TQ5EFsZ+p/culenB?=
 =?us-ascii?Q?nKscMXXHpaicVzNhXuvE0JXRdUu5thPh7Q2Q57qGEiA9YGPFlg8mRDSMZIfZ?=
 =?us-ascii?Q?rr6kJTITpJlIbxTozNmF0Bfu6JWQxnSgf8YepZVWCGc2JFJ2dy5rQVZx/Vwj?=
 =?us-ascii?Q?HHn2QNv7iagmNGjA+E0XYM5rr8DJBTqYELa0p3wJ3jj0ecYWaOHu836/Wbs8?=
 =?us-ascii?Q?k7NLhN0meDYAe2/pLW2vdREfs3SW5FkefTZ6cuz8ZOGU7W2plgOwGc+2YZ2R?=
 =?us-ascii?Q?8G9joz/U0YLZE0mUDh/TYds/KM42hyvI1FnjAAoEBNxQANWZdrp6yddueh2y?=
 =?us-ascii?Q?CrMHyHL3r3rRpieKgUJ/ssMTc4lvwanokjOau8R8L6l6yeqkOipUYV6H20Zw?=
 =?us-ascii?Q?piM1FGn7Ehul7YlTFn1yU1CauPLQ4tBit0mYuWK9dzHVIJZty0+MayHEXosd?=
 =?us-ascii?Q?osmsgZ2KmGHAYKAgCgrg7Z6M5Tqk8dHbwlB5X0RWGD6dtpyst3KY9ZDCBMCH?=
 =?us-ascii?Q?doD6bIkc1yYWWojXWrhmoG11Tn6BfWHmRSHmTep1ndhkVNW0vt235cO+A/uh?=
 =?us-ascii?Q?mVdqXjmMhyq7aXiZamVKrwid8/9qR7kyL3upzI/2TBR1o5UofI3jRt6ryTqV?=
 =?us-ascii?Q?Hj6jP4LSfxmAv//jol+eDBgcd8MiBUNcN/stDgLt8RfcqIdS0PRh7TtAtBwr?=
 =?us-ascii?Q?d9Xy1rCaWnqt/q7CkBsmrFbIXS0HoJaxWnQ4JwMe0sRakQOjj+joWWZsk0s4?=
 =?us-ascii?Q?AY66nCS+n/JTKkhoWHre6z/4iOFCKhjeSIVSHW4X+6f0s7tvo65OJet2clG5?=
 =?us-ascii?Q?B7UpFYcCDthfUjWKEVNB5d+4jzUxQr7XVKpwInnhJSBBL7dZ6bZGNNB9LinH?=
 =?us-ascii?Q?re7zBonXInGQ3DIuu8OF7rtZHCiWvec8zxDBtlmyw3mgbQ2/Ep0BUP9gBBcd?=
 =?us-ascii?Q?H/yg0oRbilz8bR077Mtx3p5x2WA/e4sfNB9RCFzHVB13SnzNT8QedGZepgvI?=
 =?us-ascii?Q?is+LYYmROfStwPzBpGii7Al3LgT2DUE7H2e/8LVJydHH4TJi/1CBMPYNy9OM?=
 =?us-ascii?Q?dbBAQd9spHRTS8aj7Pd6+pLqx02v7PxReyF6GVC+Gjt0R/96e1OdGE0Pv+F2?=
 =?us-ascii?Q?yrq/au6IB1Tw6Pf1RQy4AwDV4RhbZIDPum8QRZeTrDXm3gM5j6nsAlxYi4Ao?=
 =?us-ascii?Q?vEMT5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465115b3-883f-4a9b-95bc-08d9b305be9a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 06:59:10.6514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFxfHtDpG5ZdSzz2xunvTddbIvw78t3IKFj3K3Ckknu4C0LqESny7bub/AEOGYRfLNIXqvfDlnz1ObGFvyJiBcoh53IbIkLF/QzMsurOw2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290032
X-Proofpoint-GUID: FVSuACK8SLya2F1l7IE-aUqxL_hHKQL6
X-Proofpoint-ORIG-GUID: FVSuACK8SLya2F1l7IE-aUqxL_hHKQL6
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, kbuild@lists.01.org
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

On Sun, Nov 28, 2021 at 09:14:35AM +0200, Eli Cohen wrote:
> On Fri, Nov 26, 2021 at 10:48:12AM +0800, Jason Wang wrote:
> > On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > virtio device id value can be more than 31. Hence, use BIT_ULL in
> > > assignment.
> > >
> > > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >  drivers/vdpa/vdpa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 7332a74a4b00..e91c71aeeddf 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
> > >                 goto msg_err;
> > >
> > >         while (mdev->id_table[i].device) {
> > > -               supported_classes |= BIT(mdev->id_table[i].device);
> > > +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
> > >                 i++;
> > >         }
> > >
> 
> type of mdev->id_table[i].device is __u32 so in theory you're limited
> to device ID's up to 63.

A u32 can fit numbers up to 4 million?  These .device numbers are
normally hardcoded defines listed in usr/include/linux/virtio_ids.h

But sometimes they're not like in vp_modern_probe() which does:

	mdev->id.device = pci_dev->device - 0x1040;

I don't know if an assert is really worth it, considering how almost all
of them are hardcoded.  Also if we do want an assert maybe there is a
better place to put it?

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
