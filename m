Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6447ECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 23:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092EF81066;
	Tue, 30 Aug 2022 23:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 092EF81066
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Q/7euxar;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=x7wUUHB+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZ7Q84Jr__s1; Tue, 30 Aug 2022 23:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61BB881000;
	Tue, 30 Aug 2022 23:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61BB881000
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45F2DC0032;
	Tue, 30 Aug 2022 23:22:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE4C0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 23:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B4B161040
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 23:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B4B161040
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Q/7euxar; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=x7wUUHB+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NL5-immrMd5j
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 23:22:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5EC16103E
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5EC16103E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 23:22:52 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ULVKpM012650;
 Tue, 30 Aug 2022 23:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=leCG75/syFcII0XnM2dcOLFOAWeKLoi5sfEgAbaP6TE=;
 b=Q/7euxarJFmnhLhtB2mmaQcj1YlmmXeis1DTGhXIyL6Vz0OxwCXvs3EtsW6JJGVP0dua
 pfAEo6hS2pyBh6Js2/6ff4Wdti6uwXWdqgsWI+/WAQE0Zw16ZAXPcbaWijbo40veDvVC
 o694dcdZGq4r+ityQf4d7noOMY3s3n7amlhuLndLEEtbe2OkAOavv2THcMhyk69sQLZy
 SLGz58OLIYX8/DpbL+iS2VK+T/jBzcl0YeBL+lH8vwq5zXP5l/pbYHM6m8O2NKJlx5UR
 BaImx59EiA4B5R4jm6BF+R+p8kIgWD2V1/hZDboQTyAMpk6iIJv4Km2+Yf4wKVG/tP8f 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbym32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Aug 2022 23:22:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27ULmQXn013712; Tue, 30 Aug 2022 23:22:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j79q4gys2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Aug 2022 23:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY8En5ayOKrQXiyiaysl6Um0RYUBzAo2UI5vuNi1OMb9MeRIK/hLPbMLSfYkaeobvzh4JPqj6M0PbVJWrL4V9JJ0miFb/w4qERJSIyU6/1tUp3oE8j3VHcOMVq0Nwh1Yb9Jcq5y9XKtHCK62N/r8LuvKGQVqWBkazLbh55WExHl9ulmQyZpQMzBgNwbjCpnA7JgRRYqGRNQbzt6QhbRyj9xNZmWaQXZvDiUdx1DV+rrea5GMjJlVWU8+kTFq8WUaWqfOVSYKVECjvfzMdcl99/xIC9VU6yv5PXOr/LcW3PIchPBQ3p98KAtwe24HN/AvZskQL1XzNuw154+sMm6ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leCG75/syFcII0XnM2dcOLFOAWeKLoi5sfEgAbaP6TE=;
 b=bcBxfUBjUvBvgPeFtiPj4C3CcCGgkzvGP/jzuCpyZAAe3uoxv5669DA5cnWr8ha6g+Nf9FJhGU8RkHQgu8p3L1aBQeO4kkrbh0S0lrULB75NGDsOIvFI6JTbvDRb6hNYIvIWUzHcp0+ZUt5j9Ot1/oZOiTj6xVXI7W4G9NaBoJD2ne16gGDbZBxrshyCVM/cSZzuHuHBqSefmuybzTwEB46jtIooe14F/v3c8o+c2d551P1F+fTaF7HVV7BDcTDxBv+W2kVbT2tlrRsLg21DUq1fggEVGd0dfEFXiI8O2U2IPOu0plVoponci8tKD4Cu3/YQ3qP9EWkVvQwPt7Z43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leCG75/syFcII0XnM2dcOLFOAWeKLoi5sfEgAbaP6TE=;
 b=x7wUUHB+hx4jYLPuXhV4BJW5Gp3bkAoSzxJnr/Js8of/RAexoB0yz9Lm5YIxsCZ+J6LQ4/6AZFaG61ZbCA3TBNnOaHtqlgBNp7VibSVSGojCPaVIvrX65dXo2rs7iGK3APknDCFCv0JfYTkCLRpy7Ap9vy8aS1pa6DpPyyjDb24=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS0PR10MB6175.namprd10.prod.outlook.com (2603:10b6:8:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 23:22:48 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 23:22:48 +0000
Message-ID: <ef63889c-4f61-75ae-4faa-fa1619995256@oracle.com>
Date: Tue, 30 Aug 2022 16:22:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: RFC: control virtqueue size by the vdpa tool
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220830154938-mutt-send-email-mst@kernel.org>
 <7460d7c7-5b44-661f-7763-3e7a6a15f138@oracle.com>
 <20220830180119-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220830180119-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BYAPR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:40::17) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf3a5f3-ada6-4084-81bc-08da8ade8d24
