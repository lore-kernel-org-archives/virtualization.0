Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259941B86D2
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333968; cv=fail; b=goH8ZYLs2r3ZFxqpFc8NUaBI8Wz/KUaeBP1TiRiQ4ICRU1GX0yzd7cxL3ROgcrQnR+SvsbPBfyn6Jh/u5YWspTIx4ZDv+5cyqd4gFbzxCpgUesgYF8Ke2FZ9m7BXiQWsUZv43MaCjqxtlfT4On0A+Tk3mNTVThwi/w9T5/0uGxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333968; c=relaxed/simple;
	bh=+9rHMLkgtZHwPLTMeC/0BguR4ks/qjDK0+9eb8tXAqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jejAY+T6wLFZf06X35F6eEzVaTrRNFbU7OFJbk1jxeB/T0OTH2tCIUDRehy0HuPDo13bqhXHT46Wr57DFbsFoZ+ELvmalYIkuA5DbYxGnm9loo7fpYjX9n8TO/eR/rtGM1BlEgeI9ECcWDkxchAbHKejTm8tQsjetF99wIW/2bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmC4zAYj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cP5NxpmM; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmC4zAYj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cP5NxpmM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBEDA403B9
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 20:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Za7XOpK_z8On for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 20:19:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A489B4014D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A489B4014D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=XmC4zAYj;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=cP5NxpmM
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A489B4014D
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 20:19:24 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IK5g6X031410;
	Thu, 18 Jul 2024 20:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=JiAPkCc+BHYLqIKxWbUZyYV6W94zCrXr5l0p17s3YT0=; b=
	XmC4zAYjYYlTgj86CJxWt68emJNLJlYpHqggSZqiPfeZUUy0faUnlRrjNL+9z+Us
	3ZQaeuKDbyjKI80DJ85kZo/usoajRtrO6yrahprHn5HSlFzwIdD8+NAZ2whPoB1v
	NYLLl/pCEmPbk8/uHw6bgV8aWsg8uGEiIiLOT+noKcvTeRbTMqp4F2nM/MpRfg+y
	1A+nCjN39+x5F2XnqgoHtDXgd8meyxu4AHIkitJ5P3cKTjGrsrNb2nsFsnuzZAA3
	Dfy47KZnGwr0jcEPlctwkQ/ZFDXwXV6r7fUFOWKsOPPSAf0a5lv3OuPss1PADTC4
	8U+OvmswrBS6RmMAupJqjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f9sbr1uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 20:19:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46IJdcGm021805;
	Thu, 18 Jul 2024 20:19:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwev3ncj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 20:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD0JOxbGm1wuZyRdjWW8IXvQ5Ig+U7YcebmG62xUREdDYb22+YzUyf29kWmpDdQrHf4byWSEhd7Bx42Erar2Z5ydb+s5f5emDVSsav4XGHrzsiJp6REpXMAabAvtJNgAckYVeZyZwPFzG09M0bo35rnO715lNzumy3XhHEkQwpb4XDHAGMZEn7X2AFp4zuWZtG52LHqjLsWbWzJw852/Z8ROnKEjLXupjR5HeWYh+fUJJBnz7SWEmRNl0KPm7ACTAbb+gBYVp+ERCmOliFDZ1fyzvWqxFpvK2RABkAF3zdvIwQwbEDlfGZf++seHkw/DCDzmIL8SkXpSVmwwmarTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiAPkCc+BHYLqIKxWbUZyYV6W94zCrXr5l0p17s3YT0=;
 b=NVgEy8ljWZpaHMjO2DdeLHRE80xUDC/3KMBSYfWuyIQ2ziPxZ2zobEjKr+skiJdIuzzZ+rxVvO4h8PzEQzDYUvqdDeHtv8J/hSiuxx76XyM1NjF0Ew4j6EZTdhM7+r3PZUUFvigxs+g/+fkuFl/CLEG+VoPyloI4grofbNrrjk7/Ghg7Khiqu0DhP3sNLOy9Ehz7WW8wEVM1+R/at+wqKJT8zUEzmZo8HLS4pGyUZNo8ZnKrF/IAVVoYehJfynKrS0aQG6iEo5yeMb15oUC07nRfVXrT8cZTfJtodVnuYYfNxAMJB41+3vwy/B10ZHVfpmsjPH8T0ktsJ0KlANlhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiAPkCc+BHYLqIKxWbUZyYV6W94zCrXr5l0p17s3YT0=;
 b=cP5NxpmMIkUO16aJgMqjDlwdnbRISXAoHMiyAoHtHGQ4xptG5E7wS8EtU4XJQ7eOyKsHuUEZkXBogZA16HrjxaV4MSWiBkPyMkqwDwGcrcK4uN00WOmhd7XI1gWIL/B23rBF3/mFrlk/WkRhonZ6/t82haltGK8xgyyPDcsbZqU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 20:19:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 20:19:17 +0000
