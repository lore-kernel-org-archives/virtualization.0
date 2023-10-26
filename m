Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10251C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93BC580E90;
	Thu, 26 Oct 2023 07:19:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93BC580E90
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=HdjLBK5T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=a/skYYJa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0n1DA5l4nRDy; Thu, 26 Oct 2023 07:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1EB480ADE;
	Thu, 26 Oct 2023 07:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1EB480ADE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0DD1C0071;
	Thu, 26 Oct 2023 07:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5ECAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9A2341FAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:19:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9A2341FAC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=HdjLBK5T; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=a/skYYJa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5jMV_MulfNc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:19:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBDF841F9E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBDF841F9E
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q3VO6u006370; Thu, 26 Oct 2023 07:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=HdjLBK5Tyrd+JILFTqCHBtEk/omQzw/gI+68AIywNzD2A9N63rS/3EZob7A8paxeukWp
 VsAoWdNJMyYygU0032dMSHSieOFCgjs+WGajOiC5DmSOT1tqehzcjXIe8lTeUhPUY91d
 cvYrz9YDEtwroK/IXfhNkhA1Ga2L25+pcEJSBBUBAVWTsAuxTgCrK4Ll4jD0nSx2VeB8
 pDtM6YJ99f2plyJGXFrGQjlGlzKDQwnIGvVf8HkWS53V/SU0vqdN2B+MWmS14CgyB6Ot
 yAkwugq0mSBStuJpZJmEs4TBUfwOUMF+JZz3U9NF3piD9EN5BdUJFs6msJ51aarefyVc tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581taxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:19:39 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39Q5xUcj031109; Thu, 26 Oct 2023 07:19:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53e9x0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWO50q09rWsXOs0s6oejsqJ9T7UXfmA4Qjy8zyNrBIrAOwGWbCocBVQo9/AqkMvJoLwSfL4zpagDQhfsQtG8/XCDwjHC+vHXNlrJrG2XvxXNg36z/pdU+cOwZxqKbSfUUmHBDWEQJpEkOgRh+cYcbd9DZzFtKFFjgIlN1wyDmWPCo+ycObpA5AooxffgUL7AppQxNhohVWiq7ILqRw4rbvcms2WM2H/EneqZxT8MTp8mO31Eni2Ld4MaWvM3MzaUL8LXtuivoCy9vAEtTq/4F/MVUtcxjKk8Vj48+0D6xF1z1NaCqNAQkB+XmuqOsh6xC/V2QjGBABjv7lmU+iPmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=iGtIWcj69EK7mHs5uzinQDb02CEZZaT5hawT44XFb19b9GWL6iFtw4CqWIsIJvM0zbjVul47i+DgI8DsRgph54dxgd4j3xVVC8VbvH2hHEbB/wElmuKLEQ5gGIG7FLY3iHGc/OG0oYtTE/yicBndjyejQlrXJF/Hc0U0eHWJB6JVI77dA5GwVy3LXRrKcaX/vISxD8vF0ifJaqakQPXYzjoap6Ld+h9eZk6vLlipH7jxc5hRHvpsI1kV++CsShyWnoaU0NfxQ9BTkZ1NqTu9oZsN4lErOvt1HiKHuMSrBNDKRj8TZgN6zvqHljouwRTCGGNrCEMAT/RdEb1YyL2zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=a/skYYJaFcX9ADaz/YWevZPtIWCzjosmBgSBXmkkoYzwHjIbTRNTGoPQYTZWhCMR+bwJS5mjUi12V/aGJT54chr58kCTdFPxiQFU+6E64f9X6I/Mw7KDBZysm4+WiEq+T17wRyXDLxaQh5Vp2DMrqTydMqmj0g929vJvP3YZXow=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 07:19:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:19:36 +0000
