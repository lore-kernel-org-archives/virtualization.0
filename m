Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC01465A2
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607377; cv=fail; b=oZz3p2vXNSN0Ds/FZTFe2K6hfDYahtXtbsRn0YoQxQwZpzEcwvHL10N76EWTScsukLUartu6qmPgpIKaI0t2ppe8LsDFSi3vN+ZeP+LWd+p7h8WaujZWgg5V5gMcAQJZrcR9ZX0WBRw5a2HfxInCpRrbKMPFqe058VDnZ2IHDiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607377; c=relaxed/simple;
	bh=PbzrgdNJrVfm8dPo1UM6YgpGa2GPbYlHFUpbLZTSXnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SECSMUZ5GdWYvJ4thsYNsMQEZ6yYCnI3PMOUdCf1lJsDWGUHruObBGczh/jEySvwY6gm+/RWfULWSpGUP/GRjHrC1NsgjuNon9smuGZlL2dFqez5cHTdLFxO+98o+Yp0QmM2tM9U9svKhxW4wJWe8hdMjTH3A/pXV7TU5hJSffM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+e+OmEW; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+e+OmEW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMWIKzWHRWNKP/HTNHKlw/oqtT6J9/Qa8IGKSiIUMEz2n/5k0PbPi9FWK5spYdVPQRMLox8x7CsWxw0C+CzHtoKZ/WIcVwuk5g+xJyCWvwIH+FnuRy8Ib/NLX+j2qf0q+cysj01YbJP181n2cufWCsRcF/xPWFeYZ+33WzhEpFHtB6wNnoZvUicofIr+8xAdBHyM5Gpk5pk+FLGhF/YqC/vtx5gGDdbSjMQDwBkeOuS1MCt6VabXBrmbOfggBJ26OznuDMlGABLsulVNZZTYHLL0Uao8CrqqiWYg73o8TsfyX+IF7ixkAlh9risx9foWEifI58TwqJatGeHJvRj92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE2Z2bpZ5KiCrySMJ36EyDfgM7jRFngRigwxHeR2aeA=;
 b=Sxcqm5EqXV1bF6hBrvCaOxMBEUeCGHBJGyuYaRETGZaOf4fFYmp1/xN6Dd8TcNXXRgYnyKBrnuJpjfDhY/JBfuWwNG83JHxNTxsJelR5LEmaCXYjFdC6+D5rVa8fKnXgDfB7yov9Bbl7+hTSiyCJBbuGTOex9vfW56YKgOeOrzOZRFOrOlnCKf8vxAN2JPcNCwt6L7lGsQMrB3uJoJOLm6gbs6FYRkvVmYzvDFxqwJb6yD+rTx+hFuIsIcIpSzig1iLG3UU8da9D6v8Cf6bk8DaWQjdyptbqXWifx+Bk2vtJd33R/+ZKBDRt45SCN3x8UX/pOkweDJKJ18jo3FtsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE2Z2bpZ5KiCrySMJ36EyDfgM7jRFngRigwxHeR2aeA=;
 b=A+e+OmEWbcgwCZceePJYMpJqpjN4rZdRlEXzCd0Kv2N43O9Ml71AI7GiZ6eTUJYVoDhNBR7yz4s0atMJ8r9b4E5lT+XtHOpB4EmOY3BPcnXFblQ8LqTZvN83K/6AT1KTcgXnasUIlc47qpw/OI3GsEEDQh7JpNONOihd6inUCVfVjY7zDaTWIM+b/asRIq21YGgc29fdO3T/uBHr8VfoCcRKagwrJkfKyVpj6Bsk/Tt+jIRQOkI1L85xxJApgtAMmejXocwrqHfk2cA31pl8wpFmB/87k6spuv7cLOxYanzOoasaaZvkyIL+7q5vmZHkGXMCopy4Z5y7QJchyUxwJQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:36:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:36:11 +0000
From: Parav Pandit <parav@nvidia.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Thread-Topic: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
Thread-Index: AQHapTkyKWSHdlbG402zkv/WdkAkBbGVKZ6Q
Date: Mon, 13 May 2024 13:36:11 +0000
Message-ID:
 <PH0PR12MB54814D7C2081F336ADCEC341DCE22@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