Message-ID: <53630267-d22f-45ab-8919-3103739e360c@oracle.com>
Date: Thu, 18 Jul 2024 16:19:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
 <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
 <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
 <20240718153724-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240718153724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: a07fa515-2409-4687-4540-08dca766e68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?akJKYTNrZ0cyWGRnc2hxM2JKc3oxVmFhYW9yZmZqVGFDVkhBTVhEMWtYVEVL?=
 =?utf-8?B?ZmRteDhWSFRqOW1IMW9Lak1CM0h4SStHMFJRSUcxNmpoOTNwcmpyb1VBejBj?=
 =?utf-8?B?c3RqclBQV2ZPWWpGM3pIbXFpSCtjc1RNM0Y5R3FwL1JKakgwcHduUm90cXd1?=
 =?utf-8?B?d3JiQ0FXQ21xaU85Y3lwTzBoTGFZQklvdlpkQ1pBYStnRTF5eFliUEJBQS9s?=
 =?utf-8?B?ZWRqOUwrQVhqclZRS0R5dHhBbkNDenl1MGxEOERTVHZqTFdSSUZtaFRtdlQ0?=
 =?utf-8?B?TXh0VHFqNjU5c05nQ0dPNWVLUUMySGZWVUJ3UHN5OUVCMVpXcVhCa2RRSExS?=
 =?utf-8?B?S21WSVlFQXdaWU9KeS9yd21INDMrYWZ3S2FuY21iVzUvdmRnVDZRajJYa2py?=
 =?utf-8?B?bTdEaVNlQ1lreWFYY3N4UGdaYVBxOXV0dG9CQ3FrZGlKY1pjRGJsOFZkNUJP?=
 =?utf-8?B?REEzY2k0ZDVVRWtXYjBMc2VPTHVCWGs3UnRPWUwvanJUandkOFZJS05xeTZU?=
 =?utf-8?B?Y1EzYkJuR0hNNTBzUTNyZWd4elR2SCtMZFlObE5oSm9JK2l4dnlNRlJxeFpx?=
 =?utf-8?B?UEwvRzUrOTdoNWh5T0hkM01nK1AzRnFVaS9CSG9GeitNY0s3eGs2dVlXcHdU?=
 =?utf-8?B?VmEzQm0vMUUxdjBpWFFyNktzZStvdWhZaGVGc2JORktIRWhpdFhEYXlrSFJo?=
 =?utf-8?B?bk83L0FKbjJzQUFPQVdoSWVGUjFGeU5YT0xTc2kzSWNDTjIwc0VSNGRWNHBz?=
 =?utf-8?B?d0VTb1dGVkxGK2dMSWt0bzRlWFdaL0ZJcG9FWDJ5dGxieWRVU3ZlYUN5MS9C?=
 =?utf-8?B?d2dmNDZYVmFOR3gvYllJTGRud3FUSlhDUFBRMS8zNHJ2Ui91NFBZdzRlUnVu?=
 =?utf-8?B?blljVzUwL24yVXM4SEJNK1R4YWxZdnJaMzJjdGZGdW4rem1nb2p6RG56NmMx?=
 =?utf-8?B?eUo5a1B3SkE1aVZkQk1JV3lFNlVwN2JLSHR6N1JITlBlbldwS3JHcHIwN3Zm?=
 =?utf-8?B?bjRnR2FxM2o1SVFrcEJmK0lVdjFjY2ZvQ3VSMkxRNGF0VkxuaG9XbExwaUFB?=
 =?utf-8?B?N0FlYXZ0bHkvLy8wclQ5STVjMHJMMzVBWkVVZXRLbWN6STBEcEI5RDlscFQ3?=
 =?utf-8?B?dkNpdkVMQm8ycTlqekRuM1Jpd0pleXUzQ1VFK015dmt2YnFxNW43NXdlN2J4?=
 =?utf-8?B?dUNDaTU4VjFvcm9aa0ZucC91MlVzTVp5S0J3bkVrVjI0K09vV2JzSkdsdkFq?=
 =?utf-8?B?KzNRaW1vVW9YeEcxQm16QmNQckFYckQrNGE3OEFralRnWHVETFRHMENCS09j?=
 =?utf-8?B?cXJJWWg2WDQrb2tPWGhYV0k5bVdBaThXQkVMbngwNklDbU5PODJEYTIwRmhi?=
 =?utf-8?B?RkJKdEY1d0VsbWNTQVpXdnhmVkp2aWxHbmtuQ3lYeG5KM2dSeTJoMHVrQVZH?=
 =?utf-8?B?ajRybERWcmlsTlZIWDFSR0VhWHdtUGJVdCtyYnVsOTB4cW9MUTNSZ2FLdmlk?=
 =?utf-8?B?RElHMlFQTlZzeWJoS3VubWFWMnVGZkJYS0xUVWRKTm1hRzRIVkhPVFNBNC9n?=
 =?utf-8?B?NmRMU0pBV0xmTnJxV3hwUndtQTcwcXZhNURDY3Z3ZHJ4QndSYjJLSEp1ZGto?=
 =?utf-8?B?WDhaYUtHYjlPWG02cWFkeDRDT1d3VDBhcW51RGMrY3BpSG1SWk8ya0s4YnJr?=
 =?utf-8?B?UzBsWWR2SDh2aHhsOEJOaGxLZ3F3cHljaTN0TThnOFFmWXZiNklMTXdOVTZH?=
 =?utf-8?B?YUx1QkU5UXFxZjZXdC8wTVEzTm5ZZThUOGFkTmpLT2swVnE0T0RuYmVYcTk1?=
 =?utf-8?B?WFlUN3MzWi9FeUc2dDFoQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T29aMVA5VFhjaHdnNW91WmhlWFF3MDA0T0tWeTNPaTNlcUpyd0tFaGxqUWU5?=
 =?utf-8?B?eHFFUnIrR2E1dUZyTVZvSHBvVTBQSkpya0RNNFVodko5L2p4Vmw1V1NTeElW?=
 =?utf-8?B?VkdPNnM5d0JJVGJSbVJCS3ZzRm9DQU5NdjZ2WEZtV2pVQm4vZEJqckovYVdr?=
 =?utf-8?B?eHFKMmoyMXVDVEpZY3Jqd2wzTHpJM0ROVFh5WElZcVB0T1JzUEh0NzdlNlp5?=
 =?utf-8?B?K2pPZXZMSE90aFRGNld0RWFCMy9SaWpqME9GTlhocWJXQWFWUDF5YmxDbW02?=
 =?utf-8?B?elBsMjJwSUNRYlVKc0taRTlXdENqTkpBRkJEcDFSRXJjdzZ4ZXRGc1FEUjJS?=
 =?utf-8?B?anNqdkZyc2xRZTIrK0dDY3Q3NVR5RzNUMGRDMWJ3Qi80RzFua0tUOTM5TGVv?=
 =?utf-8?B?VHR5dDdKTmRJdE40QnJZNHFqY3lJSmNNUW5mb1dHcGg4OXBPaVphdDIyRFVV?=
 =?utf-8?B?TnhjNEo5azdzU2wxNkJGSXhmSFFxODBOYkh2eWR2K3RZT3JSaXhybUtIazBK?=
 =?utf-8?B?MnZOaDdlS1pyOWVDd2JEY245ZTBua2dqbWlCcWlJMlBPQXZaYWRxVEM3aWpK?=
 =?utf-8?B?TlFPeTFjSFpRc2VJSE1tMGpZellDOXdDL3FDell3VURESjB1OXY2ZlU1VzR1?=
 =?utf-8?B?N1hUWlJTOXJwdExITU5FSmw2bEpSWm1lK0tGU3BiT01COEUvT2MzRURZVXdJ?=
 =?utf-8?B?cERMcVV0cFpiMHFkdGgxWnh4RGJ0MHhZL2RqME9kM3hHSmVwNDY4ZUlaWE1Y?=
 =?utf-8?B?U004clo3SlY1TE9MSUdPdXRNOW1QYnJiTDB0QTVQaHR0dEFoS3N6SGNabkFW?=
 =?utf-8?B?VU5pL2ZXR0dVMENCeHdWdXlBL25oWGFRdzA2S1BJdmc0QTFRa2E4eFFJOURQ?=
 =?utf-8?B?MTZQNFh6VzVBcVdFQ1hvZDZ4OTRWOUZOWUlYVlNZL2YrMjU3M09PbDlmSk5V?=
 =?utf-8?B?dlYrYlBoVXhpd3Y3MTczMmR6ODlWbzBjVHI5b25zL2g1enNoajhPYTV6Qjgr?=
 =?utf-8?B?ZVE3ZjVyNlBkb3BXYkJtRjlDT2Y5M3AwMkxEcWNDMkRXM2tmOWQ1Zkh5Zm5j?=
 =?utf-8?B?V1BTOGp2WTllTndLZnZrWHV2VlJ1RGZXc2JXQ1FrTm1MSUg0eE00ZjNrM29m?=
 =?utf-8?B?RlR5aE85clBvRjRxSWlTcXFqa2I3ZUtYMXNxWWJDMmxhYzFGQ253ZXNLWnNx?=
 =?utf-8?B?UkQ1R3A3Vmg5NUZMV3ZzOGt3TkNyUVhaZnFOcVdFQ21kUnNkUXlseTh3enpY?=
 =?utf-8?B?TE9kcEsvc01HdURIOGFqOFpsd3Z0MHVoUTkxcDF0Y2xWSFRYajYwcUhibU16?=
 =?utf-8?B?eWE1OVZEZ2I3K3ExUTRzelRUbjFtOVhERU5TS1dQZktIcWxNRXY0TkY5WVRi?=
 =?utf-8?B?NktzK3QyanhabkJtdzVIbjcxWnVpN05oSFNDejg4RlQ0aTdmRzRiS0dQcm45?=
 =?utf-8?B?eTYrNFgrcUlaeW1CenZxQ1J2MlVkcG8zcG9WWGRLM0w0aTNtQ3lsNlNsZFJl?=
 =?utf-8?B?eTRjemoxLy9GZWRKRDE1ZTlWVVpBK3RpNExqekp4emJ1NkRtUm50N1lmRFdt?=
 =?utf-8?B?R3BoY1IrYWx1VjBZNWZHdTVxRzhmR2VWb2ljU2JiYndNZklQb080RzFnUG5D?=
 =?utf-8?B?SldXODh3YnJUWVQ1bGdqNU5lM3BMRXBRUUk2bTJmVC9KVDU4eWZhL2JxeGxy?=
 =?utf-8?B?UHR0T0thR1ZYR1dFenlncHo4ZkJBaCsyTi82WVJDNFpNNFVnNnljYUZieC9m?=
 =?utf-8?B?N3ZYT3p3TVhiL2hrQnlpWjBhYS9oTVozZy9qTlpaS1NycHBiTVZ3cEJxdGcr?=
 =?utf-8?B?UURyRERMSjlLcEtWZmUwMDhuQzNMMHpXOFRwQnBwemFGZyswendFSzJWcG1V?=
 =?utf-8?B?OVR6RWlUTDFVbkxaZGdLczRsUnFSeXk5aTFCTlJOdmxpOHlkWU5tZmFVeVJT?=
 =?utf-8?B?K2pBUVkvVFhlN2pLK0dOVy9CSnhCclVmUWtTb0tlUDNVc0srK2RETEgwVmdj?=
 =?utf-8?B?SCtFUzJNOGlROCtnYktNSlRMSlJOMTNjaWkrbUVFYzlSOWlpYVRwM1ZVUW5t?=
 =?utf-8?B?V2tVTUlsbXdPTDFVLzU2VCsxMVZQa04vS1VMa3FlMGNTV0YyNER4S3FzM0dk?=
 =?utf-8?B?RDZLbFNhOGtMVGdpS2dNNFh6cCs0RnRjYUNuci9sREl2OTY5akM1RXF6WVdK?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vx1iJsv4n+UKgvpJEVFfrpZ3Ly9sIBSuc107HVdh6OMC0T193S950uLNgH818DkPxR9mqnzn/wwu0YnqHeYxa2CZJYlHLIN8YQeUb1m2L5Mj2hwZefnKsQezD7qXNm42SUkLsBag3PxPGh1VMezW/8U381zSgI3d4HWoH+pKqtQCcJUExTKj+y3aX8Nj6Xz7iqnwgnklTlu1A44royyhh1hBmfl74X049cDyiResWUh1lx0o9TwRz8AnqpTYN8CYRvaEtcSZdM8rdmORXeYg5xiBiUzgJlQ83mHicZZf6F7QezMLzMvciP+SWL0itiAyTyrfLD0FzzavzKnvmeOptPQw8zUj/Lgbxbz+lVpbm50E1kQAjTCO4TXhjfiI9D6ljXWCj5VsG8wFcQhQIRaI/zp/ckLhaiNQ3qnVZND8W1hK8mFpvZlvI3uToxCdYVzFMAQnDEbbfjnx9W2mtL3o7IfPypF3Dp5EDegXqDLSb/BxM+rLMYfXsu3w8k1iAIVOk0RPTD7YujmghNMH8cKmqn7fK1VohSVAk/mUq37HiLllce5Y3OP2sz7CEkZ99ZJR13hGgcJxUEK+S/FJhIGxRYJVBzVUwDa+vu6+32D49Mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07fa515-2409-4687-4540-08dca766e68b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:19:17.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTiu+TkAD+zEVXqzKhtuPYN7Jkv1awRuqpuhJkG+YfJQXCk0hYOSGHHiGQH4Mum4IYveLJIhxCiFB1iIra9yFXGp6P9XqrZZHffPR6d2t/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_14,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180136
