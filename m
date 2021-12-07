Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129AC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 11:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5B72402ED;
	Tue,  7 Dec 2021 11:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1O230WXPmSZ2; Tue,  7 Dec 2021 11:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34FDD40180;
	Tue,  7 Dec 2021 11:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B5BC002F;
	Tue,  7 Dec 2021 11:01:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F09CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C3E060609
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="l22Mdmi5";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="iO+HVVh4"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9YHRuB-dYxsK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:01:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BF9060E54
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:01:05 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79GxfW012491; 
 Tue, 7 Dec 2021 11:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=I69QQS9x/JjEokjqDW18g139X3gHpeHayK6RJvdkSuE=;
 b=l22Mdmi5KYRBTJxDIQPyZl1eNDBgopNx2RAPdPqgMwAtpU0ByyeYuB+HWdpdO/QYelAn
 yaCFxYbF6L7+cl69PrlnTJzkGw/C4JxgmirTZoFHAqOIhwXKq9fScdSusUZqnKhNNBBb
 QpIo9bD/jwzMoDzOU+py20fnu44qLevrZUBSJf9mlTQQXM2DdPnjN/bMAPtqReJuD1iL
 vVSWD+cYOvLVdJjNeSYGEn2/Pw62ptZ+TFVgR+4O3HPOUsq4JxgRDl5+4PA9UIf5R/Ey
 G0kvvhfZyrEmpLVlL3GcXjIx84ZiERAUw/zFm0pKU6asYsE7WrrrUhUJlA8aZLOrPJeg NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csc72d1y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:01:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7ApDh7003605;
 Tue, 7 Dec 2021 11:01:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
 by aserp3030.oracle.com with ESMTP id 3csc4t3wcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2TBB47aUkuWvHH+Si7b5PmIHC9jfI2G3AM5oJPMvGKwrb1kgWQzGQX/okqC+9sXm7xEngnJbqUlEHY2VfD22x+scFjfsLcFoqKrOTiNLp/cfs5rxdvyE4kQ3z8EBREvQ4AI6dysEjXY8IQccH6B3CJ/9DL78bG+eKJbgjKzX0+ELmxPnRezTt4e7D80MhHk5Hr3BnXq5uMS8zBTU/ekwyutCj2yZCTLvqrbRfj8sCclnrIyhg7iOXCRhI64rVCf0/fvVkEIhUE+h76QGKLJNAhEfe+RlZBEIpI4/dOPmNjfCJKbQo+0VE+CJRx39R7qJIFUyYwBw2hKixqxsXD1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I69QQS9x/JjEokjqDW18g139X3gHpeHayK6RJvdkSuE=;
 b=edV+EavzcqepazkH4qyGQkctbNgTsYgw2Kx0ODBuuW5lYJ96BtWe1PcxH2LeuPjDlTi+1j2SzldY+erx4B76k91GocONURb2F5vi8tEkzuZPEZ6SCoKgoiMyK7Iof6cmuVLdRL3KPM9rjt1TYFGZSZVD0TGaTPAC3ydFoeDC3ZsCjFHPYyIEK3Z8BiGWAPVibe1ucivWupGjks1AugtQjq6ctXGZYAykqUW+HnbLmW+FcDT3fd4RZdPAmPPioXmtc9BAPqQUysgBu0CJlLg7dAH8maekvpYqHe8lKnySN8rnvU5vZnx/jEcW+JhF1D0imVXAZB8eceddKhzTwH3B0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I69QQS9x/JjEokjqDW18g139X3gHpeHayK6RJvdkSuE=;
 b=iO+HVVh4jQjXLNySJBjA1+nUlMidyu0HhBmG7/DCcHhf5oBXZPTHuD3q4+oYkhHiS2XtOL29U95Udis3xO/lWBt2+05+3NaIN+BoE+tdEbm60lmLHusxXB0EM536T3eFKe7xDOv5hj0G2hjU8EMB+CzLXp7z4E2X+n4+DoATv3A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1485.namprd10.prod.outlook.com
 (2603:10b6:300:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 11:01:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 11:01:01 +0000
Date: Tue, 7 Dec 2021 14:00:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: fix memory corruption in vduse_dev_ioctl()
Message-ID: <20211207110040.GH1978@kadam>
References: <20211207104614.GA21381@kili>
Content-Disposition: inline
In-Reply-To: <20211207104614.GA21381@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by
 JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 11:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060f5915-4c10-4857-98e1-08d9b970dad6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1485FFF806F1C243A43E61CE8E6E9@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeoPi4BMmYAdQk0QvjwrkCfJT0yL+OtdC+hiLFsJc53nWyWMykBIQ08JrwNeDyPsjKEaFKlWquiVDwotBKw3P6fGMxqoqwfXNeJQFd8kVE9cNoKFuKYRT67UDip3QE8JrJpmx7Y/rMOu/KUZZR1XQE4L9mNqvkF3DtgBywxULttvmlOKiebl5sFVaoU2Ec5kPXZDoD/z5UaUM9twu6TSGP2x2Aa7Yf3dDbUXNKfdcgkAGefgaNJNaz8wNhHloNQUtcbynAnlEwmEiJOvUVYnfjlmt2XUw3fjuQ2aENKmerl9uk7RW69rO69Xgn+wcQ+BeuAIaS457UC5a+8qhbzQXYHACXtyGSzSDnv2TBazdyFXJYmaO4yNAvgq83ZOObY00U4ui0x1Q4W5i+hxY0dhno6YxIHMsFEWIs8eO3YICdORik2H+RvxH5dtqq5AI4kci/pmVifcDUxBVTtUOU9bOl0u4kP6pLBCWItUOHqr4AnKgtiWmrbHlEB+AiXZ/Avy9FOzGMXV0QpQWdLBYPG5CNUiPBWnOrx+OBbs/mBVoYvJwc8PJ81epC7oQbQYwY4KQMc0KGQeMkK58AxS7MIw0M/1ZSxK+OH1DVHN1xNY1sZ+MpbtTkjoGFE4zExKU+7ARbyFJ/ijKraR2cafY/MKQBK7UEYP6PeuZwZtPB60p7kMTFyiz17uBK3UlFJUuLbobIPekK4mQ0YMTcv/3g941A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(1076003)(26005)(4326008)(38350700002)(55016003)(38100700002)(186003)(6666004)(83380400001)(5660300002)(956004)(86362001)(44832011)(8936002)(508600001)(9686003)(8676002)(52116002)(33656002)(66946007)(66476007)(66556008)(2906002)(9576002)(33716001)(316002)(110136005)(6496006)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/a1fN7agcxxhowyepmxPxrf1/6CmxXFtn4hpi1EBkzG2s+WQZkTfwl8A3lo?=
 =?us-ascii?Q?TaYHOs6//acKMR/lF6ZWu1HzjMDkfAF5sw0Ir/+IpnUZupJrSB8K6MLl/I5j?=
 =?us-ascii?Q?Vv7p04viJ080HzQy38kRLLSHhpxsX66DKLBupzgkAqMUxzkQ3ERLrMptcPD/?=
 =?us-ascii?Q?dfsCUyWhGp5zaiuhwTHTwSWVr1f3L088WZKQ1F84RS12vAGUzZUNHFaOHJV/?=
 =?us-ascii?Q?g71tYrOCob69FT++CEIhDtu2cu3n5BZF3EYxTlrRhM5YVnnE1NaAsSRvxU4E?=
 =?us-ascii?Q?1z7uy+oIeAiE7wB7Oxer9veOCQI3TtzjRokPhr+XauOavwzAoftu8MZ1uH3E?=
 =?us-ascii?Q?SN8hW0VjRRx4bSmyKjnkI2o8rzdhSASKOrcO5vcrC6u2SfQS2nvvOtSSx/6n?=
 =?us-ascii?Q?9gDSCjF3ICL+2a2AplH/VKn4TjfoY5sz6YJTsOHcrp8uTwMo7JmELm/spvmX?=
 =?us-ascii?Q?jMROclI7l1Acdmn39MHalSSSWMU5uiw95hou/mrb3AQeEFAk0jo9ryf1nU23?=
 =?us-ascii?Q?W945LuFujn/SCks5H4GqwMT7mTeorpPMA6vIwhM5B6Sq2N0bVlfW/ItchBqe?=
 =?us-ascii?Q?6mmVoOhcNFsoWhaimoXMEyGOHmKMDMfmrcohul9mn2vVQiD7sifVgCDTHiYS?=
 =?us-ascii?Q?pHh1+7UUlw2n5Nz8FGugQs9ALlbUjlCfr3I7HbRVVyPZewxwcG5TRAmGrgPY?=
 =?us-ascii?Q?ebpAQqjrIVigpy1lj2hCID0TOy7acmT8gpnXft/3xE0R3NfsR5HzyDA8XKau?=
 =?us-ascii?Q?4srV33GQb3GthHzUFtWWXkD7ghfR+hILOcS5qcmEKzvzmZ+z0Ozkvl81yqru?=
 =?us-ascii?Q?xTaw1/PM1/r201BtS3D0Zdx4nTKk09d9pGBN71BnW5NPiaulDi5ON0IHCNKb?=
 =?us-ascii?Q?ZMq+2F6FexbH/3JDojki3AI/93Vjv79M49oyOETDbKIQWqTqzwtr5FvAzSBS?=
 =?us-ascii?Q?+DJGD2FWb322kDIBpEB3jkZP28GdDSgTxGDuT/DzigiVy+aPecB5s4ICs6t5?=
 =?us-ascii?Q?WKb21KoW8JUvPRbJIlGVJQppajFYpKJkjEjBaQRtlDjiLEM44soxb5F68nhE?=
 =?us-ascii?Q?HBCPhujWf5GZcI9KxplEeXvw8FmsXTNiE4QN4HxyR4//sjCRx2A+opZt4r6Q?=
 =?us-ascii?Q?ODl5BW9Yoc9d6xgda/ruGewTomTPPd/458u44al4gtIWrgV/jqHGbDk83IRL?=
 =?us-ascii?Q?5FGwlpCUdipTitLaYWJteiFgpq79nwKiEhjKV2RYNOnzVr1clnuQtvQ10HcP?=
 =?us-ascii?Q?T9tixjezizrVyMI3R1QE2KRicbtwvxX1wcPGIYM68/I5hbmWswM1+A1E4Ffk?=
 =?us-ascii?Q?ch06EJpX5qUT49sH7MjjeG/Xz3o8RuJPnZU/hlbrLKExIPu0cJAunxFJ/tzZ?=
 =?us-ascii?Q?LFd7zigM0mgpfxBX7z6CBtlaKwATyBFd6p2cSNM9/4+g/J5ytAMWP74A+LQz?=
 =?us-ascii?Q?rWnt0qvf+X9LY9lTBdSrcRqpg0BTh8Vd05QAKvkdAKfEk8kuFz393tKkmdm1?=
 =?us-ascii?Q?2cICbf+WhSuSq8+KWdIoMg/3mWjpAn41Bl2lBXLtBQT9IeVNm6LJZt9Z83fn?=
 =?us-ascii?Q?GygzzVXl/USzr05pKkcZ1QtWg6qT/iAYbo3l9EHMFzBwv9ZP4Znr2INMK/0p?=
 =?us-ascii?Q?4fmC+vlKG3/BbH6zLXaus7PobFlqZwHQkle9ZVfnRffCFOGVXhoJQWiOTZrw?=
 =?us-ascii?Q?KKLOuBO2IZKCtK9GpHEog4/tsi0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f5915-4c10-4857-98e1-08d9b970dad6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 11:01:01.0037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4BBCG82LTXzPHK9vtkghPWgHH8bZVz6YAV6kcPMZCnOktil8DSFj9t+bqFoPuQhIt1ajLTO7XQjyERjSvDK7wcp496S/AZvzo05w3U6V8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070063
X-Proofpoint-ORIG-GUID: gixwBDZ0CW7u8gqLU6CFFrkDRIazFeKI
X-Proofpoint-GUID: gixwBDZ0CW7u8gqLU6CFFrkDRIazFeKI
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Dec 07, 2021 at 01:46:14PM +0300, Dan Carpenter wrote:
> The "config.offset" comes from the user.  There needs to a check to
> prevent it being out of bounds.  The "config.offset" and
> "dev->config_size" variables are both type u32.  So if the offset if
> out of bounds then the "dev->config_size - config.offset" subtraction
> results in a very high u32 value.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c9204c62f339..2f789dca0c0b 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -975,7 +975,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  
>  		ret = -EINVAL;
> -		if (config.length == 0 ||
> +		if (config.offset < dev->config_size ||

This is reversed.  Sorry.  Will send a fix.  I was over excited about
this patch.

Also I need to write a Smatch test for this so both the original and my
patched version generate a warning.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
