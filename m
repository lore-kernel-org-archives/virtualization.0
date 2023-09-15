Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB0EE3F2F
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 06:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB66440A60;
	Fri, 15 Sep 2023 06:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB66440A60
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=vts2gJN3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kpG1Nc32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RTkuVw07BtSF; Fri, 15 Sep 2023 06:34:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D51240253;
	Fri, 15 Sep 2023 06:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D51240253
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA5A6C0039;
	Fri, 15 Sep 2023 06:34:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB2BEC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83AD7612C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83AD7612C8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=vts2gJN3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=kpG1Nc32
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmerETkwzuSt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:34:33 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DB0360F66
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 06:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DB0360F66
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EKxkEG000825; Fri, 15 Sep 2023 06:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BP+SaTfJQaDEDlh3phf8tOR9i/T/Cqx5WFZaa9WfhPM=;
 b=vts2gJN3L3ZuHJ7sBAdcahQgsqtUnEc33rViuqGliTubW5Sv4Xg9Vpn89AdtT2c3wwDE
 05wpUloKm3/M55BHNCzqI3x6tWUk9vvSp/C1Q72Y1UfjRoT013mMhxZModohU4F03QzZ
 bYeu3yJQ5jX6AfqL9YV1p0o0p2BkOyWpZdrdYbngwwZpPewflRqqSs+91wT+FYm4ll0D
 JnYk1LNew7Dn7w6PcreJSxsWQV+kAGtQbXQs5u+MT6F6RZPSNdX5AQIw2RR43MLop9HC
 aMHQEXjO4EQorwnkQMXQFZmmKq95CgXCufpRAY8gIjbrWgssEc1ljb5kxY5nPoc0O3Zl FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr6b0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:34:25 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38F6Q1wf036208; Fri, 15 Sep 2023 06:34:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5fxx7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+wyAIlPX3e15gHelyledgwvXONUiWhN84NN3Ad51rl6j8N9r1pH6EHSgonDdFJrQ/aziaoMghsl9npyMQTWp8e3sZkAuDb72G3JqQh9TYweeARSP9zzpGbAldeHVpwvz9bIO9Y//sOGUd5tIztjvguRYfQSzKv8E6H63XqiBOGSSh8omHccoCuNp0Izz3x7WDwh3LNZ6uFsKd9v4zJglHQ2i8YLREtGS9b4Pf4EKbAwhG/oZQiF3dm/433WfQk6rT8qBbSF2lBr/eSOoK0xiP7rW2aYL4mzhjaoiEFKNbWWy295B+rocum36NSw6ovAZ1RC1LmSxNGIuM6TfSXAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP+SaTfJQaDEDlh3phf8tOR9i/T/Cqx5WFZaa9WfhPM=;
 b=NYvQJnvpc10Y3jRbVyzOgHbS9HC8RQlarMxbnwV+9uGwefYQuzy7KcufxZNX4lRnNa40myj7EKgGK9z0KOYP9RzD33hlDXmRMAiv9aTw73JHONhOWqL306kzp1IJgN3AGyn3KQhwEPQlHpE/hjEjex4IPo9zAeTwcWcXK/PvZBJhROAwvQl6Yhys0aBVXruEmAlMHOmc4UkBcEQ0LPjoNVcUP5eVPeqLHTAhbQFrPHFt8blpf21inG8aDDXV54Q/84BeauElu7zb1SbwimwmUHUF4Aih1FS1XEhfnolPU7HuZw9sA5fcmrPOF/0Rs5gmOK6C0nu2AN3uaffAdkYIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP+SaTfJQaDEDlh3phf8tOR9i/T/Cqx5WFZaa9WfhPM=;
 b=kpG1Nc32Q90TDWyAXItWEY/JMrpuLX7QTnvhxF5ZafRAt2X4ST2kT5ER4m3f79m+ZKu9pr55akcLEce9njVXiZXnF3tXjOV2GvAX/ABYzEv8QzppJqeHx12RXPsK4geAPPWCxvHweKN51Tgh5gs2rj2a6kZLZkpPLLl6F3401PA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 06:34:23 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:34:23 +0000
