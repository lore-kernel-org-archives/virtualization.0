Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12637CDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 07:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66D2861068;
	Fri, 13 Oct 2023 07:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66D2861068
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=sal9BEGW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=d/s1IqvN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9k1ZjVx8F1yK; Fri, 13 Oct 2023 07:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFBDA60FBD;
	Fri, 13 Oct 2023 07:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFBDA60FBD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96D85C0071;
	Fri, 13 Oct 2023 07:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 138E4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D67D5402E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D67D5402E6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=sal9BEGW; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=d/s1IqvN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6oPnt_q3cNpF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:08 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C89F6400CF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C89F6400CF
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D7P95a029756; Fri, 13 Oct 2023 07:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=sal9BEGW26Bdnts8IvXoBlPJN+6CEofHJn8nHeb+Ri90EPIZhDAk9a4mN3DRblrMPCCR
 O3tXENJG2mgRr+PnGdLVSHihkL82Whm9DoY9DCV3ZyTrpes0k04I0rm5sidioLccqElE
 V4g9bzZDaXwszYwi8/ICQDW6QLGzPrXpZS/g10Up3qE0DTVNiYA4cYM751qv7ZDYFhv/
 u3CMojy7tc0kVSFwhmTGUNBjNiWuJmg430Plh5ZvbCuaVVCV7LURAqQbJjD6B5hb7rhy
 vjTsq9tMeDo6fe/7Z/omOXIalpsPCe5+8pZ4vEh4QjrKGQsZUMhF2JRedNJUB/pEacnv +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuvdhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 07:36:04 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39D5g46O039883; Fri, 13 Oct 2023 07:36:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tpt0tfnse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 07:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp4x4cynClyQlwhs2lbhMFzSkkniYAC7SyVghepCO2VgmCzQuA/hHBIADfCVgcNqmP+SV7NYzRJNs2KYnwhkqS4NPm7OfEkonBQ6Y/6+vm3x4nwFxUjx69cMs9cUD1pWi0LWjpXbPzoEC1yGl4D4tTXPm5C7qU8AImeNULTSpryp5GASV3Ar7xFqFvdo6AXcGV//ZpKyRLsfkh6XgZ7Gs4zQCGs8wT2rkg7WpVzo0fUkepq+bVFkZKHbWKqTYT/2htG4oknL64K+egwiUwjb30u55GTkEZtBzPHYFHrAhppXEv9OPUoJ5pPHmEU51eaD3nQZBNGKUgV5Dq9O8sW8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=QZZ8QWXwt2r0+a5IhZCSB83F9IUE7Ud3QHLmWR3eeE3BiJh3lIpIB5hvjNYzw2HPqpHzhxYlr9ykq7AG9wLjnhizH+XgJl9NXU7daOB8y+4LhZmcvUXr/XUKIQHF9ub9OT3d2mfE6tpkOKiJpAMKThvDa9/3wuutZ61wvhvD6S2Wvx1qf5u0hvVCy6sXOr/g9RvEIwdAO8OxIP8qxnZ75tFQvoSwPBY8Hs6HOEWdcjhYWt9dUKhDUBTntTmjaDmu6iB2MC5KY+aO0iBU6Gh4VvbKF1PLnzeZCke3vjC4SEqgu2GvfmycaI8yO6sv15iW9IJaT5O2hCoakYMdqReuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=d/s1IqvNc5ZTfE9mtqga939TLpNfCpcXFMC1uSXoPwEdFl/NHiccWnZtwnmShT+ZfpujI842kVjnTIvA4poSEbLjmobn3v1dFY9RwNH1GQz1Pq+MhDFU66WPBPgqmg5VmgbWJkbSxtZnGB2oreMbz6rhDaaiYD9QAp1qXFlBx1M=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 07:36:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:36:00 +0000
