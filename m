Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97EDCDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 20:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29CAE40861;
	Mon, 16 Oct 2023 20:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29CAE40861
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=xjyRHrgN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qmJofEaX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMO3PL-xvhuH; Mon, 16 Oct 2023 20:11:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 443E240918;
	Mon, 16 Oct 2023 20:11:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 443E240918
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 110A2C0039;
	Mon, 16 Oct 2023 20:11:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 874E2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F5FD40918
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:11:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F5FD40918
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vp0e0Ee2bDwy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:11:03 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5412640861
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:11:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5412640861
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GJONwP016965; Mon, 16 Oct 2023 20:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=xjyRHrgNcJ9ahZY2u+6icxRwcLYpB68Ct5nHHyFaHlLosFpJuC8DZojvKoDd1PhuQMtY
 D/7Mmqw9A3XSWCgoLJ4RcL6Wu7Ji9CyiSfw0XkqDi1aM9J5hk3XxGzmfzqGiNig2FM5E
 Leif0nIw5JY9Uq9PcQmEo2nELXCDrGIig+dvkmW2bX/SIlRyS9A5L+oBDrgXrUQuys5K
 EIIWYF/MpqAFormSO3JANrJkHva5Xs4PjIu01ojY7kgFOfb+7t8tkkM/Sa03z0XM182z
 gGREcUohzmChtNCTFBpm1iSQuJGtRI181C7ElqgPC4NrQD6nBvVrKPvOACiZccEiGsuu dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1bp07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 20:11:00 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GITtbx015354; Mon, 16 Oct 2023 20:10:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg1e4bk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 20:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhxjRMLnLSI8ZZnhTZm+s+6EYfzPvjOQF7Cv+tuv0hjB7YNT7mfvGhvPrnFhTDwYuvzOd0wnFk27Y+Swsb+QId9EWEdQvlfYu+DO/OVdPvo6doPxd6WjY4f9OiGfx1S64v2JsPHeDw383DfWM0wKbRJxB/i/T/M2hjiphQfbOMkVJ+McdDxijN5NwZyL+KFlBRZXxeILAhnImzVzD9Xnu168I85gQ4NqqJaMCttJ2C0imLf6AUGDZu28kWCL4rvqwd67Rlj1HrexLAH9iCie/j+oAawLznKqsSJbxKHrDFvGH9cmXsvIK3omjFA/ZhaGEd4eDuCKNOonBT1B6QirqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=U4pT/Fey7X8IiYyj1/K45HQrvPsjJcD9TKQg6yz92/gzJfVZ1Qnz4qBIB4ottkaOa1O0xpmQ/KdFv5xZOL61No6d1X7SoSYSqEL4D/a8eEhlzHVeaccqgvF8/sD/1+7VcrqfCDvtAJQ0PM5LwE5+ghbPQB/0EleObj00lx+5ghiYecGBC/JJ2vwiY3JeGN2u5V41xxI+We1P88VWOY2aEkhOxdaOa7CIMp6heFaYI1vpmn3Av6tgDoY6x1OaL1TLysoJmI0I5zaPQtsaXIlBRO9/2rxtw8bFl8kbBuL2qiO9A00An7mDczPzANsPjmNEbk8X6z9q6mbvu/x6ncrg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=qmJofEaXk/BE5lIwV6sHzD7prJMiK3PyruwT89Jf9tBrsGd+8UVtWO71fBmR1iwYyNyrq0dnsLP1s3mu83PKjr+FyLpMT49XzZcKc69bFjEciDR7DAs7+1Icm9947oLet318sqdYVQPlI9usH6X571SIhMjWQEA9OwLHEy6ca2s=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA3PR10MB7070.namprd10.prod.outlook.com (2603:10b6:806:311::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 20:10:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:10:56 +0000
Message-ID: <aa1c177f-7d3f-4b66-8f0b-ab2c4bf40084@oracle.com>
Date: Mon, 16 Oct 2023 13:10:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA3PR10MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f23107e-bf8b-4677-69e0-08dbce8401d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVrcmmybOAfaj2X9OlLBdvaAuEZlbGrWps8PiHfENdm1XsGOMYbKIIlvwukf8NZ383DklZjJjzprqnAiisUbGrGEbuuwkM95/HQS2HiTER3fqyf5fX4xFBbJjO/AzR9S1cVwqYZOP9ID9YSOks9/ichXkSbfBJdvJhwwXq1IEgSSr5mc67LXX/hGqcD5DSc+U7JVRvKNsXsdr0TjCbkWv5kKmppEtDxAFFzSe05hp1TlgECXDD4QPiS4YbwBgdiY6EDCuvz+/ay3IH9DeMjwL9RzOy41f1l/xSOELPfMYkXsgeWjZxR0qGl/1+IPjnfRY+zxtNvO7ZcxQjgkTF34z09pZbT1hRLFF7CfQfMoKFfknHiLPSbhNGT7vIwmFM1ddumAk8OFJvg/Il702xH4coyCovGM4XDsHKo/v7i+Re4QxU9Sh7Yxh5KMtg9TrI+800WlVv2IJeu8+mFhpdfZeYhdr0mIqRTZ8/xvjj5JL//AKpeMVIKMW0VJcQzYv5fHF4QLoVBLjJs6G7UbG97nhVW3XRJR8J8ef3kf/Ve+0UKsZy9LLsS95mZ0GLrst4DTUPXbjhm+wIoZzNq23PHz8zWIOiv7LlSOGhi3sTGH5QOAXSHheEwBNA9mx9IhlOBQEkF/tDZ/PDHUB3bOJTeEyRaINDBNKkDla+jOQCEaSM7tMM9cVnESDmdy+XzPzlTGJXeKDFcRHlGvfgcHxTOuKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(83380400001)(6512007)(66476007)(66556008)(8676002)(4326008)(66946007)(8936002)(316002)(6916009)(6666004)(6506007)(53546011)(36916002)(966005)(5660300002)(41300700001)(478600001)(2906002)(6486002)(38100700002)(86362001)(31696002)(36756003)(31686004)(26005)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRaeDBEWGJYWkVzNG1WdnNRR0N1VWw2dlB4bjdNWktFdHZMMWgvTEtDa21Y?=
 =?utf-8?B?eWJWYTdvSy9RREhhR0d3REtiZVJmM0xlUUdKRlp3Y1ltcktXcWdLeW1zYmZk?=
 =?utf-8?B?R2g2aDcreHhpSmFhOXAxZWJXUlN2Y1pqUGhmVEJTQzluQmJDNWw1eDkyUXB0?=
 =?utf-8?B?M1phbEZucEQ4cUdVYkhBS2ViNGJvN0Y2NGhLb3o3ZlMyMFYyY0o0eEdOZ3Rq?=
 =?utf-8?B?bTlaY3ZFT3E4UUdEYTh0a3YwU2pYdnJBMi9kakZ5M2VnKzM4Vk1ENElYeW1s?=
 =?utf-8?B?Rjc1V3IrVEg3QTBncEo0TlNOMElRd291a1NkQ0xFdURqNE5WMjB6ZjZaaGtn?=
 =?utf-8?B?STJaN1VsQlk5NG82a3dZbTBxK3BTamhoYjYyWUdUYXNiWU9yc2w4cVRrT1RM?=
 =?utf-8?B?Y2tiM05VZnNnK0ZrYjk0U0xONlhtN0EvbFI4ZHdqbUFiR3hTTWx1R3VWUVNj?=
 =?utf-8?B?NzNraFVsNENtc3pSQTAwNk1lZWIwQzFBeGZ6bXQvL3lRWmR4Nnc5VjlJQXh2?=
 =?utf-8?B?emNlTFpQS3Fib2ZYcHE2RUsxemFCRnhMVVE5TldrVzJrNFZIdzA0RzE3ZGEw?=
 =?utf-8?B?UFNZdGkranN0NENEM0dnSHI5VHRWb0V0bU1ZN0FzU2RGWm1aakFuRHZ3N3Jv?=
 =?utf-8?B?T3BuYVVuaXpNZTNrdVZteW5IbGJZbmMvNi9zeVFscXBRczlmYTN0NjBFaHkr?=
 =?utf-8?B?bThWVThzYmszV1BnOTROMnZLajd5NHpBOFZzSlpLUThoaHVUOE9iNHM2bEpP?=
 =?utf-8?B?ZlREai9UVUpFWXQ2aDB3Z0JmUVlCb2lpcHNPd1ZkVkl4dGFHWGxlRDl0dlBy?=
 =?utf-8?B?Z2hZWko4YVBwTVRKQ2VTcW5DTDZ4aGdScGpNaFQvcmIxWTNBRGNxOS9Qa1ds?=
 =?utf-8?B?NTZWVUI2MlY5bktoYTVqc1A0VVZ6Ykl1Z25VZFJKVnZucmo5RTVQRWh6QnZr?=
 =?utf-8?B?LzE0RmZkTFJYdlhHQUl0L0twTDJ6RVVUMU8xYWwybGdZYzlpallhUCs1MFVz?=
 =?utf-8?B?ZVd3U2JYZUdzMklMRXBpcXhnSkZpalA1Q0ZUSjlFM2pRRE9ST3ZGMUIxUU9D?=
 =?utf-8?B?ODJJbkNnbm1rbE5MMExTR29CUkFTTStHanNVYW5xdzRHcmFxbmhxSEM4N0M5?=
 =?utf-8?B?TFc1ZFlzMVp1WXJZTXhaejJ0b2paaU5jNW8zMFZNeE1LK3NzQmw0WVFQVFhD?=
 =?utf-8?B?OTFQMlI4Mmx0eE96aHFCWXl6akV4TEF3TmJKWkppanhzbU5SY1krOVBOdVJu?=
 =?utf-8?B?dm5DbzdqdkRGRjRpQ2dFQTlBOWRpa0tvK3R6bjJXWmJqS1VtT1EvQnpZVHN0?=
 =?utf-8?B?UE1HWjlFZFE4cEsyTVJpcU4vWWRtNVlrdmo3WnBXeDBFZDR2ak40d2FkVUgv?=
 =?utf-8?B?RzNMQXJrM3Q2TjhIMlhVczdlaThLSUlIVGY0NkxPNlgzTXFRNUpDQzYzY1lj?=
 =?utf-8?B?RHNJR2VnNFhmMjlqTTZmNU85UTlDTTVyd0ZBY2YwQ2FkWFFuSTQ1ZUNpSXEv?=
 =?utf-8?B?dm5EckJPeVJCbFIwTE9naW5ycEcxcEFmWVdRYmF0aDBzbTROdW91WmdneFFV?=
 =?utf-8?B?dFN4N3hrZVNTU1BLOUlCbFJuWFdqbHBSMjZ3czFCNDJSS3M5VGF0OXoyK25q?=
 =?utf-8?B?YWFRaXdRVUdKeGFnMXVBUXlMa09HMUN5c1NHek9NMGVUNGpxS0xxYUtkdVA5?=
 =?utf-8?B?bmVpOXRudFkwSmtMTnFHdGlBTHRsV25LdTg3ZXVtY0wwNmFaa3lmMVVsTkxP?=
 =?utf-8?B?aFdZNnE0Qyt2YkJBNXFSNDE1REJwRFMxbnVkcmtKejJJN0h0VnRiaE1LZk5x?=
 =?utf-8?B?N09zbXZrRTkwT0l5VC9LYjduYkhWa3l2cWFTQ2pyRitjNEorUkFJQ2xFUHhO?=
 =?utf-8?B?Wm55UEtuV0xLSFprVlI3WEZNM211b1VhM1RyWEg2MzRjcDNTVG0rQndQeGk0?=
 =?utf-8?B?UXVyQzFKWmhHUklhNGFXTzZ1eEdLTThkM0E3aUdLamNZcUxYUXV1ejJIQ0Y5?=
 =?utf-8?B?VklUenJIaFNyK0d0SWhWSDRLN2cyNlZWRStjVU93VzZWZENXQXJ2V3JlNkZP?=
 =?utf-8?B?Ui9kbHFMSFlWbWhBR2MvQ1pNUCs2NTFaU3pBMGk2RVFSY3FFc0RhR3d0S2tj?=
 =?utf-8?Q?116ytV4xLtwJDx0HfMGzeYZqF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWlTVURMWU8zS1FCMFY4azh3WENXYUYrS1hVWGNReXBoUWhkNUFnSnJFQW5V?=
 =?utf-8?B?L3RpenYrZ2lqekVXaHV3RTlsbkVsdnB0RStKTEdlQ3JNb0FKc3M1V2Z2cEQx?=
 =?utf-8?B?dUVSVldiN1pjUEd3eUdneml1T0tncHdQN2hlbFZKaDB6QVh1QkwzcWRTelF4?=
 =?utf-8?B?Um90NVNlNDUvQTdQNndjcEVtdFVZR2w1cFVwK3dPM1VZd0tXM3BzajhzWFha?=
 =?utf-8?B?S3FmTkJCTEFMQ1dCaS9IWjA5L2ZWRmdlOTVSRk10TlE5Tm9WenlTK2dJNVZE?=
 =?utf-8?B?djdGVFBlUWJMUTNkZkgvQWZFbkp0RVRnVGV3KzRMK2EybEhYblgxc1g1OU51?=
 =?utf-8?B?UlpNVDNkeS9IZU5mTmhJWGRVNzVGdVczblE5Qy9aQ0hlSGJBb2NxcStvcWph?=
 =?utf-8?B?ZlpIQU1vMXZGMmZZTDZQaHlVazJSMzE4aHMxWGhSb2lLa2tVV2p5UTg1bWU3?=
 =?utf-8?B?TWlpZm81US9uZkJiU01BYXdLOGh6bmg2UldrWjI2WHZzOU1WbkhBUFA2eTZk?=
 =?utf-8?B?b082cDVQcXQzU2NyT0x0QUFyWkNZZEtZOXp2Z29jemw5UGNPZ0IyTENaUzhW?=
 =?utf-8?B?OG9jSHFJdHp3a1RFM2dWZVVoNnBnaENNK1ZZa2tpTzNtOHdiNkRoU2xtT1ln?=
 =?utf-8?B?YlVDWHlMMHVSOFI3UXUvb0dDaVJIVkxOREdmYzNTREVHNjZEK2RoRERmVEVz?=
 =?utf-8?B?NWhOR2c3N3M2N08yYlhOMG9SWkpiSHBFR1JwZ2hKUk9tZjdGdTNULzFLcCtD?=
 =?utf-8?B?Sit4c3ZpVVNFQkZINFVKMmhRemd4ZEM2amxYZWI4ZGoyYmhtZTZHSGlTM2ZQ?=
 =?utf-8?B?cDZ2d1FybVgrSFV5cU9QalJKaHZnWnZZM09XaG1HelFpL0VhUWxGTC9kZXlz?=
 =?utf-8?B?Y0k2WGJFRDNEL0JMWUY5c0RBaG9JeStkVVdwWXFhNjFxSFl0UDZ0OWpsOTJt?=
 =?utf-8?B?OGZpUWx3Q3czSVE2c1JFWmFVZGY3ak9iMDBHQWJhOWZ5VmR1eWg4c1dJRXor?=
 =?utf-8?B?Wk1MU0NrTjJtT0FVYUdjMytPbjZaendoM3NFckdwemJXZWhQbU5hWVMzWmow?=
 =?utf-8?B?Z0R2RVREME9yYXhKMGI1SzRFc0lnc3NPeHZ6ZnlXcTJ4M1lhTGdtcmxnbHQz?=
 =?utf-8?B?NytaSCtBSFVldUtjZ3hUeDdqTElRSlNua1U1Y1VUMnFsTmRkTWZFUmEvRkNN?=
 =?utf-8?B?M3RPZmU1dG1RTWI4YXdzSEdpZDU5MmRESy9jR3BDUDVWT2NRWmJlUDViZVNV?=
 =?utf-8?Q?IRAAlr86cIJT3ke?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f23107e-bf8b-4677-69e0-08dbce8401d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:10:56.6340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgvVEzwKMaDVhnPzPl2sEVVLLeSNeceDh9QxunJlwhUQN3amcO4AnpxcAKG+xVyZmlN7LVLGSw2++cZyz2axmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160176
X-Proofpoint-GUID: kp13-1G9Ecbm4iHamZRYyC-CT7lmKBI8
X-Proofpoint-ORIG-GUID: kp13-1G9Ecbm4iHamZRYyC-CT7lmKBI8
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMC8xNS8yMDIzIDExOjMyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgT2N0
IDEzLCAyMDIzIGF0IDM6MzbigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+
IHdyb3RlOgo+Pgo+Pgo+PiBPbiAxMC8xMi8yMDIzIDg6MDEgUE0sIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBPbiBUdWUsIE9jdCAxMCwgMjAyMyBhdCA1OjA14oCvUE0gU2ktV2VpIExpdSA8c2ktd2Vp
LmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPj4+PiBEZXZpY2VzIHdpdGggb24tY2hpcCBJT01NVSBv
ciB2ZW5kb3Igc3BlY2lmaWMgSU9UTEIgaW1wbGVtZW50YXRpb24KPj4+PiBtYXkgbmVlZCB0byBy
ZXN0b3JlIGlvdGxiIG1hcHBpbmcgdG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBzdGF0ZQo+Pj4+
IHVzaW5nIHRoZSAucmVzZXRfbWFwIG9wLCBhcyBpdCdzIGRlc2lyYWJsZSBmb3Igc29tZSBwYXJl
bnQgZGV2aWNlcwo+Pj4+IHRvIHNvbGVseSBtYW5pcHVsYXRlIG1hcHBpbmdzIGJ5IGl0cyBvd24s
IGluZGVwZW5kZW50IG9mIHZpcnRpbyBkZXZpY2UKPj4+PiBzdGF0ZS4gRm9yIGluc3RhbmNlLCBk
ZXZpY2UgcmVzZXQgZG9lcyBub3QgY2F1c2UgbWFwcGluZyBnbyBhd2F5IG9uCj4+Pj4gc3VjaCBJ
T1RMQiBtb2RlbCBpbiBuZWVkIG9mIHBlcnNpc3RlbnQgbWFwcGluZy4gQmVmb3JlIHZob3N0LXZk
cGEKPj4+PiBpcyBnb2luZyBhd2F5LCBnaXZlIHRoZW0gYSBjaGFuY2UgdG8gcmVzZXQgaW90bGIg
YmFjayB0byB0aGUgaW5pdGlhbAo+Pj4+IHN0YXRlIGluIHZob3N0X3ZkcGFfY2xlYW51cCgpLgo+
Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTYgKysrKysrKysrKysr
KysrKwo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
Pj4+IGluZGV4IDg1MTUzNWYuLmEzZjgxNjAgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92aG9z
dC92ZHBhLmMKPj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+IEBAIC0xMzEsNiAr
MTMxLDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqdmhvc3RfdmRwYV9maW5kX2Fs
bG9jX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+ICAgICAgICAgICByZXR1cm4gdmhvc3Rf
dmRwYV9hbGxvY19hcyh2LCBhc2lkKTsKPj4+PiAgICB9Cj4+Pj4KPj4+PiArc3RhdGljIHZvaWQg
dmhvc3RfdmRwYV9yZXNldF9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQo+Pj4+
ICt7Cj4+Pj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+Pj4+
ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmln
Owo+Pj4+ICsKPj4+PiArICAgICAgIGlmIChvcHMtPnJlc2V0X21hcCkKPj4+PiArICAgICAgICAg
ICAgICAgb3BzLT5yZXNldF9tYXAodmRwYSwgYXNpZCk7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gICAg
c3RhdGljIGludCB2aG9zdF92ZHBhX3JlbW92ZV9hcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMy
IGFzaWQpCj4+Pj4gICAgewo+Pj4+ICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqYXMg
PSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+Pj4+IEBAIC0xNDAsNiArMTQ5LDEzIEBAIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQo+
Pj4+Cj4+Pj4gICAgICAgICAgIGhsaXN0X2RlbCgmYXMtPmhhc2hfbGluayk7Cj4+Pj4gICAgICAg
ICAgIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAodiwgJmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAtIDEs
IGFzaWQpOwo+Pj4+ICsgICAgICAgLyoKPj4+PiArICAgICAgICAqIERldmljZXMgd2l0aCB2ZW5k
b3Igc3BlY2lmaWMgSU9NTVUgbWF5IG5lZWQgdG8gcmVzdG9yZQo+Pj4+ICsgICAgICAgICogaW90
bGIgdG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBzdGF0ZSB3aGljaCBpcyBub3QgZG9uZQo+Pj4+
ICsgICAgICAgICogdGhyb3VnaCBkZXZpY2UgcmVzZXQsIGFzIHRoZSBJT1RMQiBtYXBwaW5nIG1h
bmlwdWxhdGlvbgo+Pj4+ICsgICAgICAgICogY291bGQgYmUgZGVjb3VwbGVkIGZyb20gdGhlIHZp
cnRpbyBkZXZpY2UgbGlmZSBjeWNsZS4KPj4+PiArICAgICAgICAqLwo+Pj4gU2hvdWxkIHdlIGRv
IHRoaXMgYWNjb3JkaW5nIHRvIHdoZXRoZXIgSU9UTEJfUFJFU0lTVCBpcyBzZXQ/Cj4+IFdlbGws
IGluIHRoZW9yeSB0aGlzIHNlZW1zIGxpa2Ugc28gYnV0IGl0J3MgdW5uZWNlc3NhcnkgY29kZSBj
aGFuZ2UKPj4gYWN0dWFsbHksIGFzIHRoYXQgaXMgdGhlIHdheSBob3cgdkRQQSBwYXJlbnQgYmVo
aW5kIHBsYXRmb3JtIElPTU1VIHdvcmtzCj4+IHRvZGF5LCBhbmQgdXNlcnNwYWNlIGRvZXNuJ3Qg
YnJlYWsgYXMgb2YgdG9kYXkuIDopCj4gV2VsbCwgdGhpcyBpcyBvbmUgcXVlc3Rpb24gSSd2ZSBl
dmVyIGFza2VkIGJlZm9yZS4gWW91IGhhdmUgZXhwbGFpbmVkCj4gdGhhdCBvbmUgb2YgdGhlIHJl
YXNvbiB0aGF0IHdlIGRvbid0IGJyZWFrIHVzZXJzcGFjZSBpcyB0aGF0IHRoZXkgbWF5Cj4gY291
cGxlIElPVExCIHJlc2V0IHdpdGggdkRQQSByZXNldCBhcyB3ZWxsLiBPbmUgZXhhbXBsZSBpcyB0
aGUgUWVtdS4KTm9wZSwgaXQgd2FzIHRoZSBvcHBvc2l0ZS4gTWF5YmUgaXQgd2FzIG5vdCBjbGVh
ciBlbm91Z2gsIGxldCBtZSB0cnkgCm9uY2UgbW9yZSAtIHVzZXJzcGFjZSBDQU5OT1QgZGVjb3Vw
bGUgSU9UTEIgcmVzZXQgZnJvbSB2RFBBIHJlc2V0IHRvZGF5LiAKVGhpcyBpcyBiZWNhdXNlIG9m
IGJ1Zy9kaXNjcmVwYW5jeSBpbiBtbHg1X3ZkYXAgYW5kIHZkcGFfc2ltIGFscmVhZHkgCmJyZWFr
aW5nIHVzZXJzcGFjZSdzIGV4cGVjdGF0aW9uLCByZW5kZXJpbmcgdGhlIGJyb2tlbm5lc3MvaW5j
b25zaXN0ZW5jeSAKb24gdmhvc3QtdmRwYSBtYXBwaW5nIGludGVyZmFjZSBmcm9tIGJlaGF2aW5n
IHdoYXQgaXQgcHJvbWlzZWQgYW5kIApzaG91bGQgaGF2ZSBkb25lLiBPbmx5IHdpdGggdGhlIElP
VExCX1BFUlNJU1QgZmxhZyBzZWVuIHVzZXJzcGFjZSBjYW4gCnRydXN0IHZob3N0LXZkcGEga2Vy
bmVsIGludGVyZmFjZSAqcmVsaWFibHkqIHRvIGRlY291cGxlIElPVExCIHJlc2V0IApmcm9tIHZE
UEEgcmVzZXQuIFdpdGhvdXQgc2VlaW5nIHRoaXMgZmxhZywgbm8gbWF0dGVyIGhvdyB0aGUgY29k
ZSBpbiAKUUVNVSB3YXMgd3JpdHRlbiwgdG9kYXkncyBvbGRlciB1c2Vyc3BhY2Ugd2FzIG5ldmVy
IGxpa2UgdG8gYXNzdW1lIHRoZSAKbWFwcGluZ3Mgd2lsbCAqZGVmaW5pdGVseSogYmUgY2xlYXJl
ZCBieSB2RFBBIHJlc2V0LiBJZiBhbnkgdXNlcnNwYWNlIAppbXBsZW1lbnRhdGlvbiB3YW50cyB0
byBnZXQgY29uc2lzdGVudCBiZWhhdmlvciBmb3IgYWxsIHZEUEEgcGFyZW50IApkZXZpY2VzLCBp
dCBzdGlsbCBoYXMgdG8gKmV4cGxpY2l0bHkqIGNsZWFyIGFsbCBleGlzdGluZyBtYXBwaW5ncyBi
eSBpdHMgCm93biBieSBzZW5kaW5nIGJ1bmNoIG9mIHVubWFwIChpb3RsYiBpbnZhbGlkYXRlKSBy
ZXF1ZXN0cyB0byB2aG9zdC12ZHBhIAprZXJuZWwgYmVmb3JlIHJlc2V0dGluZyB0aGUgdkRQQSBi
YWNrZW5kLgoKSW4gYnJpZWYsIHVzZXJzcGFjZSBpcyBhbHJlYWR5IGJyb2tlbiBieSBrZXJuZWwg
aW1wbGVtZW50YXRpb24gdG9kYXksIAphbmQgbmV3IHVzZXJzcGFjZSBuZWVkcyBzb21lIGRldmlj
ZSBmbGFnIHRvIGtub3cgZm9yIHN1cmUgaWYga2VybmVsIGJ1ZyAKaGFzIGFscmVhZHkgYmVlbiBm
aXhlZDsgb2xkZXIgdXNlcnNwYWNlIGRvZXNuJ3QgY2FyZSBhYm91dCBwcmVzZXJ2aW5nIAp0aGUg
YnJva2VuIGtlcm5lbCBiZWhhdmlvciBhdCBhbGwsIHJlZ2FyZGxlc3Mgd2hldGhlciBvciBub3Qg
aXQgd2FudHMgdG8gCmRlY291cGxlIElPVExCIGZyb20gdkRQQSByZXNldC4KCj4KPj4gQXMgZXhw
bGFpbmVkIGluIHByZXZpb3VzIHRocmVhZHMgWzFdWzJdLCB3aGVuIElPVExCX1BFUlNJU1QgaXMg
bm90IHNldAo+PiBpdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IG1lYW4gdGhlIGlvdGxiIHdpbGwgZGVm
aW5pdGVseSBiZSBkZXN0cm95ZWQKPj4gYWNyb3NzIHJlc2V0ICh0aGluayBhYm91dCB0aGUgcGxh
dGZvcm0gSU9NTVUgY2FzZSksIHNvIHVzZXJzcGFjZSB0b2RheQo+PiBpcyBhbHJlYWR5IHRvbGVy
YXRpbmcgZW5vdWdoIHdpdGggZWl0aGVyIGdvb2Qgb3IgYmFkIElPTU1VLiBUaGlzIGNvZGUgb2YK
Pj4gbm90IGNoZWNraW5nIElPVExCX1BFUlNJU1QgYmVpbmcgc2V0IGlzIGludGVudGlvbmFsLCB0
aGVyZSdzIG5vIHBvaW50IHRvCj4+IGVtdWxhdGUgYmFkIElPTU1VIGJlaGF2aW9yIGV2ZW4gZm9y
IG9sZGVyIHVzZXJzcGFjZSAod2l0aCBpbXByb3Blcgo+PiBlbXVsYXRpb24gdG8gYmUgZG9uZSBp
dCB3b3VsZCByZXN1bHQgaW4gZXZlbiB3b3JzZSBwZXJmb3JtYW5jZSkuCj4gRm9yIHR3byByZWFz
b25zOgo+Cj4gMSkgYmFja2VuZCBmZWF0dXJlcyBuZWVkIGFja2VkIGJ5IHVzZXJzcGFjZSB0aGlz
IGlzIGJ5IGRlc2lnbgpUaGVyZSdzIG5vIGJyZWFrYWdlIG9uIHRoaXMgcGFydC4gQmFja2VuZCBm
ZWF0dXJlIElPVExCX1BFUlNJU1Qgd29uJ3QgYmUgCnNldCBpZiB1c2Vyc3BhY2UgZG9lc24ndCBh
Y2suCj4gMikga2VlcCB0aGUgb2RkIGJlaGF2aW91ciBzZWVtcyB0byBiZSBtb3JlIHNhZmUgYXMg
d2UgY2FuJ3QgYXVkaXQKPiBldmVyeSB1c2Vyc3BhY2UgcHJvZ3JhbQpEZWZpbml0ZWx5IGRvbid0
IGhhdmUgdG8gYXVkaXQgZXZlcnkgdXNlcnNwYWNlIHByb2dyYW0sIGJ1dCBJIGNhbm5vdCAKdGhp
bmsgb2YgYSBjYXNlIHdoZXJlIGEgc2FuZSB1c2Vyc3BhY2UgcHJvZ3JhbSBjYW4gYmUgYnJva2Vu
LiBDYW4geW91IAplbGFib3JhdGUgb25lIG9yIHR3byBwb3RlbnRpYWwgdXNlcnNwYWNlIHVzYWdl
IHRoYXQgbWF5IGJyZWFrIGJlY2F1c2Ugb2YgCnRoaXM/IEFzIHNhaWQsIHBsYXRmb3JtIElPTU1V
IGFscmVhZHkgZGlkIGl0IHRoaXMgd2F5LgoKUmVnYXJkcywKLVNpd2VpCj4KPiBUaGFua3MKPgo+
PiBJIHRoaW5rCj4+IHRoZSBwdXJwb3NlIG9mIHRoZSBJT1RMQl9QRVJTSVNUIGZsYWcgaXMganVz
dCB0byBnaXZlIHVzZXJzcGFjZSAxMDAlCj4+IGNlcnRhaW50eSBvZiBwZXJzaXN0ZW50IGlvdGxi
IG1hcHBpbmcgbm90IGdldHRpbmcgbG9zdCBhY3Jvc3MgdmRwYSByZXNldC4KPj4KPj4gVGhhbmtz
LAo+PiAtU2l3ZWkKPj4KPj4gWzFdCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxp
emF0aW9uLzlmMTE4ZmM5LTRmNmYtZGQ2Ny1hMjkxLWJlNzgxNTJlNDdmZEBvcmFjbGUuY29tLwo+
PiBbMl0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMzM2NGFkZmQt
MWViNy04YmNlLTQxZjktYmZlNTQ3M2YxZjJlQG9yYWNsZS5jb20vCj4+PiAgICBPdGhlcndpc2UK
Pj4+IHdlIG1heSBicmVhayBvbGQgdXNlcnNwYWNlLgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+PiAr
ICAgICAgIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+Pj4+ICAgICAgICAgICBrZnJl
ZShhcyk7Cj4+Pj4KPj4+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4gLS0KPj4+PiAxLjguMy4x
Cj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
