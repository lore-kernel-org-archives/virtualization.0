Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A880DC6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 19:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9AF360D65;
	Tue, 14 Mar 2023 19:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9AF360D65
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=gPX0Yp/r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=LwTDnfUD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4z1-iHDbyis; Tue, 14 Mar 2023 19:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13C1D60BC2;
	Tue, 14 Mar 2023 19:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13C1D60BC2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5113C0035;
	Tue, 14 Mar 2023 19:29:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0892C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 19:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90E9881208
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 19:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90E9881208
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=gPX0Yp/r; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=LwTDnfUD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vG2WErNWIdjZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 19:29:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D268A8142E
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D268A8142E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 19:29:34 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32EJJQBU025391; Tue, 14 Mar 2023 19:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=d9sfjAY3dQFoi9SrIS5EqiS9BMI2mJVS0J+9Y8ws0VU=;
 b=gPX0Yp/rxZ7xXfkJKAOZX12TkRwMVyppn1b6nBdc+O4uRCDa4eYHsTUXSnvpXHxTdRcf
 IMwbt05VeQx1YoOsTT6DIzaWrLcyucFhSVtJTrR9Yn6xUQZ8sgxstAi/M6CzSVXmGB8v
 Sfvrlo8fQ6ICEKGibvczMg3J3lkz6yCfg0IJQ937swwnKMOC565kP6+XkzRhIO149PCI
 GPbWE0qfXl/SS3bLoRvOPVAnxNOmJz2QQv1sBldaqZ6E7+796SInI8umVUo1kliY0dHC
 1+fANnYxp7I4dMqxrUBW9VoumMYOXCA46WROsC7jOcLvD5rY1aEO9tT1tZUgIDmyR+8T 2g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g81fj2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Mar 2023 19:29:33 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32EJG0DB016536; Tue, 14 Mar 2023 19:29:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3p8g374m0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Mar 2023 19:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVzgYNVogJsVGfby8LlGv5i4j7B440fDViRL83BpP3L7pdds8TbRhZSlYr+btoUDeaxLi+PSLIyTSIOxgOLPyaXzp8uw7N/3+KTjd52FzzEfZYp704Kn7hNjEhfdZgtGrlx5qhZxoKxy0N9c4kSIBCnOGB7wLTZd5nEVrDiVJ8p3JI3u9bd4ePw8ZSSqucM20+1yhQr3f0rdYW64f/t46IXAunHVPbjGKWM1zMbxX3VihXoFE36hgZpnfWHVEoP9rrYWX1hE1X5sIsHhBkOLr8d1uR+QZOQOdgIxmuXjJbYZhNjj2DW5ifez7UgIw/YTzUUeIXv79DMzPA6wDr9oFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9sfjAY3dQFoi9SrIS5EqiS9BMI2mJVS0J+9Y8ws0VU=;
 b=FkOJ6KWKmpuSq8WWLA6IWbjJ3iKbaDJiRNMtgo0SbQTmXi5PWP5uG8kcURH8zO9ptYiBGSkaVxtzTlTmKfCszmbjiP8mbJOkYlEuzhE7Fo7E0PDpWMXVI2aR5yn8n7ADZt9bvlipGXFWaa+v5rwOpppyVtYo1z5EdauAnYvnK4zuyGd6TTtlF4V7ZDb5V4Bx061rboPCg6W9+7mBarXfbubRpvAqMgIlgLA9gLxNOsaLo7RgjMbTUp+qh8rFwQqG+v3WxQiwVIa1Vw7W1vpCMy/dZJTE1C14BHkzKPUkHy9O8SEAPVbE/SI/kVTct6d7XYvgqxrnQSQJWZrGbcTT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9sfjAY3dQFoi9SrIS5EqiS9BMI2mJVS0J+9Y8ws0VU=;
 b=LwTDnfUDXs7KyPCxEy7rsEJJ+dIF7lDdSt7KBEzIZQeDPqlxmrkPtTYDDxHnnzx6yQ+CTK5f9DdK/QNj2OPe8jfw2K9yLIklo6r5gn07VDFy4V8CT8eE3842zyYw5HZqpzrs8W+RT0bHnc+hngu7C036eJPv6dPZoLOGe/YOKpk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 19:29:30 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 19:29:30 +0000
