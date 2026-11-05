Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793886668;
	b=KsbWWhWSVHV496FwOftL60If5yoeB9tLCvbvBHqCA07zFOxMPNejMwCx0NaO2d08f2Mh
	 tZAw40phDqb1+y+YrdPDoYlJfClIQx/8cfguRMGxjH6t4L2tO2CI0p12dPgxJUpwBDS+U
	 uzf2uPMGa6b0W39t/QP3mMN2KWAs7AkeeBM5IKjMJ6Lez9IYxvdXq8DKTMTdvn3sef4s+
	 /6nisWV/plKmPS/U8ZGWtZm83sbNQpvF6qRP/McgxRdjTaj/8Xo6IK2Uc/8m1NDKAgPTn
	 L+4q+NH0p++9LjNVuQs2gBblHfDsFhPPJ2Bc1fSj7mktzjGGGVdEfEkJGcRgWNywkuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886668;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FTISAkGxfwT8YvI7Iq1YEq1UleMLxfDAzck5YoG9fzM=;
	b=TjP+wpZHW6oTM1NYT+u51Y8g9gEQ3RZco4W2BNE85rDTFV5Yi4hN67xrpKvDPrcJpzlb
	 2SjZvd+NC4Wsu8gFD+0aTeWzjhq2hW3NO6hC4ZQfUNxosKnnOi4e6E9YI0c8ej+wdRFZl
	 VMZS/pzgkCQ24mwmIdxrQFGj4f+cRs49loYzsuKNODGBOP6yCx6tN3p7CVt2tsbgbwvtR
	 ZozA54Z9RGu3zb7zy07XZywYBnmOU4OynlZkX90L/T0XxzuxtaGFQUPbic0dvCoaFg9Jt
	 WoQLrLa5svBwUVEMHMInul2W6kUwIKVpd0gBOfkgRoypDJIWJtMM8t2s9zWbJSGwCPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V1oYg35R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.5
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F83606A32D;
	Thu,  5 Nov 2026 13:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F83606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V1oYg35R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugiv70QGzMvkwazoXbU5SAw7K2gmWwb0WhjdBcGssZgkmVt66WgK83tH8i5xnM4Lpn7+fx+9Y9MYNVDzS/ie9fJm4/I1vDFyv5i8pnBephipBZ4UQBkmxfFZqj5bW2nEN2hVhuRKP7418fpYUja4I0nXR9+gZ/+QZalbyo2zGL+56CR9aCLeviNoGvmmlE/uqkaSgZe6KlxadJ0ZYBooMHNjxvO+DaIbnmnsY57ADwfqSXSdbliRftUR8mhaK7ZIiWOPvdSiEKF6ngDqELd49DSLJPMXMas2CbhGDbpFDkORd+eoLQkKAVCv4B99b2BT1kc8PaJY0KmWB4xEJAG9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTISAkGxfwT8YvI7Iq1YEq1UleMLxfDAzck5YoG9fzM=;
 b=gbtMGgOF8yXk+RnLgauxuEezxT+ng0vcNXwR2BvAtOhHniDeIPwV0pXzAtrnCJ6QJE+C7WaDsvNnlBnGkQKsaMKDcEkN9hx9Jbbc+f7jn+v0nywOt0RCpnPWOvSEMtBS/XmBrfGk2ZYZ9V68s6otMq4YqYQwNRSB2gX3vB37lcay9YRrYeHp2xxJfszv0CM2RPfIQiFgKxAFtcH27ZI2irZ4bq3ZsA50jtQ4vt2wgAPv64sKA0cYKOAHapwrjaiDJd/aBdTtbPR0sIrnOckTKmC4HZw4jDe4zPPD2DhG/UDKwWXDEI9z94b3AjaylBU9ajWxuIUc2wz6CleHwdE12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTISAkGxfwT8YvI7Iq1YEq1UleMLxfDAzck5YoG9fzM=;
 b=V1oYg35RMO4tKH8uiRl2QGA8qZsmF+kGTn2NiDvHLEsR6w2F2G1lycgNIagRFzDC9wrYa6Xjfd6LQct13aWcX05byz0dtwMLO8XI/iC5atQOcWPeCJhPNtGAbDyzc4yoy9OW+JF/Sc8mkT//S/+/Gj1P/kHpa6DqbMRYALJtdMl+/9Aiftn2Zbt9dn++zSbc2TGl9sUDRmKveFyXjRryljJFknHWuv2pA+ZBYEbn+rQ62BwZVnV3Al9QGwdiqEI6r0ZljxaBmME0P4R8oDBOjB8bvtOUy6r+saAK1kR+SqiuDEdS525SnfOmgcwtQvREJ3xscjlyEeCW2k5ge9edyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PA3PR04MB11156.eurprd04.prod.outlook.com (2603:10a6:102:4b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 13:50:58 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 13:50:56 +0000
