Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737C6CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 06:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 905FA404AE;
	Thu, 12 Oct 2023 06:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 905FA404AE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=OvAtjjCA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0CXK1Nlv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uk4TCMPtIxZV; Thu, 12 Oct 2023 06:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B162040339;
	Thu, 12 Oct 2023 06:19:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B162040339
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CDBFC0071;
	Thu, 12 Oct 2023 06:19:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E48FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 06:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 624FC41522
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 06:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 624FC41522
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=OvAtjjCA; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=0CXK1Nlv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yr4SUHBtkY9b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 06:18:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0483409F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 06:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0483409F0
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BKTZj8031167; Thu, 12 Oct 2023 06:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=OvAtjjCAAt0KtyQDLOTs6INQBjQNNNrLvsd390mr0bbXR0FAkYcV+gmMfey/P1ph69iU
 NeS9UgbSdBetwKUOvH3WkfZD7qhh4HPyaJT+Voldriywpu8WBbKdqCkNoB9RNziDXYHm
 NhDy6uvy0MVTUrAclYhQzlRnBqYHRvFasX9lo7RHEsDRl5ZNbHjVW+fD+Tu6O4f9Bxpi
 0YNNVvRPgN0UlHFi9G2qN4aQ4T+Jx4L2iefGM+DshfnSFaH5SivNW9ofrSaaKOEZx+QR
 tIVO3FLw2HZv6plazeNJhARo/+SB1G3Jb2QnVBwVLegj94z0w3XINviG7BcJnTZ9qJ7u JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh90y9ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 06:18:53 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39C51hxc020140; Thu, 12 Oct 2023 06:18:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tmfhsxag9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 06:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fygFY+Gu4enVL2FW4LnYA3aeUP3uEmEfPPqymId7DQzfE4x0H2Mol00fR53zv6jwMGMSHElHEmUmMjOvNGa/JBYlrwp2/cbLqhTliaB60VPf+IW9vFcpFG0vgtFGH6OKHj0Pzgm+kM6n3F10AzESu2PT9N10B0fSpGUSyemRh/TDXq7AH8cUE0SY6icjmJJVUzMxblHR7FWFBfViey6tt9AlWSOpvJF0BRy+6hg0/QgM9ZsGp+NexbM+qfM1+HP/P4pRWg0LIMUCCwBsbRnfyuGKXQ8eh68Gfwk+Gnfm+Vb5iJpFHcbB2+AmvZnF6tYPv5iLSJ5976Z0Q/co2L0KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=jAnBRYzerh1ifEeOBWd30zUctyEy59xEgoDZxF44dUdiPdhCNrkcdfVj41LDFAA+Y35wneOR/f/LzrsE42WovD6SaTWtnxLmjRDyyYZ1rmEXsctzviQgVvMCV5UpAo6hkEcJBfFGe5zuijFzr11MJ+EUC9h+NRF9mse2QGNt6tMhyriJXMkcPplLIOAae8oFDS8GUpsYF/4W+MOUHGmo4ZTRvlgrvAvWbz1wrriOIldY3gMDnoWpLItLpidQpbCPV0Ro2CDEW+9aTCieY/e6PF7zcrFyNGL/ecrXdzuRlU5fTz2x5ybDiH/IG28qa3P43YFnkfdfw5Q4tNQqaWcJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=0CXK1Nlvez/5Zr4LKPaXGcf1e5ty+vI6ChpMRmJ6EYLrX1eEw8nNcnhILqaNrLMYqSwsXcp41WrxTtVdPBodrm5YCI1hVXlxd+H33LPEBr3/s2JyCnCGz3x7pt7D+Nv8UYr8mPx0rtTltTA5geFPhOUJ1VYvzRWOoeygxM7GuD4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB5717.namprd10.prod.outlook.com (2603:10b6:a03:3ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 06:18:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 06:18:48 +0000
Message-ID: <f16baa51-d545-48a4-a46c-88b152339d85@oracle.com>
Date: Wed, 11 Oct 2023 23:18:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWe=RwotkcNKFuStvX=HxQh6sdtfsH23jhf994eXi3-2Og@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWe=RwotkcNKFuStvX=HxQh6sdtfsH23jhf994eXi3-2Og@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: b9479592-ed2f-449e-e641-08dbcaeb1896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRzxyFRnBa3X23oaASGjsmnqlEsJP/ol52KOBbQusnuU1r4ZHXIfClm0LiE031dvK1ZCHWbpFcjPBjF/6jc7Pb7Tj9ThL1zKQUlRXnHyKrnEaaIWg+SIFk7SRt8uOMm1/l7yZzpEXBl3hin6yyj1xhU3r9hC+ae/0YpTET3LZC/iFSZBbBfsemUnt1BEFocSFMCEoJ3/zkZ3iSrn/nYGbxYo7cGM8t5F2kYRVlNWlal5DMDpWaYu3I2PTplkigESvBUtzMLC/ogVZByoHo6JPEozUTXfKoRnbrXBkrQaBnrsCuT8kik8UBnXxFMeVxpGfY1viEPKMvt9c8z54FHsQqHYQ4RPTa4n300xotsgrDHxGyT8DJAvR7AIqplu9IHlYuS/ylD48YhltTXmQ8RJi4c191h/dOEt+Ryot3gVZjZFDjboDCafsBbBUCfJLNumNXiTmsUbo+17oQ/EpXKjm/EVs3RGgl/gSN9NI8DfSlpFMqjvau8GRKvcn9tsKepE9nNN6qiCxZ0DJvS1JTVn6QNm82Sts6GkzGMDm0haf5m+gXDQc4QT5xxnU/C2gjtutotCdO2n92frnTtwbb202yD1o6E7OGHA9y7jzl8QLPiec3rsRZSIi1xDd04Aea72zw/H8DvqDRrkttX1lcSQpx85BDmW/x3t14SoAzMvuGwTsrzGTwUyqobshxskEuMs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(86362001)(6486002)(2906002)(8936002)(31696002)(8676002)(5660300002)(478600001)(4326008)(36756003)(83380400001)(26005)(31686004)(41300700001)(6512007)(316002)(6916009)(6506007)(36916002)(53546011)(66946007)(66556008)(66476007)(2616005)(6666004)(38100700002)(66899024)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGNjY3RuZHR4NHlJNVFSWUhnVzk1bEZXQjk0dWRxYTlHbm5raG13dThWMnFG?=
 =?utf-8?B?VElHZ0xycFJjd1JHdnhXanJvaEp0Y2VSRkFneldFRStFMmgrNi8yTk5RcGxL?=
 =?utf-8?B?M1QwU09acmxuWEpFRndHVmM2Rk9GVUVQSTg0cDhQWHF2RnpYNUsvY2hQUEpO?=
 =?utf-8?B?T3Y3SnZYNFdWRmZRMWd0aWZkRllSTlVCVFAvZUxxMW9hZ254TTQzQmlmemRq?=
 =?utf-8?B?L0xaYVQ3dmdPRFp3RTJXRjFEck9iNjNTclRWcmQ2R2tNYkpKVFdGVkpGZkVL?=
 =?utf-8?B?d1BvQUloTGdDMU1ibnVmb2swM3dIcGdFby9mM0pkS3BVQVNkMWNQNm5MSm5n?=
 =?utf-8?B?ZUl4Mm84cGV2NWd3c3hsVEE3UmJOVnZ4M29QVitZVmF1OFFQTjVTakY5T0xp?=
 =?utf-8?B?QnA5LzRzeUFnNXBGcytYb3dtYkRYb3l0S1RhTVRMaHlYb2o1eTN6Wnd0TmlD?=
 =?utf-8?B?bmM2V2RvcjFKOENvTjhXMmtiOEpCQ0FlSlNWcjRyVlFQQ3NrdWtJbHdlQUIz?=
 =?utf-8?B?cWJKN2lTdzYxMDAxOHdpcVFjd1UzcHh1bmI5S2lWVkpuOVBNM3F0dW5ybUky?=
 =?utf-8?B?aEFRSGVJS1NkVmJiVVdhQ3liV0ZZcUtNRkF6WDFnaktXSVh5dHY1WmV1UFlP?=
 =?utf-8?B?MkhJNytkbjdyZVZ6NlF5dGx6Y1ZWYmZJaVBVUVpQeDB5MDd4SDk5TmFtc3FK?=
 =?utf-8?B?ZDcrNWVJdzljV3ptNjZoOTlsVllBR2ZOTkNvM2FYT1Q4eitTWUcvMzZ0Ty9H?=
 =?utf-8?B?RHBLa2QwclRsQ3o0L3UzbyttbjNZbG04MTV1cFFLVWhOdS9jMGhJWjBBQ1Rw?=
 =?utf-8?B?aFZhb3F0OW1BcG85YUJCUkF4cDBDcDNQMldwa3hMTmdKZlRCSC9FWGVFZ050?=
 =?utf-8?B?cnYvUzR3Nkl6ZTB2c2RkdnJTWTZzRFlBSUxEdnQ5cm5Lc1p5WXl6c0lCdi9i?=
 =?utf-8?B?Z00rbFJOekdoU1daa0M4azRGVHBMYlpwbnc5SVRYcEN1cG5hL0lsaE1relh5?=
 =?utf-8?B?SHpmTi9FYUZhcHdJR1hLYm1ueTR6RmFJQVRGM0J5c20yanRpb3JZbUg0RHYr?=
 =?utf-8?B?RlhmQUdPQTJxN1RvZkNkZXROZUR6ZndNN2UvWFg1WGNkMHBwRmd2RmFCRzdR?=
 =?utf-8?B?RlBDTkJaUHFzVFpPSGxVZVBucjFKeWN0VDY4Snd2MyswQVp1RTViSkZvYmYw?=
 =?utf-8?B?NTBzOG5aRlNiRERmZFNTblFiRG1MdUMyL2hmT3dnQmF5SzNrVk90OENWcmJv?=
 =?utf-8?B?M1VqMktaSDJ4cFdBV0kvZjBWaXpNYmNpQytQUlhqN1lZS3R6WjdFTVlYV3hq?=
 =?utf-8?B?S1o0WTFuRDdGc3R4K2laMXJPM1FHRmpHZ0pUUjlDamxsZ1hUaEhITjJKcncr?=
 =?utf-8?B?T0VzV0QrVVhlbm41emp0ZEc1RCthbTVHRktLNUx1cEFNWm1kNUxmeDdPNks1?=
 =?utf-8?B?NUlWZzNEN0pCeGxsSWo0NWtHWVlDd0tFS0xBcm93cUF5TnpPZ2tSekdaTzhF?=
 =?utf-8?B?RDkyNTNlZVFjZ25haXp4S2hZL2JObS80VDF6TmFjMnBYVEhYQnJTU0xwODdC?=
 =?utf-8?B?cGIxcmtxckN4NURVenkrd1NhZTF0Mjl3SDBqeGd3MVpkRWF2TnFoNUFwVU5a?=
 =?utf-8?B?Q3NseE1pcE1MbjNUaktUVTJFRWk5TERuWjgvUUljcHB0NzluNDRyOVhJQjlO?=
 =?utf-8?B?eTU5ZWp5VXFTSzBTMjJ4U1QzeFRxSWR0c2N2TFhpZldvRzZ5UTlHT1hGWWxz?=
 =?utf-8?B?UjRsY1Jzd3Ara0w0LzB2UWppdTRWKzkvVUZwcXNXSC9MNUQ1SWJjZGJtNG1B?=
 =?utf-8?B?SEdiczFndURSVzdLMHUvUm5IT0hwdWpYNjgrNHp0dE13cFYwcjdxbFJrdXpn?=
 =?utf-8?B?K280d1piMkNxL0VOTmVHLzhRVVN6ZkNQTDR3TmtSajB6QUxMdlQrb21BUEJX?=
 =?utf-8?B?dWVyNlRxUDdqZVlPT3dQRTcza0lYYVF4WWNtN0dzV2tCbitkMm9RTjhmWnhi?=
 =?utf-8?B?a1FtNDZrS3dmR05tM0YvTjdBNWpMdFF1UEJzSlRkUDFSL2FES1k0MWZNS2ZS?=
 =?utf-8?B?bGVmTENpYlZHTmN6Z3grNDlIekUwY1N3S25zOEw0RUFLbnZ0Q2ZnOXowTUJI?=
 =?utf-8?Q?1JqMo+Cy718DIydFe2ZG5Vx2Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TXN1eWI5SGlDcnFSQkNPL2ZoTUpOTjFkcTBXU1FhRUhFbUxBVGxnSFJzOXBm?=
 =?utf-8?B?dVZybStxVU50RnE0T093WTF1bFJIZTFqZ0NiczJIUUJwNVp1WEtKQjg1RnJY?=
 =?utf-8?B?cEZURjFHa1NoRy94YmExZzdaOElST1lYSnhPcWN3MzVZdjc2MnFPeExLc0Zt?=
 =?utf-8?B?SFB5ZnY3ZXB2b1FNUVRUTGs1cm52OEc4V2N0RnVqUFJwWC94L3NHcE0wb1Vw?=
 =?utf-8?B?RGhsSXNlZjdTNkx5Q3FXalZrWG9NTUNPVHE0eG5kRGlYV1hxSjRpazBLQktR?=
 =?utf-8?B?Y3hGanJpRjliaTlyY2ZGZ0Q3RFYwTHZSQkdZUXRCeUVFcElQR1Z1bUNlNzBN?=
 =?utf-8?B?QXVDc0xQamwxa2FxUUg0T3N1bDV6QW5jN3hTQU91VklwSW15bEhuTTJyMngw?=
 =?utf-8?B?dGdLWTRLWS95ZnZ6RE9OUy9jempaNDZSWGpXd3VvanpyNnpmalRZelVWOWxm?=
 =?utf-8?B?UUNmSE1ZQWFIRkoxWkovZ1Y1bTVwb2tUQWZqZWVIOHhlQ2JRMDYyV3JwWHln?=
 =?utf-8?B?eWRrSkpzYTlSVWVlSkViWlI1a2dOTnZ0Z1p6VGllaU1ySTRFbUtZQ08xOG9I?=
 =?utf-8?B?VXkxbG00RGs2Y051UGdNWXhSbHJoUlRQdldPQi9pQ2FFWnBSSzJpZUZNM25S?=
 =?utf-8?B?LzFJWFdqRE81Y05pV2tLeTlvSVc3WDhsZkpldmNiS3Z4UVNFc2FtMHBjT001?=
 =?utf-8?B?Z1BiTmR4K3VZU2x1L044NVlzc29FVENXWFlCTlZMVDFPTld1dVN2bkFBQTN4?=
 =?utf-8?B?QUNPanBuWVA0dVB4RmxCT3pyMkRLdFhnL3MydWpvMi9hUVlkQWg4WEpNbHBq?=
 =?utf-8?B?Nk1yN0RxZjdvUDlCQVRCSkNRTk93bEhiN2hnWjdnZlNFeGtTTlh4SEtrVGF0?=
 =?utf-8?B?ZlgwdlVSdWszcGNpdS8wMExzVkNlcS9VdFpmS2p0RS81czFZNEIrd3kvRExC?=
 =?utf-8?B?THIvSjV0cmFkdU9jeVdGTlFsdStTNDBkTW1JU1FGL0NNRDNxaTFZbE55Ym1M?=
 =?utf-8?B?WGxiS3ZYSWZKYTJMM0dVbzhUeXVzVktNWDNtaFlablVTbVcwaHdBQzV0eFJx?=
 =?utf-8?B?Kyt1VmQyT2s0SGpDWndjUDRITDBGczNHZzRZVjN4MkRxcFVwVGdzYzh0TzAr?=
 =?utf-8?B?SnpoQS9ob3h4blVFQldWRkxuVWVyY1VMeDBsRGtSUk96Ty9XNDJqbzZKTUhU?=
 =?utf-8?B?eU5tNkppZTkyTlFUejhpTVJHRk5sNmd3Nnl5bG1lKzJsRnZEUUozdW8ya1J5?=
 =?utf-8?Q?OL+hZmaYFuEAjGV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9479592-ed2f-449e-e641-08dbcaeb1896
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:18:48.3459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WIk/pwXDMZCYvxQRQekpTlPNmLI22fIg2gCbzSEaFPJ0MrqR14GVgGDGoggTAFoExERwE+TBZgeWl7mke3h+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120054
X-Proofpoint-GUID: DuuqGvZwp97mgX1S6ju3_eUDdl3iWm3m
X-Proofpoint-ORIG-GUID: DuuqGvZwp97mgX1S6ju3_eUDdl3iWm3m
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiAxMC8xMS8yMDIzIDQ6MjEgQU0sIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDExOjA14oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPj4gRGV2aWNlcyB3aXRoIG9uLWNoaXAgSU9NTVUgb3IgdmVuZG9y
IHNwZWNpZmljIElPVExCIGltcGxlbWVudGF0aW9uCj4+IG1heSBuZWVkIHRvIHJlc3RvcmUgaW90
bGIgbWFwcGluZyB0byB0aGUgaW5pdGlhbCBvciBkZWZhdWx0IHN0YXRlCj4+IHVzaW5nIHRoZSAu
cmVzZXRfbWFwIG9wLCBhcyBpdCdzIGRlc2lyYWJsZSBmb3Igc29tZSBwYXJlbnQgZGV2aWNlcwo+
PiB0byBzb2xlbHkgbWFuaXB1bGF0ZSBtYXBwaW5ncyBieSBpdHMgb3duLCBpbmRlcGVuZGVudCBv
ZiB2aXJ0aW8gZGV2aWNlCj4+IHN0YXRlLiBGb3IgaW5zdGFuY2UsIGRldmljZSByZXNldCBkb2Vz
IG5vdCBjYXVzZSBtYXBwaW5nIGdvIGF3YXkgb24KPj4gc3VjaCBJT1RMQiBtb2RlbCBpbiBuZWVk
IG9mIHBlcnNpc3RlbnQgbWFwcGluZy4gQmVmb3JlIHZob3N0LXZkcGEKPj4gaXMgZ29pbmcgYXdh
eSwgZ2l2ZSB0aGVtIGEgY2hhbmNlIHRvIHJlc2V0IGlvdGxiIGJhY2sgdG8gdGhlIGluaXRpYWwK
Pj4gc3RhdGUgaW4gdmhvc3RfdmRwYV9jbGVhbnVwKCkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNp
LVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aG9z
dC92ZHBhLmMgfCAxNiArKysrKysrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJp
dmVycy92aG9zdC92ZHBhLmMKPj4gaW5kZXggODUxNTM1Zi4uYTNmODE2MCAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4g
QEAgLTEzMSw2ICsxMzEsMTUgQEAgc3RhdGljIHN0cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92
ZHBhX2ZpbmRfYWxsb2NfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICAgICAgICAgIHJldHVy
biB2aG9zdF92ZHBhX2FsbG9jX2FzKHYsIGFzaWQpOwo+PiAgIH0KPj4KPj4gK3N0YXRpYyB2b2lk
IHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPj4g
K3sKPj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+PiArICAg
ICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4g
Kwo+PiArICAgICAgIGlmIChvcHMtPnJlc2V0X21hcCkKPj4gKyAgICAgICAgICAgICAgIG9wcy0+
cmVzZXRfbWFwKHZkcGEsIGFzaWQpOwo+PiArfQo+PiArCj4+ICAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3JlbW92ZV9hcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIGFzaWQpCj4+ICAgewo+PiAg
ICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqYXMgPSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+
PiBAQCAtMTQwLDYgKzE0OSwxMyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPj4KPj4gICAgICAgICAgaGxpc3RfZGVsKCZh
cy0+aGFzaF9saW5rKTsKPj4gICAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCh2LCAmYXMt
PmlvdGxiLCAwVUxMLCAwVUxMIC0gMSwgYXNpZCk7Cj4gTm93IEknbSB3b25kZXJpbmcsIGRvZXMg
dGhpcyBjYWxsIHRvIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAgc2V0cyBhCj4gZGlmZmVyZW50IG1h
cCAodmlhIC5zZXRfbWFwKSBwZXIgZWxlbWVudCBvZiB0aGUgdmhvc3RfaW90bGJfaXRyZWU/Clll
cyBhbmQgbm8sIGVmZmVjdGl2ZWx5IHRoaXMgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCBjYWxsIHdp
bGwgcGFzcyBhbiAKZW1wdHkgaW90bGIgd2l0aCB6ZXJvIG1hcCBlbnRyeSBkb3duIHRvIHRoZSBk
cml2ZXIgdmlhIC5zZXRfbWFwLCBzbyBmb3IgCi5zZXRfbWFwIGludGVyZmFjZSBpdCdzIGFsd2F5
cyBhIGRpZmZlcmVudCBtYXAgbm8gbWF0dGVyIHdoYXQuIEFzIGZvciAKdGhpcyBzcGVjaWFsIGNh
c2UsIHRoZSBpbnRlcm5hbCBpbXBsZW1lbnRhdGlvbiBvZiBtbHg1X3ZkcGEgLnNldF9tYXAgbWF5
IApjaG9vc2UgdG8gZWl0aGVyIGRlc3Ryb3kgTVIgYW5kIHJlY3JlYXRlIGEgbmV3IG9uZSwgb3Ig
cmVtb3ZlIGFsbCAKbWFwcGluZ3Mgb24gdGhlIGV4aXN0aW5nIE1SIChjdXJyZW50bHkgaXQgdXNl
cyBkZXN0cm95K3JlY3JlYXRlIGZvciAKc2ltcGxpY2l0eSB3aXRob3V0IGhhdmUgdG8gc3BlY2lh
bCBjYXNlKS4gQnV0IC5yZXNldF9tYXAgaXMgZGlmZmVyZW50IC0gCnRoZSAxOjEgRE1BIE1SIGhh
cyB0byBiZSByZWNyZWF0ZWQgZXhwbGljaXRseSBhZnRlciBkZXN0cm95aW5nIHRoZSAKcmVndWxh
ciBNUiwgc28geW91IHNlZSB0aGlzIGlzIGRyaXZlci9kZXZpY2UgaW1wbGVtZW50YXRpb24gc3Bl
Y2lmaWNzLgoKPiAgIE5vdAo+IGEgYmlnIGRlYWwgc2luY2Ugd2UncmUgaW4gdGhlIGNsZWFudXAg
cGF0aCwgYnV0IGl0IGNvdWxkIGJlIGEgbmljZQo+IG9wdGltaXphdGlvbiBvbiB0b3AgYXMgd2Un
cmUgZ29pbmcgdG8gcmVzZXQgdGhlIG1hcCBvZiB0aGUgYXNpZAo+IGFueXdheS4KWW91IG1lYW4g
d3JhcCB1cCB3aGF0J3MgZG9uZSBpbiB2aG9zdF92ZHBhX2lvdGxiX3VubWFwIGFuZCAKdmhvc3Rf
dmRwYV9yZXNldF9tYXAgdG8gYSBuZXcgY2FsbCwgc2F5IHZob3N0X3ZkcGFfaW90bGJfcmVzZXQ/
IFllcyB0aGlzIAppcyBwb3NzaWJsZSwgYnV0IGJlIG5vdGVkIHRoYXQgdGhlIHZob3N0X3ZkcGFf
aW90bGJfdW5tYXAgYWxzbyB0YWtlcyAKY2hhcmdlIG9mIHBpbm5pbmcgYWNjb3VudGluZyBvdGhl
ciB0aGFuIG1hcHBpbmcsIGFuZCBpdCBoYXMgdG8gYWxzbyAKbWFpbnRhaW4gaXQncyBvd24gdmhv
c3RfaW90bGIgY29weSBpbiBzeW5jLiBUaGVyZSdzIG5vIHN1Y2ggbXVjaCBjb2RlIAp0aGF0IGNh
biBiZSBjb25zb2xpZGF0ZWQgb3IgZ2VuZXJhbGl6ZWQgYXQgdGhpcyBwb2ludCwgYXMgCnZob3N0
X3ZkcGFfcmVzZXRfbWFwKCkgaXMgdmVyeSBzcGVjaWZpYyB0byBzb21lIGRldmljZSBpbXBsZW1l
bnRhdGlvbiwgCmFuZCBJIGRvbid0IHNlZSBjb21tb24gbmVlZCB0byBvcHRpbWl6ZSB0aGlzIGZ1
cnRoZXIgdXAgaW4gdGhlIG1hcC91bm1hcCAKaG90IHBhdGggcmF0aGVyIHRoYW4gdGhpcyBjbGVh
bnVwIHNsb3cgcGF0aCwganVzdCBhcyB5b3UgYWxsdWRlZCB0by4KClJlZ2FyZHMsCi1TaXdlaQo+
Cj4+ICsgICAgICAgLyoKPj4gKyAgICAgICAgKiBEZXZpY2VzIHdpdGggdmVuZG9yIHNwZWNpZmlj
IElPTU1VIG1heSBuZWVkIHRvIHJlc3RvcmUKPj4gKyAgICAgICAgKiBpb3RsYiB0byB0aGUgaW5p
dGlhbCBvciBkZWZhdWx0IHN0YXRlIHdoaWNoIGlzIG5vdCBkb25lCj4+ICsgICAgICAgICogdGhy
b3VnaCBkZXZpY2UgcmVzZXQsIGFzIHRoZSBJT1RMQiBtYXBwaW5nIG1hbmlwdWxhdGlvbgo+PiAr
ICAgICAgICAqIGNvdWxkIGJlIGRlY291cGxlZCBmcm9tIHRoZSB2aXJ0aW8gZGV2aWNlIGxpZmUg
Y3ljbGUuCj4+ICsgICAgICAgICovCj4+ICsgICAgICAgdmhvc3RfdmRwYV9yZXNldF9tYXAodiwg
YXNpZCk7Cj4+ICAgICAgICAgIGtmcmVlKGFzKTsKPj4KPj4gICAgICAgICAgcmV0dXJuIDA7Cj4+
IC0tCj4+IDEuOC4zLjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
