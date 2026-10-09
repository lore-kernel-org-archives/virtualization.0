Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF483C9892;
	Fri,  9 Oct 2026 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519804; cv=fail; b=lCApl9vdMkHRQ5t5xeHPTbLxWFBXpDZabDMj128xi22IfBISaprAJcfSy5FvOIb3ZuJJIky2jGw+W3yVzcwNKFKLo4a0EN9pQWHsedQ0jAdk3JzYOy9TNV8LWKUPNDGM4nSuqe7kZnluNI65RK+aHwuSr5PFccQNcEs2zRSLsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519804; c=relaxed/simple;
	bh=/teaRfJ0FQJ8HCBKuXaC4e7CIPnRxWk88MtjZPT1gmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUgdDhhCYFEMqtQw2Hzf/iFTAFpz+rKWsBnbcam9QSBO2+/coarUs5xq/cKzYBPMPtAOpIX525ZBxI7H20mNupZ2MTzf0P/5cZQzXfQMLqNISuXaSRO4ArxvkayE04qCM3ZI+I12U9T4RHaor2COlrPU9fkcvkWFc9NK+9H0V80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b9AEOfPm; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b9AEOfPm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5eMruy/wHNjH4EDNrPakYnFiJ1sFIhtXECOiCGMDTYvj8RIYQUKabkJisD+QXIwrVXBy4akAdIaQsyMFJbbSvIAkXV0OeNxZMe50rFUTB2hdshzSCOQsf4cTTZFV9nj1f4UIFuILd37UHcu0lkA25uoUPzxx8Rdms3YbZ+EAPH0RT7TfGJSTyCYGlwSP/q+Z3qNUEbh9VdL8KhGwEWU5XRaJb2cN8eXFZ+S6t2tk1H1VL1bsoiAZi57mCqYTKimv9E9iJ+H3oL4IdzD2US/eafvHVFaa+V5jlNaMao62B0rtuzA0huZXmRzdrRHQnurnb9S5B5xQ2nYVePRg5/Cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQCpNshqSh0LAzFaaWerENiJo+pM83yCqyLNpgaXzHM=;
 b=JOJEm4lMzn5mQ5Fk/XM4988zWLo6YY1FsKghcX36USipYmAIWLBp4dOmXET2OdLpfyZ+KPKm0DEWKya/Ikd1egxk+T/2Q/f3uK6/3HsWKCEnB8v6zo78/g1tkix6oH8EX2IU+Xa8lPAYDAyvDrvRYSuRjZ4mu/qpugK/M4jClQz2PMyPWcoGS/txgxrJwHzlmbvQWWhWOCoStvN4ENpk8H9JVxgTJPPbF3VNFD771JO6cM7LUQR72yVozRJh+S7Gj8P645YJJa3vV2OLRYh50FuchH4N7VL12xHRXh/cJLacPerB8FJE1xsPs38DHqATtOpmaGy6fEAx4VeX3jZNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQCpNshqSh0LAzFaaWerENiJo+pM83yCqyLNpgaXzHM=;
 b=b9AEOfPmEFBInq0DDdpiureMDJrijlsNBBxXFYRqS0h2JZ62suSpmZrP4nsVKATubPuCHRjetbyq6vmWj0ritpS2A2LnzMnkcSxSABL8has7bqMPHRnTJf6j9XT1/Q0zZL+EB1Evz/OaP+PwysVGc1klQ65LuTS/AGn+5604iHpMCR2fmLowuMD7aOaFIagVJu1VMDgZM8Xymhk0gcjfl/vkp43vpX2QaO7sFm+zRo2CUm8wcotTNogVd7A15KgsUZVxEyly8NQWfQowaj48jE25ZYoN2cQM0ek5NwFK7osWV9GkZuTmJPlbxqbL3CG1ZKt8S7Uujkr9OeuV2bd8MQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB206370.eurprd04.prod.outlook.com (2603:10a6:150:401::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:23:05 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 04:23:04 +0000
Date: Fri, 9 Oct 2026 12:27:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francesco Valla <francesco@valla.it>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add
 multiple vdevs
Message-ID: <ashtOTx/xhTsMnQ3@shlinux89>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <arKiOCGrWAKyc-bc@p14s>
 <arLawAw6kgFT2e0W@bywater>
 <arP06mWDehsIDh5s@p14s>
 <arP5AvA51GHrI8aN@bywater>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arP5AvA51GHrI8aN@bywater>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB206370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0ec283-7a50-41b1-aaa2-08df25bd0338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DreUnbXauPvsIOTtxnw08ffuSDpOMuRerxy3ipceHJSWlOhqP8EJqilwq7h58oDfjA91W+tPDKEFbIxDAo/3y4y2xnHKRotopFCA5soo7znon2Nnj1N8hhmrcM3FLvBgLj/QMudIEm78zyikORTFxJfmSAE5bqRm+3aepqTtYVFrd4ATHR8V7mD/AwjMZ0pUEQzuSsOj656llxy0xbt5/+lk9cNV68gEfYfvS+AxP0SaX4mh2fyfwfr2RzqFo7e6U4RXD11ijSaYeZGJK/mxyKfOiNhMc4AfOT5pge6YAaXXIyzU709c6fuPTIUxIMko9txCGU1FcOuuikaa/tApVvgCTxMVP+7Z8zh8PmWdHJ9fz4ybceJTJIpU26zMmscaFdKadHT2dgnTtC6JqD7Zyam0GmCdv3pzyo4IySx5wxmWAvbILC833EJsrWr4aKpg5+WUZ5AmAK8FqtFgm8dvAYfhbdX4KvqdsWH1jOuNmf00quUZ6PqCywLshIFeIklocLpPe911k07RCG0KEXp/oKTYlxMkbsLEwaVIrX5mGP1lDNC/3utg9f9xL7iCwWEwi/dWtyqu1mIhh9ttTqJdb5I6nV476ldJ5negbju/xQSnwAVFMdO0k/4TPVY/0cYQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p16KU7KyOuELt+VFp9QACACg0WFvXZ0uRlZY4g9CpTgAXDLic0KYmP1g5CWv?=
 =?us-ascii?Q?ePmVS+Ei7CuNMUqrbjTpfNlGZMSo0xu6Aku9LTt+wRCFqJM6uXF83a/a7lOS?=
 =?us-ascii?Q?Gg5/r9cmtSYuOmq3AJ6+mZ/hyHYWXASCqV5GBmwJm7TLpBN+63a4pOKrSMnI?=
 =?us-ascii?Q?FlkqSZOK8pIdGZrYxtgVbLkmcpr9CtA31xI8yCVQR0OJlqCUUx2lOic9cSLj?=
 =?us-ascii?Q?zIEGDsVUGyM4olMyjMRUA79e9wsbkPEwcSJnUWDm9Se00xaw0NzXyx5hRPO6?=
 =?us-ascii?Q?XhtptwYHtiUSvVbLyj2MNVAm5Paow3CbQo7S+qRRO1wpnBtboiH/Fa88P4rf?=
 =?us-ascii?Q?a8czQc87oECJJOATAZDWhpJGqUIp/L9hOta8OPVKhIoVvvPo9dhpI8Dg1Vw5?=
 =?us-ascii?Q?u+GfY0GT4rlygdFxTSWd+3P+jlE14g1ssf8rXudCa3Aks/c9xXjQ7Y9WV9cH?=
 =?us-ascii?Q?/QSR2ciY+tcKS3b1XN3weiVb2J/YHp1xxrmyBF9uuW7GqHBf66dVNUjQwiOw?=
 =?us-ascii?Q?wfRNNj23AvLbqAygcuxWu7DmsljVlfLeWOfFBDK+YPuY8o1GYPxm3H/TV6bm?=
 =?us-ascii?Q?YC4xEBR2b81aZQqTX+8abOaI76QXQO1UFvV5V/NfVh4svboXYDVDHbzODqrr?=
 =?us-ascii?Q?NXU5XidyqhVUuGhB5KfHuXoj7g/zyXfDFTqKotmhEkoyjt/6LbqjCJrbSPfv?=
 =?us-ascii?Q?YGFhpzNKK543bloknzTf54OYOh068DcXgI7UoX46f5QhxUuEEN1XxclgwSE/?=
 =?us-ascii?Q?WtspJLo/5nyeQtpEb+4vCaguTXl3/kmSRanNqCfqwYGOc+V6P3thkj5HkX8R?=
 =?us-ascii?Q?kp7ufMtPBvgiqr/ZwrtqzLnntUshMYEg9mP9O/q6LLc5SHLTgjMxkzmpaAEM?=
 =?us-ascii?Q?3bdY9Uvl6gQfB4Ki4ZUqzG9mxD9DDsXbrc885O8QsJkkr8/Y9GNxsGaJ+6EG?=
 =?us-ascii?Q?CMam3+cXaZZkzxYQ7j3sjvV8WKS8xebUMQ1D6kQaCjgIkMxTznaHqd05wxf5?=
 =?us-ascii?Q?Rg6xhM+FCV5kWg28TIUIGH3VBfkigDJzh9ID003NKYzvfBUNpgkTKPIvCO/y?=
 =?us-ascii?Q?zZL3NvOM1r64MkVDSv8/cWoAfFQK33Z+vwPVp73KXhH389sUfUlYzb8li5gP?=
 =?us-ascii?Q?2iOYd9RtbZh+KjHMLsYIy8S7bBwOP8AfUitJwO0DKwcW4iyc6OOKNbbbRHbt?=
 =?us-ascii?Q?Aw1Z3/4NeWpt1ITWhcprCk9k1ZTSK84JlIE0K5POZHdBPcTQvwqs0/7OwGZO?=
 =?us-ascii?Q?ne/SZIzvBXc6JTzY2t1A8BySA78xhjCoSGHAqXGMScX/8NzzDv+Ev6bteD6J?=
 =?us-ascii?Q?/LJE3ypWs+AHBZFFdxoLRhX5V3WSF0dY2+dLW+at/q7buinueBxLFguegpgr?=
 =?us-ascii?Q?7bjr3gv5+HsI25++rpsHlOXjKmaXyAYSAc6KVXGmG1xQOWRa2DU+QOJC1KQm?=
 =?us-ascii?Q?NX6H23pGeKMzadeVECJpp9UvnCvJicB64T9Ji93W3ydQL2xrFzW4qPYXdOFf?=
 =?us-ascii?Q?dpQtnklo72DFDiuR30xXoYCdFUywq2whVg03k6HzqDC3t43WMiCxYTE7Spnf?=
 =?us-ascii?Q?FsxdP+t6Ikn2Vtw25KhCyB/1x74Nghu7QpTpN+8+7fVEUgo8XgAvrt9Yf9nc?=
 =?us-ascii?Q?wi/7vYUwmXy0b0qbcv8ruqNlE3pWdvXLKNPbN363mGB3bK+AyvyoDjFgKt77?=
 =?us-ascii?Q?GIn2np7wIgLopnZtcqC6TYvIrQoi0vsgp/SuRjHE7762pMBng0dRPwbGXtPp?=
 =?us-ascii?Q?6fykMyqX+bC/htdl+23U2+1ETjRzLwIu6dQsgaG/Sf5mWy4CUb6o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0ec283-7a50-41b1-aaa2-08df25bd0338
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:23:04.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGy7XcJQZ5ZiWpJOGL557XCcZVwXUdGzqQQGy86SGHSkjc0hAdluAJyfCgZt5mhbrYIOsSFRrWzgzLUobebH1domIm5EWfL0Rjplj5YkqZ2ROMNlBXqlgSN9KeqPNNoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB206370

On Wed, Sep 23, 2026 at 08:42:23PM +0200, Francesco Valla wrote:
>On Wed, Sep 23, 2026 at 09:48:58AM -0600, Mathieu Poirier wrote:
>> On Tue, Sep 22, 2026 at 10:19:48PM +0200, Francesco Valla wrote:
>> > On Tue, Sep 22, 2026 at 09:43:52AM -0600, Mathieu Poirier wrote:
>> > > On Wed, Sep 16, 2026 at 11:10:57PM +0200, Francesco Valla wrote:
>> > > > Add rings for multiple vdevs, as well as the required virtio nodes for
>> > > > I2C, SPI and GPIO functionalities. On top of that, add example
>> > > > peripherals using all of them.
>> > > > 
>> > > > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
>> > > > 
>> > > > Signed-off-by: Francesco Valla <francesco@valla.it>
>> > > > ---
>> > > >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++++++++++--
>> > > >  1 file changed, 119 insertions(+), 9 deletions(-)
>> > > > 
>> > > > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
>> > > > index bd14ba28690c..dfa3b122ac5f 100644
>> > > > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
>> > > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
>> > > > @@ -53,6 +53,32 @@ button-k3 {
>> > > >  		};
>> > > >  	};
>> > > >  
>> > > > +	gpio-keys-virtio {
>> > > > +		compatible = "gpio-keys-polled";
>> > > > +		poll-interval = <100>;
>> > > > +
>> > > > +		button-v1 {
>> > > > +			label = "Button V1";
>> > > > +			linux,code = <BTN_3>;
>> > > > +			gpios = <&v_gpio 23 GPIO_ACTIVE_LOW>;
>> > > > +		};
>> > > > +
>> > > > +		button-v2 {
>> > > > +			label = "Button V2";
>> > > > +			linux,code = <BTN_4>;
>> > > > +			gpios = <&v_gpio 24 GPIO_ACTIVE_LOW>;
>> > > > +		};
>> > > > +	};
>> > > > +
>> > > > +	leds {
>> > > > +		compatible = "gpio-leds";
>> > > > +
>> > > > +		led {
>> > > > +			gpios = <&v_gpio 18 GPIO_ACTIVE_HIGH>;
>> > > > +			label = "LED V";
>> > > > +		};
>> > > > +	};
>> > > > +
>> > > >  	reg_usdhc2_vmmc: regulator-usdhc2 {
>> > > >  		compatible = "regulator-fixed";
>> > > >  		off-on-delay-us = <12000>;
>> > > > @@ -89,11 +115,6 @@ linux,cma {
>> > > >  			linux,cma-default;
>> > > >  		};
>> > > >  
>> > > > -		rsc_table: rsc-table@2021e000 {
>> > > > -			reg = <0 0x2021e000 0 0x1000>;
>> > > > -			no-map;
>> > > > -		};
>> > > > -
>> > > 
>> > > Why is the resource table removed?  There is no mention of that in the
>> > > changelog...
>> > >
>> > 
>> > You are obviously right, the commit message here should have been a
>> > poem, not a form of hermetic poetry. My bad.
>> > 
>> > The resource table here is causing problems with how Zephyr is managing
>> > it at its side. If it is kept in a separate memory location and copied
>> > there at runtime by the remote processor firmware during its startup
>> > (which is the current Zephyr behavior), then there might be a race
>> > condition when the aforesaid firmware is loaded and started by Linux
>> > *and* at least one of the vdev drivers (here including rpmsg_bus) is
>> > built-in. In this case, the copy of the resource table done by the
>> > remote processor might - depending on the async execution of the two
>> > processors - overwrite the status bit set by the Linux driver:
>> > 
>> >   Firmware load and startup (echo start > /sys/.../state)
>> >                            |
>> > 			   |
>> > 			   V
>> >   The vdev devices get registered (by register_virtio_device())
>> >                            |
>> > 			   |
>> > 			   V
>> >   If a driver is built-in, it probes and sets the vdev status
>> >   inside the resource table @rsc-table.
>> >                            .
>> > 			   . (in the mean time)
>> > 			   .
>> >   The remote processor starts up and copies the resource table from its
>> >   dedicated section to @rsc-table.
>> > 
>> > Depending on the system load and the complexity of the firmware, the two
>> > operations can happen in whatever sequence, causing a race condition.
>> 
>> This would happen regardless of this patchset.
>>
>
>Correct, *if* the remote processor is copying the resource table to a
>specific location and expects the host to use that. On Zephyr (which is
>clearly outside the scope here) this can be enabled through the
>CONFIG_OPENAMP_COPY_RSC_TABLE option. I am keeping that disabled, and
>removing the rsc-table node here.
>
>I am planning to reason on this and propose a proper fix in a separate
>patchset.

The previous workaround for this was to add a delay in start function.

https://lore.kernel.org/all/20221102112451.128110-1-peng.fan@oss.nxp.com/
https://lore.kernel.org/linux-remoteproc/20230707232444.374431-1-marex@denx.de/

>
>> > 
>> > This is somewhat masked if vdev drivers are built as modules, as the
>> > devices does not probe immediately but only after the modules have been
>> > loaded, giving the remote processor time to start. Note that this is not
>> > a solution! but a workaround.
>> > 
>> > If the rsc-table node is not there, the startup logic falls back to the
>> > classic rproc_elf_find_loaded_rsc_table().
>> 
>> We can't remove @rsc-table to make a problem go away.  
>> 
>
>I need to re-take a look at the NXP SDK to understand what's the real
>purpose of having the rsc-table here. Judging from the commit message
>that introduced support for such facility [1], it seems the SDK is not
>really using it.
>
>Maybe someone from NXP can comment on this?

Linux needs to parse resource table to setup vring. When RPROC(remote processor)
is booted by ROM or System Manager, there is no elf for Linux to use, so a
pre-defined address is used rsc-table.


If RPROC is booted by Linux using remoteproc, rsc-table in DT is not needed.
But RPROC is not aware it is booted by ROM, U-Boot, Linux. So it will always
publish the resource table to rsc-table address.

And we need one DTB/Image to support mutiple boot cases.

Hope this explains.

Regards
Peng
>
>> > 
>> > This is specific to i.MX platforms [1] and is probably not normally an
>> > issue because - as stated in [1] - the offical SDK from NXP seems not
>> > to check the status inside the resource table.
>> > 
>> > > >  		vdev0vring0: vdev0vring0@a4000000 {
>> > > >  			reg = <0 0xa4000000 0 0x8000>;
>> > > >  			no-map;
>> > > > @@ -105,12 +126,42 @@ vdev0vring1: vdev0vring1@a4008000 {
>> > > >  		};
>> > > >  
>> > > >  		vdev1vring0: vdev1vring0@a4010000 {
>> > > > -			reg = <0 0xa4010000 0 0x8000>;
>> > > > +			reg = <0 0xa4010000 0 0x1000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev2vring0: vdev2vring0@a4011000 {
>> > > > +			reg = <0 0xa4011000 0 0x2000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev2vring1: vdev2vring1@a4013000 {
>> > > > +			reg = <0 0xa4013000 0 0x2000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev3vring0: vdev3vring0@a4015000 {
>> > > > +			reg = <0 0xa4015000 0 0x2000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev4vring0: vdev4vring0@a4017000 {
>> > > > +			reg = <0 0xa4017000 0 0x4000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev5vring0: vdev5vring0@a401B000 {
>> > > > +			reg = <0 0xa401B000 0 0x2000>;
>> > > > +			no-map;
>> > > > +		};
>> > > > +
>> > > > +		vdev5vring1: vdev5vring1@a401D000 {
>> > > > +			reg = <0 0xa401D000 0 0x2000>;
>> > > >  			no-map;
>> > > >  		};
>> > > >  
>> > > > -		vdev1vring1: vdev1vring1@a4018000 {
>> > > > -			reg = <0 0xa4018000 0 0x8000>;
>> > > > +		vdev5vring2: vdev5vring2@a401F000 {
>> > > > +			reg = <0 0xa401F000 0 0x1000>;
>> > > >  			no-map;
>> > > >  		};
>> > > >  
>> > > > @@ -149,8 +200,67 @@ &cm33 {
>> > > >  		 <&mu1 3 1>;
>> > > >  	mbox-names = "tx", "rx", "rxdb";
>> > > >  	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
>> > > > -			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
>> > > > +			<&vdev1vring0>, <&vdev2vring0>, <&vdev2vring1>,
>> > > > +			<&vdev3vring0>, <&vdev4vring0>,
>> > > > +			<&vdev5vring0>, <&vdev5vring1>, <&vdev5vring2>;
>> > > 
>> > > Who is using vdev5 vrings?  
>> > > 
>> > 
>> > Another thing that should have been in the commit message. Vdevs are
>> > defined, in the Zephyr application I am using as PoC, as follows:
>> > 
>> >  - vdev0: RPMSG (tx and rx vrings)
>> 
>> To be backward compatible, there has to be a way to make vdev0 defaulting to
>> RPMSG.  It would also be nice if bindings were define for RPMSG so that it can
>> show up in the list of remoteproc-virtio devices like i2c, gpio and others.
>>
>
>What vdev type is inside vdev0 is up to the resource table (i.e., to the
>firmware running on the remote processor), not the remoteproc-virtio
>framework.
>
>Defining bindings for rpmsg would today be... pointless? Since no
>hardware needs to be described for it. The same goes for virtio-can and
>virtio-entropy.
>
>> 
>> >  - vdev1: entropy (single request vring)
>> >  - vdev2: GPIO (request and event vrings)
>> >  - vdev3: I2C (single request vring)
>> >  - vdev4: SPI (single request vring)
>> >  - vdev5: CAN (tx, rx and control vrings)
>> > 
>> > vdev5 is not represented inside the devicetree because the can-virtio
>> > driver registers a single CAN network device and has thus no need for
>> > such representation.
>> 
>> Then why is it part of the remoteproc's memory-regions?
>> 
>
>Because a vring description needs to be present for it, or the
>remoteproc-virtio won't be able to fill the entry inside the resource
>table.
>
>> > 
>> > > >  	status = "okay";
>> > > > +
>> > > > +	virtio {
>> > > > +		#address-cells = <1>;
>> > > > +		#size-cells = <0>;
>> > > > +
>> > > > +		vdev@2 {
>> > > > +			reg = <2>;
>> > > > +
>> > > > +			v_gpio: gpio {
>> > > > +				compatible = "virtio,device29";
>> > > > +				gpio-controller;
>> > > > +				#gpio-cells = <2>;
>> > > > +				interrupt-controller;
>> > > > +				#interrupt-cells = <2>;
>> > > > +			};
>> > > > +		};
>> > > > +
>> > > > +		vdev@3 {
>> > > > +			reg = <3>;
>> > > > +
>> > > > +			i2c {
>> > > > +				compatible = "virtio,device22";
>> > > > +				#address-cells = <1>;
>> > > > +				#size-cells = <0>;
>> > > > +
>> > > > +				eeprom@50 {
>> > > > +					compatible = "atmel,24c1025";
>> > > > +					reg = <0x50>;
>> > > > +				};
>> > > > +			};
>> > > > +		};
>> > > > +
>> > > > +		vdev@4 {
>> > > > +			reg = <4>;
>> > > > +
>> > > > +			spi {
>> > > > +				compatible = "virtio,device2d";
>> > > > +				#address-cells = <1>;
>> > > > +				#size-cells = <0>;
>> > > > +
>> > > > +				sram@0 {
>> > > > +					compatible = "microchip,mchp23k256";
>> > > > +					reg = <0>;
>> > > > +					spi-max-frequency = <20000000>;
>> > > > +				};
>> > > > +
>> > > > +				lcd@1 {
>> > > > +					compatible = "adafruit,yx240qv29", "ilitek,ili9341";
>> > > > +					reg = <1>;
>> > > > +					spi-max-frequency = <10000000>;
>> > > > +					dc-gpios = <&v_gpio 21 GPIO_ACTIVE_HIGH>;
>> > > > +					reset-gpios = <&v_gpio 20 GPIO_ACTIVE_HIGH>;
>> > > > +					rotation = <90>;
>> > > > +				};
>> > > > +			};
>> > > > +		};
>> > > > +	};
>> > > >  };
>> > > >  
>> > > >  &eqos {
>> > > > 
>> > > > -- 
>> > > > 2.55.0
>> > > >
>> > 
>> > Thank you!
>> > 
>> > Regards,
>> > Francesco
>> > 
>> > 
>
>Thank you for the discussion - is helping in defining further
>requirements and constraints.
>
>Regards,
>Francesco
>
>[1] https://lore.kernel.org/all/20240719-imx_rproc-v2-2-10d0268c7eb1@nxp.com/
>
>
>