X-MS-TrafficTypeDiagnostic: DS0PR10MB6175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDYYQ0hwu10QF3vvcDFMHHmHLqjGWNpd3GUOugYtULopPODiZ7Vsmg51TegSHkc9hKWCLh20dpyoXbMhexriGcM1aJOWfk2A/FdpdOtB1sFYyEC9wGwynttMG6V3epKC2ZXX2o2CPSjKEL9QdF8zRz1RW4jN1HywKAr3jzfOta9nyKPBUU++Nuw4f83w7Aux//QDJTKMephadBBR5zbnuAQ+pzk9XmSSj52Gl7BPmsk1LsEzJ5A3D/+qJm9jdgETvKf2RKQjXoGR+DPk78EtTUlB2uQuZdrhKkWXyKvAOo6K1J4FmFiN4kRRVHDCoPZYa0eP37bkwO8O43vMJykSWaPnIbWIYKoD4/19CTV+6Uo0PHjKZrRaZEHVqfcSVhEWBYtzII39HVzit0rpsucVXCZT5JqIoj3aVnBm1oMQphjO6roYHiGXZd3xhC0CjQv0LxyZqjEd9hwFIx25tUmUndYyT1z6AvUIlV2YvOFla4c6bG7ABXJziwLHlRfwe88U/0aHK4IOiEwCslzl7uA/Jst8d8ZKHYs7oR6+zFGxLxB+bhIEZju7YbreNUQJfGxl66Wsgo/QsxztHVINfVTFvkTx8eqREfGCiaODOFXYOk90ZCToo/853b03znqcX7ajdYMZbv38DfSPwN7jYV3GIF7x4cFdG+HXZwFF8ExfkXjhbfX67x9S7fnyLPRKQecJhATOxE0q86ZVAnfUs+/E8k8XPuBlWBxyHW0GEO7j1N8Mr8YF9X7YPetGn7YpG+nc7U/frboTzRl4ZQQdP/ud5VtCTNqt7g0dXCgDOM+8QTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(39860400002)(396003)(376002)(136003)(366004)(38100700002)(6512007)(26005)(186003)(2906002)(31686004)(2616005)(6916009)(316002)(36756003)(54906003)(83380400001)(5660300002)(6506007)(6486002)(8936002)(53546011)(478600001)(66556008)(4326008)(8676002)(66476007)(66946007)(41300700001)(31696002)(36916002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG15VFR2d3E2YTViL3VrV01YMUFlbU5VOWV3bVRtRnJyK0FVTDJraGUrVFgx?=
 =?utf-8?B?N2Z2WUZ0aXNqOUg5UlRUOURzYVFUM0pPdDlKN0s5WTY2Y3J4NlNjTW9FcUZO?=
 =?utf-8?B?cWd1OUxOdHpTVmJWNGRwZi8xK1l3WTg4MFZJbkNaSkpOSG1oVko3QWtQK01m?=
 =?utf-8?B?TkR4VlpOanE2Q3MrSG04NU9RR0ZMY0xzaXRVS3hycnphSldBWldPNE03bDIr?=
 =?utf-8?B?NUtmVFUrTEZNcmU4eDBMU3E4YkRNekxjMEFWdnkwcTlLQWJQdU92cEp2OGpo?=
 =?utf-8?B?ZDJvVWtMenp2bi9tTDZuQVNHdURsWmdLWGZsbjgvblZEaE5EWGt4WC9wdE1H?=
 =?utf-8?B?d2JoUE5NSXFWQ1ZNYVo3NzVLRW05UWY2NmdwbHR4clRNMTJFSU5FTjVKazRh?=
 =?utf-8?B?bTF3TFArRUNIZnVPY1F6N0hDak1NRGgzWHgxb3NKcHdVdjMvRHJMN2NrWTcx?=
 =?utf-8?B?WW1BOFZMdGVKenJFaDN1RUlJa0VmcEtTMVA2dlppelJOM1F1WVdCelZ3dnpv?=
 =?utf-8?B?VXVxay9KckRJSUd3UjVveGJGcnE1ZXhHMUN0R1FnZ1lJL0ljNUdNRjF3UDdx?=
 =?utf-8?B?TSs2Z0NyZWIvblNlSzh5U2JOVHVTSXQwbXgvRGlITy9Jd3puL2tyalBBUWI5?=
 =?utf-8?B?dkRQUWp0dWxkSjRTR1NyOTlJbklsTTVGRmNKZVdJOEVVTG93Ym9LSzlYYTdZ?=
 =?utf-8?B?ZURRa3F0Q0ZhYlBoejE2SXEzUlpkdmlPS0srZ2ZXNmJHZm9UbjFxWDAvK1Y3?=
 =?utf-8?B?UWxnK0tleThHRnpLeVFsR2lLZlkvSVh1NnlsWWNpVzkrTndjd0d2dmRVNXJn?=
 =?utf-8?B?UE1wcDBQNUhMOVp3NVYwc2grSDlGTGVDbnVSMHR5QjA3ZjRGY2w5VFdZK09S?=
 =?utf-8?B?TnE4VTlLelRYR3RNUm42NlVrWUx1QlRYbUNNcG1ScDBua2w5OXBqYnFWaWhp?=
 =?utf-8?B?MXFyaEZoTGErMXZtanJROTNaNmQvbVZHUUdLQVBQd05oQkJmWlpMU0k1N2V3?=
 =?utf-8?B?dVJHeGZOaGxrWDlyUGlwWDFKUTdzS0FnQVFPdzdNQml6emRHVEhIM0JzbE5O?=
 =?utf-8?B?UnpCSWlmd3VuT1dFMDVFai8vbzFUNUkvVmVYdzRSTmV0UFdFSERJME9kdVBt?=
 =?utf-8?B?WWdGekZhaGE5VkNjYVJEQldHek1ra3hxNGVSZUlrbzJrZ3k2TTdqTGJpb2dR?=
 =?utf-8?B?cWVmK2xkYXZPTGNWRXBSb21LVFhOdFJLMG93UnRVMzRyVnhJUjE3MXgybm1D?=
 =?utf-8?B?WDF1THJBZUI4OENVd0piV2c2ZkQwSkhoL0RrSnVYK3hDbEtPVHBWZUxoQTV1?=
 =?utf-8?B?Z21CcHVwSzlWbkdXNkp0ZGd3ZjlJZGcxNTE0NDd5QXU1RHZjRmh0T1VTS0tP?=
 =?utf-8?B?T3Y3Z01WSllnWXI4ZzIyRHhSc2x2TSt0WC9vc0VoaXhmNHVTUUlLVFlqOUtq?=
 =?utf-8?B?UklXemFBcUZtaFhBUERaT0hJZ281ajdsUkxpSTZYMXhKanVleXN3RGJvVy94?=
 =?utf-8?B?NEltWFFKT0svajBPUk1tS0sxWTJaUkJqdzlsaTR1QWUrZld1NTRqTTBrdVFD?=
 =?utf-8?B?djY1Yzh4bVBDMUpMY0Y2OTFJM1NlSTZ3Rno0MENVQ291ZlBwcXFENjRrakc0?=
 =?utf-8?B?Skp4aU5pZnNMWDV4c0Nta24zQ0tlYmZnWkR6b1hkTjhieVJNQnEzcFFrNXdC?=
 =?utf-8?B?ZnVlQWhwRWZOS1h5R1pNamhtVXNzdnYwUFNaQjk5UEJ4M3BjTFVtNUMzVW5H?=
 =?utf-8?B?YXlRTzY4bnp6MzlxdlZDMTRvenVXWjNmdmpTS3I3cjdYNEVmalpMV0pFS3dG?=
 =?utf-8?B?SGRRajlzY0lEdGIwZjNCNS9ObDF0MTN0QjFlSm5uUUlVOEpBNDg0S0R2N3Iz?=
 =?utf-8?B?cy81aEIyaFNTVXJkTkVrdWF6aGZSMEdQbFlWeUN5d2ZsWlhEU0VzTlBPOEsx?=
 =?utf-8?B?eXNUY1FyT0lBT2QxUUFrWkVOQjl2dlRjd0tXR09Nd1dRM2kxYXhSV1FaZ0d5?=
 =?utf-8?B?STZBMFZFbFRCY042TFo3S3JnVHByZFVYMkI4ZXhSMjJ0QnhsTTYyTm56Z0Jn?=
 =?utf-8?B?d1lTM2VWdG1jU0NVTWp2cHNqYnZNRUpGajBpN1paQ2wxM1dpbFpNaXFIUkVw?=
 =?utf-8?Q?4VFPXqdV3UtmmeI/aRtoEgD95?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf3a5f3-ada6-4084-81bc-08da8ade8d24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 23:22:48.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqSu10bG+lXQpEgbiXgodxjQju3278Dfw8ZbF69m27A45ydiNWUR/Giu73CSpVOJ3DzUbF9M4Erv1CX2d7Zw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300105
