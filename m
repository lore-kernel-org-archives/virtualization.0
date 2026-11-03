Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793705974;
	b=tbDpmP+DzwaKz88IUXlKuGGjEFuFRw5pEOxgNBcXQE7TAQcFeRP1SiTo1L3Xju+bYWGi
	 y7Y9dP9etsR5EmhGMmZoI0ZkErOVe9deSoLM60B+mhXdGhC15Nyz6H9feoLXElg0NsS34
	 VKx0NFWMHdtN5JF8L4gSWdTGQwTf5miVDWI8ArOZiFMeYVoNHaoal5Um9lgErq/7O6oMR
	 owZuE+giYSlRNgGCSUrxyAVKMCAH0AXN8TIkjg15uiYh8nIQ1sqX/jDX+onBgGY6tZA6X
	 hXHzml+L4d/5hOxYB1Ems21SdZ6oOdyoBFmCaSIk+fQbtXAv7S8mI5lGpgarNnfK3nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705974;
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
	bh=X2BaFLA8nX4B61bfMQbiTVXu6xfgGO+KsWU2iBYg3hI=;
	b=bwsBjgWAUWG/aXzxLP7CA1dtYjbNZAAjIsicV8gDfnN3U23/45/cst1NLc5sOv1B5zeJ
	 e/BovA/Wxrc1iOcg/ykwim6evDksSbZb8YJoOCtcNwpMzkGY6rJoC8bjdsgvjJmNstUDP
	 QljSZ13eAz8kV8Xo77R1AzhvO0OOo3qjZ9sA2VDOaHB6agmNb1K/voXXzfc6n/lFH1+vv
	 kmROg0tSmFSzNlUW8WBPhY882v6SKaALkV456EfPVdQG3VydUdXWO84TK/AzZe2HWxnok
	 0exJjyCnGXB9G/znJI2pWJtkotvb75UQHCiYRxnoRwSeRyuefOhaAs7UpcovQlQyH6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OIkreEit;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.16
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C77606A326;
	Tue,  3 Nov 2026 11:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C77606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OIkreEit
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKoW00blQV2+4DlGyqNJa/PBYqUUVOM/FJeWtcz19derT1Sg2yB567xjhi+gp6IBJo+n6UaFXIPXAvKZQW/S6sLiA6EphCoCi6kMnug3hJpRPe3BsarYY23oO2bDtKHV2eBcBdoXOuH24a2ulcdjmUPt+hMLHLnv//hmYHH0BVPHbY96sSdN3u5OwQWLlVfTLPrs0EIBgYQCHdr2clfKizBIW3F0AoMC7YSs0949Y2t9jussExF3ljofdV9+lXPI/ani0n2RAsHqgOJx7iSbuzaSMPA/RR7nmfXbTebhUcT6fb0SbGPC+ofuxz4mz+h1HdbAe8R75pbcKgclr8vMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2BaFLA8nX4B61bfMQbiTVXu6xfgGO+KsWU2iBYg3hI=;
 b=G53B1G57mj1JR8zY8yg/qMXVg+SdO3fSHRJMDLXzsIjuZQlzHZMjitqtYwEJsFVtqdXS6fR5WNe6Iowy235aHVNFLAfH6ApOkEWxLI/Ro2RAzSuiaUCLedBMDXXik5TH8DDcs6geeWemqVvpvvKCG5vnTkyVvQXaSI0SEO5lO7DTaVDRahcpMDqviMHIm+AEv+fpE1NBDCkOxpJyFrUNqnq+wJhu+uQvVN5PBP0XmA6vWyfGWhe2688jKpomIbtFuDzpUNrAdcGbffDcB5twGm9aIGhvVtNWfJ/BjJsA7wtyIiXrtq0DwZLQVvjd0eoJNUsESAF23YFosCs31MHb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2BaFLA8nX4B61bfMQbiTVXu6xfgGO+KsWU2iBYg3hI=;
 b=OIkreEitKdYDvNhq+s8x0T6havPBv4g+gvf5fymX0DkzHzcRACxsDhSEMaihOqDs7yQQl0EQucjSDpRSNcPPiP7zc28ORH2dWJoSJAhJX99APvbBQqfLhz3C/fAk8wnGl1VTfXQmRg9Ef3RoRtlXkdNHcSjdM27p8lzkuzeDCO7oMuFuwFPphFabyjuZAWtPzHP8+4M4VwYJVRu5xT+/psj3PASQcI5zY4866FaCJzB7MLz3VtFtPdlfFeqrLi9/+cT7o+nFoFFDJbNWPCnWwk4VIlGcW/6ptzPSb0r09mPG4jH3d2jLwz4DVndgGoXQof+6skYwaMYDN7XxG6ynSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PA4PR04MB7583.eurprd04.prod.outlook.com (2603:10a6:102:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:39:30 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 11:39:30 +0000
Date: Tue, 3 Nov 2026 13:39:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
Message-ID: <egj2sjr6palh4p7daxvw7t547eghkl5mzprjaaxzijtzg2ghpo@wahu23aivld3>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
 <sashiko-outbox-191926@kernel.org>
 <sashiko-outbox-191926@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-191926@kernel.org>
 <sashiko-outbox-191926@kernel.org>
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PA4PR04MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fd639d-9418-4fcf-76c3-08df399f1f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|6133799003|18002099003|22082099003|56012099006|261102123227099003|10067099003|261009223027099003|261022105027099003|261021121427099003|261022075727099003|5023799004|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ntcoydpHuRM/3PqUppaAKdm5TtN5xJNC93FO+0kaKgDJP1qQo1BvBWuIlDUgfL982W6S/yqEW1fBli2Taba+b7ZmK6zmNHYYj+TAuARKI/dmu/qUO7p2X63dYsn/V62Rc7ajwnZSW9pqr4NHLU6ewPWRSZmYkhOpxXTgOOZBSieQpFjLvKF8dEZINqtpexJ9coAADgPfhks9DRJShgl3voBI5bE+XufpfqlkYbD3Z0ff1aED1WC3XINw2WSQRbXyBl0/XX/F2JYxx8HAs6so2th5WqzJYqvQBc3mJX0k1UpSY7IE+YGD4SxBxnprNjKtNBydqAKXW13MAqSWb2qUd2Uarfa9JJXWgh4xD0Lp0jjMsWNTzGtmFtW85Y5WYA1Cra7rgLFizaIr17Nx8nGuSejP/fHIQrFdEJLX4XoNBbbjqWNxhxtWCcxs91CwurODD6oJ0G9O4PJjPvOEiaEZnicQ1Hp3mB/wOJ7ShJ7w4cj821VfYwNZydUKl4SFGTj4e/umYdX00tkzMOIf6sOYTSXR2AxGSvIaZp09iufetLLeFF1jhYe2JnjRnE7yZFjSDZvfSWmotIddr6zs5d4nji7L0AvUrSYAev5CUfq79DXCd9t3W+n2nOSvTWebMl8n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(5023799004)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTSYTXun90TkdhLxMqWz4mTVACCxCggdm4fWsQhZVF8zP4y/y3KCg+dRDaGq?=
 =?us-ascii?Q?OS8JqMHwzW725jt3MsxusC51ANg7shcOFsvAvdNpuUrOWuzqBfVuYnjWndQR?=
 =?us-ascii?Q?40hUZcM1aFFcbjq7ymTRgjjPDY5I81N4uiIKXpFU9tIMB8Xh+bXCR7fa+cKs?=
 =?us-ascii?Q?T4Sqzxc39aGhDrHT2Po9vzGKBVFo3dyR3jnXnNbLEn/xjhumF3wNuVoqGOjd?=
 =?us-ascii?Q?3Bt7NdLZe4qyiU3hao4m5gbCT526ATPtUv4GYuHNdKBSEtf6Hx8p3MLMx37d?=
 =?us-ascii?Q?3Av7lCy/xQaHK5RX5x3NexKwnZZbe3zGtzdWfn8EiOxQfRf/NxcNOBX2vfH7?=
 =?us-ascii?Q?Vm+edMNCDRqybC0+bFzMpQja9+PsFFR2/dACJWZQwYo9sXfFkr67AkFxEvdt?=
 =?us-ascii?Q?+5TwMv/09iNNTURWSiOSfyVU4Yam2hY9zb/G+DvSKGgUkZTlXv+dddIszIgc?=
 =?us-ascii?Q?9VI3SXk7iLao/RIrWcscSn9HKJRfhEqhD0S9hssSCsdk/0H4flEyA32u4x3O?=
 =?us-ascii?Q?2ghDurqYY/2OEvamqmCukjEp48VHkW0lqioh0/OymEh2PqoAY8yuV5aPEkwd?=
 =?us-ascii?Q?noyp586RvTjOvpAeMeGAd0oNRc4xhYoOtwW4Aq8rs/AbLqDJsBe230YMfA1f?=
 =?us-ascii?Q?N3UMCUZEiOmXNqpmfkV6q4iNQVIrzZPNADjEwH8EHEjBptV3Ekbyx5gJpjhs?=
 =?us-ascii?Q?57UZXnELEeeigEMQwygRtALQENewa/53vmXpbMehstwT0Fn0KG4rzVANv988?=
 =?us-ascii?Q?QFWmgoAG+bwh//GPRnh42FifaV6u0EJtd089V+MgYuU1fWh214m6jQG2q3PK?=
 =?us-ascii?Q?ueA6GB7vqx0E3yo0qsv+nGBk2jYSuPLuc2zDqqlH/SbkDJMzrp10bwqcXx9T?=
 =?us-ascii?Q?2vXidrmm67hL5Ds3fMHgp82lxQWI8q3bQueRck1aGZlNrasR3Rh0qwaqf9RP?=
 =?us-ascii?Q?aVZdB42welN0ROrsyoNffolirLapFzRjOhpYpcNSjRy4g+AdR0ft5GW91NI8?=
 =?us-ascii?Q?LlkFGgMo8mWP6vFOL+h/utjg4YeZ6CddEcsuGMIcG8VBa9dD4LwBF21JTrhc?=
 =?us-ascii?Q?+l8otksFZ8QWJFd6Pp/SH0uETq+NfJDZy4CgY0AzOSNJzdibtaV2+J+zQbc5?=
 =?us-ascii?Q?PDDE5/mjbfKrUO47KTTu3oulZfwo2uIZvhQBESmSZ6iCJvChJiIOgI5hAlYG?=
 =?us-ascii?Q?Twl8cQgnTNk00xslPf1WNDVjYwFw5irFYQqwhbG0cCdnMlEDXdoUYaNrpvN7?=
 =?us-ascii?Q?qjgA+LOcMFpw7NAz8dKp9X74uVvE802iw/OYZINxw4MUI7sYf6JJ6TIm3LAZ?=
 =?us-ascii?Q?buL2RjVPX58QIikOsYQ4bZDrtUdNQAS/ObfPQVHqVCOldK33ZPyfWNxigvo4?=
 =?us-ascii?Q?T4rU5U0z84tTQThZP7puN3NUkcgMIolITArem7Jkkkp0hr4DCJgYBDbldhSn?=
 =?us-ascii?Q?wMa/3ewdLfn7OlUdhFcnNgUUkGxbYoS2StLR/wZ5vDJKIyyw5Wsl8PVuesnX?=
 =?us-ascii?Q?F3H6W3Qpmks6KA2idimAgLvHHMYT9eZ8K23VTbVK0moAdzHjcnFWEL7Io5X9?=
 =?us-ascii?Q?Eopo6G/RZ4YXHcbiXf/msF/Hp1uby0YbrekRixCc53q9jYAjtkIA4w8GWnxX?=
 =?us-ascii?Q?6biiOpw4cnhbrtjJ6UYFPsogqXYEw99rGzk1P4iWgWcs+JG1CzByjqX6b0vP?=
 =?us-ascii?Q?i7tufeeUFb598iA3st2NU7RjdSx7zvGIT8pcmUij9UTXEiBsfPur9SpAlVPS?=
 =?us-ascii?Q?HwELzOdx/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd639d-9418-4fcf-76c3-08df399f1f5f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:39:30.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Et1aP5mpQIkF6aka58uJzyaP3AG4UZgaN8AS7bpgDqlVKG3Q7gcZR7wxowfYqWwGskMxriywUaIN/G0fzN8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7583

On Sat, Oct 31, 2026 at 11:48:09AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] net: out-of-bounds read in qdisc_pkt_len_segs_init() via generic_xdp_tx()
> - [High] net: shared skb->head corruption on cloned broadcast skbs in generic_xdp_tx()
> - [Medium] net: WARN_ONCE in skb_checksum_help() from generic_xdp_tx() after XDP resize
> --
> 
> commit 47b74c796cb5f05688236335aeb274a972cf3b13
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> net: validate xmit skbs in generic_xdp_tx()
> 
> This commit validates skbs in generic_xdp_tx() using
> qdisc_pkt_len_segs_init() and validate_xmit_skb_list() before passing them to
> netdev_start_xmit(). This ensures SKB_GSO_DODGY packets have gso_segs
> recomputed and unsupported offloads handled in software.
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 88860185f5832..e98d85a539916 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5855,23 +5855,44 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
> >  		    u32 act)
> >  {
> >  	struct net_device *dev = skb->dev;
> > +	enum skb_drop_reason reason;
> >  	struct netdev_queue *txq;
> > -	bool free_skb = true;
> > +	bool again = false;
> >  	int cpu, rc;
> >  
> > +	reason = qdisc_pkt_len_segs_init(skb);
> > +	if (unlikely(reason)) {
> > +		trace_xdp_exception(dev, xdp_prog, act);
> > +		dev_core_stats_tx_dropped_inc(dev);
> > +		kfree_skb_reason(skb, reason);
> > +		return;
> > +	}
> 
> [Severity: High]
> Can calling qdisc_pkt_len_segs_init() here cause an out-of-bounds read when a
> generic XDP program adjusts the packet head on a GSO packet?
> 
> In bpf_prog_run_generic_xdp(), when bpf_xdp_adjust_head() shifts xdp->data by
> a non-zero offset, skb->data, skb->mac_header, and skb->network_header are
> updated, but skb->transport_header (and skb->inner_transport_header) is left
> at its pre-adjustment offset:
> 
> net/core/dev.c:bpf_prog_run_generic_xdp() {
> 	...
> 	off = xdp->data - orig_data;
> 	if (off) {
> 		if (off > 0)
> 			__skb_pull(skb, off);
> 		else if (off < 0)
> 			__skb_push(skb, -off);
> 
> 		skb->mac_header += off;
> 		skb_reset_network_header(skb);
> 	}
> 	...
> }
> 
> When the XDP program returns XDP_TX or XDP_REDIRECT, generic_xdp_tx() calls
> qdisc_pkt_len_segs_init(skb), which assigns the signed int return value of
> skb_transport_offset(skb) (or skb_inner_transport_offset(skb)) to unsigned
> int hdr_len:
> 
> net/core/dev.c:qdisc_pkt_len_segs_init() {
> 	...
> 	if (!skb->encapsulation) {
> 		if (unlikely(!skb_transport_header_was_set(skb)))
> 			return SKB_NOT_DROPPED_YET;
> 		hdr_len = skb_transport_offset(skb);
> 	} else {
> 		hdr_len = skb_inner_transport_offset(skb);
> 	}
> 	/* + transport layer */
> 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
> 		const struct tcphdr *th;
> 
> 		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> 			return SKB_DROP_REASON_SKB_BAD_GSO;
> 
> 		th = (const struct tcphdr *)(skb->data + hdr_len);
> 		tlen = __tcp_hdrlen(th);
> 	...
> }
> 
> If bpf_xdp_adjust_head() pulled skb->data 1 to 20 bytes past the original
> skb_transport_header(skb) on a TCP GSO packet (or 1 to 8 bytes on a
> SKB_GSO_UDP_L4 packet), skb_transport_offset(skb) is in [-20, -1] and hdr_len
> becomes 0xffffffecU..0xffffffffU. In pskb_may_pull(skb, hdr_len +
> sizeof(struct tcphdr)), the 32-bit unsigned addition wraps to 0..19 and
> succeeds if skb_headlen(skb) is at least that small wrapped length. Then
> skb->data + hdr_len zero-extends hdr_len to 64 bits on 64-bit platforms and
> __tcp_hdrlen(th) reads approximately 4 GiB past skb->data.
> 
> Even when skb_transport_offset(skb) remains non-negative after
> bpf_xdp_adjust_head(), qdisc_pkt_len_segs_init() computes hdr_len and
> shinfo->gso_segs from the stale transport_header offset, whereas
> validate_xmit_skb_list() -> __skb_gso_segment() -> inet_gso_segment() /
> ipv6_gso_segment() later resets skb->transport_header and tcp_gso_segment()
> recomputes skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss) without
> re-checking dev->gso_max_segs.

