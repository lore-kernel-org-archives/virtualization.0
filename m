Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01625E7E62F
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 12:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7206A60776;
	Tue, 26 Sep 2023 12:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7206A60776
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=4L3U/nJS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=n+9fZUdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbRsWOcKKinv; Tue, 26 Sep 2023 12:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAC456001B;
	Tue, 26 Sep 2023 12:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAC456001B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2054C0039;
	Tue, 26 Sep 2023 12:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85E5BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E34841F19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E34841F19
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=4L3U/nJS; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=n+9fZUdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMaEIIBWguK6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:22:22 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C39941F11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C39941F11
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38Q8oLvW008514; Tue, 26 Sep 2023 12:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Jc2yLsuxqYx//Bd4Tze7RN17rhCfCULfnow4VTOe+OQ=;
 b=4L3U/nJSYRNC0nX83PnJClypsK2ambZ/m5onYXhJra8qIg30MXfX9xqN9EwzUGFAiQaB
 iMxgXdPtXPuCt9xnAWBPdelLWRAzJop1IfqT6s7gMVutNjlvO9/5rWsDgUndE2nMsOgv
 pTv12hAKBhjZ0sLrXvh+RZsCduHvcE0PiocxO71roxCpHUtGx2jTBXoXpMgTXA5WRIU+
 n2JzpFIabeK3hY/PZvRTBrB7ltUKoR+lt/8qbxiYRiMpASrKMNRWI3W8Q2Oh16RoAGLN
 3rl1sGRgCO+cvFcTZjs8yLR+89tTbJPCtyLd4lGBty1oo53UhHSyeJVhgnzJTmciJ0Fv Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuecam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:22:18 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QAeI3g003221; Tue, 26 Sep 2023 12:22:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pf66vxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9ozMCdTkmLDOybnKZOI+fYG/pdaFdSO/DFBmgRZ0e+02XV6akycwMCx6+AAZxA6qzR/VwQnzd/LFx2REY+w3z/jHdEZRkzVjTQAKdL5KVnUV94KxlVVw32ynEj+Cs1xuKUSZdb1fJv8OkkUje1Ci/vLdyujvWTyFEiTIh8h2lseOwsqKIVaU7LTpZ3NFVPAQruAtNvsz5CSWirRhdLH0aQ6LoxKpZ2knMVzRqGfyFbLz6M42ylnJ4rnmHZkSJOuSVz9D6ejl+Kc1yzWzqldmeQfEhS6ZtoCpmCC2cx0JXvS1M4PtfH5IspurmEwtzwdlSTTzw3CKawrPSrTT/n+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc2yLsuxqYx//Bd4Tze7RN17rhCfCULfnow4VTOe+OQ=;
 b=DTmWlDGwXT+WVr2hm6eWyL4qJoiHZ5nl7hi4dGt5Eqf4kRZ57RjYN/uP9xrF4xWarL6SiNRfRaiU2g+FGbY/9eNCp7CswetJP4ue9lYLcvmNWRhNW5pZyv/cgy565/x9JEMkUp26dfbf0QHfjVvT96zaN1ZWG22LRz7w+f2cEnqfwYgsYnqFAN2psZs8+tOTghaWqOD/yOd8QSlwMxbRqhP2oWryoeaikQ/o7tqPDHBNg7Ytvus68q1O1FxiOQhF/hnwT5BPFrrlz8082iVQKYV1vydg/21gAUD620/Kw4m62e2CertaHjk7oM+RVwbKLdhLzUaLevxTfdpnoYDuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc2yLsuxqYx//Bd4Tze7RN17rhCfCULfnow4VTOe+OQ=;
 b=n+9fZUdiiHpEvYYZ7VeteRipDlp5Nf8B/YWBOcGGs5Lr38KXZM2/BIW5XDHo7tjMKf0g5CGtajsx74Xu3vMGzRMmMNy9EdJ/1QW3T0hRfl6DaF4v3bThnzUlCqwOqaS2MqBV8vJgyA0GFqV5JGP/oFZzOtTya67AcOfB600sx+M=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Tue, 26 Sep
 2023 12:22:15 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 12:22:15 +0000
