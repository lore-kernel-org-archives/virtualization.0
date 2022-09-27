Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7453C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 10:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D8208308A;
	Tue, 27 Sep 2022 10:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D8208308A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ckQ6k7xT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=weYzPxKW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEH9zhuvZSET; Tue, 27 Sep 2022 10:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E3BB8305A;
	Tue, 27 Sep 2022 10:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E3BB8305A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA9DC0032;
	Tue, 27 Sep 2022 10:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4EDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C46A0403A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C46A0403A5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ckQ6k7xT; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=weYzPxKW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SYT4fy-nEHD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:01:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0AEE4017A
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0AEE4017A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:01:17 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8Stmf032658;
 Tue, 27 Sep 2022 10:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=wW7fb19znzDrqqO+dR1ter6MPicwEgk8ZFAkmrBEPsw=;
 b=ckQ6k7xTWFU0n9cqGw6MDtPAvIH6HAvg7eQr0wKCWvh7/HfuDypynPXVSVRcslWiWgGk
 kMEIdAJB7XoerG3bt3R5r80BnXl5FINJNrgegLkcyWsPFbWtVLMXf4SCWR9AsdCBodlt
 TAA/rs7ssryIhbuH3DqTkL0iFEGJGbVHe5cfm7P97p7kUsLwjYNa4qGjRgRIL6LcNgUw
 7LN+7RuM+alD6Ok0vqgXYR4gp+tQJXUcAvn+uARMgr3em2aYG/9sue0s/si175z9cl/5
 yK4fbZgmbBaEBcTXyN4LksJQbh/4nULyuSLzX2aWYX7Aj5xJ9zWqfpvDjTEzV9wae15z mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwe6jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 10:00:50 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 28R8OnvJ027910; Tue, 27 Sep 2022 10:00:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3jtps53nyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 10:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9mIwkSDTmjEHgkVcBoRColEgfVnlIzroOtqKuRmq/W69QjBlmLMhbxQur4YGcA9WOlNXAKG3kOHURfXnYZV8k5lphRlb9R1XQpfv7c202eIc5OdpqEqZVPkw+NeFObVE5ErQqTQO4JcaqB24YAkzobNYynoM+kIydBWE5Z2EoDu9AvaBN4dY2ROHH5tFI+T7ZBiNpc9K6t8bNG+IrnMFwFQerrdwO76Shr1puyb4EyK1eNGF09cWgJAAyRtfyYm11gaQAOmnDZpG+ocsFculiLDxLo5SFjrPfzkQDDXVITJTUVBXy3BFvXrtDmP0GEpriNKB9Z8CQjKhw+2yspqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW7fb19znzDrqqO+dR1ter6MPicwEgk8ZFAkmrBEPsw=;
 b=aWgpCzkEicyQW5EioWbcsJ7rzQi5uO6UIHcqdFJ5rWbf1v5/EMlGO2ffjFnqmEsCgGhw2tpBHEp646XX1wvtGpzC/dg/kN9wPP8fEcSdkW19jFEht19AZHm2VBEcK42xvZKg0t4/NI3rVdxCr5PMf4mhHvnyr0AJeaIT1B68Mk89tAZvAnRx6ThLjDgbJqfBys/JgKj65041UTa4C6TF7P2pnS7ieoXMN2EJzpTa0N9PSJr+H1m2wRKMKuGPXy2MlezXxsz38xQ7zLxsEBTIRMX4UKvqyeKv5cofnBlf73pvj1Qq7sU1iEJ+ELRbbAfbAaCcEFHIW9uvGqQzedYJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW7fb19znzDrqqO+dR1ter6MPicwEgk8ZFAkmrBEPsw=;
 b=weYzPxKW3pMEPaAGq/bvdcynJbDNCsn9Lkq9pxJ805f2pq9Mc5fLRpaXRb4grVX1DrGYIvfXSmAuB039hi8EN4B4V0ZQFYifIrLs27HFA0e2YwD9n6H8reGpn/6MrKhZVR5Y8/Nbed23DrAhVVJPsivZsdoTL8iwmHjemq7E8LE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 10:00:47 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13%8]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 10:00:47 +0000
