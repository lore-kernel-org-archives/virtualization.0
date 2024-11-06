Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F084204F99
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908142; cv=fail; b=qE8LZqGQoISY6/rD1qqnorYUWuIrBfK85GjeIxpFMRkgx1rF5KhLy+JIYMFHmOtIwN16f1ZnVX0jXKgmCMqyml+8CpELylyC2OJLVYCt8q7TuK/J7Yx8VheK/r0npolPWP3CleMLrZdw2ujVF/sbHe9UPuhpTSB+DL+3hbqNKSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908142; c=relaxed/simple;
	bh=F1D1xgZ1cHHq0Nm72w9qVF1AF5YLBUgXZLBFePxmZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pX2f4N3WikSvVhXgLkTw8dndape8S8Zz1g5IvRDc+0P6oXDG1MI9bZ94s+RXua3N/YguUmxJT+DR9P9nbURyeHl2nYI6V0yMx1Eixq6R4ohXGa+t+n8yDMkhN3OpKB38jt08fjoMkH3Nd2AyTkPP/trg7Bu7RYM5JKwwnv0zejI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IuKdymMO; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IuKdymMO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B137060AA0
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 15:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4ZRs6o_Meo8 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 15:49:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:200a::60e; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F342160AA4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F342160AA4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IuKdymMO
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f403:200a::60e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F342160AA4
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 15:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0mCvbRmJbsHdqiP0QTTA7VAJibIe190BHwvDIHCblVCowJWLJUkORXZ41HVc4AMcqwNtXs+pG1kNnsQVjHSwpUZiaqv0TkLOZAEiWfZsUDbB6+OrLfp7QVFhIX0HVvZGpkwP/g7qyWxKN3aFWf4d2KsXoBmDPhn9GUc2gieK5lw4IFyg8nqS7e4+rvmTu5BPd1GVe+z7kI9u4SIPrnnxfeN+Sh0BgVduslcRpno1Ph8gtNWaz+JkEAbRwAfMWEBbuoe7yM+ksUuNi7yAgyqFB3ukvAvGFc/HuFFQG7DjsvdyTW/vQaB/azoyCdUoFpPVHjSHkTchcJlttiK40n5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1D1xgZ1cHHq0Nm72w9qVF1AF5YLBUgXZLBFePxmZoI=;
 b=Iv7y4Fh9Qy/NecPiwVLF+lKE/hdGM1ss1sJC0JxoiJoGRsj50EJijGk7civJ4PWDfyHQ5qE5aKGLD8iHxTUN5FMYOt8BN+vMZ7ilW87aBZGzPka+a1M6fTV3JdEkUqjhYxxdMlkYWm0Gd1zvIs06cZafZDg9f4svLBzr77gM0snZd9zloxwmQKg4cch4omsMnlVfyGWH4t/CWZXdSGMODS1PSdhCXGx8N9aJKcK0tDCwCiCvSgqYqxKt+uvzQSN/cYwxnFlGjbx394fuBT6uR5n9I2zS8UwwI9IGBeIBSlc2bemfOdk7U1OkeO36ZuQ/iTVBBGFZA3oZ9NsO1y+YQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1D1xgZ1cHHq0Nm72w9qVF1AF5YLBUgXZLBFePxmZoI=;
 b=IuKdymMO3RNZCIZaVbdaly+A9vZCyg/mENsgrOGmQ4z2fQljz+VjXgFbNRMpzgEZALYgy74LCk9Mm4lLiFDgUR+eRgpaHW5dQNMDvm8E8wCT5ZuRtN+Hd5mNj+w0o7peq/oTQYGOmiE9a2qKyQdC/2VhV9IZY7NJ0iftqIZevYesFe+/wrYf+FoKUvANNdeSMr8gOx+KG8Ly1hvTx5wXVBIj4rEAVh6e42sQso/lh8dpGFfWlAYa64xbaKh017gybruo18/1UQq57w3Yh7PFLAW6jWZs/QGMjmz4WLOu2z/tlZPn599nmLF67E1BE2ZX0ND7Vu3ngnTlXOaLcVhaLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 15:48:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 15:48:55 +0000
Date: Wed, 6 Nov 2024 11:48:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, kevin.tian@intel.com,
	joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 vfio 5/7] vfio/virtio: Add support for the basic live
 migration functionality
