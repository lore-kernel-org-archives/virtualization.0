Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FF200CD
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832220; cv=fail; b=fNauvwni3gZLmlyFgWICobuxTQ8JI2lDOSj3eaGxbdPUlskHA60F4BZqcIWSVhV8imTkAKuNI1FbZ2bYGJO5nusEDbsn91Jv0CsztWZQQRXVf1jChjWK4dOfrsRg210gNFdSquPtDtpU858VjwGnjkqwe7IeXQ/OkFXag11utSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832220; c=relaxed/simple;
	bh=eorLodkmVI0/9zUWbvbaGhCGZZzmK/5RuwApfoQfzlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPgYf7K2IO0eeUpB/lsrbIsQQ3osHhujlSAe88b99cmnZtTEGjtXR2swlp2TElNV9/KVuShe5UFw/CF77RgIpWHy4gYfG1DXwNMXOFYcdUQnt4vqI+z66cizQ3+6N0kQV03nV5AX3FoBD6DYMQaa7WSDZl34sarOq3ty/NQwuWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fq3jWbUv; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fq3jWbUv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8OdAD+XdxTvknhqhXfPN94lpAxHSkwtHnv5Tz5DlXtZHW2mSrYPQ9Y9LjDihc51I1Pg2YngATB+s9ginAJXO/4Hzft/vRx4Uf+CCRXv2iikcIx4ZMK19KySLNFPIJJtHQypDGm2gTdD1TfS/M6BN15HbiYgsaBRghP8496EQSiKrxsvLxyYHsAAguJ6a6E2kFPmF6Vdx28ZWXtunNCxe0q8CX6QrJOFb8OqsJnD1sKWUcX9A9mqq0BSD2yFnwmE/0qszWV+c3Lw377S8F/z1XYx5sfc1amUqQ053qG3DauanpRV5wXVwctaMRKXqNUrRpSNEdC1+PqhL7RZWRk7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LclziUaIv/xWU3lb47JtiCfXbu1TYIg6zvOxm7+1Pkc=;
 b=ZTwnp2qTzmSmVgVEpzSMjJ4EWmb76og5WfYSWn9Oz0AYSnGpRTweuR4xujkjm8YspHsZqwDRxKwjN5s2D6FwjCDGm7tU0d20yjn0MCm3u145qT47V2L1Ef5WHK91NAKNgRzx6OiI2knTSXSVxnAx8kzzuhwMRSEiKx1CnUGuygI+HC587lE9ln3tk60G9U+mRwcl4yorxsrmGyqz/jy/Wd2ydmA3E2CQ7m4SbROY6CABfmc+T/BE4FN2hVyFlpde9VCUwQMlbwvE3U+ORcQVjIxvKdW0PduWGhg3oEqukXvCNFNtHbiAGegHjue/kMXiG316RNknqpkEpvvhB3Vi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LclziUaIv/xWU3lb47JtiCfXbu1TYIg6zvOxm7+1Pkc=;
 b=Fq3jWbUvKgDwooa1hHyEavzNLxbSkRZQ417Esqjw0RKQvkIaeV0nH9zfKTshTpGOevqPB3Phw0+AI/KnSrZ/UMT4X9OmUbS0/tML3qTjmPHzKZBoKGtCa5Y529Xi0MEXNLH5V2NXrEBrKX/qhVu3bEEi9/UdbWWG8sYeS6MxKTTkFoSLyliatd7CT2tr576nkZJ5kFX6C1rHEzZm5dSvqrUhItR6qcvh31f8u2ENl9/4C3EYOYzeGZGF9Bw7uxgNXzlF2H0NkPcuHWbQ5MIcANBYoY59s8ciTyK3uyN9Ib2O82rrWCK5x7Xvdg7vpww8DUq4j7e95n02RKv0fQ156Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 08:03:35 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:03:35 +0000
