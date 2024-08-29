Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0414A4EB
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958215; cv=fail; b=TL3t6biQFJDzrGVlR9gYFlGv5NkMkNXH4XvOg5E6R5D6xJmNyRf5VyA6oSz22iNl13efCsgDHJ7fOIy9j+dfrXBPDFgiKXKSygQA8ezuqm1NUjvkvHzO9T5EW6WFceL83BzrElH86jZ73ZUmWHVBFxiceF0e0UcDCkNGrKZ6QQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958215; c=relaxed/simple;
	bh=/y9hR/pXZ2rYqhfo5JHDmiF5SVpfkPJfjbcN0f6TRBM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FB5kq4e7wLWYUyT2j4mIGLfOwtBNx6yQ74bhw5eiEFb8MyqilBD2Wxvj024wLlJKsfhPhCyriI2reebiAKetbgV+V6vqNoMuFKOq02tkA12z26UisY6P4DxT6Mok5XK7SdQ0Hxf3hcZ8QdL/eqQZcHjQ+1HyvpCgpOMCn6Ho6kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5KkOYlq; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5KkOYlq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gP87RcSoQzX+xaOKMk/9jDN1RhzhkB6C8YrpkTXx4/MOx3J9aafHuxJClu5CTFA277SCCmStrD13TUX1dhGkIe+HrI78mN3HYB79Rq4MctsQT1qS3atV6BQqyE9jvlfaUFSVNyiZt7TSW7m0yK8BdwO9ND8z64j1Xcgcv8vzDum/V7Qhm4ONefx16nyObfdw9ltOdmln+j0HzQ6C5cS6elEJRGuYYRQ863MpdZ8tXpH+xS7m6E8SpZP3a12IaX7p9m1Wi9PuFO+NhjsCDIb7dm/wlb3paNLhTL9+tcUIj09neA6+4ssFaLckTH80E7zuSvAM70eZkZoHht43nTQdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nI8vyB1DgZJwDj4Q775N7gvsWVER3e/nfeDNwAEUcc=;
 b=DoRUNRwLt2kC7Wt5wdGRgzEA5Ej08WydXqpCOp+JTGAMGMRA6YXIBmsYkvqLM/D6qr1UlWqvlHC9JOM49dpmt3+dcR/Qe+dPLktYHFedLEldzudffAyfs5ayUJUNo8hNBrUA0FQXGD4/FaP2wH+FePyyAEXwwo1l/9mdEMgQpOxYWyJZBdcSmjkUE1dltQO7tVfIS6ZIF4iM40GUxZS3NflvoMFYnek2602Hq87npjCzyn7J4S1cnXPfKcLeHBE2NtvCZmcdeJCG9mbfE7h1aPvS1plsjZ1TmbrusHGv6+BhIUbIARQ/fKCUrsS53Sxb55O/cTzxHMf3FvHENi0LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nI8vyB1DgZJwDj4Q775N7gvsWVER3e/nfeDNwAEUcc=;
 b=X5KkOYlqmuAx/krA4vPdm5FcIbd9TmacUgGqkPHZed+1bf0YZbOWpfsvAEHFkTb5xHTwtKr5er7u3mkhMwYvcXC/7XwD6rGwesJYtrdMfq80PpDFXw/DAd5ZsCQf81ZqbQuUKCLne6n5pQlfEn29y32wgF6PAgkEtMgTwOb+lygTYm7UIC0gYGIZnzWhgcjl1qfCppfq/wxRt7ADn8PF5qB4OyFxTRcs/k61fModZfE79DQtKfrR0ktr5RBvXZoJRAIS6YSLWNzKxMmWe9F4wzha6xPxB3cNIakmlh4OtiH+x5uAcV7UaOYSB/W6q5kpquxe4gr9XDvgz5iz51wM8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 19:03:28 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 19:03:28 +0000
Message-ID: <0648a9d9-a056-4cdb-bfb8-a792bce1e771@nvidia.com>
Date: Thu, 29 Aug 2024 21:03:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
 <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