Message-ID: <7c555830-6909-d482-ea05-4316a02012df@oracle.com>
Date: Tue, 27 Sep 2022 03:00:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
 <CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com>
X-ClientProxiedBy: DM6PR14CA0072.namprd14.prod.outlook.com
 (2603:10b6:5:18f::49) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e83a316-5f9f-4911-80de-08daa06f2651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acJML1G6nse916rYBa6aIu8T8YpqpEuwQZrde/79q1UWcT3l3/+WuOdLFHYyTr+J1vVwSM02UV/VynYIEVmNydYtgeq9rB9V29Nry0GORjv7l9n/Hq7xhDzyYjNh7KFx5SZfIX9DG25b70x+Q96rfwCaFTPRzqbscm8GSNO4JvASls9iFluzCOCMFnJ2ahoaFSYEsvuH/mvW/u8lSmaiU+XZ3lz8jNJFw+LzFY/v7Jx/MeKHQZpuUyxsDQ4nn91erhALzKCWVP4yiPCur4Ch5E2njmcKbtSxqfq30ZXz7tnqxSzJYVt59TKSdoVNiZUTdpQXoqHqtiyMMmTacAhHnjTqSKx1EJnz9E1ZJINsaggKnP5uEV+eSRuGs0fZb8/Bq8qF10jedk30F96ZVfvd08rXvRIPMUBwUPV0B3d1GfEHMLr7RLxJSPygw/Wvij4lHOe413KlUOpxb8Z2jRXmbfBvG7fPnKxxCOpeFzN8X0MObzYQWVxoi4WA7gxV7oOuj+vNQOnkYbJmfaeKmZdGYbgJto4FgVeun9N84rEHrbInBiGu1FksRX2JLfqQ+k9BBXvqA4V73L6CXzRjgEbElllZUdZ8+HoIXhbe5Pdxtb22PlD901wUI8PbJzth32ZidjZCKz8wfRmi60IwmLUajNim5ZPiC/GpMu6sgb5SZFcjT7cvoThMdD2E4aOK+vFnvVfwwxgIq9lLjTmib178QN15O0L/Q10QJ0XHYDeQUkjuCXj0d7qMF1gGFx8HyUfhJDsW+GQ7YKOyy8BuLHTGcJYCo/PGuznCKE8YkBFZJgiEItUjI/Rn/VjKrGBixPy8quvG1rdS8WDqVJ3ReX1uhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(166002)(2616005)(186003)(86362001)(38100700002)(31696002)(83380400001)(5660300002)(7416002)(30864003)(66946007)(66476007)(41300700001)(66556008)(4326008)(8676002)(2906002)(33964004)(26005)(6666004)(53546011)(6506007)(36916002)(110136005)(316002)(8936002)(54906003)(6512007)(478600001)(6486002)(966005)(36756003)(66899015)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkViMjlLNjVON3hWa20rN0ZTOUp1NmFteExSdU9uY3NjSFdkM0t0cGJ4a2V2?=
 =?utf-8?B?RlpoSUdSWDBnM05ZUDBuT0JOL0o3cFNaUVJOd2tiRnczNjFXdWxSSGEzWGNo?=
 =?utf-8?B?ZWZVamt3bythdDN4Q1ZLbDM1NXRpaWxJMEQ5NkU5M0J5SEtZblVxWmJpTnJZ?=
 =?utf-8?B?SG5KbFhCSzVWOXczejBwbnVLcjVpTTRyMDdEQmJZRE9KbWRqbkpTSWE3aER2?=
 =?utf-8?B?N0tUclBFbkwzOThJVmY4MjdMWEpZY2prcVk3RUhPNklvTDN4ckxyUkdYN25r?=
 =?utf-8?B?NWc1WkcrV3g1SjF0dGpySkgvUFdxWVBHNDNCN0VsQWhZbjRaSkpGenhSa1Ez?=
 =?utf-8?B?bEIwWWZHU0x0NEJOSi83dFJVVWlVUW5VclJWaCtlYmhnaldMR3lheEg1VEcx?=
 =?utf-8?B?dWhPaXI0UkpQMFNHL1MzSVA3emVpdWxBSnVGUUVjdFZZOGgyTjNMVnRMemVL?=
 =?utf-8?B?OFlZSVpQWjE5aXJQUS9GRXlJNE5nZkN3aGgwVGFENGZ3VXZSVWxFeW1xTCsx?=
 =?utf-8?B?eHRvd2tXZi8wVlg5ZW1SY1UwSDcrQk5ONm9MWmZWK0NsSVhjYTc0Q3c3ajlu?=
 =?utf-8?B?UHJkSzBXRWpDOHRqK1dCR0JGNUNSL096TWs3d1RaNzhhaGQ1VENkR2lQZDI4?=
 =?utf-8?B?amI0ZVgwdGxERTJ1UFBlZkNmVVNONFd1SHFDenA5VmJVYzdwVXNPMEJKTUtD?=
 =?utf-8?B?NCtWVnhqTzBTZjBGMmw5VWlLZXptR2t0S3FUZ1RHK3NvZEIxbFF6czZualpC?=
 =?utf-8?B?M1V1Q2xCQzdDbVphZjRhc0hPVkhxeFcvM0VBZGtxLzFORXRZM1F6bmZ0Smwr?=
 =?utf-8?B?UDllenhaM2lIWlZTYkJxaU5oUFljQmU1R1ZQalJxcm1rOUtkcEFxd1VsaDZD?=
 =?utf-8?B?V0gyekZJZG1KOW9mMUxWTUJIb25jVS80SnptdDV2UGdEYmdLVHE0OVJvdXZG?=
 =?utf-8?B?WEN0bkRiK0ZWeUkxbldLQWNDUjRacVVnWFJWQ28yOUE5UzBQcEVxdU1paG9D?=
 =?utf-8?B?VXJOSEdMdk5jTTBJUjBFYlBjNldrZGsvd2twRXNLRFhCN0hHRHJXNU1LZkZW?=
 =?utf-8?B?Qm9PMWJQcXN1Q2pWTW9HSUJJY3VlS3QrM003bHhveGVUOEFEM3BZVXRIcGNM?=
 =?utf-8?B?YjRkY1BGRE1PVk5iVVVYWUFvdGZ3UmQ3VnozbHpBTzB2R05CZ3A3UmI1a1Zk?=
 =?utf-8?B?cUNmYzRtMXRvZlJZdmJ5aFVoKzZhcEpoQk5Gcis3Y1ZOM0Q0THBtY05oQW4y?=
 =?utf-8?B?M0RCWDQzd1gwVXZXQWZJTkdsckxjMU0ydlgzejFYM29yRFVjSm1PWmcrS1p6?=
 =?utf-8?B?NTUvdXpUcWFxYXZpOU5LVXBRZjF4aS9HdlYyb0Y2QVlQWTlWaGRZV0lqc1BL?=
 =?utf-8?B?QlhjTTdnOHQ5UUdvOWtUckl2Nm1YOERnb0JJTDdnUEMxcjVlcFp3TkpGdDdO?=
 =?utf-8?B?UE9SVHA3YXh6VkNRcDNBUHhWRzVyckxLditSZ3VPbXRvZGlzaVZzeE1ZVmtx?=
 =?utf-8?B?K3VEdlEwQUJPclNjcVlMNzNQS21neFdLZExsNW1Nd0FZdCtQYkgwR0x0blVs?=
 =?utf-8?B?L3QwUUdIRWcvM014STA3TWpFaVRkZjI1UisxNzlobmF1K1d3aXp4SVFHV2cz?=
 =?utf-8?B?ZHdzWXllTGlTb3RpQjhDcTFLZmd3U2hlcUpGeDUwMVJ2TWxjZ0FMNzJ3cWgr?=
 =?utf-8?B?S3pEUXZRZVNvUS9Oa1pQYXZ3Wk05eHNySVJGb0pyUU9Hck1sQWhOS0lVUG11?=
 =?utf-8?B?TytMSE4ydHppcWFROStURldnUUZGa2VHMWd3bktsK0dwRjJOcENLWloxQUtB?=
 =?utf-8?B?SlN1a2pOcmYrc3ovNndGcUVBMHkrNVV3V092OUpVYjlMV0hCRkF4a0ZhWE1m?=
 =?utf-8?B?RXBmRmEzQjhuRVNrSmN3VUREcFQ2dHhUQzU0c3l2SGtCKytzbUthT29pekRw?=
 =?utf-8?B?dnJkVzF2czdFdkVJVWdtU2lxQklSNGpQdTNjN2N3U0w1SmpNOVNIVGF1c1Bj?=
 =?utf-8?B?UEE2TUlBSVRqWVBHMFVPaVZwN2NuUDN5RGk5Y3dvdGJUUjNOOWV4citneW53?=
 =?utf-8?B?R0NRejRUS01WUms0ckNaRk5KNVJVbS9vNEY0dnRMSjhwbmZJaE51dzg2V2RF?=
 =?utf-8?Q?6PpKLNNbbCpPbTSIWWSW4WE/u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83a316-5f9f-4911-80de-08daa06f2651
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:00:47.2910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7ayD3aOd8ana13hVjhkAOEt5WbtK/05rRM2ovWf4Z1Z4x3fg59lOGiuXHoWFK2+pibaG6cLcILYiyu2ujDdwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270059
X-Proofpoint-ORIG-GUID: MR8ZBpOmGbrxxBIPFtuJU0Eazk3jrVkf
X-Proofpoint-GUID: MR8ZBpOmGbrxxBIPFtuJU0Eazk3jrVkf
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 Yongji Xie <xieyongji@bytedance.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============5500796740299247180=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5500796740299247180==
Content-Type: multipart/alternative;
 boundary="------------adjU1uXnK4wKVEJv1jm01SdL"