Message-ID: <8952f08f-cc61-cf5f-7ffe-3f2a80891d28@oracle.com>
Date: Tue, 14 Mar 2023 12:29:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Content-Language: en-US
To: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f269688b-8392-406c-e070-369b25acc252@oracle.com>
 <PH0PR12MB5481A0629C479A030C8A8EDEDCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313233638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DE6E7A0594D38019305DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54816DE6E7A0594D38019305DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:806:a7::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c99748-d413-495b-fe02-08db24c26e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uugZWQ+cWLK4BkJc7QNxOy2RK5EGc31tWJLtzQamEu4pPE18IiICyN08R5GAHQqDsumiLxdGsyEJQBjGtP1RmeFc+Da0vn4/m5yE8TPFhItyCEaYSmNSRPCZOBHUIQu1MhPABqKhqEHyXRwG0KW8D7zujBLBqQrwxWNsYrBvBlP6oroqv64+h2i1EPIcUzpbRccB5zxBrtuYT9JsT5X6KOHUEi42TmedW+KIVqwSaxBJPYKygzFN+zL0Ge8vnZfKzVulX/9vOKyjVyam5lNFOnX3+kBzE1QltkZOJVpom8nQwuWyTD3GUDkV0YQlaO3I1g/cWOCH2GOtWSYBHGUTXbfxTPM5M8bkdl5X5R/G/0aij2Y+xThOXv1dk2HmC1lxKF0sVLuRd2u/HNUEjPuqchMnaK3tsbxUEy+i2trZB6Flh0gxQysScNQdXPPlT2GYzFCvs4SXB5wTzdJaRr5G4T2OMcCUWjhUsSfgSxWJtszzpufa9Bx0ZM/cPFUGcHdokp7JNE85auEwQlwxG4fe6+GbK8Kyh0EQTWjaZnlzgDDGBFzLQMcNRpMPfKusL4+o7LCmbecC9BbIr8vlGwx1331XazqqDb32S7C2noHMFtOTPLmpVE6iWC5z4qrHSC/+Yag7EiR/ubvEQLawf9oglU6FX023wfoEN+6+9/KKtxE4RMg3+TkUY1X4ufXDusXhnH0RzuMDpuxqCFZpHD2oAA4Q7HQl1AueUwb4kOkDg60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(31686004)(41300700001)(36756003)(5660300002)(66946007)(66556008)(31696002)(66476007)(86362001)(38100700002)(8676002)(4326008)(8936002)(316002)(110136005)(54906003)(186003)(6506007)(478600001)(26005)(53546011)(6512007)(36916002)(2616005)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGgwUG54bnliSkh5dEZuTHpFNHdNTDcwT2F1KzF1VHE4SnVjNm83QWh5MHVl?=
 =?utf-8?B?RmFRUGZCYnBHU3puTGEybm9US09CbjdZclBCRnNua3FnWVFpRk1WTWI3cGtx?=
 =?utf-8?B?V1RTdG1LbG9TZGhDMm1neDJwQnJKSSs0OHRHaFIxMzZ2aFBTSVh4bU5NWXRV?=
 =?utf-8?B?eE5YWWpwazE3OWxVSXhHUUh2SzdhcmVBTzdtM215WE02a1JXWTBSdnhCcUNL?=
 =?utf-8?B?bnVnMDdKU1kxS3Zvc3QrcE5QUEVsVWpzWkZWczE0cExBd0NIM0I2SER0VSsv?=
 =?utf-8?B?Q0hNT1o4REFCYWgrKzU4d0l2bmJVV0Q1NTRHNkJSTlZkN3VuT1ExNkpyendM?=
 =?utf-8?B?YXR6U0VTaGZWY2FQa3hvQlFEV2NucEdudWI3eUZHbVZkUlpycEZJdFNHdlUv?=
 =?utf-8?B?R0VDYmUyaUcwR0xSZjZmWENVeDJ4dTNUVzlvbllwK0ZQd3NJVzE2blFaZDJh?=
 =?utf-8?B?ckZ6R0VFYUZiUDhReW1wSXRKZU9VYVUzTWtGQVpVZm9EWkhHeFg1RmE2NzFM?=
 =?utf-8?B?cTAyWXdxMTdtU3djNitKNjRpTE1tLzVzcy85SWZFaVQvYitvQ0NzenJUK2hX?=
 =?utf-8?B?aXRlaUhlVktDM1c4Q0RsZlJsV1RSRWRRYU9nNDdOVmlZb0FBNW5UclVydzAz?=
 =?utf-8?B?VjVyRGt3SnYyWThtS1F5aTIwdVVaTkg3dnUrS0FWWlVsQ05CejlJbTRERU1C?=
 =?utf-8?B?MWt4YzVYcUo3Zm15aWVEMlVsZzZxU3hmN0lNSlB4Vko4b3FzOUU1dU1DWVRB?=
 =?utf-8?B?bmI5UlhaWnpWUU1uWnpoUUM3d2dObTlCR055UHNBdXMvWE9hcDVqVWpLRWxi?=
 =?utf-8?B?UlZkWC8wTm1MMUFpNWhNc3ZoQTEvZk5jZ1U1UGN3YzNkdk11NGtxeEx2Q1Ur?=
 =?utf-8?B?cGZHTmt5T0R2SE5jM3o1Yk9ReUova1d4R3lGckptSWFMV0cyKzJSV0dIbmRO?=
 =?utf-8?B?cHdETnpFK25NcUN2Q1FlTVZ6WGlJRk0za1V4SGl2QkN2cVMzZG02NExsdTBS?=
 =?utf-8?B?cUlJMjdFZGNlWE91bHVtcXlyNEo1L3BEaG1lQVdKV0J6Y2dVS1dCM3pDbkQr?=
 =?utf-8?B?Wm5BemJuUVYveUJGekNtTnd3S2YvWnViNVdRRWlwYUZkWjk4dUlJVUdhbUpU?=
 =?utf-8?B?MzFzalVKbkk1ZEg2NThCcjFwWmsvQU4yTkdoVms5ZEMxWHUxNkZzUCs1WHk3?=
 =?utf-8?B?M1QyT1g3eFJwNFNaRld0endSMWtpcHA1WWd3L0V2cVloeHhqTW53MEQ1dlRC?=
 =?utf-8?B?VzI5dnM2cGM3dk9IYnNSUmtJWG93V2FQa1B3OEhVbG11M0ptd1FXTjhGSWd4?=
 =?utf-8?B?SXcyamxFM1lVdWJlT0dMVkJ3MVFQUDBrYzljTGNUbkxHQldzVCtDQkRDV1BL?=
 =?utf-8?B?YllwTnpGcC8rOSt2djJnaENhcVZoQmlDOWF0cllkem4yUnFKVE02Y2J2RzVp?=
 =?utf-8?B?Nm5teWdkMFVLYS9BUjI3a2VtdzF0YThBcm9tVzZjUDBsenJ3RzZYSXpRTlpt?=
 =?utf-8?B?VW1vbmRpOUFBSkpYVWVkV1NiU3FvUllEOXQycnhodWdQTlIxREhFbUs4TDYv?=
 =?utf-8?B?QW9kNHNBQkEzdDgxbU1maVgzK29lQW9Rekp6M2U2UXNNbjRxWUZPaDF6TUJW?=
 =?utf-8?B?WWdvTVU5L1puRmlreGRVZmx0TkMzVDR1SUxSc2h6Nyt2VzFTSS9ySnFYc3Nw?=
 =?utf-8?B?T25tMytKVjZxNnZ3YlJPb2R1eXUwUyt3ZGpPQU90T3hIQnJzMG5aYyt3YlRK?=
 =?utf-8?B?Yk9SV09GK1hwM3IvcnhVSjFkdWdwbnA3RTBheEY2cnhMTmdaY1VGZE0zbGdH?=
 =?utf-8?B?WEJSZjlLZTVrRmN2eHRWZ1dCSVJuS3lhc1ZsOEtYSXprQzh2MHRXS2hINkZq?=
 =?utf-8?B?QTFidEMrY3NYcVNBbnBuVmUrVHNVN3FaL2l1MkVOaFVJQ2Z1aHNnaXg3Ukdn?=
 =?utf-8?B?ZUtGK1F2MmlMSE9KMmJ0OXN6aHlNTkxiOFdxaWZtdU0ra1VnMklBOUdzeTJq?=
 =?utf-8?B?RTc2SElVbjZHcGVnL0h2VldsSUJRbmcyNFByR0syc0ZRL0p0d2FGSGZZbU54?=
 =?utf-8?B?VGtQZmNmRUV5UE81ZmxKSnM0NnRlbW5vUndZK2pjbisyRWNEZytUZWRNM01s?=
 =?utf-8?Q?W6l0tgywepLOiScL0gwRUP1cz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mtAcddnRjllrNwIKsLE1Cfz13X4em0B/StYBgPv5pV+cJqhAOWaKklL3Y/l+UgeSc4j7CbDTMRFrxjCNLzg4/AKCUHmpRlB5ppUK+Isf/4CbjMiQg2zCGHdo7ijxEP03PtkBKXGQ9/MeDD7ygbxOfVwFt8QZFtet1uWd+VgMjRWCuvSvD3VxsNeiYfTilWaBk3cOQVXMN7I+rKca4oS0tqMfgvmQ2p01e/gMWm81K3p1es7cza3+Rk7U2Gp7Me0Hj/MX57xhzBlbVofkl1bFQG8iTifQp9/ioWSLc2rIupROQJ3G3xC2QG9ZFMf6B+wtEYaOcfXxdTny6Kp9P5PRug58SjVzNkwVfpNLwRJ4ePgCITIfl4sazSPSMqWQD98B+g8II8V/72qQF52gaw2p/vgr05huqRS/0uoa20pAP35LeTlUeICRJ1VKQBgq8tQBzjHpEDR95+wydUgDzsd/6X7L3Sw0jO56u5SjgRVsEaWBkHAXrwHB6cMI6vuu5fiQceB09nDH/6LU5phDLARmkZVRYJ9G65lJwLaiQU5ffVc/KsKvWHEWjsWV3qJZsa/jTM9JrWyRwnS01aAxAi3FD2nMa37/jv8c+Vic9hnmCl/tEFh4QOHaJs5awgRw/C6bGkup2smg6eFo2LgiOmnoj4aBgUE+HNC3M5hhq5JEZhqbjmaNghwZPLDE4F/8NPFdGnpcT72GP3/1uk7MDhFQPlAmz3DjK/G7FpUh68Mci2if9AH4C4WB7LFyeEG/7ELCEummGc/vTC+SUkM90rFnoERrtC+hxEsZaSNqO6IGL76MALvIVuWRhRTftmYTubq+gYEBYi2P/YK2D9OBpEGr7SSHY7xfh0JrkxZ+/RFfynLCIaL8q7JJ4XXkASGZgPlo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c99748-d413-495b-fe02-08db24c26e95
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 19:29:30.2979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urAztJ/u4I369MkMB69ZagXQiiEQLY7auVZuXcTZrRFVFiYGMYwbLXYRkeGGVddtNLKKdXyo3msCSeZRIuwDNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_12,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=849
 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140159