Message-ID: <79d1b247-ecf9-b636-3581-341515cd68cf@oracle.com>
Date: Tue, 26 Sep 2023 05:22:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/16] vdpa: Add support for vq descriptor mappings
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <d9962b17aebd75b4c32c24437ad68c967f78377d.camel@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d9962b17aebd75b4c32c24437ad68c967f78377d.camel@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:806:d1::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 12811632-61ca-4a70-45b7-08dbbe8b382f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxUhv3ApO6Qwq47nKrOibnX2H+fOZ/jLZER73C7+0wIDNE89g25+h5H6GYgDCmF5a07KNK4ebHGQ1HX11+ykscYvsXSOL+lPczz/NI0r5RDyD+TpiBRkV5IYFAXKaY91jUvho8n3JUQ8Kq9OxJQKInbxIpBExtlicH9N2lGg5NPyMm+vvHHNVR3lCuUPftJU9OopwFbBiTNkU0H+W7+a5kBBJeb6mZFtLxuvEg8fb2qienBJZM2B9P4sHRqB9swn556iH+6FTHoZbg85b6ICf0fuSd6NuUPdmaBXui4fTDq2/QVuJBH+UOau6NSRuNLz3ncZZTueJenYdbLQma+jSwhjOnyPK2NlDRpTQrlzigB90hGxy+KNuG4g7qshz26vYcWVynO49GRdEnJLSaMvw4pFLadcxE/jENV27FSZ7I4fnQkIIE14Jwsja7GLJToaTpjLWHxNOGoae7q6Yg7Xn/q5fZFYk2bvQ8AKvkPlyG4yfZ11Q5vdEiRJH/be91Ju6aDs8aypW6trzzVhG14zU5r6HyR8CbBNvAs0leTvxqEaUowSy+0jg6lsTfTFYMxok2xcbucuUoDFjRTHdLZL7JYEfoyx4PUqtgDum+BnWANLP+MrAe4j5bzV+djVc4m5V3WU0BLkzTs19TYWJ751ScklZZrwMNj/UaSkfPdmJsAJDkwv0akjkUELrNKyXNxT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(6666004)(6486002)(7416002)(2906002)(83380400001)(966005)(6506007)(478600001)(8676002)(4326008)(26005)(5660300002)(8936002)(66946007)(66556008)(110136005)(66476007)(54906003)(316002)(41300700001)(2616005)(38100700002)(31686004)(36916002)(6512007)(53546011)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFKckpFYmE1N0EyUnlPZTJXV2xwK3VnRUVPaElidFlTd1NYOFp1UEsrd1ov?=
 =?utf-8?B?MDExajFLTEJtamtlOE4rZjlMbGhqbitCbElLSzlwcXFoa1d3YkRDOFhOSGN4?=
 =?utf-8?B?clRPbmI1RU81ektCOGxJUEFaNUxWUjlTcGFKVG4xQWl3TENncWlKVnlRVmdF?=
 =?utf-8?B?NjBqVUM5bVg2ZzlYOFRaMk5xaXB3MjdacXBlSmkyYmt5WUFCK1g5SGJjb1ZN?=
 =?utf-8?B?RlZBbE9HNHhadkxPRlM3bWtXYzJkMVJIVWI1RmJaZnVDTTVEM0JOUkNqb1FN?=
 =?utf-8?B?eGlnTVVPdk5sQ0Y3ZElKc1IvSGovZFNGYVV2NWpRWC9CMjEzdmJleHBFNkhk?=
 =?utf-8?B?Uy9lTkw5cTVTbyt6NWcyODY1L0dMTndFNmFTajRQcEw3cnNPNHQ1a3RGeXI5?=
 =?utf-8?B?SEFzSldGNkx2Q1JaYTBJMFI0ZWluaUFYYVBrUXYzUGRlOFBIMW9Jb2RtWEht?=
 =?utf-8?B?QWtpNXIzTE1NMU03UmduOFM0NkprZGhwcUV6ZW9TYTl4cnZCcXV3T0tWQStV?=
 =?utf-8?B?MUZIRUUzQkU0eDUwV0ZaQTE0RDIvQjB2YVdtQTM1c2hOdmRmT3pQQnpxNDg2?=
 =?utf-8?B?WjNnd09xb0EwbzN3UFVYdm1rZkhIUFcwQnhGRno5Y0xzNGZCanRGZk1hbWZj?=
 =?utf-8?B?MlZ6N0hBUnFVSExSMElldXlMTnRhbU9UM2doNHhqbS8rcyt0WFZuUEN5UFVa?=
 =?utf-8?B?QlFHVk1HVDhndzlFeTZIbzFGamIrMVljWEtPY3dhOERRSytKYjRDbWxxaFBp?=
 =?utf-8?B?Rm5XWEFqN0tuSXJEMTNPVThJWHJmaldXbHE5T3hnamZROEtSWDgzcllKMHpi?=
 =?utf-8?B?NkRmQXJFcURseHh0Szl6K0pxN3NmT0E4UC9JQVhIRk01WDdydVZCbXhrNERM?=
 =?utf-8?B?eTJFWE1rdlB4bzhwM2hGQlJXMkZMaXBXQWhVblBtQVNIUHdtMWtNRmNIbEVU?=
 =?utf-8?B?QmpkdVlGdGNPYlg2UXBwNG1oQUljaE1ZWnlzdDd1MXp3NHhScS9oQis1cEts?=
 =?utf-8?B?M3FjeE42eXJGWmpMMlBqdll1dUF0NXo4NWhvQ1ZtY0ZHZHpXVXF2YjZlMENT?=
 =?utf-8?B?WG4zcWVNekR6NnM1WHhBTkdycG1uSGx0cmJvNVVIbXcweFovNkh0ck5hUWpR?=
 =?utf-8?B?U0dTY0l0S3h0THp6ZnJUS1Z5U00vQ0F0bW5RZkhtbjJ5M2NFWVU0cUZmN2VW?=
 =?utf-8?B?b0JEbTFBWWJac29PNGF0aUFyVjNLM1Jnc2VIUlphRWxxaG1qcXRKMUxsYnVH?=
 =?utf-8?B?ZHJFeEh1Z2o3Zkw1SjJ5OVV3SUFpeDZzSnFiNE0xYnJTeC95NTZQajAwOEpX?=
 =?utf-8?B?R0E0bWJUelVyZWtCZHY1eG52d1pPaU84TWJZd3llL05mTHZ1U2gyTzQ2Q0Ix?=
 =?utf-8?B?QzBvVVFzVDJUUTY0S1NGd2g4Q3pLZW1TbTQ3Sy9EcHY4ODFTMndFZnpqOEkw?=
 =?utf-8?B?T2hiT1IycDlxKzlteVBlN1lvdlg5TGs3aS9SdkRMaDNqaEppVmZGcWN5UXEr?=
 =?utf-8?B?WU03MlYvRTdMSnJydFl0RjF0Qk5Sa0hXS3hHSzNJQVN3c1ZjanB0MGJWd3ZC?=
 =?utf-8?B?Z2xBdm5wbk9NUXp2NDUyajJCUG44VXBqZFFhazdsaTZkZmFDQk5FWUVyVUYw?=
 =?utf-8?B?blo5NUtLYSt4YnhWKzBIWDRKeDlkc1hTUmxJQkRzY1N2UkoyVVVHY0dJTXdF?=
 =?utf-8?B?MVF1VXB5U2dJN21ZZG5OVTI3WXg2ODBqN0x3cEZVT2l4b0dSZ0YwcjVFYVMx?=
 =?utf-8?B?eHFCSUFiTytmUjdpTXp5MlkzY1NKMU9pbFg4Qk9kYTVOVUxlbFhVNTNGelJG?=
 =?utf-8?B?TUpaQUk1TTlSVGN1TkkxNGpXUjVsQjVJMEdEZklJMlFYZjVNb1ZCbDRTWjVj?=
 =?utf-8?B?ak5nOUN0TVY1YW5GS3hSMTRxbis5azFraStTak1NOXZmS2ZqSVc0VHNicCsv?=
 =?utf-8?B?a2lDYlIzMWFYNnlRU0l6bjlpRWlROStzY1RaRTVFTEIzeGFHR1J6TnBKYjZE?=
 =?utf-8?B?M21wdHZqRG9VYTdmZ1NCWUF2VzB6QktGQWlRUklDMnJWRkV1MmVXRk1ZRng5?=
 =?utf-8?B?ZGZGOTNBSE54cFZRSVBtZVNOUGQxN3dhQUJTdWtmOWo1TWJyOWF0T1BCM0Zw?=
 =?utf-8?Q?XrHh8xy8X0BQCKTaZZW1aO2tq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SFN4dWFiR2szalRUK011WHhFZWREUXZleWxKMHpDWEMvZ3BiMVZuck9OSzdG?=
 =?utf-8?B?dE0vUEhrRkpXZ2NibE8xbXBNZko4ZXh0RW5XVXRxeWFJMGlldDFZd0VReGpE?=
 =?utf-8?B?bHFQbzMvTjdZNFpST0p4Ym9LQlNoVkVNaC8vN0ZRQnRiWEdydFQzMUhpZjZE?=
 =?utf-8?B?ZzQrNklYS0ZTQklZNHNXaVNpQmFPUytNTXJsTHdlWGltNHdFVDJJMDlrbytH?=
 =?utf-8?B?VG10SEFwMWtjRW5FMHdhcTExTXlWS0VUbFY1emdTbVp1WjBVVHlNR01nODdl?=
 =?utf-8?B?WDJBTUl4ZkxrN3Awa3dSbUxLc05La0FTZUY0WjlJNGo5SlRMQ3BUUUNUeHZX?=
 =?utf-8?B?bWltbnhZSGlzODJaSm5NVzZiRXRmU2ZjUlhJUDFNTG5TTEdhNk1UZ2hIY2Nr?=
 =?utf-8?B?QVEyVDJEQWlXVi9HTTNkUm5rQW1EMW01SzNHeDljSnQzK0VGRlhwTkZ6NjNR?=
 =?utf-8?B?TndwdHhUcDk4ZCtpZnRVekVYS0UzRFpCVU1ZNHF6QVJnbzExblQ4N3FyVW9s?=
 =?utf-8?B?dVNrR29SRjUvSVo1ekNWcnJxNUxvWGlZeEVRUW9iS1dESmE1NEVBYXhHTERs?=
 =?utf-8?B?RTdpci9xK0o3TUpBSnRNcVovR1ViK0oySlBMWVpHZEl1QnVodGRYY21GaldD?=
 =?utf-8?B?RmgwZGx6alNpVmpNbUhWYVk0NXlBdjdtbzJxbTJ3QmliMVphMWxiZ29wUkp6?=
 =?utf-8?B?Smt4VnhCUUprc3Y4ejR5KzBKaWVHR0Rjd2ZBbWNxMnluUmMyL0NOWHRjbVM2?=
 =?utf-8?B?VlprRTkreU5BdVdqKzlmN0RDSlpHYWJwSDd5aUJrT1M3QUJ0aEhNUlRRdEdR?=
 =?utf-8?B?eHUxaVlEYWZOemZtN2twby8yUjFpMGczWXpneWgwSEVQaVBVeHNKTjRJbFRK?=
 =?utf-8?B?NnB3UDlvSVFTczlZOC9iME1BK09WcUVHc2hXdmtvYm5tQWxxLzZUanBMVjE2?=
 =?utf-8?B?WHk2TVFsbE1HcE5YcVJNV3o4Tmh3R1BITk9ON0lFYnhNM0k3L1ZGMlE5SXVP?=
 =?utf-8?B?WXE5RU5xRXpxWVphVTRMa1NRYUE0VUhDcGZHVHhyZUExeHl0QzVBQkxmN3JS?=
 =?utf-8?B?TmlwY2ozeHc2Y1lpc0tWYWJoKzVCQlM1dStwalR0RUMyYkIxMWVVenhVcDZD?=
 =?utf-8?B?QTB4dEZHUHRqSDFMUXd4RFg1RkFkTk1rMnV2K1oxVG8wVm5UYjZYTmFCRlJs?=
 =?utf-8?B?N3FORk0wYm1zVUVZdDBFejM2RDFLRG16VW16eElLUGZ3N2NEaXJ2Nk5MelZ4?=
 =?utf-8?Q?s2EY6W6iL7O4Bch?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12811632-61ca-4a70-45b7-08dbbe8b382f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 12:22:15.6967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YMBGfUJV23fECY5KKPYRADyYp68df+JHUMPvklu+hSdkpfuw03cD9N3SN+NqmgRxKkYsm+xB8Z39BHSl0XSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_09,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=892 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260107
