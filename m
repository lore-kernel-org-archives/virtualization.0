Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80555C00A8F
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 23:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF775428A5;
	Mon, 23 Oct 2023 23:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF775428A5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=gwhKftJ+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O4rs5iHB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sySbNcGrCuZ5; Mon, 23 Oct 2023 23:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C862642898;
	Mon, 23 Oct 2023 23:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C862642898
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A036FC0071;
	Mon, 23 Oct 2023 23:03:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 565C3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30BD661453
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:03:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BD661453
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=gwhKftJ+; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=O4rs5iHB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cw83PfWsXAAW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:03:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E906061451
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 23:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E906061451
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NMIqAE009053; Mon, 23 Oct 2023 23:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qa0U7DEf3LFvPppBkOHFTwAov4caDpJz8/mbba+9jcs=;
 b=gwhKftJ+mINVr9bOv27n2YnAmaR7scZ5FexOukfmA7AjXbc6XE7KrzQi+6J9A9GboMbZ
 WxGGf/E3DOC7VQaqrudkh/RnflRPeFWcuc7Gn5oKUfKFRUEZQJXTzF+HWWejz+5IhmI2
 ZDOElL5RHIAyA3IDA854huyVYeZpxzo2H0ZyEG0RtVU7MsewfRppLIl84vmeM3YlvkFs
 dWM6IK+H6AQE76fvmfZyeb35DOo8/IRJV1NcAaCYR2D7S9ctePji5IvO7TDbompTlpqA
 o/59K5ZB+/nDk2cB2yzn2qggXYKIyL8K5zxasK+fUkAMX7eliJLhgyNaY2EyyPc2evaL KQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dv860-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 23:03:55 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NLGqHk031101; Mon, 23 Oct 2023 23:03:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53b4cd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 23:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/S9Entkt4CiR4iwNYEPk9nT61e49EmO7gejeytktdWr/c7KrrK7vv1yqu2uWStFCwzlBIwr8R1k0vEVMPO8L016GfzMrrWwWtMaxNmpfro3z27AmupwKqLrtBYdQseYJAQb8+PjsaqMo7zdCr7miiqpVkUzBU9BjO7DTx35WkrS4tQa2Hz6CEkunOhTiJSBaBboZSi0Jh49zyWi95o+0SM1MsmUTO6uKoLc+3eFA7ktP+9BBtR1GiGSYXSqzTU2Ulq/YUmTV5IOmrPVL1aig72DRDH7ScEHbxnGh7i6oFygKkA6eEC5c9fpxAAKBEv5SE+TK/MypS+8wwl507OcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa0U7DEf3LFvPppBkOHFTwAov4caDpJz8/mbba+9jcs=;
 b=GcEIDITB3w+i8jI5i+alTtl6tYYGSGVd9h/mR714OAyRmOVQ3bNnKeEKg41MRNdB2N10kgZ6HuGivRTJkqjBWRIJ3zu9yGQI4bobgAXzgXojIdO9AIfNNFQ7abvWMhfZUO3tLNyPZJwaaDxsYY8USGTT+5OV7zXS1X7FuHrMVP3Xqr5Z+H0I/BtUMrMijiQQ3cinsSxEj1OVYYYX4wMl1EG1FYWIVYH/bx46AjAWVHdXus3lhK+c97EIrSHAIKayusiahnDZLmDu5LpymidG+kuN0Pq5Wtnixg+0RhwBphQDHVd+aD09EPgAQ+bzpQA1wThwWS33Z5FyzIYdmnrplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa0U7DEf3LFvPppBkOHFTwAov4caDpJz8/mbba+9jcs=;
 b=O4rs5iHBGuN3xMJ34bqU8raT7gySvg/+xsgAXeELl66lT6LLUpDOVa2jm3/06jiflpiQiG/4p5DQ5Kdnghbkp+mHYpynZSG8EV6fAcxyG7ONr4n+p/HfW35JG7SV9AExocZxFP3BF7oaauG6Cty8Tq2LjpHXsb4OnseMhXROF3o=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 23:03:41 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::77bd:3721:8a42:ecab]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::77bd:3721:8a42:ecab%5]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 23:03:41 +0000