Date: Thu, 5 Nov 2026 15:50:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
Message-ID: <t4cemsueavai2foshmtpdx5dro3ztrrjubbju3nekm3i6kyohf@s2rllhmufxyt>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <sashiko-outbox-191926@kernel.org>
 <sashiko-outbox-191926@kernel.org>
 <egj2sjr6palh4p7daxvw7t547eghkl5mzprjaaxzijtzg2ghpo@wahu23aivld3>
 <20261105133108.GR865646@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105133108.GR865646@horms.kernel.org>
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PA3PR04MB11156:EE_
X-MS-Office365-Filtering-Correlation-Id: 03044992-a7fa-4049-df8a-08df3b43d0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|23010399003|366016|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026121527099003|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	yVFMCyLW4g+mTD30r1+Ff5I6prl2kb7fpSsAphR0o4l6Lw5O9kVkeDWRr40fkdprMEErGWlpoVjFcBu4qscJFpAb4vJYofM6St/VR54lzfysCRXcl9/YxEAJ3X+lZY9P65yzG83OU01AnWVTHdomx3E/YByK73ILaAdN7bRvUtbkBge186YhUmMzJtWvxG/yJqatr8a+Yy640Ev7NHZYJHz3EXn62q5zJQyU54mpXRRzY4/tv8noTn5nhdzOWGPqjCgQOU+PSTDsQ6Xl2esgLNF8TGLg+lF9snJ73WgKYEnOsG288puhm0yszYQrs3BSJ/EomyZ2/GNgaKc3mq/jxyrgt6liQH/yVQsOs6UXayQJJ7MLs7c1xK9l1cdSCiDWOpniORk068GOgP8ZzVotG6WXJskAsBrI55NSirRo5ItwJidY5paRURVfz67x4MhQ4cykqQDMIzyFMTFbjgemAIlAZ/M+pAVcfTlYIhQqmKZMJMcpMbYboAaKvN5K3DafjKG2jj/+OsE+nqIw5HejVGxsTVOqFFMSTAQDnQXAVP8aoXGUS5GkGQR6zI47xLpGJP1pOSlRMAv4GlL9sGG1Cm7M4xerPpboPhXUBhsLFsV/QyANPnRLlj/1adXa+Mxy1lgPrrb4LSmGeB1bDhHNpcdo15iY6KtuEgx9RqNd9aA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRqiIQx6OvzrSMkY9OFQeisQTQzQrUxMLQ/DDwOcJLECNDrBKN8yTlJUSiKp?=
 =?us-ascii?Q?hyhxoZmoeo6cnLxNQgvKRjb3KRUdXCyv3bcKnkFsWg6QsCYOII7VJrx3a/Qy?=
 =?us-ascii?Q?k3rjIQm0dJY65lQDvMGBNKNCsz4ZNhOQ1T+sUp4Jqc4lbBo3YWrf3xHQ1fsl?=
 =?us-ascii?Q?tYr+61n3J6tUSn9xb42LyJ9gVlr2QvWSYTB9/aRRuC2gd06/kVSs13Gj13oA?=
 =?us-ascii?Q?R1lihhxOzU24Dw0y7Sx/T2UsOmlpZW7CKMd6etDdwLW+905X/rLNaQQXQF9n?=
 =?us-ascii?Q?oyKaJAQ/zhxyLkdFfoTVK76otgvkElr/fD3qoWYtTr120vz/fkUGcap9TRPo?=
 =?us-ascii?Q?afJAeWkqsyMqf+FWXv7TSLudOsHW3JkUmJma/Bf8pemjW77oMq33RPStbNDF?=
 =?us-ascii?Q?OQczp3TPuCOsRCc+fY3n+vAH/YptggYOcoNIm25EGHMPY8MAxmo2qRiH06IR?=
 =?us-ascii?Q?1MoLaLndOYcOYH2ixLLAADK+97xwSu8BBok8Zo6Z8s1vptAOjKvHQNhBxqhM?=
 =?us-ascii?Q?Nql8RT5Ofc3g5xKyq1BM2cqoea8V8TyuV5IPikhj+MvwmSaTmNrbDDmJgPrb?=
 =?us-ascii?Q?4Gp4a5lChbSUOMIp2Jw/HM10XHZgQqH1Qqu/mHJdhyf+TC5cI08SPJtBj2cf?=
 =?us-ascii?Q?ez/x9CsgY8H248Qrek0GlNpBNZBMBbrfeRMNft4cTxh8eD87b0SUyQ5ApBlh?=
 =?us-ascii?Q?mq1wp7MrkTgMt7SPPaR8MDeEEY2oQdotBvDn3a0EL7DL9FmkLfjfJ1H/Wp1I?=
 =?us-ascii?Q?xWW7PsYKUorVbzyA9qPXJEzXMKdeMuzcZniwckWcoQqWl3wI/IhGIVg5x2kM?=
 =?us-ascii?Q?FcHMntWbMpxX/a5owE0LwHINYG1y56xNqcwe6Jz6s8aPwXeuPNaMdqxSJEph?=
 =?us-ascii?Q?voZuqDjBbbmvDXktAIn8QsVvzCzbM7+r5ioNprdijA1AepybWTU3uNNJEkWj?=
 =?us-ascii?Q?9+PFyocK7Vs9jksoF5VRyl7N+sYMaiIgG2rIyi2rNE+G15v+UFM4MNNYGe8n?=
 =?us-ascii?Q?0SP6h6Vtl9PhMoeJofnkX61TFQALx4DEMvEl+NpTzO4gmZM89iGPN8GuFtaX?=
 =?us-ascii?Q?kCfarCi19jTZdaDlGZjx/NR5v6aPgGfrdFJYYTKoUMl49Q3zrcSNosnxnlf2?=
 =?us-ascii?Q?//NOQq4t0H0bk9Ftvt9ECo16ND49rnD36XaH61VJgqVIKMcG5AdG3zLxFJdh?=
 =?us-ascii?Q?VcKX8z917qMPaK8BST2iZQ1Q/GorFc0DAePxeyQxnFFaGQssClEIkfbSwS5P?=
 =?us-ascii?Q?TRf3mKGEQLvBbkKQD75P3AotvtVmlX1aSdTOJQSuyXEyRfKzNDrfFvDeY0tp?=
 =?us-ascii?Q?CvGpkGBrxaePLemXT2ZKJxKp90dyfNnjKH2UEr3r22MkGwpo22EUQzv5WoNO?=
 =?us-ascii?Q?uyZG2hAQLurT3/V3WJ2gqOqwo2mdp1Z/k3MZSK5r5FNo66IGChnaWWVpXJGl?=
 =?us-ascii?Q?YukI7M1hdORG2EX2PTeOLJnxtfFCN25zDa1npHcRkdOJ6X0KA5FL2j5b+KLe?=
 =?us-ascii?Q?P899RhW59+WH71Ih7fbUrN8+5S3J1QKqGBo/IUUnVcm4mPmlfklr9690te1T?=
 =?us-ascii?Q?gQA9mgqgbdcgbtDPhAGA0WS0lHnZy0EzI1nHja1/8VzxSHtcG4fUx5Pcg+If?=
 =?us-ascii?Q?OIFYb8A5JxRgXffJpIKGMbHQGPpQcm7HlMnytAEnUpHdjW/hGJR1LepGfPZ4?=
 =?us-ascii?Q?1IR4c4hfYN2HBaYcMI/0uSXUGF0vrw/CpAUAeIRW0Ebee8wnzJY3v3Lb16t3?=
 =?us-ascii?Q?jhmduYSOSHQDWHQNVqCKuv/CUJjuSWI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03044992-a7fa-4049-df8a-08df3b43d0e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:50:56.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S8jMKjRE7auf+ryg07pNXtLwtsQQNcTZSInmfc5mT1qEvRZxkEOJmPHQf7TsxyVwgqhOQGByLbtddqNUJk5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11156

On Thu, Nov 05, 2026 at 01:31:08PM +0000, Simon Horman wrote:
> On Tue, Nov 03, 2026 at 01:39:26PM +0200, Vladimir Oltean wrote:
> > On Sat, Oct 31, 2026 at 11:48:09AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > > - [High] net: out-of-bounds read in qdisc_pkt_len_segs_init() via generic_xdp_tx()
> > > - [High] net: shared skb->head corruption on cloned broadcast skbs in generic_xdp_tx()
> > > - [Medium] net: WARN_ONCE in skb_checksum_help() from generic_xdp_tx() after XDP resize
> 
> ...
> 
> > In short, I don't think this patch makes any of the above problems worse
> > than they already are.
> 
> I also believe that response can be extened to the overlapping feedback
> provided by netdev-bot+sashiko@kernel.org 
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

I saw the other Sashiko feedback, but I won't have time this week to see
whether all feedback is overlapping or whether there are some new points
which should result in a respin.