In-Reply-To: <20240513212707.9894-1-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW6PR12MB8949:EE_
x-ms-office365-filtering-correlation-id: a979f4ce-eae8-4289-f376-08dc7351a747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OyuXatPx0hbSnzbUdDt6t2A5JHMfoxVxCaPRJFJsVXTV7ke3ImdHxMcDXQnL?=
 =?us-ascii?Q?Gldyl/oFrYSYrweJXdZwnpxCtLEfzN38IFekUMSzUchCarN+Z3T7IdLpV2hv?=
 =?us-ascii?Q?v0K1cQN8iTeUM6AsQIyfDA+wrePjKjmwNVvlLtRcGr8FqFFTKmMnYBllo3gG?=
 =?us-ascii?Q?mRN3RtROMfy6W1sfuLr4bw6rygGkzN6Lh+DCyBw22x78+StuxXYAi3C+rD8N?=
 =?us-ascii?Q?EmLGGg0IQR0iDA/j6MqcIqUJnwlm56qon5KD2MSWc1ubW5A/JsFGNarKYE7V?=
 =?us-ascii?Q?CQ04HHPRhplbYpJAZj3W5wpL/jEJD1d2Oupoo4PLWG0luVav7y4UID4fGxdn?=
 =?us-ascii?Q?VH2/Ha3cthSvR93gpFz7rWLVGTUZjiINrfpYUUIWqEpVNp1FXKptjYHGOo7j?=
 =?us-ascii?Q?hcpn8KNGmW2GAAf5ozvcJf7hj4PBiwKQ2VvEv5uhteZDi91524aZBEXfmz+i?=
 =?us-ascii?Q?AB8gRVGQlAo8Y4JlI8nTcPaN7mXmAdmPghNqeA4YfnNghprnhgbfF0xXZpal?=
 =?us-ascii?Q?VLNTY9shWEfV6ruin33SmzavFcXDbOkS+oVl9s8n64pX1pPEsZ6yyx3SrkKo?=
 =?us-ascii?Q?XvXgl8a7CRT2R3TKj7NcmyN0/ZHLtm3CaPGA262P4pU9cldc7NIlm5rav94l?=
 =?us-ascii?Q?6GyzcHAr4WVSotSp7O0dAkhEFmJ6i6LBjdkUEq+TyauWFbI79Mbl0OI/KkVj?=
 =?us-ascii?Q?H7YKHw5zQl9uYtrVzOoQyZZ+tY7Fn/GdlsqLZJktxQSWjne25FyTMtVWsqdF?=
 =?us-ascii?Q?eWIH1Az47iQKp9XNEewLlXVD78AxQdTBDGjVHXp9qGJrrlB3DG4Sl12T4YTN?=
 =?us-ascii?Q?nBcu98WytmxjbvyxV29GJ6DCziPXDWbLqWSlKOlfHI5L1PfzraOhk2f2F5nC?=
 =?us-ascii?Q?WgXGxBapEzp2uUXpRpGA0Oi2HIL9URoTvcMOXDwLjhDl6p4vMGAKdx30FeQ9?=
 =?us-ascii?Q?FxivRWqe067I8WfRaG/BpCADn4DFvjmS/QSIOvjd8NsOR8Wl+UGMho1JU8RK?=
 =?us-ascii?Q?ZhQ0/mGSMvIyfCgGgJx9cf1IjYdr2vUx+ghW72ZY4JxuhsucT/XrqNFwY/t6?=
 =?us-ascii?Q?6ykwPRdemfzklLjdbrpAb2xkk9BYWtfpqyaDXE540egOop4MGz24EwkJL9Mr?=
 =?us-ascii?Q?4R8wgcKyXhUumVWd5+p6iYooGW1rgBymEeAW5NzGf9yd/+GWVhc4xjpU6d7U?=
 =?us-ascii?Q?u1pn27g8fwonniws1WkArJvR6K3p8A83hMTqRv8rxC0hBbiPyAResZd6ELCG?=
 =?us-ascii?Q?iZHC04BSjmQLxfYiR2gs4M8UtDiBk/CTq7NppMUbKIft8of/t1NhQYsbIUmN?=
 =?us-ascii?Q?DlqAF5Hc8GQTsSpNeS9ZAeyAtLA/PJjDlq/t0hxkpjcwRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YlYprT7u5N5cbj/+YNt+D4cARdQOpTJj2lPJbwu8CLMi/VMgYwg+E72vl/I/?=
 =?us-ascii?Q?oNTONwX7FFzNXtQ7fgbFs1B7TwMe/ZdXBkWh6BN4oKqGS51efEBD03BXpXp3?=
 =?us-ascii?Q?G9OfyG037lDYj1CghIF/atc9+lcCXTqEFtUs0J3POFH0orIKi6ofybINS/nE?=
 =?us-ascii?Q?FsqTuQ+DW0lPBd6XuirPf29ge9B438cxZYVV+3dnvftnAYwXTvGshBizXNvs?=
 =?us-ascii?Q?icBNW2QKYGZe+8biTCBoGx80QzD4dLc9aUv5VqXL0DiRh7UpuuI+wCORH/ZM?=
 =?us-ascii?Q?70khUbSuQIFjOsh+jNmEWa6OZha3A3+38hMz0etHPJWvSiYh7mGK9031woPd?=
 =?us-ascii?Q?mgY2NXUqXI8ckZn1NFKv3VQL8VsGxKG/ugfeI3lK0++HMFuGpNDuRMHR3f0G?=
 =?us-ascii?Q?1GuwWjxuZuV5rFbqoK0XWfC7OfGjTpDFzloU5a52E0Rk3agcddp3gv9GH2G7?=
 =?us-ascii?Q?1O8npUHkG/G90Jn5Ou0RRT+csEnt9GAAJYZvGW/tbSkk9U1ModmC2Db0yV5B?=
 =?us-ascii?Q?ZrgXACwa/vxSd0s5tTl+hFXpWtcxeImmAJutVQCNqbenssRQB4xKMSoKlTEp?=
 =?us-ascii?Q?i5FoxCw2w0WApG9ltAxrGaTqkzJ2j2l5bNt+/+Q0a1TxdTc+mq5dO0L0MzqI?=
 =?us-ascii?Q?eJkXq85sg/MNZRiRTbHnrmYKlXCuYjO+a0HC/KuzzlqqODOJEts/ezupwIJc?=
 =?us-ascii?Q?53NT93t3aJ2ZTIBsvctjMseHaV7vEXKrGoyljK8ns8HY8EDvwYctqwWaLV3z?=
 =?us-ascii?Q?pxBq2lsRnjFn5zqOdTJ/4+EV1ODLcaHqIlO0if3DLqM+UM2jcd1mdYqREzO+?=
 =?us-ascii?Q?l2wX8mB6Hl06iHmfCIyibLF1AojncKAYvKNn6BTQAHlDMXIWx5uegeq4s+Fk?=
 =?us-ascii?Q?B5QL521/ilXdPR/0SpaNI9ca5QnHucQnlNPxRKDX+fb/fFt41mBtwpvf14T6?=
 =?us-ascii?Q?PVAWxqEVg58DMPGcfp5g0R0ofEIbxDGBUwj34pCHGCMznhnVQ5TsVpq1iQdk?=
 =?us-ascii?Q?Fn7b6P7cymoge8nlMcdbqtaYje10ECO4xZ4/Hs9dCc4feNH4Z7D6Rk/wDM4o?=
 =?us-ascii?Q?Zh2IxSC7e2qA02TgKZAZz4Vqq0yrD8WFoTq31xZhtnzBB+NbpRLiSO9t0BCv?=
 =?us-ascii?Q?hb+GsFl04ankXLQIWHqYbn6FBScKAia0YE2QS5hdH+yUYDCnb69ZTcikKGsa?=
 =?us-ascii?Q?ftAllBQJP/vwxk/z3SU5nNLQpbnfdRxqGH10IrRat+mfuFmyfeNllEv6jfkd?=
 =?us-ascii?Q?IeezjQCNSwvPmKjBoilYodhEF0QF9soWBy4IyCBlhuKVBwG1z+UQPB/DxDuY?=
 =?us-ascii?Q?Q5gXTi6E6xwLDqZ4hi0UG8Xp0tA67i9lWxYXPcfYy1k7rWoiPeGE+a36Culh?=
 =?us-ascii?Q?QuJ08c5feeBRXXCUEFt1qZNL1VmqtWlcLq+9qR/CW+p1V2RCQ74OPvlmyyrr?=
 =?us-ascii?Q?AneYiyIZGBW/WSeTQEUTFo+EjBRRTgz401hIV6swI55s/c3E3Un15RvcwkGv?=
 =?us-ascii?Q?I4zECsCL3yPabrRuQcAdAK72yA6Xq07HUcTM9oQlJRJEEDr+DGXIDAUAbasD?=
 =?us-ascii?Q?eh4lM7UPg0sWWSUgzrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a979f4ce-eae8-4289-f376-08dc7351a747
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 13:36:11.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxF7x2F7qKpmYFXiejO7FJj9kn9tfzu+IKBhzoSIlA1QTxJz7QmGoXdP5VnFIS9B7CaGphU2LpWDroLuBAw2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949