Message-ID: <489dd10f-928c-4479-9633-59eedf9b60dd@oracle.com>
Date: Thu, 26 Oct 2023 00:19:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-vdpa: fix use-after-free in _compat_vdpa_reset
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
 <20231026012326-mutt-send-email-mst@kernel.org>
 <8f7418e3-816f-4bfd-bf6e-8be68054f55d@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8f7418e3-816f-4bfd-bf6e-8be68054f55d@oracle.com>
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8029ea-4eaa-4fd3-fa2a-08dbd5f3e8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c8OgFatI1n+zi/2H3mQ025bFPsRUAjGdQB6yCZJau567fifgnu7y76kCdOFhrpx4QLxBVGBF9bWOQbMiNuyyerJm2Eh2C/Vp4sTX2cc484HOrFV77Iooq71pTOusNOO+ogj7yT/pmOtiooBssoG8drUzwo09HVBzFcB4HsndjHHI6hy6A9lztKmhxpbOSe9VNbv4TbRRKTyT9bRTnY+19NhRv1L4vQI8B1SIlXpk2WCzrakohiF7V4AGFbPBdiT7xq/wkfsX8t3oe9/ijafUn2wLYYdI48F7hP5g9B1tTyZb75O6aZGYTXKPfbvVII+OVNrFZlMDIRpeVOkIlSGOkAKAN10cX/U5P2xesipPrzDCLffOfTsA9J09+CM68vw1KGH4nkQLWoLn55Rn891UXZoGUPXgsqRNh0FpK0Ow6Vq235hQ0aQxqSWqUo2s5hp+t2HBn5lviFmrMYUAGjVaFEEir3d8E+CFRYPquREQM9s7JT/Tl3yOY8KkWTD09BQjlNVsz6CTqUzAxgsjWO5AJsIb5Zhhptz9ohwr0ZV85ytgl6AH4mhKErJ8zg00JxbRlw6e1Fwg5Spn42XBWRyBvyCFwLjmIFZTYZ+Wonrhcj6nhwuMzqp8YC687u2VOk6Fn2lU93BndsIUtwIuPAaCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(2906002)(83380400001)(8676002)(8936002)(966005)(6486002)(4326008)(53546011)(36916002)(31696002)(31686004)(5660300002)(41300700001)(6512007)(86362001)(6506007)(6916009)(316002)(6666004)(26005)(478600001)(2616005)(38100700002)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9DRFBQUG03L2xsUWt1ZDhVTFp1MDdOWFFLZjZlY3JxNng5NXBScElGd1RQ?=
 =?utf-8?B?all1ZTZmcXkvQzVFNnM2TkpTRlU3aXNrajZBS2J1M0NzVzEwdHVVNHViSURH?=
 =?utf-8?B?NGxEbTU4d1dTamxhL0RhNWZiZmlIa21oM3QzaXNCT0VTc1hFTUxKMHlCaTdO?=
 =?utf-8?B?ZjFtMEp2aTJuSVJ3cU10V1I3RjJkb0FPa09BNGhic1VKUmpGdWVhRmFIVXRo?=
 =?utf-8?B?cTNmdWtNMWZLdW5TbUd0QVJ6SkR6QXRFbUxlL0RhR2l3UnJ5ejFzaHQ4a1hz?=
 =?utf-8?B?Ui9jbjJjL0NlOVN6TUlsVFl2eXAxcExhN3Z1K1hPTWpUWnZ2RzlsSzM3RW1M?=
 =?utf-8?B?V0hXZUQ5VmU5YjlBQ1BBS2FXZlZ5Z3Vwa0dmbXJUSnZMeklVRGNaTkVhVTJp?=
 =?utf-8?B?d2ZvRzYzc3ZRSU0rcThxU0lYOFM0bFZXcTdNODhXZTdLdlpINjlMMm5uWG82?=
 =?utf-8?B?Z0o5RVl0aHlGS21PQWhhZ3VnMC9OWXdTTW1WbHhBdXBtUVdCb1J5ei95Q0E4?=
 =?utf-8?B?SWJidmx5aE53dDdTb1N2bUlNT2FjdStGYm9BRFJtNVJhOW1jK09xQkE4eFhy?=
 =?utf-8?B?TUptY0Z1SEFmRHNCZkZ5K3ltQk5hZm5BSmVPOEdaeUZFQWtuYmFoYmtMeGJI?=
 =?utf-8?B?eS9jclBYaVRsb04zbEw4TkNOaFVNR1RVbUJIaXVxV0picWkwNkF3eVBCM1li?=
 =?utf-8?B?dHg5ODhLaXB0MVFPUDlORmRzU2JaaXFlMVBpN2NNcVV1ZXNiU1c1NVJHM3I5?=
 =?utf-8?B?OWl3VlA5WWl4L2tzbUxpWlZtN3ZtRHlNdHVuMGxyY0JNNm1NdlhyZlJSVTVw?=
 =?utf-8?B?MmFLK3I2eDhWd0F0VEltYWw0TlIreTBZTzcwUS84VktzbnA2K1o5Tm81ZFRB?=
 =?utf-8?B?cmJpemxPeGhTcTFUSWRGMDhwekFBWUtFSUs3VzMray83ZVpmTjF4STdqd0RC?=
 =?utf-8?B?cU5ZbUUrdVBzL1ppaGdZaTQ2bXVDN0NmdmNLRFNCVk9tQWpqdTdDSHpOVUhV?=
 =?utf-8?B?N3B6RmZuZTE4TkswNVlmcyszdmNLZnJWRHk4aEJ1cVo0TXBBak1zNXNIQ1lX?=
 =?utf-8?B?dTc2RjVDMmdNRDBoK3RiTWlsS0VBY0NKeUU0d2VuMW5oSG1kaCtLSVc4Ukhp?=
 =?utf-8?B?aHcveVhUU2FlYjhnZ2FrZUFubEVqbXFiY3ZkcCttc294dkZDU2c0eEUxSk1z?=
 =?utf-8?B?RnhTVWhYMmFQTG9VN1pmdmZlT0RteFBsalBUQmsvQjhZNUdYMUxRcnJCNUpk?=
 =?utf-8?B?OEhkNjdiNWFJSlF3TCtWaS9oMXNWdTgxYndVMXJWYXhJNnY3dUFRd2lWRTR1?=
 =?utf-8?B?OTB3VzZDVnJnZmh1VzN1dkd1bzN4dXRscFNXcndjM0tRU1pzeWhjMi9HK0Vm?=
 =?utf-8?B?ajZ0MUUvcVpYOEdGbkFMVG1UNTVkRjhEY2lHN1dWYnAwYXFndGNIc3lHWUx5?=
 =?utf-8?B?ajUvWndGMlpVVUM4Qjhxd2p0VzVoaVp2NGxMMXRFcHRhVWdsK1pLK1NSTjYv?=
 =?utf-8?B?bklHK2NqbTlJd1RwTjRVK0xINWp2UklyL2VCUzFNSlFQYjZqR2loY2lNdzJo?=
 =?utf-8?B?U1kzdmpjYVVmdE1NN2FjMDFPNk1MZkg5QVJ4M2VPUzNGaDBTK1pDWTV6ZGZz?=
 =?utf-8?B?YkJiRlJPY0NHbXd1VkgvNFRKRGg2N2JwaEprSzZNMkgzUnJKSUZQd2Rvekw2?=
 =?utf-8?B?bnVrdWluV1JqdW16UkN4NFVxMzVDZzZKMGtSRytJZXJnSHdzdXVTaDBlQUZL?=
 =?utf-8?B?Y0NaUmNRV3RObVhSWTVrejcvT3JyNkFnVld5ZHZvYm8vSzdGUVVpZFlkcUxp?=
 =?utf-8?B?cnVmZmxsN2tMY0d4am1kOFVNZ1BtWFYyMk1hd0hNbU5jTEs5cllMUStLdWhi?=
 =?utf-8?B?Y1dSN3ArQ2hKc2crSXMyRVB6dStDWks3aTZWR0ZyVHVGL0tLOUNqL3ZSempz?=
 =?utf-8?B?Nm93dDRjR0pxVmR6clFxeUpoUFZzczhXLytldi9SczV3Z29pZ0lOUzdPd3dz?=
 =?utf-8?B?RlNDdnpmK0tmbjFpUEpmeCtRSHQzSWpPckpGeldqVkhvL3hnSVRHTzV6QlZC?=
 =?utf-8?B?VVBTWlcreVNka2hMdkRKb1ZzckJ5bndaZWhHYVNzK0VkNDc2MzlYOHorOUxU?=
 =?utf-8?Q?ljKKXWcavtlMwCBdf7tEISsiC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SH81UDDdjH19haZFigbUZrm4CdalY0iuq1Ryi3hF5UsRobKXNVzRuYUUfVGOBZtDmf0C6V1XsipUlFiRm09G+wPb/u6OVl7MPOypz72AidZMq1sjQP0tBdKHGu1SpiYTr5PQ3vDVodZUaeauz8fhyD7IegX3AGzIg372mp4rLJbG+J588LJwf2/4g5xmLSmzK+qLjVvDIcZ3BXnh9PtrDfR7pA+vv7cEybO1DSLgDiA1B+7d7ukfgmB/B7sTMd4bewk68ciXiQQq9xDLTeJCIcLvX2qTz2GTPCFGCXdDSUAHRTdHzJJiHidhV/iMyjYQLN/+/S8P/KMzRl+OmGlpUl2bnh6Ee2YIkKIl1PaeJrRRRsVzSIluE1JBKVDvrRRn/AJ+wH03dln5m0F+FL+raqlF2d1HJhyRCB78euHW4QpT184wXpvM7dTtlIXrX+akd7oBikhOemWxqStFyU0CeADAG5kWer9hOFTIrot+dZrSdbdJQd7D3szEQLRzWbB5sBcrRfOzV7hPrdlxJW9gLUkS/ce1DtTMoPxILL2/SqMb/amSd3gMpe8Da71I7x3ORxlTwXAZXIPZo8sN0WoDO3ViiTxq98h41ar7xCL7Z3uhikkr+QS9M/lGh3AysjFCiGF3j5+mSa080QuSI6n6rS6R4C6f5tKg9H9aPF0g1DxRQT63/IZ21/xpsnFYNeX39xH0LRBl+DVgQyzsb4118hRAxKdqQIYeq9o/HNMjFmadQ1jKAVoeL97YZGWtjFVBoO6FiO78f5OoWeQ79sGnHD6Xxzui94WjaxnVeqJCaOuRbg/sCT06Ln5cxL3GrjMyTxjMTz3QLInrBBQzXMX8iam2ErcqWaxUGf52dfwA8zx2WiAuLfJSICuXlzJzD687+rykG+8PWbN0StG35E8GpJcvGPbJnXkeuVmL2qj/KEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8029ea-4eaa-4fd3-fa2a-08dbd5f3e8d7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:19:36.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFQCiSCyNR9cy2vxV6pMjtauLqUCUdrjy42cpXpHMfRBLdvMb5I1cPpF2NgLCACoHO8WLPzoq/eHBN2bTDjFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260060
