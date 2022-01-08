Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C51C433F5
	for <virtualization@archiver.kernel.org>; Sat,  8 Jan 2022 01:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24A3C82C04;
	Sat,  8 Jan 2022 01:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNQsiX-KPOrt; Sat,  8 Jan 2022 01:43:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7193582ACD;
	Sat,  8 Jan 2022 01:43:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 541E8C0030;
	Sat,  8 Jan 2022 01:43:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDD3AC001E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C557242864
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="1IMMAx96";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="u3xoWLxa"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLPjM9STwIxl
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:43:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98B3041634
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:43:35 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2081WQ5j018090; 
 Sat, 8 Jan 2022 01:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sgyJYhKH8iBLv2UyS9INn5tbwr8Io5wMOBZN/99HhyA=;
 b=1IMMAx96t6GBxJeb88DUAE67QM1sZ9RU8YnKL+MVVuqpImivNFac2lwfv+OUxMvjnUyF
 0bSl2vZKwRo/fYExN1mo/9mkP1U8e+PZllQefW4Ir7y1eEaYGVUSgpczCQq9l4ze7PYE
 2xET2BB3Okiitm8JyNS6uHefdjwrW7fPgiXslzvJclKUPhfBh6M/plHztwluO9bUZd4M
 76c+pY1QKXH6WERIU6j8MRwiNOZIhwmAE/52WoDxzBGDwv91acL7hrt2WSS1ifls5BOp
 CeeUnLlShnZz8sSmulXqb+XCE67CijCIvLDyf4CgO90pyRDkcl89t0f4DY91ldX74J51 CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3df11dg06n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:43:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2081gDKD136557;
 Sat, 8 Jan 2022 01:43:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by aserp3030.oracle.com with ESMTP id 3df0nagtgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzP8bEOSj+0jWl99Y+1SjbQDP3/N+OI9GZJ/MOLh9uCN8EmT4MYmafeI0BGBdCO+u7vtY7FX6IGiXL5wd3cF6/Y1WkRSJZGLVCTUvjGux7JUdsnAsmgyazSOdL/vLHmEipi6WE7eEdWtJ0NvHjQK04Nhn6FvO77hvcuHFH/57wChjTouxq1G/oRAfOsCnjo3hzoIvZpYa1BdfSTvVDdmK0HBiGlkrvay59a1PKIR1nzQEDYzMNI/fM2hKPONHD2mxtf86I3tI+g4aLI0X62jm8fgUtZXLSpaB6VytqeF/aQPBbGZXxlFrT896R9gBR4I7lEm4b79z8KRbNcUsVemmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgyJYhKH8iBLv2UyS9INn5tbwr8Io5wMOBZN/99HhyA=;
 b=Ty5+LAAef+5f1iy2r6mGzm4B6SfmRtrpeuZrOWSvvXMuBPxCHl6F5ulFAmBAFb1+ksy6OH3Fz8Yt4yWPq1C/pE8ul0Hgd7GnYiYPLWXwmj5STHih5DeZyw5iktCwnIUuuxGQ7Q85vSpWiZIHJPAwsv7aSeciTB5Ujhd3sdCtfyPBPdkPuS8PC+BmqVG+Atkgoz/bOWoIl1eXM6Z1+AFLjNQHd9rBjv+JkrmfhdFgKQRimdl2FdXeAixI+DLJW/C8CycdybQzRPH92gIov8XcS+MDxe9sygAq/OnkywPugsMGO2+S19p64uwHeNcdZZdiIIkJajjvafMxZMviQZlBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgyJYhKH8iBLv2UyS9INn5tbwr8Io5wMOBZN/99HhyA=;
 b=u3xoWLxaYat0JkmgnRiuAc6k4gZlEo8j0gEPymqYZ8PrHHuhpzvHrP9xsYXYSlqUzhsiQsCxQNHW3NR5F/JsEBVfHQsYKOs00qdQr23HPaW7hjOeG2o5ntL46dTL37fqiaLn+18OIzdIw1uQR8obO+fVfZkCpRADAbnwUtZppl8=
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by BN6PR1001MB2145.namprd10.prod.outlook.com (2603:10b6:405:2d::38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Sat, 8 Jan
 2022 01:43:21 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb%6]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 01:43:21 +0000