X-Proofpoint-GUID: 6M8_SnTrMdpQRu7EnGXuMz_edyDcEw9g
X-Proofpoint-ORIG-GUID: 6M8_SnTrMdpQRu7EnGXuMz_edyDcEw9g

On 7/18/2024 3:39 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 18, 2024 at 08:45:31AM +0800, Jason Wang wrote:
>>>> For example:
>>>>
>>>> 1) old owner pass fd to new owner which is another process
>>>> 2) the new owner do VHOST_NEW_OWNER
>>>> 3) new owner doesn't do remap correctly
>>>>
>>>> There's no way for the old owner to remove/unpin the mappings as we
>>>> have the owner check in IOTLB_UPDATE. Looks like a potential way for
>>>> DOS.
>>>
>>> This is a bug in the second cooperating process, not a DOS.  The application
>>> must fix it.  Sometimes you cannot recover from an application bug at run time.
>>>
>>> BTW, at one time vfio enforced the concept of an owner, but Alex deleted it.
>>> It adds no value, because possession of the fd is the key.
>>>     ffed0518d871 ("vfio: remove useless judgement")
>>
>> This seems to be a great relaxation of the ownership check. I would
>> like to hear from Michael first.
>>
>> Thanks
> 
> It could be that the ownership model is too restrictive.
> But again, this is changing a security assumption.
> Looks like yes another reason to tie this to the switch to iommufd.

iommufd, like vfio, does not impose an ownership requirement.  If vdpa has a
stricter requirement, such as allowing the vhost-net sharing that Jason
described, then we need to surface that now, and extend it to allow change
of ownership for live update.

Is the vhost-net scenario currently used, or aspirational?
Copying from Jason's email:
   1) Two processes (A and B) share a part of the memory
   2) A is the owner of the vhost-net who is in charge of building memory
   mappings via IOTLB
   3) A passes vhost-net fd to process B

- Steve

