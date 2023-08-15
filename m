Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B626C001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 23:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B7CD1414BE;
	Tue, 15 Aug 2023 23:54:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7CD1414BE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VdD3Weow;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lKpMqnPq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAeE3akYsVF0; Tue, 15 Aug 2023 23:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB2F4047C;
	Tue, 15 Aug 2023 23:54:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CB2F4047C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D302CC0071;
	Tue, 15 Aug 2023 23:54:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB7DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7765F60AD5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:54:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7765F60AD5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=VdD3Weow; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=lKpMqnPq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uudZTjJCqi3h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:54:36 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3814A600B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3814A600B8
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FNP2f2028971; Tue, 15 Aug 2023 23:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iiI6cXDcGDqoDA4ZjCLmiftACJEP1Iz7oh9HL0OXfHw=;
 b=VdD3WeowwXBdHhmWsUfb0xwWWQJMMZS62Fcvq99JVQSfQdV7ZtRopGSGqWZmeElJwXeu
 lWmuQXy4dQ9pI7v1hshCy7zb2PDQ0jCSLXuZYc3t3vddmMECPKHj/qNY8wjedNwr3vw5
 mpbt41vanhIDnvhbEnFnUOls+Sbi0P6+8ZHwbmQG2HSgNyJZSF9FTKQlduz6CP18XD5d
 HFzgIHGdMrM97kH2TKGUnGyhayIfiCCS8LNgTo08H6uAD+8VMXxfc0gfGbqn0GKA/3+e
 JhORo//qlHEyyuzS3QaBZpNsLoPmzi24s4+HJcRF1Cts3bINMe5LDqeKLxxtcAFppogP BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2wwaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:54:34 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FM72Ec003999; Tue, 15 Aug 2023 23:54:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sexyjfcrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+xHTbrIS5aNetP3tGFEAg+nG8EHWOqjAZj8cTP7vm43ClTWC2d8Zj2ocYpNsV/fHzuP+uGzR/c+zgzJmQx6VmOT7t2OLg4jRMsm0LnNy0AAaL/evDlfHlaxQNzFL1Qa2euh6SN0nkLXi2A6/XPqQfrUQJtBQ886/bIGDjUquS80YHp0Qn3ZRL9opAwRQ9xw9JgckXfPUJoZ8nJ9JYeMLPVC2gl3a1B+kabDp/lLy+dezxvWA+IKv9vqnv4KOS6cDXFeyeAPs97HTkRau885JPJqzf6LMLh0rm6H/nXdo9DqosCOfHQTKeLFkiAOTIZtEK0iAHPdaHylxUrmobY3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiI6cXDcGDqoDA4ZjCLmiftACJEP1Iz7oh9HL0OXfHw=;
 b=i6Q2nFnqpJU162m4zRzC5Z+aiE9w0Ytr9e61HmrRNZAQls98fd/Ht+olh9WvcaukwxpSevO069173tezZz0A9JYKexdHARrrQEZa28+PUIiRU7gS4LCGWkTo0VXo5c7KtLROicmh+Cr5A+AOHBKiGrB1esNnWQ1dP7Ze/53xozOKfOFRSgu31+CmjRY0UYDKmKBMS8YZIcaBJUnuvWWolSpVvtFLYv4VbOFHDHritoXPtKCM8EjoU2iOPeM73o3cgqn1HMoGFODihVjgr1gaP4xILVzFHKuIIcvw74vPuoj4jS37e0tjP45rE3tZVbBwXGv8piDk3+hTAOLmKgWtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiI6cXDcGDqoDA4ZjCLmiftACJEP1Iz7oh9HL0OXfHw=;
 b=lKpMqnPqKq7T4yMSAuahoFWdzuKa18dpU5qFDOgWGvRU9Ne2Pn+LRpDNat/efEcMdMKjXwrlQa4yzvhXfDKhLko+h/CUahZxaSFLEtgVpR0GQTLaN9hWbd92+mJkQDIq1TuY6bo0KUoTdK+JtEkkGSinSjzYjOxJGwJsQFHTzqs=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB7692.namprd10.prod.outlook.com (2603:10b6:a03:51a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:54:32 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:54:31 +0000
Message-ID: <dbf568df-2ee8-e5c8-3696-74aeb71a03aa@oracle.com>
Date: Tue, 15 Aug 2023 16:54:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 2/3] vhost-vdpa: introduce descriptor group backend
 feature
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <1691585683-3948-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEsUM9d2QHtKUDSKO+qMJjRYhKy2w7J_RgwywrOv2tcJTw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsUM9d2QHtKUDSKO+qMJjRYhKy2w7J_RgwywrOv2tcJTw@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: eebabce6-193e-411e-8c05-08db9deaf854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xqd9rsM5H199jSnyj1hgGHihFzAyM+523GD+w2PaBS3tniqiw/goxpkN999ZP0lX88mn8y+c2gx0TCeFUNpYYEuP6tdnqfgtNlv4WvwTg5ZcDZvwd2pTMsoGZMkQr8i6/rpKOygzYlFQW2KvLl52+l0AfZbfbNQsVXl0kwyo35tFpcZLTCETWLNLlHizpcNvm9eO9XVVNpNJT2BXdR0E19C8t4soLSS1F9+psf2f9iK1wVvWLHEBT85H+qFDwTHMKyxhVq0CdjaQugBS4fe0pNSO2djyhhTtbdVAn8OhYiwyhz2zmHFA0He84C8Ij8f/7+eNShmfSL1DrouWyFD9DHKToYrzTmRGI4RHuWbW2a9bbmQ6di+SleUOeiEiJROLUxlcWRrs5Qp7fnYtbSjUTPqFvHg9Vag0URYkmfXeZO7bHvx8QQ4Awybesf8M+XZOWoZrS4/Mk5f/gKdA3GdFEX1GhnY5aBiGdkeW1dil7i68I6KOqu91F/ts2MTwkxHY6V7G1kLnSsrtL1n75NFU6kYN2KQCzhlI5RIZc3EV8/gG675aHujOfpxM+WQR5zYg9ScmjLVoBQwd8OxFTSZbHNRfam54KHGTcn+JIju7zLOvKcRZ9GALpla00afx6Sd+mUZluzgtGXUcpL8oxK6FGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(6916009)(6506007)(66946007)(41300700001)(2616005)(2906002)(31686004)(6666004)(478600001)(36916002)(8936002)(36756003)(4326008)(31696002)(66556008)(86362001)(66476007)(6512007)(6486002)(53546011)(38100700002)(5660300002)(26005)(316002)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVIzM2VBR0tMZmVBSXRDdmhmZnVnaFREejNvQjlQT1V1L1hFODllTGU4UkFD?=
 =?utf-8?B?dmFUMDRuVDNIUGd4UU9uS2o0elVsNWp6bGpoUFFNL2tzeFJFMDB2UTRsK3Rv?=
 =?utf-8?B?YjM3MGRic0pqVE1oUENrQWtDRWhvcDE4SEhEanlQWk1qUkJoVmNpVXczS0Fz?=
 =?utf-8?B?anJ6TXVMRUpmU2dzbFVlaWZ3d3FrcEcxc1p4c3lGTUV2S2VzdC8yRGN1MWty?=
 =?utf-8?B?Y2VOWDI5bzBTS3ZwN0p6ZkhKTUpna0d1c0doRkdmUHZ0NEtacUJDYm9odVVH?=
 =?utf-8?B?dVlSa0Uya0x4aThDM1JlaTh5THhYWTFOTUpFNWdWMkVLeXBydTdZVGdRNXBZ?=
 =?utf-8?B?bFBMU1JYZWdqQ1kxTVJVYy9ZL0dSOThPU1YrNDBoTS9ZdnIrR1ZkTmNvSGNM?=
 =?utf-8?B?SGRLRUtHa2hWSkFUYTgvQmNKeVdTRHhsT0pKM0JjZjJnS0RvZjkrSXgzYko4?=
 =?utf-8?B?MkZJK2xaM3hsMEpUN0QyZUxsQjNoVWJ4NEVHSlVKWG93QngwS2JDU09MS3d0?=
 =?utf-8?B?ZmROOFBKU2RqZDF6aXpZWG5McWM0enFVMjd3Q0JXMmZnOFB4U2FHVVZIWjVL?=
 =?utf-8?B?Rno0YkRuMnMzMGJsN3ZPdk5UWW90N3dTK0ptU1VHVlFnVFd6R2l6OUVWNCty?=
 =?utf-8?B?M0wzVVpYcW52RTFOdzBMRjFtUERudDNiLzFsa3FISlEzK29rVkNaclFKUUtz?=
 =?utf-8?B?Z01KbzNGelZZU0FGRjBCejB6eGl3d1pDQUoydFNSOGo0SW9nNTVpTisrTkNZ?=
 =?utf-8?B?dXdlYTFwQ0Q3UGlKSUkrNDRIUmt3TnIwRmFwRStFU0xnZENzZThMWThQU09s?=
 =?utf-8?B?NGUyNDdoTGlXWkZIaGlNU1Jyd3ZiZ1I1WUczakRlVnFnanFhRngzV24yNDNa?=
 =?utf-8?B?ZWp2MEFWdGdHZ3RiZ2ZjbWMvWVlWWHYwUzcrU3RBcDZkUXFDM1hCckVUQUl0?=
 =?utf-8?B?MkFMdERjNE9KYitReDhlQ0I5amxBdnk2WXJIMm04UDJHOEcyUUN6YVZMTUgz?=
 =?utf-8?B?Uy9vZUdiVWYrcWhpSjFxcXJnZThaNWc0RHZ6SjF2ZEZ0ZVphWUxEZTB3RExh?=
 =?utf-8?B?eDJVUTQyMkNzdlFzN3EySlpCaUEySnBML2ozSHpFcTY3aUF3QU9uNFhsZlJv?=
 =?utf-8?B?L25pcmxrMjhUYWxxM2N6SThTYXpkSnBMOTk1aDdCM3hWU2MvZnZXMGVvRXgx?=
 =?utf-8?B?Rk0rSHRWVFJpQ0lIaExTNjN5MjV2c0RGakk4V0hhK29DMG9mN0RyMUxjM1ZY?=
 =?utf-8?B?VXVZeHY4akFMOURrOTFPcXJ2Z3NwTE5xVDBDYmdJS3BFZTUvZVJPMVRWN3Vx?=
 =?utf-8?B?WEo1VG9lMFF0YkFUeDYxUUIvTWJSUVBLYS9kMmY2dHRLZVJtNFA5bDRBOEhK?=
 =?utf-8?B?bjZ3UkZjU0dDQ001dHVmczdDUGNiVGk5K0JqRERpMFRDR3E1Rkg3RzVhTTdw?=
 =?utf-8?B?eUkrR0pzMWdoTGpVNEVuVW9xem9NYzcvWlc2TnlIYjZaUFh5WWNqSktvaWRw?=
 =?utf-8?B?Ym42RFFYdmRUaXFtNmg4OG14ZDI3eVEyT0I4S20wcWpEZHVyVDdVaHJLOHRM?=
 =?utf-8?B?emJCSk1ZZ1pPKzltcU9lb3RUWlg2T0xWaHluR1puY044dGE5TjUyM2IranJu?=
 =?utf-8?B?SUViNUx0QnN6VGE5ZTI5Sm9OemIvdlVmcWcvd0dsNXV5VjhFS2tkM0tXS2px?=
 =?utf-8?B?cG9LQzI4ek9PQXFTTGZkSVN6dHY0aGpIVm4zbHFoWlE1UmxrVkEyNEt3aCtq?=
 =?utf-8?B?dmszSm9yeDVXaEtNVXlHZW1DeHFadWlhYkRpejBKM2F2RHI1cUtqaDlwRXhz?=
 =?utf-8?B?M3ljTmpweUZZQWt5QmxrUitVTEpSNzhuMDFLc25VYTFub3QzSFBrRU92TTNq?=
 =?utf-8?B?L016dk9vNmtTaFJUYzRMcnAwL1hTRUxKNFE3NmtHdThpYTVKYVZSamJ4aXZI?=
 =?utf-8?B?YlJHdG5wckExY2lETHMxV1pFc1Z0cHpKTzIzdHYvTjlxNkh5TCtPUVo3dmd1?=
 =?utf-8?B?WVE3UUR0QTNqNlBySmFWV2lZNzJKUDc0ZkVtWWlxVUVCSDkvcHluYjQ1S1dX?=
 =?utf-8?B?dnUzelNmK09sT0dGckpWUkZXTWlaRmEvdmZNV0xUQUxtdm9zYXlvZHB2MEdY?=
 =?utf-8?Q?fSzLEEzj1+/y0tt4NVzKtcCnJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AorPRnfAHZtT1S9klDoql1351VWkimTgT1FT0dKhuwCL+X7miWG1ha01v4cH38vlrh9gT4xHzwu2sRbyEb4IOuCTluUufKLU8WMKES2DFQbZJTd7fr1CsNWwdJD6N/tAyX6MNAhrHEp2jlVPd3ZuiPRKmB/MIsZZMkmrBnecxBQH1hqVBt/iEzHkVpeAd9sZyKsnCk8Zvi9WGtfY+V9ouMRXV6BmPTHVBnT+x/Pj0JntJnn6OHw9xqxDnDIZdfjls1APkl2n6ZAM5M+FU19JwThXQoT0TYKLIWA3ihtgzP7FJ49DY/IHmVfGvhM0ub/SLZDJlP05E1GgFB0BHjgLxyZRV8QzzFikKP/BEt7I/SsU0VQ6nH4uqbIX7YRxc/OGGo72MLHJdCBjQgAxsfBDGqKD9gn7z32+Z8Y2F3lK72bPWlAsWsCRIcoD1M1WjxOczCdyZDJWIv3J+ItpWsHolbTXjrS8D0Hsm4xaa1Yn4x6lx2nJ26EeQiIOYifL551Q9ItugNh+gUDuX9yT30edem0M2iRuKX9MIQ2NtWZtekXz2LLg+Cy4S7tI56h2Pm427/L1OPRnykDqYnt/DBDZoBQeF1/20LsmXg/5yQzxYnK1RVw+Rmm/k1BmaCWzohLKpuQ4q6Fgd/dpZQoF+pSTnl2TgoxyIPF8Cr4D7FUZ2085N4BtJbZdfCDyuptpdSFo9laXuyVbHJ21tWT7vgZ/pMAX5CU7Ku6NT81NAzUfkMaxYZ1hQpLQVTw+FUvJFyJ+gbdQpI3y6qB/fOUKxZconPqY1+upj7M94KkvoXXBu61+R23zH46i17yK08MWnfTcy6ZxgH/p66EHgXwlVNQJI/3FxgrOEVSKoR0i/5HTn+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebabce6-193e-411e-8c05-08db9deaf854
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:54:31.8794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fHjdgNaXQojT/K4/F75snVuJRpATqGVOjmdlyPSke9VMnnGhdni/CfETYyFKrImGYcNJgdzJaWaaBSYL6hUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_20,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150216
X-Proofpoint-ORIG-GUID: aS_Tqgbk8ziiPCJzw9H1WJI3JhPgHVMc
X-Proofpoint-GUID: aS_Tqgbk8ziiPCJzw9H1WJI3JhPgHVMc
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