X-Proofpoint-ORIG-GUID: IIVfzsLSmj9d8DyPMaRbdveGbezVWdnO
X-Proofpoint-GUID: IIVfzsLSmj9d8DyPMaRbdveGbezVWdnO
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "perezma@redhat.com" <perezma@redhat.com>
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

CgpPbiAzLzEzLzIwMjMgODo0NyBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+PiBGcm9tOiBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+PiBTZW50OiBNb25kYXksIE1hcmNoIDEz
LCAyMDIzIDExOjM4IFBNCj4+Cj4+IE9uIFR1ZSwgTWFyIDE0LCAyMDIzIGF0IDAyOjA1OjUwQU0g
KzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4+Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAxMywgMjAyMyA2OjE5IFBN
Cj4+Pj4gQWN0dWFsbHkgdGhlcmUncyBubyBzdWNoIGJ1cmRlbiBvciByZXF1aXJlbWVudCB0byBt
YWludGFpbiBiYWNrd2FyZAo+Pj4+IGNvbXBhdGliaWxpdHkgZm9yIHRoZSBkZWZhdWx0ICd2ZHBh
IGRldiBhZGQnIGJlaGF2aW9yIGlmIGRlZGljYXRlZAo+Pj4+IGRldmljZV9mZWF0dXJlcyBpcyBu
b3Qgc3BlY2lmaWVkLiBIaXN0b3JpY2FsbHkgdGhlIGRlZmF1bHQgdmRwYQo+Pj4+IGNyZWF0aW9u
IG9uIG1seDUgZXZlciBnb3QgY2hhbmdlZCBmcm9tIHNpbmdsZSBxdWV1ZSB0byA4IHF1ZXVlIHBh
aXJzCj4+Pj4gd2hlbiBWSVJUSU9fTkVUX0ZfTVEgZmVhdHVyZSB3YXMgZmlyc3QgaW50cm9kdWNl
ZCB0byBtbHg1X3ZkcGEsIHRoZW4KPj4+PiB0aGUgZGVmYXVsdCBzd2l0Y2hlZCBiYWNrIHRvIDEg
ZGF0YSBxdWV1ZSBwYWlyIGFnYWluIHdoZW4gbWF4X3ZxcAo+PiBhdHRyaWJ1dGUgd2FzIGFkZGVk
IHRvIHRoZSB2ZHBhIHRvb2wuCj4+Pj4gRXNzZW50aWFsbHksIGV2ZXJ5IGFkZGl0aW9uIG9mIG5l
dyBmZWF0dXJlIHRvIG1seDVfdmRwYSwgZS5nLgo+Pj4+IENUUkxfVlEsIENUUkxfVkxBTiwgYW5k
IGV0IGFsLCBlZmZlY3RpdmVseSBjaGFuZ2VkIHRoZSBkZWZhdWx0ICJ2ZHBhCj4+Pj4gZGV2IGFk
ZCIgYmVoYXZpb3Igbm90IGp1c3Qgb25seSBvbmNlOiB0aGUgYmFja3dhcmQgY29tcGF0aWJpbGl0
eQo+Pj4+IGd1YXJhbnRlZSBpcyBzaW1wbHkganVzdCBub3QgdGhlcmUgYW5kIGV2ZXIuCj4+PiBU
aGlzIHJlcXVpcmVzIHRoYXQgZXZlcnkgY2hhbmdlIGluIHRoZSBkZXZpY2UgYXR0cmlidXRlcyB3
aWxsIGNoYW5nZSB0aGUKPj4gYmVoYXZpb3IgZm9yIHZkcGEgZGV2IGFkZC4KPj4+IFRoZSBPUiBv
cGVyYXRpb24gb2YgdGhlIHVzZXIgc3VwcGxpZWQgZmVhdHVyZSBiaXRzIHdpdGggZGV2aWNlIGRl
ZmF1bHRzCj4+IGZlYXR1cmUgYml0IGRvZXNu4oCZdCBsb29rIGdvb2QgdG8gbWUuCj4+PiBJdCBi
cmluZ3MgdW5jZXJ0YWluIGJlaGF2aW9yLgo+Pj4KPj4+IFRoZSByaWdodCBiZWhhdmlvciBzaG91
bGQgYmUsIGlmIHVzZXIgc3VwcGxpZWQgdGhlIGZlYXR1cmUgYml0cywgaXQgc2hvdWxkCj4+IHN1
cHBseSBhbGwgZGVzaXJlZCBiaXRzLgo+Pgo+PiBJIHRoaW5rIHUgbWVhbiBhbGwgdGhhdCBkZXZp
Y2UgYWxzbyBzdXBwb3J0cy4KPj4KPiBJZiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUgYml0cyBhbmQg
ZGV2aWNlIGRvZXNu4oCZdCBzdXBwb3J0IHNvbWUgb2YgdGhlIGZlYXR1cmUgYml0cyAtPiBhZGQg
Y29tbWFuZCBmYWlscy4KPiBJZiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUgYml0cywgdGhhbiB1c2Ug
b25seSB0aGUgZmVhdHVyZSBiaXRzLiBEbyBub3QgT1IgdXNlciBzdXBwbGllZCBmZWF0dXJlIGJp
dHMgd2l0aCBkZXZpY2Ugc3VwcG9ydGVkIGZlYXR1cmUgYml0cy4KSSB0aGluayB0aGF0IGlzIHRo
ZSBub3QgdGhlIGN1cnJlbnQgYmVoYXZpb3IgZm9yIG1seDVfdmRwYT8gQXMgZmFyIGFzIEkgCmNh
biBzZWUgaXQgd291bGQgQU5EIHVzZXIgc3VwcGxpZWQgZGV2aWNlX2ZlYXR1cmVzIGJpdHMgd2l0
aCB0aGUgZGV2aWNlIApzdXBwb3J0ZWQgZmVhdHVyZSBiaXRzIChmaW5kIHRoZSBjb21tb24gcGFy
dCBvZiBib3RoIGZlYXR1cmUgYml0cykgdGhlbiAKcHJvY2VlZC4gSSBhbSBub3Qgc3VyZSBJIGZv
bGxvdyB3aGF0IGlzIHRoZSBwcm9ibGVtPwoKPiBGb3IgZXhhbXBsZSwKPiBVc2VyIGFza2VkIHRv
IHNldCwKPiBGX0NPTkZJR19NVFUKPiBGX0NPTkZJR19NQUMKPiBGX1BBQ0tFRAo+IEluIHRoYXQg
ZGV2aWNlIHNob3VsZCBvbmx5IHVzZSBhYm92ZSAzIGZlYXR1cmVzLiAoYmVjYXVzZSB1c2VyIGlz
IHRoZSBtYXN0ZXIpLgo+Cj4gSXQgc2hvdWxkIG5vdCBPUiB1c2VyIHN1cHBsaWVkIGZlYXR1cmUg
Yml0cyB3aXRoIGRldmljZSBkZWZhdWx0cyBmZWF0dXJlIGJpdHMuCj4gICAKPj4+IElmIHVzZXIg
ZG9lc27igJl0IHN1cHBseSBmZWF0dXJlIGJpdHMsIHVzZSB0aGUgZGV2aWNlIGRlZmF1bHRzLgo+
IElmIHVzZXIgZG9lc27igJl0IHN1cHBseSBhbnkgZmVhdHVyZSBmaXRzLCB0aGF0IG1lYW5zIHVz
ZXIgd2FudHMgdG8gcnVuIHdpdGggc29tZSBkZXZpY2UgZGVmYXVsdHMuCj4gSW4gdGhhdCBjYXNl
IGl0cyBmaW5lIHRvIHJ1biB3aXRoIGRldmljZSBkZWZhdWx0cy4KTm90ZWQsIHdlIGRvbid0IGhh
dmUgdGhpcyBkZXZpY2UgZGVmYXVsdHMgZXhwb3NlZCB0byB1c2VycyB5ZXQgb3RoZXIgCnRoYW4g
d2hhdCdzIHNob3duIGluIHRoZSBwYXJlbnQgbWdtdGRldiAoZGV2X2ZlYXR1cmVzKS4gQW5kIHRo
ZSBjdXJyZW50IAphbmQgdGhlIG9ubHkgc2FmZSBiZWhhdmlvciBmb3IgbWx4NV92ZHBhIGlzIHRv
IGluaGVyaXQgYWxsIGRldmljZSAKc3VwcG9ydGVkIGZlYXR1cmVzIGZyb20gcGFyZW50IG1nbXRk
ZXYsIG90aGVyd2lzZSB1c2VyIGNhbid0IGtub3cgaW4gCmFkdmFuY2Ugd2hhdCBkZWZhdWx0IGZl
YXR1cmVzIHRoZSBkZXZpY2UgbWlnaHQgY29tZSB1cCB3aXRoIGltcGxpY2l0bHkgCnVuZGVybmVh
dGguIEJhc2ljYWxseSBpdCB3b3VsZCBuZWVkIHRvIGFkZCBuZXcgQ0xJIGludGVyZmFjZSB0byBh
Y2hpZXZlIAp3aGF0IHlvdSB3YW50LgoKVGhhbmtzLAotU2l3ZWkKCj4KPj4+IEJ1dCBub3QgdG8g
bWl4IGJvdGggZmVhdHVyZSBiaXRzLgo+PiBDYW4ndCBzYXkgSSB1bmRlcnN0YW5kIHdoYXQgdGhp
cyBtZWFucy4gV2hhdCBkb2VzICJib3RoIiBtZWFuIGhlcmU/Cj4gTWl4IEJvdGggbWVhbnMsIHRv
IHBlcmZvcm0gT1Igb3BlcmF0aW9uIG9uIHVzZXIgc3VwcGxpZWQgZmVhdHVyZSBiaXRzIHdpdGgg
ZGV2aWNlIGRlZmF1bHRzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
