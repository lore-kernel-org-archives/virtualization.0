Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE37CC001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 22:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 259BD41A05;
	Tue, 15 Aug 2023 22:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 259BD41A05
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=r5dqh0uw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=otse1Mzl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3anbYQ5QzE0; Tue, 15 Aug 2023 22:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B0B541993;
	Tue, 15 Aug 2023 22:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B0B541993
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04D76C0072;
	Tue, 15 Aug 2023 22:31:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3821DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 22:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05D59611C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 22:30:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05D59611C3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=r5dqh0uw; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=otse1Mzl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDGa5nvyCxhM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 22:30:57 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2E68611C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 22:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2E68611C1
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FJjgnw028686; Tue, 15 Aug 2023 22:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=luREmoywbpAYDD7VQWltKV5q6+TZ2rVouSDhMvNstEw=;
 b=r5dqh0uwV6K0+s+n5rF88eYyfnCOraXQd3yynsELiVdzMWLkxoDqYoH5iGO8zRXKHU0g
 UH5eHfM8fUP9WCTeWYCMjJpGbmtkMH0Erxl+GgcTjF+r3cS0uThU4P2xw4IlfYyPFRGl
 NtLWbELgjfYyunxqazCpSW0nAyWyYxY7h0HeKp4pR0yI00NCVuoezOIrTgIR2LfT1nvF
 PnpfuVVjHN5/vIaawSHIZwfkxJF1JmVLZURfpRawiSnYFDbM8qmF+/gah/1Z3h1/ZjvV
 K1eQGmeRk/gRIqdnMx2mnTntG4H15Vb4MtZPhgt/lPKqg7XHvolpXgN8t3bwoJIJjmm+ dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30swurk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 22:30:52 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FLuPCM027423; Tue, 15 Aug 2023 22:30:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey1smw74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 22:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElZJTDPzlcZal6Hhd5Ea4b0h+mqh/eWD/ISTG5SosN9KnZEG+QxNNvzjRRBQcMgtCxXhRxjQxQLOIJ0JRanfkg5g3DlsMePVaZiloYaVIZgfEeREaEL+cGGUz25qsV+B214B9kBPUzbiZuyIDBgB3xUIQmtADo67tobCBgLd7JnruFtkriR8qH+tZ8Geg0jPB4ZcMsT1r9niBh4j7Cv05AXM5qWVPO/fKorGbjqxoCuV7k2+bVqrJKfb4RyEdSDvRBkbN0zDLNWr1FljSBXprCnGLOuNyln2PFlw12HRWngeITMB8h9n8p5QXV4ANzriHMSGS4P/nFNwBfBECzmVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luREmoywbpAYDD7VQWltKV5q6+TZ2rVouSDhMvNstEw=;
 b=FpW/bmY+0FPHfosi2uweBoM2P+VdmyYvQ6Db3tfkHCdD+qL7ovr1MEiieqB67tuN/q0qLc3VUZxbLMrFC7eGBbB9xKUeyKHBCyRj5hPMf3ubql/el9R9tKO6blYCDbvuqZrLeXJ+JRKA4e1hpE5zfwDY21bIjtoN2U/iu2FEcKMK6YlIbQnufhqnSlSq76pKshGv2yZcvAXcDsLZNWaSzLaCDG5jmPX6Tp8RXGj+eTX6nlW38aNG8wUIYgvqIV4VSF2KeSKknAw76gbvXISZreJu0Rja0Okp8L20djEfs52K2i1sKk+fcoFGGE/H+CA7pw7Y3v0VTh4w4/qpMz/f4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luREmoywbpAYDD7VQWltKV5q6+TZ2rVouSDhMvNstEw=;
 b=otse1MzlmSD44dwxXzC58OAvsR0PoFSfgaLu6Tm+c3Om2pRQWowmOhc33tvlhPtP85cPVmPfZ73zXReWbYk7t3o4HP+IeGIaaVAnVwK1GKTi56/4PFJ7a/WZ1y50xvm78p27ZFCMVicxS+LCZgB4xd2fLVk3Ph3RiZVD1M96/O8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ1PR10MB5956.namprd10.prod.outlook.com (2603:10b6:a03:489::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:30:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:30:49 +0000
Message-ID: <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
Date: Tue, 15 Aug 2023 15:30:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ1PR10MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0cc01c-fcaf-4694-2f56-08db9ddf46a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjvQ4ETFRQBIKvbIBIYIRWXAfj9D58z65xoK2fI1mjrey2uBjTAS9oxp+TGAvwr8BxNNCBWVw6IH6P2amrrlg3GbRpiwiXh31IPR+EE1kkWFK62EG/ZRCJ7OuuOp3YcMr3a9YcACPUGhir6A/eUGFCL+t58ot9uyo6ht1Ji0qc6gbbdWLPhF1mL9uVAoZ3B5SvD3CX7/xRhK0eZJz5j6qW7abvso77ZC/SaZHf1Gt+5RH3ODb3Ly9W4wKjZ/jAA3N7dzZVO6kqKnjyVH8RbRwOT3FSkMMqpPmlVSO1u0zzcs/Jy6qV9R1WtpXggHtn2UB8sCuq0opgB60r+GCU0qHXZwtT50BRKNmhgS1BKjAIQlRcUdOdzD6MH3ZMeAJ+E+qmx4VeTPM2EeVlgq34bdlHKuSU2YWEs1dyC/ovR4ec5PSgzsBoqVVovIugHsHzvZI16pvyRVFT9/Fs4PWg6tg3BsGgyZgaSFHhkTSDA2y40WuQ8Or3Ig6gSYYL6jR6aLASc1xwzNcy2ERSkySSruM2NbxBcBHAChWcb5nV/0uR7N9sjxjq4+eMXGbHXasZ1FpznoVAH0uPlLXrT2Pl/+ib5cZaZfAmHYscIdD00PShgSrg0Iz8XDHttkBfNLXo97wMJ3TGYxPMc0O1J0hSWPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(6512007)(6486002)(36916002)(6506007)(53546011)(26005)(6666004)(66946007)(66556008)(66476007)(6916009)(41300700001)(316002)(478600001)(4326008)(38100700002)(83380400001)(31686004)(2616005)(36756003)(2906002)(8676002)(8936002)(5660300002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdobklLQ2tyUHBsOHphNTV4cUxtaUF4anVlM2pZT292N3Y5bmE5Zk9GbU85?=
 =?utf-8?B?TTJQb3ptcVgrbGtnbmVmd2d4QkdGL0RHQm4xbzNLazd3R1BYMHpJQVgxbGxr?=
 =?utf-8?B?TXV5WTlVQzh1eGtFbFJIVTBLMHl2RC9UQ2NXSG9iOXZCNlRGNjFrMW1MaFB2?=
 =?utf-8?B?WjRlUEpRajRqQjVsaEdEM28wOEtIQjFmUU1PK0JscGc2OWtlWHVvUDBHSGZZ?=
 =?utf-8?B?VzFGZWFYWDRvS2sxMkFiRzA3M2VOR09HOXBEeit1dlpqbkVDWkNCdnFIQ09m?=
 =?utf-8?B?RWpFTGlxNkg1Q3ptL2RnU0hiU1NPSmg1UitZeGV3U2xhUGRCYlpjR3VFQTVk?=
 =?utf-8?B?UUltcVVpZGdDbGJyNTAyMFZvVkhkMGI4NWNMOEY2SStRWFhqRXRYa2UxdGpy?=
 =?utf-8?B?RTNOb0REVDIvVjVHb3VMVVRNYVZ6RmhpL3JXeklGVXBuLy8zRVlwS0tDM3NC?=
 =?utf-8?B?cVB4UDhmUEwvcTVmUzVYK0k5WnlBTXZFUis1VVd6Y0cyZzVwSXVhQzdmdVdN?=
 =?utf-8?B?c1hwNkVDY3FFbHlIbjhudzdqWEJ0WWNxT011elNZOGV4Z3hqMXYvK3NaQ0Fv?=
 =?utf-8?B?NEJXK3B4eVhBRW9OWkVSbm0rb1FpWXNwTkViWEZyOTFYZTZPdEVuQlMrT1dm?=
 =?utf-8?B?eVVVdlFja09MYlJ3MnV3ZWwrZ3FTdG5pa0FCQjh6MGZqL1ZRNGxvdXVQZjl3?=
 =?utf-8?B?aGV1eXIxYWxLcFFRU3pSM2xBV0trUmttYXJnTWp3N3VtUzhNU01RbFhqdlNN?=
 =?utf-8?B?S3cxVkFpYVl6NmpsdG5IRWdXN0FVY1dpSXk1UXFPOHBBVGRvUXlLUVpBdWdI?=
 =?utf-8?B?dUZjMkJDMVhZVkVYd2FNb0g2NmJDeEhMZERqaDh3ZlJQaTR2d0FQSStQNWF1?=
 =?utf-8?B?RlN0L1lqc0wwOWF4N1JxNlhkSDcvNWR4NDRCT3p3VE92ZENsUFVsWXVpL2Ry?=
 =?utf-8?B?bTBpVllrTjlVdjhib1dkQ2F6QzVFZEE5NDNoeHEvOHkwUnNTODRlRnVScEN3?=
 =?utf-8?B?RUhSbnZBZkVFemNKRlJFSzJ6YUExSFFSOU5UQlN5R2NZSlk0b2VXTG5jcnhp?=
 =?utf-8?B?cmg2cGNZYmN2dm1kV1oveUJVTVZRcERGNGZmSFVvN2Rob0JwR1ZpZWt6VGV4?=
 =?utf-8?B?bnFwZitqMWxGWnYvbHhBb2luZjd4VEVickxRRmVHQjdNSzdMZnVRNEJ5UmY0?=
 =?utf-8?B?bmsrZzcyNGM0aU8vQkJnRjYyQjFCSjgyZ0Jjd3RIQ1d6QXFmbGtOaEFZYXF0?=
 =?utf-8?B?Zjk4c1BMR3JFNzRLZFhqdmRyeVAzS1BzVFd5S21XSUN3NEFuS3YwN0l4WG1Z?=
 =?utf-8?B?QmFDNG9qV3ZzNDFWY0l5UHRiTUQ3azBJZTBqNERhOUZSdlBIRFkxQUdwQk9V?=
 =?utf-8?B?Z2c3NC90cGtobk1hcFB6NXI4M21ucDA2anNYMTRkL1gwdXoyV3d4RHgydE1q?=
 =?utf-8?B?cmNZUzhPUE14L0s0WEVxc01mMERxY21FeVJTMmpTc3FWNUhTb1lyRzUxekNC?=
 =?utf-8?B?MHFrU1ZFR3c0UkpIWklNQjhyeVB4dGFNM3ZLVTdkUGhldWlxY2Jhc1hqNzNF?=
 =?utf-8?B?bmQ5UnluRjBhWG1FUVc0bFdmc3kwWktvL1FROUE2R2RiR01yMG9nUEEvbWlp?=
 =?utf-8?B?OFNIUW4rMU5NSVduZ1NtS29uNElWM1lnOFFwZVBFbjBkSkJ3Q1k1ckxZQTlN?=
 =?utf-8?B?VURLQ0NIcElOYWZNaVpqQ2JJTU1JU1AyOTM4NTBWNEJsNHBaWGVNVkdCWVU2?=
 =?utf-8?B?Z1pWdnBTY1NDY0xETkl3SkExODRnQjNwdU4rbmFlVW9pOUhzbU8wWGJYS1Ex?=
 =?utf-8?B?QXNTS01EbzIvNmwwc21MbEJLT3Ixdm40MjlxREt5TEtIVHhwTTUyU1BGVmtI?=
 =?utf-8?B?VVVvZWlaZFNKYzVuY3k5NEVKYlFpM21rTjhWekFGTGttNzF1UHZSNGZoYWhw?=
 =?utf-8?B?ZHh2TU1XenQxa2JpdjdzWllpNXdHbmQ4TkRGaGtZSUhVWXhHM3o5VUUzN0p4?=
 =?utf-8?B?S25hM0VQQ2FUS2szMHZ5b3pJRVdkekVuZjAvOUljMEp6WmFERW42djhQUXQv?=
 =?utf-8?B?Q0Vxc01iRW1UenpaSFl2bjM0emtiK3RnYjhwc1dHQjJObUlNRHE1MzlHM21u?=
 =?utf-8?Q?YTrA8MUg7YFi0rjtyG/BGsyhp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TXVqN1BPbUErd0c3aUorWU5uYmVxODJjVU1JOTRsdVJQTWV6dzJ1ZWVyV3hi?=
 =?utf-8?B?cG5LaFdpa0F2T2lxMmE1RURDckxaWmFLVzduOWFESHZ4QlExNWxzT0gyMjJ6?=
 =?utf-8?B?ZXFsVFlROE8rVHZscVhBSFcxRlNBWFdnZW50a3JiWmcyTHhDZTBXK1BwTXFZ?=
 =?utf-8?B?bTRhOXFwK0FkekpRM2pROG9oQ3FUckR2RDJNWXVjQTlGMTBjQ2NmV3NLdU51?=
 =?utf-8?B?Wjhrbyt4VFpZdkVDbjUyNzF5cVFZZjlHZmVwODRPM0Vpc0hPSU05eVVZVG5T?=
 =?utf-8?B?Z2pwRmMvSmlpbjBUK3dQTU0yaWNTWWdjM1l1L2NCcEE0M0ZIMVlyU0t4SUdq?=
 =?utf-8?B?S2IyMnVWQ3RZZTRwMDliejlFLytsT0RheUtvNmRETCtQTHFRdGQ2MlJveHMx?=
 =?utf-8?B?NnZjaDNSWHJKaUtxSjZjVldqMnhmRjJ2VlRPYzRENEtzYnJIamtqTEkrUjNu?=
 =?utf-8?B?bjkxNTkxN21FYTBmWThlL1B0Vml1bktOK2EvU0xLNWNhRmxLN3prUFRYOXJ5?=
 =?utf-8?B?RjkzS0V0b3ZlMDNIKzcxMmZLYkY4ak00VG9xZU9zczJGaTFOSU5uRXZ5Rmtx?=
 =?utf-8?B?WGhleVRJNmFHU2IyWEVwL0NCVk9xTUxKWjZ2TC9kemtDTTNyTUVBRVRxcGxN?=
 =?utf-8?B?YjdadGRxYllJdm9lbWg3a2t3aTFDOVhHMXRDaTZuamQyVjdZdEk0clVEb1FS?=
 =?utf-8?B?YVVKdGhkdnB4cEZvL0pUUzVFeXdpQUQyNXAwbTY2MjFQWkVSbmpvZEJGdjhw?=
 =?utf-8?B?YTZlMGZsU1BlbW9yaUJlbXVPbi84a3Q5K0d3S3BTa21yY2RENmlHWDc2RWFa?=
 =?utf-8?B?MWNvK1Z1dGg0Um5ZQ0tERHVUendqbnh5ck9QWGZDcVU3VnMzK0FSbkNwbHow?=
 =?utf-8?B?a3hjdkhrRktCZW51SW1SOTV1bE43eGg0QmVVYXRFZnFSb205cnZzMFBIdVlp?=
 =?utf-8?B?SUI2WlU0MkhXandRdE83SHpPVlVtUW9VVzdySi9reW01Wm96TVpmbXVjNlE4?=
 =?utf-8?B?YWpLQWFJSVQ4WndkQUtvUDg0elRPOEw5cWZMTTVQV0lhd1A5eVJScHZNb2pV?=
 =?utf-8?B?WFNvV29PU2xKdmc2VWVvaWhZMDErK2JNUlF4S20zSVNGaUkxK0dqejlLQ0ZX?=
 =?utf-8?B?Y1Fjc0tyTkUxNFpFMUUwbEF1bEhreVE0MXc2ZnJhWGg5TElxQUkrRWsyamUy?=
 =?utf-8?B?VXlJZTMrSmVrZ2o1VElKbEhVYjVhVjJKYmFWTVNFbGVPbGswMFBrZ2JHV296?=
 =?utf-8?Q?K63O8Afs+YdOlVx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0cc01c-fcaf-4694-2f56-08db9ddf46a2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:30:49.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QO0y1op1mjl6VOlZC9yc877rN1vww/4+rrL3zPvLzzrZa3LLNszC60FyWrHdQy/DQznURjeLIrGNkN2Pqa8l3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150202
X-Proofpoint-GUID: qFrYB8uIiiG49R3jDIYiE3QbM-JqMUNX
X-Proofpoint-ORIG-GUID: qFrYB8uIiiG49R3jDIYiE3QbM-JqMUNX
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

CgpPbiA4LzE0LzIwMjMgNzoyNSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUdWUsIEF1ZyAx
NSwgMjAyMyBhdCA5OjQ14oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3
cm90ZToKPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE2ICsrKysr
KysrKysrKysrKy0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8ICAyICsr
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4+IGluZGV4IDYyYjBhMDEuLjc1MDkyYTcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC00MDYsNiArNDA2
LDE0IEBAIHN0YXRpYyBib29sIHZob3N0X3ZkcGFfY2FuX3Jlc3VtZShjb25zdCBzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdikKPj4gICAgICAgICAgcmV0dXJuIG9wcy0+cmVzdW1lOwo+PiAgIH0KPj4KPj4g
K3N0YXRpYyBib29sIHZob3N0X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKGNvbnN0IHN0cnVjdCB2
aG9zdF92ZHBhICp2KQo+PiArewo+PiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9
IHYtPnZkcGE7Cj4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0g
dmRwYS0+Y29uZmlnOwo+PiArCj4+ICsgICAgICAgcmV0dXJuICghb3BzLT5zZXRfbWFwICYmICFv
cHMtPmRtYV9tYXApIHx8IG9wcy0+cmVzZXRfbWFwOwo+IFNvIHRoaXMgbWVhbnMgdGhlIElPVExC
L0lPTU1VIG1hcHBpbmdzIGhhdmUgYWxyZWFkeSBiZWVuIGRlY291cGxlZAo+IGZyb20gdGhlIHZk
cGEgcmVzZXQuCk5vdCBpbiB0aGUgc2Vuc2Ugb2YgQVBJLCBpdCcgYmVlbiBjb3VwbGVkIHNpbmNl
IGRheSBvbmUgZnJvbSB0aGUgCmltcGxlbWVudGF0aW9ucyBvZiBldmVyeSBvbi1jaGlwIElPTU1V
IHBhcmVudCBkcml2ZXIsIG5hbWVseSBtbHg1X3ZkcGEgCmFuZCB2ZHBhX3NpbS4gQmVjYXVzZSBv
ZiB0aGF0LCBsYXRlciBvbiB0aGUgKGltcHJvcGVyKSBzdXBwb3J0IGZvciAKdmlydGlvLXZkcGEs
IGZyb20gY29tbWl0IDZmNTMxMmY4MDE4MyAoInZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIApy
dW5uaW5nIHdpdGggdmlydGlvX3ZkcGEiKSBhbmQgNmMzZDMyOWU2NDg2ICgidmRwYV9zaW06IGdl
dCByaWQgb2YgRE1BIApvcHMiKSBtaXN1c2VkIHRoZSAucmVzZXQoKSBvcCB0byByZWFsaXplIDE6
MSBtYXBwaW5nLCByZW5kZXJpbmcgc3Ryb25nIApjb3VwbGluZyBiZXR3ZWVuIGRldmljZSByZXNl
dCBhbmQgcmVzZXQgb2YgaW90bGIgbWFwcGluZ3MuIFRoaXMgc2VyaWVzIAp0cnkgdG8gcmVjdGlm
eSB0aGF0IGltcGxlbWVudGF0aW9uIGRlZmljaWVuY3ksIHdoaWxlIGtlZXAgdXNlcnNwYWNlIApj
b250aW51aW5nIHRvIHdvcmsgd2l0aCBvbGRlciBrZXJuZWwgYmVoYXZpb3IuCgo+ICAgU28gaXQg
c2hvdWxkIGhhdmUgYmVlbiBub3RpY2VkIGJ5IHRoZSB1c2Vyc3BhY2UuClllcywgdXNlcnNwYWNl
IGhhZCBub3RpY2VkIHRoaXMgbm8tY2hpcCBJT01NVSBkaXNjcmVwYW5jeSBzaW5jZSBkYXkgb25l
IApJIHN1cHBvc2UuIFVuZm9ydHVuYXRlbHkgdGhlcmUncyBhbHJlYWR5IGNvZGUgaW4gdXNlcnNw
YWNlIHdpdGggdGhpcyAKYXNzdW1wdGlvbiBpbiBtaW5kIHRoYXQgcHJvYWN0aXZlbHkgdGVhcnMg
ZG93biBhbmQgc2V0cyB1cCBpb3RsYiBtYXBwaW5nIAphcm91bmQgdmRwYSBkZXZpY2UgcmVzZXQu
Li4KPiBJIGd1ZXNzIHdlIGNhbiBqdXN0IGZpeCB0aGUgc2ltdWxhdG9yIGFuZCBtbHg1IHRoZW4g
d2UgYXJlIGZpbmU/Ck9ubHkgSUYgd2UgZG9uJ3QgY2FyZSBhYm91dCBydW5uaW5nIG5ldyBRRU1V
IG9uIG9sZGVyIGtlcm5lbHMgd2l0aCAKZmxhd2VkIG9uLWNoaXAgaW9tbXUgYmVoYXZpb3IgYXJv
dW5kIHJlc2V0LiBCdXQgdGhhdCdzIGEgYmlnIElGLi4uCgpSZWdhcmRzLAotU2l3ZWkKPgo+IFRo
YW5rcwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