Hi Lingshan,

> From: Zhu Lingshan <lingshan.zhu@intel.com>
> Sent: Tuesday, May 14, 2024 2:57 AM
> To: jasowang@redhat.com; mst@redhat.com
> Cc: virtualization@lists.linux.dev; Zhu Lingshan <lingshan.zhu@intel.com>
> Subject: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
>=20
> Most of ifcvf code work for standard virtio pci, except for bar4. This co=
mmit
> makes bar4 only effective for Intel products, thereby turning ifcvf into =
a
> standard virtio pci driver.
>=20
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/Kconfig            |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_base.c | 17 ++++++++++++-----
> drivers/vdpa/ifcvf/ifcvf_main.c |  5 ++++-
>  3 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
> 656c1cb541de..dbf09f35bcef 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -44,7 +44,7 @@ config VDPA_USER
>  	  in a userspace program.
>=20
>  config IFCVF
> -	tristate "Intel IFC VF vDPA driver"
> +	tristate "Intel IFC VF and standard virtio-pci vDPA driver"

The virtio specification limits the subsystem vendor and device id usage fo=
r informational purposes only.
Hence this change/claim here for standard is not good.

I don't have objection to have per vendor creativity in the spec, but for t=
hat let OASIS commit to ratify the spec to use subsystem vendor and device =
id for non-informational purposes.
And amend the spec " (for informational purposes by the driver).".

