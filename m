Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528E9C4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 14:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7FEE4F68A;
	Mon, 30 Oct 2023 14:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7FEE4F68A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=B/jwdMSG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=eoGNjFP5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBYwruhiRtAi; Mon, 30 Oct 2023 14:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C888D4F661;
	Mon, 30 Oct 2023 14:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C888D4F661
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F885C0071;
	Mon, 30 Oct 2023 14:05:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49C89C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24D63704B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24D63704B0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=B/jwdMSG; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=eoGNjFP5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AocrmaDqlaA9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:05:53 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0380670481
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:05:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0380670481
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UDpSNY010973; Mon, 30 Oct 2023 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=B/jwdMSGbQmLMlDtcFXEw6oAGwfFxy/nL87NOpBtHYMxTCKGv08waFRMugVE4GQCkr96
 z1jygKTBCu0/DcTzZjQMNyxRc3BF1XAPp3EX0R800lWHKkgVLg68kXeuQY2t+y1JkZJH
 IPIocOk+4hOQqvAsQpI6wgeYD1WaSFD/AsLpvboYse5Lll2gLIDdiHbePKrXgGy+dFTw
 3qqrMXb1vFRUrpZXiauqXo+a7nAzk2++aWGb5MhG/B4Up24QrCxVyeEuhXzmblaNu8Q3
 QjFYmOQ5+2Tqmml3JCg6jEirMtArNorKTeceZX3V1SbHSZ2g4pnA/5uPjRAx0eMorANs kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7btug8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 14:05:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39UE3QJG009195; Mon, 30 Oct 2023 14:05:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u14x46594-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 14:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVIKVhWCZuCrQT8O16N4o/WfaWWTj4weiXQg2w24lT9QQNxu4ymID0OnI5wumbjk/gM81PyHZcGaJZdTlK3JlyVxuSvwMXBMC70jungjK/nw7Elb3lFRG+RLp50wmNU3LM4LIjYiyHcHeEH/siBApYAcS4X43sYblGTgGr1MvqNbwlggo6hI/COtewC6djbMqdOvUAluykEMFBAs3Fi1RxcNzfv3hF+lBfB5YJ6GuzJmuAx+n7yA81Omxq4wCQPoyYU5QTG5TmXi+S+GeCal32LjqLWfG7ib0OwwsB8qMbZtmvW9kbF4OH7LgvpNzRuLmxjlxVLPXHjqKxX+r00inA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=Ae7m5idSatFF1m2NuDi2K+EPvNtdr+KmkJi2uDNgmyuKZvX55rXo72mDLzcoX4qPduKbvND7qRZ86dUE+1A20B+rVhOjTHWjRzAmAEtzm+WgcVS8cM+jJ+pKpvqIYbwuGWlKomJRZ3q5+wPQi3WOSp1U3VQNiK6glOT+MbTrSWKiNh+79Gkrf0Y5tVqcTM9T4KJO6+ljHk5dFD3CyrqV59tu+bp4zuoMSNJ/tJhWfOIJeb90xon/G8EkNGYLuZWawrGEinu/gh5lUSdBK6XpuLV98I6mvaBlftOUawWSkk/fmdJImXuc632oK9mTii7EuX81EmfqVKB0lD3LDyM3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=eoGNjFP5grqeadWkOtRY08cUuT7XKp6FhCcJgDsQ+2FQ37vfoG20GLBMOzFynlDM/B0XdYPajwIOj/uELvDvW7UoZ0/CTFsS1VU47RMhvMNFbUnN8fn3I0Yc3RP5zCPf1DQwJGQa6bB5hRqp00r/RklsEu5t/zmNntXFtKecA8I=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ2PR10MB7013.namprd10.prod.outlook.com (2603:10b6:a03:4c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 30 Oct
 2023 14:05:42 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 14:05:42 +0000
Message-ID: <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
Date: Mon, 30 Oct 2023 10:05:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To: Jason Wang <jasowang@redhat.com>
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ2PR10MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f313f4-a4d7-4042-700d-08dbd9514dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1Y3pSMCDlbgg+ts2w7CR8KeFOGvwFqvhXbmwkvKzhZyetv+VDZjwglJVVEHGFmbwkORl4r8fMwxb8JdhAqU9miH3GhAX0KoNlTSd4T3csggt215VhtBMOFBWaQXoIaVFS6hefRBBeOk89E1Wu+2ArNa8B6b8nq8eAmcfcMLAz+coyPuqM9i5vppRvDImwQ7xOKH5R/6XNPJe0Iu4bvWJp78eUa0othHxla43yHpwbtPfxq/f5iuywqAlEEqHsjI+BXDygUat/zbLYdN4hKwsJ6D4Js2zWBPFJp1jNErlq5Y16op28rjZrJ/k2b0LapN0u08OaBt6Fct2iXa2IO9W53KZOcwPBEMoZ0wEUZDGX++01TyAFHKVjeMDO+s6SAh8382KCYSTJwKSb5YO1BxvD4FlrK9oQXPltukg1LTtZLEtHJVOAa20TugwZTUBzim3wjjVf8eKYmu7zX2LLd086U5iP0F+KEiRbHWaNg87ydEdIh0OtMyJgo3/BsEhDhkPrlLhFxvtqEW1Hr11D6UvUklF8hzAqMlDd0e8A9aSWPPDaACjEQuaLqLEvDUqV0WYBVdvXDT+DJoGy/jd4cXMB4/OrDsLHFTpgBcH+tAxxhpxYSEQk6w7GQ+G0bZ+EyBEo2rQlmKEzlr2S9j/wfmZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(66476007)(66556008)(86362001)(2906002)(36756003)(66946007)(54906003)(6666004)(478600001)(316002)(6916009)(2616005)(53546011)(8936002)(6486002)(5660300002)(38100700002)(44832011)(41300700001)(83380400001)(31696002)(36916002)(8676002)(4326008)(26005)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vld2SnZoelBlMUNPQ1hqNVpERXVXc1RiL0Jidkk1SThoeW5na0tSY1FseWJ6?=
 =?utf-8?B?WnRiMWUwWng3NGlES0Y0SEFUcjFEd1RMR21xVFczY0xnOGdBY1EwQUVqbmJI?=
 =?utf-8?B?UHcva3NOeTlEaFlsQlJuMGQvdVpWbVo4cWJCR1paMnhGNXlJRnJRNHRvblJm?=
 =?utf-8?B?TGJ5eGZ4MmlXZTA4ZkFLRDVTMlN1dGlwSU5GVFdvQlhTcVY3Sll2clozZXQ5?=
 =?utf-8?B?K0hBUnMxTnViZHd4Ky81d0J6ZVIzcWttVTVSdTNrd1RCRGhZK2Y4Zmk3aEV1?=
 =?utf-8?B?YU0vSndMNDUyby9KYmpKWDFKT3kyellpNVJweVBRcWlMb0V1NWQ0RDV0TVlT?=
 =?utf-8?B?aXhMV0p2RWlQdU81SE9rb3l4aGZIdkdZaFpPMndETlVDUWdTZ3pBK0NvaDZX?=
 =?utf-8?B?c2FRcU1lQThKOTNvSFd4MXZsYzZqbGpnWEZuek96bXZNZVFXYXk0bW91OEZs?=
 =?utf-8?B?TEhIU3VVR3RIM2NCQWszaU5IZU9jWFFTTU95MHZ1cmJVMUowQmRoeWJIZk5V?=
 =?utf-8?B?d09JdGNaODFvZU45TEd2V2cwUlVtVFZGWFpDek9KdnVGdkRzRnFMNVROOUFN?=
 =?utf-8?B?aUxiVXZ1RDR0QXlENC9aaXR0aVdyZ1BMdFZGSVQ4S3pQWmovWFBKdnRtVXB0?=
 =?utf-8?B?M1Y0OFBFNnY2d1dOUktPaHZ0MEhwSVlyU3E1Y3lMaGRxeFFYSWtYUmFmenV4?=
 =?utf-8?B?RnAzeTZzQTk0QkIyMEdzeFVqMCt5Y25GZk95WTk3bVovQTM4NU1teDRCSlJZ?=
 =?utf-8?B?ZzhnZUVTTE5qVkpHOTI1ZEhodjNuejkxaThWNStXQVV0c0tPUXpBTGgvL2xt?=
 =?utf-8?B?MXlJVUtkWVA4UkJzalcvOFN1Qnd0ZWRYSEFlSUZPdkd5czJjc2lDQjBDclRr?=
 =?utf-8?B?WWljTjVPK09iUFB6MWZMV2xwUjZ1dC8zbEltSjAvOHBmcFJud0FuQVBrVC94?=
 =?utf-8?B?N3lTdDdEZEd2eE0rb2NWZXdCeDcxckhTWEszNUlHOWM1cmpZQmhOMC9zb3N4?=
 =?utf-8?B?bVlONDdWakxWcHVaUXJOelh6SGlLRzcyMmpObCtuaFNNRFNuUDcvOVU0Q25r?=
 =?utf-8?B?d1QveVVLc2VsWElsMnpIVGY5elJiNVMvSXBLVDZWWWFCTkRscnMyY2pjTS80?=
 =?utf-8?B?ZEJKODFrSDJBWUFkTEhZbUV5Uys3ZUhDY1lCeEpKTERETjV3L0lQUDl1aTBI?=
 =?utf-8?B?U2haS0I3bjU3a3dHVkFoRHpRMlRFNTdnMXVHMWhnSjV4NHZEL3c0ZGxzQjVE?=
 =?utf-8?B?RjIveXBOcy9IVHFQQ1VleEwrTklkVGdRdTRjK0cycUwyOTR3cnVCeXpDOVA1?=
 =?utf-8?B?QWNKOTVEektlR1BLQ0lKU3M1V0RONC80UVVGVytrUzd0Y2I1KzQwSDllTUQ1?=
 =?utf-8?B?UFNiSGFjVC8xQUoxL3BJUHI5L1FQUVZVZkQ2WjJ2OWxYYW9aMlNKcnhRWnk5?=
 =?utf-8?B?TDBLWWtaY01keXFYNDBTZVVuY1hQNURxbDFqN1lvU3pYRlgrTDdjSFF2bDha?=
 =?utf-8?B?Z1l5QjByWmFDQWZVcWxCcllRdWlPcTFvaUU1WDJETklHc1Z5bDRxc0lzLzVu?=
 =?utf-8?B?aTU2d0xJOTNkNFNVVmR4cWJwQnVhVEF5QTN4bTAzNGZtRGVnc25TNGJYditU?=
 =?utf-8?B?Y1BEbXRSbkgySUQ5SVFPVi9wM2haR0sxWTNWSU1yVVlCQzlPeElxMkJZQWVl?=
 =?utf-8?B?NC8zSmppSTJNQ0tQTzNvRXlKeERJM3hlOUdmVXFKQlZxSG9SUFZ3Vk5oSDZ1?=
 =?utf-8?B?RGlVV2VVa3BQSXhYWkVTNWQ1NERqVFF3QkdrQWF5eG1rb2RIdVNTVmNaQ2Jq?=
 =?utf-8?B?aTdxMkMwTXkyeXBWVkRRY2lQWHg0dVNFVHRoQzZIb1E1ZFhzQ3VpWFhVb3l6?=
 =?utf-8?B?K2pvOUFhMmpMZTVza3p0OCtSdm1SdjVsb1JnaWtDcHFHaHJKdlArdE1KSnc4?=
 =?utf-8?B?Z2MwSHVZdURpY3Uxenp0b3JhT3g2WUxzeXgvbnFHaUZ6UldnZjdNcVZxV0M5?=
 =?utf-8?B?UGtJRzFBZ2hlYTR4NEVUdkNBci96YWZBOWZqWkh6SFBqcWNnV3FHVVdYYitR?=
 =?utf-8?B?TVJTb1crZmlIZnRqTnNXVnFlRFdsbm4wMVZEeUI3RnI5N1FBV3BNS3BEakhw?=
 =?utf-8?B?QzBTMlNwalp0bVZpSWVHNzBFT1NkV2E0aGlyQXhrWWdSTDBYRkxoajk5MUpO?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z2VDd1lQUGJndjk0RE5sbWw1SlFFaGJlb09hV2kwK01kNk9PNmlBejRVUGhT?=
 =?utf-8?B?QThGNmEyT0ZnMkVwZGY4alFHMlZHSUZzY1BlWXhFMHJ3NUFNWjN5Tk9UVkdt?=
 =?utf-8?B?eEw4M1dydWZGTEdpUjNEL0V1YVBFT2tJVFJhdUp0TUt4SlZ0SzV1NUdQTGEr?=
 =?utf-8?B?VHQrYVJXMTBLRjJnbDA1OFZMVmhjUjl1UTE4dFRNazZsM05vVUJPeGZMZnhu?=
 =?utf-8?B?YnJjT1dYSUl5YXBVSGo3WFh3aGdrMHNMR0luR3Y2WGNGSXl0dG9VQ1F3S0hH?=
 =?utf-8?B?WUQrR2t1TWtMYnhhak9CR1dYTk43SUxZUWQ2NWw0ay9hT2tHOWd5SGZXTkF4?=
 =?utf-8?B?ZGdmOC9QTnVwYk9rSTlhbDRtT0RkNER2Q3ZvUmg0L1NIQTRBdzB1dEYzRWd2?=
 =?utf-8?B?bEIzSDhMYnpQdHppZ1FOaEZGZ1hEOHRNWlNvdkprSysxa1Jqa2ViZWZNQUo5?=
 =?utf-8?B?UHYzeTVRUVl2VGVXbEhuR1A4clNVKzFMZGpSeCtCR2pJcTExZFBpcHlGWjkv?=
 =?utf-8?B?eFU0YjFxQndyTDBJZGpscWJvYldleVNEcHZHY3V0dlJrbUJMbm9reUpyVk1F?=
 =?utf-8?B?TDRRVStCQnhCV2pzbzRrcjV1TVovSFd2Q0hPQ2lMQ29VTTZVbVNoS1EzOEdj?=
 =?utf-8?B?ZVY4YVlDeVdrdndnM2dxYit6MFV0T2lVZTdTVUV5WXQ3MnI1ZVR3ZnRrRXZw?=
 =?utf-8?B?c0pUOWp2UzBQUEdZZEFnU3J3eUwydDRLYnJoQ3J2WndLYXJLL2xTR3h4VVBa?=
 =?utf-8?B?cXhldENrWDRnREtVTlRBSCtTUVByR2lYRHJCbTJLdHlsbTNQUER3cStoekJt?=
 =?utf-8?B?bTdPT2VCdXpOd3RBeEtMdjRIaWJ4ektNZXdqZ05QTkdFV0k1UkdhN2JQNVBy?=
 =?utf-8?B?RkZBSHJtRHlOUnBZU1pON3AxbE0zOHJlalViWnpJTGpmMW5adktzdmpIbVM1?=
 =?utf-8?B?eVFhdHZTZFVmM1RjRUN4NWFrWmN3QlpvUmRFeEtXNjNoWkRoQnN2WjJGUnFM?=
 =?utf-8?B?RE1VT2pVcVJCbXNQSmUxRnpjZ2hwRjMxb3ZzQy9LaEhCM1dHb281emtQVHJF?=
 =?utf-8?B?MUtWOW1lTVVEZVN0ZGtlMTkwUTZDWWZjc0F1NzFoUUM1OTJDb2ZqRis0RHFr?=
 =?utf-8?B?V3NSeEhnakZDUk93ZzIzeTlRYlNaWENhVHRuakV4LzQwcld0M2h1UnAweTNN?=
 =?utf-8?B?Si9zbWp0YTdGMkh0QmZOM29zYmY2b2hmR1g1VkZncElYNjRxWkYvR2JXTzUw?=
 =?utf-8?Q?COD9nUZ4uZrOjGR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f313f4-a4d7-4042-700d-08dbd9514dd4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:05:42.6164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klSR3k7P/BY9xhTQZymYv3nrm8zdP6oAZTfYEtFthz91oZpiUx6q1OkSnvn/C7YxSGXgzqtI6JZWzPaAyrOGUNmW2IWm86F7OSAMrsYfQ54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300107
X-Proofpoint-GUID: 8j_Nm4Gy1uRHeGRckaZai463SC-wB-1W
X-Proofpoint-ORIG-GUID: 8j_Nm4Gy1uRHeGRckaZai463SC-wB-1W
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTAvMjcvMjAyMyAyOjMxIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgT2N0IDI3
LCAyMDIzIGF0IDQ6MDfigK9BTSBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPiB3cm90ZToKPj4KPj4gbWx4NV92ZHBhIGRvZXMgbm90IHByZXNlcnZlIHVzZXJsYW5kJ3Mg
dmlldyBvZiB2cmluZyBiYXNlIGZvciB0aGUgY29udHJvbAo+PiBxdWV1ZSBpbiB0aGUgZm9sbG93
aW5nIHNlcXVlbmNlOgo+Pgo+PiBpb2N0bCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+PiBpb2N0bCBW
SE9TVF9WRFBBX1NFVF9TVEFUVVMgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSwo+PiAgIG1seDVf
dmRwYV9zZXRfc3RhdHVzKCkKPj4gICAgIHNldHVwX2N2cV92cmluZygpCj4+ICAgICAgIHZyaW5n
aF9pbml0X2lvdGxiKCkKPj4gICAgICAgICB2cmluZ2hfaW5pdF9rZXJuKCkKPj4gICAgICAgICAg
IHZyaC0+bGFzdF9hdmFpbF9pZHggPSAwOwo+PiBpb2N0bCBWSE9TVF9HRVRfVlJJTkdfQkFTRQo+
Pgo+PiBUbyBmaXgsIHJlc3RvcmUgdGhlIHZhbHVlIG9mIGN2cS0+dnJpbmcubGFzdF9hdmFpbF9p
ZHggYWZ0ZXIgY2FsbGluZwo+PiB2cmluZ2hfaW5pdF9pb3RsYi4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+ICBk
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAgNyArKysrKystCj4+ICBkcml2ZXJz
L3Zob3N0L3ZyaW5naC5jICAgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPj4gIGluY2x1ZGUvbGludXgvdnJpbmdoLmggICAgICAgICAgICB8ICAyICsrCj4+ICAz
IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBpbmRleCA5NDY0ODhiODk4OWYuLmY2NDc1ODE0MzEx
NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBAQCAtMjc5NSwxMyArMjc5
NSwxOCBAQCBzdGF0aWMgaW50IHNldHVwX2N2cV92cmluZyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYpCj4+ICAgICAgICAgc3RydWN0IG1seDVfY29udHJvbF92cSAqY3ZxID0gJm12ZGV2LT5j
dnE7Cj4+ICAgICAgICAgaW50IGVyciA9IDA7Cj4+Cj4+IC0gICAgICAgaWYgKG12ZGV2LT5hY3R1
YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkKPj4gKyAgICAgICBp
ZiAobXZkZXYtPmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX0NUUkxfVlEp
KSB7Cj4+ICsgICAgICAgICAgICAgICB1MTYgbGFzdF9hdmFpbF9pZHggPSBjdnEtPnZyaW5nLmxh
c3RfYXZhaWxfaWR4Owo+PiArCj4+ICAgICAgICAgICAgICAgICBlcnIgPSB2cmluZ2hfaW5pdF9p
b3RsYigmY3ZxLT52cmluZywgbXZkZXYtPmFjdHVhbF9mZWF0dXJlcywKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1MWDVfQ1ZRX01BWF9FTlQsIGZhbHNlLAo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB2cmluZ19kZXNj
ICopKHVpbnRwdHJfdCljdnEtPmRlc2NfYWRkciwKPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdfYXZhaWwgKikodWludHB0cl90KWN2cS0+ZHJp
dmVyX2FkZHIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Ry
dWN0IHZyaW5nX3VzZWQgKikodWludHB0cl90KWN2cS0+ZGV2aWNlX2FkZHIpOwo+Pgo+PiArICAg
ICAgICAgICAgICAgaWYgKCFlcnIpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZyaW5naF9z
ZXRfYmFzZV9pb3RsYigmY3ZxLT52cmluZywgbGFzdF9hdmFpbF9pZHgpOwo+IAo+IEJ0dywgdnJp
bmdoX3NldF9iYXNlX2lvdGxiKCkgZGVzZXJ2ZXMgYW4gaW5kZXBlbmRlbnQgcGF0Y2ggYW5kIGl0
Cj4gc2VlbXMgaXQgaXMgbm90IHNwZWNpZmljIHRvIElPVExCLCAKCkFncmVlZCBvbiBib3RoLiAg
SSBpbml0aWFsbHkgc3VibWl0dGVkIHRoZSBzbWFsbGVzdCBjaGFuZ2UgbmVlZGVkIHRvIHNob3cg
dGhlIHByb2JsZW0uCgpzbyB3ZSBwcm9iYWJseSBuZWVkIGFuIGluZGlyZWN0aW9uCj4gdG8gaGF2
ZSB2cmluZ2hfc2V0X2Jhc2UoKSBmaXJzdC4KCk5vdCBzdXJlIHdoYXQgeW91IG1lYW4uICBJIGhh
dmUgZGVmaW5lZDoKCiAgICBzdGF0aWMgaW5saW5lIGludCBfX3ZyaW5naF9zZXRfYmFzZSgpIC4u
LgoKICAgIGludCB2cmluZ2hfc2V0X2Jhc2VfaW90bGIoKQogICAgICAgIHJldHVybiBfX3ZyaW5n
aF9zZXRfYmFzZSh2cmgsIGlkeCwgcHV0dTE2X2lvdGxiKTsKCnRvIHdoaWNoIEkgd291bGQgYWRk
OgoKICAgIGludCB2cmluZ2hfc2V0X2Jhc2VfdXNlcigpCiAgICAgICAgcmV0dXJuIF9fdnJpbmdo
X3NldF9iYXNlKHZyaCwgaWR4LCBwdXR1MTZfdXNlcik7CgogICAgaW50IHZyaW5naF9zZXRfYmFz
ZV9rZXJuKCkKICAgICAgICByZXR1cm4gX192cmluZ2hfc2V0X2Jhc2UodnJoLCBpZHgsIHB1dHUx
Nl9rZXJuOwoKYWxsIGluIHRoZSBzYW1lIHBhdGNoLgoKVGhlIGNhbGwgc2l0ZSBpbiBtbHg1X3Zu
ZXQuYyB3b3VsZCBiZSBhIDJuZCBwYXRjaC4KCi0gU3RldmUKCj4gT3IgSSB3b25kZXIgaWYgaXQn
cyBiZXR0ZXIgdG8ganVzdCBpbnRyb2R1Y2UgYSBuZXcgcGFyYW1ldGVyIHRvCj4gdnJpbmdoX2lu
aXRfaW90bGIoKS4uLgoKSSBjb25zaWRlcmVkIHRoYXQsIGJ1dCBJTU8gdGhlIHBhcmFtZXRlciBs
aXN0IHRoZXJlIGlzIGFscmVhZHkgbGFyZ2UsIGFuZCBpdCB3b3VsZApiZSBzdHJhbmdlIHRvIGFk
ZCBhIHBhcmFtZXRlciBmb3IgdGhlIGluaXRpYWwgdmFsdWUgb2YgYXZhaWwsIGJ1dCBub3QgZm9y
IHVzZWQsIGFuZApubyBvbmUgbmVlZHMgdGhlIGxhdHRlci4KCi0gU3RldmUKCj4+ICsgICAgICAg
fQo+PiAgICAgICAgIHJldHVybiBlcnI7Cj4+ICB9Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+PiBpbmRleCA3YjhmZDk3
N2Y3MWMuLjc5OTc2MmM4MzAwNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2gu
Ywo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+IEBAIC01OTUsNiArNTk1LDI0IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBfX3ZyaW5naF9ub3RpZnlfZGlzYWJsZShzdHJ1Y3QgdnJpbmdo
ICp2cmgsCj4+ICAgICAgICAgfQo+PiAgfQo+Pgo+PiArc3RhdGljIGlubGluZSBpbnQgX192cmlu
Z2hfc2V0X2Jhc2Uoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4LAo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ICgqcHV0dTE2KShjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX192aXJ0aW8xNiAqcCwgdTE2IHZhbCkp
Cj4+ICt7Cj4+ICsgICAgaW50IHJldDsKPj4gKwo+PiArICAgIHJldCA9IHB1dHUxNih2cmgsICZ2
cmgtPnZyaW5nLmF2YWlsLT5pZHgsIGlkeCk7Cj4+ICsgICAgaWYgKHJldCkKPj4gKyAgICAgICAg
cmV0dXJuIHJldDsKPj4gKwo+PiArICAgIHJldCA9IHB1dHUxNih2cmgsICZ2cmgtPnZyaW5nLnVz
ZWQtPmlkeCwgaWR4KTsKPj4gKyAgICBpZiAocmV0KQo+PiArICAgICAgICByZXR1cm4gcmV0Owo+
PiArCj4+ICsgICAgdnJoLT5sYXN0X2F2YWlsX2lkeCA9IHZyaC0+bGFzdF91c2VkX2lkeCA9IGlk
eDsKPj4gKyAgICByZXR1cm4gMDsKPj4gK30KPj4gKwo+PiAgLyogVXNlcnNwYWNlIGFjY2VzcyBo
ZWxwZXJzOiBpbiB0aGlzIGNhc2UsIGFkZHJlc3NlcyBhcmUgcmVhbGx5IHVzZXJzcGFjZS4gKi8K
Pj4gIHN0YXRpYyBpbmxpbmUgaW50IGdldHUxNl91c2VyKGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZy
aCwgdTE2ICp2YWwsIGNvbnN0IF9fdmlydGlvMTYgKnApCj4+ICB7Cj4+IEBAIC0xNDU2LDYgKzE0
NzQsMTggQEAgdm9pZCB2cmluZ2hfc2V0X2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwgc3RydWN0
IHZob3N0X2lvdGxiICppb3RsYiwKPj4gIH0KPj4gIEVYUE9SVF9TWU1CT0wodnJpbmdoX3NldF9p
b3RsYik7Cj4+Cj4+ICsvKioKPj4gKyAqIHZyaW5naF9zZXRfYmFzZV9pb3RsYiAtIHNldCBhdmFp
bF9pZHggYW5kIHVzZWRfaWR4Cj4+ICsgKiBAdnJoOiB0aGUgdnJpbmcKPj4gKyAqIEBpZHg6IHRo
ZSB2YWx1ZSB0byBzZXQKPj4gKyAqLwo+PiAraW50IHZyaW5naF9zZXRfYmFzZV9pb3RsYihzdHJ1
Y3QgdnJpbmdoICp2cmgsIHUxNiBpZHgpCj4+ICt7Cj4+ICsgICAgcmV0dXJuIF9fdnJpbmdoX3Nl
dF9iYXNlKHZyaCwgaWR4LCBwdXR1MTZfaW90bGIpOwo+PiArfQo+PiArRVhQT1JUX1NZTUJPTCh2
cmluZ2hfc2V0X2Jhc2VfaW90bGIpOwo+PiArCj4+ICsKPj4gIC8qKgo+PiAgICogdnJpbmdoX2dl
dGRlc2NfaW90bGIgLSBnZXQgbmV4dCBhdmFpbGFibGUgZGVzY3JpcHRvciBmcm9tIHJpbmcgd2l0
aAo+PiAgICogSU9UTEIuCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oIGIv
aW5jbHVkZS9saW51eC92cmluZ2guaAo+PiBpbmRleCBjM2E4MTE3ZGFiZTguLmU5YjhhZjRlNmE1
ZSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92cmluZ2guaAo+PiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZyaW5naC5oCj4+IEBAIC0zMDYsNiArMzA2LDggQEAgaW50IHZyaW5naF9pbml0X2lv
dGxiX3ZhKHN0cnVjdCB2cmluZ2ggKnZyaCwgdTY0IGZlYXR1cmVzLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZyaW5nX2F2YWlsICphdmFpbCwKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2cmluZ191c2VkICp1c2VkKTsKPj4KPj4gK2ludCB2cmluZ2hfc2V0
X2Jhc2VfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4KTsKPj4gKwo+PiAgaW50IHZy
aW5naF9nZXRkZXNjX2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqcmlvdiwKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqd2lvdiwKPj4gLS0KPj4gMi4zOS4zCj4+Cj4gCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
