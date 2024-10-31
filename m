Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18C745F4
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384233; cv=fail; b=XV04IAXYTfn8Hjla0qGMFhKOG1/ufx9HQ7tZItf52Gc9OFRHEwcFqfTLLuYPrw60Cjoo3M2xfdwhEHpJp4CJzGrDg3AZQcEaxkhPvTlACU50+cpySGkLMky6bDI/rpxNne3wdZ8uFxSTefe3Iw5BWQ6mA/v1nq+YqIFDv5aHDlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384233; c=relaxed/simple;
	bh=v1Ha7Nk9IAAaHZN4c4ApXBHwKRQc+DmifmRv8tL4ltk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o90nUR5skXONGLOK+KDsM2CC1WiwfAT/GxuGuVUNIOifrna+wfqRKRw9UX2gRcKMFrWdVowcS+zXrFMd1wQIDN0YWjina1Rpyzs5xHdC0fTCwMbUcjquC3ipQk80Z1CqVoYr3Kb1oy3dG6X3nAqwVo6n18b1mMILHAqxvhc+Czc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tj3zVhGM; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tj3zVhGM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0BB440DDF
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 14:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.104
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Olyd5oUoBewS for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 14:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2414::610; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=feliu@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B527404E5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B527404E5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tj3zVhGM
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20610.outbound.protection.outlook.com [IPv6:2a01:111:f403:2414::610])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B527404E5
	for <virtualization@lists.linux-foundation.org>; Thu, 31 Oct 2024 14:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXS5E37XpkJc4zdDH0TNhl2ZsYZC4kPMXT2CohkZpShrUPtgnOXU9kiKWPCGp/augADbcJjns6zpn+pVFJQSA65OT0Bps36e6gXf/lEDY87JyemZio/AQYew3bnbk5QoO8T2AEWwvt5pPOWmZOWaJ4gWkPEUnEv3ly0nmpnJYxGZYlywPB3WNw3tNxpas6FFLVgndAnn1dcWKW/Pfgdpgg5cyRxAJfnwgh8uBShRQxUzzZV6XV97BCMp6B5+nHu8k3S0IIPjuXNmjK/TGi1DQgNthJLDhoVL+eDp8UxevduDMtBQCt5f1RJCnCqLKXmksETQ69rb7Fqc+ZNXSUG56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwCsbxDiiIn9vDySe2kC5E9Ts81hfhppzknxGAjAOd4=;
 b=SikNOeIHlxe3AGUKFprmJAuPm4n99ukxEw0o5tmutv8S343KhP1XstFnrAAHPfd9Q7rgHqIaTfBAiUoMYP4rDdGLnzhVb0cUXJ3+25hYccRd2fDvSTU71oI5bSJ6CxAK7Ry5Jg8IXKIx0+w0fO7cZXBmUB4l9y1sHadJ/wj8xRECmQxhNqCjp8qaKYlVZtylTzqencyVz+gXVIf36NbVM4JeIjNTRTodBCEyd9DJrq2YCGrG35WEGJTM/LEn7V6Vee/BbZuBejOkS8tUdq1/wF1uEuAP5ybLU13txm9awgLnNDGE7M4hSKg4EXRpSkY9dR/4GefnOXqqoc4ND56wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwCsbxDiiIn9vDySe2kC5E9Ts81hfhppzknxGAjAOd4=;
 b=Tj3zVhGM8SIlz/mz3Mr+zyxJ1iWKtwqul4ObN91/9d44EvYbhw0XsXWjF2URXsbLQB4xE6BXfeMIYCq0Mk1nU4TDzYSr6k6m+vab7VNtZ784xSwUaSCMFAMBK1r/FiQkZ2tcXRca2czaLdf9LEHBb7AMv6WEDSzPlnz0UgrthuYvwxxxgIVA6DyXlVkhhUB0V1J2osXAB6BhvbGMTjdVwfnIkK2O5ZMNxUP7bXTnt76FREtp71cF0BQGiLRLmNQhNqny8zepMK+lFL93rdb4SwSQFGX/PDm5PHhpH1WOedfETVw+BkuI75/FScYEpaUqeMb9QKKoyt/WeiZ/n6RU5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 14:17:03 +0000