Message-ID: <fb810fc1-1a6a-487d-8b35-2ed8a921a915@nvidia.com>
Date: Wed, 28 Aug 2024 10:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Fix invalid mr resource destroy
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240827160808.2448017-2-dtatulea@nvidia.com>
 <3706c1ce-0a65-6f62-e735-9ee187a8966c@oracle.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <3706c1ce-0a65-6f62-e735-9ee187a8966c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: d60a8b2f-6421-4c4a-3436-08dcc737ea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHVIMW9XY29ubk8rNHZqNENReG5IeE9Yc09za3ZIdVVnekZtZXVCWWRURWdC?=
 =?utf-8?B?cVpxWG5reGQwWU16WDJtd2JER0RaUDd0UEl1c2pYek95TzNRM0Z6YjBwaHNJ?=
 =?utf-8?B?NkwyZEVVWWsyeTNWSVdmcWJPRVRxdnFEcXROWWYweWptVElVN2ROK213OXFx?=
 =?utf-8?B?MklSMXd0MmJrbTFwMGE3SkdraFVxeHU0WVMwZS84VlhYOS94N3RkUEoxTFpp?=
 =?utf-8?B?WXFhUFZKQ1lJdlNJbVhONFh2emRKOFE2RHlpY3QwZjVraGtTOXVYV1NSaFYw?=
 =?utf-8?B?TUd0VDhjdnh1TDhmTVlBS0lYeVluMS9mQ2xFMnBxbXIxeWtnemlWL3prK2hV?=
 =?utf-8?B?MUFGbFUvSTJ1NDRBcDNOSXZFM3poNml0Q09wTDFyN1RaeVlPWWYxS2IvYTR5?=
 =?utf-8?B?TCtLU3kvczQ5MEFrUEp0V1ZSOGNjSG5CaGsvd3d2UkxIVXdOejRaOFpFMzZL?=
 =?utf-8?B?NlhNV1F6ZTZFWHovWGpBdVIwdkZPRnF0bTFDa1d1RytQRG5oTFovb2Z5SExJ?=
 =?utf-8?B?OGpBOFNRY0h3cFBWTGVMZ1Viejh1NVR5bUcxUTQ1ODJrOXA3MWdob2w5TFV4?=
 =?utf-8?B?WTF3NXU2b2JDeWpGdkIyVUJxZjYzbTJmNTlwbkRBRXRFcnJKUmRvWTdDMUor?=
 =?utf-8?B?OUR6Zy9kY01hbWdXOFZHZ0M3VEtCQlpkQlQzK3BJYjhBTjF1NzRBTmdUN3VE?=
 =?utf-8?B?UHJSdDY3cXZnclJYUWl1bnJFQWduSlJ1anpJRGR2RW5Id21pN0pyckpNM21l?=
 =?utf-8?B?eVg0VXFFU0F3eTFMeWhQVWkwTkFhWFdBL0Z5N0JVVmhLQ1hlb1o0U21KM2ho?=
 =?utf-8?B?MzhGUlA2RnFKTHB6RXErV2JxK2MrMmhEdFN4WVRoM2VBUW1jK3JSQlBkMnRT?=
 =?utf-8?B?VTZ2VnNIS2pmbWxwNWkxZ2lqTVM3cGc5WjRBR0dJcGdmbGNxc21tdTg1UkMx?=
 =?utf-8?B?U2JtUWFTMnBQZ2Uxa0tIQ1RVM2RlOXJ6ZzV0dkFSeC85Z0kyOERmTnVLaUJm?=
 =?utf-8?B?NVhOeHJEOXVBUUQyZ2tVSDRpU1hkemd5VDVUWVBaaTBRWU1vQTJ4WkgrNC9Q?=
 =?utf-8?B?VHB3VnVGNDhkM1lwaCt5a2dBQ1dHbDZDeEJ3dDBML3V4dXYyaTUwV3dDYUhX?=
 =?utf-8?B?dGl3akZVM1BockVVOHBreHNoVElERVFMczZuM1U5U01ZSW1LQWIxT1YvMURz?=
 =?utf-8?B?WlVQQ0hFakc5MXc2elpXT2lkZWVwMitSM2FKa0dQVUErclREeTdtaUxiTitx?=
 =?utf-8?B?VmlWaTRpeTdzZzNsVFlUYS8yTjJRVDVURUUrZzZYTUg4SVdaQ1RiSEpQbzFN?=
 =?utf-8?B?dHdXSzJmOE80T2N0amdPV2JPeGdWYWpzQzJWTDlMTUJIV1VWODBlcHdGZURn?=
 =?utf-8?B?aEprUERXQ0RpdXBrZXBMcFYxamJjZjhiVnA4Uk5qbWNsT3d6dnc2NUJtVFd6?=
 =?utf-8?B?NFVPR1Zkc2FuUWpKODlIRFFKZFJiYWpveGI5UDJNdTA3WDFHclU0djdNTmhZ?=
 =?utf-8?B?VUdUWFhLalYvRXRCbUlBclJLWmFjWk05YWNoUDZLb21vQ2dnZjhLbFRLV25L?=
 =?utf-8?B?cGF0QnJZZXhveTMzNUt0RzdMQnU5ejRiNFd1MmtITUhiVS9nMC9aN2dIbi9U?=
 =?utf-8?B?bTI3ZGRBYlYwNWxYY21xUlZSWk5aN3V4UEVzbGYwSmZ4dW5uYUFUZ094aWp3?=
 =?utf-8?B?Smd1T0VML0R4eWF3Umg5Zk4zWTRFcjdQaEtSNlFLTFNiSmN5S3ZsK3l2RHVu?=
 =?utf-8?B?N3h6S21TY0tqZ2ZpZ3JTOXFkcWVwRmlYUnlLUS9CKzlxWDloQjYvSHJRM0Y4?=
 =?utf-8?B?K3h1M0tQN1BqMkhoYytXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hrWkZ0WVlLeVZoRFRSbmFJRmtaZU5DbkRZblAxUy9JUGZoVVlkYzhvK3Y0?=
 =?utf-8?B?VXZvTm95ajhadXp1UXdPNmNiVFowaisrcmdVS3FEbDFXbXdxTHFJL1M3bVVk?=
 =?utf-8?B?dWtTMFBKTkhhTk55emN4bXErQ29UMllqdWFmalk5VzU2V3VrZGc4TG9SWmx3?=
 =?utf-8?B?Vk1QdDZPejdkaDhZbnFJTGxCT2N4RmJLMWFYTGpRSEtBcHlFQ3c3ZU50VXF6?=
 =?utf-8?B?ZmtRN1dURDdVY2JGcHcwcGw4d1JySHdiUDNLamJEb3NqR2JaMkRYNGtuc0I5?=
 =?utf-8?B?OVdnTnVPYXpJcXdKYXFJMGRnS1Z2SmIvNEMwRHhvWTVST1JCN1N1dUEzQ3Qy?=
 =?utf-8?B?WTNid0F0T1RJYUpwbHN4NmkxdGlpWDNPcElGSUllU002L2xuKytINFVzMy9S?=
 =?utf-8?B?L2FPUC8vemxCQkZNa3UvS2U0M0lPc0xMdjBYcXpmQkRYdEl3dE12a251RzNj?=
 =?utf-8?B?TXB6VDg5V0tjei9lakYza2ViSnBqS2NBSFVRM0FUZktzN3c4SUtTRFYvWlhx?=
 =?utf-8?B?MFhQTlpRekk3cFVOdmpkMk45bXNtdWVxdTRNWFFMK0pOdHNxYlhpcDBPbTRB?=
 =?utf-8?B?andtb2RKZitOZDFzT29CVFlZWlFIT25jbGF5MlNkU0FJR1pyYnJoc0tEOHNV?=
 =?utf-8?B?cGEyeVpXbkt6L1pzTmlleGh5elBrYnIzcFEzSzBqRS9IMk9pSFgyVVlpZnY2?=
 =?utf-8?B?c0hjTyt0WWJhbkxoT3Q0R0JycHdiZDVrM1J5RTVnY1hlM2ZLUm1UNGVIOEY5?=
 =?utf-8?B?TXM5cm80WTlTWlhPakdjMGpMNmxudml0UFFxMEhvSFRGdnpXNFBmcVpORHN2?=
 =?utf-8?B?WkRTdmV4VitYWWpxSzZOWVFLV1V0VXdUaFl0RFRzRFN0NVdTK0RrSDZmUjdZ?=
 =?utf-8?B?TnB1bk0xd3c4NE9naThNY2UwRVFTcGJLTTczWkRFY0RMQUNLajcrdGJpb01x?=
 =?utf-8?B?Z1g3Y2JBSkx0VGs5QzBDL2lVOUhBLytnZnpJK0YvcTk4OVBIeUhVb1JDdWN5?=
 =?utf-8?B?NTdEOU0xOEsrMXBER0dRTzFHbEVnUVljR0k2NHl1OUZ0WkVaSkV0dnBLSyt6?=
 =?utf-8?B?L3BvTW5QUDVzUjcvSllJMHZZTzFvektTUzIxa21MbWs2TVhlU1dlZ1RKSWtx?=
 =?utf-8?B?MkU1NkdhT3V2N2k1WWlTWjhXZlNoQ2swaUtud05WMXMwcitQQlNkRDVFZXcz?=
 =?utf-8?B?bFRiVzRaT2syQUtmVFFaSTBYbmdDYW1SYVZDLzlYbCt6bjNBakZoWlZPNmxB?=
 =?utf-8?B?d3RJRnRqbzhUa09XaEJwYkl0T3dwd1prZGZCN3N3MGMyTUJpNk16RjNrRWZk?=
 =?utf-8?B?WE1IejNUTWtYUksyKzZwSDlkWTdsSkpWWWZjM2VZWDVLMHgvWEtQTDV5My9E?=
 =?utf-8?B?TlJhQ21GYmtEQ0IwTEg0dTFHZkJnMkFlTG9iM0kwaU1FcEtZbCsxSElPNlh2?=
 =?utf-8?B?eXpUZnhEWjVOcmxVR1BBNXZuM29TNW5BK2gzQXZtOUtYalFOZTVZdXp5eVZ4?=
 =?utf-8?B?VFdyY2tEemlONmdHYUdKZlR3dlFRb0FReThKZ0UzNUZrV1NVMlVsWC95dXQ5?=
 =?utf-8?B?TlRwbm9wUE1jRVh3N2pEZi91ak93cndGM0MzSjVGU1hJMXZmODF6ajdyUEN5?=
 =?utf-8?B?L0NVT2Z1ZUY0TnZKNDBTY0RDdUdzT3IyTnVZVFlERlpocEZTdTN1Y3lIVjlQ?=
 =?utf-8?B?d3I2di91Wlk5S0k4YjVZU0lCOTFIbnBYcFVCNW9ESnpCeVlZV0daU2ExZEtS?=
 =?utf-8?B?dHJiSHpJRXN3SDhBSzlYT04rL2FUYmtrMSs3UUJhSGhDREUyTm5selpCWGox?=
 =?utf-8?B?aEdMb21FbEFGRXFWU3lyd2xRY056LzIwaVFqZGh0UUxKR3FZMW8xbFB4OXhF?=
 =?utf-8?B?V3FjZGZOQ1plMEE4SFlVWW5wT21FT1dwY0dPZXFxWW4rL1M1azRpNTh5MXJO?=
 =?utf-8?B?RlRNQkhoUnFDUFh0NnZNTjcwUXdubnZvSzZrT09EbDRnK1BmdytVbmIzNDVQ?=
 =?utf-8?B?ZEhINmNlUVRvWFpEYkNnRW9IRElEZ1FkTG1POUdQeDE2Ym5rb3VNV3l3dEJB?=
 =?utf-8?B?MFR6OVRwWjMzN2RjdnFPRkZ6SEYvTXVCRUljT053UzRZYW5zMG01N09MalBT?=
 =?utf-8?Q?tB/7DlXATD1tERyZ709SHx0Lt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60a8b2f-6421-4c4a-3436-08dcc737ea4c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:03:34.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/MKSg9EMf78EamCXdKrt4kUJbi4MLiHmA206NyNjQtzjESpy+Yvg8BmETmRnRLSP6VCpXy8bV2N9YRo1cI3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263