Message-ID: <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
Date: Fri, 13 Oct 2023 00:35:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 63262923-4538-488e-bf7e-08dbcbbf0b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFLmC0Px8IqU8QtMOGrOQSj+Aw7nHxOvW+6JsMoXdgmwEQkjYyO0agkLE2W/HfS9WLiztCwecNgcWCAnZB2jKA6lc6JVdAJXK3AT4w24IXS58z3x8BPjoK3q6z4RHrkDD5QlS87VoTmaJExxnlm/pbrrXjfYq0wLScEqoEuHHgvCX/uIM/jTCq8shauNHbXUQC3DrgQNY3AH2bt3i5sy4TJiGrVcljpvfGCNnvsZPIE+lVOZFKGRDZuUgF+JTibvfJ4/y0nF78taAGiismj8JlxgvL8eXJ7/tOAQe+ABcnk/Rc4XDKnYeN8KMhCSq79iu+c4Ieg+pYNuTrvRjDgydRbUu27OTHwx8ipKjPkZihZOgPpwGRr8DxMYvyKxGKbTmY4h8Rrzp5d0MyC62pbAgNT107mJw77OuB+mnTSloX7ngvrIlLEH0rm+1iRz56fWATS0ZGKBGy2uKPXPTUnuIWEoKFd/b9uedtNIwq2McUDK7iZBt4u1PlEYX4kOz/vQt79Z/kENFsAwcFzUqHMVaEb6qdFyNb6wjK+NE70lQJJcTsVbqkeezeL4ANmCK6DCJVF8elqo68nmevt2mYnbUJtM0iMRG+c6D8amzPJ+xElHiz3LxlCULmKYCfwqs46PfVFiD8s03DdNtX+nhzYd5wK5TYl53DjgMrMJyz87O0A2AADmdHJT2ccqwnNd2MaMWyj3vLlSaep/YQzjMW7rlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(6916009)(66556008)(66946007)(966005)(6486002)(5660300002)(4326008)(41300700001)(8936002)(66476007)(8676002)(31686004)(2906002)(83380400001)(2616005)(31696002)(36916002)(6512007)(86362001)(26005)(53546011)(38100700002)(6506007)(478600001)(36756003)(6666004)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVo3czJUMGNOWlpDU1pTTDk0SU5NQXB0RW1zdktqU1k0UG5taEg2U3dheTdU?=
 =?utf-8?B?dktyYzA4RWkyWnF2NTM4WEVvUVRBVHYwT3daVTNqZ2xPK0puN1RxQWRwYW8x?=
 =?utf-8?B?aGNpZHZZTys4QXlJaWEyRWdpVGR5aUllQzZYS2lieitoclI4UHhDWWZXYXBG?=
 =?utf-8?B?TEt5ZUVjeWlmOEFqRUF0VzM2bXNIS1A3QlRIY0NvckUwS2luc3NWTXhGRThm?=
 =?utf-8?B?dnJKMCtXcXBieGdHWUhCUE1KcEhRRzdYNEloZW0vMmg2bzZGbVlnWWcxeWdH?=
 =?utf-8?B?V1lIbytiRWhqK0ZUUzk2dGpac0RXUGplVWpKeGM3UW1ub0Z2UDQ4TTQ0a3Mr?=
 =?utf-8?B?YkQ2L214L2M4aVhwVzVhczU1cGQ2VHhYVUUwSHVuZ3NtRHc5NXNCWnY4T0Mx?=
 =?utf-8?B?Mm1NRXBNcUtqamszaUhZWlpWclBkcFNMeXF6R056S3dHdzRpeElNUk5qcElv?=
 =?utf-8?B?L01IN1pIOFYyUDBaVkxRb1gvWVpiRUlTY3kveGNNYWFPMngwVkFYek9hSUlH?=
 =?utf-8?B?Y2JFOGw2S1k2RTRKdTFUclNvMXAxRGNEdDZkMVJUNlVjVDQ3d3hJSTVjOGk2?=
 =?utf-8?B?eXd1TFFtMWRuTTJEeWdrL2s2bGxROFFTUkNNaEFhVkVtQkt0bDl2UkJvN0FI?=
 =?utf-8?B?NHFxc2Z3dXNiSEpoSDZXUThQVDJadnpjRlhDL0xlNHBEaDM5OXV2QlFpKzJ4?=
 =?utf-8?B?cnkycDVhdWM2Nm9udFJubGEzWmMzbGF0WndzMmdvejRIeUtIOEhZcWJTVURD?=
 =?utf-8?B?dVY2RWhwcWNvbTZpUnRtbjBJZlR3dVBBeUNwUVEvOURNbDN6RWliQzlia0NE?=
 =?utf-8?B?RkJYTGtSajdNeHVXYXJpcFQwOWJ0L2p2TWNnZjVwQUVDS2NmT2g3NWZVeEZS?=
 =?utf-8?B?aTN2cWxYT0E4dU9PeWpiZVY1bjEzRDhWVTJkOE1kZUI4bzVMc2NSazVPS1hp?=
 =?utf-8?B?RlRTSTBBRlFoQkhUZVhhS3NuRTE0ZkxWZDRnTHd4dWdJZXJreExiNWIrWkhR?=
 =?utf-8?B?KzRwaWJmQmF0V1dUY1NMOTFuTzFjQ25IME43R3k4TFEra0lmMllvUXhtcnJW?=
 =?utf-8?B?eDJxbEhJbG8zMW92ZEMxb2pja0lzK3hjTjl4c2gzalBtZ0NuTmlUMkFhL2h5?=
 =?utf-8?B?L0ZUWHZRbnc0dGhmcnlQZ1d4dm1UNzdPUkdzVXM2cW5HWWlJNFBTQWNjMW92?=
 =?utf-8?B?UUUzVTUvRVNPeC9WcmJxSG9SR21SOWZ3THFvQkE3QjJzQXBndDFPRldRUzdm?=
 =?utf-8?B?dGNzUy9JVlpRR0RBdVZhVmtFZjE1bnRWUWdrU3ovdVZHQ0N5VXlKd3ptMW5M?=
 =?utf-8?B?ZXF2WVRyczY3TFVmdnBqNFNzRFdGam1FMnBTQ2J5KzQwenR1RG0za3JLdTVG?=
 =?utf-8?B?ZEN5VkR4dzJoYnpjMVozaHNCelZ6US9sY0FGLzJOSXJyWTVrUXlxOXZZakZD?=
 =?utf-8?B?b1IyWFlBSGpMVlk3ZFVJN1FiVGhKVjFBUmVTcU9xNi9HT2NMZEo1SzlNaXFU?=
 =?utf-8?B?UVdVZU8xTGc1Y3N6dVpFMkNPZXRVSzh6bE1BbUNpNnJ6RG01QURyMTJjbUpM?=
 =?utf-8?B?cGxpK0x0NzJidXFTeEdXYUN4eDJWMXBHc0lyV1JaZTJVbTZmODRVZVRrSE42?=
 =?utf-8?B?VjNwVk1iMHRjRStuaG5MWWhiT3ZJU2xzcUQ5aUZVbnIzMW42NERqYVVZczFP?=
 =?utf-8?B?VGpLRG8xZHNhT2ltWFFRb1BwTVgyZzRJRUJBcC9qQlVSZ0M3Mjl6SC9QSkwv?=
 =?utf-8?B?c250WE5RNWcrTTFZZGl2eG1CaVFNajFuQkNMYy9XRmlmdUVmaGkwRmtXcFBO?=
 =?utf-8?B?MXVZN1QyMENYbGkwSytvOXJKdUFyZEZud2xvUXQ3eXd0ZGZVNHRMMDV4bmJB?=
 =?utf-8?B?bnJKblhLMkVISkcyeXk3emNyYUpaZzdBVDhHRW1qZ3hBcC9NbmdKaHpyUG1T?=
 =?utf-8?B?TG1aSGt6MVFoeWcyR2NDNWd6YmpWdHdJUElDeXdoOGhDNXJCK2hYUnFBZDBX?=
 =?utf-8?B?OWpoMXhuNVZFeUF0TVFTNTNUR3duTTM0NjhUSnJZdFdlSWp0SFd5VDROQUNz?=
 =?utf-8?B?Y1JiRGVtVkg4QTAySDJpaXRwUkFRa1BhWC91Q0ExNmVqQ0NNL2ozWVdXMkRF?=
 =?utf-8?Q?2lcyL3Y57dzTc5QbkqS4I2QV0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3p0ZXJ5TnBpWnZuTEtrQjBuZG1KWjRiNUVQdkJHTndYK3UyT0JnTUJjQWRx?=
 =?utf-8?B?cmhPT2l3bk53am5ZOU02disyYzEzNFpEWG8zS1NwTEN0dm9CYUZ2MmRXWGVT?=
 =?utf-8?B?OElTckRYMjRvNHM0YzhJUnRlSlV6T1V1ZUpjVUdPdlFmSFJZQ1YyMjBjcDUz?=
 =?utf-8?B?eVc3OEJVQytUcDk3WGxOODBnN3R0YkNnTGQ3WnNqN2JnUXlFR0ZDRlFYa1hx?=
 =?utf-8?B?N040TjhGM0J1TFVjd1o1M3RNaVVkTmt3VHFYMzNvUU1XalBwT2lzN3Fadzcr?=
 =?utf-8?B?NUgyZUxMMTdUclhlSE8xdjQrRTZDZURiRmttbnNFdEdKWFpWZHBiSUxvQXJG?=
 =?utf-8?B?YVU3N0ZPTjFOYXRwanJNc0x4ZEhUNzVPZXV0N3d1YW92UDF2QzhJY1FCRG44?=
 =?utf-8?B?eVVmd0dFMXJ6UE5TM05sV3p6Y2d5THh1QStYdUoyUGMzQjhBelc2eUdmc1RO?=
 =?utf-8?B?WlBETFJmZFhsa0FsU3hBcmRmZGlGdFZEeUpGc0ZVeHlzWE9FTWFicUc1QjND?=
 =?utf-8?B?cHRmZHpWd3ZiRmhOaUd4aVVJVjErZlpoRTVZUm5idG9CZGYxT2ZaR0JLOGxG?=
 =?utf-8?B?SndiNjlxS2hqRFNhbTVFRGhaNWJrODVib0tpRWtRdE5iVm9WWnI1eVRvYVZx?=
 =?utf-8?B?VnpPeW1OOFJMcmhEMktoK3EwY09wRHFYUTJzaWRFa0p0OHBSSEN1blNrd2ln?=
 =?utf-8?B?aDFXOTNJS0d3TUljRjN3UEc4b1BLWE45bDR3LzVKdjhwaTI2UnBWeVRlR0Fs?=
 =?utf-8?B?NzNVV2szaW9UZVVZK0h1dm9yenlzYTFNUlNQM1FzZnpvTWhzRjhtZmJrK2Fk?=
 =?utf-8?B?Ky9qWjdQcGp0NmhJQWdYb3lWSzBNcENFaEwvdUVzMVMxYzB6ZUkxQno0TXQ5?=
 =?utf-8?B?MFJhZlpscnVyUEtZaHQybmIxdlZhb0R3YVVZVEttTzNYcExLTG5tbjhmQVVP?=
 =?utf-8?B?S1dINkVnZWM0dFhVMUtvYi9nSWNGM01sRlJrUFRPZFpVZ2ExUXYvSmppSWJ4?=
 =?utf-8?B?cHMzMDVnNndrbDcwU1o2S0dCTkhIRTBNdXpGY0xlY3NiVXJ0NmkvN2d2cElS?=
 =?utf-8?B?VnBqNytacnA4MngvVVdtTW1WTU5IYXAxZXgrZTNONG1XM2Vpak12RmZONnJo?=
 =?utf-8?B?VVRtM1NpMEVybXhSZ3JONlVzUlRTazJ2cDI0cFNmZkJyT25XMVR0cnVtZVB1?=
 =?utf-8?B?b2I1Z3hoWVhsUWlLUHZXVXgyczF1NEpRdWx3Z0tQVGg5SFRnSjRBK1BJeURs?=
 =?utf-8?Q?Uzg+NL4xMte5aCN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63262923-4538-488e-bf7e-08dbcbbf0b60
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:35:59.4785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcwNt3D2TpdoOwdaGc51zU0MGRhJw1XoErdAQd7KgcL2benuGGk+OL6oatgCzvMyseGWRQhRHpYwPP0Rfa1cHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130062
X-Proofpoint-ORIG-GUID: LBvbscsEEMcAraFYj1ggEDlZ0QL_vA2H
X-Proofpoint-GUID: LBvbscsEEMcAraFYj1ggEDlZ0QL_vA2H
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

