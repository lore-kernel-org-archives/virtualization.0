Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD018410A
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240973; cv=fail; b=eAFy1/JNhzrkbp+h9eh8pjvc/4dY5+fSkHIj+LgMIVNwi0fOCHKbUb8m8KpzqVC9zgo6wrJBeVCmTSI8OtB/3vmkexlSJAJnIH1c8zqJZiUHTyMmuWyixYy3D8buTN+h3NMa/g1wYiLKOz3hJPU3FbQyy6o3ALGEXOJeNaKalTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240973; c=relaxed/simple;
	bh=wo1LPZeab15MyJuF/RWmgTg+Ih2yZI4Kd9ltPKAGkpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=re1hpz3Gl7wT4ag6JPVpV9DF6iKu7I209c2GI4Wt55qxGwpj2klcyw92QPb5Eaaj8RwssAgrOvRU/2HSXB0fnrSZGVzWj5E6JsqKQpoPw8SLcJARK20V6Rd+nK2H0oEgqR+xm5OF2bxYxyHKrkl8ywJ3RKo2JWajdBUEepu4nfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlWMzgl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qVwPn/Wr; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlWMzgl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qVwPn/Wr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7BCC4043E
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YTsMM_q_m8fe for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Jul 2024 18:29:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CAB76409C7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAB76409C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=NlWMzgl+;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qVwPn/Wr
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAB76409C7
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:30 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HIAtjQ023767;
	Wed, 17 Jul 2024 18:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=hMhTxDL2w9ER5QSgBRfCi+S0UKzngRChTK7vtQfZoE8=; b=
	NlWMzgl+6sm3RdX2WjDrovS6Fb4fl89SS4YYWIAfZOMh6qroBL0pnrAV1N0ZcFsP
	pYTLSh8iN36k6hOI9GZhzT0JX57fusf/ZQG4e7HcM8qS5mDoSHp+d9va3QwVwQ+c
	3haIyTk8db+nG0H8cT+woGPHeo2mPdpEDQGKLDcZUPtWmz8/u8EgDgbrpyr/Rs+g
	D7+tt+u+n9dR6Z/arY14LQYJjHzeoLQoPXF8PEHJAarsRN7XPxmrCAA5tKjHnZBy
	isHPEUKTc+2acImooAXfRORaSTrYY1ItueBKdiQPFfdT/VCsLswbPEmMHGWxPwcG
	TKre1hDZjbQ6Yc6+Frsm5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ek0gg1jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:29:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIBtuK031678;
	Wed, 17 Jul 2024 18:29:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexqygt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKYH6nVMVJhnsJpR6hQJ3oHMPRdMt30XHahLl/bX34/fxK4yRe2zfmyTbKt61BOrSgxuzUGxy15JqnGAEGvc0cY0xLvKP2GK3Vajif6K9s3sefyQj+o6xX0AHL+GHbPCOBfh6AxCqSCgPaqm8hXdth6i8glQQ9Fh2nrYL0Wro8G8O/cC3Q2hN+Z94vpce6iRShJHUhtC4OIasEGnIfK/Cj1IxqjH/TbTYPPKQwXSy+DA701GkHJbztsxMG6UuYBclNLn8dbeSU08O/53PzDpRxZ/iZ8+0waie8CnqNBHHNofXm/qSCwlXDVFHYt6tXiH/yAQtONfhAeouhxM8Fnzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMhTxDL2w9ER5QSgBRfCi+S0UKzngRChTK7vtQfZoE8=;
 b=FRTFeT8miYQFUpdlPX0GGSrJat390gBQjJM8LUIUosPGjrBbNh7AsCbTe3u7TssmPvfzCcqdi9TJW6wby32BPeYv8jAecedma8YvH4TuQRgiqCfG8/CyBU+nwIp5W2lufDe274FDWNQNPyCPkhl4dWK24B5+sm7BcgQTpuIhEXoFduh9RTW3erBJYny1DzQaEkkfRU+EC6mZRbIZlU3iKAsv0miMDZ//Bx/Bls0wgX0v6vrRoz3lsvltORb/ZxTqG4omHxMkOmNzpnHaWEt+zh1lpAl77p5CenbRi55QyyGNW2NjcuFF5bBlqxELG7NRL8zNlet5iN7fLX3/pnAzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMhTxDL2w9ER5QSgBRfCi+S0UKzngRChTK7vtQfZoE8=;
 b=qVwPn/WrlNzbbinsj53K1bKQ71BnpQoDjSiqqADygxQzP8v2Nm+WYFj9UBuJ4Xb8gMx7yNQoxvcmisNEuH4H8DgTFuGzzGehT75X+BXEwZXUWQ0PyrdZGD/YQdG5eGjylKes/YpTJFwZqY/anX86Olr610GAKJsFxGYoV4ozGrU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Wed, 17 Jul
 2024 18:29:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 18:29:24 +0000
