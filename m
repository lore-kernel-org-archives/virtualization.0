Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91BC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 23:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABA73415C7;
	Tue, 16 Aug 2022 23:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABA73415C7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bgyvOFXK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xGeHBhqy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6pjLrZ9cLfM; Tue, 16 Aug 2022 23:15:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC276408D3;
	Tue, 16 Aug 2022 23:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC276408D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8BD1C0033;
	Tue, 16 Aug 2022 23:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56365C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C2A0826DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C2A0826DF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bgyvOFXK; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=xGeHBhqy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ltOcVkqGuszi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F19181BB2
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F19181BB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:15:13 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GMxlxO026249;
 Tue, 16 Aug 2022 23:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZrE9JMovCrb8mkiopxrtFB0sPA9ltNwJqW6j9NdVX/Y=;
 b=bgyvOFXKIQt7OA24wrvPrNbmoyZ5jpPEzupkiJaZiUL52M3StSojoKE85zVWUuEh551t
 s5t8Sz8QX+cU/76/bC5IAZGGbL7l72rpFFkKFxQTB+ctugk/IBr1OuiR+tBLiTmLY1jf
 etQxq4A62jmplA2HMiepAvIPBXjHsiogWdl8zFKM+ATKbi3TXzEvRXSmfyo4S46FKaMl
 J6oEaZWZ16E9tcFZGNFZe386vCNjUFwL4ZImeo28EcZ5yxPSEjart6oJYcnO9YH8oA+C
 G5v08PUuw0nU/eDOodMq8Wb62VI8hSDJ0FkcftJ4aR65YFVXrl1k536J+1WYFSM7MH8H /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2r2fjne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 23:15:07 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27GMsaRf029034; Tue, 16 Aug 2022 23:15:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d2y84j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 23:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syagn+tlk6p3Az/g50xEyV2Q9wdZboBCN9AXsoIQJ8rcrT3S8n0pNmlNK0pT0vHUroy31H8sRp05YfIgkpr0NOQ8sRyj3dQbsdHrfUVb7kiy9kcwW8gODgi6VKrUizPLyBzt65r+GAQEXltG8FfqJvSXo7ySHFZl2FqezHf3pek0cadLhqKVitj0w0zsqXBlz43xe8xxAGSmRv5gfvgGEuf61Q/xI6Aqo71Ez3sv6VKCchlwekf3ghdxl7jK97uguxRq7/s37MaLElcUytkKXdLahMC/xKUsDTFE1P0J1hpZEflgJSQRLHkEcDIzccLbiFwpQJdimuuBdvU6EIL7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrE9JMovCrb8mkiopxrtFB0sPA9ltNwJqW6j9NdVX/Y=;
 b=TSUWMjrexMCRwBLjnFOF+hFMcY+9tWb9d4bgpZZGgbnvlmCiyEh5bTHQpBtF0eSNS3Ya3X7nsaGrOPwq5TPHxm+rCnUO9y4YhZskswLPUtIWoN5RkNgcJaQBDGqDQ8xHq8rkSTAUmaUvB1cPNismNRDjmX5MEh6Xa81C+hFXLz4y/0Kj/2njaOa0wevWdPW+PqHv1yLNEPeUdVu74FbgHZa9MCKgxp21NFIit6QNmrsM6cmJ6J5zinblYKVpUFhK9ShYKvsSorMR/moQsfn1Wvma44tQ2vMg7Zf9AeUShHhmriYIcRsK4VP8wDIvDLR2DotFCTphbWJxPQREAMvozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrE9JMovCrb8mkiopxrtFB0sPA9ltNwJqW6j9NdVX/Y=;
 b=xGeHBhqyfNj/xVPn0/JUVuzIaQBjPteGjqjGYAdY2EEjG/QQwtzsxrBDjRjwWoGa6xLoC5WjM42Yc9cgfArmSyVaj+NdHmmB2Q3AVyP7tcuBnriHDSaBzENXDTXn6SV5dRLDplLUD4+D9pbn+LmBUO4fsfsGx9OPhWI9/KeBgfI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB1257.namprd10.prod.outlook.com (2603:10b6:4:f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Tue, 16 Aug 2022 23:15:04 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 23:15:04 +0000
Message-ID: <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
Date: Tue, 16 Aug 2022 16:14:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
X-ClientProxiedBy: SA9PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:21::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4585a6fe-2e79-4635-ae1b-08da7fdd26b3
X-MS-TrafficTypeDiagnostic: DM5PR10MB1257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0oY34z1Ym03iwRynxfiwmqlXVuwBUuSTmOW5OS0AfC0GhQi04TFmVjmaRP5qqGTmt4AvmaWK6Ngi4uQu27j1Gis6hivbYovYyPE2u4uFYzq276VT4jrEqe+M29+j45ZdXCL2mqFed6s5P/ZU64GkkHs38OTmJ3rmJd/AfiZqX6pasnm9oUO9vwbQkl2CiBhZ6JV0pLbvR7XtokYHFFr2szC/XuSEVp++lqK1yQtvY+OSLIC9Tk3BMoaHV4Kl/1aWfhK6NIRhBS19xteLgMFnIL3xX+BQiRPSfwg5vxoqsaV0otIdWXZ9o31HzL/QdFTYu0QOfhlmBDGP6gBZCKthSSLLwAyai3+b/VBVQl5elKEgcbtU/g3zuMA90+ux6rZi7332RquTAvym/5uL+gGpiwqlXRFYA+2Wvu7EOheq38Wg7mKUPvaiCEHlC+2ZaYPZjNKLcoqVr7HEdLbnSTHCcs8ZkeEdPaG3jGwA5LL+0O0ptPNCBZ91rmP1jKGvSd8nNmmuCWtN9zkVzXr5JqQkfGs01CNXOymZ/6Og6kztyLKn5sEMiNTN8kf64ZHOIsPlaHuls2Tj+315DerIo3zaG5PUX0lmMIzMlhqlnFgrTsUdEYNK7tkULVlhBfezEUT2hbf1LlObejHfpTYoTWXe5caMIFv+2p6KLPRjaHy1zJxuLWq2YpPWdUohAZmMpZ+BH1VfE2pPPa7Vw948Q9lqhmWBWC54r92mm1maLPIIbYlAIp8Rc05lN+at//sTp7lSrAooL6lY8MUaKKcZLwMvz+WNngXMXMzPplHSLkbclt3TMAqKzphUGwbN0CNZaP29Srl18HYNBBFIm7UKdFs4rj1aMiCp+OxB5Q0V28FJY8nf4YYz6wTaMj7lOEXBDVu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(346002)(136003)(376002)(39860400002)(396003)(966005)(478600001)(6486002)(2906002)(53546011)(26005)(41300700001)(36916002)(6506007)(6512007)(6666004)(8676002)(66946007)(31696002)(31686004)(36756003)(86362001)(66476007)(316002)(66556008)(38100700002)(186003)(2616005)(4326008)(5660300002)(30864003)(8936002)(83380400001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3A1bXI0UkhNQlR0YUU5SUZaS0NxMVRmdlRHMW9IUEQ1U284MWR6SGZXQWRW?=
 =?utf-8?B?ZTlKMk1wd3ZIUytxMkV4Mm1BMDRpTGY3aThLYXIyNVZHOXBJS3RPc3h5a1JW?=
 =?utf-8?B?Rm1mRTdIYWl1dU55eHJqUjVHOUtyVTV6N2hrVG1acVM3MGsraE9VUDh4SGxW?=
 =?utf-8?B?Ky9GQjUveW5GejYrTFJQVEhKNlpVSWFOeVN1TGpwZFNkd1gweWhvSUZWcjdD?=
 =?utf-8?B?SHJ3MndvY05nSE9INk5HYkVnU2k1SUhldlM5VVN5WlR4NWNSNlM2Y3hrTXVW?=
 =?utf-8?B?UTJLdkEzc1Q2U3RMV0p0eERReU1JYlVRZ0F0TnlQd1p2RC9BQnJ2SGhuQmk2?=
 =?utf-8?B?Y1YzTzlNU0JHby9UVm5LS2J2RWx4K0YzM3E0UG9OWVM3cEM2dzZIZzQyWTcv?=
 =?utf-8?B?VlYvNVI4K3A2MmppWGowanVaYzBESWUzaVI1cGhDTXB4TlVUZjR2RkJqYzFN?=
 =?utf-8?B?K3RiWkNQUWFYRGJsSHhSbUtKTVEyZUk1cFpBYWlEUThnRnFSTWgrajRwWkhT?=
 =?utf-8?B?M3NmRVNPTGQvZXc1N2FCeDEwUEFuY21zcmE3MlM1UkExL0Y5aUJBeGh3Qk1M?=
 =?utf-8?B?V3FFMWdRZDU3c2xnc29vVmNWd2lZYUdud1VJelVIeFdtS1RTMzhTZnRrazVY?=
 =?utf-8?B?SUIxZWhUS1JQT0JlR2tmRDFyNU1uNjdKMHlnVGRoVFhTYmg4SW9UZmhVMHYx?=
 =?utf-8?B?cGNQeExRQ2IzZ0ViM0hxUG41RWJ1bGNwKzRtdngwaW9OWjlJOFpIWWRCeW1K?=
 =?utf-8?B?Q1FqQWRJbTZ2N2N5NHc5ZGN2TWtlSS9mVUNId080ODNFazRVa0RKZDFyVm9J?=
 =?utf-8?B?eURoSXZSYjZ3TmEya3A3YlkreHZRU3JNTXYxdDZka2NDTnFCTHlFRWZmQ1hD?=
 =?utf-8?B?ekV3WDBpYUxDc09RWk5ObzBsVnNTcVdJWTgrZll6MXhxdkl0MUszaVBYL2tK?=
 =?utf-8?B?dVlSY1lpSlB3QWcxSEo4eFZCOXNRVDJpdUl3TG43bm80ZjVkOVZBMDRQdFpv?=
 =?utf-8?B?VFE2MWxUWGI5WlVacVpySEZWdUZkSWJtUStEUjE0b3RDZ3NPTjJoWlV6YktE?=
 =?utf-8?B?S3RqaDVnenN5U3dYRnRuMkFvUWNTMjJpaVVXQjY2SmxwMlcxNnJWajNaWXpz?=
 =?utf-8?B?NWdPUnhsSk83UVVNTlNRcWc3aVliZmRmb3Y5MlYxb0NzZVN2WU81Ti8vUUli?=
 =?utf-8?B?eVBzVFFPTnZ1T2I1ZEorMExadDRma1lHYkFaZWVkd0l1dytWL280YWg2cTNy?=
 =?utf-8?B?elJJSkhHUGtpOWdMMHl5eVNTSFd0RmQvU2VldmFYcmdLM0FlSWREN2N4VWV3?=
 =?utf-8?B?VHFweitSTTVWUmNrZUpRNnEyZWs3L2xBNmFQZWxDaUxoMTJhbDZ0WDBuWU9v?=
 =?utf-8?B?NVZyLzNzODM4VitHRk5KTW5UNjBoODNQNnV0V0M5alVmTWVnS2x0OER4YzdN?=
 =?utf-8?B?UVlsM29xUGNLam05SEZnN3NzUUJwNzhPM3NWMzZ6WDdEN09OWkJUM3BUTHlS?=
 =?utf-8?B?dXRhd3BlSDFPdkhkM2h0Rk9uL2ovaS92RjhQamFwYlQzenc0bE91eWpycVE4?=
 =?utf-8?B?M3hudTh5OTNGdSt5NndaZ0ZUWWRvbUNMeVZ3QlhOWTRBa0ZZVE9pSG5xREx1?=
 =?utf-8?B?ajNCOE83Rm9IMy85eXZuYmZzbHpOK1hiZmFjbnF2dm9vT0RkOGFhZk9vcis4?=
 =?utf-8?B?V0xyQTVBaytXK1FFUXo5L0F1dTNLQ1pva3lOQkR5MVdaRkZKa1FhUThQY3pi?=
 =?utf-8?B?RWxhTzdpanEyaEt6Y2hUT2labmVKQ0tnckJnd1BLakk5ZVNvVzBhVGVGbGVO?=
 =?utf-8?B?ZDRQMU1KN0xRTFRiVURsTzMzWVJwamJrS2hTY0dRU3dlbEwvUHpHL3cwL2x0?=
 =?utf-8?B?emQzOUE0RDdXMkxKSEZlK29UdUlEWTBvd0xUZTFHQ0FGOXh3R3FoWkNSK0hK?=
 =?utf-8?B?aGdvOTZFNUZYSVdzZDdQaW9TOVh6K0pWL2FQZmp0QUVLMFZLS1ptcVBqMWVj?=
 =?utf-8?B?RUpRMkdDbklXbkhQOVBnLzRwRkJMWCtIVnBDTjUvbkJDYmtjcFZ0Njlqd2lu?=
 =?utf-8?B?M3k5RGlqSUJBWXk0MDBQWDNNLzJBV2xsM1lXTzZ0TmNTRUFSb3BVQk8zYmND?=
 =?utf-8?Q?VrWNczhEmX7y2l36aSziN6pzw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M2FlVlZ2M0N5TXg4Q3pMdFFsemhzcUlVZEwxVVJMRWVYY2tpWC9hblQxZkNv?=
 =?utf-8?B?eTRLSDBia090RVJ0OTI5OVgyc0lkSk1vYW02UmRlaUtpWi9SNG8yaG5KZHlq?=
 =?utf-8?B?Uy9keElOaFB1S2R3Sy85SjQwMGxRcEJzTWl1enFQNDIrNlR0bUwxSTA1dEZz?=
 =?utf-8?B?NGw4bzBKUHBxdzRPYUt6S2NzTEhrTlFsQ2FQNHpIRjJFeThZcmx0bjJsMHFI?=
 =?utf-8?B?TFNBdzhjRlRUNm0rUXNmYngrdG00WWVmNjRLcHNnd1VLNzExNFl1TXI3bU1s?=
 =?utf-8?B?ejVDMzFWYnZaMkdmdnNtRUY0MEF2MWIwLzdaRi9jSnFzRkM5REZoZjRZK1BV?=
 =?utf-8?B?emhCaUgrT1BMY3Njay9rR0FDaG5Xbjkza2xxWEZkZ0cvUks1b09KSGhFR0hz?=
 =?utf-8?B?S3FNQnJkdEcxR0pFWXFsRjJuckI2cVpjWEtyd0hGSmk3S0tmNHRla2ZLL2w3?=
 =?utf-8?B?emhlSU5QMG5vekFKL1ZMT0QxQXJvRkVNUTNDTEJaY2NydlViS1RUR3lBTVda?=
 =?utf-8?B?azRSSmxHcnpLT0JxZVFsRm1nd1VIYmRpSEdEVkJhQUNRN3BZaTF6RUl1c1Bl?=
 =?utf-8?B?SUtONUgrUEhLNkt0OVYxTUt6eU52TExVTlQ0N1VBMjBiaURPR2pPY3BxbG0w?=
 =?utf-8?B?TnBBNE1FUVRabnJ6dm0rbE5mYVhrOHhGZUNZd1lPcDE1M3pqUE9WYlhUOUNZ?=
 =?utf-8?B?YnQ4UGtSZWxWNWk0S3hUMVprK1BBMzhUNFYreTA3RS82c2lNM05Hc0FWU2pa?=
 =?utf-8?B?Q1lOdldPZzdJODltT2dCZjZoT0h0M3dyaTJxVEgyRjNNWkRBdTY0N3kvNFRN?=
 =?utf-8?B?R09PSnh5YTRkZ2t6Y3h3SGkwS1ozU280TysreXczSHBkRjc5a3ZnWkM3UEky?=
 =?utf-8?B?TDhMUjk3ZHEvRCtQOWlYSDMzRWVIVXhaRmhScWpVUUZ1TXNPWTdQdmE1TjdP?=
 =?utf-8?B?RURXL21VcUtXeUtXb2QzRlQ4cFZmM2tQMkVCZTlpNUxSdEppY3ZwYlVMRUQ0?=
 =?utf-8?B?M3VYNEZoak5UZXFGaWZVeUkrS0dqZnBzMk9QaFBNYlh5UHVwMDlEUHhsZktz?=
 =?utf-8?B?TDYxbXBjQmdFcnNyUXVPdHd4ZVNRSk02eDhzQklLSUxtd3hrU1VvR3htK0Vp?=
 =?utf-8?B?TEFBNDIrRnZ6OThLTWlhMTFWSnhadkIyYW5Nd244QkZOMWFVSGhFRm53NDBh?=
 =?utf-8?B?WllmK2VsTnR5NGY4S2IvYUQvNTFza1drS2FmM0liWCtwSkxUMWNqZFd0WmY5?=
 =?utf-8?B?eDc5MjJyTkJ0djcySGplOUhaWFZLanNab05yQTdiY0sxKytBUmJiMWE1TnhC?=
 =?utf-8?B?a1pTN0xuVmRnQ2ZIdFUvMDBwNVRPS2ZUbnMxWTRpbHh3LzhsenNOSUU1UVh6?=
 =?utf-8?B?R1NrWW53U2QxNytMNkxFL1UvS1hnd1dxY0NIaS8xRDY2WGh6aVpTL0RySFB0?=
 =?utf-8?B?b21VTHJwdU9OQSt2YTc2M2NxMDBlblhJWFlTa29JNVJCN2R4ZHcxMW53Qlhy?=
 =?utf-8?B?SitHVVlHRzlyNURJVnVhRjQ2VGVvbmJmZGxNMkR1elFkUHlxNFpKQ1VjNnQr?=
 =?utf-8?Q?7oNlBcGr6lF49rRS1BMtLNS0PIh/aFiMI1MkGQQDO6hBuW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4585a6fe-2e79-4635-ae1b-08da7fdd26b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 23:15:04.1406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erH/KxFKiiM8YhuRz4PAwIWuVL/6hyVAiQOpQhRH/o1RbU1xHqFqvPvqLxcWeUApQBdxQq+HdpHDdS0lv2w/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160084
X-Proofpoint-GUID: dFRaFkoGShiBhWWo5g-TDzn6pno0E5oO
X-Proofpoint-ORIG-GUID: dFRaFkoGShiBhWWo5g-TDzn6pno0E5oO
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

CgpPbiA4LzE2LzIwMjIgMjowOCBBTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24gOC8x
Ni8yMDIyIDM6NTggUE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDgvMTUvMjAyMiA2
OjU4IFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiA4LzE2LzIwMjIgNzoz
MiBBTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gOC8xNS8yMDIyIDI6MjYg
QU0sIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+Pj4gU29tZSBmaWVsZHMgb2YgdmlydGlvLW5ldCBk
ZXZpY2UgY29uZmlnIHNwYWNlIGFyZQo+Pj4+PiBjb25kaXRpb25hbCBvbiB0aGUgZmVhdHVyZSBi
aXRzLCB0aGUgc3BlYyBzYXlzOgo+Pj4+Pgo+Pj4+PiAiVGhlIG1hYyBhZGRyZXNzIGZpZWxkIGFs
d2F5cyBleGlzdHMKPj4+Pj4gKHRob3VnaCBpcyBvbmx5IHZhbGlkIGlmIFZJUlRJT19ORVRfRl9N
QUMgaXMgc2V0KSIKPj4+Pj4KPj4+Pj4gIm1heF92aXJ0cXVldWVfcGFpcnMgb25seSBleGlzdHMg
aWYgVklSVElPX05FVF9GX01RCj4+Pj4+IG9yIFZJUlRJT19ORVRfRl9SU1MgaXMgc2V0Igo+Pj4+
Pgo+Pj4+PiAibXR1IG9ubHkgZXhpc3RzIGlmIFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0Igo+Pj4+
Pgo+Pj4+PiBzbyB3ZSBzaG91bGQgcmVhZCBNVFUsIE1BQyBhbmQgTVEgaW4gdGhlIGRldmljZSBj
b25maWcKPj4+Pj4gc3BhY2Ugb25seSB3aGVuIHRoZXNlIGZlYXR1cmUgYml0cyBhcmUgb2ZmZXJl
ZC4KPj4+Pj4KPj4+Pj4gRm9yIE1RLCBpZiBib3RoIFZJUlRJT19ORVRfRl9NUSBhbmQgVklSVElP
X05FVF9GX1JTUyBhcmUKPj4+Pj4gbm90IHNldCwgdGhlIHZpcnRpbyBkZXZpY2Ugc2hvdWxkIGhh
dmUKPj4+Pj4gb25lIHF1ZXVlIHBhaXIgYXMgZGVmYXVsdCB2YWx1ZSwgc28gd2hlbiB1c2Vyc3Bh
Y2UgcXVlcnlpbmcgcXVldWUgCj4+Pj4+IHBhaXIgbnVtYmVycywKPj4+Pj4gaXQgc2hvdWxkIHJl
dHVybiBtcT0xIHRoYW4gemVyby4KPj4+Pj4KPj4+Pj4gRm9yIE1UVSwgaWYgVklSVElPX05FVF9G
X01UVSBpcyBub3Qgc2V0LCB3ZSBzaG91bGQgbm90IHJlYWQKPj4+Pj4gTVRVIGZyb20gdGhlIGRl
dmljZSBjb25maWcgc2FwY2UuCj4+Pj4+IFJGQzg5NCA8QSBTdGFuZGFyZCBmb3IgdGhlIFRyYW5z
bWlzc2lvbiBvZiBJUCBEYXRhZ3JhbXMgb3ZlciAKPj4+Pj4gRXRoZXJuZXQgTmV0d29ya3M+Cj4+
Pj4+IHNheXM6IlRoZSBtaW5pbXVtIGxlbmd0aCBvZiB0aGUgZGF0YSBmaWVsZCBvZiBhIHBhY2tl
dCBzZW50IG92ZXIgYW4KPj4+Pj4gRXRoZXJuZXQgaXMgMTUwMCBvY3RldHMsIHRodXMgdGhlIG1h
eGltdW0gbGVuZ3RoIG9mIGFuIElQIGRhdGFncmFtCj4+Pj4+IHNlbnQgb3ZlciBhbiBFdGhlcm5l
dCBpcyAxNTAwIG9jdGV0cy7CoCBJbXBsZW1lbnRhdGlvbnMgYXJlIGVuY291cmFnZWQKPj4+Pj4g
dG8gc3VwcG9ydCBmdWxsLWxlbmd0aCBwYWNrZXRzIgo+Pj4+IE5vdGVkIHRoZXJlJ3MgYSB0eXBv
IGluIHRoZSBhYm92ZSAiVGhlICptYXhpbXVtKiBsZW5ndGggb2YgdGhlIGRhdGEgCj4+Pj4gZmll
bGQgb2YgYSBwYWNrZXQgc2VudCBvdmVyIGFuIEV0aGVybmV0IGlzIDE1MDAgb2N0ZXRzIC4uLiIg
YW5kIHRoZSAKPj4+PiBSRkMgd2FzIHdyaXR0ZW4gMTk4NC4KPj4+IHRoZSBzcGVjIFJGQzg5NCBz
YXlzIGl0IGlzIDE1MDAsIHNlZSA8YSAKPj4+IGhyZWY9Imh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODk0LnR4dF9fOyEhQUNXVjVO
OU0yUlY5OWhRIU1kZ3haanc1c3A1UXotR0tmd1QxSVdjd19MNEpvMS1VZWt1SlBGejFVckczWXVx
aXJLejdQOWtzZEpGaDF2QjZ6SEo3ejhRMDRmcFQwLTlqV1hDdGxXTSQiPmh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODk0LnR4dF9f
OyEhQUNXVjVOOU0yUlY5OWhRIUtWd2Z1bjBiMVE1OUFqcDZPN0pyQi1CdUVCU0x5UTllOTVvR3Ex
Y1ZHX3NRSVBETDB3aEk1ZnJ4MUVHb1FGem5tbTY3UnNFZUpUclVkZllybVpQUkZhTSQgCj4+PiA8
L2E+Cj4+Pj4KPj4+PiBBcHBhcmVudGx5IHRoYXQgaXMgbm8gbG9uZ2VyIHRydWUgd2l0aCB0aGUg
aW50cm9kdWN0aW9uIG9mIEp1bWJvIAo+Pj4+IHNpemUgZnJhbWUgbGF0ZXIgaW4gdGhlIDIwMDBz
LiBJJ20gbm90IHN1cmUgd2hhdCBpcyB0aGUgcG9pbnQgb2YgCj4+Pj4gbWVudGlvbiB0aGlzIGFu
Y2llbnQgUkZDLiBJdCBkb2Vzbid0IHNheSBkZWZhdWx0IE1UVSBvZiBhbnkgCj4+Pj4gRXRoZXJu
ZXQgTklDL3N3aXRjaCBzaG91bGQgYmUgMTUwMCBpbiBlaXRoZXLCoCBjYXNlLgo+Pj4gVGhpcyBj
b3VsZCBiZSBhIGxhcmdlciBudW1iZXIgZm9yIHN1cmUsIHdlIGFyZSB0cnlpbmcgdG8gZmluZCBv
dXQgCj4+PiB0aGUgbWluIHZhbHVlIGZvciBFdGhlcm5ldCBoZXJlLCB0byBzdXBwb3J0IDE1MDAg
b2N0ZXRzLCBNVFUgc2hvdWxkIAo+Pj4gYmUgMTUwMCBhdCBsZWFzdCwgc28gSSBhc3N1bWUgMTUw
MCBzaG91bGQgYmUgdGhlIGRlZmF1bHQgdmFsdWUgZm9yIE1UVQo+Pj4+Cj4+Pj4+Cj4+Pj4+IHZp
cnRpbyBzcGVjIHNheXM6IlRoZSB2aXJ0aW8gbmV0d29yayBkZXZpY2UgaXMgYSB2aXJ0dWFsIGV0
aGVybmV0IAo+Pj4+PiBjYXJkIiwKPj4+PiBSaWdodCwKPj4+Pj4gc28gdGhlIGRlZmF1bHQgTVRV
IHZhbHVlIHNob3VsZCBiZSAxNTAwIGZvciB2aXJ0aW8tbmV0Lgo+Pj4+IC4uLiBidXQgaXQgZG9l
c24ndCBzYXkgdGhlIGRlZmF1bHQgaXMgMTUwMC4gQXQgbGVhc3QsIG5vdCBpbiAKPj4+PiBleHBs
aWNpdCB3YXkuIFdoeSBpdCBjYW4ndCBiZSAxNDkyIG9yIGV2ZW4gbG93ZXI/IEluIHByYWN0aWNl
LCBpZiAKPj4+PiB0aGUgbmV0d29yayBiYWNrZW5kIGhhcyBhIE1UVSBoaWdoZXIgdGhhbiAxNTAw
LCB0aGVyZSdzIG5vdGhpbmcgCj4+Pj4gd3JvbmcgZm9yIGd1ZXN0IHRvIGNvbmZpZ3VyZSBkZWZh
dWx0IE1UVSBtb3JlIHRoYW4gMTUwMC4KPj4+IHNhbWUgYXMgYWJvdmUKPj4+Pgo+Pj4+Pgo+Pj4+
PiBGb3IgTUFDLCB0aGUgc3BlYyBzYXlzOiJJZiB0aGUgVklSVElPX05FVF9GX01BQyBmZWF0dXJl
IGJpdCBpcyBzZXQsCj4+Pj4+IHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG1hYyBlbnRyeSBpbmRp
Y2F0ZXMgdGhlIOKAnHBoeXNpY2Fs4oCdIGFkZHJlc3MKPj4+Pj4gb2YgdGhlIG5ldHdvcmsgY2Fy
ZCwgb3RoZXJ3aXNlIHRoZSBkcml2ZXIgd291bGQgdHlwaWNhbGx5Cj4+Pj4+IGdlbmVyYXRlIGEg
cmFuZG9tIGxvY2FsIE1BQyBhZGRyZXNzLiIgU28gdGhlcmUgaXMgbm8KPj4+Pj4gZGVmYXVsdCBN
QUMgYWRkcmVzcyBpZiBWSVJUSU9fTkVUX0ZfTUFDIG5vdCBzZXQuCj4+Pj4+Cj4+Pj4+IFRoaXMg
Y29tbWl0cyBpbnRyb2R1Y2VzIGZ1bmN0aW9ucyB2ZHBhX2Rldl9uZXRfbXR1X2NvbmZpZ19maWxs
KCkKPj4+Pj4gYW5kIHZkcGFfZGV2X25ldF9tYWNfY29uZmlnX2ZpbGwoKSB0byBmaWxsIE1UVSBh
bmQgTUFDLgo+Pj4+PiBJdCBhbHNvIGZpeGVzIHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbCgp
IHRvIHJlcG9ydCBjb3JyZWN0Cj4+Pj4+IE1RIHdoZW4gX0ZfTVEgaXMgbm90IHByZXNlbnQuCj4+
Pj4+Cj4+Pj4+IFRoZXNlIGZ1bmN0aW9ucyBzaG91bGQgY2hlY2sgZGV2aWNlcyBmZWF0dXJlcyB0
aGFuIGRyaXZlcgo+Pj4+PiBmZWF0dXJlcywgYW5kIHN0cnVjdCB2ZHBhX2RldmljZSBpcyBub3Qg
bmVlZGVkIGFzIGEgcGFyYW1ldGVyCj4+Pj4+Cj4+Pj4+IFRoZSB0ZXN0ICYgdXNlcnNwYWNlIHRv
b2wgb3V0cHV0Ogo+Pj4+Pgo+Pj4+PiBGZWF0dXJlIGJpdCBWSVJUSU9fTkVUX0ZfTVRVLCBWSVJU
SU9fTkVUX0ZfUlNTLCBWSVJUSU9fTkVUX0ZfTVEKPj4+Pj4gYW5kIFZJUlRJT19ORVRfRl9NQUMg
Y2FuIGJlIG1hc2sgb3V0IGJ5IGhhcmRjb2RlLgo+Pj4+Pgo+Pj4+PiBIb3dldmVyLCBpdCBpcyBj
aGFsbGVuZ2luZyB0byAiZGlzYWJsZSIgdGhlIHJlbGF0ZWQgZmllbGRzCj4+Pj4+IGluIHRoZSBI
VyBkZXZpY2UgY29uZmlnIHNwYWNlLCBzbyBsZXQncyBqdXN0IGFzc3VtZSB0aGUgdmFsdWVzCj4+
Pj4+IGFyZSBtZWFuaW5nbGVzcyBpZiB0aGUgZmVhdHVyZSBiaXRzIGFyZSBub3Qgc2V0Lgo+Pj4+
Pgo+Pj4+PiBCZWZvcmUgdGhpcyBjaGFuZ2UsIHdoZW4gZmVhdHVyZSBiaXRzIGZvciBSU1MsIE1R
LCBNVFUgYW5kIE1BQwo+Pj4+PiBhcmUgbm90IHNldCwgaXByb3V0ZTIgb3V0cHV0Ogo+Pj4+PiAk
dmRwYSB2ZHBhMDogbWFjIDAwOmU4OmNhOjExOmJlOjA1IGxpbmsgdXAgbGlua19hbm5vdW5jZSBm
YWxzZSBtdHUgCj4+Pj4+IDE1MDAKPj4+Pj4gwqDCoCBuZWdvdGlhdGVkX2ZlYXR1cmVzCj4+Pj4+
Cj4+Pj4+IHdpdGhvdXQgdGhpcyBjb21taXQsIGZ1bmN0aW9uIHZkcGFfZGV2X25ldF9jb25maWdf
ZmlsbCgpCj4+Pj4+IHJlYWRzIGFsbCBjb25maWcgc3BhY2UgZmllbGRzIHVuY29uZGl0aW9uYWxs
eSwgc28gbGV0J3MKPj4+Pj4gYXNzdW1lIHRoZSBNQUMgYW5kIE1UVSBhcmUgbWVhbmluZ2xlc3Ms
IGFuZCBpdCBjaGVja3MKPj4+Pj4gTVEgd2l0aCBkcml2ZXJfZmVhdHVyZXMsIHNvIHdlIGRvbid0
IHNlZSBtYXhfdnFfcGFpcnMuCj4+Pj4+Cj4+Pj4+IEFmdGVyIGFwcGx5aW5nIHRoaXMgY29tbWl0
LCB3aGVuIGZlYXR1cmUgYml0cyBmb3IKPj4+Pj4gTVEsIFJTUywgTUFDIGFuZCBNVFUgYXJlIG5v
dCBzZXQsaXByb3V0ZTIgb3V0cHV0Ogo+Pj4+PiAkdmRwYSBkZXYgY29uZmlnIHNob3cgdmRwYTAK
Pj4+Pj4gdmRwYTA6IGxpbmsgdXAgbGlua19hbm5vdW5jZSBmYWxzZSBtYXhfdnFfcGFpcnMgMSBt
dHUgMTUwMAo+Pj4+PiDCoMKgIG5lZ290aWF0ZWRfZmVhdHVyZXMKPj4+Pj4KPj4+Pj4gQXMgZXhw
bGFpbmVkIGFib3ZlOgo+Pj4+PiBIZXJlIGlzIG5vIE1BQywgYmVjYXVzZSBWSVJUSU9fTkVUX0Zf
TUFDIGlzIG5vdCBzZXQsCj4+Pj4+IGFuZCB0aGVyZSBpcyBubyBkZWZhdWx0IHZhbHVlIGZvciBN
QUMuIEl0IHNob3dzCj4+Pj4+IG1heF92cV9wYXJpcyA9IDEgYmVjYXVzZSBldmVuIHdpdGhvdXQg
TVEgZmVhdHVyZSwKPj4+Pj4gYSBmdW5jdGlvbmFsIHZpcnRpby1uZXQgbXVzdCBoYXZlIG9uZSBx
dWV1ZSBwYWlyLgo+Pj4+PiBtdHUgPSAxNTAwIGlzIHRoZSBkZWZhdWx0IHZhbHVlIGFzIGV0aGVy
bmV0Cj4+Pj4+IHJlcXVpcmVkLgo+Pj4+Pgo+Pj4+PiBUaGlzIGNvbW1pdCBhbHNvIGFkZCBzdXBw
bGVtZW50YXJ5IGNvbW1lbnRzIGZvcgo+Pj4+PiBfX3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCB4eHgp
IG9wZXJhdGlvbnMgaW4KPj4+Pj4gdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKCkgYW5kIHZkcGFf
ZmlsbF9zdGF0c19yZWMoKQo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL3ZkcGEv
dmRwYS5jIHwgNjAgCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLQo+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIv
ZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+PiBpbmRleCBlZmI1NWEwNmU5NjEuLmE3NDY2MGI5ODk3
OSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+PiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+IEBAIC04MDEsMTkgKzgwMSw0NCBAQCBzdGF0aWMgaW50IHZk
cGFfbmxfY21kX2Rldl9nZXRfZHVtcGl0KHN0cnVjdCAKPj4+Pj4gc2tfYnVmZiAqbXNnLCBzdHJ1
Y3QgbmV0bGlua19jYWxsYmEKPj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gbXNnLT5sZW47Cj4+Pj4+
IMKgIH0KPj4+Pj4gwqAgLXN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBza19idWZmICptc2csIHU2NCBmZWF0dXJlcywKPj4+
Pj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHN0cnVjdCBza19idWZm
ICptc2csIHU2NCAKPj4+Pj4gZmVhdHVyZXMsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcg
KmNvbmZpZykKPj4+Pj4gwqAgewo+Pj4+PiDCoMKgwqDCoMKgIHUxNiB2YWxfdTE2Owo+Pj4+PiDC
oCAtwqDCoMKgIGlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSkpID09IDAp
Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4gK8KgwqDCoCBpZiAoKGZlYXR1
cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpKSA9PSAwICYmCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCAoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9SU1MpKSA9PSAwKQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgdmFsX3UxNiA9IDE7Cj4+Pj4+ICvCoMKgwqAgZWxzZQo+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgdmFsX3UxNiA9IF9fdmlydGlvMTZfdG9fY3B1KHRydWUsIAo+Pj4+PiBjb25m
aWctPm1heF92aXJ0cXVldWVfcGFpcnMpOwo+Pj4+PiDCoCAtwqDCoMKgIHZhbF91MTYgPSBsZTE2
X3RvX2NwdShjb25maWctPm1heF92aXJ0cXVldWVfcGFpcnMpOwo+Pj4+PiDCoMKgwqDCoMKgIHJl
dHVybiBubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQLCAKPj4+
Pj4gdmFsX3UxNik7Cj4+Pj4+IMKgIH0KPj4+Pj4gwqAgK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0
X210dV9jb25maWdfZmlsbChzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCAKPj4+Pj4gdTY0IGZlYXR1cmVz
LAo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3Ry
dWN0IHZpcnRpb19uZXRfY29uZmlnICpjb25maWcpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgdTE2
IHZhbF91MTY7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChW
SVJUSU9fTkVUX0ZfTVRVKSkgPT0gMCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZhbF91MTYgPSAx
NTAwOwo+Pj4+IEFzIHNhaWQsIHRoZXJlJ3Mgbm8gdmlydGlvIHNwZWMgZGVmaW5lZCB2YWx1ZSBm
b3IgTVRVLiBQbGVhc2UgbGVhdmUgCj4+Pj4gdGhpcyBmaWVsZCBvdXQgaWYgZmVhdHVyZSBWSVJU
SU9fTkVUX0ZfTVRVIGlzIG5vdCBuZWdvdGlhdGVkLgo+Pj4gc2FtZSBhcyBhYm92ZQo+Pj4+PiAr
wqDCoMKgIGVsc2UKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZhbF91MTYgPSBfX3ZpcnRpbzE2X3Rv
X2NwdSh0cnVlLCBjb25maWctPm10dSk7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCByZXR1cm4gbmxh
X3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KTsKPj4+Pj4g
K30KPj4+Pj4gKwo+Pj4+PiArc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfbWFjX2NvbmZpZ19maWxs
KHN0cnVjdCBza19idWZmICptc2csIHU2NCAKPj4+Pj4gZmVhdHVyZXMsCj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmlydGlvX25ldF9j
b25maWcgKmNvbmZpZykKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBpZiAoKGZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fTkVUX0ZfTUFDKSkgPT0gMCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+Pj4+PiArwqDCoMKgIGVsc2UKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybsKgIG5s
YV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiwKPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YoY29uZmlnLT5tYWMpLCBjb25maWctPm1hYyk7
Cj4+Pj4+ICt9Cj4+Pj4+ICsKPj4+Pj4gKwo+Pj4+PiDCoCBzdGF0aWMgaW50IHZkcGFfZGV2X25l
dF9jb25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIAo+Pj4+PiBzdHJ1Y3Qgc2tf
YnVmZiAqbXNnKQo+Pj4+PiDCoCB7Cj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19uZXRf
Y29uZmlnIGNvbmZpZyA9IHt9Owo+Pj4+PiBAQCAtODIyLDE4ICs4NDcsMTYgQEAgc3RhdGljIGlu
dCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0IAo+Pj4+PiB2ZHBhX2RldmljZSAqdmRl
diwgc3RydWN0IHNrX2J1ZmYgKm1zCj4+Pj4+IMKgIMKgwqDCoMKgwqAgdmRwYV9nZXRfY29uZmln
X3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPj4+Pj4gwqAgLcKg
wqDCoCBpZiAobmxhX3B1dChtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSLCAKPj4+
Pj4gc2l6ZW9mKGNvbmZpZy5tYWMpLAo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25m
aWcubWFjKSkKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+ICvC
oMKgwqAgLyoKPj4+Pj4gK8KgwqDCoMKgICogQXNzdW1lIGxpdHRsZSBlbmRpYW4gZm9yIG5vdywg
dXNlcnNwYWNlIGNhbiB0d2VhayB0aGlzIGZvcgo+Pj4+PiArwqDCoMKgwqAgKiBsZWdhY3kgZ3Vl
c3Qgc3VwcG9ydC4KPj4+PiBZb3UgY2FuIGxlYXZlIGl0IGFzIGEgVE9ETyBmb3Iga2VybmVsICh2
ZHBhIGNvcmUgbGltaXRhdGlvbiksIGJ1dCAKPj4+PiBBRkFJSyB0aGVyZSdzIG5vdGhpbmcgdXNl
cnNwYWNlIG5lZWRzIHRvIGRvIHRvIGluZmVyIHRoZSAKPj4+PiBlbmRpYW5uZXNzLiBJTUhPIGl0
J3MgdGhlIGtlcm5lbCdzIGpvYiB0byBwcm92aWRlIGFuIGFic3RyYWN0aW9uIAo+Pj4+IHJhdGhl
ciB0aGFuIHJlbHkgb24gdXNlcnNwYWNlIGd1ZXNzaW5nIGl0Lgo+Pj4gd2UgaGF2ZSBkaXNjdXNz
ZWQgaXQgaW4gYW5vdGhlciB0aHJlYWQsIGFuZCB0aGlzIGNvbW1lbnQgaXMgCj4+PiBzdWdnZXN0
ZWQgYnkgTVNULgo+PiBDYW4geW91IHByb3ZpZGUgdGhlIGNvbnRleHQgb3IgbGluaz8gSXQgc2hv
dWxkbid0IHdvcmsgbGlrZSB0aGlzLCAKPj4gb3RoZXJ3aXNlIGl0IGlzIGJyZWFraW5nIHVBQkku
IEUuZy4gaG93IHdpbGwgYSBsZWdhY3kvQkUgc3VwcG9ydGluZyAKPj4ga2VybmVsL2RldmljZSBi
ZSBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGggb2xkZXIgdmRwYSB0b29sICh3aGljaCBoYXMgCj4+
IGtub3dsZWRnZSBvZiB0aGlzIGVuZGlhbm5lc3MgaW1wbGljYXRpb24vYXNzdW1wdGlvbiBmcm9t
IGRheSBvbmUpPwo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5zcGlu
aWNzLm5ldC9saXN0cy9uZXRkZXYvbXNnODM3MTE0Lmh0bWxfXzshIUFDV1Y1TjlNMlJWOTloUSFL
VndmdW4wYjFRNTlBanA2TzdKckItQnVFQlNMeVE5ZTk1b0dxMWNWR19zUUlQREwwd2hJNWZyeDFF
R29RRnpubW02N1JzRWVKVHJVZGZZckdxN1Z3amskIAo+Cj4gVGhlIGNoYWxsZW5nZSBpcyB0aGF0
IHRoZSBzdGF0dXMgZmlsZWQgaXMgdmlydGlvMTYsIG5vdCBsZTE2LCBzbyAKPiBsZTE2X3RvX2Nw
dSh4eHgpIGlzIHdyb25nIGFueXdheS4gSG93ZXZlciB3ZSBjYW4gbm90IHRlbGwgd2hldGhlciBp
dCAKPiBpcyBhIExFIG9yIEJFIGRldmljZSBmcm9tIHN0cnVjdCB2ZHBhX2RldmljZSwgc28gZm9y
IG1vc3QgY2FzZXMsIHdlIAo+IGFzc3VtZSBpdCBpcyBMRSwgYW5kIGxlYXZlIHRoaXMgY29tbWVu
dC4KV2hpbGUgdGhlIGZpeCBpcyBmaW5lLCB0aGUgY29tbWVudCBpcyBtaXNsZWFkaW5nIGluIGdp
dmluZyByZWFkZXJzIGZhbHNlIApob3BlLiBUaGlzIGlzIGluIHZkcGFfZGV2X25ldF9jb25maWdf
ZmlsbCgpIHRoZSB2ZHBhIHRvb2wgcXVlcnkgcGF0aCwgCmluc3RlYWQgb2YgY2FsbHMgZnJvbSB0
aGUgVk1NIGRlYWxpbmcgd2l0aCB2aG9zdC92aXJ0aW8gcGx1bWJpbmcgCnNwZWNpZmljcy4gSSB0
aGluayB3aGF0J3MgbWlzc2luZyB0b2RheSBpbiB2ZHBhIGNvcmUgaXMgdGhlIGRldGVjdGlvbiBv
ZiAKZ3Vlc3QgdHlwZSAobGVnYWN5LCB0cmFuc2l0aW9uYWwsIG9yIG1vZGVybikgcmVnYXJkaW5n
IGVuZGlhbm5lc3MgCnRocm91Z2ggRl9WRVJTSU9OXzEgYW5kIGxlZ2FjeSBpbnRlcmZhY2UgYWNj
ZXNzLCB0aGUgbGF0dGVyIG9mIHdoaWNoIAp3b3VsZCBuZWVkIHNvbWUgYXNzaXN0YW5jZSBmcm9t
IFZNTSBmb3Igc3VyZS4gSG93ZXZlciwgdGhlIHByZXNlbmNlIG9mIAppbmZvcm1hdGlvbiB2aWEg
dGhlIHZkcGEgdG9vbCBxdWVyeSBpcyB0b3RhbGx5IG9ydGhvZ29uYWwuIEkgZG9uJ3QgZ2V0IGEg
Cmdvb2QgcmVhc29uIGZvciB3aHkgaXQgaGFzIHRvIGNvdXBsZSB3aXRoIGVuZGlhbm5lc3MuIEhv
dyB2ZHBhIHRvb2wgCnVzZXJzIHNwYWNlIGlzIHN1cHBvc2VkIHRvIHR3ZWFrIGl0PyBJIGRvbid0
IGdldCBpdC4uLgoKLVNpd2VpCgoKPgo+IFRoYW5rcwo+Pgo+PiAtU2l3ZWkKPj4KPj4+Pgo+Pj4+
PiArwqDCoMKgwqAgKi8KPj4+Pj4gK8KgwqDCoCB2YWxfdTE2ID0gX192aXJ0aW8xNl90b19jcHUo
dHJ1ZSwgY29uZmlnLnN0YXR1cyk7Cj4+Pj4+IMKgIMKgwqDCoMKgwqAgdmFsX3UxNiA9IF9fdmly
dGlvMTZfdG9fY3B1KHRydWUsIGNvbmZpZy5zdGF0dXMpOwo+Pj4+PiDCoMKgwqDCoMKgIGlmIChu
bGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywgdmFsX3UxNikpCj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4+PiDCoCAtwqDCoMKgIHZh
bF91MTYgPSBfX3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCBjb25maWcubXR1KTsKPj4+Pj4gLcKgwqDC
oCBpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2
KSkKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+IC0KPj4+Pj4g
wqDCoMKgwqDCoCBmZWF0dXJlc19kcml2ZXIgPSB2ZGV2LT5jb25maWctPmdldF9kcml2ZXJfZmVh
dHVyZXModmRldik7Cj4+Pj4+IMKgwqDCoMKgwqAgaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywg
Cj4+Pj4+IFZEUEFfQVRUUl9ERVZfTkVHT1RJQVRFRF9GRUFUVVJFUywgZmVhdHVyZXNfZHJpdmVy
LAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWRFBBX0FUVFJf
UEFEKSkKPj4+Pj4gQEAgLTg0Niw3ICs4NjksMTMgQEAgc3RhdGljIGludCB2ZHBhX2Rldl9uZXRf
Y29uZmlnX2ZpbGwoc3RydWN0IAo+Pj4+PiB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1
ZmYgKm1zCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFf
QVRUUl9QQUQpKQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+
Pj4gwqAgLcKgwqDCoCByZXR1cm4gdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHZkZXYsIG1z
ZywgCj4+Pj4+IGZlYXR1cmVzX2RyaXZlciwgJmNvbmZpZyk7Cj4+Pj4+ICvCoMKgwqAgaWYgKHZk
cGFfZGV2X25ldF9tYWNfY29uZmlnX2ZpbGwobXNnLCBmZWF0dXJlc19kZXZpY2UsICZjb25maWcp
KQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4gKwo+Pj4+PiAr
wqDCoMKgIGlmICh2ZHBhX2Rldl9uZXRfbXR1X2NvbmZpZ19maWxsKG1zZywgZmVhdHVyZXNfZGV2
aWNlLCAmY29uZmlnKSkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+
Pj4+ICsKPj4+Pj4gK8KgwqDCoCByZXR1cm4gdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKG1z
ZywgZmVhdHVyZXNfZGV2aWNlLCAKPj4+Pj4gJmNvbmZpZyk7Cj4+Pj4+IMKgIH0KPj4+Pj4gwqAg
wqAgc3RhdGljIGludAo+Pj4+PiBAQCAtOTE0LDYgKzk0MywxMSBAQCBzdGF0aWMgaW50IHZkcGFf
ZmlsbF9zdGF0c19yZWMoc3RydWN0IAo+Pj4+PiB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNr
X2J1ZmYgKm1zZywKPj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4+IMKgwqDCoMKgwqAgdmRwYV9nZXRf
Y29uZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPj4+Pj4g
wqAgK8KgwqDCoCAvKgo+Pj4+PiArwqDCoMKgwqAgKiBBc3N1bWUgbGl0dGxlIGVuZGlhbiBmb3Ig
bm93LCB1c2Vyc3BhY2UgY2FuIHR3ZWFrIHRoaXMgZm9yCj4+Pj4+ICvCoMKgwqDCoCAqIGxlZ2Fj
eSBndWVzdCBzdXBwb3J0Lgo+Pj4+PiArwqDCoMKgwqAgKi8KPj4+Pj4gKwo+Pj4+IERpdHRvLgo+
Pj4gc2FtZSBhcyBhYm92ZQo+Pj4KPj4+IFRoYW5rcwo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IC1T
aXdlaQo+Pj4+PiDCoMKgwqDCoMKgIG1heF92cXAgPSBfX3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCBj
b25maWcubWF4X3ZpcnRxdWV1ZV9wYWlycyk7Cj4+Pj4+IMKgwqDCoMKgwqAgaWYgKG5sYV9wdXRf
dTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsIG1heF92cXApKQo+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pgo+Pj4KPj4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