Content-Language: en-US

--------------adjU1uXnK4wKVEJv1jm01SdL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/26/2022 9:07 PM, Jason Wang wrote:
> On Tue, Sep 27, 2022 at 11:59 AM Jason Wang<jasowang@redhat.com>  wrote:
>> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>>
>>>
>>> On 9/26/2022 12:11 AM, Jason Wang wrote:
>>>
>>> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>>
>>>
>>> On 9/21/2022 7:43 PM, Jason Wang wrote:
>>>
>>> This patch implements features provisioning for vdpa_sim_net.
>>>
>>> 1) validating the provisioned features to be a subset of the parent
>>>      features.
>>> 2) clearing the features that is not wanted by the userspace
>>>
>>> For example:
>>>
>>> # vdpa mgmtdev show
>>> vdpasim_net:
>>>     supported_classes net
>>>     max_supported_vqs 3
>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>>
>>> Sighs, not to blame any one and it's perhaps too late, but this
>>> "dev_features" attr in "mgmtdev show" command output should have been
>>> called "supported_features" in the first place.
>>>
>>> Not sure I get this, but I guess this is the negotiated features actually.
>>>
>>> Actually no, that is why I said the name is a bit confusing and "supported_features" might sound better.
>> You're right, it's an mgmtdev show actually.
>>
>>> This attribute in the parent device (mgmtdev) denotes the real device capability for what virtio features can be supported by the parent device. Any unprivileged user can check into this field to know parent device's capability without having to create a child vDPA device at all. The features that child vDPA device may support should be a subset of, or at most up to what the parent device offers. For e.g. the vdpa device dev1 you created below can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than what the parent device can actually support.
>> Yes, I didn't see anything wrong with "dev_features", it aligns to the
>> virtio spec which means the features could be used to create a vdpa
>> device. But if everyone agree on the renaming, I'm fine.
>>
>>>
>>> I think Ling Shan is working on reporting both negotiated features
>>> with the device features.
>>>
>>> Does it imply this series is connected to another work in parallel? Is it possible to add a reference in the cover letter?
>> I'm not sure, I remember Ling Shan did some work to not block the
>> config show in this commit:
>>
>> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
>> Author: Zhu Lingshan<lingshan.zhu@intel.com>
>> Date:   Fri Jul 22 19:53:07 2022 +0800
>>
>>      vDPA: !FEATURES_OK should not block querying device config space
>>
>> We need some changes in the vdpa tool to show device_features
>> unconditionally in the "dev config show" command.
> Ok, Lingshan post an example here:
>
> https://lore.kernel.org/netdev/20220927025035.4972-2-lingshan.zhu@intel.com/T/#u
As I explained in the other email, it's incorrect to count on config 
space fields to export vDPA attributes for live migration. If anyone 
thinks that is not true, think again.