Content-Language: en-US
In-Reply-To: <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dba5eb-a389-44f2-9b6c-08dcc85d440b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCtVaStLeG16bFRTTmZJTm90QTd1TXZYWncvcVZiRXA5Q0xBbldhdlBzR3ph?=
 =?utf-8?B?bDJmQzVzWFprd0JHY2NMUHNnVEpvSFJrcWkzQUVUVHc0dFQzbFdDUEk2TDBY?=
 =?utf-8?B?MHpveHZuTVhDd3c1QURuYzJBSW5OSTRKaDFJTFU0TE41aU10RXFyZEJOU3Ba?=
 =?utf-8?B?eWlwWkErWWFiUGZpdEJ1VlF5TGFEa2ZEQm5IWjFJQjlNNEJIRHJRcXd5WkF6?=
 =?utf-8?B?UTF0MGtrcC9kRHBjQ05YU0kvVU55WU54M0Yza0EyZkNGY0lZcVRoK09FYnlW?=
 =?utf-8?B?VyszdStMVWpkODNYVVlHQk5KOWFNaUYwNDZ5bUJUdUx3SE9vVXd1S3FzWjJG?=
 =?utf-8?B?Unhpa1JXYzNLRWJINCtDNHZqNWJYVVZHOU42Wjd5TkJ0eFJZaUo4UXFwd1Zi?=
 =?utf-8?B?OWQzL1JIeWJhZjF1aHViWVU5UU5UMHBpQ0EwMFNjam5DU1RlVHZDeTZ4aUI5?=
 =?utf-8?B?cmNaQzBJNHdibGxOM3FhVU1VNmdFNy9BVTQwKzVJNlF6eTVZWDcva0NTbkx0?=
 =?utf-8?B?RVFBeXVZNXdydDUwcFBKSnlhQ3VPenVxaTllcGxXQzc4MVFrOERPdWMrYTNm?=
 =?utf-8?B?WVA5U0tTaUg1QWNsRXBUK0dhSTZJblVNbG55MmczU3NqUVNTSzdFQlN1Wldl?=
 =?utf-8?B?Y2VFNGJ6ZmpMbENnV2MwS1l6MHQ2NUhKTDkyVVNIaUNWa21FSXlXR0xndmtr?=
 =?utf-8?B?cENkUzJtMmNzUFIvTXNtTzJmUnhnYnFYQml3RlhzbXlwei8xM0J4MGxYdE1m?=
 =?utf-8?B?ZEUxYUZETGlOVFQwN1B4REd5UTJITUFIaW9nQnBwK2FKcXpldk1taWJ0Yzlj?=
 =?utf-8?B?VDIzYU1SbElaQkxyakU3Q29NN2M4azNNZGo5cVpJVHl3Q3h1aFVYWllxWVBC?=
 =?utf-8?B?dHZtcmhjRytIME16eElFbGxsbllPdVl6am1QeGdjQVZRSElYV2ZFTmo5SG1r?=
 =?utf-8?B?WncwSTlYQWtDaU15QmJMSjdGWlZPV1BocTZuSlVmc2pnMjE1cTJQRExIOW1p?=
 =?utf-8?B?QkZTYXpXc2psc2NtTy9Gc2R6RnQ0KzZoMVJ6eHNGcnpSYUJWZ1JESFBJajAw?=
 =?utf-8?B?YmlMUnltNzJLOS9XQi9KVGFpcU90TXN6SXBGWTBzVHNTWkxQcnpSRXRXR0VP?=
 =?utf-8?B?VUd4RXVvNGZVTHlESGwwTVh2YXVnaVBLMFhtUVd3UklHRm90cTZtTllaZnhB?=
 =?utf-8?B?dW1YckZ6UGk2eEdwcTZLUlZManZwazlFUVhUZm9UZXpab2w1eE5lTFNPZmFj?=
 =?utf-8?B?NUw0NENtNmIyck9xQVFTcEhyNmtjME1aTnFpZzFlS2VUaVJVVFlZSjJGVzB5?=
 =?utf-8?B?NHdVTm9UV2xaWWNaaURFRFFoZkJteFFIbW1IYll2TDN0NWFMMldRT3RqRlBN?=
 =?utf-8?B?OTRGeGZuTk1IWHNNMlM4aGRFMklMWVJOaVJJbFhTWmlxdTVwbzNKbkk5eTha?=
 =?utf-8?B?cVVHSVRoQ2JIL1h1d1JTVlhVVzdwUm5UUEZqU1E0MXYwZmNiZ3RrV2IxQXdx?=
 =?utf-8?B?aTdJUTZINXgwZWRLMzZQZzVXdndxMTVjNWJLUUJ3VDJiWU9RUmJzOFk0THgw?=
 =?utf-8?B?WWlnM3o4UGEyZWZsTmxOZERVZFlnWTQ1TWo2cUJsQ1RnMkY4MmF0a3AyaTJq?=
 =?utf-8?B?cENlVE05alVSalM1dVdSZ2MxUWZsQzdlUU5jck5Zd1dwSDMwd2FsSEJJTW9u?=
 =?utf-8?B?aVF1ZjRSRHJYS0ZEVnhVWVliNDVXa00yZWc3Z1AwdDJ2cjBtWGRscXp1TFJt?=
 =?utf-8?B?dEZobGhMWmpEQk95ZDQyTG5XWVB3ZDErVjJhOFo3OGMzU1gvWnhoV0JqNW1v?=
 =?utf-8?B?OSt4VDNXMC9PdE8zdzA4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtjVE5sOWlCbHdkaUZwakovZFdGb2JSKzNEZUhrbXg5OURlT3lFM01tVU8y?=
 =?utf-8?B?OFFweFVGRzA4dUxCTWZMSERDZzdaWGVtOGRPK0Fjb2FoUFA2MU9nKzI2SStS?=
 =?utf-8?B?QWExMlFCL2RuKzQ2dGhVMjhzd3k2WmpyRm5EczVoVU91eWVXQ2tlUGYzMDVa?=
 =?utf-8?B?SkJ3ekNhWXk0SnQyc3IvRjh0R1VaeWNKcG52dVVEUXNOZ2xYdktGY3FOM2hi?=
 =?utf-8?B?a1ErYlFGSEtkU0tXeHpnZ21CV1d2YTlocHZHRm8rNWR2YXVwVVRwN2dHMnA4?=
 =?utf-8?B?MFRzNFFqVW90N0ZxaFgwZ1V6NS9PWXVnb2xZd204ZTgzMENIL2E3d0Z3QzJG?=
 =?utf-8?B?UTBEdTducG16eHVDQm8vK0lSWEdXZng3UmRuWXpUSEJSWEZHbUQ3RmdJK0tR?=
 =?utf-8?B?L25FZzE5STRaeG9CQnRoNExqd21IeWxGOWg3RVZMUlkyRXgrUGNrUlNIejBa?=
 =?utf-8?B?TjM0WkRXbHA2VjFDSmdLdGMwTnY4a1FNUE9rT2xXRzVXa0hYdDNCMlJUUmxX?=
 =?utf-8?B?WVRESDVlV1h4RHdwQS9LM3NrZlBrSE9XaEhhMXRpcmtmdzJuNEprODRHUzFS?=
 =?utf-8?B?bjF0N3NxL3ZMcjMxa0x1SGxYZWh4TXZ6amN6SjMvbHYvZ2dEM0ZJQzFGYUJ2?=
 =?utf-8?B?cmtpRUpuUGtxZnh3cFZGS3hST1dQVHpLRVpha0ZYNkJPNFowdm9rTG5Qb2pL?=
 =?utf-8?B?NzJGYjhyZnpYVE9Zc3JMbVVmeXplaFBFb2ROVXQrK0Urck01WitoaEdyMHhF?=
 =?utf-8?B?cnlsN2c4TFpaUDlrR1VZMEx3OFB3RnUvUnlqdHZOSnZIMVd3NHYxblhSRnFx?=
 =?utf-8?B?OXJZcEhuQ1dWQk02a2xTbjRpZkRJeUc5UHZPMkIyejdoQzlFOXBad2tFUVE1?=
 =?utf-8?B?elNQeW52T2NIR3F3dVpKaC9kOVg3L1ExMHVqMWdUOWJQMEJTWVNVOTRFYkdF?=
 =?utf-8?B?L1JVcWFzU1dKSU1YeDJGYXJWLzcrSWRmbmJLNnBsM1JsdEthUjdhRU16TVhs?=
 =?utf-8?B?a2k4R20xNC9XWFFxam11MUpSK2J0UjhvaVpYMXIwN1NzQnVYdmRmT2xCQUxY?=
 =?utf-8?B?aGZKMEVWeDBEYXJEWU9GME9wQ3JXeU8rRm5rakQ5TzBlOWd3NjJkcFhnb09s?=
 =?utf-8?B?YkVMMjJEaU80QzFDMTkxNlp0akErdktQNko5SjlhaWhDbTl4U01SY2hHM0ZX?=
 =?utf-8?B?MXcvQUx5UGYyeU1mU0lubUVub0lNdDRlRVNNWThiUG1WMWVSemtDZ0dsSVlO?=
 =?utf-8?B?UnpSTVU2Ky9DWEhQc2VRR1NrcmgxNk95T3BqNEQ0UCtJdE1SWGpVTWltREFG?=
 =?utf-8?B?cFBsN1MzblB5eXlSM1N5RzB3U1BMTW5jSXh4bHBCaXlJbk8yNzRFS3I1eW1z?=
 =?utf-8?B?U3M5RWxxbDBJZlpQZmtXankyMHhRWmhtZXBMemFxK0wrZXZrUjhKS0F0QkpY?=
 =?utf-8?B?MXovLzl4dGQwZ1dzUzRtN0k0T2kvUnF1RGlrWXBoNks0QnhDakNwMnZKOUxD?=
 =?utf-8?B?OHRFV25JNThqOFM3S0k4b0xBV3ErMGxUcWZNRk12U3pXYlN6c3FBSTdnQmhY?=
 =?utf-8?B?NzlpalhCb3YvaUJDUjhXNlBaRjhEQi9HNWIzdnpGeVBpU2NuUUdRWlluOTJ6?=
 =?utf-8?B?enBhbTV6bVNBUUJBZHlnMEdSS1A4dHRqYkRHTkJDVHZpWm1uLzlvS21QcWx0?=
 =?utf-8?B?aHQvUGhidnRQOGl6TnhuTW9WNkh0TTNyS1huV1FROTgwT1Z1TUVOMHVuQmRF?=
 =?utf-8?B?L0NwdmtiMWZjWVZCNnMwVU5QZ2YxejlpUVduWG1IV1hLeUNqS0hHTHJnWlA1?=
 =?utf-8?B?cGpGKzVwQk0rSkNPclVyNFVQZUs3TmpCTzdpdU0rUlg2L0QyVzNqSGZCYS9a?=
 =?utf-8?B?bFJBNVNISHNTdHlCUkVldlc0dWhEKzNUdU83bEY3QUpmL3BFTFRSRVI3RGp4?=
 =?utf-8?B?NjFQdmV6eUlTMm9QdWRCSXkzNGErTXZoNTdYMG5zQXFITTZ1bkU5eWIyUnVU?=
 =?utf-8?B?d3hWUjhYMW1HZEU5em91WjRBTVlZdEdIeTFmYldYNXVBdkZGSkJNNThIVDlN?=
 =?utf-8?B?WWhNeldpTjdFbEF0MFBuUTVRaVFXRnc3NDliV2p3U2hYZTZ6MXRZYjlUb2Ru?=
 =?utf-8?Q?bYhBzQkCJHPKLrmFB0teJIu4d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dba5eb-a389-44f2-9b6c-08dcc85d440b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 19:03:28.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl+XkdRDwibtc21WSosQ8qu8srJUR64kQBBeEcB9yMyp2Sv+RUaIQKVFFVuGh0ZhR+viJEKh8rqKCuo4//YvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375