CgpPbiA4LzkvMjAyMyA4OjQ5IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFdlZCwgQXVnIDks
IDIwMjMgYXQgODo1NuKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6Cj4+IFVzZXJzcGFjZSBrbm93cyBpZiB0aGUgZGV2aWNlIGhhcyBkZWRpY2F0ZWQgZGVzY3Jp
cHRvciBncm91cCBvciBub3QKPj4gYnkgY2hlY2tpbmcgdGhpcyBmZWF0dXJlIGJpdC4KPj4KPj4g
SXQncyBvbmx5IGV4cG9zZWQgaWYgdGhlIHZkcGEgZHJpdmVyIGJhY2tlbmQgaW1wbGVtZW50cyB0
aGUKPj4gLmdldF92cV9kZXNjX2dyb3VwKCkgb3BlcmF0aW9uIGNhbGxiYWNrLiBVc2Vyc3BhY2Ug
dHJ5aW5nIHRvIG5lZ290aWF0ZQo+PiB0aGlzIGZlYXR1cmUgd2hlbiBpdCBvciB0aGUgZGVwZW5k
ZW50IF9GX0lPVExCX0FTSUQgZmVhdHVyZSBoYXNuJ3QKPj4gYmVlbiBleHBvc2VkIHdpbGwgcmVz
dWx0IGluIGFuIGVycm9yLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAg
ICAgIHwgMTcgKysrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3Rf
dHlwZXMuaCB8ICA1ICsrKysrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+IGluZGV4IGI0M2U4NjguLmYyZTVkY2UgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IEBAIC0zODksNiAr
Mzg5LDE0IEBAIHN0YXRpYyBib29sIHZob3N0X3ZkcGFfY2FuX3Jlc3VtZShjb25zdCBzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdikKPj4gICAgICAgICAgcmV0dXJuIG9wcy0+cmVzdW1lOwo+PiAgIH0KPj4K
Pj4gK3N0YXRpYyBib29sIHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAoY29uc3Qgc3RydWN0IHZo
b3N0X3ZkcGEgKnYpCj4+ICt7Cj4+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0g
di0+dmRwYTsKPj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2
ZHBhLT5jb25maWc7Cj4+ICsKPj4gKyAgICAgICByZXR1cm4gb3BzLT5nZXRfdnFfZGVzY19ncm91
cDsKPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJlcCkKPj4gICB7Cj4+ICAgICAg
ICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+IEBAIC02NzksNiArNjg3
LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAq
ZmlsZXAsCj4+ICAgICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZmZWF0dXJlcywg
ZmVhdHVyZXAsIHNpemVvZihmZWF0dXJlcykpKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FRkFVTFQ7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9T
VF9WRFBBX0JBQ0tFTkRfRkVBVFVSRVMgfAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpIHwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX1JFU1VNRSkpKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RT
VVBQOwo+PiBAQCAtNjg4LDYgKzY5NywxMiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9j
a2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPj4gICAgICAgICAgICAgICAgICBpZiAoKGZl
YXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkgJiYKPj4gICAgICAgICAg
ICAgICAgICAgICAgICF2aG9zdF92ZHBhX2Nhbl9yZXN1bWUodikpCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+ICsgICAgICAgICAgICAgICBpZiAoKGZl
YXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKSkgJiYKPj4gKyAgICAg
ICAgICAgICAgICAgICAhKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfSU9UTEJf
QVNJRCkpKQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4gKyAg
ICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVND
X0FTSUQpKSAmJgo+PiArICAgICAgICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9oYXNfZGVzY19n
cm91cCh2KSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+
PiAgICAgICAgICAgICAgICAgIHZob3N0X3NldF9iYWNrZW5kX2ZlYXR1cmVzKCZ2LT52ZGV2LCBm
ZWF0dXJlcyk7Cj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+ICAgICAgICAgIH0KPj4g
QEAgLTc0MSw2ICs3NTYsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlcCwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVz
IHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpOwo+PiAgICAgICAgICAgICAgICAg
IGlmICh2aG9zdF92ZHBhX2Nhbl9yZXN1bWUodikpCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpOwo+PiArICAgICAg
ICAgICAgICAgaWYgKHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAodikpCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJ
RCk7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1
cmVzLCBzaXplb2YoZmVhdHVyZXMpKSkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHIgPSAt
RUZBVUxUOwo+PiAgICAgICAgICAgICAgICAgIGJyZWFrOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlw
ZXMuaAo+PiBpbmRleCBkM2FhZDEyYS4uMDg1NmY4NCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS91
YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0
X3R5cGVzLmgKPj4gQEAgLTE4MSw1ICsxODEsMTAgQEAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9y
YW5nZSB7Cj4+ICAgI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCAgMHg0Cj4+ICAgLyog
RGV2aWNlIGNhbiBiZSByZXN1bWVkICovCj4+ICAgI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfUkVT
VU1FICAweDUKPj4gKy8qIERldmljZSBtYXkgZXhwb3NlIHRoZSBkZXNjcmlwdG9yIHRhYmxlLCBh
dmFpbCBhbmQgdXNlZCByaW5nIGluIGEKPj4gKyAqIGRpZmZlcmVudCBncm91cCBmb3IgQVNJRCBi
aW5kaW5nIHRoYW4gdGhlIGJ1ZmZlcnMgaXQgY29udGFpbnMuCj4gTml0Ogo+Cj4gcy9hIGRpZmZl
cmVudCBncm91cC9kaWZmZXJlbnQgZ3JvdXBzLz8KWWVwLCBJIHdpbGwgdHJ5IHRvIHJlcGhyYXNl
LiBXb3VsZCBiZWxvdyB3b3JrPwoKIkRldmljZSBtYXkgZXhwb3NlIHZpcnRxdWV1ZSdzIGRlc2Ny
aXB0b3IgdGFibGUsIGF2YWlsIGFuZCB1c2VkIHJpbmcgaW4gYQpkaWZmZXJlbnQgZ3JvdXAgZm9y
IEFTSUQgYmluZGluZyB0aGFuIHdoZXJlIGJ1ZmZlcnMgaXQgY29udGFpbnMgcmVzaWRlLiIKCj4g
QnR3LCBub3QgYSBuYXRpdmUgc3BlYWtlciBidXQgSSB0aGluayAiZGVzY3JpcHRvciIgbWlnaHQg
YmUgY29uZnVzaW5nCj4gc2luY2UgYXMgeW91IGV4cGxhaW5lZCBhYm92ZSwgaXQgY29udGFpbnMg
bW9yZSB0aGFuIGp1c3QgYSBkZXNjcmlwdG9yCj4gdGFibGUuClllcC4gSSBjaG9zZSAiZGVzY3Jp
cHRvciIgYmVjYXVzZSBwYWNrZWQgdmlydHF1ZXVlIGRvZXNuJ3QgaGF2ZSAKInBoeXNpY2FsIiBh
dmFpbCBhbmQgdXNlZCByaW5nIG90aGVyIHRoYW4gZGVzY3JpcHRvciB0YWJsZSwgYnV0IEkgdGhp
bmsgCkkgYW0gb3BlbiB0byBhIGJldHRlciBuYW1lLiBJIG9uY2UgdGhvdWdodCBvZiAiZGVzY3Jp
cHRvciByaW5nIiBidXQgdGhhdCAKbWlnaHQgYmUgdG9vIHNwZWNpZmljIHRvIHBhY2tlZCB2aXJ0
cXVldWUuIEFueSBzdWdnZXN0aW9uPwoKVGhhbmtzLAotU2l3ZWkKCj4KPiBUaGFua3MKPgo+PiAr
ICogUmVxdWlyZXMgVkhPU1RfQkFDS0VORF9GX0lPVExCX0FTSUQuCj4+ICsgKi8KPj4gKyNkZWZp
bmUgVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCAgICAweDYKPj4KPj4gICAjZW5kaWYKPj4gLS0K
Pj4gMS44LjMuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
