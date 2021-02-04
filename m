Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7825C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:12:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751FB64DFA
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751FB64DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0DE9B274FC;
	Thu,  4 Feb 2021 17:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXzymX435yPp; Thu,  4 Feb 2021 17:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EB84E20023;
	Thu,  4 Feb 2021 17:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6980C0174;
	Thu,  4 Feb 2021 17:12:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB6BCC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9213B86CC7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ERCPuW9ufGu4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:12:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770135.outbound.protection.outlook.com [40.107.77.135])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C6F8A86CC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B07F0Wu/hAfccZLsfYLtel+hNlHWH2a7c/TYNArH0GKmbCEGSDjWkZV2m8sOYe+LfVLgiJFXvTgBX4CPiPe1oe9OTCeAZeNIURehFA4xNMr0xmSbXvkW2VdAvxtkX9ueDmc2AaXNWZTgUjbhuVmEYBj38A/02rX1qPxhiPButY+BLr1yvN+AEzUsW0u8mTJVwxwV7evJAkmnEXqAmMhwSoRrenZBcWUJLgY7+Wtf8R3KKCvMbzE99ABCV7gbswWEtywaOFh6tcphdfnQrp3sloW7T3u/9ueB4LjNEOc67DxUHNVbSvM96sIbCIvBG+gthch2JdZ8CLHi0wxUE2GgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZsx/AqAxbtrUh1BM/UkUEitlxP89ueP/CNNjw8SZ54=;
 b=hGnj/FwKtXpT5qdIGojYNbLuqnjPUx3AX2ZBkxL4Ubmn0IaPyuBMXXKhNpQn+YN5NExSekW754scjxS8bkZOw3T7Bz27OuQ73l3N/Eg16O4xNU8kV7SCjomCx5Y2kD4vTzIp+dTY4XElnuiaZOvf9HUj3XvpGFRcR9z9gKV6iok4zShvqh0G+rYtrvQfivVK2DhDJe435jyzXAfpI0IDjNkBE4gkxJvN+oDAGXFMgudsW9dMxuBmYOms0rWdT3Mu91lksJuS0+zpvQ66yN3pIpk2JXNy7Oxp2d5MNItW9AY1Y1G2Q+skJ2UY6bwOibaQuYJgieoKBAmF1Zuwg0hIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZsx/AqAxbtrUh1BM/UkUEitlxP89ueP/CNNjw8SZ54=;
 b=HrQ4WvuGoz5k36haj7vaSSpT5NC7NzBDiv7LRbfuxhxtFkz8F7yF30N3YQGOb3g05CPaqenwvRi94aKNUEAwiIxE8K53nY9TgNFOAqYM4zLvH4sDLLreF/hvTdE8r5RtVF1mtltxNuOV8j5zPU36z8oHl0s29dLkksGK5X20vs8=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1971.namprd21.prod.outlook.com (2603:10b6:303:7d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 16:57:00 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:57:00 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
Thread-Topic: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
Thread-Index: AQHW+j3qq5sQ0lOpw0S/7GiCHvmsdKpION2Q
Date: Thu, 4 Feb 2021 16:56:59 +0000
Message-ID: <MWHPR21MB159326FF807138DD759531F5D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-9-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-9-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:56:58Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34a429a6-9374-47da-9691-415aa7d0499a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90026fad-8335-4d54-b2e2-08d8c92de38d
x-ms-traffictypediagnostic: MW4PR21MB1971:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19710E3AB21403A84226C5E3D7B39@MW4PR21MB1971.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fy9QxIGg+PQB6CyZE0xacOEZAbHjyT+xlTB3I4mYNNJNjYjVnrIcdEefwpPzd2oJ5bP8b8y139yB0dn7kDwS2316+z71eIILl1XqoujajyFlxygUx0Ij+qkVNcXWmfPdvfgLNOD0YKWWT9MTtIDLwtCWCxtGBFQlHc4b+Pq0aMZilKtqAkzgrX1xAA93VJFLbTlKUHUVZrv2qxphQzZaHpuUWn+LeuJdOuP3F8GCbuEtmk7BNZ6eCuAF36o+fDS76r/TG+z/s7Bbh/gWQkcmZByRj8TNeQtcnmPV97Hxva1CjEioOmFpFwOq3gTp8VBy4OoEepetoe+T6QSTA/EoTSlWykowlailFA26eN72qHWDo1JqxYZmsBefnkZasbrLmhAJwXP+r5a8GB6vjVfTDKLosC6QpEi9NgUPUqB2vErp+ALJVtRnos16g/5M5gPokgRT/hBL/I+xJAF0t25ESTWBd76YcGTxTdks/mmLiBAPsCDT5GlxbwUzpTGSm5pjRO1XvMS/p59NHrRTkjyNvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66476007)(52536014)(66556008)(66446008)(86362001)(498600001)(6506007)(7696005)(8676002)(4744005)(55016002)(33656002)(7416002)(9686003)(66946007)(4326008)(5660300002)(82960400001)(76116006)(54906003)(71200400001)(2906002)(110136005)(82950400001)(186003)(8990500004)(26005)(8936002)(10290500003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sep6eGZaG9uPlMWOka8Xo5n/jAaedPECjIFPVJfUUBNorPTAc2O9iB993ose?=
 =?us-ascii?Q?ET0XYVC3tx9JkxxrelfZ4Tve39/sfQ/Uds75tqkGQRBPrM4+6PXSi9VXaHch?=
 =?us-ascii?Q?GyDLGYL3hvS77t3OLwUtKzR1HQ+FkoaOVSI9o3tEbBbhnZOo9VFI1UyOKgGv?=
 =?us-ascii?Q?BpRSw2+jLs65QYumwz78UUgK1MHUevSG6j85W5sm4tdb7Wx0N0vBYaNJnUq7?=
 =?us-ascii?Q?2jKpth8iP0OC9/blbiZZGWFDz43GxN9eCxFz5Kg5DXbgww9lHFzrJ2mZVcCg?=
 =?us-ascii?Q?uC2TusDKyPhPzpTUiEOhpmXIuagdIgSOpBb04utg0Y8U66j6QTsCopq8qbW9?=
 =?us-ascii?Q?p/AreVGeyvBXpdXrJF+x/4pebagZi4Gkw/RMmo5r4p3nMnjw6PnCrLhsbSV4?=
 =?us-ascii?Q?2iRuT5SBOykYEhs2j7neooeIMwN02EfFE8qpofllj/GLu3lBpwy276qejtGK?=
 =?us-ascii?Q?HMOsTCJ0t0xxL+MbToxyx184OseEx7JZ4sxJxjYGN1wDYrdxTxNeYnqK1tL/?=
 =?us-ascii?Q?ZoE1xrKO8dejZhMN/wdF3BCUKnEFW3lr/4g5cc6rAHePr80VZWCDVHWBbXIu?=
 =?us-ascii?Q?Yugvd751lPJRyQQ7f5b+xs+u/8EJrL5tF5MAlw+lCY9R5g6n0X28hBLo6ilL?=
 =?us-ascii?Q?cGdUhINRf7kQ6Jyhnl1LZCYGh4F5OLnnxBKg0S+xlPquJli23QHhjdjjFE/c?=
 =?us-ascii?Q?rQrMQfS0zhzTDot+pXy0C2SjeCSro7hGT71UJspUlY+3W39NrcHvx9EvYJ50?=
 =?us-ascii?Q?NwPxda+wm5NNhTAY77xAy3W9kWCRlDWTwqchc1ILZU8uHC/BafptH2eKEjOB?=
 =?us-ascii?Q?SObFeipxQYFbP6m8Zqre0nmrIX1UbU75CquF4NUDLA5RqSbowmDieY0a1d28?=
 =?us-ascii?Q?jtmgr3FDGe6cUov8n8wtCf+gq4arYueV1XvLbYA5s26JBRFVIldj/Y3cqHbN?=
 =?us-ascii?Q?Beo8ydZXl1OMgnfjaxWUGoX7yyzQsU2xMbHJkGKFenx9QCyuTYmVIKb37dib?=
 =?us-ascii?Q?CwNSWsIlQGZZgtj2ClsJmcjS4ybM9pLSguJQH8BTAaeeZrOThdkPAdnRu+++?=
 =?us-ascii?Q?5UEnAy3RDecViCZf23Y6IqjNh5T/wgPDbjS/093eN3wlXH1JGTzXFjV9yIGq?=
 =?us-ascii?Q?aB61rUOLr+FoUuNMic/sdE5bse1h39OelR+FYZ6bIGKscInV8XuX+60HO3lh?=
 =?us-ascii?Q?KYCEUdL3xBpHFf/szd9QFoKcL96XCCQ6h4L5UjUro3DOUmtIVn6fVpK+YAoL?=
 =?us-ascii?Q?/oFPr4zF2KN38O1uAgUJJzWv4da9VavDNkxyQ7YABSz0y/ywtYW/qrZVDU0D?=
 =?us-ascii?Q?qTYoMIrxsnHfXTMwoxHSuPdS?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90026fad-8335-4d54-b2e2-08d8c92de38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:56:59.9641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H17FC8O/nb0BziOFkktbdWVWGX1ElqLCooXESPiEOrhnC0+Gg2BLpfrq5pKLfSAMe5jLNVo7ECmPZQKCTFiVnl9QoLt6qLoCeCEnXwIGGcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1971
Cc: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, "open
 list:ACPI COMPONENT ARCHITECTURE \(ACPICA\)" <linux-acpi@vger.kernel.org>,
 "Kaneda, Erik" <erik.schmauss@intel.com>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "robert.moore" <robert.moore@intel.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "open list:ACPI COMPONENT ARCHITECTURE \(ACPICA\)" <devel@acpica.org>,
 Vineeth Pillai <viremana@linux.microsoft.com>, Len Brown <lenb@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Michael Kelley via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:04 AM
> 
> There is already a stub function for pxm_to_node but conversion to the
> other direction is missing.
> 
> It will be used by Microsoft Hypervisor code later.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6: new
> ---
>  include/acpi/acpi_numa.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index a4c6ef809e27..40a91ce87e04 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
>  {
>  	return 0;
>  }
> +static inline int node_to_pxm(int node)
> +{
> +	return 0;
> +}
>  #endif				/* CONFIG_ACPI_NUMA */
> 
>  #ifdef CONFIG_ACPI_HMAT
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
