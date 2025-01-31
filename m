Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED11494CF
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310267; cv=fail; b=Qddb+gdLvnHP7QJR3gszLA5+hiM1+s+BRbUnsOLB/PZy/2hjznI6aGGPAEYJdycu15txKTmA8B+WGy8V3PcJqd3ZWdrewyLj58HdJHZ9gRLfvyhoERxyIVqI9aAk9fEj4U76azZWt85GjSB1gz3dycTI+NGZddOkgzaV1D23ACc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310267; c=relaxed/simple;
	bh=r4AQoVKfYFtmEAvIfR7XPtr2qGe0lfcpGLllBKDr3VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mo8+ID061r0q7HdSChmxrrkz6OjcCGCZdXzz9eNdqntt15PIy4xtgGZlTNAYsTW0QVy/WvaF1+mRWw++VmU2r4lBvPEFHg9Ea+/tXNxowlFNIywirwpoa2IP7WFe9MlnLaDo9I7uiPL3ju/9jthK44IxYb6PshxVkJ5lR4S7hOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgSaxu+L; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgSaxu+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akRXe8VzrG+DkrCFaSnA0ms6/4RC147NFBr0H6oWsmyumPH3ICWejBb3LeC2prCTKRtQViZ6VHRWkTdkuq4QPXJe5ThMVpwydqkSmsjhA+pWUSmkebJUDdpHtE+HAkMwUs1l80ga8lbX0wiEuhYIeMrzz8xzXX+1k86HJZ74amNNAY4/FhvSVS1k1ccwAWqkhI9oGdq5qMmClZcK5l7a/fFL4DYDsgfxgwJFXYH/CGeQGzEyJ6bTj6Kw6w/plJx7Jdf6jaIJ/baBlEmKJ5nBtqslrfX/lwYhPRIC2ffPToNSPRggbAz3s/Ypvy5GT039OZtz9g5WooZEUBqfKMAG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7QaVr0fCpzedj+C73ifSElQ2W7nsycvuopnOQN5eqo=;
 b=pl1NvbgsT/y7ZVzxdE3iOW3/z2diqjwZkyXr96+m2qrlYojj4fzZ9NceaRlGd1xNjJ2e9SNbQyQLUD/25HFVu0eFW8sBvXeR+iJv2C8qF7INviAciNvAo2BOz2IyRP1Rre3gpqajgUar/G54NJN6vwJR7s6xyEahb/xIXTBj7kzFwWJrc+lshY2uU+MUqy4ZIu7zeGC+J2FbogysdzWc2n3mR4v5x1XS6lVkoXKMsc7Tz/UIDSb7rxd+AXA+uU+354WoLLiB0yO5rR6kSZePeedlpcibXjJ1l8BZf6QBGv/XVWOUnLpWBaFDMjYRQUgtGm+7kr40tLe4IR7P+uVpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7QaVr0fCpzedj+C73ifSElQ2W7nsycvuopnOQN5eqo=;
 b=lgSaxu+LRLsfLXW7+TnCrTb/Ln4VT/0HeYBqegrzfWBZienLtWRQyzBK40GdpJJA2va8fxsUxW1Q6MpnlQRurO5uOruvYrJJrdqm1US5yO0oFEok65tmmpc+BiVnQ6b2hlSTQd0my59PwbIG3vW8TO+HIvLTS3wgT6PrX4XPPFGz+WT/yoHgpnugoSaA0wmBSJFDbvKk7Fnlm4pyH4l9+3aZCrlyjCh6IfmI/mlVvuKnwBzL4uY+6uGokJ35eY1Id0V5Mf6MMh+87TjMb29evNUopwEAFvFLvHHlWz3VBNQ1GKoJyAWV2x7yzBJbk1ps4Gl6lnPyBX3sjq2I/OlurA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 07:57:44 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 07:57:43 +0000
Date: Fri, 31 Jan 2025 08:57:40 +0100
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on
 big-endian machines.