Additionally Parav already repeatedly pointed out quite a few times, we 
have a lot of (quasi-)duplicated attributes with similar names,

VDPA_ATTR_DEV_SUPPORTED_FEATURES

Lingshan's series will add:

VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES

and with this series, now we have one more:

VDPA_ATTR_DEV_FEATURES

Do we really need to maintain so many? I'm pretty sure at least one of 
them can be eliminated.

-Siwei

>
> Thanks
>
>>>
>>> 1) provision vDPA device with all features that are supported by the
>>>      net simulator
>>>
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net
>>> # vdpa dev config show
>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>     negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>>>
>>> Maybe not in this patch, but for completeness for the whole series,
>>> could we also add device_features to the output?
>>>
>>> Lingshan, could you please share your thoughts or patch on this?
>>>
>>> Noted here the device_features argument specified during vdpa creation is introduced by this series itself, it somehow slightly changed the original semantics of what device_features used to be.
>> I'm not sure I get this, we don't support device_features in the past
>> and it is used to provision device features to the vDPA device which
>> seems to be fine.
>>
>>>
>>> When simply look at the "vdpa dev config show" output, I cannot really
>>> tell the actual device_features that was used in vdpa creation. For e.g.
>>> there is a missing feature ANY_LAYOUT from negotiated_features compared
>>> with supported_features in mgmtdev, but the orchestration software
>>> couldn't tell if the vdpa device on destination host should be created
>>> with or without the ANY_LAYOUT feature.
>>>
>>> I think VERSION_1 implies ANY_LAYOUT.
>>>
>>> Right, ANY_LAYOUT is a bad example. A good example might be that, I knew the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I don't find it in negotiated_features.
>> I think we should use the features that we got from "mgmtdev show"
>> instead of "negotiated features".
>>
>>> On the migration destination node, the parent device does support all features as the source offers, including CTRL_MAC_ADDR. What device features you would expect the mgmt software to create destination vdpa device with, if not otherwise requiring mgmt software to remember all the arguments on device creation?
>> So in this example, we need use "dev_features" so we get exact the
>> same features after and operation as either src or dst.
>>
>>> SOURCE# vdpa mgmtdev show
>>> vdpasim_net:
>>>     supported_classes net
>>>     max_supported_vqs 3
>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>> SOURCE# vdpa dev config show
>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>     negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>
>>> DESTINATION# vdpa mgmtdev show
>>> vdpasim_net:
>>>     supported_classes net
>>>     max_supported_vqs 3
>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>>
>>>   But it should be sufficient to
>>> use features_src & feature_dst in this case. Actually, it should work
>>> similar as to the cpu flags, the management software should introduce
>>> the concept of cluster which means the maximal set of common features
>>> is calculated and provisioned during device creation to allow
>>> migration among the nodes inside the cluster.
>>>
>>> Yes, this is one way mgmt software may implement, but I am not sure if it's the only way. For e.g. for cpu flags, mgmt software can infer the guest cpus features in use from all qemu command line arguments and host cpu features/capability, which doesn't need to remember creation arguments and is easy to recover from failure without having to make the VM config persistent in data store. I thought it would be great if vdpa CLI design could offer the same.
>> One minor difference is that we have cpu model abstraction, so we can
>> have things like:
>>
>> ./qemu-system-x86_64 -cpu EPYC
>>
>> Which implies the cpu features/flags where vDPA doesn't have. But
>> consider it's just a 64bit (or 128 in the future), it doesn't seems to
>> be too complex for the management to know, we probably need to start
>> from this and then we can try to introduce some generation/model after
>> it is agreed on most of the vendors.
>>
>> Thanks
>>
>>> Thanks,
>>> -Siwei
>>>
>>>
>>> Thanks
>>>
>>> Thanks,
>>> -Siwei
>>>
>>>
>>> 2) provision vDPA device with a subset of the features
>>>
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
>>> # vdpa dev config show
>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>     negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>
>>> Reviewed-by: Eli Cohen<elic@nvidia.com>
>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> ---
>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> index 886449e88502..a9ba02be378b 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>>        dev_attr.work_fn = vdpasim_net_work;
>>>        dev_attr.buffer_size = PAGE_SIZE;
>>>
>>> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>>> +             if (config->device_features &
>>> +                 ~dev_attr.supported_features)
>>> +                     return -EINVAL;
>>> +             dev_attr.supported_features &=
>>> +                      config->device_features;
>>> +     }
>>> +
>>>        simdev = vdpasim_create(&dev_attr);
>>>        if (IS_ERR(simdev))
>>>                return PTR_ERR(simdev);
>>> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>>>        .id_table = id_table,
>>>        .ops = &vdpasim_net_mgmtdev_ops,
>>>        .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>>> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>>> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>>> +                          1 << VDPA_ATTR_DEV_FEATURES),
>>>        .max_supported_vqs = VDPASIM_NET_VQ_NUM,
>>>        .supported_features = VDPASIM_NET_FEATURES,
>>>    };
>>>
>>>