Message-ID: <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
Date: Wed, 17 Jul 2024 14:29:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
 <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
 <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d47e4d0-fccd-4e43-1c79-08dca68e6256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1pxYXViMEYwMnBWL3YzTE1JWTFrdWd4UkJ6NXFZT0E0azJYTmIxc2NxbmVG?=
 =?utf-8?B?MWx6Q1Y5cnVQU1V6czJvQVlKT0V0YTJDcWpCSWlLb1BzdVY4UzdIYzdFVjdE?=
 =?utf-8?B?VitnN29kWHZXc1d2SW9zVHhKam9ONGRGZDh0OWJRYUFlTzk2ejdCSnFFKzlr?=
 =?utf-8?B?NjRCZDRlRXN6MitsdGRPNSsydDE0N2VCQUpQdE5NR1FaYm5mbE9JdUtCVG5F?=
 =?utf-8?B?VUptWnhMbFJCK0haZTAxN3ZOemtMdGpuazlEaHhLZTdoZ2MxaVhnUEJpWVR4?=
 =?utf-8?B?ZVV1TEdham5CMkozRG5xWDRKbkxhOGdLUXVDSTh3SXZ2blR5bUxTRHZBRWw3?=
 =?utf-8?B?cExYZ3Yvbjk5TkpQMGxhbnFIY01aUEVGSnJLT0pkQnp1VSsydzVXQmsySDJh?=
 =?utf-8?B?UzNZWnlrTkJ3ZzVJOW9iVkNDVCtJZWh3cTZCSG85NkNvdFhOVERHa0dVcERS?=
 =?utf-8?B?K3pGbVgrUWlvRnA2RkdFMFhkeG5UVEVFRDA2WDkyd0duNGRUSldhQjlmWHZy?=
 =?utf-8?B?bEJuNmgvM1BqVnJaeWlQSHB0QjVlZFRUR2g4UktSNWZNcW5MSW40MmpyMmpi?=
 =?utf-8?B?ekFPVjA2ZVdQWWliYmIwMDNoeVVLQllRMDFVZk92SUUxdTBHQ0xuWjZFcGFw?=
 =?utf-8?B?QjI1cXFVK2JxRjAzWi9NT1pDUU10K1RMTThhaTFHeXZuamxFdVpyQityM2Ji?=
 =?utf-8?B?YjlYcWV2bS9zanBiRDBPNUlwcFI4V0xOSHhiYlFGM0hRdDZkdWhwUFVnSHpv?=
 =?utf-8?B?MDZkL2dFRW9iSVp3eVpFZkYvVXJSSzlaQjhxU1U0aHVTYjZQK3NnVFk2aWtG?=
 =?utf-8?B?dThmQzVLU3Bad3hsQVVrZEJhNDhieHpkNjVORDIvY0RWaFNpdlJWL3JXSjVN?=
 =?utf-8?B?WTVDanVWaUpEMllmRlZFTFlQSkVHVERIdUJIT1ZGRzk5eU5zU05UdnhRdDFW?=
 =?utf-8?B?Q3AzZHEzTEh4bVhWMGZTSHlkQUo2Uk1pTzU0MDlvZXBIeGIwOHVUTC82VCtW?=
 =?utf-8?B?WUtHYWRyaUorS1NRU2E0QjFDZ1FzTkZpanZwRFBHbjZJSHZaTmJpZkVvOWRu?=
 =?utf-8?B?NVZWZjRPUHJtNk81SDVTb0t3dmRFR1JJK1lnNkx4SDBXaUg4d1M5SEhGNTdO?=
 =?utf-8?B?M0pDUkZ1MDNRaGY5MUk0OTFCYk5yUWZPSVVUejBKaGdTWjdHYnhvaExHK3Rp?=
 =?utf-8?B?NWF4ZWMybVEvZ2UzSW9YV3ZQTjNWL3h0RVBJVVZYMWZGRTdpRXp4dlJvWWZz?=
 =?utf-8?B?QzIxdVFtVDZVamZBYWZaMTBPd0JrVWdYWVVuVW1WVzhRdUxKZjhFeEtiekFM?=
 =?utf-8?B?L1RVSmV0SW1kaWpWN1V1cS9wcFZ6WEUyTHVpT3p1YzhwOWdxcnVETWI5bXNu?=
 =?utf-8?B?T0tHVnIrOUMyK2NnQ0dJeStOUnBBd1pPWmdqb2V0S0NiRWd4Qlp5V3gxZ0Ji?=
 =?utf-8?B?bVNqdmFaY0dkNEtWZWF6ekxQVlBXQ0M2NFdSS2lyaEVrL3cyNUR1VXNzckRB?=
 =?utf-8?B?T1JId25UM2ZnTEV0QXJ2TWlnUDFQait2WVNydTdlWHdEYjZCTTMwL3lpTTB1?=
 =?utf-8?B?VDA1OVhxYml1ZDYwZ1lxQzdkNFZKMGJXT2xmZ3RyeVZCSTNFbHBmNlYyQzVy?=
 =?utf-8?B?UU9SRW1IMXlKTThRR3ArREJpMlYwZlpmV21jVzE0SVFuem9RcWI0OVNJMnFO?=
 =?utf-8?B?M29hS2dKVTNUeEpNOGUzd3dkMjU3TWZGajlRcEVqVXJUMklwc21BNi9sS1cz?=
 =?utf-8?B?QXg0S1QxSWZtcDZwY0o1L1JUT2xOMmdQL0ZtaXEwMkFBUEpoVDhpUm8zY28y?=
 =?utf-8?B?YldGa0MxT0pwLzQ3Z2J5dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anBaaFc2ZTU4b3R1NmZubzFRcXl4TTdQS01TV1JLTjh2UlM5ZXgzaklXQVZu?=
 =?utf-8?B?cUk0NW41Z2FnbnJjV3RTS3NDUks3VkhKbmhYRm9Tak01RWRXb0l0U0hCNFF4?=
 =?utf-8?B?MmorcnJyN2c3a0RvZ0dOK1JSaU96Q0xFUmw3Q0JNb3V1NDl6YVZhRGtEVXNG?=
 =?utf-8?B?RTBPU3ExaDdpeDVhZU9BdW1jR0kwSXVraW5wRUxnY1Z5clE1NWU2RlJ0UFc5?=
 =?utf-8?B?bGdpTzZlNStPamNvWXdmY21uNko2VVkvZXZ5RUV2N255OGhVNXNTc0M1b0M3?=
 =?utf-8?B?S0EyOVJTWHFMYm9XbnNwTDZvQlk3aFFYSTYzVktpcjNOOEd0UnppZjlKaWpN?=
 =?utf-8?B?ZFplMWZTTXp2MEJZcFRKNGVPN3dmV1o3emxkcm1pS2p0WDNma202QTc4RnFq?=
 =?utf-8?B?NlY5M1I0aHl2ekFvendxM1ltUUl3RUJreXRNeWZaVEtBMWxscjVNOUxqaVdE?=
 =?utf-8?B?YVFDM2thdERLK2dPNWYyd2lvT0p1ZEQ3NFlycTBnRVZiMnRZemNvL3dNM0Jh?=
 =?utf-8?B?cUM2T3lkYkR2TmlyVFZJNEs0WWx3MU1rWnRTVmV0NWM1YUpXTmRHVG1Pc1Qr?=
 =?utf-8?B?WDJIbUxhNWk3NGFLVVY4MWZtbnNIalpHbDJYNzFVbDNXT3crMXVCTjFRZTFS?=
 =?utf-8?B?dFRha09HYmtpaGQxdDNwU1ZyMXA2cldGRkMyZkswZHhjU0tkTnU2V01ZNWhJ?=
 =?utf-8?B?Z2xvclZKbWpPQ3NKMUhNQXdhb2FHZE1sVDBpMmlOY3FRQ2ZyMXd2MFA3RnNQ?=
 =?utf-8?B?Zk5nMTZBTTdCUk9VUnhzaHdob3BqUmRmMXF6TVFVNjhBUmtwM3FhVE5HMVc5?=
 =?utf-8?B?TTdPWng3cUtnQjQwV1VaNHNlbzVtL08rdmNUVWJRWTBNSkpYSHV1MEdxa1NR?=
 =?utf-8?B?Nkg5NWNOMWdjamgydFFLMVcvbUNPTldPMVpJSEtUd2lWSEhLV05IcVVLaVlH?=
 =?utf-8?B?dTcwK05QZ2tPRWtCOHNoTkYzT3Y4Y0ppYUJ5Znhra242c2w3M1NDTGtRME5M?=
 =?utf-8?B?MDVOYjFFaGFNSnN1NS9OQVVHVTdwamhXNWlVeDlPR2t6NmMvOUJ3VTRJaU1n?=
 =?utf-8?B?Z2hPSUdnQ3Njd3RjSXZZSW95dkVTRVdtaGhyV1haQlNGMitYNE5NT0ROMGpQ?=
 =?utf-8?B?enc3a3lTNER5cDcyU1BSN1lWRE9BVVA1NFhZNTRSMHBPaUJHNmY0VmFxWFEz?=
 =?utf-8?B?OERSWUMwbkRmVXFuNHZtMUpUYnBTaUFPWVkvWkpsWTJlYVRrUmJJczJuQWsw?=
 =?utf-8?B?dWtmNVg0ZU8xa21FQm1wVGRzMDV4SkJlSFczYXR4QzIzR0I2enNlYWJwUW9k?=
 =?utf-8?B?eWxNRjhDTmp5eEp3ajRLMEZtQnJsZ2d0Vk5BUThrV2F1TlJuZkUvcmk3eVhs?=
 =?utf-8?B?N0hYMHN3ZnRiS0ZQRnNqM2k4U3UwWUU3MWdUZktvR3R2M2d6a2Y3U041SFQ5?=
 =?utf-8?B?NEFuZ0xwZC9ZeGxWZVNTUE1yV1gwRHZiYnE0eDZFT1JzYnYxRTJaUk9MdVll?=
 =?utf-8?B?T0E5TXRENzdkdi90SmZsZTJaSElmK3B5cnBKLzZyWGdHcWZlNDlHczJqVCtZ?=
 =?utf-8?B?aTJhV1ZHQmE3Um9jZ0hwaWtPUFI2bHF5aFRhUGZ5cXhqczRycEExd3lkWmZ2?=
 =?utf-8?B?dnRDREJncGlJdUs3dVBsY0NuUFY2bWkzeEpRb3FDdjdyUFhCWFQ3bnVraS9w?=
 =?utf-8?B?UTI4eU5qbEoxVG91WExQS2FmVEpiemQxdVlmc2dZby83b2lhOXBDRjN5WDR0?=
 =?utf-8?B?cUU5T2tzd2JRaWQ0YytaMlMyZU92RDRZdkh2NHVSdXV5OUY1OUEzTVVsemgx?=
 =?utf-8?B?TjVVTHdrd1hQUGRPZktSMktuWk1IeFlBNkFoL0lKSnJYNVFTdHFiN3BvaHRw?=
 =?utf-8?B?NmVuNUtQa0ovRGVCNWFVT3RUTzY1dklnK3VZOFlCMFhPa0xwQ3UvcEF1S0Nh?=
 =?utf-8?B?Qjk4RkxkdUc2S2o5OGFJcFFHcXRLbVRvVXFWYWhPQlZZR3p1eEtjN1pxUE5Z?=
 =?utf-8?B?RlhxeUFpM1Vzb3hTcXRjUlZsZWkvbnBwbkx3TDNKeGo1TTRVNlB0QlY1NG9U?=
 =?utf-8?B?Sy9aRU9MVWRzTVNRaTNzVVB6NzFmWEVNZ1pkZ3F0eFBJS0lNaFU5N1ExbmpU?=
 =?utf-8?B?MUhZT3dUM3JWUUZFTmR1TURkYWVtb1hGdDM2QlJpV2RlOXZkbGgzRW1XVmxN?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9J6YWtLQMsMC3kG+EY4AY2y8ERfkfx7pM5L79rBqKmzu2yXudhPO4juAnx8mkNU7shAiFd+pmNIQYPvUz+OkklnCEUDzpWayPnt6IxJfrbR3OTVxTZqPtM7pJq88+qYhOefgOZB46yYTHz1od2epwLdkG0njgdO6Q+aFeLDOaQo5JSDUXroeAIyr6eR9lUT84DqaknfhVgMfU9+NZ/9MSPic/+hNnlnTWURUAGIwu3xTyJBQS6PfAY28So+McnsKPVPZgLwXof6fkQqW5PdKujDSYGOIxI3RQSAaow6GhE0Kl0CyxZmhgt1FSEQxa+Ehs2QZRNDBhXLqhAFz8uuQsdiN076l322p9AUIWmAiv2eLp2WkZ5qr2geEOWNcEySoAbQXV+4GMn2XRkfusbHn4z6CwoLwOspsD5cFYvsbpT4iBsnAamwa06DQRNXQ81MNz1XODTF2SBGFqvRuoRbBBDv0SQ75kwPkQhbIqxsY/FTt+wrKseENSO6te9zPXlfwhv14tRrA5GYM5+Kq4g5350v4grDAzJRF9gAv0FWtUcGaVAuegXFP0+16lJjbSu/5FOIBo7reVsWF5HSBB5bqn1fPqOShw2V1g/bW0efwmcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d47e4d0-fccd-4e43-1c79-08dca68e6256
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:29:24.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV6EuRjpBjz1OVvg7P/0qFTr93fVrYC7Ei5E/9+aV155R9p/MkOJIQdtbzgAB9lkCrc6vgEKPi2hutSo5KajPXVe6NADo1K6tr1pSPQF5DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170140
X-Proofpoint-GUID: -hD_lY0kpq2LwG_Jf4S2lNulOv8pSMjk
X-Proofpoint-ORIG-GUID: -hD_lY0kpq2LwG_Jf4S2lNulOv8pSMjk