Message-ID: <20241106154854.GQ458827@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
 <20241104102131.184193-6-yishaih@nvidia.com>
 <20241105154746.60e06e75.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105154746.60e06e75.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c528c7-25d8-4921-b7f3-08dcfe7a853a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhahrEd35esoDtAaMenW/r4a2fVbhySKj0equmn6jBVXNaFdKhGLdjfe8Ovw?=
 =?us-ascii?Q?BM8QrMrxA6hauigrZDeeOADMPyY+FvxTh1oS7W7Bepu4P33XvRCrpWhORWiK?=
 =?us-ascii?Q?KXCvnkrTYTMSoDH0fenu0nfzUbJYnAXisRwfAEPuAU+AuBVuPImAld6H3BhE?=
 =?us-ascii?Q?Q/RS6+aehviNcQAzBdaFGWpR1eeZllWpUDNfGMEyo9h3oEmHgBlomsCAsVvp?=
 =?us-ascii?Q?T6YFF3ve4el/XLRTzNiNv85ykrqXXjDidHzKSqKrbhY20zyT3VTai8+yQ0iU?=
 =?us-ascii?Q?jZWM8ZGPOiKvtqT2JkwFqE6ZV/cuQsHcmV96iZuH5jRt55w0WLKTmTSHJgVI?=
 =?us-ascii?Q?rc8cppEGjw1f7uEBkjPX70lD5kBtIt8/iivCqVGF1KNQjqcu/sxAlMPSZsD2?=
 =?us-ascii?Q?i2jDBVHAvdR/nhHCSgrAdY+OLNqDplO96jF8ftq5ww7eqg7NOYpwn/JOdpui?=
 =?us-ascii?Q?ioXMKP26CB8181AKPCK6syZEZFOkpTDQCesY7WAUQqA4C7MizdfaMdpqrm0o?=
 =?us-ascii?Q?jofABjmo8TzkSLpWt+omOWGCGDA+w8x3kH2DYtWM4j4F48U3iuiNe+GLYCbd?=
 =?us-ascii?Q?wqZjB5/ttbs9qNVN0NG22vhTvO3vVw10faMznoRgXeRFQ/qk6W4mdOI1SGh5?=
 =?us-ascii?Q?s8rmPK9Uj4pnDqaUGReRWmwr81hD5oV2qVLeUavR6NecLpWwWjBNjZXY2BGB?=
 =?us-ascii?Q?gXm/r8VGpsc4XGBP60zW0ycgY+OqpR5D9xOpGPq087RkfY9ktrZ098FAidQm?=
 =?us-ascii?Q?8eE7Svvawvjlw6p/n8PYRkF3sEmOA24NQdyY/8yYRpjsVjtQ/uEplfHQ2d6Y?=
 =?us-ascii?Q?OcpeBMjgpYcs3/RtNvrnD4fA2DuOVDkdRS8ISFeToO1KAhErJAxSwG1s42UC?=
 =?us-ascii?Q?mJyHQsCGs1U4MO3UNiNt23uJq2kR6icl4SBCQ6DKUaWql1CiaCRKwuqA3rmF?=
 =?us-ascii?Q?UDJ7M7wRWl2K+afYQwJ+fai9UfLxzsS8PCP/A/DPoooUrzWmpBFVFbXmBKm+?=
 =?us-ascii?Q?VsXqhEdaikkA6aZI47VDnxPUfPMJP/c7PkBywqBqCa8VdUY2Aat0XLkWXkmS?=
 =?us-ascii?Q?feo7cfJDVqfDsBbXkVq0+UmNYK/ud2I8lbFptod6/wrhM7pRcescYYt05OXl?=
 =?us-ascii?Q?JlK2KErWgKP97E4o5RWDUoVR9kdwe7Y7hlLBEZSbiwCxfWRKB6usx+IcBKxg?=
 =?us-ascii?Q?o1kL9M0ikA3Km33vMocGNu0gcLKMnBvESyl4C3k3bq7hr5SprxLP8CJZ1BmP?=
 =?us-ascii?Q?cU0T+Pq4zRL739YOAFye3ZCK1WaArlIupa/eTz8/aRvKSo42OY68riGEXlyN?=
 =?us-ascii?Q?VDFMUStdMuKIPnD5vR/OAYcT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzzTtkBW+T6Q/ubtQFVkvVahLTBed0CeW+l/hR5X9rSUwpXI6rgLZIdCm0EB?=
 =?us-ascii?Q?PFA5Fql34yNxbcGXhORTLK6ahpmu1/AutUWVWp8IAdCfSunTPVxccdjkuicF?=
 =?us-ascii?Q?Qv2wipeGSUKXO/dXbgG1WyyILsYmlTKQEaMuiZ0jx8wPFMR9wTz7A9eKJ18f?=
 =?us-ascii?Q?Iqj98f0kF0oS697qVeq2yMVc6Gq0V4sIEW/mAhaJsaCGjzp6neebf90mJ7Do?=
 =?us-ascii?Q?MfMRerxMEXanhbSsBkUI1ZGs0ZtlzdYQa+n/pn8TIBxwh+c/ZXPC2HV8xX5I?=
 =?us-ascii?Q?gcH3q6ok6AYxSU/JIaM4NX3TUVA0Z5ZTqGwil8LW68TjOuUJnpf39wKuZ8E5?=
 =?us-ascii?Q?6l7fTb/tmPx7xPaU/Y6BW/lkxGz1X8FDQtVe6vQjB/McNcRww15qgED5rlbu?=
 =?us-ascii?Q?cRBV0e+OnsogvpZD1Ahk6/LZZvYXCqnbvlN1/7wZF14SmmZyqhTF4ygaCHH6?=
 =?us-ascii?Q?zcp0ZRzF7yFb/wYVqXtozAmIZ1SgwR89L3nFcYNlrOFzNHtJ9eWzkxg02Waw?=
 =?us-ascii?Q?UepsbajQyU297tq+PkrObbwYYLeIGtpNpjQTDWecIsTB5Wp+Jy/X8HDLTO+l?=
 =?us-ascii?Q?bZGyb6oY8AWYK3LFzqKU8lipAeyF4Q9YI4YaERGz+3oZjv5bK5EA9FPidVRl?=
 =?us-ascii?Q?nHCS9H5WQOlO8630vXfw3ZlHqB5BGFXWM+BtTvw3PrL4pRqqchXdrxCGy6n9?=
 =?us-ascii?Q?ZjGIkx7k8yr8FwQFIf6nUEf56Y5U/PuvnlmjXHHe9AO8qCwuF/KyKLJ/mFEz?=
 =?us-ascii?Q?sKCe5ye2nTyWQV0z8xkewGl3ZHTVFUt/uVEOl4xiNjsT8C9ngIXSxwLhxtZy?=
 =?us-ascii?Q?wJMr2GsJ2UGJGJ7nLX0BeOf+fJ4KLSXfUWOM0VpiD7M7i8zHAzm05WBK77Vw?=
 =?us-ascii?Q?T5vbF2rX2Iv4TlUYKNYy+KkNQLLEmQ3mjHj4cNiXZbsKATbe4DFo33KMoPHW?=
 =?us-ascii?Q?87pUJHoJjyvRzSCa2w9qiiFjKXSdCpLZS2E0nIVj1Bx5/l04jMl1DAJBSVHH?=
 =?us-ascii?Q?chFgeYGMgLrsMdNe5I0dcsvMDyCn29+EOHT3jxtXkwNuEF1iAw2pIjUsaoVq?=
 =?us-ascii?Q?cs1Cjulx4lWQltAD3v73+f1vmy3v8c+mpM9f3V7HQKdTYUh9vzz3jqK1ogoA?=
 =?us-ascii?Q?4MF+phonqKG8GotgGYi3ypgodDo8TSuE1yh0AkSZHohnyMyXyt78x4aoAgtL?=
 =?us-ascii?Q?JXVplyXltV5kLWJImJEfDZ+bxy5ydgES//OdsSU+e29iKvXDHqR9AfagnKON?=
 =?us-ascii?Q?R4E17KWof9je5y8M7ngJrA0jfRJRohRJKl44h+Rr7pAAGSGBGnyyLQNwc9xL?=
 =?us-ascii?Q?6iEfXgrygusIJxGjPnLOYYt6Imy8DMNs74cgD/OyeSZBluv5dIWWu2ovgwxH?=
 =?us-ascii?Q?NsIYWEXk+iN7Tbd7S340gC3MYekHClTKcZf+065VwdD+PdqH0n++0eYNbAaR?=
 =?us-ascii?Q?HxIqB9+/e/wpci4EoE5/wXIFPW8vS/CXYkymNKpk0hIBMPBFHk5qxHz4nDXo?=
 =?us-ascii?Q?1fJnCnOAVLIbnNbW/K4v/9hx3dBw7vc4Jq3zgPtEe8Tdy68mWYtxJ4/Auyun?=
 =?us-ascii?Q?ToxK5gRgzMqQX5FeA9rYj1OZ0VTgnQ60GaBOfUdI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c528c7-25d8-4921-b7f3-08dcfe7a853a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:48:55.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiSbNcz+6ObsLuXy1EURdygx7WLRG3RCzVB7kYSbJ8I+MgvKa3iJsanJoZNlJ3nL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506

On Tue, Nov 05, 2024 at 03:47:46PM -0700, Alex Williamson wrote:

> I think the API to vfio core also suggests we shouldn't be modifying the
> ops pointer after the core device is allocated.

Yeah, that is a dangerous pattern we should avoid

Jason