Message-ID: <233b923b-e6e2-0d47-8230-df91a35ee4de@oracle.com>
Date: Fri, 7 Jan 2022 17:43:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, Eli Cohen <elic@nvidia.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <YdiABvwrK3WxfHqb@archlinux-ax161>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <YdiABvwrK3WxfHqb@archlinux-ax161>
X-ClientProxiedBy: SN4PR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:803:2e::22) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0028c5dd-c690-472a-ee2f-08d9d2484087
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2145:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2145459F4595E4DAA2031440B14E9@BN6PR1001MB2145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPbX7TOcVK6rM7Y7Y/U3ji3/5ghtS9BrNiD4aPpYHRApZIV5q8tW31tgKdOpH0pvRWYodQpY90dECMhoq3XYLHxdwKoY+et8YeDKX/E5IuruRCeJz+62NZfJd7qZaJ8BYGizkTXYWB6fyy5DA2KBGQ7CsOXZaAlllC2mdIYhaDC+DexkrA56dtxNW5q3P6d/gs/KpiA2BpWtlmrIX175EBP3en7wkOkL221Sl8KzizgJxIENffMz2Z9E9CCoD+VhUBAvHXV3QatzzMi+uYepOEpXjSugJ52RXmO7k6OADIPssEb2HGjOmx7GpDVJKCPdFeyJ7HGx2oFsUh+ii8809bK5/uGtlu//PDLYDQNrCK67DTIpuvgrKNaGqKOd0M5VO+mhP7AH3bmGOVxCUKjakV3sktwnWT7xUUxC8psXhggFHUR3h5iXVL27KhMQITDoFxy3g2uUeVdoDLgxIvz2xadab0yXMkN09hiVzRMSgUgMnw+LahHVGqH3Y9iD9T80ikt9nR4PErJ0gYYQNVUMbN4uHvb+2Y8OGvobxXxgt24YF1YA8Tdi8wWoDh+NGX4xvRFCrdVFe+kSMdPvVmwsolLNmu7lKsZiLL5C0PSgq/Ymzh3xjBn2e5WLjA4Q+IIKyk2W4+Yhd+mySbgX/vH9RvJHJhAGea49BoskX5UHDFffqIO69vy85nJDHSit7EiiseC3sStf+LK8qf3zzuncSYsrC36URDzVY9CbtnqQhDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3283.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(5660300002)(2616005)(4326008)(36756003)(31686004)(6512007)(86362001)(38100700002)(31696002)(53546011)(66946007)(6506007)(66556008)(26005)(6666004)(66476007)(83380400001)(36916002)(316002)(2906002)(8936002)(508600001)(186003)(110136005)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdieGs4V2xaNEJDdytnZHJ3andTTGFiTVBvUDFEU0plcUVRdElKaTlqZFRC?=
 =?utf-8?B?ckFRcS9vZGFsY2tUYjR5RStIcTZMWElDVEFsbGh1Q3hEWHlmNFZTTC9vOXVV?=
 =?utf-8?B?dExOQ001Q3lFTldVdkswQ1BJVk8rZ2dTY2VEamxneGRqK2ovN2M0ZC83SUoz?=
 =?utf-8?B?YnZUdEh0eXVMOG1oMzhteTBrVkFXQU84Y09CeXpMdjNMSkU5aWZPR2tGOEJF?=
 =?utf-8?B?L3RwaE9rZEhvTG1wTlBUczJIaU44NnQ4TXJvRnl4SjE5cWdndHJaMEpMQ3hO?=
 =?utf-8?B?REd4aFhCSThHbjBnV3UvYlE0VjlSTXBHMk5jVmpYZjVNZlA2VWFXenJVdHpu?=
 =?utf-8?B?ek5LUGJLdFNQSzBLOVJjdWZLZUFBaHFrc2lHMHZNMnNZZ1lZNGlEOGJSTERk?=
 =?utf-8?B?dnpOUDA0THpmcU8vdnJqQVpZaXNZU1FkZ055MjkrZE5LbGFVME5FemNzUlpt?=
 =?utf-8?B?cGhGWkRXaUpzQkJWbkJFL3VKTlpHaGxycjNvSm43SlIwcXhVUVVoTzk5RGtp?=
 =?utf-8?B?TXpQUnFUaDBQVmk1WDlqTnFMWU9MTjFKekZVNHAzQlhjL3h4SUFRNmNmNWJN?=
 =?utf-8?B?S2ovcmFXakZlYWhFM1dDd2lla3ZyMUZDVGNLNFFkeXNvTnIyVTJqYlJKNTJQ?=
 =?utf-8?B?Y0VYK0FScmhBbHJZckthTkZXeVpYRVg0TncrTkRVN240U2JxL1g1ZmZveDFL?=
 =?utf-8?B?MnVEdTdqaXAxSmIzQnR6Rm1aejU2M3ZrMkZEVmwyOU1SdHd4V3BuWDBTdC84?=
 =?utf-8?B?WWlqdnR0Nnh0ekJJVS9HVlZFNFVHYlQvRW1UbTUwKzg2aVZ2aEVYeDZrNWFT?=
 =?utf-8?B?UGtRUHlJVkU0QmFDNmlPNzl1ckVZbExEUUpkOFJHSWhpZm0wSFQwUEg2N3Zw?=
 =?utf-8?B?UE1hOXIwUzE4OHIrbWIxc21qREdla1FtM05kSHFPVkZLelJ0cUdkaEZmVkNL?=
 =?utf-8?B?Z3owSXlVTURsanBQZkVUSk9FckFyRHk2Ull3QlNaYkQyMVBuYURLT0VzaUlG?=
 =?utf-8?B?MkI4aUNQRWpDZ052OG8yOHJiWVlRNFdtZ0hzUWtvbVZtMlJNeEtYMTVURHpP?=
 =?utf-8?B?a1ZEWmJpK1RVTzNvc290bzM2RzFyeGhqM1dQcFc0ODN5UjZSc1dLZlh3dTNv?=
 =?utf-8?B?aGJ4NEQzam5PNTNVdWxORXArWUE0MVZIaERDRWFGV2c1dGJOM1JSZUVQd1Ft?=
 =?utf-8?B?Ylh5dW5uWWpwNDkxM1F6a2ljRHlxSDRmVVp6MDZ3djdGZTZxdWUxcmJoNVJx?=
 =?utf-8?B?c3g1QTJFcGNYek9vMytPcHBIZC9MSWpDdGs3K3RKYVRjWTJ0Lzg2SHhFaWJh?=
 =?utf-8?B?aFlVR3NsWlhZUTQxWlpIcmFtOVFQeVpLemFUQmdwbVcxYUJmUW9jTDV6RUpu?=
 =?utf-8?B?S3puQXk2ak1zMEdGUmRvWkY1Zmk2bTNDTXNLRk1mSjBHL2Zndk5aVVQyTUN3?=
 =?utf-8?B?WVhWUGZoZHk1dlRHcm9QekdXcFhoKzlPQUpqZFFXV0dQaDE4d2FVbkQxVktO?=
 =?utf-8?B?am13ekhqSjFUWm1FZzdJcTB2SzNuY3AxL2lsSzRqL0JScnZaQ3RMeXpxSWFj?=
 =?utf-8?B?bEt4THpUb2JlYVpBci9aaGVqYi9aWDdkekw0bE9iMzZIR1k2Z3dyYnYyT3Vm?=
 =?utf-8?B?Z2pUZFlOU2RVUlEvOWhMd1BpZHlnM3F2eWpzTkRmQUVGb21OeEYwNFlueERs?=
 =?utf-8?B?bW1Ya3Qrb2dBMzJFZm9sbG5GU2NiVytnRzY5REpLeEpQZDZhc3NoSzFWN2Rh?=
 =?utf-8?B?eXhPWHB1SGRTcFZrS2tNN1drdE5ka1ozU1dPd3RDY0dXOFNTYXRXY0Vxb0dD?=
 =?utf-8?B?enJuYU9UM05mZ2EwZmFkZHBrVFhrMHhLQTRRYkV3RmsxZUtITFR4SHhreGMv?=
 =?utf-8?B?SmpReXhmNms0UHZyTHFiUTlCd0FUZFNqdG9SZ1ZGWmlpWHZ1SFpxSW1ieUJ1?=
 =?utf-8?B?Y29VMXVSNkgwVVZERFRJREFWb1FJU2FKeHhoTjhPQVMrUTNldFRFMTVVZCtU?=
 =?utf-8?B?WXJEQ1o5cDBXNnkwMnhBbHQyOUhONFU0c0EyWWl3WEtSV1pFTTVyNGVLUDEy?=
 =?utf-8?B?K0VRSFRlcVhGbnFsTEdVMnYwWVR5Ym1WelZkQlFZSWIwYzg0OVltU0YwL2kx?=
 =?utf-8?B?dmFQZWRJcngyenI4cGlOV3NLa1N6WURnbFZBVjJhWUdUMGZkY09OK2d6cnhO?=
 =?utf-8?Q?OWeBd0PGZQfizEFKkmsITVo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0028c5dd-c690-472a-ee2f-08d9d2484087
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2022 01:43:21.3170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8YaFrssyGBnGj9t5F/9njn1j18uNS8kZbFNDW2wzNqwaqaAbKJw+umw2UDOrbmj/9EG9COEDfkfvV4y5oU6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080007
X-Proofpoint-ORIG-GUID: wlBYhtrRhgoMQUDJYag5Yuq1B_BHwqg5
X-Proofpoint-GUID: wlBYhtrRhgoMQUDJYag5Yuq1B_BHwqg5
Cc: lvivier@redhat.com, mst@redhat.com, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