On 7/16/2024 1:30 AM, Jason Wang wrote:
> On Mon, Jul 15, 2024 at 10:29 PM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 7/14/2024 10:14 PM, Jason Wang wrote:
>>> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> Live update is a technique wherein an application saves its state, exec's
>>>> to an updated version of itself, and restores its state.  Clients of the
>>>> application experience a brief suspension of service, on the order of
>>>> 100's of milliseconds, but are otherwise unaffected.
>>>>
>>>> Define and implement interfaces that allow vdpa devices to be preserved
>>>> across fork or exec, to support live update for applications such as QEMU.
>>>> The device must be suspended during the update, but its DMA mappings are
>>>> preserved, so the suspension is brief.
>>>>
>>>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
>>>> accounting from one process to another.
>>>>
>>>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
>>>> VHOST_NEW_OWNER is supported.
>>>>
>>>> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userland
>>>> address in the new process.
>>>>
>>>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
>>>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
>>>> require it, because the userland address of each DMA mapping is discarded
>>>> after being translated to a physical address.
>>>>
>>>> Here is a pseudo-code sequence for performing live update, based on
>>>> suspend + reset because resume is not yet widely available.  The vdpa device
>>>> descriptor, fd, remains open across the exec.
>>>>
>>>>     ioctl(fd, VHOST_VDPA_SUSPEND)
>>>>     ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>>>
>>> I don't understand why we need a reset after suspend, it looks to me
>>> the previous suspend became meaningless.
>>
>> The suspend guarantees completion of in-progress DMA.  At least, that is
>> my interpretation of why that is done for live migration in QEMU, which
>> also does suspend + reset + re-create.  I am following the live migration
>> model.
> 
> Yes, but any reason we need a reset after the suspension?

