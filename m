Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E761DF747
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169493; cv=fail; b=BPCwf8AOrd4C3Wq2uz0NbOH/bmJDjQowVQiBJ2bNMhT1NJiHrfQUesI64ClEVYGU8fpoZ2sXlOqr7aXfTjAQZNtBghXezCNXt2WTeFceTPXOd0cyzBvrJ4SwcDvyJd7Cg1Sy5MI3lmDVGsaI9BIIt2cyFSGIs2RNMk4NiW1NBF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169493; c=relaxed/simple;
	bh=MHNOCR5qWu5HC44xbTNjCN4ctLHPlBcHOWLmect6+aM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4uvnpOsFY6f79WcJjIAiHeHg61T1loYxqJsRBxhC7ZRTrhRqZ2KaQ2g9z3pbVtIOrdxd+VGvoRsRYi/rZhDGYV8S049F9E+/fVGI9D6sq8+rXlbIMr2ozxjDpPf2csUGmRrHI4DyOq/BWZD+rliA7ZGILrgrrk4D5dFEzHPcHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZuP0JNWO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PYsGPJhj; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZuP0JNWO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PYsGPJhj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE66A408A9
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OMi33mBQH_2P for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jan 2025 16:51:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8E9ED406DB
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E9ED406DB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ZuP0JNWO;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PYsGPJhj
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E9ED406DB
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 16:51:29 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFsGcV003542;
	Wed, 29 Jan 2025 16:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WrDayBjwHn4KoqYVfGoSGdXXMofr3Tc5nlmOAin8ofM=; b=
	ZuP0JNWO1TRMZ2eZB4qGTyDwpRa9muUjyrVi+btj4DXExA/PZ7aPybkN6YYHX0ya
	35myj0xyQum2wchcH0J4Eh16qgTzuNJMJvCJlAF/sM9DeLUeOXdM10DDfeUki3Qr
	vjmH26dxvmb7Aftgpc1t3zduVCjSuI25WLhjEJrR6eCM4cBN7W+nthBL7lxJeVyf
	+SdmvXSy9Ubf0wlQ6TZeQz8b6jr3Pih3srZ1srZDcnfr/Sr53lACjL7MTCrKX0uu
	U5XTdW7r8tKe1chCoJI+JKNM6lnAxQZKyQ/NVWARXIjXmbm7GKIY7wzZjKgWT5pq
	btUeW5ppLVzR14gan8OH5g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fqcp84mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:51:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFdnDS036333;
	Wed, 29 Jan 2025 16:51:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9xch4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA+Q+rbA9OsTfesON0WK/3ESd1cvvaxaXv/zj/65PP/I91B1ibSoiztllIMoEwipAu0k6n8Wvz3zhjDHGEFQ4slCjcGdJCwqrA1beMLSF7rNgwSjYiqlupsqsktZnWFGJTjKja7JPs1qJtXBMex9TgfAuBcp1Sw/SbJ0HVjIRMVWD7i/XtgAvEmsRCdJzvknTD3cjTs8DoxnfC4SzPLK3/nc9ISIW5FjKmmJQGKt8YyOgpQTtEcJYZINr18SMquozwrYVBahxK34SMBw0JvwOh0yjnPKQ24DnfzWKFm7Sre5YIZNRGrWAH7EslZWuzRI9QQBYQhjNICa0/rD/pV2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrDayBjwHn4KoqYVfGoSGdXXMofr3Tc5nlmOAin8ofM=;
 b=wMhe54dNIttlA3Nw3KrDFgcJutcm4Insj0htZ3S8YnhPBPCOAZzNFJtIG9fmxsBfAoPPeUTeQRCj5ocbsqoFf03S0HLLa3w3RK/oHAp7upajzUzyuuhr9vpxtn++ii4GB82pehyYvmz1VwwxjEouLOihmWw7NrJkRquWHKQ0e6ROLqgeLd0CobYyJ5PvY1pPh2tvyVmA+oTwjXw7D62MzSVSPGThwbQgARR6KXNOucGtHEmfyJbZJSRbJvnn8QbFSdV8Lzn/x/dZpXZ0nZ9mOVZSHSI2co0XKVFSkHLvO4rKcECBd9vvvOemoYWh+Ylfnp6w4pcLWYXEJWwBFSUgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrDayBjwHn4KoqYVfGoSGdXXMofr3Tc5nlmOAin8ofM=;
 b=PYsGPJhjMuCcI2W7u3Hi+JcfAm62gsIb40gfjnrVdja8dX1FdouLlIYcklykpxdpGGhwGoB4xGTxy/VO6veYTNFMRVB/aTOCOKKKiHPEktBCuw3C4v37l/vlGWQ6mIOSTDGa09mF4lD0MYDtk0Whk2plzVPV5Kck8DroiYnpJdQ=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by BY5PR10MB4387.namprd10.prod.outlook.com (2603:10b6:a03:211::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 16:51:24 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64%4]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:51:24 +0000
