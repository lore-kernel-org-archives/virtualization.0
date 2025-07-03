Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A852E9EB0
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552251; cv=fail; b=V7xfDvUvZ94S7rN1ipXEmBHJdYIGcHCKzmUVhYkwIKnCB8ShDm7fzS1b8ADbCnH9pQiswZDlWPJLUiAMf76j9tF7i6hTKkzzc5j45/491eM+7wh+pAbkcFjF04g1IHpEUo9T5dtepea4dYAZHElpUvZzKMuA3x5g4INpr5dcVmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552251; c=relaxed/simple;
	bh=y5oL0+f45c5Dm5SVYjN63Ryz17eou44j+mTcvSmyJ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EB5VqEeTOkAT8Mc4gh6f57ND2AmmVCQ1RpcmtHgr0RSuOdmoHv3Lw7hQoEF9UoZx8rwGW2V0A2mZslA7jFIS5IBeONxrnzHRZKTxu3Yv9VMelOAq6fwXnrUZjlW0zctewiHU7WKL9im4w7JqxeliYB0VmUwU3Y/pYtcZ/AJaU4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TtuisTyS reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TtuisTyS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh8E05OSoz7z0a6GlYfurES8EyXtP2irXuA/UAnghuOyP0NMb9NTJakrYy9SPhOmDAxsK28lFxws/Kp/e+1RDyrxh/5LkuwUQLTG7MKPX0R3BtnkIjDz4z/jN4iEUPcFLwgKF3HA7achJEFr7sH/HnGc7/93tg2Z1L4jqnaq6m6RjISYhhLOIlAreNXU66bF16+S2Qdl+Dxgy6h/5/K/h7yh8nLYa7gBm60tvK5nHx4L9ZrFnQQDuNq/KopLIpL9oRw14esGF45n6za9MLcvGunsxK47UijbaPAhjWvWlbbwcLAe8RiEE31BN9oPP1+7yehlQMyqGiFwB4TFzFL7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnUt2FyN0tx3IrQhxdmdL2AhEarXDQ/5q4EEgWHvT20=;
 b=lNSrkxUgSCxucFsRjOmDb7mFmzzoRrHTPN3vJBvHvt3YeiJpT9KS7lL2mgNtFTCm65QL9OFbMkqEo+38DIynl3F5pJl7cKmyqTK+rgGZZY6z6FL2rfJw38w80d0Siige3SBTLRquqIHDUOU5+ds60nkpoP5jUdsPLze7oMFLEAsWeVEbtshJfDi/wPEDUgGc2pciLCHcVd4OszCzvNK8h4JkJdo7Rh1kd2ssUd79ZMZft3n0rjRKSc2OU7JTjoZcjXTveXQ9ivLPciuarcIwXY7x45aNKgZTFdDVdBOajv2tNEKfCu+Td5UC8swG/Ncm36Q6ak+7ZWd+rkWNsty5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnUt2FyN0tx3IrQhxdmdL2AhEarXDQ/5q4EEgWHvT20=;
 b=TtuisTySMQXZIoLEc/wesdoTNmWUYT33TxsYFqtiBxOzitSqq5BGn484moQZ0oDU26pWTJ64QndiXg9roxsontZKsBfvFuuxP8bZ5B9iFfwmBMGOz5gWxP6TsQ4gpi1g6RfciIk0HSRNO7IhMRw6Dbo7AM8PqtEEP/SiSfAEe4P9XH5nHZWRrbMlAEM4gdMRfOnvr1OEPNBNLHf28cHPEln4WiAvM1sgahxy1LykKoQJoiIw44hPWvdW9CxBOcaw60TqzqGba8Ohpw13VPuiGp+kSJllZ4WZNeCq7K+PxpdI+B2LkhzRLDx48DXoRQgj+ukee4aeFoXqxhg9wUjtfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 14:17:27 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8835.027; Thu, 3 Jul 2025
 14:17:27 +0000