CgpPbiAxMC8xMi8yMDIzIDg6MDEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVHVlLCBPY3Qg
MTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+IERldmljZXMgd2l0aCBvbi1jaGlwIElPTU1VIG9yIHZlbmRvciBzcGVjaWZpYyBJ
T1RMQiBpbXBsZW1lbnRhdGlvbgo+PiBtYXkgbmVlZCB0byByZXN0b3JlIGlvdGxiIG1hcHBpbmcg
dG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBzdGF0ZQo+PiB1c2luZyB0aGUgLnJlc2V0X21hcCBv
cCwgYXMgaXQncyBkZXNpcmFibGUgZm9yIHNvbWUgcGFyZW50IGRldmljZXMKPj4gdG8gc29sZWx5
IG1hbmlwdWxhdGUgbWFwcGluZ3MgYnkgaXRzIG93biwgaW5kZXBlbmRlbnQgb2YgdmlydGlvIGRl
dmljZQo+PiBzdGF0ZS4gRm9yIGluc3RhbmNlLCBkZXZpY2UgcmVzZXQgZG9lcyBub3QgY2F1c2Ug
bWFwcGluZyBnbyBhd2F5IG9uCj4+IHN1Y2ggSU9UTEIgbW9kZWwgaW4gbmVlZCBvZiBwZXJzaXN0
ZW50IG1hcHBpbmcuIEJlZm9yZSB2aG9zdC12ZHBhCj4+IGlzIGdvaW5nIGF3YXksIGdpdmUgdGhl
bSBhIGNoYW5jZSB0byByZXNldCBpb3RsYiBiYWNrIHRvIHRoZSBpbml0aWFsCj4+IHN0YXRlIGlu
IHZob3N0X3ZkcGFfY2xlYW51cCgpLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxz
aS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwg
MTYgKysrKysrKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+IGluZGV4IDg1MTUzNWYuLmEzZjgxNjAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC0xMzEsNiAr
MTMxLDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqdmhvc3RfdmRwYV9maW5kX2Fs
bG9jX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgICAgICAgICByZXR1cm4gdmhvc3RfdmRw
YV9hbGxvY19hcyh2LCBhc2lkKTsKPj4gICB9Cj4+Cj4+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBh
X3Jlc2V0X21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIGFzaWQpCj4+ICt7Cj4+ICsgICAg
ICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4gKyAgICAgICBjb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+ICsKPj4gKyAgICAg
ICBpZiAob3BzLT5yZXNldF9tYXApCj4+ICsgICAgICAgICAgICAgICBvcHMtPnJlc2V0X21hcCh2
ZHBhLCBhc2lkKTsKPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZW1vdmVf
YXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQo+PiAgIHsKPj4gICAgICAgICAgc3Ry
dWN0IHZob3N0X3ZkcGFfYXMgKmFzID0gYXNpZF90b19hcyh2LCBhc2lkKTsKPj4gQEAgLTE0MCw2
ICsxNDksMTMgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3JlbW92ZV9hcyhzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwgdTMyIGFzaWQpCj4+Cj4+ICAgICAgICAgIGhsaXN0X2RlbCgmYXMtPmhhc2hfbGlu
ayk7Cj4+ICAgICAgICAgIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAodiwgJmFzLT5pb3RsYiwgMFVM
TCwgMFVMTCAtIDEsIGFzaWQpOwo+PiArICAgICAgIC8qCj4+ICsgICAgICAgICogRGV2aWNlcyB3
aXRoIHZlbmRvciBzcGVjaWZpYyBJT01NVSBtYXkgbmVlZCB0byByZXN0b3JlCj4+ICsgICAgICAg
ICogaW90bGIgdG8gdGhlIGluaXRpYWwgb3IgZGVmYXVsdCBzdGF0ZSB3aGljaCBpcyBub3QgZG9u
ZQo+PiArICAgICAgICAqIHRocm91Z2ggZGV2aWNlIHJlc2V0LCBhcyB0aGUgSU9UTEIgbWFwcGlu
ZyBtYW5pcHVsYXRpb24KPj4gKyAgICAgICAgKiBjb3VsZCBiZSBkZWNvdXBsZWQgZnJvbSB0aGUg
dmlydGlvIGRldmljZSBsaWZlIGN5Y2xlLgo+PiArICAgICAgICAqLwo+IFNob3VsZCB3ZSBkbyB0
aGlzIGFjY29yZGluZyB0byB3aGV0aGVyIElPVExCX1BSRVNJU1QgaXMgc2V0PwpXZWxsLCBpbiB0
aGVvcnkgdGhpcyBzZWVtcyBsaWtlIHNvIGJ1dCBpdCdzIHVubmVjZXNzYXJ5IGNvZGUgY2hhbmdl
IAphY3R1YWxseSwgYXMgdGhhdCBpcyB0aGUgd2F5IGhvdyB2RFBBIHBhcmVudCBiZWhpbmQgcGxh
dGZvcm0gSU9NTVUgd29ya3MgCnRvZGF5LCBhbmQgdXNlcnNwYWNlIGRvZXNuJ3QgYnJlYWsgYXMg
b2YgdG9kYXkuIDopCgpBcyBleHBsYWluZWQgaW4gcHJldmlvdXMgdGhyZWFkcyBbMV1bMl0sIHdo
ZW4gSU9UTEJfUEVSU0lTVCBpcyBub3Qgc2V0IAppdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IG1lYW4g
dGhlIGlvdGxiIHdpbGwgZGVmaW5pdGVseSBiZSBkZXN0cm95ZWQgCmFjcm9zcyByZXNldCAodGhp
bmsgYWJvdXQgdGhlIHBsYXRmb3JtIElPTU1VIGNhc2UpLCBzbyB1c2Vyc3BhY2UgdG9kYXkgCmlz
IGFscmVhZHkgdG9sZXJhdGluZyBlbm91Z2ggd2l0aCBlaXRoZXIgZ29vZCBvciBiYWQgSU9NTVUu
IFRoaXMgY29kZSBvZiAKbm90IGNoZWNraW5nIElPVExCX1BFUlNJU1QgYmVpbmcgc2V0IGlzIGlu
dGVudGlvbmFsLCB0aGVyZSdzIG5vIHBvaW50IHRvIAplbXVsYXRlIGJhZCBJT01NVSBiZWhhdmlv
ciBldmVuIGZvciBvbGRlciB1c2Vyc3BhY2UgKHdpdGggaW1wcm9wZXIgCmVtdWxhdGlvbiB0byBi
ZSBkb25lIGl0IHdvdWxkIHJlc3VsdCBpbiBldmVuIHdvcnNlIHBlcmZvcm1hbmNlKS4gSSB0aGlu
ayAKdGhlIHB1cnBvc2Ugb2YgdGhlIElPVExCX1BFUlNJU1QgZmxhZyBpcyBqdXN0IHRvIGdpdmUg
dXNlcnNwYWNlIDEwMCUgCmNlcnRhaW50eSBvZiBwZXJzaXN0ZW50IGlvdGxiIG1hcHBpbmcgbm90
IGdldHRpbmcgbG9zdCBhY3Jvc3MgdmRwYSByZXNldC4KClRoYW5rcywKLVNpd2VpCgpbMV0gCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzlmMTE4ZmM5LTRmNmYtZGQ2Ny1h
MjkxLWJlNzgxNTJlNDdmZEBvcmFjbGUuY29tLwpbMl0gCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3ZpcnR1YWxpemF0aW9uLzMzNjRhZGZkLTFlYjctOGJjZS00MWY5LWJmZTU0NzNmMWYyZUBvcmFj
bGUuY29tLwo+ICAgT3RoZXJ3aXNlCj4gd2UgbWF5IGJyZWFrIG9sZCB1c2Vyc3BhY2UuCj4KPiBU
aGFua3MKPgo+PiArICAgICAgIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+PiAgICAg
ICAgICBrZnJlZShhcyk7Cj4+Cj4+ICAgICAgICAgIHJldHVybiAwOwo+PiAtLQo+PiAxLjguMy4x
Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