Message-ID: <466f4e29-5af3-4a51-9283-0f5c2ccb702c@oracle.com>
Date: Wed, 29 Jan 2025 10:51:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] vhost-scsi: Fix handling of multiple calls to
 vhost_scsi_set_endpoint
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        pbonzini@redhat.com, wh1sper@zju.edu.cn,
        virtualization@lists.linux-foundation.org
References: <20250121213125.140333-1-michael.christie@oracle.com>
 <bte2rkiy7tvefzanh6hsym3xawuyjznpcoevxcdifw7jqqep5r@vdanwnpihn27>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <bte2rkiy7tvefzanh6hsym3xawuyjznpcoevxcdifw7jqqep5r@vdanwnpihn27>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:610:e7::25) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|BY5PR10MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b55a45-adf6-4895-388b-08dd40852a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTd3NWU0eEVBZmgrdTNNaGpmczJhYno3KzFjMEcvWUs1cnRXWUUxUElhQ2pI?=
 =?utf-8?B?cDRvTW0wWGNtY00wcVZqaXJWUDk5bzBpUlNoVmFpWTh2U2tjRmE5T3ZkZTdw?=
 =?utf-8?B?T3p1aTVZMlpBR2pubklxbDBjYmRVc2wrUU0rSzZ2QVJvbXRQR0NzZGR5U3NH?=
 =?utf-8?B?WlhrUmR1akk2QjZRdzlsNEtmOER5UkQ5eW15SXBWbE9yZ0JEOTRYcHBYSVdN?=
 =?utf-8?B?cnNJUWFVekpFODdwZ2lPeWd0N1VHM0Y0NmZFWDVhQ0xLakJGWkpxM2JUUzJ1?=
 =?utf-8?B?QnRHNGErUzJ5aWFoNlZ6QjZLSWFyelJSbTUyZWpGQzZIMS9FTEdDRFkvdVFr?=
 =?utf-8?B?YUIyYnQ3T0I2UHJVUFNBTWdaOXhzSXIzWHgreFY3MEdsbCtwUlMzVURUcU10?=
 =?utf-8?B?RTQ1a0d4SzA2OHc3Zm1yMXRxMmJ5UWpQRjNSV0tYcGZaOUtvVENtcE1XY0VV?=
 =?utf-8?B?NGFneE43Q2VES0h3L1ZLVWVYa1ExQTVuR29lRWovR3RQdmhGVUNCQjBnQThD?=
 =?utf-8?B?R2doaVNyQ1lHV01Tem82czVJK1lDSkRObVdyRnZZV0JCZTdwSy9VUkQ1Nm1G?=
 =?utf-8?B?bkpTTDJxNi9LS0tPeHgvQkdlTUR4SGVFUWpnU3dYVm5hNzBCaEsxNTVJVE5K?=
 =?utf-8?B?YmM0RVE3blNYMEcxajJJUWJ5VTB0bWpNb3h0MGFSeGtSditPOG02RDZOV25V?=
 =?utf-8?B?OXVvTCtrVVFDUk1qdjgxcktkUkhWSmFaMmxxd2QyQWR6L0ExRkhpRUNMM0tR?=
 =?utf-8?B?bTE3bU1ZQXhXcENjMVNrUUFnb3BkR2RNbWhoUkUwcjVmcklPdmtkU1BBaXBS?=
 =?utf-8?B?S3k3Sm9kY090ZCsvbzdSV3Jyd010eGVGVGFwSGs2R2NScWd0VFhTR3JGZHZ1?=
 =?utf-8?B?QVJmcDlXdDZpcmRkUlg3YkFkWkNUR3JXclp6dUN5eUFJWlJkc3pGdk1vcC8y?=
 =?utf-8?B?a1V3Nk1hQTZYQ2pUbmhMSmVqT3huK1RqQW0vTGt6WGxoMzJIdXZYNFE3aDJt?=
 =?utf-8?B?RmtuUjlJRk9JVlZydURTRmVkd1dUTEhxKzlGR2xCYURNc0krYUgxUTNtL3BI?=
 =?utf-8?B?WEFvNlZYQ0Z0cEFnY3RoZzNLaC8zMjN1cDNxRVB4UHdZT1ZsQnZwc3VZNWFj?=
 =?utf-8?B?UWVCWjN0eENIbXVGWmp4d2VZaGdTVk9xU3FkOERuM1ZML3plWUZvQXMvbmcz?=
 =?utf-8?B?cDNmQ0xHa2dkT0REV28vdXlIRjcrdktpcy81a0Z2RlViUUhYbHJoZmt2OXF3?=
 =?utf-8?B?a1JqRWp5K21YZE5KbURCV0lWa0JOS3hxWERsd0cyemdibWdkNWN3QUpwY2x1?=
 =?utf-8?B?eDZlVnphSExNWVZQdUxkQ0RFNXAzd2J3MVpoMllreU9mYnRoK0NqQW9tZUg3?=
 =?utf-8?B?L2tTamFvS0o2MnBva2pQSFNQN0xRbVJoVkh1SmgvKzFmZzNOQUVmUkhWbUZV?=
 =?utf-8?B?VHNJV0xwMnBodlE0bHdUMnZsZVc2aVY1dU5KQnlBMlNaWHRwNkpkZEN1Zmtz?=
 =?utf-8?B?TXh5eTdmd2ZqQ2IxNmVjSFpFUUh6eDdzMjF0S2w4Ym1ORkFCaytsZ2VRN1VW?=
 =?utf-8?B?eGVGMFUvSnhmdEJ2ck5vKzJRQ3hObkM4SHpkOTZLRXpiOGJGeldRNmsrQzhq?=
 =?utf-8?B?azY5di9TbTJEMUVDZU1TSUZPMGVPVVFzVzY1WXVQZUxENms0dHpGSThiSExi?=
 =?utf-8?B?ekpGRWd3VUxsWHpJMFZBcFVMd3gzSkhNVmVqYVFjaldhWjJPQ0JOTWdXODhh?=
 =?utf-8?B?YXJYd2grNHZJSVF3RnloWEVpMnkzd21sNFQxank1MytURVlOVEtEWjFLRCtq?=
 =?utf-8?B?SFJsVk9KR0FNdVdNVzdNMks1cWNrQkc0VHJOSWF4NUx6d0pBR0JoNnNoVlRF?=
 =?utf-8?Q?dSRNxLMmy71+V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmhkM1EvY2xhT1gvdjhnd0I4cTI2Y1l2NS8wTnNGNkJYZFVYL2dsZlFFWVZI?=
 =?utf-8?B?UnJaUEpjQXhzVElXT2wzR2dVY2plVjlqL3l0QkpPbEV6YXhCUm5zRkZvaW5X?=
 =?utf-8?B?NXZMN280T09scGM1eHdMZ3RranRLVGdsMDVZQ3dvanhwRXhpVzRiQTNmK2Ur?=
 =?utf-8?B?U3kvMlUwMDk3a2dIQUVRMGUzZUo4SVJxazh2YWdZdHhwM1gzQ2FSOWlLWE01?=
 =?utf-8?B?WTk1SjBFcWtCaXpTRlVpeDRZVUd4Q0kzR2M5V1k1NWQvc25JaWgxV29qQW9t?=
 =?utf-8?B?T2NNUW5mQ3gwRDlEd1FOcjBCUVA4SC9uR1U0K1BYQXlkSlJtbG4wblVMRXly?=
 =?utf-8?B?eG1tZFlmL1lOODZjY2wxNHE4UmtiZmJ4RUdobzZQaUY3UDNBeUt4eWlDK1FG?=
 =?utf-8?B?ekxHWEI2SW9xWU5temkrTDh5N1dTZy9YbUdxWmdGV0NQSzN6enhDUEZ2dEZM?=
 =?utf-8?B?bVdFZTZRSzI4YnN5aFUwWjI0VG15eUFMbDVCdkJLaENSZlVjbHNTMStqeDZE?=
 =?utf-8?B?Y1ZVaXVKNHkzSzZEWDR5Q0JJMXgwU3EwZXpJeXZxTDZyT0JjY05wZExaeVBm?=
 =?utf-8?B?NFVnVXBRVW1Pck53Nm5RMzR3UW5ndWMyUTZaaDgvWUFZeHRRaTF0WGptRWpT?=
 =?utf-8?B?QmtIZUEwWFlONFRyTjN0a3lwRnJ0ZHRqZ3Z6dnY5cmYrLzJFU3U3bDBlbnFE?=
 =?utf-8?B?SkdZZWVmdzhyN2NUM0Y2cjdMMVZXWWlnQ1NLYlhXNFFGMHBzaHVtcU00RjNI?=
 =?utf-8?B?a2dQOHVIaDF5bm9ycytoekl5ZWtIV20wK2RUNzl6bDF6a1lwaHpWUFhPZnlp?=
 =?utf-8?B?NGtQOWVKdTZCcng1VmpKNHQ0RXl5RGxibCtid1Y0WlJZcjd5emErL2FNYlhy?=
 =?utf-8?B?VWZlN3A3ZkJmNjRFT2MrbVIxUkdhU3dnSCtkck8wdlVrN05pWWRmclhJYjZH?=
 =?utf-8?B?U3BEa0crM25YTUVvQzB4WGRlQ09HbmhTZUhBSFlMOU5rckNUMmJXdzVTV1NJ?=
 =?utf-8?B?dHdIekFxZ3JFYXRrcXpMbFkvRGRWU1RQUzNhaC9uejluZ3ZNZ0g2d1BJZGJ0?=
 =?utf-8?B?dFZiV2FRUEIwbXdVak1hZFJyOUd6M1MyYzczWWNnc3c4Wi82TlBFWnpMZTQy?=
 =?utf-8?B?M09raXMwTXRzT2M4MEZWOStBYW4xcndycjMyVEZpYmhiOXBTcnI0Q1EreGF2?=
 =?utf-8?B?NmZTRERncEpHMjdoOHh3WjNFNmJOWWtuNzdUdVIvZGM4MjlCbGFWUGNIYkRU?=
 =?utf-8?B?OStURnBobEhoZkpKUGRZbExudytNVkM4Nmt4eCtjK1BoQmZXckJzVTdmMTh3?=
 =?utf-8?B?a3d0Z21VOVJ5Z0kzU0ZxTU9VbW5nUFVTTmdrcW5iUWIzaVIrVGgwa2xNWXo5?=
 =?utf-8?B?aVlBbmdPQ05XczQ2d21DTG9aQnhYNGJxVmZ4UW83MjdwY2FxSThJZkQvZWRH?=
 =?utf-8?B?RGRJWEVxN0tzVEI1ZW5aOVFSTzM1RW51QVVWV2RVNk9GcVJ5R0RiRWgxYTkw?=
 =?utf-8?B?STBSNDVhWUN2VXNVY3dFNkxRa2RzRVNuZjZwbjRwV1RiRU9OOVVNQng0OSta?=
 =?utf-8?B?dlU3U0xHdWM1N0owMGVWY09URWp5VHcrK1U0OVdMV0p4aXFobWJmY3kzTzdZ?=
 =?utf-8?B?eU9MbVRKQTZqcFFybkpZaysraUhUTXo5Z0RVRzZwS3BNTnA2R1dydUFQSEdC?=
 =?utf-8?B?ZUJRTFhkUjN1bTg3WUE1TjNycEY5UDlCanJrVlY4L2lBT2ZBNnBIRXBFZGFL?=
 =?utf-8?B?UEtJZXJiekxQbTlyWVlHdkNYa3plU1Y3SzlkS2gwRm02NytmTUtGQ3Z2RVBq?=
 =?utf-8?B?eENHbmxoc09YSWtzZlk5NGl6SUVBQUJHUGxabUlLNnpFeGpuMW9JdkxuWnVj?=
 =?utf-8?B?aVVSUEkyL1UzbG9JcHA5Z0g5V3hTWWNnNkNKeGNERk5RSG5mbE9SdGpkRGdh?=
 =?utf-8?B?ekd6N1BOeWtHODdZNFJWSXlXWjQzdEhQWDF5Sy9Hb09IeVdpN3hRekQwL2Y2?=
 =?utf-8?B?eDFRcUtBczc3VFozYnk0aWNFbDh5cGVoMFRadGFBTGtGaUxDVitRb3BMWnF2?=
 =?utf-8?B?RXR5V0ZwZ1R3Q2hkZ2N0N2s2dGFsSy9YVzNzc0xubUhkdmNYL21LUnZqK0pz?=
 =?utf-8?B?aW1FK01hTjZ3ZjhlT2doR3o3RjErZjdDQTYxWFpFNXhabDBaL3V3WGxPKzNs?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z0Mqd4l+x9Fv1sMNQ4GvFdd9vTt5P55PRi22EQHCBXSALjasVDk8KoEJyjZk7zkSQ/k+tRYy4/X7rVCkf4HqaWqP0w/va3f/i7ON/JK20vT6jBk6yibJqcU8rvcpEdXFA1aU+SlipNxhqqBU6tBKDg8oz90jti9RXCaW5B4Py+OUaWruKj5VtoayoFIq640N6fBOOgw8WIYMmZu3C1KZO0XvchluDsHGoCgV19iMZ/DFEraOJ0POT8Dr1s5QirTY08RvucTNoFYxd3qW03fY0RKGGvk7oA7urg9JlZn7km+7efHortNyqHcTeCsJ2QGDcURRmfdSgDBGaRBiG9T9jpieYd3FwGZdlGu8ZnglId9HgG6ADtiCpJY0USxiWQveWW3rFetML7/gTZRN9ZNl/XTqYOs+26OgmOwIZQwaa3lr1J/G18ct8ZWicpyoKDzXdwFz/URscYm7Pu0tYiRGNrfj1Tc9bhehB1Z26q2d7gX4OwEuzmMY8tEolJCZ63JglQKkQy2VAxVyxPYu08N0sG0BXIVJ0lAqCgPrniYEJSSwM2Mr2zKwdtwuO2K4NG+G50Iu8KkKqgS7OReljbOZFZSF3MgJQK5sOn79Wp4dPdc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b55a45-adf6-4895-388b-08dd40852a78
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:51:24.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zunpUJVtam7WBGNwvJ/8Zbc/o/uC6c+cFYTdLRigLhBRYxSITnm5EHuLOQQR06weIcvmNyKfjhThYrERO/Y3/QnQo8uR4N+LimId+xY0W+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290134
X-Proofpoint-GUID: xgq4t544iXAjyk8ud-1ZGl7_e3TvhLFn
X-Proofpoint-ORIG-GUID: xgq4t544iXAjyk8ud-1ZGl7_e3TvhLFn

