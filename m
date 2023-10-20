Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F6C001DF
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 01:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A77260F00;
	Fri, 20 Oct 2023 01:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A77260F00
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fE3aiLIr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qzVgufd8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1DQodg4zC1i; Fri, 20 Oct 2023 01:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 456CA60D88;
	Fri, 20 Oct 2023 01:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 456CA60D88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E165C0071;
	Fri, 20 Oct 2023 01:02:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 049D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 01:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1A544A483
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 01:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1A544A483
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fE3aiLIr; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=qzVgufd8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tS5Hn33v6V04
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 01:02:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 582314A332
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 01:02:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 582314A332
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKxJNB013649; Fri, 20 Oct 2023 01:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=fE3aiLIrXkus+A/U/ai/eOaZvwTyMWlcnBQImEC5Za1T2EhCkipzxgmJ2ka+AkmawmeR
 Wuv3R64Zds8BCAtnTLJ9bevqkhdhFLTQ4U40vSsBjz9Q0UA8MjdcVM5kLb4cSJzSj8kt
 G8i84qm0cfFwhaDvfCw3PFIxtTuMISbrrfqnwBw7SRanapjrpcURNHaNZXIVEO4vdCo5
 +qmk+3v2lvui4HpnkPfPYDq4JbiNEVPNJfv7yzN0MUtFLcnyCT2Axt8RPVK0a94xzvVs
 yedVEPfM6Tnw/ybBkgO3D5aewhieionFGZZ95DOEBshGigT8/hiThEM1aSTjrDYfviED ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwd88ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 01:02:43 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JNUXp1038505; Fri, 20 Oct 2023 01:02:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tubw46m1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 01:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+MEiiRDWOMq4kQCj0t1mdtBc88gvdz7uxCTUxXrINQKo/xZeANDM9x4UGTirvEmAt2U66vD5aLySPni9fwRH1A/oLEyy75kT7fMI2GvYwWDV4OalcnQfyASdMN6+TP2Hon9fGrk+FgffMMZxCOoucgHJeI9dPVBndb0DdvQpu+0NQQFZSQFJ9waisj471cTYDraG0rBl5DZ6yLfCOptTv8TYIlBgqz+zh3HpsfO7BbcXoUciJ3H4HxfnO5dIItd4B3vpQq5CCQtWoPTUYrFKlSpTFc80Arwe7ghzfFHCp/JmUcMu7Ut5JakwzkPy2G98u3JtCi3/YQDwzVECBQzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=Nb+ikFAYmUgEUaw3U1du9AtRP1UXfyaDZqSPdVbPjSwBIAcIR4cXP/kC6ugIX2GlJHWP+rI+nCrtKXkGHeuiwSM936CDCYGIJ3hreQUTQaWZhtW9k4IYp7CBKGu8Ul5wUCvJUlEijdaTzRg0ll/NL1qMF+VwZVib0gXG6KgDkTOkcoCRPkJDEF+psq0KgKr874AlkHWtKvxvsT+FWGWFkB0eH2XmCawpkmUvAMAHSnlGyxtQrVLDMViOmEsOBWGOdd6PQuqwyeuj/SOGtQY7BSsCTvwayQdZpLN6MUXlGfVQjbb23yQIfuUqS3QDH6/TPmviWtL+vokeR+6PZYfgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szr1Tt5qdC03gksTf+IgNe546s8XVJoZsQBhVGjFNz0=;
 b=qzVgufd8xi+OiXfflB15YOWjn64Mhl5vRUlhmGoItnX6MTeU03tiiZy1CL/NegNObOdsV0U+XkZlsTenIfqzL+18/wqrwM6MTTabZHRybSK0IBB+KomdMe0LNsD85EGk+IDGti/YsZn7MDr4jbPDO2q1VKt2nkLpwcOB+aaIq3c=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 01:02:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 01:02:39 +0000
