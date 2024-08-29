Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16071B140E
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926830; cv=fail; b=W8NYj7lHjKgYp28hzT9oAWeDIEF26ips2g08nlhLGiR0C4zeVIHhqzr0koeb6YYqdB2o0VWSBDFgWCMZ+ysTd7Lo7XrRfbr0js8J5jNH2SSNpi9GIS93e+kK054AMGTK8XWrEG+zWkAx/PSRX6lGedZtAj9Tvz4lLI6AoJUz1ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926830; c=relaxed/simple;
	bh=sJMUWrZt2eOBlcIPeElYHEApamo3zzFEkvhaRM9PyKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qogNoyFArhAByr6h5ZbNU1F5OKV/bCwXqa8butWc1GzGPjkLXRFtmm6lTGIqOKjiRJfNZuF5LPI/bXm6sZRInVGErVzOwDAi5BQrJcm7TBaAtmWtZAjllBTZ/q3yBku3Jkd3Q+VMChbHs95/cAN3aXICWF2C99Ej8OgdJOvn+xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pyh4Ib8U; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pyh4Ib8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwpDK8p9durbmp72jwytSewXPfvtwVx93L9REv5bR4Fv+ouCC0MppESXUoLLQBCORw8oxEsAiOeeiu3TUvJdbmbZ+EtNIaNml7wSJqe9RQkSw59pbZw/heD910g0Cdwaa7+IBQzcVje3JkgvBrVv/ANTF2ePZ6UqjLS7RVPsUw9ISfIFmyNTklrN88DdZA43IQKSG7dxFxom692zkB73VHDgndaBZ6mFhznI9Tqng5G/VD3z4NYQlcirvsESY8oa4XTqeM+gVlHsbpTT4F55nj9cID/89WRp+Mm9igFuaBk5Vx/6Et9Zt5nr6b/UIyooNpu52yPB40CqNvTFlpYDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD3Z4zTDk3eCOL6GmlhCMNfWauo1EbmTyXQABiw1xik=;
 b=gE6C89h8JDdlJJ/Juk+ZIWojHUUb79vrZfjoazrn0L3JNn9kUY7IBniIQN58yHJlAoc+qMsglc1hA4VxN3DJQW0A/7p6ul7cyEWaq8XdJlYd6O6YP00KydKY1sXLPCjk5cy/bRFgHsd4Kj+6S3/+EKYWKtEr7jxhsin6V1Oqto+qrqDvrmhsDzPtbxedfLeT0xsz/pQCgb8ofG7sSg6f0I47g2DkyFU1KbB2PL1Qv/AVitbJ/BPAG3/HI2KjcCY5f1/NGaZcNyb5tfY+UB6q9ONzBsuJZuGrgDzOeMahO3IgvX0lD3ZjC2eh1nfar/uSopzMOG2H5kfPTWRK35wUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD3Z4zTDk3eCOL6GmlhCMNfWauo1EbmTyXQABiw1xik=;
 b=Pyh4Ib8U7gRN3U6GclkpOu1p9//QsWmRfAl6AQxYnkie8ZNrjppjeGrz9T8rByFacc1OIZw3eyZ2AS41z5x4IE6Fuy9dIwAXfuBTFPVTTzCf8UPFJDFMOKlSmgOzZzvGYKA8fSs4JDB4JQo3SaQ9BU8H/CAhwwodend3o54040lrLijV+3wKqmbgGiSBAsMk+0yzmET2IRvXYBuvMjdUvFFTJwcCKsqxNUp1bPwm/TdqhjTj0SIvVCsDt3RCLPLpX9vs9bh+LH738QStFWddavLXhRhIimUjnNYsOsedjyR4p3bqqUpdBwDvL6xzDMa+a5DwAL4FxDCKXi5qixHNjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 10:20:23 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:20:23 +0000