Date: Thu, 3 Jul 2025 14:17:04 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wenli Quan <wquan@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Subject: Re: Host Crash When creating a vDPA Device with device_features
Message-ID: <s27ex7wujgm7bn74aktkulumskjv7cxrk2ucpvqiixl6qhumko@vrajokbnb4r3>
References: <CADZSLS0r78HhZAStBaN1evCSoPqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com>
 <20250703024601-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703024601-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed77b12-4500-4ab3-241f-08ddba3c567f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?sIyBQ7wfJeoxtHJCfp36Ox8hyRM22ohnz9jP3PgclEHjslFjpqTKW2GbRP?=
 =?iso-8859-1?Q?LSwbJHfmMISvv1NubbS6Y5VCmoQSjHU9sXBqBkcAghXUstSsgo6k95GlIf?=
 =?iso-8859-1?Q?B+MaGlKjy3bKmHdFDYgnN+CrVPaCfxF5KS5FjI85u0A6QTyjbY+qtrXH5I?=
 =?iso-8859-1?Q?2sinDd5/wA0WyTbeRP2dDVaZ7YQZNe0eMMtOTFEm7/wxv1MKKiGAI2Wjiw?=
 =?iso-8859-1?Q?mf85cdEv3ICAUOv0QiqAJbwvu7nYWa1rL93dGYM5RY7kIFGECCe7gYGHDu?=
 =?iso-8859-1?Q?IeoPuA/k1GkPj8EUP7B9ALhvrpITUQriZj1GqOQHs9iLACMwfkPA5kSoH6?=
 =?iso-8859-1?Q?dMvsrzutt8lUsnV5vNS5baqtkXrDPEnrU5cV3XNLu3rN2njJAHK9vXJ1O5?=
 =?iso-8859-1?Q?/tc9+i7fAomTB2hbb90VeAzF7BprLuKfmDsCRsixZGaiYNOrAHQC9chA2n?=
 =?iso-8859-1?Q?NVahFVLKUxXGkvgm45LGT4dSMmm15hBLxpl63gXgJ+PeZKJZANcAFruraW?=
 =?iso-8859-1?Q?lP0dwpuWCxp3MAv3oDGlkPNjA9+kBTPBNVYyIkS3hDd/v1kDTiw+uA6V9a?=
 =?iso-8859-1?Q?geI3DttdxWOc8EZCAn3gYMWR/mkTrvhlrui8Mw41TnrjzeP841/GgHIs3M?=
 =?iso-8859-1?Q?q/raLI5mKlqOOx7ns6zZPWgC/ydfyFWK620xWbMW+XzzNaKct7LzKgZuOs?=
 =?iso-8859-1?Q?xDv/78UxKHFkiNCqp8fY9HgcaYDBgfZvJ053FdyMKHpCvTcfQFkNYaNa/G?=
 =?iso-8859-1?Q?Nbl/gese0yZ1KcNboDk34MnVHkK9lU9gaBn9c/KRgW8erfRFaXHvHFJCnx?=
 =?iso-8859-1?Q?NEQGVf1nUKkXC0Nhs6dNl1Nm3XM+XS+H/UesPRv+GBTKjreEfHX6PV5s2S?=
 =?iso-8859-1?Q?Xfdn+2uBYc2kNi1oS9hOA1y42n6Wrfrot92NfdgiVWX+QO1dmCoVUM5Hyz?=
 =?iso-8859-1?Q?SlRI9nC4NrEN427htcSqgGgNHJAPzqa9TFmiyqfT+nCSK43ALAiHw3Gw05?=
 =?iso-8859-1?Q?jQehm55YQeB9nyuxUviiBmhnIT+wpb/QWz8+nAcS0TfIIXA4k7euz4+YEa?=
 =?iso-8859-1?Q?0ZApd7OR/XLeHyTw1TUC98EvkdzsY6N7ndkt7x18MQ7knaOeoDO1aUhAVe?=
 =?iso-8859-1?Q?goYUS7OymRxZ8DIzn3ttavSE98YBDkK7DyHWmK50P5ulUKLWYAZtJt+lvO?=
 =?iso-8859-1?Q?hUvV0erGa866yWoODOtqWLVDH12k2y+3rh4FNKwOWwrPe1bNvE3UZXRHIb?=
 =?iso-8859-1?Q?sIYYs7cq29HpPsjsOVOmM76hkKk0VmWgtjik0vGBk16zevNNlk0DVdDk3j?=
 =?iso-8859-1?Q?hqBJbbjArRXg6cpHutvOylY2W19knJD5onvnq233OcjqrIzXkqBAZ9rSg3?=
 =?iso-8859-1?Q?vA/vKmDVufRg/XQVv3VsUOQyOrEqcd3MuG+ZnJw4kUchYqNYNIx/AXB5Kz?=
 =?iso-8859-1?Q?+6E2RO0L/TDaOgUG40QyJPs/Syi8EDoNYCVsLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?l3+k5fWmdvtEJrEuI/R8qacq9EaD1f/+03KNny/VnaUggBzVYwtAi4PATg?=
 =?iso-8859-1?Q?E35D0oaaocn7i2g+6yzqOYoqdytHDgM+36/78hb9lgEL32aPu2/sec9ANk?=
 =?iso-8859-1?Q?6sZZrnIENHaUvakpG4bh/bsspqLhHPTHZm+Qe7n5oAcxFBltH410ygyU0X?=
 =?iso-8859-1?Q?ss7EgdLsJQbof9CPPndOblYl7qWQM2RzQUh4yEXEluC6aP/FOlxnwmYxQH?=
 =?iso-8859-1?Q?9BFaBc2kiPN7Ml5RDsx0v/7pskNDSM/t6BTJAcW3d5OPdveEcMlu561mBo?=
 =?iso-8859-1?Q?AfXkcHt+huT2ET5YJhAFUhVfYjvt2lKp/ooPpj+tvSJ2bLVuwStc/txdJL?=
 =?iso-8859-1?Q?vUwJPRjm8I/P6t9ZnwpUdJKVaaQN+ebcJmEdscWSkd51PLBSkbHEWcAblS?=
 =?iso-8859-1?Q?N10QSLz0BPhJKGlaKfm8zwKHXzvpZboCzZ5xsflF8uF+PwtRl0gSPOO2WT?=
 =?iso-8859-1?Q?mqsL0zbX0kdTVTPkbVn7u9+4SvR2EV6QcCRUTVYGSd4qcSYTDVPoVDFnO8?=
 =?iso-8859-1?Q?CZ02NoSjI21IJHyvoVbLFGlGTAjDV8z9+lINDY8+OQySAlDpram1zlpncK?=
 =?iso-8859-1?Q?wEbknVAvMRjs1GCNRGED+J/cRjopzcTYLBn4QHV3jrnQilLeQQQNUH8Gx6?=
 =?iso-8859-1?Q?TG2OLWxXJvhZq89KhCLnfDhFWaf8iMq31Ley85LL4y0SCKkaIyxjhRU1/+?=
 =?iso-8859-1?Q?9Ecz2i85Z9XLdE7hdHfMwK5UNtWt39iaVOSFVQkJCBrUlTAejt7h03raG9?=
 =?iso-8859-1?Q?Eo+xwseJYyOvpEkWGvxQoqwHVkqHpIw6oQSQdLk7RF6f50SHgYGGlzS2jw?=
 =?iso-8859-1?Q?rwOJ87TAld4RNXbuifZ9KbDCKDyMCXkyd20hrAVJzA1qEIyO7tsRrQcSrS?=
 =?iso-8859-1?Q?y91R6BK+bCe37Jzo4zKYP6jS64rp7mQnR0Gt2EfzmCZEmNKp12xM9C1+zS?=
 =?iso-8859-1?Q?1+Hpfy6cD6sJnZC7isQmBt83bL5uCZ518sDPcqeMTn+S5qeWemxisz4lBw?=
 =?iso-8859-1?Q?FjOzOQfUgwX8/WtAuG9R4Y91fAkX+lgteJmiU/g8OKuqmTZI5OLJT0m97D?=
 =?iso-8859-1?Q?fuBhx4K01IgAMzvGa+Ltm6LYECc3c2EmobRix95Tu/y6Orfd6bPdzemOXv?=
 =?iso-8859-1?Q?poig2Kapo2jyIfzekUXdWyPdHqiJPQXcZghrgbi0l/e0Ewrfo8uhWVQjWM?=
 =?iso-8859-1?Q?LHMucNFMaEICXVWQ8zyfsepRDhgLWM4s7FT2LGPZasVN6A6EGuSBPoZYBB?=
 =?iso-8859-1?Q?tC9xyE/EnZzD7tzetYima1sWX+cdx2dlzOon8EO3DePYiiX2jxHL/3Qgj6?=
 =?iso-8859-1?Q?Np7BavFSmLW2y0f0xsipasssxin4piENb1IV/1cIEzoZrdfQ260zj04gvr?=
 =?iso-8859-1?Q?eazSYeAIaDc3Rg9xkMk9HUY2iFVQTf/vwTUAY7VfJF/pnkEImd/tKvlhdA?=
 =?iso-8859-1?Q?ea1SGAV0prBRzablH7OU0wOAPKYKAncTIymZqbZk/bHqhQOcB5RFxzcAis?=
 =?iso-8859-1?Q?YDdWQlHYvmTTKEXJMVyxPVdwao+vKHMyuGpPO+JzQHgYv0eoiPFt3bleZ3?=
 =?iso-8859-1?Q?00NaHogkNNHVeT8Hogi/Dx43V4V/PAvURsQKtmP/tz9ul+H4TIhCLPVGRQ?=
 =?iso-8859-1?Q?7pVu+TPOTf4x5GQ74LBoeqDYzzN03GFb7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed77b12-4500-4ab3-241f-08ddba3c567f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:17:27.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umiNdszI3ammQsGYYUygObMJYE6GoNoC4x078j2FQO6wtES+HExdncIuXhM2Fp8wsgZPOnj74HQ0+LeLLph9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