On 1/29/25 10:36 AM, Stefano Garzarella wrote:
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 9a4cbdc607fa..6bb64f3be7db 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -1828,14 +1828,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>>         }
>>     }
>>
>> +    if (vs->vs_tpg) {
>> +        pr_err("vhost-scsi endpoint already set for %s.\n",
>> +               vs->vs_vhost_wwpn);
>> +        ret = -EEXIST;
>> +        goto out;
>> +    }
>> +
>>     len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
>>     vs_tpg = kzalloc(len, GFP_KERNEL);
>>     if (!vs_tpg) {
>>         ret = -ENOMEM;
>>         goto out;
>>     }
>> -    if (vs->vs_tpg)
>> -        memcpy(vs_tpg, vs->vs_tpg, len);
>>
>>     mutex_lock(&vhost_scsi_mutex);
>>     list_for_each_entry(tpg, &vhost_scsi_list, tv_tpg_list) {
>> @@ -1851,12 +1856,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>>         tv_tport = tpg->tport;
>>
>>         if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
>> -            if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
>> -                mutex_unlock(&tpg->tv_tpg_mutex);
>> -                mutex_unlock(&vhost_scsi_mutex);
>> -                ret = -EEXIST;
>> -                goto undepend;
>> -            }
>>             /*
>>              * In order to ensure individual vhost-scsi configfs
>>              * groups cannot be removed while in use by vhost ioctl,
>> @@ -1903,7 +1902,8 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>>         }
>>         ret = 0;
>>     } else {
>> -        ret = -EEXIST;
>> +        ret = -ENODEV;
>> +        goto free_tpg;
>>     }
> 
> After this block there this code:
> 
>>
>>     /*
>      * Act as synchronize_rcu to make sure access to
>      * old vs->vs_tpg is finished.
>      */
>     vhost_scsi_flush(vs);
>     kfree(vs->vs_tpg);
>     vs->vs_tpg = vs_tpg;
>     goto out;
> 
> Should we adapt also that code, removing the kfree() and updating the comment?
> 
Yeah, I think I should. Will resend.

I think I originally was trying to make the patch smaller to make it easier
to backport but seeing it again I think it makes more sense to do the cleanup
in the same patch.