X-Proofpoint-ORIG-GUID: tt-gYKd_IXEvr24onIUxQHtyPCMKWjzD
X-Proofpoint-GUID: tt-gYKd_IXEvr24onIUxQHtyPCMKWjzD
Cc: "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA4LzMwLzIwMjIgMzowMSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFR1
ZSwgQXVnIDMwLCAyMDIyIGF0IDAyOjA0OjU1UE0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+
Cj4+IE9uIDgvMzAvMjAyMiAxMjo1OCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4g
T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDY6MjI6MzFBTSArMDAwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+Pj4+IEhpLAo+Pj4+Cj4+Pj4KPj4+PiBJIGhhdmUgYmVlbiBleHBlcmltZW50aW5nIHdpdGgg
ZGlmZmVyZW50IHF1ZXVlIHNpemVzIHdpdGggbWx4NV92ZHBhIGFuZCBub3RpY2VkCj4+Pj4gdGhh
dCBxdWV1ZSBzaXplIGNhbiBhZmZlY3QgcGVyZm9ybWFuY2UuCj4+Pj4KPj4+PiBJIHdvdWxkIGxp
a2UgdG8gcHJvcG9zZSBhbiBleHRlbnNpb24gdG8gdmRwYSB0b29sIHRvIGFsbG93IHRvIHNwZWNp
ZnkgdGhlIHF1ZXVlCj4+Pj4gc2l6ZS4gVmFsaWQgdmFsdWVzIHdpbGwgY29uZm9ybSB0byB0aGUg
bWF4IG9mIDMyNzY4IHNwZWNpZmllZCBieSB0aGUgc3BlYy4KPj4+Pgo+Pj4+Cj4+Pj4g4oCcdmRw
YSBtZ210ZGV2IHNob3figJ0gd2lsbCBoYXZlIGFub3RoZXIgbGluZSBzcGVjaWZ5aW5nIHRoZSB2
YWxpZCByYW5nZSBmb3IgYQo+Pj4+IG1hbmFnZW1lbnQgZGV2aWNlIHdoaWNoIGNvdWxkIGJlIG5h
cnJvd2VyIHRoYW4gdGhlIHNwZWMgYWxsb3dzLiBUaGlzIHJhbmdlIHdpbGwKPj4+PiBiZSB2YWxp
ZCBmb3IgZGF0YSBxdWV1ZXMgb25seSAobm90IGZvciBjb250cm9sIFZRKS4KPj4+Pgo+Pj4+IEFu
b3RoZXIgbGluZSB3aWxsIGRpc3BsYXkgdGhlIGRlZmF1bHQgcXVldWUgc2l6ZQo+Pj4+Cj4+Pj4K
Pj4+PiBFeGFtcGxlOgo+Pj4+Cj4+Pj4gJCB2ZHBhIG1nbXRkZXYgc2hvdwo+Pj4+Cj4+Pj4gYXV4
aWxpYXJ5L21seDVfY29yZS5zZi42Ogo+Pj4+Cj4+Pj4gICAgIHN1cHBvcnRlZF9jbGFzc2VzIG5l
dAo+Pj4+Cj4+Pj4gICAgIG1heF9zdXBwb3J0ZWRfdnFzIDY1Cj4+Pj4KPj4+PiAgICAgZGV2X2Zl
YXR1cmVzIENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080IEhPU1RfVFNPNiBTVEFUVVMgQ1RS
TF9WUSBDVFJMX1ZMQU4KPj4+PiBNUSBDVFJMX01BQ19BRERSIFZFUlNJT05fMSBBQ0NFU1NfUExB
VEZPUk0KPj4+Pgo+Pj4+ICAgICBkYXRhIHF1ZXVlIHJhbmdlIDI1Ni00MDk2Cj4+Pj4KPj4+PiAg
ICAgZGVmYXVsdCBxdWV1ZSBzaXplIDI1Ngo+Pj4+Cj4+Pj4KPj4+PiBXaGVuIHlvdSBjcmVhdGUg
dGhlIHZkcGEgZGV2aWNlIHlvdSBjYW4gc3BlY2lmeSB0aGUgcmVxdWVzdGVkIHZhbHVlOgo+Pj4+
Cj4+Pj4gJCB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhLWEgbWdtdGRldiBhdXhpbGlhcnkvbWx4NV9j
b3JlLnNmLjYgbWF4X3ZxcCAxIG10dSA5MDAwCj4+Pj4gcXVldWVfc2l6ZSAxMDI0Cj4+Pj4KPj4+
IEEgZm9sbG93IHVwIHF1ZXN0aW9uOiBpc24ndCBpdCBlbm91Z2ggdG8gY29udHJvbCB0aGUgc2l6
ZQo+Pj4gZnJvbSBxZW11PyBkbyB3ZSBuZWVkIGFiaWxpdHkgdG8gY29udHJvbCBpdCBhdCB0aGUg
a2VybmVsIGxldmVsPwo+Pj4KPj4gUmlnaHQsIEkgdGhpbmsgdG9kYXkgd2UgY2FuIG9wdGlvbmFs
bHkgY29udHJvbCB0aGUgcXVldWUgc2l6ZSBmcm9tIHFlbXUgdmlhCj4+IHJ4X3F1ZXVlX3NpemUg
b3IgdHhfcXVldWVfc2l6ZSwgYnV0IGl0IGhhcyBhIGxpbWl0IG9mIDEwMjQgKGJ0dyB3aHkgaXQg
aGFzCj4+IHN1Y2ggbGltaXQsIHdoaWNoIGlzIHJlbGF0aXZlbHkgbG93ZXIgaW4gbXkgb3Bpbmlv
bikuIEkgdGhpbmsgd2hhdCB3YXMKPj4gbWlzc2luZyBmb3IgUUVNVSBpcyB0byBxdWVyeSB0aGUg
bWF4IG51bWJlciBvZiBxdWV1ZSBzaXplIHRoYXQgdGhlIGhhcmR3YXJlCj4+IGNhbiBzdXBwb3J0
IGZyb20gdGhlIGJhY2tlbmQuCj4+Cj4+IC1TaXdlaQo+Pgo+IG9rYXkgc3VyZS4gbXkgcXVlc3Rp
b24gaXMgaG93IGltcG9ydGFudCBpcyBpdCB0byBjb250cm9sIGl0IGluIHRoZQo+IGtlcm5lbD8K
SSBkb24ndCBoYXZlIGEgc3BlY2lmaWMgdXNlIGNhc2UgZm9yIHRoYXQgKGluIGtlcm5lbCkKCi1T
aXdlaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