--------------adjU1uXnK4wKVEJv1jm01SdL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 9/26/2022 9:07 PM, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Sep 27, 2022 at 11:59 AM Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">


On 9/26/2022 12:11 AM, Jason Wang wrote:

On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:


On 9/21/2022 7:43 PM, Jason Wang wrote:

This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
    features.
2) clearing the features that is not wanted by the userspace

For example:

# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

Sighs, not to blame any one and it's perhaps too late, but this
&quot;dev_features&quot; attr in &quot;mgmtdev show&quot; command output should have been
called &quot;supported_features&quot; in the first place.

Not sure I get this, but I guess this is the negotiated features actually.

Actually no, that is why I said the name is a bit confusing and &quot;supported_features&quot; might sound better.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
You're right, it's an mgmtdev show actually.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">This attribute in the parent device (mgmtdev) denotes the real device capability for what virtio features can be supported by the parent device. Any unprivileged user can check into this field to know parent device's capability without having to create a child vDPA device at all. The features that child vDPA device may support should be a subset of, or at most up to what the parent device offers. For e.g. the vdpa device dev1 you created below can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than what the parent device can actually support.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Yes, I didn't see anything wrong with &quot;dev_features&quot;, it aligns to the
virtio spec which means the features could be used to create a vdpa
device. But if everyone agree on the renaming, I'm fine.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