Message-ID: <dbdfa01f-1aa6-4bf8-8981-cd7905f579eb@oracle.com>
Date: Thu, 19 Oct 2023 18:02:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
 <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
 <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a30a274-73bd-4a2d-1c65-08dbd1084151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e21d5mdTnoul+Hi8PAM+G45EJjfpUIdZCkUTomwfHZiBc2FgFhn7htIhX/soCpBIIu9aPoUf+h2KwTBRGk3PY8Ee41Bpl8zAi9EUCXDalWFMwLYMoLg0GjzL291VnYpMbbOwcg8zxJNjSC/czgjziZhBHhgD1/LZ2qBQFd1mxsDUZrKb9fis+ItxuyiELDXiBbi44GoVtdxLrBBkXKL8lywin+hjQlRRoqVEuu+2XXEm6FpscL/ziAY6F9PsKKceFtkBr3HlfgHUufDW5XkcRgdCr152QnvZpyf96dQlg8/rZczKMKpIAIrTTJy13KUU+XkY+VEW5Gdfy+W3ic6Gv1b1c3wm7PlAhuCBTwnt2Bzn0Hvb9odNHldOw6nGY1j9x2tFoBPVqr+cAo0FeO/kb9W9eV8l+LvbhIgom7Z6b9crlpl3zMD6ZvEAD0ajXZtpPewL/TdezyliLNyv3a9ySJIU3z8VXTaoq84B4HCmbfCOQgiu0JFpxDx2KyvR7sek0Z6eYv6der1M4DyWlw/n86kBTFpG0cJEuSHS8Zz42FwCXTFR0C9XAHQlCUku42Wh64Db/iBodgDtZKdhqLnzhAD9IO+V87MwmyUKXPVZXE32esD/PO4cNu1NDgz1Cgrlm2r/0MF0ODvUO0OJSLDETxfTsQOHTHm5U1RCZvGi6W34Uq+mjwClDU3yFN0JFBeP2+CAtYgwJQoCv+tTVkD13w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(66946007)(66556008)(316002)(6916009)(6666004)(6486002)(478600001)(8676002)(66476007)(8936002)(966005)(36756003)(41300700001)(5660300002)(31696002)(4326008)(38100700002)(6506007)(2906002)(36916002)(86362001)(2616005)(53546011)(6512007)(83380400001)(26005)(31686004)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCthekZFNDBISnMzSHZpeU9aV2RCeE50Umlib3ZFbnE1NFlyekFsS0txYm5k?=
 =?utf-8?B?dFVvZXlDVzcyWFQybjM4VWE1Z3FyL2JUNlFPQTFSMjk5ZnR1U1V4WkgrOS9q?=
 =?utf-8?B?NWFrUXBIVkRxb2piVUFiMWlXQzNxalB6YUFqT1ZFU0E1ak1NNi9LM1RTZFBS?=
 =?utf-8?B?NTB6WHpKdVlWUThWRWplL2R3Y2dQSkwvREhHTVJhVXhvcnc2ZXlrY0FwaEQ5?=
 =?utf-8?B?bTBzWlhrM2FrUlBXTzJEbDNlc21zeHNtaTNwSzY5Z2tVR1hRdks5K3J2aVpq?=
 =?utf-8?B?YzluOWtuSGQvK1Z3R3UvcGlVUUEvWHVESHl1MVN5Mll2cHVaQ2hRZU0vbURw?=
 =?utf-8?B?RGVmd1l0RXd5OG85aWMvbDZQcG9hVWhxWmpibXpVTEgvYlpTdmRSektDV2Nl?=
 =?utf-8?B?WWVGRStVUjFxMWxqUXRwQytNTmdwTFBabDBlbHJCbVpnMWRMZzNrb1loS3Rl?=
 =?utf-8?B?TFphdWNQc3hlaHliTm9UVjQ2aVZXWWs5dUFzNXZoam45NFZZL2dQM1VPcG00?=
 =?utf-8?B?TlNJbmYzRWN1U0ZUYmVUQ0tVOUFYeEwwa0U2cnBSdHpYV2NrT1hlcDdUeDBW?=
 =?utf-8?B?a2lKU0c4cWhBdk13ODlaQ01MOEpmelhhd21OWVBVaVFuY0l0UERDWjB0bG5n?=
 =?utf-8?B?MCs2TStpZVRFVk5zbnc1V3htc1o3ckk2TEE2eklIUlBTNWtzRzRYNXF0N2FX?=
 =?utf-8?B?VzFDSDJMUnJqT2tkY3pheTVkdEdzVFN6V3dVSzU5dnJNYVptek4vaXRGVFRV?=
 =?utf-8?B?SEpIb1lCeS9YQThVa3YrcXY1YTBCSmNyS3YxVFdCZTRrRXZ0Y0t2c1Zqbk9T?=
 =?utf-8?B?NmxEd2pXRDE2Z3MxQjhVK1lCOVV0MzFUSWljQWNlY3pZZzhCb0RuV3c0a29a?=
 =?utf-8?B?Slg2N2JEYWViYlhvZmwrUVlmRytuRWpORXNnbklNRy9zbXQ5OEhIWFVvcnZX?=
 =?utf-8?B?UVpSN2NhSjl1RytqbW4wQXRBQTFOckRBMkxSTy8vYzJxSldPbFVra0JFVzVs?=
 =?utf-8?B?a0t3Yjk0d3dOdzd5R0U1UXpKQ0hQVFJZOGdpZ2VCYzRsRk1vYVlwUU9SUW5W?=
 =?utf-8?B?MDN6c3gyU21oUUNYN3k4OTlJVUJ1K2FZNGRXSDhTSW5FblZQUHRHY1cvOVhG?=
 =?utf-8?B?N1lWZVVDT0JPZXM4Zy9qdGdPZ0d2Q2UzcjJmdFRJMkY0UDFwUCtrU3k1U0pL?=
 =?utf-8?B?Y1dGdVpUWUtEcjRrUy9uVitNcjVRQlVqVEhHcmx1Q05CY3JCM25lOGUyUks5?=
 =?utf-8?B?Y0pnMnlsVmVaSFY2elg3bEZObVRHazNqNWlyWHp5L0VVQ3FjcmpVRGpGREY4?=
 =?utf-8?B?VElXL00rL0JCZWRoTlR2aitaV2ZyekRRbWhZeEVzVXMwQXY5RUFMdy94WThQ?=
 =?utf-8?B?TmNQRVBLbEZlNkIxL1BFSWM2SGd2enlTNGdrZU94b0pZQ0pBYmM2eTRIc1FE?=
 =?utf-8?B?MWV0eC8xNjlxK09tb2JJUFFXSUhVQnk4cTlRMDA4c0JSZFpuRWkzV0lxQWRM?=
 =?utf-8?B?ekJFSTBWSGZXdWRDRFJJN0JMaTZjNndBMUN3b2VRaHZSNTcvVTVtZ0JQUy81?=
 =?utf-8?B?YjE3SjRodGNGRXE1VUs4U0RtSWRlUGZFY2dwQ0w3YlJGT3ZRUTlXaGVuZDR3?=
 =?utf-8?B?bUxkZ2IxN3p6WFUwVXJzQzJiamkzYmVXMUFXOFZNRDZmMW9PaE8xSi9qUGQ4?=
 =?utf-8?B?eEoyNHBQWllPZGZWN21nNGMzVmpCaE5Zamg4WGNiOXVOQXFRME1PWWdzZ0l6?=
 =?utf-8?B?eDNWRFlqaEMwZDdMcEloOVUrNExOVTcwdVFmSjFnRm9UR0NpcGUzNlF2MjY1?=
 =?utf-8?B?bjhadTZ5dmxWSmFnSDdEbGwvb3J6SU9hTTR6eURkRjVBTVlFWjkzVHY0Mi9D?=
 =?utf-8?B?V1VqWGdSSWdRRSszMHpLdEJRZi9rMzdiVzlhbEFJckYyU0lvYXQ5c1BSNnBr?=
 =?utf-8?B?RUxlOWIrYllHRG0xaWZWWDVBZGI0ekFlZWZEMWdNVkc4M1dMR09uTlNhd2Mx?=
 =?utf-8?B?bmJOWE04bzdKd1ZuL1RreGJqMTdqdmdkcE4xaWJveENra1RQOXE5d0ROcmtB?=
 =?utf-8?B?bEdnZkt6TVFXMXBjQVlmUmJ3MzVYVTlBRDRaT3lZVDZXd0RMNERlei9Sc0Vx?=
 =?utf-8?Q?/mBEEiI3A1i+f5hG2LpRC3MqG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MpRFu4FAbL6WucvZYn5JGZGbhfB1R8hJekQ6Q80mvts0XJGRtv6Gz2tF4tQghCcJdyvb01NZ43B4V1V42Zr7nOduK8FFn0KSIl0p6IXkTeMGeDV7hRzHX/K8io+fbzoFBzgMR0qwaSFixKKxvV6KSMJM5kIGNukn+cu8dnHp5xOSv5kNRDkd/aZttfuVvFXKOZyhlfX8dofY+SL+UhKF7kluink/M3og6DyIpEv5c15tnDq4yoGwcZ4nowmz6WwwMMze8b3hAocdIwxhhw5aZHl3p+++ZuUxuNHqcVfbVgdFjNWRU5ASJmMfn/oyMGbR7P/WacfBeWHZdzZ/YgK7lRNgYFFbFYWKMtp24bSJGApFZgWgF/VIFLASAaUICDu2RByuqFW0JvlWsLPyuCYdsMn6e9xmjd7JGXomgN+dbIlYjDFSOyN6dUvKKlS2p9QsUVtC2nOdQX6AN8TWeBJMp/jTKSDvVVtB0Xh7QmLFEfevOnmsqxVUJGOhyEWkIvfM33mZ8mFWcr6EcpHqCPbwR+a43mulrkHSx84IkZxypMMFGEUa7NxPBTjrP5sZGRjGwwVfzuA1k338zUSCjt5SqEsL0fP6DEZzyMM5XQpBI+8nnb0ZkEjjW5UJEjymTjFD30LcsFEZoc1uLhac6w7YvJqXjRLm8ozN/RUuSSX653BYUQatTk1S0W1KkccgD7HvxOrGiNaoyaICq3Xcs8wRnn4+K+QplAoQWATWWxz6k9Nrz0wwHUb1Zua927KgRJNZPptgCcUcahf2S4a9W4lPlCJh5zKNDuq0811orY17CyBfZXP9WsLXOeVIIUlCXjviwfq4gu8lWUGUGIh9U+00Ck2BhkgRrOPPmC2a5cVz/hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a30a274-73bd-4a2d-1c65-08dbd1084151
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:02:39.0798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skcki5zlirEfMnrOwyCUp4xE8IG8kNscBVp2Yj4v9GRVg1CewRWcSBGVahFxea0JkDsrc7k+AjUyShYFgAXNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_23,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200006
X-Proofpoint-ORIG-GUID: iI_SymNdSmRhjMX-a6vLAOZZrKLyh-rU
X-Proofpoint-GUID: iI_SymNdSmRhjMX-a6vLAOZZrKLyh-rU
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