Message-ID: <klvpj7l5tbrwpjxfch7rgy2abqxbi6riuhvoxgg6whbbjgrf5q@wkaamsogcp7e>
References: <20250130214337.12881-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130214337.12881-1-kshk@linux.ibm.com>
X-ClientProxiedBy: BE1P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::16) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: e37c531b-a3ef-4c02-5eab-08dd41ccf15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXZGMCt2OXFXWk5IUU0wbExkN25JeDlidjNoV0Y3ak1PRzJ4d21tRnhvUlJI?=
 =?utf-8?B?OFhoVERvWUR5aU1YNjVacE9zVHhjbjc1dWlBejB6RWg1ZXBRbGhBKzVDSkFy?=
 =?utf-8?B?YnlnK0piM1BNZDFHWXlxdWllU2NqeGtXaWdmbUp1RHZMY1Q0U0xQNnFSY3B6?=
 =?utf-8?B?aGNUcU9jMmpwbFZrd2F1TXgrOGV1eFM5NDdXTytOVTYwbzloeFJaWU1YVSsz?=
 =?utf-8?B?dU1MQjZseGpJVnNEMjh3eTVFOVdPRlh3R3ZGR2FpazZqcGxlaktCNU1makt5?=
 =?utf-8?B?SDltNG04UVFGUlJvYmhtOXVjcUtTbkxKdTBHVHpqUHZ1MDdreEJDUno5b0Vo?=
 =?utf-8?B?UzlMT0tPdit5TlNWb2pzSmJFbjRpeHdzMlN6UmQ5WlppaFc1RWM2RlJrVGlq?=
 =?utf-8?B?bzJTY0RQYTl5dXRoWmlUK0l0Zk5lTnBYLzhkQVp6akZ3N1V2cW8yT05MdFRE?=
 =?utf-8?B?anRZVnhmcGF0dDAyUkVCZGlDL0lkSjZZY3ZkeU9wekE4dnBnUURpOHNSVUsx?=
 =?utf-8?B?dzVSa0VhMmF0UWwvbEIrUnZCMEl0VUU1NkUxMjJpd1M3dkhYSDI5TmdBQ2Jr?=
 =?utf-8?B?MUpBY2cxU0NWejltajMzc1pSK3ZIR25vbmNTSmZKMlh1d09xZkRsOVRxaGU5?=
 =?utf-8?B?d08rMlcyVXR2T1F0UkVCSSs5d3dZOHNMRkNmQVZ6RFFHWFZueVovMFdyTHR0?=
 =?utf-8?B?N2ZXeUdid1FWcmQwbUhGTzBPNDNRcDF4d0M4OWRlTnpMK3ZyWkpBalc2LzA0?=
 =?utf-8?B?UXN5MENaMzhkalltV1g0dktsLytkZkNKZmVLMTJBTjN6QXdIM0Mva0hhd1Jk?=
 =?utf-8?B?KzFOM092djZGQ2VpVGplTnFTUC9KUGVZMlZ2VzhxbTZnbjdTVWgraHdYallt?=
 =?utf-8?B?dHFkclNVcGZTV3dJQ0lSWDVjRkFWRUx0b0xhMWhrYWU1NTdPczJCSGk4K3Ji?=
 =?utf-8?B?MEsxRS8xa2dESEtSdFkrMFI1cW8xaFY2WTQ0UU5JVXRWcVFlWEt4K29Hbk9M?=
 =?utf-8?B?SFlJNHJIVFoyWmtwZEwxQVN0WUxIMlhGVjF6MVRxZ2hJWDBzdFplR2FISHFF?=
 =?utf-8?B?QWFOVGtEYVZrRjdSRElxM2VyMWQzWGxvNmRxRjR1aGN5UXdlb0ZlTXo0Uys4?=
 =?utf-8?B?Rmw2UlcvckduRVo1SzhDMjIwQ2s5SzNmckJ0Q3djZURTZDRhY0J3YkxoOGwy?=
 =?utf-8?B?OWI5Z2FJalFOUFkwWVV1ajVYVTlUbVg3TlMyL0pOU0ZiYWZsVHp5UmJzdjNP?=
 =?utf-8?B?WWVPVmc1eFRzdFlVVm8zVDZtRVh2Y1Fabk9taDM2Uk5iUkxvUGxYUzIzWmVW?=
 =?utf-8?B?OXlGNStlOC9vVG0zQjdjbjBVQmlDTU0xMGNYalJvTHc2S2VZNklBZHNWSlZj?=
 =?utf-8?B?OE1GQzlGSWZkanBnSnlkTHVPYjQybzRhSlJZSmFTV3I4TkdtdWtPUDluSGp4?=
 =?utf-8?B?TDBTRThqSkF4RnhGNWQrTWVBNWFJTWFWQXg2KytsODZ3c3FRaGdJeDM2VXRW?=
 =?utf-8?B?ZU83a2hPQi9JYUpmVmZMQytoQXVuMXgrMVFVWlJKNzhpNEQ1WW9EQXdnd2VV?=
 =?utf-8?B?NzZ0MlpncDNDUzJPZlFiL2doYXNJcDRleU05N2FwdGpsTnBEQ0FlZHBublV5?=
 =?utf-8?B?UzFpVDIwTnlnSHBiR3czZ050VHpWZFZVZkUvVUY5eW9ZaDZXak1GWG5HSUh1?=
 =?utf-8?B?NitDTVptL3NMTUZ1MjJBVTNtZFFYTDl1dFQ3bGZFSWpWUGR4U05yZGZrRU5V?=
 =?utf-8?B?SlFJQ0F2aTJ5ajZzSDQ4aTgxSE1yRDJabXQ1b3A3enhtdXB3ZXE0dkJEK1BF?=
 =?utf-8?B?bVdlMitUOUtoLzVXeUVsRGJxR2dvdGlEVzZBL0oyYS9pZHhSVlFwWWRIWEhL?=
 =?utf-8?Q?+3qBnc8ebRGLG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZPaFEwRjRpcysrUVZoTGxOVU5URThjSjgrakthdjY1cnhHSnh4Z2tnT3FT?=
 =?utf-8?B?WnpkWlI4aGJ3STc5YlVkQnFmN2xxOEl4aTJTTjIxSGlaQzV0QXErOHZPV0g5?=
 =?utf-8?B?bE5LdXBQSkMyUS8vM29Md1NCRzN5UnBhbEQ1R25WTGJ1QXR6K1JyN2NYSGpw?=
 =?utf-8?B?WktTaDVkVy83L2Zyd3pjcXN1TE5CZGxOY0VUNFU5bExKZmN4NFpHWlNrTVI3?=
 =?utf-8?B?SDdpaXVpZ2NPV0RRNm16RmJJdzNPdEFxdE13VGxmTXV3aVgydUdLcjE1VTJE?=
 =?utf-8?B?bm50YXFtaEJtdEpmYzQ5SzFoUDZlZXFuSExndk9nSHVZaktpY3JhK3VkY09a?=
 =?utf-8?B?bW16bVJ3WTVzemkyblVSVUpIVENJSVc0ZWZHaFRlUDZud1VCU05pRk96QjFZ?=
 =?utf-8?B?c3E4Um1vTDZMNDZhOHgxRkk1bzQ1VVFYRGdwVzNzWHZZbkVaQTFybTY5T2pJ?=
 =?utf-8?B?V21xdDc5ekNWVUFVdzY3L1pXTnVIbFExWWhhVHdDdnlDYWFkVWlUSGJDeGt0?=
 =?utf-8?B?Ui9paTFHbmN3dXRLQUVHOVBtejhkajNoTDRGWkk5VGdKSk9XdWtwUW5TQ2lx?=
 =?utf-8?B?UTVPb0hFRmh4NGRQdGk2eFFTUHhvVE5WL2MyYlY2OFlWZEFJQVlUYUZUa29C?=
 =?utf-8?B?cHJhQkxlcXFzYzVHQkJTSG03L1V1M1dsUnowU056aHlCSloyOEZJSlIveGl3?=
 =?utf-8?B?OVB2ck1JVlNNalBUQ2drdE1UNG1XVUcxY0lheFd4Um4veXdMb3U3cnk2bXRD?=
 =?utf-8?B?Njljem95Z0l1WnYzV3VzNEE0cFE0NUgxMWJsR3VLdFgvY2M2V2JxVnRrbXJs?=
 =?utf-8?B?VGFVL1dodWJ1NWk5TFZEazl1UGljTHZqdzVZdktnVFkwUHduVjRCUERHYml4?=
 =?utf-8?B?MWlEelhNYnA1R1MrZ1h5eUF4RkN0VGhaQXg2bDBaZW9LM2l0QXBNbDhPVHMx?=
 =?utf-8?B?N0l6elZsNkFOL0ZjTUc4NEVIQmc4OGZXaUZDQ2R1L1ZDTTBPNUhMZURhNzl3?=
 =?utf-8?B?TXY5aXd1WmlOd0pUbTdaRW9rZ0Jza2t0VkgxS3Blb0FlckZsaFRYQ2pmTFVa?=
 =?utf-8?B?MnRqSkFuYnExYWNUZ1dPS3pFUU1ocTQxTTAxeloxMEtCVzdVL0huT2VtbmtV?=
 =?utf-8?B?VndsWFNMOGdDZ0sva2tjU0l2c3BkajRsblhSWHFyd3RjSWJvSzYxZ2tqMmpw?=
 =?utf-8?B?eVgzbWxoRS9LZ2ZpWXFUY2FaUlhtdmJRNitaMnUxZmIybUgwZ3loenpXSW94?=
 =?utf-8?B?ckVnMFRhQWp4MnlTNHBBZWdwS1VhQUF2d0MwTFNUWWVuZ0k1TlNNOEVMSm5Y?=
 =?utf-8?B?ajBjZ0lXRm9BZzF6NlpiV1VRRHJ5WTAvTUZMQlRhbCs3d2o5RThFMnB6c0dX?=
 =?utf-8?B?bmJqMmpTaE5EOFpkcUhkNmc2TzhwTGFrWkFoemV4a1RQZG5keHZLclp6SkdT?=
 =?utf-8?B?c0lXM2NiTzJqdXQ2a1RvMEZQc3FERnp3dmkyVG03ZjdsemNvRzlCYlBPSEZh?=
 =?utf-8?B?UjU4cU12eXczZktTNU94cCtHRVRzdzYrSU9vMWRudkJldUxBeWYxcDU1RHhp?=
 =?utf-8?B?Q2l4TUI0aXhYaUlodDBjdy94ZWlyK040U3B3QlN3STRQMUFOOFRpMEpOU0dL?=
 =?utf-8?B?N0JNcmRNcFlvL0hxc2FOb2syamtWcUsvSWJrc3NFd2VlV3dZYVIzZEcwT05G?=
 =?utf-8?B?ZmtGNzBFM1ExRmdOdnJ4S3dHUDBwdnAwM3JiMkorb1ljZ2hYOE9TazZsQjhx?=
 =?utf-8?B?VmV4Si9XaUJRVk4vaENkQWlNTzdvTk1OSFpJL1hHVmMvdXhFY1QzbURDQTY2?=
 =?utf-8?B?VmF0ajVBc3ZKVkl2eVhjNGJoQVVyclJOVXVja2h2aXdZdk1QRjhYd2pWaEZP?=
 =?utf-8?B?c3kxVml0YTFNS0xrRGw5a3ZkUXJHM1dRMVVwYmNhMWNQQkdlVDg1dWg2OVkv?=
 =?utf-8?B?RG9QekVUNlVGYTZ3NWJwZWx2ZGwxdVoxaUdDZlpCMWhLWHltTS8xVEhpRWRn?=
 =?utf-8?B?eGhlZXpud2VXeE94M0NlYks3SW9KdnYzRmpHcHFaaGh5bXVyVEg3T3hUaVFa?=
 =?utf-8?B?bU9VYklqK25mZEl6ZG5KSFJvazVzVE9URDFhOVpkQ3I1ekNzVDQ4MFBoSkxn?=
 =?utf-8?B?cVBTb0ZucVlIZkhMalp1eXo1Mk91Z1VOT1Y3cXlvejNCL1BaZ3d3bUZmbnY2?=
 =?utf-8?Q?7U/uobfEqQMPTct9nGgEI2+PHa7SY3gWuxDEelon/ANU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37c531b-a3ef-4c02-5eab-08dd41ccf15a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 07:57:43.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lAceA6qNv+N8AP9NduAzIK5WIdrWVcljpvhYjW9Li+DIs7yPYZBXkbmm8HJWbqolnMQPwUAFgKxlbsWGagveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195

On 01/30, Konstantin Shkolnyy wrote:
> mlx5_vdpa_dev_add() doesn’t initialize mvdev->actual_features. It’s
> initialized later by mlx5_vdpa_set_driver_features(). However,
> mlx5_vdpa_get_config() depends on the VIRTIO_F_VERSION_1 flag in
> actual_features to return data with correct endianness. When it’s called
> before mlx5_vdpa_set_driver_features(), the flag is clear, and the data are
> returned as big-endian on big-endian machines, while QEMU interprets them
> as little-endian.
>
Good catch! Thank you for the patch.

Could you add the clarification that mlx5_vdpa_dev_add() uses the
endianess helpers (cpu_to_mlx5vdpa16()) which depend on actual_flags
being set properly.

> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 36099047560d..f9ea240b8145 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3884,6 +3884,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	ndev->mvdev.max_vqs = max_vqs;
>  	mvdev = &ndev->mvdev;
>  	mvdev->mdev = mdev;
> +	mvdev->actual_features = device_features;
>
Maybe it is better to be conservative: only pick the VIRTIO_F_VERSION_1
flag out of device_features.

Thanks,
Dragos
