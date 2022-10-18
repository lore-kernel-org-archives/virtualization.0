Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD234C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 00:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57008405D0;
	Tue, 18 Oct 2022 00:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57008405D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=OiF0HdNM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=AxCUdBk3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipbMiD4E4rfp; Tue, 18 Oct 2022 00:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C712A40576;
	Tue, 18 Oct 2022 00:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C712A40576
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE8D3C0032;
	Tue, 18 Oct 2022 00:12:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E823CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4DE282F20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4DE282F20
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=OiF0HdNM; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=AxCUdBk3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcB5DwlueTjO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:12:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37EA182F19
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37EA182F19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 00:12:51 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYDW3029518;
 Tue, 18 Oct 2022 00:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NQxY88RaYjPXzijz6p1GDQEKfaUqqWCwyzu5+P9KsEU=;
 b=OiF0HdNMK6LgfIfNOPpZLa9p0iqEWh8IKqjjEwO4sUurvPr77K2lQGH5CCqXAqoOxW1W
 aAMlP0A8R7+zHEKNJ4qMVmJLCqcYmfkjoslBldEYV2poPrWGezTV20quXsXqTWU3o88V
 tn12Z+4K7IW3mvmnctljFuH4EnH3tO1IsHWcmiELPhIJpGMtIXrqsvXstWs5qYCVPC2e
 WohSCTm52JkusYCcOFFyhFjoTu3y8nCDgbcMbVmbo/ZNyt4M1QkE1ChaXstvKbpdTTIJ
 Ler4KyCWpd/8OrfezYnn9GN/3iEvhbi00OT8RfVkNw5GQ7nDMuEybGaVbJTTCmPq9wk+ ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyw9as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 00:12:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29HKEAm8017430; Tue, 18 Oct 2022 00:12:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hu6khex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 00:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePhe6zGIYlbrnrLvZXIj2CcWZKz7lVfzjmiQAzLB1bvwFapPE1HRge03X+iGRN2XgB4rYG1Yz1mjHFj2D4Lh08mY1V7u3+oGViabJcs4jmya2u+qpzDXRKmyRwCz/zXJi8tPOZU1+5lsIGLqT7F8t35h2TIV27OynmFi/iYo1+PARZ0e0nGwGLa37R47DipfRLij7aUDWtf5xBjhCAvmiW3w8dkQjtsjISLv92ACMjF5pKRRp4KCOz4q1uB654C7F2LdC/0Y/tFkS0cVYZdstL0Ap2bSsi84++B3b5wnGO4w3lmsjnHr8xfiiKhIG8maDrQadPGofM9YNdaGah6k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQxY88RaYjPXzijz6p1GDQEKfaUqqWCwyzu5+P9KsEU=;
 b=gariM9A3eRIrNhtXP1hjrulE3Ui+pLbonYzFiyfW19ZmD0sJHQRKTZTrm8zFGgfwnf6keL2qM5FpoMnxdxqfI2sA49v3F5joM5wVjBKqWNnT/A8DGrfNaTDrCMItyHW/iSmpG0HtlGavHn0BjqJ5hnsu1whruJl3+Q1wQnSBGtXg3AHOAG9b/LCxvi6INExaeQmDWLbxD8HtHPyekV0YDvlI2lOew793evzkF7TYybiuKPEPISWPQCVQ/zkyV/ZptUWTqKHuL6prJTm+7/3zNMsjnyzvFaYaU1pU3rG7pd74bnsl06jC6GBCWSXNXL+hm2dkPLiOafkQsOA5QiRL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQxY88RaYjPXzijz6p1GDQEKfaUqqWCwyzu5+P9KsEU=;
 b=AxCUdBk3giJPNreMBDxhQxkweZDQzK92ssddqISjA56JUu6NLIY+txNNccK5aFmp3WM7c2x8vNcuC8MPOZuYvlNkDedxr79HstEXN1SSWgMCj/FlWF4jA/ld65dzvt9aIAVJatT+iCpep0kmObS8unpzfnZdDICbcJN78xKCxz4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 00:12:46 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 00:12:46 +0000