Message-ID: <b223d828-2c08-841f-47fb-7cb072fa5ec9@oracle.com>
Date: Thu, 14 Sep 2023 23:34:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 00/16] vdpa: Add support for vq descriptor mappings
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>, Lei Yang <leiyang@redhat.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <CAPpAL=w6KeBG5Ur037GNQa=n_fdoUwrFo+ATsFtX9HbWPHZvsg@mail.gmail.com>
 <CAJaqyWeVjKTPmGWwZ26TgebuzCaN8Z2FmPontHvZauOTQj0brQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeVjKTPmGWwZ26TgebuzCaN8Z2FmPontHvZauOTQj0brQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: cc378059-9ad3-4037-a9e9-08dbb5b5cc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Spb1a2alsD1/ylnqMV6KaQOffe1eKgsEy1wKfKr0sBxxKZCP5fP1Y741KuqtQlpMaUVlfwuT5t5RR4eU88ILKyG1IQCN/LmFWqFtmdQ/qAAD/luheC/jfE35SSz+FC/LaxiN4jsCjhVOdYBYipG6VA/xTVBPJzG5VhDu9p528l9Vz0ESUgw8aEoTbfpj1hrtuwcCV/HlBkOSzVHxUo186VC37mLy4nWFbfln7xB8lCjAak+/7R/RnspST3DYi/LsFpcgv+2T4HVNKNiQs/FEbKz1SB3BWkTUVTanDON6sNQqTpDH2D4p29OVLGaVcktoUK8Ki2O3GsKxyKYywhAkA3XloNukP71/OL0S3prd8dv2vxxG+c3muOOG/Hn5k5LJ78IHJ0Nj0RkwoH/7TBXHPIlbkEdrwYtl77CjWf6NvaMJ01rgT0My7nJMgNpOEnBbcUJD5tydypjIOwfXGiN7N7sKnFyc8tWdBRYJ7JULUSB9BKCaPj2uPvluFo042XanaWyTlnffBQczOBE6f2fzaUJKyU9dnBHSVvRSEa2wlfeUblZoNZOT1NclCAa/ENT2h1sHuOtmFSdZFhlSpZ6jqfJTbGwKa6C958G92Ipg1rF2rGBpG1iqJrc1p4y1q6yHwI8b4iOpnS7K5zfX1r09Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(966005)(6512007)(6506007)(6486002)(53546011)(66899024)(36916002)(83380400001)(38100700002)(31696002)(86362001)(36756003)(26005)(2616005)(4326008)(2906002)(7416002)(8676002)(41300700001)(5660300002)(66946007)(110136005)(316002)(54906003)(66556008)(66476007)(31686004)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhLRW1xVUswRUhRSnVPcWhmdDBteEZDZGtFY253amtiMHJoNjd1QmRMbm5x?=
 =?utf-8?B?TmwwMFFiUTJMMzBnMkl5S2JQanA2OHNGclRqUW5DYkpybm1TeUR1M1I0ZUdp?=
 =?utf-8?B?VkNEM2VOejdUbmI3MUEyZk9WeW9wTEVxalJMZU5WNm56ZHdkWGVOWUlqcWMz?=
 =?utf-8?B?WXZ2VkNwZEwyMVJVN0pKWjVueFJETVNQUkM3TFpib1dmSkxJcGk0NWlEeGFs?=
 =?utf-8?B?b1FxTFpRV0Q4Z1hZZnRRRGgxc0VXa084YWFzOUVacjhQOERyU3F0Vlp2aVR0?=
 =?utf-8?B?Um1jc3R1bll5NDQyODJUcjhhVXVITkNSeWNLQWpaQlBUVlUzQituZW8wZFpw?=
 =?utf-8?B?SVNxVnVSR1BEZE81VzBnVWVBNjVBbnduZ0ZySHcxR1JFUzA1eE1WWDhyQy85?=
 =?utf-8?B?bGRKd3dheWZ3L0lsaEFBQmpIb09Ic1JPUkRjM1Y2WURFdmQ4SlVkTGh2b2xx?=
 =?utf-8?B?WHNiNENBZTNiOTROK3FUOTgyWnJEVVgvZ1FKNW9FclE3UkxsUkZOYThVWlB5?=
 =?utf-8?B?UHBJYkFIQ0FmUE5xeFcvSk5hWnYvKytUdFF3RlZSdVBsZHUvUTJIcGgvekNy?=
 =?utf-8?B?ZEI5MVZUWGQ0cTBqd2FFbk9vT2llbUtOejJEb0Fja2V5NmNHbU9md3ViSXE4?=
 =?utf-8?B?Vnd4anptWUVYV0RkWm1TYVlLR3ZjS0xENW5ZMU13NGtpL0NQYjRFYkhzZHUy?=
 =?utf-8?B?Z0xaNWV1SENyMUhZTmR5cmJIWXRlK3M3WEM4VXUxSnV1SnlvMS9sUDZseXRj?=
 =?utf-8?B?dDlsbmtVQlFtWW5mb1AxSlFKQnJHT0VpbXZJdStIaFljS3ZIMkZ1R1A4VVJk?=
 =?utf-8?B?eWRneGp0UlRZM0d4SU5ZWjExRXR4SUpXOVhCZ1ByWnlkVFU5MDFob2J6c0hh?=
 =?utf-8?B?azB0bDg2OTNVZ1NNWm5mV0M2b2diTit5SXJTMUJiWk0yRFRlSXZ5KytxdDlj?=
 =?utf-8?B?ZUZxZDhVaGtHdEkzSFlpRXNtV0k5d0F5U2laL2dHcVhkZ0laMUtOL2ZEdEdp?=
 =?utf-8?B?MndFakpCMzFiMkg1dTBGNEhKbXEwS3E1SU1vYlNqaVRGMHAwS01uMW1IT0RL?=
 =?utf-8?B?ekJjenBCVldoTXpIZzNkSFp0RkdUOTdoV1luNEtvTkZwVVpZWk5ueHRLMHpS?=
 =?utf-8?B?NzRrTWxXOGlpYlBrUmRqdzZPM010NXk0bUFoYzdEUG5aM3BwYjltREovZ0Fv?=
 =?utf-8?B?am9VNnFDSnZSc0x0WXBiNEN3WVpJdDJac2tPYklSaXl3ZVF1T211VnB3WUhM?=
 =?utf-8?B?cnpHaWtROCsxbXlpc0Z3eUNxejZ3TmpQb1QvWjdFdkNVMGozWVZ1M3JNSVpP?=
 =?utf-8?B?bXB0akJ2TW5iSTJuTFNoUkh2VEppQXh4S2FDb1QyUm1NOHI2V1ROeDBRTXJS?=
 =?utf-8?B?SCtKWmtaY1NWLy9xdlV1dm13UjYxQkVNY1BiTlV2c2JPK08vOWxyRExHRGho?=
 =?utf-8?B?UDR0b2xrWUhyQVo5UWRYckh0VVpLRHFTdVRnVTErOEUzUnRmVkpMUmszSDMx?=
 =?utf-8?B?ZE9MUXArQU1QU0xITGsxZ1E2QlJnaFR1ZXkwNmVQY1pscXVydWM2S2JFV09o?=
 =?utf-8?B?VCtpaTlnV09BTVloQnY5aVJRWEVoOE11dEozczFQS0pmTEZhZXpRc2c5NE1C?=
 =?utf-8?B?dnZab2htWFhPZGQzSitiZHRMRFVMcjNTcDRSZ25mT2xkNHJjQm9raC9heXVj?=
 =?utf-8?B?Zjg2elVBY29HMm04UGtncmZKdGRuaU1oNndpYnNQQ0N5RCtGeHJ2NjN5SzEz?=
 =?utf-8?B?Tml6Rm40T29sVjlUNXlUeExjTHF6UkplUVQ2UjdsZHZqVzl5d08wM2ptbWZB?=
 =?utf-8?B?bER0bSt6TCt3RjZoMTl5MG9sdnZpR1hDblFQUGdoN3hPNjV5MFg1TmlNNXRP?=
 =?utf-8?B?Skw0N2c1cjlxSjRaTkNmdmZsMG1EaStFTXJRTHFBRWFoNTh5TGhNenVJNDg5?=
 =?utf-8?B?d0p2VGg4VnVwVGlGc2NwUVM2TFVkUCt6TWZNSmNjUkI2RG1QZUNFYithdXlY?=
 =?utf-8?B?Y3VOK1FHazdrMjAzYU96M2d6SlV3Y3c4eWVUQlFpclUzOGJnb0VUSCs0Sy9h?=
 =?utf-8?B?NCt6bnFaMmpZUGtmQkdMTEFJVmE5TnFoYkR2dk1EczBmMS9RUGgvNlAyc25F?=
 =?utf-8?Q?6Zkfw1yfV/LpG8+9/G+PcfKcQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cGxjZXo3M1BSNmlqeDhOY204THNWSmI1Sy9hQ2NkaVUybEIwOFVJOUh2WCtB?=
 =?utf-8?B?Um9zMmRmbW9LcGIyRHk0REpRQXY4SnVtc0s1dS9iV2Q2YjNaalpQT2Z2d1pH?=
 =?utf-8?B?eTQreTBySyt5NmZzMi8zdXRlaW5QYk13NHBMU3dyNnlyMjdPYUljbi96NmY4?=
 =?utf-8?B?SHhKdUp3cWMyUFJHMVNjV0tLbC9OOHZFczZJWnQ3TXd1TnR3b2FMZXVic2Rq?=
 =?utf-8?B?dEZ4aGFMWDl3YlJDSWRNSThrdU9XWWIrSUdldWYxeUI2N2hGNVU0ODNXRHpm?=
 =?utf-8?B?WUZMcUhpbGJiUjRaRmIzOExrRndQUzBjajV3elV4WFBNb0Zmc0FYZTMweHR5?=
 =?utf-8?B?Tlhld1FLYkg1TUs2cnB2VWhnajBoQThCV1Fkck1tQXVLUzVEV3dZVkUwd0lH?=
 =?utf-8?B?ZVlZRHlhbGpTc0FjZ0lDdDIrRDdvd25TVERKa1pZbVViNUVlbTV6UXozM05m?=
 =?utf-8?B?V0lHQkRrYVdmM2hVWUhEdGIxbVdleGJlOFphVlFpbkdWMGR3M3o2a1NLQjc3?=
 =?utf-8?B?emtiZXMzS1ZMbm41a1l0ZW5PYnNZMUZGUGpybnd2d2QvZkNjVXpCSVRKN3VH?=
 =?utf-8?B?V3JmVFhPUnR5ZWJNZUhVS25jSnh5WnJvNVRsZkM1aCtqS251MUtGUUZuYjNE?=
 =?utf-8?B?cGZGQWNGZ2dsSkVOc2FUZWlIMVA1ZWowVGd4ZXBQOExUV0llMTJYem9wU2xX?=
 =?utf-8?B?NmtBQVdpRHppS2pkNnlIcEtScHk3WG9rYUE1aEtxamNHbzBHWjdUdGhOV256?=
 =?utf-8?B?NFdyNlBBNDhHdlNTT1FhaDYrakVweWJ4U2FZcXpRVmtEaXZQeW9QY1lxMnZB?=
 =?utf-8?B?UCt4cGFrUVFEdDZrdFBtQzZUMTBJbGFZUFBZUmczeno2ZnBTcEdhNGUyakhh?=
 =?utf-8?B?YU93UDl0ZUx0ZHEwNjNPU2pISmRxOGFWVEtVeGQ4ZlVHZTh5VmMxTk5mT2hE?=
 =?utf-8?B?eFlWeHkyN05EMXdHd28wRmluNi82TENicENPUVBoSzBFVDBySDdpQnFyZ0FD?=
 =?utf-8?B?SnhoLzQzSTE0aVhpVTkwT2VLRGwyVTRGQ0YrRFRJQWROQm5zcmZIZGJ0VFV1?=
 =?utf-8?B?b3M4WjBDT3dRb3NtVnZkc3BxazFwaERoTldEcmZLU1plMmxTbmI1TGQ4REky?=
 =?utf-8?B?V2RlTi94SCtleXNlU2d4aGtoQWpXS0Vudm1rSVdBSGgwTFlETllFcjJscmls?=
 =?utf-8?B?Ti9aWitEZDZRNjE2Z2VSNWtTK1plUjc5M0d0a1kwdUpwWCtOTVpOZ2xKN0NU?=
 =?utf-8?Q?NS7BqFi5dfTi0GZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc378059-9ad3-4037-a9e9-08dbb5b5cc7f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:34:23.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jIfhXl0qthACs2/jSd2R6g2xG/apatVIJXGMIXdO5F8UVtMpvO6fTmLdKo36eEeORiRaKm7Wayh/ZDJn4SNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150057