I think Ling Shan is working on reporting both negotiated features
with the device features.

Does it imply this series is connected to another work in parallel? Is it possible to add a reference in the cover letter?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I'm not sure, I remember Ling Shan did some work to not block the
config show in this commit:

commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
Author: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Date:   Fri Jul 22 19:53:07 2022 +0800

    vDPA: !FEATURES_OK should not block querying device config space

We need some changes in the vdpa tool to show device_features
unconditionally in the &quot;dev config show&quot; command.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ok, Lingshan post an example here:

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/netdev/20220927025035.4972-2-lingshan.zhu@intel.com/T/#u">https://lore.kernel.org/netdev/20220927025035.4972-2-lingshan.zhu@intel.com/T/#u</a></pre>
    </blockquote>
    As I explained in the other email, it's incorrect to count on config
    space fields to export vDPA attributes for live migration. If anyone
    thinks that is not true, think again.<br>
    <br>
    Additionally Parav already repeatedly pointed out quite a few times,
    we have a lot of (quasi-)duplicated attributes with similar names,<br>
    <br>
    VDPA_ATTR_DEV_SUPPORTED_FEATURES<br>
    <br>
    Lingshan's series will add:<br>
    <br>
    VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES<br>
    <br>
    and with this series, now we have one more:<br>
    <br>
    VDPA_ATTR_DEV_FEATURES<br>
    <br>
    Do we really need to maintain so many? I'm pretty sure at least one
    of them can be eliminated. <br>
    <br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

