Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF9212F8A
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692963; cv=fail; b=X8ufvmhnJGwgFn9G/8OFVGzHy9ewevgOHb1XlM6QBGpbqepkIyAYdXjvEkthNabuwQMUr0REFiSaG/6bUbOlc1r6pHEX7CgGsohoR5gi2f+jA9i5ypFagZ1Pi3pHCMuPENXTEdP8GygX/XYStmr7/3U1zSOV5PRzjtd6wNWnDHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692963; c=relaxed/simple;
	bh=exJLRebdEIHvVKXGjh0wNQheiordSDKar0VkngX+3yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QulQmOcCxtxjX/2raP548LSVZEA9Fpwb9A13X38cCjX46bU9L1I93WfHQU41D2+CRTSHnFn1US51lx0aHIA5qT6V+KmC97nD4P8FLnT7ELgNc6JxSR1UJ3A9OtkAKKxdZVBwnIJ1I8bfPRCKqTwj/+4TWpNlZQqq8SAScsZYsBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmMWwNfr; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmMWwNfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq4ul1vx3F/0z3ZGaHWSFRK7B8hKAt9TERfm8d+de+SFWVnBcFr0nqgpgjVPyYIuAaI7YPe58ekTkhIC8jAcPqw9HPw+hnMCDc6wqYJUOz1Wsdcgi49Fan6DRIr5Bl3CiWvqEFuVyIqX7Wl3a6p4zIFNGr1DE5Mi15HbI9oCFfa6ogoYWWA4BmSWZF2VuDpqqm7lJGs6FY9QIDqWzp3RfIwExow4rVBbq6dHqhqp3bPEPzYIr/sQfz5uAh+a9BT/btZykThkCUKygf7eGe+mTQGDQO117Y0fDL0KDqvd7sfDYR7Yv30+KxqMqtnczT72wZv8ySpctNtunrbqRBFlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GADOLtWXC9GftEUnY4XGUxFPWnNoRWWjQeThrh2hA4U=;
 b=SPic3BmGbxrHSy01goCNT7r+GBvpaRI2J9VVU6JT1lePTWjuOXhWHXqu/Lv5ZbrKxfxwiC4lvSuUCZ2V3V1ATH1pi5NCSlJlGs6FpYpLhbO92gIxbYxRc1ggofo7QLJ+v3NeKFyYIE9mHoIyKSqRoo4Tmgj/Pa3tN82qMFOA1WdotXeod0DDJldue7FZXCPuwEOff3tdi/8nMuNHTg4lLfcAkwmTxXt0nYT7PzHfst2bR/bS4XRgi0EJHQWKa1Jp3cy+W2dskIn8CAQorPQAjcxUxTktmiMhNi3+RfYTqm9/orbZj44dePY27sb+Y4M3oJprc2dh8XgU4+W1rdlwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GADOLtWXC9GftEUnY4XGUxFPWnNoRWWjQeThrh2hA4U=;
 b=FmMWwNfr49RRBJ+XQ4+wH9eYL1t5DdYkzAmiCCr3CXBEOYbnVzJPHh4Pyq2f0LcJQLONGMdVlyt2XIXqHQzRvrgcgULbFLW4q2qShyUUm/tcqfuNc5TQUjbco+3FxXZz93M3s5qBQyVAJAslcUnvZ0XGik4E6GxuDqsgC2jQME9iKWzP0F+rUwLnec6UDfyNju/V06ENqHg3YGBVkQ4YB/tQX7awVuabGnYpB4FZm7EDdBzCKoMIDA97TDjH0ccoLSC+aehlskoTlRZHpgVZLSaOyZAqfGQYjLGpqV/IlWYCz18aQkAh/8oXu6n34gpI7dTyl6lVb+echqYaJ2LUIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Feb
 2025 18:15:58 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 18:15:58 +0000
Date: Tue, 4 Feb 2025 18:15:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on
 big-endian machines