Received: from BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065]) by BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065%7]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 14:17:03 +0000
Message-ID: <5045b28d-32e9-349a-fc4d-ae2a995437a9@nvidia.com>
Date: Thu, 31 Oct 2024 10:17:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio_pci: Fix admin vq cleanup by using correct info
 pointer
From: Feng Liu <feliu@nvidia.com>
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Parav Pandit <parav@nvidia.com>
References: <20241024135406.81388-1-feliu@nvidia.com>
 <39714b40-28d4-91d8-774e-9c8d91461d28@nvidia.com>
In-Reply-To: <39714b40-28d4-91d8-774e-9c8d91461d28@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To BL1PR12MB5825.namprd12.prod.outlook.com
 (2603:10b6:208:394::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2645cc-c06a-428e-fb49-08dcf9b6b15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2doWnIxdjdSczk1UXFvYXVNTXB1ZUVCK2psNjd4dGQ5dmpUNlphUGYzREZD?=
 =?utf-8?B?MUIxTzBKWElXRUFTekw4OGdGYzFGblJuTjVHMDdHbmpaQklBTkdZTG1rMXZl?=
 =?utf-8?B?c1JUM3RZdE4zQkF6bkYzcVNZdHNKbXRweHhYdEVXN3BRcW1FQ0NrVjd5RWxD?=
 =?utf-8?B?VkMzVDZzWVhubzFkR0IrNC9wWnRxRjdzdnJIOXZYWURKdGFqVExQcVFMUVFJ?=
 =?utf-8?B?ajBjaUl3Zyt3UmtYWmpLbmpQaXg5bXllcDdhU3FxdVFwNmY3bnZWM05MWFhY?=
 =?utf-8?B?TFRzYUwzeUlQM2hBTXlXSFg3Q0ZROGZIVTVVUE9xK2wrOHd5bWI3M2g2Wk5a?=
 =?utf-8?B?ckxRK3N4azJUWmE2TWo1bEhIQzAyOEpaemhtbzJ6NGNBaHFWZ2lOZW5xL0lx?=
 =?utf-8?B?WGdOcGQzbzlnNmxFNkdvQnNDUEExdDdDcGNwdHZKcHkrbGZGSk5LOW5LaVNB?=
 =?utf-8?B?WE0xL0h4eHliSytGeGhXemtMQ1JoZS9RSkJZT3RZNlZJditURG9JWGtXYWdV?=
 =?utf-8?B?ZTF2MlNPTFBwNEdEYmY5L0JJdWZPeUNtODVIdFJXaEhxL0tqSzJzb0RpU2pZ?=
 =?utf-8?B?eHJmUGJZWHhzc2s1MjhCSE5nZEhqa05KdEVoZGtGYVlMSkxqWE93Uk1Lc1Nk?=
 =?utf-8?B?K0t1STdoQTZ5WXZWRVVTbzZGLy91TXJnUVluc25OdDh6MDd6YkFWUHhGdEJy?=
 =?utf-8?B?SElwMGRLdGNyM1RoQzRDTVkwZ2lZMlFnSEt0QVJVblhhNjVMNzdqVlI2Q2J0?=
 =?utf-8?B?M2Z2Nm1XRzdjYzg0RVFlc1dEQkEyN0o3ZkNHdGlEN0hZVnFza0l6SVpBTnk1?=
 =?utf-8?B?eFZFWlh4aktlOGc0RUNLSUNpYzZ2UHRvMEJGZFY4MUxGR21pdEllbnJLNDUr?=
 =?utf-8?B?d0xWdXlrdDR3SCszYlRwWlRuR0xzRHBkMWIrazBmYzZ0bFVPeDdUcDdOQWtm?=
 =?utf-8?B?Titpdks5QnpFZUk0RXp0V2JrY3ZjQldNVCtVbytOKzJFVEFWKzBtSmVURVZ0?=
 =?utf-8?B?dmRCSTRaZkdaNlFtTEM0d3JVd0hLS3V3TklPZm4xY0FEVVhadmtza0N5eXYz?=
 =?utf-8?B?enNhYTNFeGR4YnBrU3JDaEl3SklRS3ZleS9sQnllbmZCSmZDUnV6emxOSDlW?=
 =?utf-8?B?eDNIc1hjQmdDaUU5S2FKd2Y1MUcrRXJ2L2lEVlEvdkFnTGk5WE5oYkxHaHVT?=
 =?utf-8?B?RWdnU1F6WEZqQ0M2dU40bnczR2pUQ0VEUDBhT3F1QjY3aWU5WGdBSU5wOW9V?=
 =?utf-8?B?cFhSTHIvcnRWSjRMR0NwMXdJdlZYcFpzVHdod3FqL0pVWWpGaW5QTkxNWjhx?=
 =?utf-8?B?NTRtb2xaYlJyY1ZXdGtVb2dDSEI5UTNLWEdKY3pHcDdTSHZFcUYyaFl5cVRE?=
 =?utf-8?B?QlRBbWFFbENpcHVHWmljN25jMkhKcjNiSmtUN1NiT3Y3TjlNS0dFZWtNeG9a?=
 =?utf-8?B?SEkwTFZmZHFtaUNoWjNFZ2F0TXlGRkJOKzhqMVhGNG1JM1FQenIyMUdrbFNx?=
 =?utf-8?B?cUlIOVplcDhQQytWb2JacDBQTWM1Lzh2dW8wZzZtSFN3OTl3ZDNLWW83OUZz?=
 =?utf-8?B?ZlJwa1NNUk9mYm9YRXNlMmtsYXkwWDI3aWM1RE9wTU8vU2k1a3ljK1VGOC9y?=
 =?utf-8?B?TkFEOXhSL1hiU1hBNDNnaU80RlBpU3l2RjhGdVZrbVdNRlZpcUUrcEY0MXU5?=
 =?utf-8?B?RUpCcG5UZkZCcUdtMzQveTFkblJqT3lVd0lTR041c2lPRlFMdkxhem1IZWRs?=
 =?utf-8?Q?h0PqXbRnp/gs1hEFOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5825.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtTOEplaE1mUkFBeUtVWmkvQUcvV2pIZmZMWU84RXlVQ2FHM2lZNHIyL295?=
 =?utf-8?B?cjNqS29SY1NMaFkySlhNYXo2UjBFTmFaVTduVERIbk5pR3U2S3h4NXdkblpp?=
 =?utf-8?B?Q2R1SUQxSWZHS3lHbEVLZndXL1BLOGdWaFRRYWZyeTNxMjJqZy81TEpEQUdB?=
 =?utf-8?B?bjhjc1R4RzlPSEE4eWRxSG5zb29Oa1JxR0tWdmw5UGxDTEphVFpDUSt1VXNp?=
 =?utf-8?B?aTFWM2dOZ2dhUkNDeTlvTzlNMkxua2kyNFppVVRZMy9XcmZuT09qMkRIbFNq?=
 =?utf-8?B?Rnh2dDNLamVoWEVSU3RKWkE2bzhGSFpTYVNiUzRGNWhWd0xaL0RobkxsUWRl?=
 =?utf-8?B?eDhleU9xNXJoRGJEdWYxZThRc2dwcE1Ra2EzZW9CWHMwbC9wNUdQWG0vQXor?=
 =?utf-8?B?dW9uT1VVK3hxbDFrQ0p6MHZadGRCM21HbVJSenRTOWRZSkZDdi9pZFJ0b3Zl?=
 =?utf-8?B?b3lKY1JPMEg4ZmEwSWdnQWxWM3J0VDYrR2FDcXlydFBHSTBFN3ZreG5VMXNC?=
 =?utf-8?B?Mmd1QkwwNXZTZFBhMFJqVjNrb0VNelQybXV3WU9Wc1pwdFQxbGlKblpMbWFt?=
 =?utf-8?B?WXYzZ0xleE4xblArejlGWGlRVExVY1VtWlM2alIwNGZzUFlIYnAxMjZxVkxu?=
 =?utf-8?B?TGdiRDIzMTBZdnVFbHZRelgxR2RRSTk3NmJuTkZSMmY4d2tULyszSldIamNU?=
 =?utf-8?B?TU1yNzB1SWQxeHd6TnYzT1B4QnV2K0lhTFhUS2hsbkFlWmNmUE5tRm1hdkFu?=
 =?utf-8?B?MlVQY280T2R3d2UxYlNZam5VS3hORmJtMGhObXc1MUJwOUQ1bkE2OExEdVNo?=
 =?utf-8?B?SVZwZGI3eWJUcEVkMWdhM05ob1lrSWRxZDdPSmpIaW10Mk1WRFJOdEJicGps?=
 =?utf-8?B?U0gxWGVxaWhRZk8ya0tXYlJWSXhaZFZMdmY0cDV3UjBzRkp4Wk52VDJSdmV6?=
 =?utf-8?B?a3RuQlhyRjkzdzJMMkI1V0NHV3lMQklmTTBuNVFjYW5ZbHZGamthQ25McHhY?=
 =?utf-8?B?RWVjaDZqWDJuUWxQL29qeVpFUkVJWXJVNDB4YzgzcWtBVDB1YjVqMWJaelpQ?=
 =?utf-8?B?QkZjZjFRTVVIT1p6dzZzNnFuY2kybFJCMU9zTDNLM3VnbW5VTDRKVFFuNFFa?=
 =?utf-8?B?SkUxRWdmVjRqTVFQNFBLOVE5dUxqa0FwbDdJQTlpMm01MXkzaFNHc0VJVEp6?=
 =?utf-8?B?K2xGUjRoT3FhdTJmV1hwZktTQ0dPbEV5RTJtWW0rZUF5MGRtenJnbSt6SXVR?=
 =?utf-8?B?K2F0NkZMeEV2ZkpYNUdKNVRWMnYrKzdjaUdJL2oyL1kvUjZ6Wng2bHZ3K05X?=
 =?utf-8?B?T3FKLzU5ak1GWWZzZFFMQ1M3SzFjbXRLUENiWkwvUjdVaDhWWEZydlhEVVdV?=
 =?utf-8?B?Ym9qMGJoUmtrYm9LT2M1WVhicVAxdTcrcWhsTjZvV3dIdFp2U205Qk4xUjNP?=
 =?utf-8?B?c0lkY1BBeFhMaGVNSEhZa3d1U3lIQmk0NVg5YmpqMk9TaDlYM1VWU1BnVjB4?=
 =?utf-8?B?Q3J4dzA5TzVjYWNoVERKNldmY0FtdlpwWTBteHh3YnQrY0NGaGpxVVV6RlZl?=
 =?utf-8?B?eWVGRVlIZ3lqakkxN1VZaWowZ3ovejZkOG5US1E5WmhwUVJWVDFSRXpPQ0RS?=
 =?utf-8?B?dTRWMjFtZGd3cllmVlVVZ2l4dnpOSll0U2lGK2tjcSsyVkpWRXdrdlVORHln?=
 =?utf-8?B?aS90Q1B6MTF1aUZQNk9MSloyV0d5S3lQT0tESEI2NDMrVDhreGRoekcwTEFW?=
 =?utf-8?B?NndKN3ZSd3BnaU1nKzVQLzBSNGxlMGI3WVAwUVU5UnBLRy8xQ1FpUU5peVBs?=
 =?utf-8?B?UjRsSVRNdnNKOFpHdmlHY1lQNHdXdTJLdGJDVDJsNWlZcGZWc25YdFZTU2VR?=
 =?utf-8?B?SmU1T0o4cHNxQVR2SC8rSXhKd0VnUjFWaW5Dc1lSMW5YRS9iQkt0Z3ZQNW9K?=
 =?utf-8?B?aEFLclNZbDNYN01FUlIwOVQybjhyT1NNMjZKWVUvZHB4NTJzQjRhOGpESXlp?=
 =?utf-8?B?RndoV1RHNmhrajIvVVBWQzVXSldXUXBUVFFvRnExS21QOEZyY3JGN3VkN0h0?=
 =?utf-8?B?NHpwR2EwYzFiSnQwekxnSCtyVzVsTksrV2s5UHNYaWI5ZmlMK0ZVTGdOK2U4?=
 =?utf-8?Q?OT0HOyrIazxsUFasIhq3JPhpx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2645cc-c06a-428e-fb49-08dcf9b6b15f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5825.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 14:17:03.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSsp6L1i0Hi8mSBbZsC9RckDCWPsp96CW0i/IWDoOT6dUG22JRPPnHpe8BYQuZwC7FRUq9+yG0ZzZt49oEJZ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205

Hi,

Excuse me. Have any comments for this patch?

Thanks
Feng

On 2024-10-29 a.m.8:17, Feng Liu wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi,
> 
> Any comments?
> 
> Thanks
> Feng
> 
> On 2024-10-24 a.m.9:54, Feng Liu wrote:
>> vp_modern_avq_cleanup() and vp_del_vqs() clean up admin vq
>> resources by virtio_pci_vq_info pointer. The info pointer of admin
>> vq is stored in vp_dev->admin_vq.info instead of vp_dev->vqs[].
>> Using the info pointer from vp_dev->vqs[] for admin vq causes a
>> kernel NULL pointer dereference bug.
>> In vp_modern_avq_cleanup() and vp_del_vqs(), get the info pointer
>> from vp_dev->admin_vq.info for admin vq to clean up the resources.
>> Also make info ptr as argument of vp_del_vq() to be symmetric with
>> vp_setup_vq().
>>
>> vp_reset calls vp_modern_avq_cleanup, and causes the Call Trace:
>> ==================================================================
>> BUG: kernel NULL pointer dereference, address:0000000000000000
>> ...
>> CPU: 49 UID: 0 PID: 4439 Comm: modprobe Not tainted 6.11.0-rc5 #1
>> RIP: 0010:vp_reset+0x57/0x90 [virtio_pci]
>> Call Trace:
>>   <TASK>
>> ...
>>   ? vp_reset+0x57/0x90 [virtio_pci]
>>   ? vp_reset+0x38/0x90 [virtio_pci]
>>   virtio_reset_device+0x1d/0x30
>>   remove_vq_common+0x1c/0x1a0 [virtio_net]
>>   virtnet_remove+0xa1/0xc0 [virtio_net]
>>   virtio_dev_remove+0x46/0xa0
>> ...
>>   virtio_pci_driver_exit+0x14/0x810 [virtio_pci]
>> ==================================================================
>>
>> Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of 
>> busy loop to wait on admin cmd result")
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
>>   drivers/virtio/virtio_pci_common.h |  1 +
>>   drivers/virtio/virtio_pci_modern.c | 12 +-----------
>>   3 files changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c 
>> b/drivers/virtio/virtio_pci_common.c
>> index c44d8ba00c02..88074451dd61 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -24,6 +24,16 @@ MODULE_PARM_DESC(force_legacy,
>>                "Force legacy mode for transitional virtio 1 devices");
>>   #endif
>>
>> +bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>> +{
>> +     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +
>> +     if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>> +             return false;
>> +
>> +     return index == vp_dev->admin_vq.vq_index;
>> +}
>> +
>>   /* wait for pending irq handlers */
>>   void vp_synchronize_vectors(struct virtio_device *vdev)
>>   {
>> @@ -234,10 +244,9 @@ static struct virtqueue *vp_setup_vq(struct 
>> virtio_device *vdev, unsigned int in
>>       return vq;
>>   }
>>
>> -static void vp_del_vq(struct virtqueue *vq)
>> +static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info 
>> *info)
>>   {
>>       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>> -     struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>>       unsigned long flags;
>>
>>       /*
>> @@ -258,13 +267,16 @@ static void vp_del_vq(struct virtqueue *vq)
>>   void vp_del_vqs(struct virtio_device *vdev)
>>   {
>>       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +     struct virtio_pci_vq_info *info;
>>       struct virtqueue *vq, *n;
>>       int i;
>>
>>       list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
>> -             if (vp_dev->per_vq_vectors) {
>> -                     int v = vp_dev->vqs[vq->index]->msix_vector;
>> +             info = vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :
>> +                                                 vp_dev->vqs[vq->index];
>>
>> +             if (vp_dev->per_vq_vectors) {
>> +                     int v = info->msix_vector;
>>                       if (v != VIRTIO_MSI_NO_VECTOR &&
>>                           !vp_is_slow_path_vector(v)) {
>>                               int irq = 
>> pci_irq_vector(vp_dev->pci_dev, v);
>> @@ -273,7 +285,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>                               free_irq(irq, vq);
>>                       }
>>               }
>> -             vp_del_vq(vq);
>> +             vp_del_vq(vq, info);
>>       }
>>       vp_dev->per_vq_vectors = false;
>>
>> @@ -354,7 +366,7 @@ vp_find_one_vq_msix(struct virtio_device *vdev, 
>> int queue_idx,
>>                         vring_interrupt, 0,
>>                         vp_dev->msix_names[msix_vec], vq);
>>       if (err) {
>> -             vp_del_vq(vq);
>> +             vp_del_vq(vq, *p_info);
>>               return ERR_PTR(err);
>>       }
>>
>> diff --git a/drivers/virtio/virtio_pci_common.h 
>> b/drivers/virtio/virtio_pci_common.h
>> index 1d9c49947f52..8beecf23ec85 100644
>> --- a/drivers/virtio/virtio_pci_common.h
>> +++ b/drivers/virtio/virtio_pci_common.h
>> @@ -178,6 +178,7 @@ struct virtio_device 
>> *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>>   #define VIRTIO_ADMIN_CMD_BITMAP 0
>>   #endif
>>
>> +bool vp_is_avq(struct virtio_device *vdev, unsigned int index);
>>   void vp_modern_avq_done(struct virtqueue *vq);
>>   int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>>                            struct virtio_admin_cmd *cmd);
>> diff --git a/drivers/virtio/virtio_pci_modern.c 
>> b/drivers/virtio/virtio_pci_modern.c
>> index 9193c30d640a..4fbcbc7a9ae1 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -43,16 +43,6 @@ static int vp_avq_index(struct virtio_device *vdev, 
>> u16 *index, u16 *num)
>>       return 0;
>>   }
>>
>> -static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>> -{
>> -     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> -
>> -     if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>> -             return false;
>> -
>> -     return index == vp_dev->admin_vq.vq_index;
>> -}
>> -
>>   void vp_modern_avq_done(struct virtqueue *vq)
>>   {
>>       struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>> @@ -245,7 +235,7 @@ static void vp_modern_avq_cleanup(struct 
>> virtio_device *vdev)
>>       if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>>               return;
>>
>> -     vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
>> +     vq = vp_dev->admin_vq.info->vq;
>>       if (!vq)
>>               return;
>>
> 