Message-ID: <8a8d3c23-5e91-4456-99c2-6e91548abe42@nvidia.com>
Date: Thu, 29 Aug 2024 12:20:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0366.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::13) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 7280f250-7b66-4faa-bb69-08dcc814315d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V3RuMEt6di9COWpQdXI5NWJOUDZoK3h5aEZGMFp0WTUyaUpEVnV4bG9WR2VY?=
 =?utf-8?B?UGo5ai9wVkZOWTRRZ3RtY2ZLMTJIUUthWnpGUmRDWjFKN1MrWURaRWJoZExa?=
 =?utf-8?B?akIyQ3dHV1pkQkNaaWpDa2xiVndYZnRxUTBpdDkwbnY3T2lYSnpaU3pBaktS?=
 =?utf-8?B?ME0rYXpoOFJLbFhWMUQzUE9KckdueEtmbEIvZjJHeVoxa1VNTzhjU3oyOERY?=
 =?utf-8?B?MG5NT2g3VVZlNmhpZTZEOUtpbzZBU0czWVljeW56RlQydlhVS2NQU2ExT242?=
 =?utf-8?B?N053elBzaXdHb1hLVHZ0bTB5RXdQK2tucjZPNUVtWCtqbTVlTDA5UFQrMmFY?=
 =?utf-8?B?UzF1V1ozYitVNFEwRHFWZ1pLcG5IMHZjV0RQLzRuTUJkSlBKazg0M3lwNXUy?=
 =?utf-8?B?eVprS3ozMmR0Rk5rTUtoTnFPWjI4NHpMeXY4elZWc0Nlam9wTkYwQThIdmEy?=
 =?utf-8?B?WWNWbTYwb0xuTW9KSUxncHRUK09tcUhqNTNvTmwva1RVS2IzRHhSYk9Db3dv?=
 =?utf-8?B?L1hRdlF4VGZ3YWFKaFBQYlpBbzVSZGRHMWl4OUQrMmk5SnNIQU90ZTRNSnFi?=
 =?utf-8?B?U1REZFhTRWp4cnRZTGNKWWowVWp3c2JWai9RM0NlV0ZjSWZDTEp5T3pnWGxT?=
 =?utf-8?B?M2VkV2w3NHpHc1A2ejhMeFcwd3czNlNlOWE5eExEUkZrWlFaNEZCK1FsN3Y3?=
 =?utf-8?B?UnJ5YTA5Uy9NWUJJRTZ4YmFwMUZjWE5DaFovNGMzKzRETFNESGVnVzJaaUk4?=
 =?utf-8?B?MHhHM1ZIOS9lMVZkamVRMytEOTBSYjBUSGtzZ3J6aEIzMnRPSXAvQm9mSE4x?=
 =?utf-8?B?OGVzMG5QRW9saEFVb3FRZkl5b1NkVmFKdWhianFIQzdXaTFzM0ZpMDFFNHp1?=
 =?utf-8?B?RnIwb2loaE5Sd1Nobkx6QTZvaVM0cmlIYWpsOXEwU1JUcXFnZytmVkIzZmtU?=
 =?utf-8?B?Nlo1blhQUW9wN080OHVFRTdYNWFSQUx0QXIvbVRwWDNzOUxTR2YraGQ5Wmcx?=
 =?utf-8?B?MjBHeXoySkFmQnpWbnZycTV1TGJiL3ZucXh5Nm9sWDIyQ0drZnQ2UnlmWHg5?=
 =?utf-8?B?dHNLdSszZVpYWWlSVGM5UkNYcndQRGxHY2l5MW93Q01vc0RRVTQxaklFTjlB?=
 =?utf-8?B?UFVSVndnUkdXUFNEbWIwanA5ZktINlBIUEFjL2tMS0dPZExlc1NyOVlsZDB1?=
 =?utf-8?B?MHBPdlRld3pYZUpRY25TNTZKYjFGTlBNeWJod3RJeXQrR1hLM0d3WGdPMXhW?=
 =?utf-8?B?WGR4V3NYMUNRS3lLY01oQkVvbmoyWmdodkhBMWJoZm5lOVk1LzNpZE9nREdT?=
 =?utf-8?B?MzBGdXdLQ2R1dkFMUmhGR21oTW1PUTZDaVpnTTNreFhYWDNRL2JqdC9NbTRw?=
 =?utf-8?B?Z0RzQnZEaE53eGpMZ2JmK0cxY1B2MWhSNTkzMFhrSFdheFpNUWhTNlJqWUo2?=
 =?utf-8?B?ZVFBdmpzNXl6TUQydUF4TDJzR2ROV1ppRzN0b0UwVlRyNlU2djZtaUpQM2pz?=
 =?utf-8?B?cDVZM3FWWVd2ZDVnTmpkQ240ak8zb0FSM1dhMmtWeEIxVENlVk9RWE54a3Zl?=
 =?utf-8?B?OWpaMFZDWGVEMUJYaldrWTFGNE54eGVJNVdZNHNXM0p2akJHK2lZeGozK0VU?=
 =?utf-8?B?WWN3VE5hTzhWeFl1VGJndGpLSjI5WHNmYk8yWmpzWkZrVGdJbTVHWHRjNlRy?=
 =?utf-8?B?K3B3SnBuNktzM0J3SVJkYmEycHNhem5aZVlwNjZkZzNvU2J2MzZqWkU2YWUw?=
 =?utf-8?B?OWgyYkNVdVdmYVBnY2M1VHR6NVVVenduM2Y1eUZ1NS9HcUhuZGtORFJTRWYv?=
 =?utf-8?B?U1J5a0pBa1NKcWs0bWp1QT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MUJUZGhEVXBpM2RCMTdUWEtXdE9SRFkxbVRrTFh1WEZScWUxVEJwVmtFd2dX?=
 =?utf-8?B?blBORlBsc2FaWHlBaHlZdVNXanU5ZW9ERTB3dTR2SGlMd1FCVWhhN1cyV1pi?=
 =?utf-8?B?enBPM2Rnd0E1VHYyZ2d3WXdBRmhUdDIrVTJaK1dhS3lzZ2xvQ1l2WXY5UTBP?=
 =?utf-8?B?OFhmejVPVS9kYmlQUFE5Ky9UczFjK24xWHk0b0NLNzBmcTBEM1FuN29wNWh1?=
 =?utf-8?B?T3FFQldOL2x2UEpUWEp0YlEwUTFVcEFaVk9MTXBnbFNqS01EaTdwbmVRUW00?=
 =?utf-8?B?SGx4RnhFLzY0RTFjVW8xOWdaak4xWmZMNlY0Y0JzYmpUUldHVWM3STh3MmMw?=
 =?utf-8?B?dlR2VmhlM0xjVEFERDlyQkNMKzgzdlFrdy9ndGVWL2QyQVRwOGI2eHk3ak5j?=
 =?utf-8?B?a29XWXkrSDZBRTZBbTJaMnJ1Rmg3Z1FlTEhqRWY1aDF1UURWV200M0ZDd1ky?=
 =?utf-8?B?cVhLc1RIT1hnbFhYdmthc2NVY0xJNzNQMFJvYUtlMERFRVBleFJ5dzlUUXhU?=
 =?utf-8?B?YlBkWE9uaDZuMXRSbkhqUWY5ZUpxSDBka2ZGWGMwLzNvdmNRUHZ0NzRrQ3g1?=
 =?utf-8?B?aS9KVkdxMkdseitOSTM1TWN2czNVODRIOFN6a3pkVzdSK0JCRjdqT3Exc3Nz?=
 =?utf-8?B?aTVveTRqV2JxeFhIa3gzbVF2TmxqZ1pXeU1oTTIxTnVYeVY2cU9zU0lva0sz?=
 =?utf-8?B?THNVVUZFUjU2QVUzZittNjdKK0xhTVhIeHZNeUN3ajdvSGRJVExkS2ZOQ1g5?=
 =?utf-8?B?S3pFTldqdzI5WGgyY1lWakFweWVBUWRLVXR3OTh1anlEWlFjcG9UOEpuVXUx?=
 =?utf-8?B?OEVKNkQ3V3U0SUV6MjJHejZsanJPSXgxTGwvaWVrMWRRK3FpbnNoMXdEVEpF?=
 =?utf-8?B?SlJpZGNVRy85dW5mczVnMi9QMUhZZWtnRWlpWDJwUjd6VXlVUGF1L1VCT1Q0?=
 =?utf-8?B?MGNnNkc4MWE3Z3I2VjFqajRwUFV2NXRwd1gydnBJVGkyVWphRExhb1ZYaTF1?=
 =?utf-8?B?Z0NlaGNXamFJOUk3VUEyL0ZFbS9ZSEdUQjVTeVNMRS9jMGdvamZxZlBBeTgv?=
 =?utf-8?B?QWszTW1UajJ2VnhQZ3VTRjAyZnl1amMxZDdPSzRyV2NhNkd4bkxkN3ZCdUln?=
 =?utf-8?B?cjRkcURFdEVkdkRBbml1cWVJZTZkdnhWNHI3RjNySmsraFJPUmR6U29kMUR5?=
 =?utf-8?B?S1lTT1kwTlVyN2lEMjJjQUlCbWR1RWQydlhFNnRhR2VuOU1WZXRtMGJCbCt3?=
 =?utf-8?B?Vk1Gb0FCeHJhcGkvOHJodjVoTlNzdzNLdWdtekltbDZ2ZXNQWUl3TnlRS0NT?=
 =?utf-8?B?MW44VVl2ZkpzbGlsZkhvMDdWUTlKQ3R6Tnp3UHIxeWprVW5yV3F3MkF0VXQz?=
 =?utf-8?B?c3pJZEJ3TCtQS2JGNGsxc041a1hYdkdhbXpKVWlXK09GMFBvZTlRM3VuRHlI?=
 =?utf-8?B?bmROeDFJS3FaVnJ1dFFnQmU3UzJVL09KckRJaVVjOUJpcFRjN2djQStpejRa?=
 =?utf-8?B?ckUvQUdFeUxoYzhyUHpQdVgvWGlPbDFjcWVOcTA3OGwrQy91RUZKT0JNdUhY?=
 =?utf-8?B?SnNhdWZoQy9JcjVPdkRWN0dCVURpTFM1V1J6cVBha054d3lNZW1TemduREZS?=
 =?utf-8?B?ZDFLQUZmQ01xQWlSOXhUeTgwY0o3czgvQ3BDOHlBSkVOUDVsVHEvankvVkNH?=
 =?utf-8?B?b0VlZE05ellJSXlzVWo3S2c2QkI2SDBrNW1PRHNsT1d5eUFvTkZQUy8wbFU0?=
 =?utf-8?B?dHRhblR1azhXRDhPbDlPNy9UT1FCYlVzejV0NEtIWHZ3b3hKVmtPbGZybElQ?=
 =?utf-8?B?Y3g5N0krOStpS2VRVzdrR2oza3FHMmR5SmI2eUpzT3dyWGdRaGNObkppYXVn?=
 =?utf-8?B?d2lpa2RDWjBPUStWYnBLVnpQNmk4ZkdZb0UwUXY1NnFnbmgyYkpPMU9qWlB6?=
 =?utf-8?B?bDJiVWxNaWE2WHRvZGFZOGE4MlVQMHZxVFBKQjk5cEFDRVhEVEIyMm1EOFBW?=
 =?utf-8?B?TFZwNVd2b0tYMUNObEx3di8xcy9oYTE3OXA2aGNHNG82dSsrTzVDNE9BdHQy?=
 =?utf-8?B?TzhNUUFISlFsd3NWWnMrdVFwallqbkhrQWR3ZDR6N0lTcHlOYldjaTBadmdn?=
 =?utf-8?Q?3CPCK/suD4lsX/3oeBMyL0THv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7280f250-7b66-4faa-bb69-08dcc814315d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:20:23.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EItHHoCg/DeEE81v7elAUei2yzZOpb+gzgorNNMtR47tSTGaaiO1pgX3KYUhvkvAbGRnXU/lvOTljQXJiwznCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349



On 28.08.24 20:16, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> mlx5_vdpa vDPA devices currently don't support reporting or setting the
> speed and duplex and hence should be UNKNOWN instead of zero.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
>  drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..319f5c6121de 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = SPEED_UNKNOWN;
> +	config->duplex = DUPLEX_UNKNOWN;
> +
The values in virtio_net_config are little endian so you'll need to explicitly
convert them. As speed is a u32, you'll need to add a cpu_to_mlx5vdpa32() helper.

Thanks,
Dragos

>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..abde23e0041d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>  
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>  
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	u8 duplex = DUPLEX_UNKNOWN;
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>  	struct virtio_net_config config = {};
> @@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>  		return -EMSGSIZE;
>  
> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
>  
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
>  	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
>  
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
