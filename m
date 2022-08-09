Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D299C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75BA2408E0;
	Tue,  9 Aug 2022 21:40:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75BA2408E0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=toPsWt5N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=i44LnEtJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S87sy6SBFM3x; Tue,  9 Aug 2022 21:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20E12408F5;
	Tue,  9 Aug 2022 21:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20E12408F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E259BC0032;
	Tue,  9 Aug 2022 21:40:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E7E1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62BAA60E35
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62BAA60E35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=toPsWt5N; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=i44LnEtJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37QTSMqMrMJF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5ABD6009C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5ABD6009C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:40:12 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279LTXIl028174;
 Tue, 9 Aug 2022 21:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vC3G1vdDUXw08XbIXrDM0Z878xyxjWdHERXKMYSavc4=;
 b=toPsWt5NaoCLFJkviO22IqDTympGZ/YR22VY8dVzfly34LTkq0wgLkBZIxJtomjKMLrc
 KnRPUFlrjWJ4+w2VuFKEtQxvFsXOQ1mg12GtWKLK8y1PSWKWKyJQWDgH9LyOTMJmqmfM
 5uFupSV17FNNLM7AQkuPv8GtXfgmoXrCLWDADqVdpr4apKhUdom2Ba1jBraYnArMEwkN
 T0xmLroAvEU0fj/jrGThmy3xk+8EFpOqh3uluvFMsj3XsOvBRceaxzVFX6Fb22u7AFQL
 AW99Kb7hYcFgXa6QwXQxa2sdH4zqLjT+2F/G2dMEw9GhyISZszWAROHu6PuPEiZyBb9D Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdr9j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 21:39:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Kes1g005184; Tue, 9 Aug 2022 21:39:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqh31cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 21:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRl95X/D65b/5Pc+vMcYHi4CSX5Yn7ardV7USSr3KXyb/iQn6eqJjF83PTRNeiOmSij7SmtGtN3IK2b1PgsEXB0tiZARoe8YmkFGHfu1D3SzqBBo4k8aWzECMOjKEozFF0XCG3h/xvP0YusUh2Chl6PyNdCm352CE5SykVpEbS5Y9Bo91FC9znJ4WosrWJ9BmZpqTooEm/oOY9DnwDWD2j6Dgpd8KpY4wADebHlvxH3GmOrtTn1GA1DjEBN3sjWt1bOfNC8E5UGJr5AQFUB7Zi+UpBFPUyuTRL8hqfhEBCWR+onu/RrwLuP5MkIIyOvkupCLh40Yd6kgDOikl4X6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC3G1vdDUXw08XbIXrDM0Z878xyxjWdHERXKMYSavc4=;
 b=JcwAIPEHAMjq6QztTPXcB6nGSl3pg9iltTHmVVvjQZ4WxoXvyZ/4d6oiQRNNWWT7eGQ6S2CbG1eTcPBn5Q7IrCpXUy5iPutUUafLuWNJOnXg1Guabux4SD17i85p66Bc00Q7j5ez6CeBKynZgeaWj/GztEq4HiLeHpFK4+l3VkZ1IOr8JnVyQ9am0W5HYw3sSyZ+786KBzZRwzWv9c/Kb8iAIS89fZ2Q3eO82NxrEEZbi0rl62FCXjDkImtQ5zXM23S9H4vsEMJtv84q2u+zrz2z5sSyfeUJNI0MPyYOI/wy9e7anFmPWwJ06H85Y+YQiVuatCUKDUW7YEgcHHjWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC3G1vdDUXw08XbIXrDM0Z878xyxjWdHERXKMYSavc4=;
 b=i44LnEtJOBSsB++jhWClf3oXC8IOMN7eW5DSIQH+W7luIxaI/5Fj3ZAwC3iUHArLezMMgCZc5GG0vNxRlqMNFj604cqZCGlij4559NQrRLTTWy8VQQTgIdfOwjCDYmxiXanuotPJSWQEj5AsouvLJqkoM7o4wrVeAyzjFZdgdZU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM6PR10MB4218.namprd10.prod.outlook.com (2603:10b6:5:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 21:39:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 21:39:53 +0000
Message-ID: <866794a0-a3a7-c097-abff-f544a9b6cc54@oracle.com>
Date: Tue, 9 Aug 2022 14:39:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <20220809173305-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220809173305-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37813fbe-2a3a-435b-ce9f-08da7a4fb20c
X-MS-TrafficTypeDiagnostic: DM6PR10MB4218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Es9JRoN5LaSO4XUz1IJKNsPJjXELfqLoLM2h7JS/EHJ+ioG5Tv3m3qSpJepugULnyb6HT+iCeK249XOo1bgspb5GKyLkmu0t1dl3etS0bZk6k6+Cr1x7Sv8VDTkn04PWD1LZoVuCYLotnuaEBSPdZniO29Dk7rhyFdMu1Laa8Xb9/CZsrvadxawLKmo9chbcaipFcyyWWta2XDt8xJonqy9cyKgd8UnvokDIf4HFxE906w9CbvWBiXxHimVyQKZgLxbix8dNYGI7JaceoLFasyt+xXOInzB1x9cWPOGvNjGLNb5bPK+oJvspsH5JZeKaUUHLyet83wVHoJiCBt5P7mowjpQlkh06nMYhIVdVt38iU6QDHUbCd9EaPxIGykeNLoH5VTkDBFNAl3HtnZkOFvQzL5E+5r8WyLv8nT8w3eCp7yR0ulHXM9nE+3syV/ox7WwoMVstWabBbhKLa2K+uba9QkUb5I9Qmf8AdoqtcHWg8VpLPSrQvtpB4CREFGqanU15MUcQnbrx/o3wUXigjPIOMbCvbytZHjGBmkPZkTri9P8rnFRL5090Fe59HYHtZL6jH5gUdcgBPTJmpkeVjyDn2BHYX0dPHewnARm2EeILZNjBtHgFM8x4nsINgQGRG34gXQC9c2f+PHGEYsdyz3gYEhfnmNIGdd8My7rriqnuOIzbUrfUowkHxjF4KdrYVLl4KW3H4QuMEO9iz1OXcSOW3gEplUCy5qJTthRs5cQGyQnKRUhI2G8jbQhYCzqWDFGBIG+DytIckifBWp8pjoBdb68fqxPzPTBcPOqRSFkqElquNQSEmaiWh2xckrNUazJjNWMbCRGu30syYO/mtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(396003)(39860400002)(376002)(346002)(136003)(66556008)(8676002)(5660300002)(66476007)(4326008)(66946007)(6916009)(316002)(7416002)(8936002)(2906002)(38100700002)(31696002)(86362001)(478600001)(6486002)(26005)(36756003)(41300700001)(54906003)(6666004)(6506007)(6512007)(36916002)(83380400001)(2616005)(186003)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THhOYTdBcTBuR3BLOGZRQm1DSVRFNDNYczZBMXdPdkY2eEw5L3dOTC9FaDZI?=
 =?utf-8?B?aGlpSmNKeXZOK1BwMGRnaU5yMXR5czhJRnE5c3hvMUF4eE14aGxOcjlhWm51?=
 =?utf-8?B?YUw5ZGp2TmJkMXlIYjZOMXZ0Q0ZyN1lyaUt5UWdPQmZEMncrQkhMK2ZiZ1kv?=
 =?utf-8?B?azE4TDgxeFEvYmFITzQxdjhBbk1tQWE5dUovRTVSbmovbU9mWFJQU0oxTjcy?=
 =?utf-8?B?ZkRWeUVNcFNqMWxqSXhaeGpuYlU1U0gzNVhFMnJ0YXRFdU9WMHIraE4xY1l1?=
 =?utf-8?B?SmN4NGFjR0VHd1ZkQ3Bkbk4xcGxsWUxPbk5PUy9Say9BR3hndmdyaFVsUURF?=
 =?utf-8?B?bytZb1VBZkZTQU1zVTl1SkcrRzlXSFZ6STlUZnQyVUFMd1lNWTZ4ZDBpT3hp?=
 =?utf-8?B?ejRoK1dlaExTT0pyTk5QdXVleFcrbzRLWStsRDl1b0g4UkdjZTM2RHdWa0di?=
 =?utf-8?B?ckpncU5jOWlPOXAvZDdmT2tnd21taTBPU1U0cjMvT0ZjVzJPM0tua2JaczE0?=
 =?utf-8?B?OUp3TFQ1T1padTAyRTMrb050RVY0RUdTL3NSbjN1Szdjczk1VzRUbnN5cTZQ?=
 =?utf-8?B?NjBaWUlTa1lrY01uVDhDejVXdWJiZG91aTA1ZnNLZUxVN2VUam90SlhxQzFZ?=
 =?utf-8?B?MmhHNGhTQXBIejV5RGJJQTBRd0x6NkptcWNxMTZKYWVBRTA1UE04MEdMR0hS?=
 =?utf-8?B?cGJPNWN3RHpBWFlDeUxIT0xGbkZqY2o2WnBOWVpvanpPQzVZVWVEMlBwQVVv?=
 =?utf-8?B?WTJkNVNWdjdRbXVUQXRVY2NMbm1xcnM2OVBxUUZkMGhsakZvaFY1S3NXOG1K?=
 =?utf-8?B?MzRaVGtBUmo1bDB5SVRDQzlrck9oODRLYXp6L3kyL3BNRkxFNGZ5TEl1U1BJ?=
 =?utf-8?B?ZisyODN5UjV1UTE4Y3ozKy9lWGxTVC9tOVFMU2lvckx2NUVjTlQ0NHFnUUVL?=
 =?utf-8?B?Nis4aFJhcitQdFgrRnF0R3RseFFUeEFPZ0pud0xSdHhXeVpTVmdtV1YvYjB1?=
 =?utf-8?B?eU5Kd1M3V1hDNVpISlBVTDJpR0NIUG1JMjkxQ3Z1cG9ObHNDRzJmRngwTEE0?=
 =?utf-8?B?cXpaV2FsSzRRV1FQRm51S0F4a3JJVi9lNS9UZzN5a3RFb2Q2UnUzbTRFa3FB?=
 =?utf-8?B?MzZsbFVzMUJrWGJjU2FSdWhHeExIWGlMaytYU1ZBWSthTXV4cXBYTVdrYnJI?=
 =?utf-8?B?dWhvQUFkcHZ1bTc5T3dnd2NXanB6Y21ZYXFLOC9KdjZyazBRUVdMOFYzUWZq?=
 =?utf-8?B?SmhOZ3VmdWtKT1R1M0V5eERZN1hDQ0R0RDE3ZXVqcnBMNDlpUytKdnM2MkY2?=
 =?utf-8?B?MWtoYmlQVGZMRjVYWE9wVGZjQWFGOU9LQnJJOXRIdWlLQ3NBUTRYaHJxZkFZ?=
 =?utf-8?B?UUtUcWo5RWNsQmk2WE81aVM4N1hGMHpzYzNncm1aMmhWeGY2TG92QW4ySVli?=
 =?utf-8?B?Q0xFTkRIeHh3dHZLazhTY0FYWVhHd0tPU0djQkY4eGR4Y3VzOVFsN042OHFR?=
 =?utf-8?B?Z1NnbkthUVhmekJKSk9GK0p1NzZ2UzVIUTIvT2dNYkgwWlZxWXhWM1ZFYUZS?=
 =?utf-8?B?RWJFNFdqSU1DVWQxWGZ2djlDR3ZORjlybEkxNkFTQndSQ0ZGZU1QUWc2VmNq?=
 =?utf-8?B?eXhsS092VGpRMTJtMkxiK0JjMExLM0ErWHRlcDBXekZkcGg3U1FBZDZlMWdm?=
 =?utf-8?B?N1AwZnRwRk1xVDBzaFdSNy9NTnJFWmtORExubmhpdzdGcHBKRlp3TnVxcEl1?=
 =?utf-8?B?ZVpCOVZPREg1THI3aXdzWDlCR1B6MS9GRFFLY3lBb1Jrb1BpT2pORFFrYXJW?=
 =?utf-8?B?SDRMMFdsQzBER2doRjBjUUc4Y1dYU3p5a3l4MUVOSUVhcUc4Z3dvSXl3TVA2?=
 =?utf-8?B?c1c2NExmbnlUOFl1UG9XNVg5dmV3bUVlbWF5MVg2S0VPYzBnTDU1Q21DcWVa?=
 =?utf-8?B?QTI2V1dsVk1GaGxENFNrNG5DMWUrbFJId0Z1Z3hQQlY5MjJHTXJUMEZVVHlw?=
 =?utf-8?B?ckdVNlc1dmlRWlZKL3o3MXFBSU81NTNTVTVsUnRiTmVaN091dkNpQkVGR2tF?=
 =?utf-8?B?ZHB3aWtDNEhBcW9WOFFrMGYwSjU2dElZdWhORTBVSUVRZ1RxMmw0VTJ3a0VG?=
 =?utf-8?Q?X10rIT/YFvsy0SHN/ZBObI4uK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WnhBUmgrNEl2UmZhU1gyYkQ5dzU5bzBvb1NSVE81ZGtVQytlMTU3WFlmYkI3?=
 =?utf-8?B?U3JuRUI4cnZKbDduVzNKVHNBdUpQSDdOeVhlWm1vWU9OVFI5S2IrUVRDMTB4?=
 =?utf-8?B?VjU5d3ZmaldUWitaSGFPTWpZV0Q4ZmM2Vmg3dVJvWHd2bGM0VkVmNE9mbmp0?=
 =?utf-8?B?Ym0xeVZyNHlXNW0yWCtYZlZyTUdkS0M1UHdFd2owNTVyTWVYNTJIVWxHeFNC?=
 =?utf-8?B?Wm5PQUxNNmJaa1BFZ0tyZUZjb29NWVg0dXV6c2dYd0hpamxCUXpiVVFUSC9P?=
 =?utf-8?B?RmZqQ3JreWVLUGJvUE42Z0IrODdjYkEvMmRJYXlpVVdwMlFqTGkrL0t5M0M5?=
 =?utf-8?B?R2lpZXBqbG1lTWN4emVMd3ZhVjlIbjJyV1FsUFR2cnlLSmhwU0JMaFhwdk95?=
 =?utf-8?B?TnlpR0JVOHluVHg4ejQra3E1OUVOZzRrUXlEckNMQjcyY2tuUUpVaFYvK2tL?=
 =?utf-8?B?a01nTGJBVlN2cU5zQUVieFUrd2JEMnIvUENkRGNIWVd6c3BSNzlualNCVUw0?=
 =?utf-8?B?OXBqZzJ2b0VoQ2M0Q2tzTTNlUkJoeTBPUFdKcTMvaVc0WWFaZmVIQzBIYURL?=
 =?utf-8?B?UG9XakV2Z1RSR25RaWQxb0gyV3NCMUUwV25VKzlaNk1JbVFpV2NGQzE0aGhU?=
 =?utf-8?B?L3BXN3pxN2M5c01NWkRQZ3pwSGUvNUNDMGpMR1pmZ1F5dGVid3lYVzlDUlA3?=
 =?utf-8?B?UForVWtNT09yYUM0ZkUrMUhTQkhjNXdrSmlHaEcyY0V5NG9ydC9lSXVaN0hO?=
 =?utf-8?B?VnVzZVNvdmljVnJjM2dWcTdiVHEwM0MrcC9KRGc3ZnZIM25pR2h0NklnSU1S?=
 =?utf-8?B?MDV2RWlpZEpVUStrdUE4K1pqYnAwTmdHb1lzS3htTGtLeklENnl2cHhYS3hj?=
 =?utf-8?B?WHFBcWVkTHdHWUpick50VUo2bmp3L0d5a0FTRVR0YUg5cnR3ZzAzczByL2R1?=
 =?utf-8?B?Qkp3ckwyRm9ncnpIejczbWIxNHk2a1BJaWE2Rjc1c3hTM0pqUllCeXBra0dI?=
 =?utf-8?B?MjhNdlBOb0dHV3lPRHlPRk1uYy8yaUZTdlU0VDE0QlNjdkF1bVVFTlVMWU04?=
 =?utf-8?B?YmFqQ0lRa0g2cnd4SjQrU1hLTHpzdWtobU5DcER4WU8yNVBYUVlyRUZ4NGF0?=
 =?utf-8?B?dE9YeFMvaHFYUjV1TTNIbVQ3YkJXdFRBRHFvY1JJRWpERWg4Z0xFMlhnbFU2?=
 =?utf-8?B?RGpMc2dBWnQ1eGwvYUMydHZrU0E1OE1wTEVJcWwveDl5ZERURVd4K0NkaEND?=
 =?utf-8?B?ZXVpS2ZFb3gvRTg5ZzlhSGZjM1VyKythUFVONG5EeWw1RVltZDhyejhBQjdL?=
 =?utf-8?B?SGdHWTZjZGowbHZVMmtlN0FwbjNYM0t5eXRMdWw1WVlCaTZyN3JFQzlCdTRG?=
 =?utf-8?B?U1o1Nms1WmZXSXdISzdEU0oxN1Rwc1QrVmtDOUw0MXNiYmlzZ0huOEN2b0RK?=
 =?utf-8?B?T3hwejdYOEdDSklNQnBWK3g5QWdMMmI0bnlEQ1NmaHIzaTJxS3FSemhGSGlX?=
 =?utf-8?B?T2Y1KzRGT3FLa3cxSVlGV0dBM3pyZjNlbkp1RDI3Yk5qVnBrOEtQMDUxbG1x?=
 =?utf-8?B?ekVTbU9GTUp6eHZhMDlYMEdsNmk0YitvenFxTDQ4WmhIZlFyWU1vbi9NaTZS?=
 =?utf-8?B?bTI2Tkwwdmc5QkZQR1h0Zjc0U2dORXRCRnMxdlNZbmF3S0pzZ2ZrVzU5OXlW?=
 =?utf-8?B?bXNkTzE5UE1zTEVLOFdjd3Q5aHJvRVM1QVAxL2xjSk5OQk54d2R4eXlSSmxH?=
 =?utf-8?B?cldXWlg2SVVXd3VJRlZpd2plbHU1b1dETHZqWUs5M20yYk9wQlJ3RkNpK2d1?=
 =?utf-8?B?cS9mUnJVZENHRThzZnFOWCsxbU5HYkcwZlRVSHJITlpxY2JZanZ3b2dqOE9R?=
 =?utf-8?B?SjlBR0IwNHRSZm5lKytXdkpsQUhWZzYvOEl0SVc5emJROGxYd2J1dmorWmlj?=
 =?utf-8?B?MGE3cU9WQmI1RlhTdFE0ZTVxWkRrdlJMWUc0N3QwaGw0VEpRbGgyZ1p2cHp2?=
 =?utf-8?B?MW9rNGFGMzd2WDlzNXJ3QllZRys2OWswZ3hyeXhlUkdzU1F1VitObEhvSmRT?=
 =?utf-8?Q?ZU3xOi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37813fbe-2a3a-435b-ce9f-08da7a4fb20c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 21:39:53.6097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg4lWFjzgvPLkADtxnXAFapwAiI/yZjGuvcz33R94b1medLSK8UPYJP4TijlHIAW7YDyN/qQoH/Z4HxCHtAdbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090079
X-Proofpoint-GUID: TasMFpdrczBa-5rwzvqsSpw1OYF20w9P
X-Proofpoint-ORIG-GUID: TasMFpdrczBa-5rwzvqsSpw1OYF20w9P
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 kubakici@wp.pl, sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
 gavi@nvidia.com, virtualization <virtualization@lists.linux-foundation.org>,
 "Hemminger, Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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



On 8/9/2022 2:34 PM, Michael S. Tsirkin wrote:
> On Tue, Aug 09, 2022 at 11:38:52AM -0700, Si-Wei Liu wrote:
>>
>> On 8/9/2022 12:44 AM, Jason Wang wrote:
>>> On Tue, Aug 9, 2022 at 3:07 PM Gavin Li <gavinl@nvidia.com> wrote:
>>>> On 8/9/2022 7:56 AM, Si-Wei Liu wrote:
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/8/2022 12:31 AM, Gavin Li wrote:
>>>>
>>>>
>>>> On 8/6/2022 6:11 AM, Si-Wei Liu wrote:
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/1/2022 9:45 PM, Gavin Li wrote:
>>>>
>>>> Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for big
>>>> packets even when GUEST_* offloads are not present on the device.
>>>> However, if GSO is not supported,
>>>>
>>>> GUEST GSO (virtio term), or GRO HW (netdev core term) it should have
>>>> been be called.
>>>>
>>>> ACK
>>>>
>>>>
>>>>     it would be sufficient to allocate
>>>> segments to cover just up the MTU size and no further. Allocating the
>>>> maximum amount of segments results in a large waste of buffer space in
>>>> the queue, which limits the number of packets that can be buffered and
>>>> can result in reduced performance.
>>>>
>>>> Therefore, if GSO is not supported,
>>>>
>>>> Ditto.
>>>>
>>>> ACK
>>>>
>>>>
>>>> use the MTU to calculate the
>>>> optimal amount of segments required.
>>>>
>>>> Below is the iperf TCP test results over a Mellanox NIC, using vDPA for
>>>> 1 VQ, queue size 1024, before and after the change, with the iperf
>>>> server running over the virtio-net interface.
>>>>
>>>> MTU(Bytes)/Bandwidth (Gbit/s)
>>>>                 Before   After
>>>>      1500        22.5     22.4
>>>>      9000        12.8     25.9
>>>>
>>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> ---
>>>>     drivers/net/virtio_net.c | 20 ++++++++++++++++----
>>>>     1 file changed, 16 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index ec8e1b3108c3..d36918c1809d 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -222,6 +222,9 @@ struct virtnet_info {
>>>>         /* I like... big packets and I cannot lie! */
>>>>         bool big_packets;
>>>>
>>>> +     /* Indicates GSO support */
>>>> +     bool gso_is_supported;
>>>> +
>>>>         /* Host will merge rx buffers for big packets (shake it! shake
>>>> it!) */
>>>>         bool mergeable_rx_bufs;
>>>>
>>>> @@ -1312,14 +1315,21 @@ static int add_recvbuf_small(struct
>>>> virtnet_info *vi, struct receive_queue *rq,
>>>>     static int add_recvbuf_big(struct virtnet_info *vi, struct
>>>> receive_queue *rq,
>>>>                            gfp_t gfp)
>>>>     {
>>>> +     unsigned int sg_num = MAX_SKB_FRAGS;
>>>>         struct page *first, *list = NULL;
>>>>         char *p;
>>>>         int i, err, offset;
>>>>
>>>> -     sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
>>>> +     if (!vi->gso_is_supported) {
>>>> +             unsigned int mtu = vi->dev->mtu;
>>>> +
>>>> +             sg_num = (mtu % PAGE_SIZE) ? mtu / PAGE_SIZE + 1 : mtu
>>>> / PAGE_SIZE;
>>>>
>>>> DIV_ROUND_UP() can be used?
>>>>
>>>> ACK
>>>>
>>>>
>>>> Since this branch slightly adds up cost to the datapath, I wonder if
>>>> this sg_num can be saved and set only once (generally in virtnet_probe
>>>> time) in struct virtnet_info?
>>>>
>>>> Not sure how to do it and align it with align with new mtu during
>>>> .ndo_change_mtu()---as you mentioned in the following mail. Any idea?
>>>> ndo_change_mtu might be in vendor specific code and unmanageable. In
>>>> my case, the mtu can only be changed in the xml of the guest vm.
>>>>
>>>> Nope, for e.g. "ip link dev eth0 set mtu 1500" can be done from guest on
>>>> a virtio-net device with 9000 MTU (as defined in guest xml). Basically
>>>> guest user can set MTU to any valid value lower than the original
>>>> HOST_MTU. In the vendor defined .ndo_change_mtu() op, dev_validate_mtu()
>>>> should have validated the MTU value before coming down to it. And I
>>>> suspect you might want to do virtnet_close() and virtnet_open()
>>>> before/after changing the buffer size on the fly (the netif_running()
>>>> case), implementing .ndo_change_mtu() will be needed anyway.
>>>>
>>>> a guest VM driver changing mtu to smaller one is valid use case. However, current optimization suggested in the patch doesn't degrade any performance. Performing close() and open() sequence is good idea, that I would like to take up next after this patch as its going to be more than one patch to achieve it.
>>> Right, it could be done on top.
>>>
>>> But another note is that, it would still be better to support GUEST GSO feature:
>>>
>>> 1) can work for the case for path MTU
>>> 2) (migration)compatibility with software backends
>>>
>>>> +     }
>>>> +
>>>> +     sg_init_table(rq->sg, sg_num + 2);
>>>>
>>>>         /* page in rq->sg[MAX_SKB_FRAGS + 1] is list tail */
>>>>
>>>> Comment doesn't match code.
>>>>
>>>> ACK
>>>>
>>>> -     for (i = MAX_SKB_FRAGS + 1; i > 1; --i) {
>>>> +     for (i = sg_num + 1; i > 1; --i) {
>>>>                 first = get_a_page(rq, gfp);
>>>>                 if (!first) {
>>>>                         if (list)
>>>> @@ -1350,7 +1360,7 @@ static int add_recvbuf_big(struct virtnet_info
>>>> *vi, struct receive_queue *rq,
>>>>
>>>>         /* chain first in list head */
>>>>         first->private = (unsigned long)list;
>>>> -     err = virtqueue_add_inbuf(rq->vq, rq->sg, MAX_SKB_FRAGS + 2,
>>>> +     err = virtqueue_add_inbuf(rq->vq, rq->sg, sg_num + 2,
>>>>                                   first, gfp);
>>>>         if (err < 0)
>>>>                 give_pages(rq, first);
>>>> @@ -3571,8 +3581,10 @@ static int virtnet_probe(struct virtio_device
>>>> *vdev)
>>>>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>>>>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>>>>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>>>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
>>>> +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO)) {
>>>>                 vi->big_packets = true;
>>>> +             vi->gso_is_supported = true;
>>>>
>>>> Please do the same for virtnet_clear_guest_offloads(), and
>>>> correspondingly virtnet_restore_guest_offloads() as well. Not sure why
>>>> virtnet_clear_guest_offloads() or the caller doesn't unset big_packet on
>>>> successful return, seems like a bug to me.
>>> It is fine as long as
>>>
>>> 1) we don't implement ethtool API for changing guest offloads
>> Not sure if I missed something, but it looks the current
>> virtnet_set_features() already supports toggling on/off GRO HW through
>> commit a02e8964eaf9271a8a5fcc0c55bd13f933bafc56 (formerly misnamed as LRO).
>> Sorry, I realized I had a typo in email: "virtnet_set_guest_offloads() or
>> the caller doesn't unset big_packet ...".
> "we" here is the device, not the driver.
What is the ethtool API from device level? 
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS for sure, right?

It's implemented in software backend as far as I know. I see no reason 
*technically* this is infeasible, regardless what you name it, being a 
bug or TODO.

-Siwei

>
>>> 2) big mode XDP is not enabled
>> Currently it is not. Not a single patch nor this patch, but the context for
>> the eventual goal is to allow XDP on a MTU=9000 link when guest users
>> intentionally lower down MTU to 1500.
>>
>> Regards,
>> -Siwei
>>> So that code works only for XDP but we forbid big packets in the case
>>> of XDP right now.
>>>
>>> Thanks
>>>
>>>> ACK. The two calls virtnet_set_guest_offloads and
>>>> virtnet_set_guest_offloads is also called by virtnet_set_features. Do
>>>> you think if I can do this in virtnet_set_guest_offloads?
>>>>
>>>> I think that it should be fine, though you may want to deal with the XDP
>>>> path not to regress it.
>>>>
>>>> -Siwei
>>>>
>>>>
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>> +     }
>>>>
>>>>         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>>>>                 vi->mergeable_rx_bufs = true;
>>>>
>>>>
>>>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