The stale transport headers seems to be all pre-existing issues, based on
the fact that Sashiko reported it on this other patch as well,
triggerable from bpf_skb_net_hdr_pop() there:
https://lore.kernel.org/netdev/179290180493.3134.5235549211177646736@kernel.org/

As Eric says, the broken skb_transport_header should be fixed at producer side,
so there is nothing really actionable for this patch, I think.

> > +
> >  	txq = netdev_core_pick_tx(dev, skb, NULL);
> > +	skb = validate_xmit_skb_list(skb, dev, &again);
> > +	if (!skb) {
> > +		trace_xdp_exception(dev, xdp_prog, act);
> > +		return;
> > +	}
> 
> [Severity: High]
> Could passing skb to validate_xmit_skb_list() corrupt shared skb->head memory
> when a generic XDP program redirects with BPF_F_BROADCAST through a DEVMAP or
> DEVMAP_HASH?
> 
> During broadcast redirects, dev_map_redirect_multi() calls
> dev_map_redirect_clone() for each destination except the last, which clones
> the packet with skb_clone(skb, GFP_ATOMIC). In dev_map_generic_redirect(),
> skb_copy() is only called when dst->xdp_prog is attached:
> 
> kernel/bpf/devmap.c:dev_map_generic_redirect() {
> 	...
> 	if (dst->xdp_prog && skb_cloned(skb)) {
> 		struct sk_buff *nskb;
> 
> 		nskb = skb_copy(skb, GFP_ATOMIC);
> 	...
> }
> 
> When dst->xdp_prog is NULL, the cloned skb reaches generic_xdp_tx() ->
> validate_xmit_skb_list() -> validate_xmit_skb() -> __skb_gso_segment(). In
> __skb_gso_segment(), skb_cow_head(skb, 0) is only called when
> skb_needs_check(skb, true) is true, so it is skipped whenever ip_summed is
> CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY:
> 
> net/core/gso.c:__skb_gso_segment() {
> 	...
> 	if (unlikely(skb_needs_check(skb, tx_path))) {
> 		int err;
> 
> 		/* We're going to init ->check field in TCP or UDP header */
> 		err = skb_cow_head(skb, 0);
> 		if (err < 0)
> 			return ERR_PTR(err);
> 	}
> 	...
> }
> 
> If the packet is an IPv6 UFO skb with ip_summed == CHECKSUM_PARTIAL,
> udp6_ufo_fragment() skips gso_pskb_expand_head() because generic XDP ensures
> at least XDP_PACKET_HEADROOM (256 bytes) of headroom, which is larger than
> tnl_hlen + sizeof(struct frag_hdr). It then modifies uh->check and *prevhdr
> and shifts the MAC and IPv6 headers 8 bytes left in place via memmove() inside
> the shared skb->head buffer:
> 
> net/ipv6/udp_offload.c:udp6_ufo_fragment() {
> 		if (skb->mac_header < (tnl_hlen + frag_hdr_sz)) {
> 			if (gso_pskb_expand_head(skb, tnl_hlen + frag_hdr_sz))
> 				goto out;
> 		}
> 		...
> 		packet_start = (u8 *) skb->head + SKB_GSO_CB(skb)->mac_offset;
> 		memmove(packet_start-frag_hdr_sz, packet_start, unfrag_len);
> }
> 
> Similarly, udp4_ufo_fragment(), tcp4_gso_segment(), and tcp6_gso_segment()
> overwrite the L4 checksum field in place when ip_summed ==
> CHECKSUM_UNNECESSARY. When dev_map_redirect_multi() continues to the remaining
> broadcast destinations using the original skb, its mac_header and
> network_header still reference the pre-shift offsets in the mutated skb->head
> buffer.

Hmm, the problem seems valid, but AFAIU, the problem that __skb_gso_segment()
does not unshare the skb every time it should should be fixed in
__skb_gso_segment() itself, nothing actionable for this change.

If anything, cloned GSO skbs can already come from bridge flooding and
will reach __skb_gso_segment() from __dev_queue_xmit(), so the problem
is pre-existing.

> [Severity: Medium]
> Can calling validate_xmit_skb_list() here also trigger WARN_ONCE() in
> skb_checksum_help() when a generic XDP program shrinks or pulls a
> CHECKSUM_PARTIAL packet?
> 
> In bpf_prog_run_generic_xdp(), adjusting the packet via bpf_xdp_adjust_head()
> or bpf_xdp_adjust_tail() updates skb->data, skb->tail, and skb->len without
> updating or resetting skb->ip_summed, csum_start, or csum_offset. If a
> non-GSO packet with ip_summed == CHECKSUM_PARTIAL has its head pulled past
> csum_start or its tail shrunk below csum_start + csum_offset +
> sizeof(__sum16), and generic_xdp_tx() transmits it on a device without
> checksum offload (such as XDP_TX on a tun device without TUN_F_CSUM),
> validate_xmit_skb() -> skb_csum_hwoffload_help() -> skb_checksum_help() hits:
> 
> net/core/dev.c:skb_checksum_help() {
> 	...
> 	offset = skb_checksum_start_offset(skb);
> 	ret = -EINVAL;
> 	if (unlikely(offset >= skb_headlen(skb))) {
> 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> 		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
> 			  offset, skb_headlen(skb));
> 		goto out;
> 	}
> 	csum = skb_checksum(skb, offset, skb->len - offset, 0);
> 
> 	offset += skb->csum_offset;
> 	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
> 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> 		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
> 			  offset + sizeof(__sum16), skb_headlen(skb));
> 		goto out;
> 	}
> 	...
> }
> 
> Since offset is unsigned int, a negative skb_checksum_start_offset(skb) wraps
> to a large unsigned value, and either out-of-bounds offset triggers skb_dump()
> and WARN_ONCE().

Correction: 'offset' is int, not unsigned int (although this doesn't
change the outcome, since skb_headlen() returns unsigned int, the
comparison is made on unsigned values regardless).

So skb_checksum_start_offset() returns the offset between skb->csum_start
and skb->data, and Sashiko says that if bpf_xdp_adjust_head() pulls
skb->data beyond skb->csum_start for a non-GSO packet, this offset would
become negative, it would trigger the WARN_ONCE() and the skb would be
dropped.

I think the expected alternative outcome would be to do something like
bpf_skb_adjust_room() -> bpf_skb_net_shrink() -> bpf_skb_net_hdr_pop() ->
bpf_skb_generic_pop() -> skb_postpull_rcsum() -> __skb_postpull_rcsum()
does, and convert CHECKSUM_PARTIAL to CHECKSUM_NONE.

In any case this is something that needs to be addressed in bpf_xdp_adjust_head()
and bpf_xdp_adjust_tail(), because I think the exact same thing can
already happen even without XDP_TX / XDP_REDIRECT, i.e. with XDP_PASS
plus some sort of forwarding to the same kind of egress device (bridging
or IP forwarding).

In short, I don't think this patch makes any of the above problems worse
than they already are.