CgpPbiAxMC8xOS8yMDIzIDI6MjkgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBX
ZWQsIE9jdCAxOCwgMjAyMyBhdCAwNDo0Nzo0OFBNIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
Pgo+Pgo+PiBPbiAxMC8xOC8yMDIzIDE6MDUgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj4+IE9uIFR1ZSwgT2N0IDE3LCAyMDIzIGF0IDEwOjExOjMzUE0gLTA3MDAsIFNpLVdlaSBMaXUg
d3JvdGU6Cj4+Pj4gUkZDIG9ubHkuIE5vdCB0ZXN0ZWQgb24gdmRwYS1zaW0tYmxrIHdpdGggdXNl
ciB2aXJ0dWFsIGFkZHJlc3MuCj4+Pj4gV29ya3MgZmluZSB3aXRoIHZkcGEtc2ltLW5ldCB3aGlj
aCB1c2VzIHBoeXNpY2FsIGFkZHJlc3MgdG8gbWFwLgo+Pj4+Cj4+Pj4gVGhpcyBwYXRjaCBpcyBi
YXNlZCBvbiB0b3Agb2YgWzFdLgo+Pj4+Cj4+Pj4gWzFdIAo+Pj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3ZpcnR1YWxpemF0aW9uLzE2OTY5Mjg1ODAtNzUyMC0xLWdpdC1zZW5kLWVtYWlsLXNp
LXdlaS5saXVAb3JhY2xlLmNvbS8KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pgo+Pj4+IC0tLQo+Pj4+IFJGQyB2MjoKPj4+PiDC
oC0gaW5pdGlhbGl6ZSBpb3RsYiB0byBwYXNzdGhyb3VnaCBtb2RlIGluIGRldmljZSBhZGQKPj4+
Cj4+PiBJIHRlc3RlZCB0aGlzIHZlcnNpb24gYW5kIEkgZGlkbid0IHNlZSBhbnkgaXNzdWUgOy0p
Cj4+IEdyZWF0LCB0aGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBoZWxwIG9uIHRlc3RpbmcgbXkg
cGF0Y2gsIFN0ZWZhbm8hCj4KPiBZb3UncmUgd2VsY29tZSA6LSkKPgo+PiBKdXN0IGZvciBteSBv
d24gaW50ZXJlc3QvY3VyaW9zaXR5LCBjdXJyZW50bHkgdGhlcmUncyBubyB2aG9zdC12ZHBhIAo+
PiBiYWNrZW5kIGNsaWVudCBpbXBsZW1lbnRlZCBmb3IgdmRwYS1zaW0tYmxrCj4KPiBZZXAsIHdl
IGRldmVsb3BlZCBsaWJibGtpbyBbMV0uIGxpYmJsa2lvIGV4cG9zZXMgY29tbW9uIEFQSSB0byBh
Y2Nlc3MgCj4gYmxvY2sgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIEl0IHN1cHBvcnRzIHNldmVyYWwg
ZHJpdmVycy4KPiBUaGUgb25lIHVzZWZ1bCBmb3IgdGhpcyB1c2UgY2FzZSBpcyBgdmlydGlvLWJs
ay12aG9zdC12ZHBhYC4gSGVyZSBbMl0gCj4gc29tZSBleGFtcGxlcyBvbiBob3cgdG8gdXNlIHRo
ZSBsaWJibGtpbyB0ZXN0IHN1aXRlIHdpdGggdGhlIAo+IHZkcGEtc2ltLWJsay4KPgo+IFNpbmNl
IFFFTVUgNy4yLCBpdCBzdXBwb3J0cyBsaWJibGtpbyBkcml2ZXJzLCBzbyB5b3UgY2FuIHVzZSB0
aGUgCj4gZm9sbG93aW5nIG9wdGlvbnMgdG8gYXR0YWNoIGEgdmRwYS1ibGsgZGV2aWNlIHRvIGEg
Vk06Cj4KPiDCoCAtYmxvY2tkZXYgCj4gbm9kZS1uYW1lPWRyaXZlX3NyYzEsZHJpdmVyPXZpcnRp
by1ibGstdmhvc3QtdmRwYSxwYXRoPS9kZXYvdmhvc3QtdmRwYS0wLGNhY2hlLmRpcmVjdD1vbiAK
PiBcCj4gwqAgLWRldmljZSB2aXJ0aW8tYmxrLXBjaSxpZD1zcmMxLGJvb3RpbmRleD0yLGRyaXZl
PWRyaXZlX3NyYzEgXAo+Cj4gRm9yIG5vdyBvbmx5IHdoYXQgd2UgY2FsbGVkIHNsb3ctcGF0aCBb
M11bNF0gaXMgc3VwcG9ydGVkLCBzaW5jZSB0aGUgCj4gVlFzIGFyZSBub3QgZGlyZWN0bHkgZXhw
b3NlZCB0byB0aGUgZ3Vlc3QsIGJ1dCBRRU1VIGFsbG9jYXRlcyBvdGhlciAKPiBWUXMgKHNpbWls
YXIgdG8gc2hhZG93IFZRcyBmb3IgbmV0KSB0byBzdXBwb3J0IGxpdmUtbWlncmF0aW9uIGFuZCBR
RU1VIAo+IHN0b3JhZ2UgZmVhdHVyZXMuIEZhc3QtcGF0aCBpcyBvbiB0aGUgYWdlbmRhLCBidXQg
b24gcGF1c2UgZm9yIG5vdy4KPgo+PiBvciBhbnkgdmRwYSBibG9jayBkZXZpY2UgaW4gdXNlcnNw
YWNlIGFzIHlldCwgY29ycmVjdD8gCj4KPiBEbyB5b3UgbWVhbiB3aXRoIFZEVVNFPwo+IEluIHRo
aXMgY2FzZSwgeWVzLCBxZW11LXN0b3JhZ2UtZGFlbW9uIHN1cHBvcnRzIGl0LCBhbmQgY2FuIGlt
cGxlbWVudCAKPiBhIHZpcnRpby1ibGsgaW4gdXNlciBzcGFjZSwgZXhwb3NpbmcgYSBkaXNrIGlt
YWdlIHRob3JvdWdoIFZEVVNFLgo+Cj4gVGhlcmUgaXMgYW4gZXhhbXBsZSBpbiBsaWJibGtpbyBh
cyB3ZWxsIFs1XSBvbiBob3cgdG8gc3RhcnQgaXQuCj4KPj4gU28gdGhlcmUgd2FzIG5vIHRlc3Qg
c3BlY2lmaWMgdG8gdmhvc3QtdmRwYSB0aGF0IG5lZWRzIHRvIGJlIAo+PiBleGVyY2lzZWQsIHJp
Z2h0Pwo+Pgo+Cj4gSSBob3BlIEkgYW5zd2VyZWQgYWJvdmUgOi0pCkRlZmluaXRlbHkhIFRoaXMg
aXMgZXhhY3RseSB3aGF0IEkgbmVlZGVkLCBpdCdzIHJlYWxseSB1c2VmdWwhIE11Y2ggCmFwcHJl
Y2lhdGVkIGZvciB0aGUgZGV0YWlsZWQgaW5mb3JtYXRpb24hCgpJIGhhZG4ndCBiZWVuIGF3YXJl
IG9mIHRoZSBsYXRlc3Qgc3RhdHVzIG9uIGxpYmJsa2lvIGRyaXZlcnMgYW5kIHFlbXUgCnN1cHBv
cnQgc2luY2UgSSBsYXN0IGNoZWNrZWQgaXQgKGl0IHdhcyBhdCBzb21lIHBvaW50IHJpZ2h0IGFm
dGVyIEtWTSAKMjAyMiwgc29ycnkgbXkga25vd2xlZGdlIHRvbyBvdXRkYXRlZCkuIEkgZm9sbG93
ZWQgeW91ciBsaW5rcyBiZWxvdyBhbmQgCmNoZWNrZWQgYSBmZXcgdGhpbmdzLCBsb29rcyBteSBj
aGFuZ2Ugc2hvdWxkbid0IGFmZmVjdCBhbnl0aGluZy4gR29vZCB0byAKc2VlIGFsbCB0aGUgZGVz
aXJlZCBwaWVjZXMgbGFuZGVkIHRvIFFFTVUgYW5kIGxpYmJsa2lvIGFscmVhZHkgYXMgCnBsYW5u
ZWQsIGdyZWF0IGpvYiBkb25lIQoKQ2hlZXJzLAotU2l3ZWkKCj4gVGhpcyByZW1pbmRlZCBtZSB0
aGF0IEkgbmVlZCB0byB3cml0ZSBhIGJsb2cgcG9zdCB3aXRoIGFsbCB0aGlzIAo+IGluZm9ybWF0
aW9uLCBJIGhvcGUgdG8gZG8gdGhhdCBzb29uIQo+Cj4gU3RlZmFubwo+Cj4gWzFdIGh0dHBzOi8v
Z2l0bGFiLmNvbS9saWJibGtpby9saWJibGtpbwo+IFsyXSAKPiBodHRwczovL2dpdGxhYi5jb20v
bGliYmxraW8vbGliYmxraW8vLS9ibG9iL21haW4vdGVzdHMvbWVzb24uYnVpbGQ/cmVmX3R5cGU9
aGVhZHMjTDQyCj4gWzNdIAo+IGh0dHBzOi8va3ZtZm9ydW0yMDIyLnNjaGVkLmNvbS9ldmVudC8x
NWpLNS9xZW11LXN0b3JhZ2UtZGFlbW9uLWFuZC1saWJibGtpby1leHBsb3JpbmctbmV3LXNob3Jl
cy1mb3ItdGhlLXFlbXUtYmxvY2stbGF5ZXIta2V2aW4td29sZi1zdGVmYW5vLWdhcnphcmVsbGEt
cmVkLWhhdAo+IFs0XSAKPiBodHRwczovL2t2bWZvcnVtMjAyMS5zY2hlZC5jb20vZXZlbnQva2Uz
YS92ZHBhLWJsay11bmlmaWVkLWhhcmR3YXJlLWFuZC1zb2Z0d2FyZS1vZmZsb2FkLWZvci12aXJ0
aW8tYmxrLXN0ZWZhbm8tZ2FyemFyZWxsYS1yZWQtaGF0Cj4gWzVdIAo+IGh0dHBzOi8vZ2l0bGFi
LmNvbS9saWJibGtpby9saWJibGtpby8tL2Jsb2IvbWFpbi90ZXN0cy9tZXNvbi5idWlsZD9yZWZf
dHlwZT1oZWFkcyNMNTgKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