X-Proofpoint-ORIG-GUID: ZtdtdNH6BCWwveSEw4E7FxsnIi24gKTU
X-Proofpoint-GUID: ZtdtdNH6BCWwveSEw4E7FxsnIi24gKTU
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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

CgpPbiA5LzI1LzIwMjMgMTI6NTkgQU0sIERyYWdvcyBUYXR1bGVhIHdyb3RlOgo+IE9uIFR1ZSwg
MjAyMy0wOS0xMiBhdCAxNjowMSArMDMwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4+IFRoaXMg
cGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdnEgZGVzY3JpcHRvciB0YWJsZSBtYXBwaW5n
cyB3aGljaAo+PiBhcmUgdXNlZCB0byBpbXByb3ZlIHZkcGEgbGl2ZSBtaWdyYXRpb24gZG93bnRp
bWUuIFRoZSBpbXByb3ZlbWVudCBjb21lcwo+PiBmcm9tIHVzaW5nIHNtYWxsZXIgbWFwcGluZ3Mg
d2hpY2ggdGFrZSBsZXNzIHRpbWUgdG8gY3JlYXRlIGFuZCBkZXN0cm95Cj4+IGluIGh3Lgo+Pgo+
IEdlbnRsZSBwaW5nLgo+Cj4gTm90ZSB0aGF0IEkgd2lsbCBoYXZlIHRvIHNlbmQgYSB2Mi4gVGhl
IGNoYW5nZXMgaW4gbWx4NV9pZmMuaCB3aWxsIG5lZWQgdG8gYmUKPiBtZXJnZWQgZmlyc3Qgc2Vw
YXJhdGVseSBpbnRvIHRoZSBtbHg1LW5leHQgYnJhbmNoIFswXSBhbmQgdGhlbiBwdWxsZWQgZnJv
bSB0aGVyZQo+IHdoZW4gdGhlIHNlcmllcyBpcyBhcHBsaWVkLgpUaGlzIHNlcGFyYXRpb24gaXMg
dW5uZWNlc3NhcnksIGFzIGhpc3RvcmljYWxseSB0aGUgdmlydGlvIGVtdWxhdGlvbiAKcG9ydGlv
biBvZiB0aGUgdXBkYXRlIHRvIG1seDVfaWZjLmggb2Z0ZW4gaGFkIHRvIGdvIHRocm91Z2ggdGhl
IHZob3N0IAp0cmVlLiBTZWUgY29tbWl0cyAxODkyYTNkNDI1YmYgYW5kIGUxM2NkNDVkMzUyZC4g
RXNwZWNpYWxseSB0aGUgCmFkZGl0aW9ucyBmcm9tIHRoaXMgc2VyaWVzIChtYWlubHkgZGVzYyBn
cm91cCBta2V5KSBoYXZlIG5vdGhpbmcgdG8gZG8gCndpdGggYW55IG5ldHdvcmtpbmcgb3IgTklD
IGRyaXZlciBmZWF0dXJlLgoKLVNpd2VpCgo+Cj4gWzBdCj4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWVsbGFub3gvbGludXguZ2l0L2xvZy8/aD1tbHg1
LW5leHQKPgo+IFRoYW5rcywKPiBEcmFnb3MKPgo+PiBUaGUgZmlyc3QgcGFydCBhZGRzIHRoZSB2
ZHBhIGNvcmUgY2hhbmdlcyBmcm9tIFNpLVdlaSBbMF0uCj4+Cj4+IFRoZSBzZWNvbmQgcGFydCBh
ZGRzIHN1cHBvcnQgaW4gbWx4NV92ZHBhOgo+PiAtIFJlZmFjdG9yIHRoZSBtciBjb2RlIHRvIGJl
IGFibGUgdG8gY2xlYW5seSBhZGQgZGVzY3JpcHRvciBtYXBwaW5ncy4KPj4gLSBBZGQgaGFyZHdh
cmUgZGVzY3JpcHRvciBtciBzdXBwb3J0Lgo+PiAtIFByb3Blcmx5IHVwZGF0ZSBpb3RsYiBmb3Ig
Y3ZxIGR1cmluZyBBU0lEIHN3aXRjaC4KPj4KPj4gWzBdCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3ZpcnR1YWxpemF0aW9uLzE2OTQyNDg5NTktMTMzNjktMS1naXQtc2VuZC1lbWFpbC1zaS13
ZWkubGl1QG9yYWNsZS5jb20KPj4KPj4gRHJhZ29zIFRhdHVsZWEgKDEzKToKPj4gIMKgIHZkcGEv
bWx4NTogQ3JlYXRlIGhlbHBlciBmdW5jdGlvbiBmb3IgZG1hIG1hcHBpbmdzCj4+ICDCoCB2ZHBh
L21seDU6IERlY291cGxlIGN2cSBpb3RsYiBoYW5kbGluZyBmcm9tIGh3IG1hcHBpbmcgY29kZQo+
PiAgwqAgdmRwYS9tbHg1OiBUYWtlIGN2cSBpb3RsYiBsb2NrIGR1cmluZyByZWZyZXNoCj4+ICDC
oCB2ZHBhL21seDU6IENvbGxhcHNlICJkdnEiIG1yIGFkZC9kZWxldGUgZnVuY3Rpb25zCj4+ICDC
oCB2ZHBhL21seDU6IFJlbmFtZSBtciBkZXN0cm95IGZ1bmN0aW9ucwo+PiAgwqAgdmRwYS9tbHg1
OiBBbGxvdyBjcmVhdGlvbi9kZWxldGlvbiBvZiBhbnkgZ2l2ZW4gbXIgc3RydWN0Cj4+ICDCoCB2
ZHBhL21seDU6IE1vdmUgbXIgbXV0ZXggb3V0IG9mIG1yIHN0cnVjdAo+PiAgwqAgdmRwYS9tbHg1
OiBJbXByb3ZlIG1yIHVwZGF0ZSBmbG93Cj4+ICDCoCB2ZHBhL21seDU6IEludHJvZHVjZSBtciBm
b3IgdnEgZGVzY3JpcHRvcgo+PiAgwqAgdmRwYS9tbHg1OiBFbmFibGUgaHcgc3VwcG9ydCBmb3Ig
dnEgZGVzY3JpcHRvciBtYXBwaW5nCj4+ICDCoCB2ZHBhL21seDU6IE1ha2UgaW90bGIgaGVscGVy
IGZ1bmN0aW9ucyBtb3JlIGdlbmVyaWMKPj4gIMKgIHZkcGEvbWx4NTogVXBkYXRlIGN2cSBpb3Rs
YiBtYXBwaW5nIG9uIEFTSUQgY2hhbmdlCj4+ICDCoCBDb3ZlciBsZXR0ZXI6IHZkcGEvbWx4NTog
QWRkIHN1cHBvcnQgZm9yIHZxIGRlc2NyaXB0b3IgbWFwcGluZ3MKPj4KPj4gU2ktV2VpIExpdSAo
Myk6Cj4+ICDCoCB2ZHBhOiBpbnRyb2R1Y2UgZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAgZm9y
IHZpcnRxdWV1ZQo+PiAgwqAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0b3IgZ3JvdXAg
YmFja2VuZCBmZWF0dXJlCj4+ICDCoCB2aG9zdC12ZHBhOiB1QVBJIHRvIGdldCBkZWRpY2F0ZWQg
ZGVzY3JpcHRvciBncm91cCBpZAo+Pgo+PiAgwqBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVf
dmRwYS5oIHzCoCAzMSArKystLQo+PiAgwqBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmPCoMKg
wqDCoMKgwqDCoCB8IDE5MSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+PiAgwqBkcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHzCoMKgIDYgKy0KPj4gIMKgZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jwqAgfCAxMDAgKysrKysrKysrKy0tLS0tCj4+ICDCoGRy
aXZlcnMvdmhvc3QvdmRwYS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjcgKysr
Kwo+PiAgwqBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaMKgwqDCoMKgwqAgfMKgwqAgOCAr
LQo+PiAgwqBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmNfdmRwYS5oIHzCoMKgIDcgKy0KPj4g
IMKgaW5jbHVkZS9saW51eC92ZHBhLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
MSArKwo+PiAgwqBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgOCArKwo+PiAgwqBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaMKgwqAgfMKgwqAg
NSArCj4+ICDCoDEwIGZpbGVzIGNoYW5nZWQsIDI2NCBpbnNlcnRpb25zKCspLCAxMzAgZGVsZXRp
b25zKC0pCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