Message-ID: <m34remjchz3recrui5zwhuthbwxl2fb5dcjzdhxuedrbsa6q5c@xshyty77q6ul>
References: <20250204173127.166673-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204173127.166673-1-kshk@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: bf613983-6473-4128-6ba8-08dd4547f943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3drK2VSRFFucEZ4L25iMWpDbW95c0paSFlVS3N2MC9UbFRyZTJaTGhVVHFS?=
 =?utf-8?B?dzQ1WDdDaWZWY1RmUEFPVkh1RDhXV1hLNTNkejhPcjVKVTh5a2tIUTlENFRQ?=
 =?utf-8?B?d2F1TW55T2dKelEzU1IwQjcvRGIxVVNUaFprOVdqRU92R0VMNURuSDhqR1ho?=
 =?utf-8?B?QXhwYWVqTHFJUmIwNUo5ODZrRjMxOFNlMExtRXVqcVBKYTh0RUNJaVBkRXFN?=
 =?utf-8?B?S3Iza3lVKzUzZC95NDVBYlFyYjFtQjRvYm01UFp0b3NxYVcySHZrOWdzUml3?=
 =?utf-8?B?ZmN5V01MaU9Da3p0UG1DSjRESVBsRG5Ibk4va1R6V0hGWjkybjg1Y1hROElS?=
 =?utf-8?B?MnJmdktQOG5kL1ZYdFlnYXplNDdBS0J4RGVpM2x1aDY2MzJ5T3R3Z3B1N1BJ?=
 =?utf-8?B?WWtBR0dRQ0s0UDNhWlZnV0pYdlJnYWlCVEo2NFd6UjFzbjlWNy9hR2hpeFJx?=
 =?utf-8?B?ZWZMQkJoUkUwUjNCNEZocWF2aFI0b2RsYUZGbmhFQkc5SklCVVpVKzdkWDN3?=
 =?utf-8?B?WkY3eWdMU1BuYkppZmtGV2ZOd3VZUTRzRGtyeStqMlUrQmYvbWE5bDVoVWo1?=
 =?utf-8?B?UnJZcHR3eGE1T29YYUxmWGVDWXRJU2hXK0tpOUJsNTFnOVdaRTVnajhQRkhM?=
 =?utf-8?B?T2s2OVM5VXdwNTFXZFB2d1VrdGJNYVlZTDU5aE53UVBpYWtlYjdDaDFubHMv?=
 =?utf-8?B?eWs5Z1FLTFN5U25NQUxYeWJYYlZQVmE2QmNLUDhsdXlWN25lL0VtaUlYWUxZ?=
 =?utf-8?B?YUdsT1p2VHB1bk0rQU1vMnVEYkdSSkliVk93UXpEOHRDVlcyTnMyNGtKR2Vi?=
 =?utf-8?B?R2F5cXB2aVpaVEFqK1J0Z2ZaMW1jZFFRQnY2QmFVVW1hOHRCaWtSR2lSV25M?=
 =?utf-8?B?aEEyMmlWbVhJZVZjL0R0QTYxSXRXNDJVMHY4M3VVVlBCRHlxTjF6VVg3cjNG?=
 =?utf-8?B?K1A1YWZiUFhYL3dMOFhteHh4Mmp4YUtzeWdra3RoZnM1Qm9JTzg5WVUya0hh?=
 =?utf-8?B?SlhJSk9HMTdRNmZ3ZzQrNk9JU2hWeEZxVkdUdlNBNGJwSmp0emE2cmY2UWNu?=
 =?utf-8?B?VC83K3hDSldtVVkxY2xzR1BGU2lnaXFUWmtieUpqNlBpTmdTK2R0QVkxeUlX?=
 =?utf-8?B?SEZ6eFlwMkIvTDQ1dnBpNnJ3Z0tTZlRMN0lMZ2hrVFhJek9vVmxYb0JuRzJC?=
 =?utf-8?B?V1F1MlNzclZNREEvOG94WXJPL25USkxTUlFFTVYvWkhKQ0U2MzUzLzhtRG52?=
 =?utf-8?B?VVNYWWlzdDZtM3ZJamZ0K0t0NUtTbFVlaVZueEdOcTIwdFBSaDQ0QkRrbGJz?=
 =?utf-8?B?b0t6UXM0cGNaaE15YktBRW9ZYkI4eXE5b3NOeEtmN3Z3Z04yT0xtbGMrRzJz?=
 =?utf-8?B?clNLMTZsdm83UTRkb2ZwY0liVGY4d2dtRWVRdEdENUVyMm9qN09FeElhUmNM?=
 =?utf-8?B?cHJpSG1ObzhXemg3Q2Z0L3VmRlBHM0c1K0l2NFhyeE1qM003bVBmb0xUKzNZ?=
 =?utf-8?B?VDc3QWkvL3JBcUFCMmZwZzlvRzh6c1VQZUJvU09BdCtGOWIxUHhXdWNMc3VB?=
 =?utf-8?B?N3IzQ2l5QzlXVWtFdVl2UUFNUW9yVjJRbmpjUzcwSUhEczVJMW9ZQWxnUng5?=
 =?utf-8?B?aW85S1ZUUXVaNTZLZENRT3IvRGEyeUd2MFl4MkROVjE4Rjc2YjJmNnhQenRB?=
 =?utf-8?B?WkZtLzBKLy80R0x2RVNFb3E4Mm5ZdUZLMnhWMzEyYUlsN2E5TmV5ajJDU3FY?=
 =?utf-8?B?cVJtNjc5MjEzb3JJUzVwNzVYVzlEMEszQjlvOUs3ZTJNZFlBc05Lb0tHK05J?=
 =?utf-8?B?OTJNZVgySEREaUV0NmxaZ0l5eXpiQzJlV2hYT2xVWnl1am9WeURLcUNBWCtT?=
 =?utf-8?Q?CkeX382qxVgNk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tnS2VVSEViZUFHUUltdjAxN1V5T1VqdmUyV1A1UGo5cUJDZVpjVE9sZGJO?=
 =?utf-8?B?TlFTc0VFclUyTitXQllGQ3RNczlmUHZnTWM5MllKTUl2ZFMwRkJwa25vVDRR?=
 =?utf-8?B?YnVHYWMzSWNDYWxNc0ZoNVZpL29HU01LcWovbHVNeTFsbDdKT2RBR2xaMGVG?=
 =?utf-8?B?OEd1Q2JFWmlWNUpTN0x6bW9oaU1UU2crU2gxaStmZlNKbjVkeTRmTUI2dWNy?=
 =?utf-8?B?K01QZVNSZFRWeUR6V3RYc21qWllwT3hJR1JBUzZSNlNGYVpReWQzKzJDbzA5?=
 =?utf-8?B?RGZCRmpZOVpiM0JKblR1TkN0ZlAyMjQwVFMvWXZyNUQyRW1uZ3gyaWlpYWg4?=
 =?utf-8?B?NnlqTWczcXpPUm05Y0R5bXJSZGpNV2hZTitySmFZZU1UQzZXdGVLTFF4bFBy?=
 =?utf-8?B?ajhwUG1Pa1ZrcmdITXh4blZpV1hzODEzWUZGcVR4VUNXaGxrRSswa0Y1cTk0?=
 =?utf-8?B?SVZjMjZDa2ZYRzBjYUR6NTJrdVBNNjRoVVl2Tkx1V05pZGhYbkZEMXUxUjFk?=
 =?utf-8?B?V1JuRWhKcEFpK0JLY1Y4YkJOUzZ0a3JDbytrYldJRGxiMEhkdmtSbHc5aXRx?=
 =?utf-8?B?cVZaNS94RktSVWZDcERSQmx5dWY5SGYyclRUSDU0RDRMQ1lMR1owRXphRy8w?=
 =?utf-8?B?YWY4dkJoK3MwQVJKem55RU9Mb3FSYkw0SkFKeXJDdVc0OFlyWTcyT0xJcHZ2?=
 =?utf-8?B?aGhSVXFLWGNpU1lmNW1BZTBBZ0g5TFA3bEFYSG1kM09hRnBJOFQyTFF0U2h3?=
 =?utf-8?B?RnJzZXM1ZUJQQXlTaVRPY2N4dWMzU2hZK1NjQzJxelRaT3ZpRGZvdUd2RWYy?=
 =?utf-8?B?NEltcU1WK0ZNNDZBbEdmbDZsY2RDTVB3d081cnBKWmtYczhZcThDSEs0MjBr?=
 =?utf-8?B?UEx6eFlyRC8xZVJRL1c2TUlhbDJrWWo2SEt4c3pTanQ2QVRpbDVlMG9zUXJ0?=
 =?utf-8?B?Zi9lY3hXeVNNV1FhUEpvaWtiQy83NG1zaVlCUmpNck9TOVFaK1pOM3IrdFRk?=
 =?utf-8?B?OHQ2WmlRdVh6T21pT0Y1MFBSNmpHSWJlMFY3TmdDK1ZHb09FTzJBalpYSUVQ?=
 =?utf-8?B?dEl4OWo0ZnQyejhQRmVhK3dNOFB1eGs2UWhXMUVrYTdtdm5OSnIwQVJTNzRr?=
 =?utf-8?B?ZXREQ0pLcFlDdjl4bkZzdGNJSUNBbHhsNFJqQWpqRHNRc01YeVRIZEdwWWpM?=
 =?utf-8?B?VVpsbFZ4S2lxdE1vSllma2l0S2F1RWJ1a0JxdGpjaDZMQkh6RWxPRmw1WkNy?=
 =?utf-8?B?b0wrUlIrUDB2ckFsRlJOc2w2UVpmZlBQaEpGdmE1dmpEZytmVnBLODZpcTdM?=
 =?utf-8?B?ZFJ1TkhKVkNJaHJsOFdsY2p4SkszL1psVWxEcFJGZTJKRGdDTzZlWVlHSDE3?=
 =?utf-8?B?Y2hHSFZQU3YwVDJSajhCZUpmV2twRzlLK2ptNmxWWVVOSUFCV25pWEovTzZn?=
 =?utf-8?B?R1pxZStrL2NGMnhSY1IvVk1pQlhKdzVMajlIa0wxQ0lyY09yMEkwWGZTQTV5?=
 =?utf-8?B?SzVsY2lnOWt4RExzRmJVUEZzWkxLYUpaNnpNQ0RSS2hpek55UGxaUDVsVjJO?=
 =?utf-8?B?S1luVGJkaU5kaW1JaHNZS0gzMjRheEpqOWpjNkFVSmtZRnZmek9oNkdwUkh0?=
 =?utf-8?B?TVJNSTZMUU9OVk9jNGZnU0VLdzR4RXlKN0JsdEVOSUw2THNMRU1yUFFwM3hE?=
 =?utf-8?B?QmQxY2E4Vnlpc05YNjZQMVZvWmpBSi8vSFRrQmVaNXVIaHlzTWoxN083QWVt?=
 =?utf-8?B?QU5ZVmlEMlR5N3hmMnJ2dFljbDFVZjdBTy90M21aU1JzNFhMRG5XWVUvTDZ3?=
 =?utf-8?B?aUVrRjU0ZFJYYXJqamptQ0hvSFRUQnpsLzkxOElkSGo0N1haT2w0KzluMFB3?=
 =?utf-8?B?UStkOXRFSi9XMWtMUiszSE5LaE1yWTlXbkNjaXc1RVE0VUsxVzAvY2tTNlZy?=
 =?utf-8?B?UmR2VGFucnAxNUZDUGsyU0ZGZzVNVCt4RkJJVmFKWVdyK010dFVuYkQrKzFT?=
 =?utf-8?B?YkNUODNSMWdqbGdwYXV3Y1gvMWpHK2d0MHpwRitxRzczckpNYmVpaGRjYXU1?=
 =?utf-8?B?a2VHRitMUks5UkRPaU9RY1dQMit1cnRISzJ6UGR4b0tlQjVVT0tkaDBXVGpJ?=
 =?utf-8?Q?bdSu1POHSF5+KLNeR0Ejbk4Ui?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf613983-6473-4128-6ba8-08dd4547f943
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 18:15:58.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+DNs361Bvdc0WZyxJc6tUTeumj+0y9zT2P+BLSZ10czeJMuYYaCoCyK+8ufuD4qNIcyMB7t/mlobtXWBAca4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On 02/04, Konstantin Shkolnyy wrote:
> mlx5_vdpa_dev_add() doesn’t initialize mvdev->actual_features. It’s
> initialized later by mlx5_vdpa_set_driver_features(). However,
> mlx5_vdpa_get_config() depends on the VIRTIO_F_VERSION_1 flag in
> actual_features, to return data with correct endianness. When it’s called
> before mlx5_vdpa_set_driver_features(), the data are incorrectly returned
> as big-endian on big-endian machines, while QEMU then interprets them as
> little-endian.
> 
> The fix is to initialize this VIRTIO_F_VERSION_1 as early as possible,
> especially considering that mlx5_vdpa_dev_add() insists on this flag to
> always be set anyway.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in V2: Initialize only VIRTIO_F_VERSION_1 in actual_features,
> rather than all flags.
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 36099047560d..cccc49a08a1a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3884,6 +3884,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	ndev->mvdev.max_vqs = max_vqs;
>  	mvdev = &ndev->mvdev;
>  	mvdev->mdev = mdev;
> +	/* cpu_to_mlx5vdpa16() below depends on this flag */
> +	mvdev->actual_features =
> +			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
>  
>  	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
>  	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> -- 
> 2.34.1
>
The patch looks good now. Thanks!

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