X-Proofpoint-ORIG-GUID: ZKy0hcK-5oPC8WflXS1mfZe4dssctfO-
X-Proofpoint-GUID: ZKy0hcK-5oPC8WflXS1mfZe4dssctfO-
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Saeed Mahameed <saeedm@nvidia.com>
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

CgpPbiA5LzEzLzIwMjMgOTowOCBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gT24g
V2VkLCBTZXAgMTMsIDIwMjMgYXQgMzowM+KAr0FNIExlaSBZYW5nIDxsZWl5YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+PiBIaSBEcmFnb3MsIEV1Z2VuaW8gYW5kIFNpLVdlaQo+Pgo+PiBNeSBuYW1l
IGlzIExlaSBZYW5nLCBhIHNvZnR3YXJlIFF1YWxpdHkgRW5naW5lZXIgZnJvbSBSZWQgSGF0LiAg
QW5kCj4+IGFsd2F5cyBwYXlpbmcgYXR0ZW50aW9uIHRvIGltcHJvdmluZyB0aGUgbGl2ZSBtaWdy
YXRpb24gZG93bnRpbWUKPj4gaXNzdWVzIGJlY2F1c2UgdGhlcmUgYXJlIG90aGVycyBRRSBhc2tl
ZCBhYm91dCB0aGlzIHByb2JsZW0gd2hlbiBJCj4+IHNoYXJlIGxpdmUgbWlncmF0aW9uIHN0YXR1
cyAgcmVjZW50bHkuIFRoZXJlZm9yZSBJIHdvdWxkIGxpa2UgdG8gdGVzdAo+PiBpdCBpbiBteSBl
bnZpcm9ubWVudC4gQmVmb3JlIHRoZSB0ZXN0aW5nIEkgd2FudCB0byBrbm93IGlmIHRoZXJlIGlz
IGFuCj4+IGV4cGVjdGF0aW9uIG9mIGRvd250aW1lIHJhbmdlIGJhc2VkIG9uIHRoaXMgc2VyaWVz
IG9mIHBhdGNoZXM/IEluCj4+IGFkZGl0aW9uLCBRRSBhbHNvIGNhbiBoZWxwIGRvIGEgcmVncmVz
c2lvbiB0ZXN0IGJhc2VkIG9uIHRoaXMgc2VyaWVzCj4+IG9mIHBhdGNoZXMgaWYgdGhlcmUgaXMg
YSByZXF1aXJlbWVudC4KPj4KPiBIaSBMZWksCj4KPiBUaGFua3MgZm9yIG9mZmVyaW5nIHRoZSB0
ZXN0aW5nIGJhbmR3aWR0aCEKPgo+IEkgdGhpbmsgd2UgY2FuIG9ubHkgZG8gcmVncmVzc2lvbiB0
ZXN0cyBoZXJlLCBhcyB0aGUgdXNlcmxhbmQgcGFydCBpcwo+IHN0aWxsIG5vdCBzZW50IHRvIHFl
bXUuClJpZ2h0LiBSZWdyZXNzaW9uIGZvciBub3csIGV2ZW4gUUVNVSBoYXMgaXQsIHRvIGV4ZXJj
aXNlIHRoZSByZWxldmFudCAKZmVhdHVyZSBpdCB3b3VsZCBuZWVkIGEgc3VwcG9ydGluZyBmaXJt
d2FyZSB0aGF0IGlzIG5vdCB5ZXQgYXZhaWxhYmxlIApmb3Igbm93LiBKdXN0IHN0YXkgdHVuZWQu
Cgp0aGFua3MgZm9yIHlvdXIgcGF0aWVuY2UsCi1TaXdlaQo+Cj4+IFJlZ2FyZHMgYW5kIHRoYW5r
cwo+PiBMZWkKPj4KPj4KPj4gT24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowNOKAr1BNIERyYWdv
cyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToKPj4+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGFkZHMgc3VwcG9ydCBmb3IgdnEgZGVzY3JpcHRvciB0YWJsZSBtYXBwaW5ncyB3aGljaAo+
Pj4gYXJlIHVzZWQgdG8gaW1wcm92ZSB2ZHBhIGxpdmUgbWlncmF0aW9uIGRvd250aW1lLiBUaGUg
aW1wcm92ZW1lbnQgY29tZXMKPj4+IGZyb20gdXNpbmcgc21hbGxlciBtYXBwaW5ncyB3aGljaCB0
YWtlIGxlc3MgdGltZSB0byBjcmVhdGUgYW5kIGRlc3Ryb3kKPj4+IGluIGh3Lgo+Pj4KPj4+IFRo
ZSBmaXJzdCBwYXJ0IGFkZHMgdGhlIHZkcGEgY29yZSBjaGFuZ2VzIGZyb20gU2ktV2VpIFswXS4K
Pj4+Cj4+PiBUaGUgc2Vjb25kIHBhcnQgYWRkcyBzdXBwb3J0IGluIG1seDVfdmRwYToKPj4+IC0g
UmVmYWN0b3IgdGhlIG1yIGNvZGUgdG8gYmUgYWJsZSB0byBjbGVhbmx5IGFkZCBkZXNjcmlwdG9y
IG1hcHBpbmdzLgo+Pj4gLSBBZGQgaGFyZHdhcmUgZGVzY3JpcHRvciBtciBzdXBwb3J0Lgo+Pj4g
LSBQcm9wZXJseSB1cGRhdGUgaW90bGIgZm9yIGN2cSBkdXJpbmcgQVNJRCBzd2l0Y2guCj4+Pgo+
Pj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzE2OTQyNDg5NTkt
MTMzNjktMS1naXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20KPj4+Cj4+PiBEcmFn
b3MgVGF0dWxlYSAoMTMpOgo+Pj4gICAgdmRwYS9tbHg1OiBDcmVhdGUgaGVscGVyIGZ1bmN0aW9u
IGZvciBkbWEgbWFwcGluZ3MKPj4+ICAgIHZkcGEvbWx4NTogRGVjb3VwbGUgY3ZxIGlvdGxiIGhh
bmRsaW5nIGZyb20gaHcgbWFwcGluZyBjb2RlCj4+PiAgICB2ZHBhL21seDU6IFRha2UgY3ZxIGlv
dGxiIGxvY2sgZHVyaW5nIHJlZnJlc2gKPj4+ICAgIHZkcGEvbWx4NTogQ29sbGFwc2UgImR2cSIg
bXIgYWRkL2RlbGV0ZSBmdW5jdGlvbnMKPj4+ICAgIHZkcGEvbWx4NTogUmVuYW1lIG1yIGRlc3Ry
b3kgZnVuY3Rpb25zCj4+PiAgICB2ZHBhL21seDU6IEFsbG93IGNyZWF0aW9uL2RlbGV0aW9uIG9m
IGFueSBnaXZlbiBtciBzdHJ1Y3QKPj4+ICAgIHZkcGEvbWx4NTogTW92ZSBtciBtdXRleCBvdXQg
b2YgbXIgc3RydWN0Cj4+PiAgICB2ZHBhL21seDU6IEltcHJvdmUgbXIgdXBkYXRlIGZsb3cKPj4+
ICAgIHZkcGEvbWx4NTogSW50cm9kdWNlIG1yIGZvciB2cSBkZXNjcmlwdG9yCj4+PiAgICB2ZHBh
L21seDU6IEVuYWJsZSBodyBzdXBwb3J0IGZvciB2cSBkZXNjcmlwdG9yIG1hcHBpbmcKPj4+ICAg
IHZkcGEvbWx4NTogTWFrZSBpb3RsYiBoZWxwZXIgZnVuY3Rpb25zIG1vcmUgZ2VuZXJpYwo+Pj4g
ICAgdmRwYS9tbHg1OiBVcGRhdGUgY3ZxIGlvdGxiIG1hcHBpbmcgb24gQVNJRCBjaGFuZ2UKPj4+
ICAgIENvdmVyIGxldHRlcjogdmRwYS9tbHg1OiBBZGQgc3VwcG9ydCBmb3IgdnEgZGVzY3JpcHRv
ciBtYXBwaW5ncwo+Pj4KPj4+IFNpLVdlaSBMaXUgKDMpOgo+Pj4gICAgdmRwYTogaW50cm9kdWNl
IGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIGZvciB2aXJ0cXVldWUKPj4+ICAgIHZob3N0LXZk
cGE6IGludHJvZHVjZSBkZXNjcmlwdG9yIGdyb3VwIGJhY2tlbmQgZmVhdHVyZQo+Pj4gICAgdmhv
c3QtdmRwYTogdUFQSSB0byBnZXQgZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAgaWQKPj4+Cj4+
PiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAgMzEgKysrLS0KPj4+ICAg
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDE5MSArKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLQo+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHwg
ICA2ICstCj4+PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAxMDAgKysr
KysrKysrKy0tLS0tCj4+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgICAgfCAg
MjcgKysrKwo+Pj4gICBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaCAgICAgIHwgICA4ICst
Cj4+PiAgIGluY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmY192ZHBhLmggfCAgIDcgKy0KPj4+ICAg
aW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgICB8ICAxMSArKwo+Pj4gICBpbmNsdWRl
L3VhcGkvbGludXgvdmhvc3QuaCAgICAgICAgIHwgICA4ICsrCj4+PiAgIGluY2x1ZGUvdWFwaS9s
aW51eC92aG9zdF90eXBlcy5oICAgfCAgIDUgKwo+Pj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAyNjQg
aW5zZXJ0aW9ucygrKSwgMTMwIGRlbGV0aW9ucygtKQo+Pj4KPj4+IC0tCj4+PiAyLjQxLjAKPj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