On Thu, Jul 03, 2025 at 02:47:09AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 03, 2025 at 11:58:26AM +0800, Wenli Quan wrote:
> > Hello all:
> > 
> > I am reporting a issue where the host system crashed when attempting to add a
> > vDPA device using the command:
> > 
> > # uname -r
> > 
> > 6.16.0-rc2
> > 
> > # modprobe vdpa
> > 
> > # modprobe vhost-vdpa
> > 
> > # modprobe mlx5-vdpa
> > 
> > # echo 1 > /sys/class/net/ens7f1np1/device/sriov_numvfs
> > 
> > # lspci |grep -i Mell
> > 
> > 61:00.0 Ethernet controller: Mellanox Technologies MT43244 BlueField-3
> > integrated ConnectX-7 network controller (rev 01)
> > 
> > 61:00.1 Ethernet controller: Mellanox Technologies MT43244 BlueField-3
> > integrated ConnectX-7 network controller (rev 01)
> > 
> > 61:00.2 DMA controller: Mellanox Technologies MT43244 BlueField-3 SoC
> > Management Interface (rev 01)
> > 
> > b5:00.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6
> > Dx]
> > 
> > b5:00.1 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6
> > Dx]
> > 
> > b5:03.2 Ethernet controller: Mellanox Technologies ConnectX Family mlx5Gen
> > Virtual Function
> > 
> > #vdpa dev add name vdpa0 mgmtdev pci/0000:b5:03.2 device_features 0x300c31829
> > 
> > 
> > Then the host creatshed, please check the crash dump in attachment.
> > 
Thanks for the report Wenli. I was able to reproduce this. I will
prepare a fix.

Is this a new test BTW?

> 
> 
> ....
> 
> Thanks a lot for the report! How reproducible is this? Bisectable to
> a specific commit?
>
This probably comes from my pre-create VQ series. I'll work with
internal verification to improve coverage here.

Thanks,
Dragos