1) provision vDPA device with all features that are supported by the
    net simulator

# vdpa dev add name dev1 mgmtdev vdpasim_net
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

Maybe not in this patch, but for completeness for the whole series,
could we also add device_features to the output?

Lingshan, could you please share your thoughts or patch on this?

Noted here the device_features argument specified during vdpa creation is introduced by this series itself, it somehow slightly changed the original semantics of what device_features used to be.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I'm not sure I get this, we don't support device_features in the past
and it is used to provision device features to the vDPA device which
seems to be fine.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

When simply look at the &quot;vdpa dev config show&quot; output, I cannot really
tell the actual device_features that was used in vdpa creation. For e.g.
there is a missing feature ANY_LAYOUT from negotiated_features compared
with supported_features in mgmtdev, but the orchestration software
couldn't tell if the vdpa device on destination host should be created
with or without the ANY_LAYOUT feature.

I think VERSION_1 implies ANY_LAYOUT.

Right, ANY_LAYOUT is a bad example. A good example might be that, I knew the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I don't find it in negotiated_features.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I think we should use the features that we got from &quot;mgmtdev show&quot;
instead of &quot;negotiated features&quot;.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On the migration destination node, the parent device does support all features as the source offers, including CTRL_MAC_ADDR. What device features you would expect the mgmt software to create destination vdpa device with, if not otherwise requiring mgmt software to remember all the arguments on device creation?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
So in this example, we need use &quot;dev_features&quot; so we get exact the
same features after and operation as either src or dst.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
SOURCE# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
SOURCE# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM

DESTINATION# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

 But it should be sufficient to
use features_src &amp; feature_dst in this case. Actually, it should work
similar as to the cpu flags, the management software should introduce
the concept of cluster which means the maximal set of common features
is calculated and provisioned during device creation to allow
migration among the nodes inside the cluster.

Yes, this is one way mgmt software may implement, but I am not sure if it's the only way. For e.g. for cpu flags, mgmt software can infer the guest cpus features in use from all qemu command line arguments and host cpu features/capability, which doesn't need to remember creation arguments and is easy to recover from failure without having to make the VM config persistent in data store. I thought it would be great if vdpa CLI design could offer the same.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
One minor difference is that we have cpu model abstraction, so we can
have things like:

./qemu-system-x86_64 -cpu EPYC

Which implies the cpu features/flags where vDPA doesn't have. But
consider it's just a 64bit (or 128 in the future), it doesn't seems to
be too complex for the management to know, we probably need to start
from this and then we can try to introduce some generation/model after
it is agreed on most of the vendors.

Thanks

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks,
-Siwei


Thanks

Thanks,
-Siwei


2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
Signed-off-by: Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
---
  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..a9ba02be378b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
      dev_attr.work_fn = vdpasim_net_work;
      dev_attr.buffer_size = PAGE_SIZE;

+     if (config-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+             if (config-&gt;device_features &amp;
+                 ~dev_attr.supported_features)
+                     return -EINVAL;
+             dev_attr.supported_features &amp;=
+                      config-&gt;device_features;
+     }
+
      simdev = vdpasim_create(&amp;dev_attr);
      if (IS_ERR(simdev))
              return PTR_ERR(simdev);
@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
      .id_table = id_table,
      .ops = &amp;vdpasim_net_mgmtdev_ops,
      .config_attr_mask = (1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MACADDR |
-                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU),
+                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU |
+                          1 &lt;&lt; VDPA_ATTR_DEV_FEATURES),
      .max_supported_vqs = VDPASIM_NET_VQ_NUM,
      .supported_features = VDPASIM_NET_FEATURES,
  };


</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------adjU1uXnK4wKVEJv1jm01SdL--

--===============5500796740299247180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5500796740299247180==--