On 28.08.24 08:22, Si-Wei Liu wrote:
> 
> 
> On 8/27/2024 9:08 AM, Dragos Tatulea wrote:
>> Certain error paths from mlx5_vdpa_dev_add() can end up releasing mr
>> resources which never got initialized in the first place.
>>
>> This patch adds the missing check in mlx5_vdpa_destroy_mr_resources()
>> to block releasing non-initialized mr resources.
>>
>> Reference trace:
>>
>>    mlx5_core 0000:08:00.2: mlx5_vdpa_dev_add:3274:(pid 2700) warning: No mac address provisioned?
>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>>    #PF: supervisor read access in kernel mode
>>    #PF: error_code(0x0000) - not-present page
>>    PGD 140216067 P4D 0
>>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>>    CPU: 8 PID: 2700 Comm: vdpa Kdump: loaded Not tainted 5.14.0-496.el9.x86_64 #1
>>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>    RIP: 0010:vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>>    Code: [...]
>>    RSP: 0018:ff1c823ac23077f0 EFLAGS: 00010246
>>    RAX: ffffffffc1a21a60 RBX: ffffffff899567a0 RCX: 0000000000000000
>>    RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000000000000
>>    RBP: ff1bda1f7c21e800 R08: 0000000000000000 R09: ff1c823ac2307670
>>    R10: ff1c823ac2307668 R11: ffffffff8a9e7b68 R12: 0000000000000000
>>    R13: 0000000000000000 R14: ff1bda1f43e341a0 R15: 00000000ffffffea
>>    FS:  00007f56eba7c740(0000) GS:ff1bda269f800000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: 0000000000000000 CR3: 0000000104d90001 CR4: 0000000000771ef0
>>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>    PKRU: 55555554
>>    Call Trace:
>>
>>     ? show_trace_log_lvl+0x1c4/0x2df
>>     ? show_trace_log_lvl+0x1c4/0x2df
>>     ? mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>>     ? __die_body.cold+0x8/0xd
>>     ? page_fault_oops+0x134/0x170
>>     ? __irq_work_queue_local+0x2b/0xc0
>>     ? irq_work_queue+0x2c/0x50
>>     ? exc_page_fault+0x62/0x150
>>     ? asm_exc_page_fault+0x22/0x30
>>     ? __pfx_mlx5_vdpa_free+0x10/0x10 [mlx5_vdpa]
>>     ? vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>>     mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>>     vdpa_release_dev+0x1e/0x50 [vdpa]
>>     device_release+0x31/0x90
>>     kobject_cleanup+0x37/0x130
>>     mlx5_vdpa_dev_add+0x2d2/0x7a0 [mlx5_vdpa]
>>     vdpa_nl_cmd_dev_add_set_doit+0x277/0x4c0 [vdpa]
>>     genl_family_rcv_msg_doit+0xd9/0x130
>>     genl_family_rcv_msg+0x14d/0x220
>>     ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>>     ? _copy_to_user+0x1a/0x30
>>     ? move_addr_to_user+0x4b/0xe0
>>     genl_rcv_msg+0x47/0xa0
>>     ? __import_iovec+0x46/0x150
>>     ? __pfx_genl_rcv_msg+0x10/0x10
>>     netlink_rcv_skb+0x54/0x100
>>     genl_rcv+0x24/0x40
>>     netlink_unicast+0x245/0x370
>>     netlink_sendmsg+0x206/0x440
>>     __sys_sendto+0x1dc/0x1f0
>>     ? do_read_fault+0x10c/0x1d0
>>     ? do_pte_missing+0x10d/0x190
>>     __x64_sys_sendto+0x20/0x30
>>     do_syscall_64+0x5c/0xf0
>>     ? __count_memcg_events+0x4f/0xb0
>>     ? mm_account_fault+0x6c/0x100
>>     ? handle_mm_fault+0x116/0x270
>>     ? do_user_addr_fault+0x1d6/0x6a0
>>     ? do_syscall_64+0x6b/0xf0
>>     ? clear_bhb_loop+0x25/0x80
>>     ? clear_bhb_loop+0x25/0x80
>>     ? clear_bhb_loop+0x25/0x80
>>     ? clear_bhb_loop+0x25/0x80
>>     ? clear_bhb_loop+0x25/0x80
>>     entry_SYSCALL_64_after_hwframe+0x78/0x80
>>
>> Fixes: ("vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code")
> The fix looks fine to me, but how come this is the commit that introduced the problem? Can you help clarify?
> 
The crash happens due to prune_iotlb() being called on an uninitialized
value. prune_iotlb() was moved in mlx5_vdpa_destroy_mr_resources() in
this change. But the function was called mlx5_vdpa_destroy_mr() back
then and it was used a bit differently.

This fix could have only checked the validity of the iotlb member. But
there are some locks being taken in the called function which are also
not initialized. Hence the check for the resource valid flag.

Thanks,
Dragos

> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> 
> Thanks,
> -Siwei
> 
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/core/mr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>> index 4758914ccf86..bf56f3d69625 100644
>> --- a/drivers/vdpa/mlx5/core/mr.c
>> +++ b/drivers/vdpa/mlx5/core/mr.c
>> @@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
>>     void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>>   {
>> +    if (!mvdev->res.valid)
>> +        return;
>> +
>>       for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
>>           mlx5_vdpa_update_mr(mvdev, NULL, i);
>>   
> 