Message-ID: <b4913f84-8b52-4d28-af51-8573dc361f82@oracle.com>
Date: Mon, 23 Oct 2023 16:03:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <8a3ec6465bc150fba804f34d456115c4f8a29c70.camel@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8a3ec6465bc150fba804f34d456115c4f8a29c70.camel@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: d61819a4-3fcf-4db7-1c16-08dbd41c4cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDlgBcjid4hWYOkrktFGmyO8H4dN7cM24YL9N0qcIB0iqRCAPWIZKwHcneCe6T1xsFAspgcsjV+ufXQhImGGbWZQJwe34i3QgLtHZvBLuWCBSSungG5V2KSpUIx8lJx4eoElwKorJRW9MZr/ncFYShFbh3cGLqrtQiMMQ4OWw4m/dO5WKZZ6NPlY3vdmu6TFj51+qgXXJxVGsz0VSu6qFfH8bZmePPlTGQJCwcPBkLxkcsYkhP/8xOrGWTJ/xY2SUlWbGiy83X7Buy3OI6GwXhiDpGsaHd/iWNcTRgdJkN8aOXYD75kei4ZqyvIiDpvEGMwf5QH7xwwPrt46Ksrv5CPkgxGwz/5ePSGQys/tHcB4uIvKUA5R5UPS2Jm2okU1qzpwKoJpa8xqSMtRhrqumXoluJNFYA/IH7toIAIlFEKTBffV1W86+9yR6VVyxvmJ95BZcobv9kDlNBnFYrFNC21dtY+ozCKK7P/hmkQ/F3scw7+5+e4cX+zmSdeUNHznyIhg7fZB6lz/AVrzu14iLmjX9TfWu1yvcNfg2dmivuQ4KZq+qDaKI4CvujI9pUxBCLF/UIdw5WZoCZvT68j8Rrsp5Ko9065L1d/uKNsoOfdvI+UlEHdKCZ+khYECmbW0ud37A+DyXxyp48r8kMuKnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6519.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(31686004)(4001150100001)(38100700002)(2906002)(86362001)(41300700001)(31696002)(36756003)(5660300002)(4326008)(8936002)(8676002)(110136005)(478600001)(6506007)(36916002)(66476007)(54906003)(6666004)(2616005)(66556008)(316002)(66946007)(83380400001)(6486002)(53546011)(45080400002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25VcVZQSDBqNVFQZWxEUHJKQWhMNTlMMXRyUHdnUGsra25KODFPR1dUenZW?=
 =?utf-8?B?KzdaL0V4NTRmdThkOGZ4Z2JFWXJ6RC9mUGs1V1BMQkQzT0JlSjg2N09mUVhN?=
 =?utf-8?B?c0FuQ0xvVGZvdjNlMHBHNlNnR0gycHlRL1lvUk9oR0dGRXNrb1ZnYmowMGJr?=
 =?utf-8?B?R0gvai9QNWMxS2t6OTI4SmI3WXNqcjJwZ1hpRWRZaVBoUUpnMEt1ekcwTldl?=
 =?utf-8?B?S254aFZqM3RCVVJRZHdLNFB3RWd4cnBIQ0FXY3ppUGcwQzQwY3BuY2Ric0pF?=
 =?utf-8?B?YWExL2RBUEg3T2FoVlBGV0NUR0Z2T2VTZU52WFdvRzVwSjU3b0N6K05uQWIr?=
 =?utf-8?B?SnlSL2F2T1haQVFzTDN6Yy85bXJuN2pQL0I3aFl6ZjBhYldyVU5qZHUyWW1G?=
 =?utf-8?B?SStraHNmdUpTbWVxVGsweVV3VXhnUHdaV1Z4VlJaQS9uQU1IdUVsLzBmdS90?=
 =?utf-8?B?K2lkWC8vTW1xeFhyQnlUOUI2ejdXdG1VQTJ2K3UyQjJrNDJ5K2hJVll4NFpv?=
 =?utf-8?B?eGhUSnYva3g2Q01zOWlxaHBYbjZGdHhsZ0hWR2k3ck1QZ3RYZ3E4U0lKQlIx?=
 =?utf-8?B?VWQzZzcxR1ZpdTJVRUVXWjNLeml5Njh1OTBRa0RJdkFITjZtdXNOUmhMUEp3?=
 =?utf-8?B?aStEWjc1cFNRSDl5MmY2ak80L0tVbkw4Z2RBZTJHVEx2emp0TWx0Tm1iMGMv?=
 =?utf-8?B?WW1jaG1HZDRMcEpCOXZ4THNOQkR4b0g4YnZBVmt3RFB0YzRvUVBtV1RxOWYv?=
 =?utf-8?B?cXZKN2E1eUdWQmNaZUozRnluVmNqc1dMZHNIbHRBYlIzMmZiRFhhSjUwR0JB?=
 =?utf-8?B?SDUzck40bi8zejdlQWVCQVB4bnVYTURJaU9LWHZmSy8zVk1uSzVCMWFFSm92?=
 =?utf-8?B?NURMSlU3aDFtS29Fd0MxQ2pXRnBKT3FKWDNzT3luWHYzWEZrQWQ3MUpyZjlY?=
 =?utf-8?B?eDRyYnZLaHRBV3VLQUg3Z3lrMm1iK3lSTVZleVZyYW1OZ0hxUWk1Y2c5azBu?=
 =?utf-8?B?WHZMNVNEQklNOW1KS0s2ZUNFZlJwNEVLKzllWHExUCtLL3R4V1VXUitsU0Ri?=
 =?utf-8?B?U1grbU1HWW91V0ZtR0hzbnBTU3gydlZiQnlMcnZwa0NvR0RQSHRTYzRjT01k?=
 =?utf-8?B?cjRVMjBjcCs2NVlxSjNJc0RUc2lOcW5NYW0wYXNZRk04MC8vUjlwLytuRExv?=
 =?utf-8?B?dmdNOHlhWnBGdDhNbWZJWk1yRWk5VUk5N3FNdkNSNHlMN0xHeVZOWjlCbHlW?=
 =?utf-8?B?d1dwT0NrL1U3OHpDUmlVRmp3UHpJSnU3LzNoUEZwS3dzdzI0UHFGVmhBSG9y?=
 =?utf-8?B?ZFFKb0JjOHkxeGE1NmpyWmtkamx1S05YRmM3c1RSeEdTTUxwc3pNek4xTjZw?=
 =?utf-8?B?bVZYbGtzNnl2YXV1SUtBMUxHYXZqck5sQ0FUUDN0VmZCSjNSV0llVytDTVNh?=
 =?utf-8?B?SE5uQTduUXlrbUJTV0hzb3JvQXkxZkd4Q0J1cEJxeEJrYitIK3Q4TmhYM1lP?=
 =?utf-8?B?RnhKaGJ4TWtzS3ZndWdRMlpzQ3FTV2E4dmNsbFZvZnlIZnBtYkRCem5obFZD?=
 =?utf-8?B?VkZWTmZJTnQ2S1ZZTXhGdHZkc1FhRFVRZ1VnNWNMcktiMUMrV0hRVjVyN2Jr?=
 =?utf-8?B?V1IyNzFQcFJSZlJ3ZlhhTVpld2ErWXp4ckwzWjlQeTROMng1WHlWYnlPUG92?=
 =?utf-8?B?YVpWYWxWVnRmM3FHazRvRVozSEwrQUFCMFFFamJ1a3VVOC82U0NKWURHZUpS?=
 =?utf-8?B?YzZSazZMRS9iRFd6K211Uit4eENHSVlMRC9tcngwRjVGbm9zSVlRc1hwVDhw?=
 =?utf-8?B?VlNZeEl5MTlJRit4Z0NOc2ZSbm9yOEQvMmx5OUI2YmlyMnR1dit4STVGV1Y0?=
 =?utf-8?B?NVlkQm5CQ0xNTnY4MS94L1RUUEtSWkJmVllzcFF6ZHlNUHdrdDBTdXlEN01t?=
 =?utf-8?B?K1czQUE3Q0xOb1pOeVUzSzVmUWpYNVh6VDA1NzR3SmlTcTdPeFJiZzFqNFl2?=
 =?utf-8?B?RnROanNESnVxMTY2dmFmTVM1UldoYkZYVVMxTCtjM2YwNVdmTGd5eWQrTXpr?=
 =?utf-8?B?dC8zcGorTXRackRhRmtneVBMVmdQTXh0UU5PdGhWTTBpV1lEYWZTbzJKQk5D?=
 =?utf-8?Q?4hUg4etWVhUQxQ1NWkSOmy6fx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J96e2ZKaImHiTc6cnO/jKH/MYAj7VKnmY5iMEids+VKbnGAmfHyLEkGU3Vw8aiW+pmepVJXiX/g/u6sgNmgzsI2FTmpXJ/T4/GTBGfxTYqBK4jFva+XlD+La6t++xzteVeCHDIvQup1Caq+PIjdatjWsHtJgizd9Mj4klyOjUMZkJfYtgQ88fTmZdVmOJ5K70vhE7WHs4/EVE8umtC2ZSDK6OkNwaqJ/vdskVcw4EElKe+G/+jpddvaysersevjLu4YQ8XGw9Y6BN2KI0vX0yFnksDKLXDidI42QnLJPWUjeP7870+7v1t/a5zHzWxVW2L5B6VRGJxvZNSbkBQDm+8t/ETnTcFKgjLQi+5hCPM4gXnc24b+bJcCP724KUHogM/yggtPVUMBa8DPWbbL/2srUOOV0q7rLCln0TVq7ApkbVdhI5AJenFo8JT1wdRMaJYppnUcbAAQa/E+pBuTnEjv4qmTO/RwmhFjV7CEzDzaEr+WlotnyAsCO9em6GsWZNjd0ajM8W4AoArHPO7lSnYDdiS31+qiG34T0vgkkPQ4TrfMoPr/5Kgd7gK5yyBpKMwPxBkfM7kFhPYlczP3vhXx3t9dcFHQnWpwfZbCTFq8K1u0qNL4MaojoTv1n7Uxi7kxwv8Tdl2COUJL+vYvrWwgw9SG8syPaW7Vizz36uboXfc8DZxMJG+u5T5WmeAEcK5wgGuhDJ+qw91huDH9JuR4G5jxbkbtkqZNJ+vHkaeNjBtepSOvjoRfxp4YWdnJJxvC+zo/R2R3t0G1ysHYMYMQ5VCokobBVO33l71PXEQiR/6jmEz57FlxPLLBYeyYKn+LO2rGCHZtCbZDj5EN4OmZrGybNz/AXAMop6yGqbsc0XsI5RXiMqP7cY6f3X6KA1bCa7j/fiC0E1ufCiNdYnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61819a4-3fcf-4db7-1c16-08dbd41c4cd0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 23:03:41.7211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/n2achXOhaCZtRtBfSnTNRC6l7nPEBpAyLnSY/W5ghGB0wG/UUbbLzW6nlNF+NtWCOQX/CG4uWAb6sFtiIXTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230203
X-Proofpoint-ORIG-GUID: _80jug4inR2aQ670AKqJyuwy9s1ZkMnS
X-Proofpoint-GUID: _80jug4inR2aQ670AKqJyuwy9s1ZkMnS
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

KCsgbGludXgtbmV4dCkKCkhpIE1pY2hhZWwsCgpEcmFnb3MgcmVwb3J0ZWQgYmVsb3cgb29wcyBm
b3Igd2hpY2ggSSBoYXZlIGEgZml4IGF0IGhhbmQgKGhhdmluZyBpdCAKZnVsbHkgdGVzdGVkKSwg
cmVhZHkgdG8gYmUgcG9zdGVkIHRvIGxpbnV4LW5leHQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiAK
eW91IHdhbnQgbWUgdG8gcmVzcGluIHRoZSBvcmlnaW5hbCBwYXRjaCBzZXJpZXMsIG9yIHlvdSB3
b3VsZCB0aGluayBpdCdkIApiZSBmaW5lIHRvIGZpeCBpdCBvbiB0b3AuCgpPbiAxMC8yMy8yMDIz
IDExOjU5IEFNLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPiBPbiBTYXQsIDIwMjMtMTAtMjEgYXQg
MDI6MjUgLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFVzaW5nIC5jb21wYXRfcmVzZXQgb3Ag
ZnJvbSB0aGUgcHJldmlvdXMgcGF0Y2gsIHRoZSBidWdneSAucmVzZXQKPj4gYmVoYXZpb3VyIGNh
biBiZSBrZXB0IGFzLWlzIG9uIG9sZGVyIHVzZXJzcGFjZSBhcHBzLCB3aGljaCBkb24ndCBhY2sg
dGhlCj4+IElPVExCX1BFUlNJU1QgYmFja2VuZCBmZWF0dXJlLiBBcyB0aGlzIGNvbXBhdGliaWxp
dHkgcXVpcmsgaXMgbGltaXRlZCB0bwo+PiB0aG9zZSBkcml2ZXJzIHRoYXQgdXNlZCB0byBiZSBi
dWdneSBpbiB0aGUgcGFzdCwgaXQgd29uJ3QgYWZmZWN0IGNoYW5nZQo+PiB0aGUgYmVoYXZpb3Vy
IG9yIGFmZmVjdCBBQkkgb24gdGhlIHNldHVwcyB3aXRoIEFQSSBjb21wbGlhbnQgZHJpdmVyLgo+
Pgo+PiBUaGUgc2VwYXJhdGlvbiBvZiAuY29tcGF0X3Jlc2V0IGZyb20gdGhlIHJlZ3VsYXIgLnJl
c2V0IGFsbG93cwo+PiB2aG9zdC12ZHBhIGFibGUgdG8ga25vdyB3aGljaCBkcml2ZXIgaGFkIGJy
b2tlbiBiZWhhdmlvdXIgYmVmb3JlLCBzbyBpdAo+PiBjYW4gYXBwbHkgdGhlIGNvcnJlc3BvbmRp
bmcgY29tcGF0aWJpbGl0eSBxdWlyayB0byB0aGUgaW5kaXZpZHVhbCBkcml2ZXIKPj4gd2hlbmV2
ZXIgbmVlZGVkLsKgIENvbXBhcmVkIHRvIG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQg
d2l0aAo+PiBmbGFncywgLmNvbXBhdF9yZXNldCB3b24ndCBjYXVzZSBhbnkgZXh0cmEgYnVyZGVu
IHRvIHRoZSBpbXBsZW1lbnRhdGlvbgo+PiBvZiBldmVyeSBjb21wbGlhbnQgZHJpdmVyLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0t
LQo+PiAgwqBkcml2ZXJzL3Zob3N0L3ZkcGEuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNyArKysrKysr
KysrKysrLS0tLQo+PiAgwqBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHzCoCAyICstCj4+
ICDCoGluY2x1ZGUvbGludXgvdmRwYS5owqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKy0tCj4+
ICDCoDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPj4gaW5kZXggYWNjN2M3NGJhN2Q2Li45Y2U0MDAwMzc5M2IgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC0y
MjcsMTMgKzIyNywyMiBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3Vuc2V0dXBfdnFfaXJxKHN0
cnVjdCB2aG9zdF92ZHBhCj4+ICp2LCB1MTYgcWlkKQo+PiAgwqDCoMKgwqDCoMKgwqDCoGlycV9i
eXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKPj4gIMKg
fQo+PiAgIAo+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3Jlc2V0KHN0cnVjdCB2aG9zdF92ZHBh
ICp2KQo+PiArc3RhdGljIGludCBfY29tcGF0X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEg
KnYpCj4+ICDCoHsKPj4gIMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEg
PSB2LT52ZHBhOwo+PiArwqDCoMKgwqDCoMKgwqB1MzIgZmxhZ3MgPSAwOwo+PiAgIAo+PiAtwqDC
oMKgwqDCoMKgwqB2LT5pbl9iYXRjaCA9IDA7Cj4+ICvCoMKgwqDCoMKgwqDCoGZsYWdzIHw9ICF2
aG9zdF9iYWNrZW5kX2hhc19mZWF0dXJlKHYtPnZkZXYudnFzWzBdLAo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSA/Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVkRQQV9SRVNFVF9GX0NMRUFOX01BUCA6IDA7Cj4g
SGkgU2ktV2VpLAo+Cj4gSSBhbSBnZXR0aW5nIGEgT29wcyBkdWUgdG8gdGhlIHZxcyBub3QgYmVp
bmcgaW5pdGlhbGl6ZWQgaGVyZS4gSGVyZSdzIGhvdyBpdCBpdAo+IGxvb2tzIGxpa2U6Cj4KPiBb
ICAgMzcuODE3MDc1XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJl
c3M6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMzcuODE3Njc0XSAjUEY6IHN1cGVydmlzb3IgcmVh
ZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPiBbICAgMzcuODE4MTUwXSAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKPiBbICAgMzcuODE4NjE1XSBQR0QgMCBQNEQgMAo+
IFsgICAzNy44MTg4OTNdIE9vcHM6IDAwMDAgWyMxXSBTTVAKPiBbICAgMzcuODE5MjIzXSBDUFU6
IDMgUElEOiAxNzI3IENvbW06IHFlbXUtc3lzdGVtLXg4NiBOb3QgdGFpbnRlZCA2LjYuMC1yYzYr
ICMyCj4gWyAgIDM3LjgxOTgyOV0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1
ICsgSUNIOSwgMjAwOSksIEJJT1MgcmVsLQo+IDEuMTMuMC0wLWdmMjFiNWE0YWViMDItcHJlYnVp
bHQucWVtdS5vcmcgMDQvMDEvMjAxNAo+IFsgICAzNy44MjA3OTFdIFJJUDogMDAxMDpfY29tcGF0
X3ZkcGFfcmVzZXQrMHg0Ny8weGMwIFt2aG9zdF92ZHBhXQo+IFsgICAzNy44MjEzMTZdIENvZGU6
IGM3IGM3IGZiIDEyIDU2IGEwIDRjIDhkIGE1IGI4IDAyIDAwIDAwIDQ4IDg5IGVhIGU4IDdlIGI4
IGM0Cj4gZTAgNDggOGIgNDMgMjggNDggODkgZWUgNDggYzcgYzcgMTkgMTMgNTYgYTAgNGMgOGIg
YWQgYjAgMDIgMDAgMDAgPDQ4PiA4YiAwMCA0OQo+IDhiIDk1IGQ4IDAwIDAwIDAwIDQ4IDhiIDgw
IDg4IDQ1IDAwIDAwIDQ4IGMxIGU4IDA4IDQ4Cj4gWyAgIDM3LjgyMjgxMV0gUlNQOiAwMDE4OmZm
ZmY4ODgxMDYzYzNjMzggRUZMQUdTOiAwMDAxMDI0Ngo+IFsgICAzNy44MjMyODVdIFJBWDogMDAw
MDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4ODgxMDc0ZWI4MDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAw
Cj4gWyAgIDM3LjgyMzg5M10gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZjg4ODEwM2Fi
NDAwMCBSREk6IGZmZmZmZmZmYTA1NjEzMTkKPiBbICAgMzcuODI0NTA2XSBSQlA6IGZmZmY4ODgx
MDNhYjQwMDAgUjA4OiAwMDAwMDAwMGZmZmZkZmZmIFIwOTogMDAwMDAwMDAwMDAwMDAwMQo+IFsg
ICAzNy44MjUxMTZdIFIxMDogMDAwMDAwMDAwMDAwMDAwMyBSMTE6IGZmZmY4ODg4N2ZlY2JhYzAg
UjEyOiBmZmZmODg4MTAzYWI0MmI4Cj4gWyAgIDM3LjgyNTcyMV0gUjEzOiBmZmZmODg4MTA2ZGJl
ODUwIFIxNDogMDAwMDAwMDAwMDAwMDAwMyBSMTU6IGZmZmY4ODgxMDc0ZWJjMTgKPiBbICAgMzcu
ODI2MzI2XSBGUzogIDAwMDA3ZjAyZmJhNmVmMDAoMDAwMCkgR1M6ZmZmZjg4ODg1ZjhjMDAwMCgw
MDAwKQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMzcuODI3MDM1XSBDUzogIDAwMTAg
RFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gWyAgIDM3LjgyNzU1Ml0g
Q1IyOiAwMDAwMDAwMDAwMDAwMDAwIENSMzogMDAwMDAwMDEzMjVlNTAwMyBDUjQ6IDAwMDAwMDAw
MDAzNzJlYTAKPiBbICAgMzcuODI4MTYyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAw
MDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAzNy44Mjg3NzJdIERSMzog
MDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAw
NDAwCj4gWyAgIDM3LjgyOTM4MV0gQ2FsbCBUcmFjZToKPiBbICAgMzcuODI5NjYwXSAgPFRBU0s+
Cj4gWyAgIDM3LjgyOTkxMV0gID8gX19kaWUrMHgxZi8weDYwCj4gWyAgIDM3LjgzMDIzNF0gID8g
cGFnZV9mYXVsdF9vb3BzKzB4MTRjLzB4M2IwCj4gWyAgIDM3LjgzMDYyM10gID8gZXhjX3BhZ2Vf
ZmF1bHQrMHg3NC8weDE0MAo+IFsgICAzNy44MzA5OTldICA/IGFzbV9leGNfcGFnZV9mYXVsdCsw
eDIyLzB4MzAKPiBbICAgMzcuODMxNDAyXSAgPyBfY29tcGF0X3ZkcGFfcmVzZXQrMHg0Ny8weGMw
IFt2aG9zdF92ZHBhXQo+IFsgICAzNy44MzE4ODhdICA/IF9jb21wYXRfdmRwYV9yZXNldCsweDMy
LzB4YzAgW3Zob3N0X3ZkcGFdCj4gWyAgIDM3LjgzMjM2Nl0gIHZob3N0X3ZkcGFfb3BlbisweDU1
LzB4MjcwIFt2aG9zdF92ZHBhXQo+IFsgICAzNy44MzI4MjFdICA/IHNiX2luaXRfZGlvX2RvbmVf
d3ErMHg1MC8weDUwCj4gWyAgIDM3LjgzMzIyNV0gIGNocmRldl9vcGVuKzB4YzAvMHgyMTAKPiBb
ICAgMzcuODMzNTgyXSAgPyBfX3VucmVnaXN0ZXJfY2hyZGV2KzB4NTAvMHg1MAo+IFsgICAzNy44
MzM5OTBdICBkb19kZW50cnlfb3BlbisweDFmYy8weDRmMAo+IFsgICAzNy44MzQzNjNdICBwYXRo
X29wZW5hdCsweGMyZC8weGYyMAo+IFsgICAzNy44MzQ3MjFdICBkb19maWxwX29wZW4rMHhiNC8w
eDE2MAo+IFsgICAzNy44MzUwODJdICA/IGttZW1fY2FjaGVfYWxsb2MrMHgzYy8weDQ5MAo+IFsg
ICAzNy44MzU0NzRdICBkb19zeXNfb3BlbmF0MisweDhkLzB4YzAKPiBbICAgMzcuODM1ODM0XSAg
X194NjRfc3lzX29wZW5hdCsweDZhLzB4YTAKPiBbICAgMzcuODM2MjA4XSAgZG9fc3lzY2FsbF82
NCsweDNjLzB4ODAKPiBbICAgMzcuODM2NTY0XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDYvMHhiMAo+IFsgICAzNy44MzcwMjFdIFJJUDogMDAzMzoweDdmMDJmY2MyYzA4NQo+
IFsgICAzNy44MzczNzhdIENvZGU6IDhiIDU1IGQwIDQ4IDg5IDQ1IGIwIDc1IGEwIDQ0IDg5IDU1
IDljIGU4IDYzIDdkIGY4IGZmIDQ0IDhiCj4gNTUgOWMgODkgZGEgNGMgODkgZTYgNDEgODkgYzAg
YmYgOWMgZmYgZmYgZmYgYjggMDEgMDEgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMCBmMAo+IGZmIGZm
IDc3IDMzIDQ0IDg5IGM3IDg5IDQ1IDljIGU4IGI4IDdkIGY4IGZmIDhiIDQ1IDljCj4gWyAgIDM3
LjgzODg5MV0gUlNQOiAwMDJiOjAwMDA3ZmZkZWEzYzhjYzAgRUZMQUdTOiAwMDAwMDI5MyBPUklH
X1JBWDoKPiAwMDAwMDAwMDAwMDAwMTAxCj4gWyAgIDM3LjgzOTU3MV0gUkFYOiBmZmZmZmZmZmZm
ZmZmZmRhIFJCWDogMDAwMDAwMDAwMDA4MDAwMiBSQ1g6IDAwMDA3ZjAyZmNjMmMwODUKPiBbICAg
MzcuODQwMTc5XSBSRFg6IDAwMDAwMDAwMDAwODAwMDIgUlNJOiAwMDAwNTVlNDM5YjVmYTQwIFJE
STogMDAwMDAwMDBmZmZmZmY5Ywo+IFsgICAzNy44NDA3ODVdIFJCUDogMDAwMDdmZmRlYTNjOGQz
MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwN2ZmZGVhM2M4ZGY4Cj4gWyAgIDM3Ljg0
MTM5Nl0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI5MyBSMTI6IDAw
MDA1NWU0MzliNWZhNDAKPiBbICAgMzcuODQyMDE0XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0
OiAwMDAwNTVlNDM3OTJmZDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAzNy44NDI2MjZd
ICA8L1RBU0s+Cj4gWyAgIDM3Ljg0Mjg4NF0gTW9kdWxlcyBsaW5rZWQgaW46IHZob3N0X3ZkcGEg
dmhvc3QgbWx4NV92ZHBhIHZyaW5naCB2aG9zdF9pb3RsYgo+IHZkcGEgbWx4NV9pYiBtbHg1X2Nv
cmUgeHRfY29ubnRyYWNrIHh0X01BU1FVRVJBREUgbmZfY29ubnRyYWNrX25ldGxpbmsgbmZuZXRs
aW5rCj4gaXB0YWJsZV9uYXQgbmZfbmF0IHh0X2FkZHJ0eXBlIGJyX25ldGZpbHRlciBycGNyZG1h
IHJkbWFfdWNtIGliX2lzZXIgbGliaXNjc2kKPiBzY3NpX3RyYW5zcG9ydF9pc2NzaSBpYl91bWFk
IHJkbWFfY20gaWJfaXBvaWIgaXdfY20gaWJfY20gaWJfdXZlcmJzIGliX2NvcmUKPiBvdmVybGF5
IHpyYW0genNtYWxsb2MgZnVzZSBbbGFzdCB1bmxvYWRlZDogbWx4NV9jb3JlXQo+IFsgICAzNy44
NDU0MzddIENSMjogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAzNy44NDU3NzhdIC0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo+IFsgICAzNy44NDYyMDVdIFJJUDogMDAxMDpfY29t
cGF0X3ZkcGFfcmVzZXQrMHg0Ny8weGMwIFt2aG9zdF92ZHBhXQo+IFsgICAzNy44NDY3MzBdIENv
ZGU6IGM3IGM3IGZiIDEyIDU2IGEwIDRjIDhkIGE1IGI4IDAyIDAwIDAwIDQ4IDg5IGVhIGU4IDdl
IGI4IGM0Cj4gZTAgNDggOGIgNDMgMjggNDggODkgZWUgNDggYzcgYzcgMTkgMTMgNTYgYTAgNGMg
OGIgYWQgYjAgMDIgMDAgMDAgPDQ4PiA4YiAwMCA0OQo+IDhiIDk1IGQ4IDAwIDAwIDAwIDQ4IDhi
IDgwIDg4IDQ1IDAwIDAwIDQ4IGMxIGU4IDA4IDQ4Cj4gWyAgIDM3Ljg0ODI0MF0gUlNQOiAwMDE4
OmZmZmY4ODgxMDYzYzNjMzggRUZMQUdTOiAwMDAxMDI0Ngo+IFsgICAzNy44NDg3MTFdIFJBWDog
MDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4ODgxMDc0ZWI4MDAgUkNYOiAwMDAwMDAwMDAwMDAw
MDAwCj4gWyAgIDM3Ljg0OTMxOV0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZjg4ODEw
M2FiNDAwMCBSREk6IGZmZmZmZmZmYTA1NjEzMTkKPiBbICAgMzcuODQ5OTI0XSBSQlA6IGZmZmY4
ODgxMDNhYjQwMDAgUjA4OiAwMDAwMDAwMGZmZmZkZmZmIFIwOTogMDAwMDAwMDAwMDAwMDAwMQo+
IFsgICAzNy44NTA1MzFdIFIxMDogMDAwMDAwMDAwMDAwMDAwMyBSMTE6IGZmZmY4ODg4N2ZlY2Jh
YzAgUjEyOiBmZmZmODg4MTAzYWI0MmI4Cj4gWyAgIDM3Ljg1MTEzNl0gUjEzOiBmZmZmODg4MTA2
ZGJlODUwIFIxNDogMDAwMDAwMDAwMDAwMDAwMyBSMTU6IGZmZmY4ODgxMDc0ZWJjMTgKPiBbICAg
MzcuODUxNzQxXSBGUzogIDAwMDA3ZjAyZmJhNmVmMDAoMDAwMCkgR1M6ZmZmZjg4ODg1ZjhjMDAw
MCgwMDAwKQo+IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMzcuODUyNDY0XSBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gWyAgIDM3Ljg1Mjk3
NV0gQ1IyOiAwMDAwMDAwMDAwMDAwMDAwIENSMzogMDAwMDAwMDEzMjVlNTAwMyBDUjQ6IDAwMDAw
MDAwMDAzNzJlYTAKPiBbICAgMzcuODUzNTg1XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAw
MDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAzNy44NTQxOTJdIERS
MzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAw
MDAwNDAwCj4gWyAgIDM3Ljg1NDc5N10gbm90ZTogcWVtdS1zeXN0ZW0teDg2WzE3MjddIGV4aXRl
ZCB3aXRoIGlycXMgZGlzYWJsZWQKPgo+IExvb2tzIGxpa2UgdGhlIHBhdGNoZXMgYXJlIGFscmVh
ZHkgaW4gbGludXgtbmV4dCBzbyBJIGd1ZXNzIHdlJ2xsIG5lZWQgYSBmaXggZm9yCj4gdGhpcy4K
PgpUbyBEcmFnb3M6IHRoYW5rcyBmb3IgeW91ciByZXBvcnQsIEkgd2lsbCBhZGQgeW91ciBSZXBv
cnRlZC1ieSBmcm9tIGhlcmUuCgpUaGFua3MsCi1TaXdlaQoKPiBUaGFua3MsCj4gRHJhZ29zCj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