>  	depends on PCI_MSI
>  	help
>  	  This kernel module can drive Intel IFC VF NIC to offload diff --git
> a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c index
> 472daa588a9d..47bc9b11c678 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -178,7 +178,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev
> *pdev)
>  		hw->vring[i].irq =3D -EINVAL;
>  	}
>=20
> -	hw->lm_cfg =3D hw->base[IFCVF_LM_BAR];
> +	if (hw->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_INTEL)
> +		hw->lm_cfg =3D hw->base[IFCVF_LM_BAR];
>=20
>  	IFCVF_DBG(pdev,
>  		  "PCI capability mapping: common cfg: %p, notify base:
> %p\n, isr cfg: %p, device cfg: %p, multiplier: %u\n", @@ -330,18 +331,24 =
@@
> u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>  	struct ifcvf_lm_cfg  __iomem *lm_cfg =3D hw->lm_cfg;
>  	u16 last_avail_idx;
>=20
> -	last_avail_idx =3D vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
> +	if (lm_cfg) {
> +		last_avail_idx =3D vp_ioread16(&lm_cfg->vq_state_region + qid
> * 2);
> +		return last_avail_idx;
> +	}
>=20
> -	return last_avail_idx;
> +	return -EOPNOTSUPP;
>  }
>=20
>  int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)  {
>  	struct ifcvf_lm_cfg  __iomem *lm_cfg =3D hw->lm_cfg;
>=20
> -	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
> +	if (lm_cfg) {
> +		vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
> +		return 0;
> +	}
>=20
This is more than informational and requires OASIS virtio committee to add =
section to indicate per subsystem vendor to allow its modifications.

> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>=20
>  void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num) diff --git
> a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c index
> 80d0a0460885..e89fd4d96ff1 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Intel IFC VF NIC driver for virtio dataplane offloading
> + * This driver also drives standard virtio-pci hardwares
>   *
>   * Copyright (C) 2020 Intel Corporation.
>   *
> @@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] =3D {
>  			 VIRTIO_TRANS_ID_BLOCK,
>  			 PCI_VENDOR_ID_INTEL,
>  			 VIRTIO_ID_BLOCK) },
> -
> +	/* standard virtio pci devices */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
> +		     PCI_ANY_ID) },
>  	{ 0 },
>  };
>  MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);
> --
> 2.43.0
>=20