Probably not.  I found it cleanest to call reset and let new qemu configure the
device as it always does during startup, rather than altering those code paths
to skip the kernel calls. So, consider this to be just one of several possible
userland algorithms.

- Steve

>>>>     exec
>>>>
>>>>     ioctl(fd, VHOST_NEW_OWNER)
>>>>
>>>>     issue ioctls to re-create vrings
>>>>
>>>>     if VHOST_BACKEND_F_IOTLB_REMAP
>>>
>>> So the idea is for a device that is using a virtual address, it
>>> doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
>>
>> Actually the reverse: if the device translates virtual to physical when
>> the mappings are created, and discards the virtual, then VHOST_IOTLB_REMAP
>> is not needed.
> 
> Ok.
> 
>>
>>>>         foreach dma mapping
>>>>             write(fd, {VHOST_IOTLB_REMAP, new_addr})
>>>>
>>>>     ioctl(fd, VHOST_VDPA_SET_STATUS,
>>>>               ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
>>>
>>>   From API level, this seems to be asymmetric as we have suspending but
>>> not resuming?
>>
>> Again, I am just following the path taken by live migration.
>> I will be happy to use resume when the devices and QEMU support it.
>> The decision to use reset vs resume should not affect the definition
>> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
>>
>> - Steve
> 
> Thanks
> 
