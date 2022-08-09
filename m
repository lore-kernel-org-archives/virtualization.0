Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58426C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 20:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C866D60BC2;
	Tue,  9 Aug 2022 20:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C866D60BC2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HpcmW+OZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gGbaqKA2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfRm9yPD-a4e; Tue,  9 Aug 2022 20:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE5D560A9C;
	Tue,  9 Aug 2022 20:32:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE5D560A9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB50AC0033;
	Tue,  9 Aug 2022 20:32:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91294C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 20:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 444274060B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 20:32:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 444274060B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HpcmW+OZ; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=gGbaqKA2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NnQIDhaRSJTu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 20:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A230A40223
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A230A40223
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 20:32:52 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279KU4gp014349;
 Tue, 9 Aug 2022 20:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I7pPRjwMDt+ittAVYdSuWZVxLhU2vduNW9Ih/yjkEGE=;
 b=HpcmW+OZVfx4OzhL3J6Iz2a/FBkUCPS0xwVAoSU1S4mIn/7lM0fAgrd4/h6le8XEEQtV
 +PcRyOq2lJQRdvmvVR1+biZ9yrv7JL2+AmMRDn77QH/BaRNux3euFrKq2vMcqst8G3gB
 OghbluxalMxMjlI3cwlxhzXsMfVng5m3dAFq16wtSfyHFtZWrzpOkSW1COq32bJ14r/B
 l6Di3MUosbh5JGJcN1yViBIozEdqd+DKtsNO4ojQQexD2egLlidSOVQYgCjpi+Q8XnWW
 Bp09R69mX8QPIQhMAwkVcjuI87WA5vH+R330KVdz+u3B6i3CCuGDrkGWpJp/UYMw7XVq Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqgg4tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 20:32:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279JoPnx010664; Tue, 9 Aug 2022 20:32:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqfhks5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 20:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf5xRfgFa5iya+uZANWkEXOfnMikSIxkzn2H/6e2J9fbFzyf3ZyNHAAvainFspcmvjQVsPPwRzzEOqBAENtjeSiig6Xkdglz6jsjNrdAN2D/8n9KwK4oZw0Bjmqt2z4kJbjET9q42cxNKj03Dq7Q4D9n2NJ22iZhjPCLCx2i8wLgf/M9TQtoyKdjb9N+TqykBcIzXFPYBB3PG4ZnP9YSsNAjf/Gw5/Q0RgGDxwpQY+zxxpD/GTTNDPyVbI0PJOqTW4MsCxIgfzcwy1ucpgwL+SkOyP/EOSlS1hnBMMf4hN/uXEjb1lJLcv9WVOO1TCZUPHA15BXKqMK/SYcrvqLDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7pPRjwMDt+ittAVYdSuWZVxLhU2vduNW9Ih/yjkEGE=;
 b=MJUsY+CIdPx5GeZx2kdZe3XNRDLowDk31nMksGb7hYK6AWkMOHpSxJ2+CtB00juz76v26BVV0oV6J2h4DmY2V+0bqlptPlcYkUGC3DTnD8IFcoj6LaKgQ4bXPIrO+WW0UxCKFF1rYy4vTaW2JhASHaPja3d0FClXKUc4bYbzrXoNqPOXJoi5iQvkuBXtQIrLIG/2rOfShCk/DlzppTg/BqA4MmzvMaWZJZLZEcvD7hZwJhzbc41GMd6DHJBl79NYFG9kFFBKo4Bk7J2w5XQJtVsszVpNbidt9gogRTLpffV3YC+LCPNK9mkpuS1dsjM/zf4InH2i4Y2Ajkedak0Gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7pPRjwMDt+ittAVYdSuWZVxLhU2vduNW9Ih/yjkEGE=;
 b=gGbaqKA2TH8fchU4c7handHrks+DjiNs+41nT/GZfsGYRaMzyzPTkUWytjacxLDqYtpAVRFyuXDQ9Qh7I5tt1pR/eLa1CrNZ9lQoplaybweCG+5wL624XHayPu46103hKQp66X8ofB0d71WGoeh3yFhLj5kg/rrcJkNsKKqtDjU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SN6PR10MB2813.namprd10.prod.outlook.com (2603:10b6:805:cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Tue, 9 Aug
 2022 20:32:45 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 20:32:45 +0000
Message-ID: <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
Date: Tue, 9 Aug 2022 13:32:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Gavin Li <gavinl@nvidia.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN6PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:805:ca::41) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbfbb486-d148-4a3f-12e5-08da7a465141
X-MS-TrafficTypeDiagnostic: SN6PR10MB2813:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lqArDUp7uMS+lVozKVys8wCaPQRF1EFeM0riITBgWMG97kAwUYKvB+/y0vy3GB8zHP7UE5rksnAPsJw6zuOpAevMrCoqFhmkxDtwto/b27GoJoB3L7X/5DtmTSQVbVYho5AVQQu4EG47C58PbBoN3W+T3ygsCcZ6hMkK2rEksiM0GL9maFJAeycjYRuWx+xIIJULdGlSS81s6qw3NLppa3mfJqvfxSj+uhRNo9c6n5ncV2RyY4NEj4gh2Fs/lsEEBAINnUoGkORONafobcbs2oJHT1Hf9dljkS1uaqLGvi4AV+x2q9KHTShuugCvuE83sbPlp2MjYCr49n3Uru7bEgHb9aBUwl1rSmDDx8PbeYJUR4W8hzYd43iZIcZa4F/+JAk0pM32H58UjygE+3llS4AdoEtEmW3XBrSh+PpAAyjQtxuupsjE7E9gQMvdaoTmqynrLsnVwel3IFR3r9GZ9I+CwLwOKI3PktVFRHmPd4HCuSwtqjlKq878M/+PSdu2vcK/b2UjHcIJBLtz39Kd60uDN+bvgED46LPveC6XkrQyt2FwszAS2mdnrfa8fkPixpW/YJtw9z3XD2zS5BNe5kdLDeYLfxfY3XCUbpN8vzhEtkrhJTIncxvN/Q+R9y7giulHdJidxulXu4t3vNamE1rMuhJ1D7ZsP9Ypl0LQO/P4LC5tU/vxrPtGr4ndlYO6+5tWpkcv2RaaCoZCjbVSGcsW3SBuloZorHSG+Dwvi/C13B3Di6RaCNt/p+0pz4xPtt/t7b8K3RnNHb4cCL56xtQYNxIu0krwyFZw80ZNUth0FZlTvpHs1JgKqbKNCC4hDWIqRsweBycmbVV7LdukQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(26005)(31696002)(41300700001)(53546011)(36916002)(6512007)(38100700002)(186003)(6506007)(2616005)(86362001)(83380400001)(31686004)(66946007)(66556008)(8676002)(4326008)(66476007)(2906002)(7416002)(8936002)(478600001)(5660300002)(110136005)(54906003)(6486002)(36756003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnROMXBnUjBXWGYxZ3VNWHYwVVJaWnpEb1pReEVDM3pLU25yZ2FiakZ5Y1kw?=
 =?utf-8?B?Q016a3k1L0kxUXBtVld4ZzVNU3A3SGxqSEcyYVRBU3dDUEN6VFNkSlNvK1hR?=
 =?utf-8?B?RllyWGh4WTcvcXBrRkFKelhlbURQSSt0ODVhK0ttRG1TTUhHSE9FZ012MTdW?=
 =?utf-8?B?TmFKL04vSVFxcnZFNUx5MWt1NXpFQjk0b01GeUxOMjhPemFBY1A5Z09oQ2Ny?=
 =?utf-8?B?Y2dlcS9LTWpRRGxzNlA2bUt0Z1RFMXN3Nng4YiszZ0s3S3JLR1pEZFJmS05B?=
 =?utf-8?B?b0VSZWVDUndDTmJiT3JkRGo0Vk10RlBZQkpuS0NDRFdYRU4rZ2FkdHNjaVVm?=
 =?utf-8?B?cjlTc0xuVC81dU1GZktTbjBqalhZclBrcGluNHZ3cW03R0lhNmZxUjlRT1g3?=
 =?utf-8?B?ZEdGZ1BNZVl0UmZkTGxiWEVuQ1I2SDJFMG0xRzNITXM5YVozbk1ocHl0dU1s?=
 =?utf-8?B?RFY1aUZYTTZBTmpCblpWUUtIbHB4Ry9BcERaelBkaHdmOStQaklNTzJvNzFG?=
 =?utf-8?B?cDNUOStKeldLcmdpNVBPbGpQdDQ3VFc5QVhvUUZYREZWZUFWNkE4S0NNd1J6?=
 =?utf-8?B?Q1VlRXNDRnREaGl1K3YzejF5NXArSVhJajBWalpFTVkwOGR5Z0drWnpScWUr?=
 =?utf-8?B?dlhIU0c3M0I5YWFObXdiV0pQKzRPU3JYZHAzemVRZnZIQTcyblh5UU8xRlo0?=
 =?utf-8?B?b3B1aXBRMVdkT0doaWZ6emR2MXplalRmUmxEL1lOSzM4SGFTZnFsYkVRQzIz?=
 =?utf-8?B?REx5aTRuMjU1Z2d2N3pISkdjek4rVjNoOVl2ZFBrMy8wK1NPZE53RXpna1Q0?=
 =?utf-8?B?QjRiRnNQUlp5dkQ4OVpPY2lDOW0xb0o2RmF0WjN6K2NCY1BGMDJRRUZKN2FF?=
 =?utf-8?B?MVYyV2Z1dy9wRUovdWIxRDN3aHdTVjJvKzFqeE5xa0Q0Q21JUzB3Y2NGdHhJ?=
 =?utf-8?B?Q0pPUGVxbDZrWTM4MVIzcmJ2cWNJdHVwWTQvbUJlSVViTS9Cb1ZtMitYaW9P?=
 =?utf-8?B?ZlBDZHVXbkZGNEhkUllQOXRLY3N4QnpSU3FheW9TUXhPWUp0MW1wbDh6Risw?=
 =?utf-8?B?N0J3Rm9rbVI4NE5VVC90aHhaNnNuUjh2dTVBL1hYR1NUSnV0T0o2Tk1mbTlK?=
 =?utf-8?B?UXpYUWJkMlQ0NDNkbXdpQ0pkc1FCWGxJcjRDY2RRWmx6V3BkTnNtaHVnVW15?=
 =?utf-8?B?QkJwaTVEYkcvdWFHWlFwMExuS1ZwS2tDWm1ySkp5RU01MnhrekhzeUlnV0Fr?=
 =?utf-8?B?L3cvZkhVNUJ1c2JEcHZjUy9xeFdMOVY2djZ0dWcxYURBYTVQc25tUXlJZFZ2?=
 =?utf-8?B?bWJ1d21tSTlIMHdBenZDUnduaXF5YWF4L1lSNlNsWFhCZVJzd1J0RG1mVGxp?=
 =?utf-8?B?WGJzWGI2L0tUYUNudHRLUzZ6NkRic3dESTRONSs5TmZHQzVPb1lYYVBma3JH?=
 =?utf-8?B?cGRYRUs2UGl6TkZiM0VqQTNoNnV2ZTJUWjZFR2poSDErdFlMdWQxQ2tWT1R1?=
 =?utf-8?B?SUM1S1FhU2JURU1yNmR1Uzc0SElhRkJlUi9COTZYNlZUOSt3VkNDanVpd0k5?=
 =?utf-8?B?Y0xKOHRDTXpKcm9FWGwvZ0VQSC9YTW5oMHlYSi8ycndaeDVmTGZOZXNPbFlo?=
 =?utf-8?B?ZDhsZXluKzdSc2x3UFptODI4WklNaFVUb1JCM3lMWkpRdWp6elRxNWVQcEM2?=
 =?utf-8?B?RElRd0tqWTBGUmdkY2N2dmM3dEE3R0JXbThNa2orUVU1Z1UrSGtUbDZMRHJj?=
 =?utf-8?B?ajROem9adVpyMm44VGQrZWEwVGhHalpCNEF2MEtjY0krYjdxclQ4STVVVzJp?=
 =?utf-8?B?RTJBbzJRT24rYWxYeXNhL0dHejJjd2RTUS90QzU1SWtreVlURlN1TzZXQmF4?=
 =?utf-8?B?U09Rb3lFWUlVZHAwQ2JMaEF1KzczZnMwbFNFOEpiYytMS1dHK01ZWTFXV2Yw?=
 =?utf-8?B?amdJYkdvbk5sU2ZjS2lJM2VRQ2RHR2FKUVJYZ0ExSkQ4NUFyUzJMRFA1NTMy?=
 =?utf-8?B?YmJBdno2dTZsTm9SYjN5cHBnVktjd0FZQ2pRUjM0dWovSHY2bE4waWNpTWRC?=
 =?utf-8?B?aHREK1gzT1U3bXkrSm41bXJpNktOVmpyRW1oRm1ITzNRVHp1Q3FpYUpDRjUz?=
 =?utf-8?Q?FJ37SpJ/VyylMwWX44wc1AHeT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfbb486-d148-4a3f-12e5-08da7a465141
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 20:32:45.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNBjd6l4C+rTnygN0ZgGhEQ32FAaawziGSH3LlY0ksJiaNxpuGjOe0iy4BoAiTEIG+wFz7MdOREL0WhWK5cOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090076
X-Proofpoint-GUID: o8z4j5sxOcHi0prQl9uqZBWy-Lg_CHla
X-Proofpoint-ORIG-GUID: o8z4j5sxOcHi0prQl9uqZBWy-Lg_CHla
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>
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

CgpPbiA4LzkvMjAyMiAxMjoxOCBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+PiBGcm9tOiBTaS1X
ZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5
LCAyMDIyIDM6MDkgUE0KPj4+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5j
b20+Cj4+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgMjozOSBQTSBDdXJyZW50bHkg
aXQgaXMgbm90LiBOb3QgYQo+Pj4+IHNpbmdsZSBwYXRjaCBub3IgdGhpcyBwYXRjaCwgYnV0IHRo
ZSBjb250ZXh0IGZvciB0aGUgZXZlbnR1YWwgZ29hbCBpcwo+Pj4+IHRvIGFsbG93IFhEUCBvbiBh
IE1UVT05MDAwIGxpbmsgd2hlbiBndWVzdCB1c2VycyBpbnRlbnRpb25hbGx5IGxvd2VyCj4+Pj4g
ZG93biBNVFUgdG8gMTUwMC4KPj4+IFdoaWNoIGFwcGxpY2F0aW9uIGJlbmVmaXQgYnkgaGF2aW5n
IGFzeW1tZXRyeSBieSBsb3dlcmluZyBtdHUgdG8gMTUwMAo+PiB0byBzZW5kIHBhY2tldHMgYnV0
IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPwo+IEJlbG93IGRldGFpbHMgZG9lc27igJl0IGFu
c3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQo+Cj4+IEkgdGhpbmsgdmlydGlvLW5l
dCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBhbmQgTVJVLCBpbiB3aGljaCBjYXNl
Cj4+IHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVjZWQgdG8gZml0IHRoZSAxNTAwQiBw
YXlsb2FkIHNpemUgd2hlbiBtdHUgaXMKPj4gbG93ZXJlZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAw
Lgo+IEhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1YdSB0byAxNTAwLCBzYXkgaXQgaXMgaW1wcm92
ZWQgdG8gcG9zdCBidWZmZXJzIG9mIDE1MDAgYnl0ZXMuCkZvciBiaWdfcGFja2V0IHBhdGgsIHll
cywgd2UgbmVlZCBpbXByb3ZlbWVudDsgZm9yIG1lcmdlYWJsZSwgaXQncyAKYWRhcHRhYmxlIHRv
IGFueSBpbmNvbWluZyBwYWNrZXQgc2l6ZSBzbyAxNTAwIGlzIHdoYXQgaXQgaXMgdG9kYXkuCj4K
PiBEZXZpY2UgZG9lc24ndCBrbm93IGFib3V0IGl0IGJlY2F1c2UgbXR1IGluIGNvbmZpZyBzcGFj
ZSBpcyBSTyBmaWVsZC4KPiBEZXZpY2Uga2VlcCBkcm9wcGluZyA5SyBwYWNrZXRzIGJlY2F1c2Ug
YnVmZmVycyBwb3N0ZWQgYXJlIDE1MDAgYnl0ZXMuCj4gVGhpcyBpcyBiZWNhdXNlIGRldmljZSBm
b2xsb3dzIHRoZSBzcGVjICIgVGhlIGRldmljZSBNVVNUIE5PVCBwYXNzIHJlY2VpdmVkIHBhY2tl
dHMgdGhhdCBleGNlZWQgbXR1Ii4KUmlnaHQsIHRoYXQncyB3aGF0IGl0IGhhcHBlbnMgdG9kYXkg
b24gZGV2aWNlIHNpZGUgKGkuZS4gdmhvc3QtbmV0LCBidHcgCm1seDUgdmRwYSBkZXZpY2Ugc2Vl
bXMgdG8gaGF2ZSBhIGJ1ZyBub3QgcHJvLWFjdGl2ZWx5IGRyb3BwaW5nIHBhY2tldHMgCnRoYXQg
ZXhjZWVkIHRoZSBNVFUgc2l6ZSwgY2F1c2luZyBndWVzdCBwYW5pYyBpbiBzbWFsbCBwYWNrZXQg
cGF0aCkuCj4KPiBTbywgSSBhbSBsb3N0IHdoYXQgdmlydGlvIG5ldCBkZXZpY2UgdXNlciBhcHBs
aWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNoaWV2ZSBieSBzZW5kaW5nIHNtYWxsZXIgcGFja2V0cyBh
bmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUgcGFja2V0cy4KPiAoaXQgZG9lc27igJl0IGhhdmUgYW55
IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLgoKVXN1YWxseSwgdGhlIHVzZSBj
YXNlIEknbSBhd2FyZSBvZiB3b3VsZCBzZXQgdGhlIHBlZXIncyBNVFUgdG8gMTUwMCAKKGUuZy4g
b24gYSB2aXJ0dWFsIG5ldHdvcmsgYXBwbGlhbmNlKSwgb3IgaXQgd291bGQgcmVseSBvbiBwYXRo
IG10dSAKZGlzY292ZXJ5IHRvIGF2b2lkIHBhY2tldCBkcm9wIGFjcm9zcyBsaW5rcy4KCi1TaXdl
aQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