X-Proofpoint-GUID: 1BIZW-wlixZsn-uhVRQihnQQr9yyHpiv
X-Proofpoint-ORIG-GUID: 1BIZW-wlixZsn-uhVRQihnQQr9yyHpiv
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 leiyang@redhat.com
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

CgpPbiAxMC8yNS8yMDIzIDExOjU1IFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Cj4KPiBPbiAxMC8y
NS8yMDIzIDEwOjI2IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIFdlZCwgT2N0
IDI1LCAyMDIzIGF0IDA0OjEzOjE0UE0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+PiBXaGVu
IHRoZSB2aG9zdC12ZHBhIGRldmljZSBpcyBiZWluZyBjbG9zZWQsIHZob3N0X3ZkcGFfY2xlYW51
cCgpIAo+Pj4gZG9lc24ndAo+Pj4gY2xlYW4gdXAgdGhlIHZxcyBwb2ludGVyIGFmdGVyIGZyZWUu
IFRoaXMgY291bGQgbGVhZCB0byB1c2UtYWZ0ZXItdHJlZQo+Pj4gd2hlbiBfY29tcGF0X3ZkcGFf
cmVzZXQoKSB0cmllcyB0byBhY2Nlc3MgdGhlIHZxcyB0aGF0IGFyZSBmcmVlZCAKPj4+IGFscmVh
ZHkuCj4+PiBGaXggaXMgdG8gc2V0IHZxcyBwb2ludGVyIHRvIE5VTEwgYXQgdGhlIGVuZCBvZiB2
aG9zdF92ZHBhX2NsZWFudXAoKQo+Pj4gYWZ0ZXIgZ2V0dGluZyBmcmVlZCwgd2hpY2ggaXMgZ3Vh
cmRlZCBieSBhdG9taWMgb3BlbmVkIHN0YXRlLgo+Pj4KPj4+IMKgwqAgQlVHOiB1bmFibGUgdG8g
aGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IDAwMDAwMDAxMDA1YjRhZjQKPj4+IMKgwqAg
I1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCj4+PiDCoMKgICNQRjog
ZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQo+Pj4gwqDCoCBQR0QgMTZhODBh
MDY3IFA0RCAwCj4+PiDCoMKgIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQo+Pj4g
wqDCoCBDUFU6IDQgUElEOiA0MDM4NyBDb21tOiBxZW11LWt2bSBOb3QgdGFpbnRlZCA2LjYuMC1y
YzcrICMzCj4+PiDCoMKgIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjc1MC8w
UEo4ME0sIEJJT1MgMS44LjIgCj4+PiAwOS8xNC8yMDIyCj4+PiDCoMKgIFJJUDogMDAxMDpfY29t
cGF0X3ZkcGFfcmVzZXQuaXNyYS4wKzB4MjcvMHhiMCBbdmhvc3RfdmRwYV0KPj4+IMKgwqAgQ29k
ZTogOTAgOTAgOTAgMGYgMWYgNDQgMDAgMDAgNDEgNTUgNGMgOGQgYWUgMDggMDMgMDAgMDAgNDEg
NTQgNTUgNDgKPj4+IMKgwqAgODkgZjUgNTMgNGMgOGIgYTYgMDAgMDMgMDAgMDAgNDggODUgZmYg
NzQgNDkgNDggOGIgMDcgNGMgODkgZWYgCj4+PiA8NDg+IDhiCj4+PiDCoMKgIDgwIDg4IDQ1IDAw
IDAwIDQ4IGMxIGU4IDA4IDQ4IDgzIGYwIDAxIDg5IGMzIGU4IDczIDVlIDliIGRjCj4+PiDCoMKg
IFJTUDogMDAxODpmZjczYTg1NzYyMDczYmEwIEVGTEFHUzogMDAwMTAyODYKPj4+IMKgwqAgUkFY
OiAwMDAwMDAwMTAwNWIwNTZjIFJCWDogZmYzMmIxM2NhNjk5NGM2OCBSQ1g6IDAwMDAwMDAwMDAw
MDAwMDIKPj4+IMKgwqAgUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmYzMmIxM2MwNzU1OTAw
MCBSREk6IGZmMzJiMTNjMDc1NTkzMDgKPj4+IMKgwqAgUkJQOiBmZjMyYjEzYzA3NTU5MDAwIFIw
ODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmMzJiMTJjYTQ5N2MwZjAKPj4+IMKgwqAgUjEwOiBm
ZjczYTg1NzYyMDczYzU4IFIxMTogMDAwMDAwMGMxMDZmOWRlMyBSMTI6IGZmMzJiMTJjOTViMWQw
NTAKPj4+IMKgwqAgUjEzOiBmZjMyYjEzYzA3NTU5MzA4IFIxNDogZmYzMmIxMmQwZGRjNTEwMCBS
MTU6IDAwMDAwMDAwMDAwMDgwMDIKPj4+IMKgwqAgRlM6wqAgMDAwMDdmZWM1YjhjYmY4MCgwMDAw
KSBHUzpmZjMyYjEzYmJmYzgwMDAwKDAwMDApCj4+PiDCoMKgIGtubEdTOjAwMDAwMDAwMDAwMDAw
MDAKPj4+IMKgwqAgQ1M6wqAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMKPj4+IMKgwqAgQ1IyOiAwMDAwMDAwMTAwNWI0YWY0IENSMzogMDAwMDAwMDE1NjQ0YTAw
MyBDUjQ6IDAwMDAwMDAwMDA3NzNlZTAKPj4+IMKgwqAgUEtSVTogNTU1NTU1NTQKPj4+IMKgwqAg
Q2FsbCBUcmFjZToKPj4+IMKgwqDCoCA8VEFTSz4KPj4+IMKgwqDCoCA/IF9fZGllKzB4MjAvMHg3
MAo+Pj4gwqDCoMKgID8gcGFnZV9mYXVsdF9vb3BzKzB4NzYvMHgxNzAKPj4+IMKgwqDCoCA/IGV4
Y19wYWdlX2ZhdWx0KzB4NjUvMHgxNTAKPj4+IMKgwqDCoCA/IGFzbV9leGNfcGFnZV9mYXVsdCsw
eDIyLzB4MzAKPj4+IMKgwqDCoCA/IF9jb21wYXRfdmRwYV9yZXNldC5pc3JhLjArMHgyNy8weGIw
IFt2aG9zdF92ZHBhXQo+Pj4gwqDCoMKgIHZob3N0X3ZkcGFfb3BlbisweDU3LzB4MjgwIFt2aG9z
dF92ZHBhXQo+Pj4gwqDCoMKgID8gX19wZnhfY2hyZGV2X29wZW4rMHgxMC8weDEwCj4+PiDCoMKg
wqAgY2hyZGV2X29wZW4rMHhjNi8weDI2MAo+Pj4gwqDCoMKgID8gX19wZnhfY2hyZGV2X29wZW4r
MHgxMC8weDEwCj4+PiDCoMKgwqAgZG9fZGVudHJ5X29wZW4rMHgxNmUvMHg1MzAKPj4+IMKgwqDC
oCBkb19vcGVuKzB4MjFjLzB4NDAwCj4+PiDCoMKgwqAgcGF0aF9vcGVuYXQrMHgxMTEvMHgyOTAK
Pj4+IMKgwqDCoCBkb19maWxwX29wZW4rMHhiMi8weDE2MAo+Pj4gwqDCoMKgID8gX19jaGVja19v
YmplY3Rfc2l6ZS5wYXJ0LjArMHg1ZS8weDE0MAo+Pj4gwqDCoMKgIGRvX3N5c19vcGVuYXQyKzB4
OTYvMHhkMAo+Pj4gwqDCoMKgIF9feDY0X3N5c19vcGVuYXQrMHg1My8weGEwCj4+PiDCoMKgwqAg
ZG9fc3lzY2FsbF82NCsweDU5LzB4OTAKPj4+IMKgwqDCoCA/IHN5c2NhbGxfZXhpdF90b191c2Vy
X21vZGUrMHgyMi8weDQwCj4+PiDCoMKgwqAgPyBkb19zeXNjYWxsXzY0KzB4NjkvMHg5MAo+Pj4g
wqDCoMKgID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDIyLzB4NDAKPj4+IMKgwqDCoCA/
IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwCj4+PiDCoMKgwqAgPyBkb19zeXNjYWxsXzY0KzB4Njkv
MHg5MAo+Pj4gwqDCoMKgID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDIyLzB4NDAKPj4+
IMKgwqDCoCA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwCj4+PiDCoMKgwqAgPyBleGNfcGFnZV9m
YXVsdCsweDY1LzB4MTUwCj4+PiDCoMKgwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NmUvMHhkOAo+Pj4KPj4+IEZpeGVzOiAxMGNiZjhkZmFmOTMgKCJ2aG9zdC12ZHBhOiBjbGVh
biBpb3RsYiBtYXAgZHVyaW5nIHJlc2V0IGZvciAKPj4+IG9sZGVyIHVzZXJzcGFjZSIpCj4+PiBG
aXhlczogYWM3ZTk4YzczYzA1ICgidmhvc3QtdmRwYTogZml4IE5VTEwgcG9pbnRlciBkZXJlZiBp
biAKPj4+IF9jb21wYXRfdmRwYV9yZXNldCIpCj4+IFNvIHRoZXNlIHR3byBhcmUgYWxsIGluIG5l
eHQgY29ycmVjdD8KPj4KPj4gSSByZWFsbHkgZG8gbm90IGxpa2UgaXQgaG93IDEwY2JmOGRmYWY5
MzZlM2VmMWY1ZDdmZGM2ZTlkYWRhMjY4YmE2YmIKPj4gaW50cm9kdWNlZCBhIHJlZ3Jlc3Npb24g
YW5kIHRoZW4gYXBwYXJlbnRseSB3ZSBrZWVwIGZpeGluZyB0aGluZ3MgdXA/Cj4gU29ycnkgbXkg
YmFkLiBUaGUgbGF0ZXN0IG9uZSBzaG91bGQgYmUgYWxsIG9mIGl0Lgo+Cj4+Cj4+IENhbiBJIHNx
dWFzaCB0aGVzZSAzIGNvbW1pdHM/Cj4gU3VyZS4gT3IgaWYgeW91IHdhbnQgbWUgdG8gc2VuZCBh
IHY1IHdpdGggYWxsIDMgY29tbWl0cyBzcXVhc2hlZCBpbiwgSSAKPiBjYW4gZG8gZm9yIHN1cmUu
ClNhdyB5b3Ugc3F1YXNoZWQgaXQgd2l0aCB0aGUgMiBmaXh1cHMgaW4gcGxhY2UsIHRoYW5rIHlv
dSEgU2VudCBhIHY1IAphbnl3YXksIGp1c3QgaW4gY2FzZSBpZiB5b3UgbmVlZCBhIGZyZXNoIHNl
cmllcy4KClRoYW5rcywKLVNpd2VpCgo+Cj4gVGhhbmtzLAo+IC1TaXdlaQo+Pgo+Pgo+Pj4gUmVw
b3J0ZWQtYnk6IExlaSBZYW5nIDxsZWl5YW5nQHJlZGhhdC5jb20+Cj4+PiBDbG9zZXM6IAo+Pj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBUHBBTD15SERxbjFBenRFY04zTXBTOG80TStC
TF9IVnkwMkZkcGlITjdEV2Q5MUh3UUBtYWlsLmdtYWlsLmNvbS8KPj4+IFNpZ25lZC1vZmYtYnk6
IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVy
cy92aG9zdC92ZHBhLmMgfCAxICsKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4+PiBpbmRleCA5YTIzNDNjNDVkZjAuLjMwZGY1YzU4ZGI3MyAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+Pj4gQEAgLTEzNTUsNiArMTM1NSw3IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfY2xlYW51
cChzdHJ1Y3QgCj4+PiB2aG9zdF92ZHBhICp2KQo+Pj4gwqDCoMKgwqDCoCB2aG9zdF92ZHBhX2Zy
ZWVfZG9tYWluKHYpOwo+Pj4gwqDCoMKgwqDCoCB2aG9zdF9kZXZfY2xlYW51cCgmdi0+dmRldik7
Cj4+PiDCoMKgwqDCoMKgIGtmcmVlKHYtPnZkZXYudnFzKTsKPj4+ICvCoMKgwqAgdi0+dmRldi52
cXMgPSBOVUxMOwo+Pj4gwqAgfQo+Pj4gwqAgwqAgc3RhdGljIGludCB2aG9zdF92ZHBhX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+Pj4gLS0gCj4+PiAyLjM5
LjMKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