On 29.08.24 12:00, Dragos Tatulea wrote:
> 
> 
> On 29.08.24 11:05, Cindy Lu wrote:
>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>
>>>>>> When the vdpa device is configured without a specific MAC
>>>>>> address, the vport MAC address is used. However, this
>>>>>> address can be 0 which prevents the driver from properly
>>>>>> configuring the MPFS and breaks steering.
>>>>>>
>>>>>> The solution is to simply generate a random MAC address
>>>>>> when no MAC is set on the nic vport.
>>>>>>
>>>>>> Now it's possible to create a vdpa device without a
>>>>>> MAC address and run qemu with this device without needing
>>>>>> to configure an explicit MAC address.
>>>>>>
>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>
>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>
>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>
>>>>> Thanks
>>>>>
>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>
>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>> with a different mac address that the one that is set in HW anyway.
>>>
>> this is not a new bug. We are trying to fix it because it will cause
>> traffic lose without any warning.
>> in my fix , this setting (different mac in device and Qemu) will fail
>> to load the VM.
> Which is a good thing, right? Some feedback to the user that there is
> a misconfig. I got bitten by this so many times... Thank you for adding it.
> 
>>
>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>> and now I'm working in the fix it in qemu, the link is
>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>> The idea of this fix is
>>>> There are will only two acceptable situations for qemu:
>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>> command line is 0. In this situation, the hardware MAC address will
>>>> overwrite the QEMU command line address.
>>>>
>>> Why would this not work with this patch? This patch simply sets a MAC
>>> if the vport doesn't have one set. Which allows for more scenarios to
>>> work.
>>>
>> I do not mean your patch will not work, I just want to make some
>> clarify here.Your patch + my fix may cause the VM to fail to load in
>> some situations, and this is as expected.
>> Your patch is good to merge.
> Ack. Thank you for the clarification.
(Side note)
While looking at another issue I discovered that it's possible to
configure a random MAC on the mlx5_vdpa device at VM boot time if
device MAC configuration is implemented during during .set_config(). So
I was able to boot up a VM with a random MAC address coming from qemu
and the traffic worked with this new MAC.

So now I'm not sure if this is just by luck or if the .set_config()
op should be implemented for the MAC part in our device.

Thanks,
Dragos