It's unfortunate. Don't know why this series got pulled into linux-next 
prematurely. The code review is still on going and there were 
outstanding comments that hadn't been addressed yet.

On 1/7/2022 10:01 AM, Nathan Chancellor wrote:
> Apologies if this reply is somewhat mangled. This patch did not appear
> to make it to the mailing list so I had to use another reply that did to
> base it on.
>
>> On 1/5/2022 3:46 AM, Eli Cohen wrote:
>> Check whether the max number of data virtqueue pairs was provided when a
>> adding a new device and verify the new value does not exceed device
>> capabilities.
>>
>> In addition, change the arrays holding virtqueue and callback contexts
>> to be dynamically allocated.
>>
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>> ---
>> v6 -> v7:
>> 1. Evaluate RQT table size based on config.max_virtqueue_pairs.
>>
>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++++++++++---------
>>    1 file changed, 37 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 4a2149f70f1e..d4720444bf78 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>>    	struct mlx5_vq_restore_info ri;
>>    };
>> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
>> - * provides for driver space allocation
>> - */
>> -#define MLX5_MAX_SUPPORTED_VQS 16
>> -
>>    static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>>    {
>>    	if (unlikely(idx > mvdev->max_idx))
>> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>>    	struct mlx5_vdpa_dev mvdev;
>>    	struct mlx5_vdpa_net_resources res;
>>    	struct virtio_net_config config;
>> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
>> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
>> +	struct mlx5_vdpa_virtqueue *vqs;
>> +	struct vdpa_callback *event_cbs;
>>    	/* Serialize vq resources creation and destruction. This is required
>>    	 * since memory map might change and we need to destroy and create
>> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>>    {
>>    	int i;
>> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
>> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>>    		suspend_vq(ndev, &ndev->vqs[i]);
>>    }
>> @@ -1244,8 +1239,14 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>    	void *in;
>>    	int i, j;
>>    	int err;
>> +	int num;
>> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
>> +	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> +		num = 1;
>> +	else
>> +		num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
>> +
>> +	max_rqt = min_t(int, roundup_pow_of_two(num),
>>    			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>    	if (max_rqt < 1)
>>    		return -EOPNOTSUPP;
>> @@ -1262,7 +1263,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>    	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>>    	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>>    	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>> -		list[i] = cpu_to_be32(ndev->vqs[j % ndev->mvdev.max_vqs].virtq_id);
>> +		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
>>    	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>>    	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>> @@ -2220,7 +2221,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>    	clear_vqs_ready(ndev);
>>    	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>    	ndev->mvdev.status = 0;
>> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
>> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>>    	ndev->mvdev.actual_features = 0;
>>    	++mvdev->generation;
>>    	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>> @@ -2293,6 +2294,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>    	}
>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>    	mutex_destroy(&ndev->reslock);
>> +	kfree(ndev->event_cbs);
>> +	kfree(ndev->vqs);
>>    }
>>    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>> @@ -2538,15 +2541,33 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>    		return -EOPNOTSUPP;
>>    	}
>> -	/* we save one virtqueue for control virtqueue should we require it */
>>    	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>> +	if (max_vqs < 2) {
>> +		dev_warn(mdev->device,
>> +			 "%d virtqueues are supported. At least 2 are required\n",
>> +			 max_vqs);
>> +		return -EAGAIN;
>> +	}
>> +
>> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
>> +		if (add_config->net.max_vq_pairs > max_vqs / 2)
>> +			return -EINVAL;
>> +		max_vqs = min_t(u32, max_vqs, 2 * add_config->net.max_vq_pairs);
>> +	} else {
>> +		max_vqs = 2;
>> +	}
>>    	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>>    				 name, false);
>>    	if (IS_ERR(ndev))
>>    		return PTR_ERR(ndev);
>> +	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
>> +	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
>> +	if (!ndev->vqs || !ndev->event_cbs) {
>> +		err = -ENOMEM;
>> +		goto err_alloc;
>> +	}
> Clang warns:
>
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2574:6: error: variable 'mvdev' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>          if (!ndev->vqs || !ndev->event_cbs) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2660:14: note: uninitialized use occurs here
>          put_device(&mvdev->vdev.dev);
>                      ^~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2574:2: note: remove the 'if' if its condition is always false
>          if (!ndev->vqs || !ndev->event_cbs) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2574:6: error: variable 'mvdev' is used uninitialized whenever '||' condition is true [-Werror,-Wsometimes-uninitialized]
>          if (!ndev->vqs || !ndev->event_cbs) {
>              ^~~~~~~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2660:14: note: uninitialized use occurs here
>          put_device(&mvdev->vdev.dev);
>                      ^~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2574:6: note: remove the '||' if its condition is always false
>          if (!ndev->vqs || !ndev->event_cbs) {
>              ^~~~~~~~~~~~~
> drivers/vdpa/mlx5/net/mlx5_vnet.c:2534:29: note: initialize the variable 'mvdev' to silence this warning
>          struct mlx5_vdpa_dev *mvdev;
>                                     ^
>                                      = NULL
> 2 errors generated.
>
> I was going to send a patch just moving "err_alloc" right above "return err;"
> but I don't think that is a proper fix. I think this patch is going to
> result in memory leaks on the err_mpfs and err_mtu paths, as ndev->vqs
> and ndev->event_cbs will have been allocated but they are only cleaned
> up in mlx5_vdpa_free_resources(). Additionally, I don't think the
> results of these allocations should be checked together, because one
> could succeed and the other could fail, meaning one needs to be cleaned
> up while the other doesn't.
>
> Cheers,
> Nathan
>
>>    	ndev->mvdev.max_vqs = max_vqs;
>>    	mvdev = &ndev->mvdev;
>>    	mvdev->mdev = mdev;
>> @@ -2627,6 +2648,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>    		mlx5_mpfs_del_mac(pfmdev, config->mac);
>>    err_mtu:
>>    	mutex_destroy(&ndev->reslock);
>> +err_alloc:
>>    	put_device(&mvdev->vdev.dev);
>>    	return err;
>>    }
>> @@ -2669,7 +2691,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>>    	mgtdev->mgtdev.ops = &mdev_ops;
>>    	mgtdev->mgtdev.device = mdev->device;
>>    	mgtdev->mgtdev.id_table = id_table;
>> -	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>>    	mgtdev->madev = madev;
>>    	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