Message-ID: <d017b048-6f40-bd02-5639-03f0526fef5c@oracle.com>
Date: Mon, 17 Oct 2022 17:12:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/4] vdpa: Add resume operation
Content-Language: en-US
To: sebastien.boeuf@intel.com, Jason Wang <jasowang@redhat.com>
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <491fb8fe786739958eb9ff3df2250a4188b0bbe5.1665745877.git.sebastien.boeuf@intel.com>
 <CACGkMEviBPXzg1Wyx6coi8o9EPNtERZ43AN_L8Lk5mfuhryycg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEviBPXzg1Wyx6coi8o9EPNtERZ43AN_L8Lk5mfuhryycg@mail.gmail.com>
X-ClientProxiedBy: DS7PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:8:2a::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5e1f63-ed00-4c32-7418-08dab09d7c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JCDF1RtnHCnc/V0VHtuGpPPP/CsBsNmQSUIyE/D0Qflk/5e8lXFcgMpW4SQakidKiDVlMKb0xyGvL91j90aBm/kppEWh7FHSjz2UAXdxhaLKRUlNBONwV+HTR1N0daJK5B1PgtdtsKesaiwo77VhPtR51krKSyoA1lIriqYfUbVY4R4m0BFOqHK5W3kN+Xgst856SVYJXNozBQHumkuskxUx1V2w9Zpy+VwHZugb66ruA+UDUHYvb37RTdHfkRpy7Dx8NS4VGCsmMxTs4CV0QdQH/v/MuWpNcEdUU+Et1wBaf7+LK5X7JYKHPyjhoYGBhq8CoTOEfjGoQhGN9xArD3sCXywMqxZs84wlUpmdyFbx2Kzty/SPMqrmaJrBOHm3rDrhKEY8yQtSF9IrktGYMfOo99cDyJi5/h9348zy6kStWIhqdIHjcrkLQ49dv0tR0azC9AV+19Cs5/SDBYLsV315TIz/b9NvhW2wuRs5nyzeRu6sScdr5Q0mbSC6aI5G0U8vJM5lLhuY4D+sNdkTx7mXia+N5mRqhe/7+xXXeDw8S66/3EkCvn3EJBmmMZgk4Yjj4q3vW6MZmNoCRt1jeKZgPu+of+Ll2Sk/YbgtFRVchnXW55ryQd07cDDfE48lRPVjgAp6JrVhcAOMGQqlEN366ma7CJ6Xb23rDAWtGzFFz0e7OQ5HrEwGHxaZu2mD8R12P+FsDmj/SY8UpZFbl3aFiRWlcxwjA1UbHguG/L9CP/hbuYbEOR9te79yYGfls6WuvRnGyXZ7TRP4W/fSyQW/X6CbqeIFlueTcjayDubJWXJ+JzCkoPnUt6+pnn6VmNdv0sDR4B/7uBcsS8FGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(83380400001)(31696002)(86362001)(38100700002)(8936002)(5660300002)(4326008)(36916002)(66556008)(66946007)(41300700001)(8676002)(2906002)(66476007)(6506007)(53546011)(186003)(2616005)(26005)(6666004)(6916009)(6486002)(6512007)(316002)(966005)(478600001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJ4SUo0b2U0OEMzYzhCWmJWUVRrYWRmblFTbllZVHRtbGlzTFpxNXhsQk01?=
 =?utf-8?B?Y1NvcUp1YzkwM1N6UzV4eko5NFJZcTV5UkU2NEgyYjU5RVVjN1F3V2M0WXA1?=
 =?utf-8?B?b3hSdjUwZDgrNjZRTUwvcVFIWVpkd0VxWmJRYXRmTlFTOU1adndGNjBKOUJC?=
 =?utf-8?B?Wng1Y3Jza0FmRWg4Z0prbmRtQ2JwWEdFU0tUcFhhMGxPbHMzVVhVei94NFc2?=
 =?utf-8?B?MFZ1WGMvM3h3QTdzRUpVRWoxelR5dnFocGdLOFBXYkVlVE5SWm9YbDY1bS93?=
 =?utf-8?B?bWJURGlhclJrSmRZMU5IQ3doSElGaUU2VEdyRW9jZ1FpNjRVZE1RbWU1Z05h?=
 =?utf-8?B?SW12WWJkVzBZeUF5aVVMeU10MkRjYUxiNnhlb1hMV1NsdjUvTndTTlpQZ2Qz?=
 =?utf-8?B?S1E2aVoxMnNIWWJaU2M4dkpRTmoxcURhWHlyY0dnMWJ1M3FCYm5KeGlNTUtF?=
 =?utf-8?B?SGk3cUp1QXdiUDlxZGd2Q0ZDbTZKbEozYThjbGNSM3pIcFEzTEkybjh5VVM0?=
 =?utf-8?B?YnA5Q1I2ekZGR1AvYlZFbWZZMzB1NTdjWDY3dFljd2x3eFhFcFpncFJaNGFY?=
 =?utf-8?B?RFdxZmhVR3A3eGZrZExyQ1UweHJDc2VCbFltbXZ1VzNJLzZva05JYXhzMFJi?=
 =?utf-8?B?dmQrc0xnS0xCYmQrZE93N3JWMEZhbWtsUDVjcE5aMkxDMXVvUE5FeWFnTzJW?=
 =?utf-8?B?eWxDb3FLbUE2TFRxc1I1aWpYQjV3T2VLbE8xZHZPenQvNWhkelBzdC9lMTRP?=
 =?utf-8?B?N1ptR0NLMlhGSEh0MzlKWVdqNHdiQnNFeDhHUzJnNW1lT2lza3ZpeXh2YTBY?=
 =?utf-8?B?TVBaMitPaTVUNnVtakp2V2tpUi9uZ1dEMWp1d1VpbWpreEVYbi9EaUF4ODB5?=
 =?utf-8?B?TUs3MzIvQU5EeU1YeExCQUE1VHdpdG1SNW1NaURseEhleTI3by94SVJITFZO?=
 =?utf-8?B?NVM3M0tDWnBXOTFzSU82akF0ejlHelNwU1FDbU5qckJoQndrSkZIRDg1Z3ox?=
 =?utf-8?B?T0ZNZFZKaHJHME9XTjl2SzNBbkkzRDJWcHlWN09yVDF0dFl3MXV4ekRUcDY1?=
 =?utf-8?B?UVZuY040bHdCZVp3UzVvSlJRQjZwQnljMHlmT3QzMmFPckVPR09lTHFTa0Jz?=
 =?utf-8?B?VHkzOFFSOFpyNHBraC92Z1YxSlplM1JpUEkwU2hYV3BLVkFNNUNRVkw2WkRt?=
 =?utf-8?B?bmtBS2ZEemYxMGpCV3lzZXpTOWNCSzAxbFJQUDRhZTRqUmNXWmszbUk0b3ZK?=
 =?utf-8?B?czd1VjJHaG1pcGJIK0wySjZya2l6cmRSeitaZld4VTVrWW1BTW9zVml4L1cw?=
 =?utf-8?B?ejlxdFhva3puc0tBUzFFNVNSN1FHKzNiWUJtUGdUS3l3ZTBLeGt1K2VzMDVp?=
 =?utf-8?B?UWF3bWZXdGpHOHhQbjdBc3NXRWFta3BxOURDS1pubVhHRjd3V0tnRE5GTGtz?=
 =?utf-8?B?L0NwU1IraGdma1g2WUQwRVJyT3kzZTdWcjZqT2NkYUlCbGFFamFiTGJjbGJq?=
 =?utf-8?B?eFQrdzVLVlQ5Ylh1S1JGaHhCejhBcVZxUGVZbTBjQUVEdkIwTFJ6alF5T3dw?=
 =?utf-8?B?VVlUR0R0YndDVFJHdFVZd2oyUU9qQlFOVjkwVWpCN291U0RJMXNjNE5XY2g1?=
 =?utf-8?B?QUgxdzZJK1pCcXpEWGFxMEp6YUkrWUtXWXlqcG52UlRwZU5OQkdEYlliZ0ky?=
 =?utf-8?B?Vnp0TUU2OE9XMFlsUmFBWW1qQ01kUFd4eER6ZHMybXJSbVQ0b2hETWhpQ2wx?=
 =?utf-8?B?M0VYTER4K3h2TmNBcDgwcWZMSmw3SEZOTFdzWHZaYUNSY1ZEVWlJMmY3NDdI?=
 =?utf-8?B?L1BUREdIRncvZDh2blRzZDh4czVqZG0rRlVaalgxNnBHNVdyRzJ0UWtaeG1Z?=
 =?utf-8?B?UVZvL1ROLzlBNnFlT1hMaFBBeDc0cG1VMFkzYUNLTUQ3bXE2eEY4R0p4a3Zt?=
 =?utf-8?B?aTE4TDlJRHRrdCtuWm0vY1lENzVoQVlReWF5V0FLMEREQVhZTGhwditYSVBK?=
 =?utf-8?B?bVlyQ2llZzV3WEhoMkNZQjVBZFc2eXdwRjBtOE92VGpDQnJYemQwWUY3NURt?=
 =?utf-8?B?UVNOOUJwWFNYQkl4Rmpjd0JMUk5vOS9lc1Ayc1QyVG1QMjhnM1ZQVk11cGxC?=
 =?utf-8?Q?6zFxdllVqAlZJuB/7ygYqE6FW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5e1f63-ed00-4c32-7418-08dab09d7c08
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 00:12:46.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YycUpqmMsZDrl6XAttOEtmCmBWdTPhuLKEbVrzJWecPDdFhp3sHmTtt4OZ5QX/cFv5/2B2D0XbOhZwdSlNA1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170137
X-Proofpoint-ORIG-GUID: ae0fy_7HqFjrW-9L1MOF648yBqJArApr
X-Proofpoint-GUID: ae0fy_7HqFjrW-9L1MOF648yBqJArApr
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

Hi,

I don't know why but it looks that this series wasn't showing up in the 
list for some reason. Only the recipients in the To or Cc lines seemed 
able to get it. Would it be possible to fix the mail client or include 
me to the thread for review?

Thanks,
-Siwei


On 10/17/2022 12:19 AM, Jason Wang wrote:
> On Fri, Oct 14, 2022 at 7:14 PM <sebastien.boeuf@intel.com> wrote:
>> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>>
>> Add a new operation to allow a vDPA device to be resumed after it has
>> been suspended. Trying to resume a device that wasn't suspended will
>> result in a no-op.
>>
>> This operation is optional. If it's not implemented, the associated
>> backend feature bit will not be exposed. And if the feature bit is not
>> exposed, invoking this operation will return an error.
>>
>> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
>> ---
>>   include/linux/vdpa.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 6d0f5e4e82c2..96d308cbf97b 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -219,7 +219,10 @@ struct vdpa_map_file {
>>    * @reset:                     Reset device
>>    *                             @vdev: vdpa device
>>    *                             Returns integer: success (0) or error (< 0)
>> - * @suspend:                   Suspend or resume the device (optional)
>> + * @suspend:                   Suspend the device (optional)
>> + *                             @vdev: vdpa device
>> + *                             Returns integer: success (0) or error (< 0)
>> + * @resume:                    Resume the device (optional)
>>    *                             @vdev: vdpa device
>>    *                             Returns integer: success (0) or error (< 0)
>>    * @get_config_size:           Get the size of the configuration space includes
>> @@ -324,6 +327,7 @@ struct vdpa_config_ops {
>>          void (*set_status)(struct vdpa_device *vdev, u8 status);
>>          int (*reset)(struct vdpa_device *vdev);
>>          int (*suspend)(struct vdpa_device *vdev);
>> +       int (*resume)(struct vdpa_device *vdev);
>>          size_t (*get_config_size)(struct vdpa_device *vdev);
>>          void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>>                             void *buf, unsigned int len);
>> --
>> 2.34.1
>>
>> ---------------------------------------------------------------------
>> Intel Corporation SAS (French simplified joint stock company)
>> Registered headquarters: "Les Montalets"- 2, rue de Paris,
>> 92196 Meudon Cedex, France
>> Registration Number:  302 456 199 R.C.S. NANTERRE
>> Capital: 5 208 026.16 Euros
>>
>> This e-mail and any attachments may contain confidential material for
>> the sole use of the intended recipient(s). Any review or distribution
>> by others is strictly prohibited. If you are not the intended
>> recipient, please contact the sender and delete all copies.
>>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
