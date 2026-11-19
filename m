Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113624;
	b=0o/NHvigkJhF3zPlJw6HeDHLucZ/Q64/Ofp4zKiRNbHfjgCdfq/hL978HML/12q02SEB
	 /+aVIFYloyRQ9dkLOBRfYe86eAzIhXA0FWNtCo2SoPzwYx0KJw9HR5vwylDDf1hXDFZvo
	 7T1ZukZM5LbzyFjXn4FBGLLtSp1Slf0K0zViv3mLBhN4rW8EOxwl4hkSxPc9glKY+6OI3
	 EP+8TdXoo8bUfKtxpXHnGaBVbTrQ5uC1I8Q2zr9YraIje2M67Nw5kcJ81u8NxkwzyvUHB
	 5WkMjeYwSKsvS0QRRVv0DsGHisN3CnLeR0f+DSKBEw1jGFsVtV2gB0DI+ALS8RS/ezA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113624;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Qps5oF20mmeAmHJSoR8fyVfiCY42hntuyyCwCh9nad4=;
	b=BfhnhkFt9FZft2e3GmpjOi47vsH30dm6pk8AURUnMoGDSqvbpnp67FZnvEVv34wXx10r
	 bnEC5PqmFdZjJ8EdipL/T/vo7c40jkJn6QcZ/hUZOxYQOTH+rIGsdgOfpE2S46G/iopCL
	 2pVyzD5inC+XSBDiSahhX394/mFMNm6qQJf7nd16rFI2vgTHpoYjdvwYuKp1m5PKT19Q9
	 wGXI7kootQQK5gSdEvbiqp49kKix8yCBoS/TxKHGImS075/GpMaCNzyAHwi2iOAmmTWoN
	 ZicT0StlY0lwCHtqzU9BSWsyertVhUf29zviAMUPJceFf0krql6iPFzM/EslLtkVc1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GcptEjr5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB3606A325
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 18:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4CB3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GcptEjr5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsXpztwmQfxU7T7YD7lDNzEle51p+AcAF7maNKiJ8SSqUhJH7DavGbDTnxC3mJN3VWWvJFVjM1QtCLRgfrPpy9+lQqhV3fjwKTB4r6KJwUAa/H6hNC4tWQIvuFWT6A/MBols0BJcSKNU06SAGeZVPC10GufdDJZK4QxKyXK+gLbtWGky1GvVxKbm84U/gg/RcSyg+V5LLfEYO3uGxT9yX74wdStsqaBF0S0enLPuT+80tSeQq9+QCMV+Q816HzUms2TluMRtQAF4Q53Pstd4MM0nlBWrYfLSEpqstxNT+c14xM7ES1cF6E3dxGWeB8ivj0gznLMifceaQKXMJxx6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qps5oF20mmeAmHJSoR8fyVfiCY42hntuyyCwCh9nad4=;
 b=XgpCGZVRMI+1aiMIdYwR5waAn4CbOQBgpysLJRlE6Zf5dqxOskom6HKNMHCpYpfpPdiLq1bI0SSkv0TqSlaWfIfNlDFmJX5fio1Si3+InLS+l3b4qlmZRgka07pA/yRtYdaNyVPUrsCme3HbuMA/T+dkHaa7CDHOh+z4gxHIWFeG7IsT1+uOu5xjsYP+7MOdqscdnMfYi3tUvjwKdEJ5p8zzi4KIN5g3Vwd/xBQnvtvfiKpbJtgx0XD8GRYKA9Apmzvr+zHP5RiFogn/tYVWvB/X4hBGzgkSQ036GpbPGZZ3Zar6sMo9JH2Ecb8Jo+OwetDDhzcgsF+ORP6eFJyWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qps5oF20mmeAmHJSoR8fyVfiCY42hntuyyCwCh9nad4=;
 b=GcptEjr5bF5RIC+zpO3LOubfIGGcar7n13ZMdMwOGz/wJaJeYhpSFjFSxWnRqur0sXvatOskwHPghZYhrMnUAVm5eZr33SaN4Vw79/hooGkgAoX/oU8zOB9knBAgJJlWTk7d7f5JyZ9x+PPp4QZVDTwus0cNAMXa3tUFLFHPD3+T44EpaHfck1vUJ1ujM2Hgy2D1a4qpttzWbxBFbfOezF/AljGw6myI8ncfTs1dXnPt2XvC2cU4U5bVQFYOvA0StpZq6aqomk07k0f+FCjZaNAMNVIYvM1bqOsY+BI+hvUIajPo5AcsSV0wSy5G+AadHx2GuP3EmgQWkwgt3Fj+Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by MN0PR12MB6174.namprd12.prod.outlook.com
 (2603:10b6:208:3c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 18:40:15 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 18:40:15 +0000
Message-ID: <9a901a79-6253-46ca-bbba-ca9bef7f0e4d@nvidia.com>
Date: Thu, 19 Nov 2026 19:40:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vhost_iotlb: bound map allocation in add_range
 breaks vhost-vdpa on hosts with fragmented memory
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 Linfeng Sun <linfeng.sun.dev@gmail.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Jason Wang <jasowangio@gmail.com>
References: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
 <20261028085839-mutt-send-email-mst@kernel.org>
 <808a6e4e-085d-4723-9489-f17f023949c0@nvidia.com>
 <20261028110041-mutt-send-email-mst@kernel.org>
 <ffef2498-eaba-4349-bdf5-7b035052ae80@nvidia.com>
Content-Language: en-US
In-Reply-To: <ffef2498-eaba-4349-bdf5-7b035052ae80@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d6afae-7ad2-4e39-d2f4-08df466c8d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261021123027099003|5023799004|56012099006|4143699003|261022105027099003|11063799006|261026140227099003|261021121427099003|261022113327099003|261022075727099003|261026121527099003|261028144727099003|10067099003|261102123227099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+18Nc+OLYnf+yJHgCrZYyuYFyCml8Y2gocWoQuwUV9bf4Jd3fAUWWLGc4yWuxmHp2rcW16Fa5XxJcPSyZXei2BEgwaMZzD426TNz7wLFmND988Pxvr+TLI83OrlC6zpjY5j68Azd9L07XH4HbSeX5fy4+0n3fetMtgCuXtxoCT1xRUuJyVAjbgV4sVel74NXVrcpCnwDS5gVk0rSwWiorn08yfEnkyQA9kx7NtVHalL2wcQC7HGA2+340QPfZU0EH9YqqTdsBOUNVUc44MqBXql7R9pH41H6/JDT8t95/DXr66Cii/5SYYvDLVwy2zm9zAwdBxo0LDXWxHuLZwQ6pj7h5qJgoeeryeoABdqi8FqfTGDG9XKSbze1XnYB6I+og84GZ/bUBMvd8PN7Pu17N9xdHxNhuGdYzVjO91r8UMJBciyWWDeftpf60xDJTT7EdS8qhgL9nf4at7XbenmyIwGAisB4hvIm80aFRsvEndr33Gzq4STw9I0TY7SLDLwHRDsym/je2pval6mFkvLXmfd9W6KKLjt0kW5pcdy70bkWlw8oQ7A8LNXVX0gux4JQGpzS5ZzeKAw7nizS3plB2SRLFYNQeSR1aWV2f94HVSOh/U3RwwJ+U0BzuQjnjdpYdui41xGTSQ1kzPZ6Cp5aJAnI0P5mJBz86m98Clqzk38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261021123027099003)(5023799004)(56012099006)(4143699003)(261022105027099003)(11063799006)(261026140227099003)(261021121427099003)(261022113327099003)(261022075727099003)(261026121527099003)(261028144727099003)(10067099003)(261102123227099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ujg3Tm5kdjNUU3dUMktWRmRjZDZna0x1d2tlSTd2dG5USzVqTFFUbm1McmE1?=
 =?utf-8?B?cWZjUWtVNWZ2emRlS2dWT1F6MVh1SlZwQmR6dmk5WU5KUnhaNHdDWnV1R0g5?=
 =?utf-8?B?MTNkbm45V3V1cjNwd3VPSWRSOWtuZzBETGxERjVKWCtLUHE4Q29LSEN6NStW?=
 =?utf-8?B?a09KaU5Ld3l2bE4weE5sNTlGbE9aS1plQXlUTThrcXpWcnVuM1NCd2V2WW5s?=
 =?utf-8?B?c1VKWWxRRVRqbU5jTjhhaEFYWW5xRUgvUGM4N3NBUFYxUVhmTFVEU3VRTlhw?=
 =?utf-8?B?NDZSZm1HZ1VlV1J2cjBLTUZLSlYyVGd0R2dYelk1SXNIVWtGelAxeWFncngy?=
 =?utf-8?B?UUtRVDB6Q1ZTdkdndk1xTTVOYVQ1SUtxYlY2bHoraGtkL3o5TUd4MVlMSTBX?=
 =?utf-8?B?TjRZVTYvQ08yMU85WHRDWDJUR21xblZXTVNXT0dyL3JBQnhJdklxV0l5RTc0?=
 =?utf-8?B?amZzVlJSOXF0YVVGeHZaZlNUM25kWXVsaW91SlRBekRMT3dVOU4wcmdDOFgw?=
 =?utf-8?B?enhzdEN6ZG1zY0ovbXd0cW11bzMraUt0QXpNSjFNTVdBWjJZQVYvUFAwbFc2?=
 =?utf-8?B?RlpnVHJDVHZ3ZWFHWTNxNEo3RTVIYXRXWlpaZTVMM1pDOXg0UThWcnhxVDhp?=
 =?utf-8?B?STA3RjYzWWp6Si9UUEM1L2p0VDBUNnhXSXpSZ2xTMFg0R3MvK1RFYldjWTRM?=
 =?utf-8?B?amNBWGNxanhmQm1naS9mTDA3UDJod0FhOEFjbTdTbUJaalJWM3kyR2xnVGVB?=
 =?utf-8?B?K01nYm5pVUlHd2NTZ0p5Qkk5b09rRnlhSUVKcjRheWVqdE5sQzRNZG9ocXNR?=
 =?utf-8?B?RWV0UGFnUWNidnBKUkFHVmlHdVRadkU2SGRhQkhiNWJqcjBnSTMzK0hQZThW?=
 =?utf-8?B?dlplL3B0cjFESDFUOUVEYThJNmZnc1JZa3F0TUp5R1JaMGl0NEpOWjc5SmZy?=
 =?utf-8?B?eXZjWTRZVXY2T0dRNFNlaDI0YWRpNno4NTZqZkN4Umk1b3k1bDZqdlpsdGFV?=
 =?utf-8?B?SDNaK0V5a1pDMkF2WmJxNmxwMWJ5eGIvUGQ3akhRem95LzN2Tjl1NWExQzBZ?=
 =?utf-8?B?T0EzM2w5aVNQYkZZVVd5YVFpRk16ZlhIa04zclNJQUZ2ampqeHd6akpBVGpy?=
 =?utf-8?B?WGZ0N0hvYnZHbDdYSVhDWDFQUDBNc011ZjVGMHFnZStoVXRyZjkxeFZsVFhj?=
 =?utf-8?B?OTZkN0FXdCtHejhrSGZrdjdTNFFqRkY5Y0t1TndRNUE5b3ByU1ZTN0hDcEZ6?=
 =?utf-8?B?VkE2N1NkRjZ6MVI5SnpGK2xRc0kyM2I1N1JhbUpJSWpZdEh1ZEVScUY0WGww?=
 =?utf-8?B?SDQvMW1CdFNsOFQ4dG8xNFQ4U1VPSExLWllhQ25BWG85Zk52anovMVhQV3Qv?=
 =?utf-8?B?VHpSNVBNMWgrbVZkeVFXcDVybmFDcWlVSGJkVDdZMEdrZlpZZnh0Mk5VUG1i?=
 =?utf-8?B?ZWU1ZW9aNlljdnVtMDRhV0tXbGRjK0xUdnplTEJxU0RSclFPMFhWUUpmam5B?=
 =?utf-8?B?NWpHYWJhRjErSkVtVnR1V3kwMDNKczF4VHMrMSt0bVQrNUw4a1RNdkRwTDBj?=
 =?utf-8?B?UW5scnpOdHFZc0FpMytmR0NBNm4xN1hHRkFDNXVNY0lwVU5HNmp3WFBVbzdj?=
 =?utf-8?B?MEpWUFNMM0pLTlJqdERxYnpOVFRTQW5Fb01NTlNQRTJENjdPZUo0eEVqS2li?=
 =?utf-8?B?bW1VRExjVDJTSnphQnp2ZWJPUjdnV0xQVzNCRWl4dXJ6V1dreDdzWU1WNUpz?=
 =?utf-8?B?ZGd6UERNOFVwK2pqRVFxSlozK216TzhYKzM5M0h2VFJUbkNMeVN3M0JRR3hx?=
 =?utf-8?B?elJubjZZZFFBT1hWVGtPUkphem5vU1p3a0ZyUGFyd0F5THZLRmZGNlVEb2lv?=
 =?utf-8?B?VW9Vb2k0Njl2a2EvU2FBTmVkYnJMUTZCaEJWR3hCeE9wcDZEYUloZFM5Q0pj?=
 =?utf-8?B?b1Ixczh1RUpYdnJlVmhPVWQweGxhRTZBN255T3JQNkNQeUkrMkwxU2g1ck1w?=
 =?utf-8?B?RDlnRVBMSlp4Q0E2R0R2UERERm5Obmp6endCWVgxMTlNUlZnamVqTjFISG1l?=
 =?utf-8?B?WXE4alBOMWVvSldSN25FQkV1dzhheWI2UWpCeEtVTzdUcHJ6bU5xNURuYTZ2?=
 =?utf-8?B?Q2pHbTBWajIwTHBESGJuYzZwSHlFdlgxZWV3dTZCUkk1dk5teUFPWVdMZXl2?=
 =?utf-8?B?Q1VObzVtbmhydm1jSlpoWStYSnBUd3FPU3hBcDBhSjhnUytBTTZ1SnZDQmlk?=
 =?utf-8?B?TnlqN0hYVmU5U0pYdkdQYWNXU2FLdDhuWFhDSStzQy9TZUxpbGV3Smt2elFq?=
 =?utf-8?B?bEl0czRwZGw0dXR2b3pvWHd6Zm9wTXg2U0c3dnlnMTlLaTBPSGFLQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d6afae-7ad2-4e39-d2f4-08df466c8d7e
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:40:15.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9grYpalzsK2jx6bkabelraM1GNYEynsj//h2PavVKEibmIhQHaY6SLI0fRBVTCQFnxL852O1AX6yIYXFfDmB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

On 30.10.26 14:47, Dragos Tatulea wrote:
> On 28.10.26 16:17, Michael S. Tsirkin wrote:
>> On Wed, Oct 28, 2026 at 03:46:05PM +0100, Dragos Tatulea wrote:
>>> On 28.10.26 14:05, Michael S. Tsirkin wrote:
>>>> On Wed, Oct 28, 2026 at 01:44:30PM +0100, Dragos Tatulea wrote:
>>>>> Hi,
>>>>>
>>>>> We've started seeing regressions for a while in our verification CI for
>>>>> vDPA Live Migration tests. Occasionally the FW returns a syndrome
>>>>> related to invalid mappings during device reset.
>>>>>
>>>>> We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
>>>>> allocation in add_range" which limits the iotlbs to 2K by default. On a
>>>>> host with fragmented memory you can get easily more than 2K entries.
>>>>> This results in truncated/incomplete iotlbs mapped to the device and when
>>>>> the rings happen to be outside of the first 2K mappings the FW will complain
>>>>> because it got addresses that are not mapped.
>>>>>
>>>>> I'm not sure how to fix this though:
>>>>>
>>>>> - LLM suggests setting the 2K limit only in VA mode and using 0 as
>>>>>   before in PA mode because PA mode is limited anyway. Does this
>>>>>   work?
>>>>
>>>> Well no, we do need the limit in PA mode I think.
>>>>
>>>> But we should maybe  bound from what's actually being mapped rather than
>>>> a fixed count. e.g. X entries per pinned page?
>>> You could have many 1 PAGE_SIZE mappings though. It wouldn't help
>>> then.
>>
>> it still mostly is 1 entry=1 pinned page
>>
>> sharing is possible but uncommon
>>
>>>> Bounding by bytes instead of entry count is another option.How to get this limit from userspace though? Would RLIMIT_MEMLOCK
>>> be an option? Although `ulimit -l unlimited` would need to be
>>> capped to some value...
>>
>> guest ram no?
>>
>>>
>>> Also, if the entry limit is still there some kind of precedence between
>>> memory and entry limit needs to be decided.
>>
>> I'd steal a page from rlimit then use that for the entries, when out of
>> that - steal another page.
>>
> Do you mean something like this [1]?
> 
> Remaining questions:
> 1) Is it ok to delete max_iotlb_entries? Or keep it initialized to max?
> 2) Is it ok to delete the module specific max_iotlb_entries param? For
>   example mlx5_vdpa_max_iotlb_entries. I don't see much use for it ...
> 3) Shouldn't the core or the driver track holes encounter due to
>   incomplete mappings? It would be good to not give bad addresses
>   to the hw/fw...
> 
> Thanks,
> Dragos
> 
Ping. Did you have a moment to check?

Thanks,
Dragos
