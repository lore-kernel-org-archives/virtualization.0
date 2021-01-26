Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A39C433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 00:32:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E09E22E03
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 00:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E09E22E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2BC26203BE;
	Tue, 26 Jan 2021 00:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wMWWsSdSnblx; Tue, 26 Jan 2021 00:32:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5DE2620131;
	Tue, 26 Jan 2021 00:32:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39862C08A1;
	Tue, 26 Jan 2021 00:32:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2BA4C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B8E1420399
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tw6ofbgAAem2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:32:39 +0000 (UTC)
X-Greylist: delayed 00:07:06 by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
 by silver.osuosl.org (Postfix) with ESMTPS id F350720131
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj240ytOeAftgzAHtv277rk0rcPaXGxycX1ljRF0Ggp/knEsXq0guusgMnS5h2bsva2W6p0+W9VkO6ejo9uaZXbdEzeAsAaWU0pAF5z+BUvga2WDbf1aFWlRby3ef4mdA2Nhk9qSZxfxCdAffauTt+N6zZEZShtLa5v3e4t9vayYzHbyBbCm7y35qSSK8JZ3rnCl9VM5zdmMhVudKuWhh5y+TQ7vOVxRrWqGuAoPepxOSIFuecVGEd9AD9b+Gfbp/arzLA9rWvoDEGUSGU/Vr/vRZ+FSwnupRHQfVL0Hjo3eDVl+b9SWh2mReSOJeEi3j2FlDMRUvV/E9vnEMnJI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFED4gD4RHSpyUuZ0qI1HjioY9Uk7X/CocCy1zD0VSs=;
 b=fCShE5TVlca75eE/EOnENMbcdzJidIPVBCop8NK40yrh50WZpdP27T86d4+xFE1a4YKTbV+QebWqWxmBeyGCPrduIsRfK/1EyiO87FFL6ypkFKH31vSL6jB4Yu0FePsyminL+h6/iw9EorfY5uSxtuhsIp0fr2vUQXErPYLZt8PIOehQ1ilFEpz1QrW7gY0S8aON+Gi/VwcHwFG1xkZ9jsnf6rci2k7+/HCqwlJpuK0hgk33QLrvZuXY9HYclYd0Azwr5g5wEyDfFljw2SUWlPQJd7jEmpw5zd7bkgolsHZanF4CBmLz5gWhYa3hqSSrgjn+L01Dgn71K1n6LuxDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFED4gD4RHSpyUuZ0qI1HjioY9Uk7X/CocCy1zD0VSs=;
 b=OQMC+xqPkYdqUVS/1vxkBjeOBgfb53Fv3NMD4AqQp6DA15vPkgm9AT7/+oWsHC1bO5pgyDD+kfnijnzOyazmJnyYVFDQJs+4kuIQ7e23AVp97No7BELmxmclurwQyZcaP19Jd8nOBbM03XqoiM0B3fErSK9BngDgM/fDFWKhpP0=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0862.namprd21.prod.outlook.com (2603:10b6:300:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.1; Tue, 26 Jan 2021 00:32:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:32:36 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization if
 Linux is root
Thread-Topic: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
Thread-Index: AQHW7yPwbHRjbrp+3062gSh4P5hdm6o5FvSg
Date: Tue, 26 Jan 2021 00:32:36 +0000
Message-ID: <MWHPR21MB1593BE5FD96AF79193D6EAC9D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-4-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-4-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:32:34Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2394a8b3-a653-4d5d-a69b-2e425496b817;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e8ac8eb-9759-4d37-8a7c-08d8c191e171
x-ms-traffictypediagnostic: MWHPR21MB0862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0862193EAC7905E36C5E6F40D7BC9@MWHPR21MB0862.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezcfOIJ37E1WvJAj9xhleKldHOjhx1ox4sLCTzFHNVNwMqv8F0d9moPhgxVpaHZ25pxYWZOn8aEc0Ix6Eba8Ybp++qeQ9xvaKhswFyqf2/X4SrcsQPhX3TpCuoDZvUnF6WDGVacL9sAZq3wmgBb40ZUePpqWrxzElVMLWt0WW+3A//VysKhNKpd0cohJ7mZII6wAwb+oHo2NXCOoqqJEIBs1OLg8gNUYTzj1ts6h5AZ9p65V8CVTzkG2hvjrhMg3ZwE3ZPX1cGqOqGEO8d2a05G/Qt+jtTL4npEPA8K8SflTgHC53FIk36Xhs+jn7M81e8iq4e7TebRQgzGZNkvZmer45Edcq71ffQJa4S3RIQmRjv5fa6vhFoZHAIiRczCheQo3zDxm/Nd6lh10CJM0D/eojQwA662qJfmxAsop/8K9aN9agQiYYAUA5FinKA+nzJ5c5VcPyut0Et5heSLB+eTznIVE+uqexSkePtXylkWWoAba+//FWP4qkW6OLq6vq3JL41O6NEINanjXwx8uWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(7696005)(66556008)(76116006)(8936002)(9686003)(8676002)(66946007)(86362001)(66446008)(64756008)(82960400001)(82950400001)(107886003)(66476007)(55016002)(8990500004)(10290500003)(33656002)(4744005)(71200400001)(5660300002)(316002)(478600001)(4326008)(26005)(6506007)(52536014)(2906002)(186003)(54906003)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nYqoZSaNj3iNS3gn+ThJS3cxSR5QLiINrx4T6zSoHjF57cyEzq/QEnwiwgb/?=
 =?us-ascii?Q?dYL8GVBDf8R53X8B3FvRRYSyG+lEpugszqMczfZfCVa9hHb2JDQE7hDfAYBI?=
 =?us-ascii?Q?DnfDM1drOmNlHIkIEL3zYw+juV+glA6RiN2N3PqlgrXLMsAqj2GvZl6q4kU7?=
 =?us-ascii?Q?UUYbeWIUTDGmRMaMPhDe73azuIZD5Ejr6py4wAHob0/OHBdcECru4CTKZPvN?=
 =?us-ascii?Q?dv0HgHgSdJ9/c0YB1NXAzzEDbI2EGqv9kXMMnBkqkZ8KHN6KDhTwxrc6B6Yc?=
 =?us-ascii?Q?NmuQdlMo0XGZrzYKr80pyxFlXo/78OXOrexzgiQoTrge83SW57eRBrDpNX3H?=
 =?us-ascii?Q?O8V9uCB7HijiOSAkM/viA3RpddSAvxq0WyGEu0xbBUcVUyKALiuiBt4TraZU?=
 =?us-ascii?Q?UlLa8llkrwxso0Ye78phdliSzBWQnUo/Su2JE1Tga5VFEoQuvHWtkPPBrnuB?=
 =?us-ascii?Q?dRcBE+SQO6R+5uaDgVMpI8LLhMg+RJDCQWRiBz5zmsDMrQwOHqudlYQiaDCb?=
 =?us-ascii?Q?mOlMoPFoHiEfWWW8GKQ/YdpQwuJPpeHmbJ131rnNBUZeR5vrvFloSDkzXyqd?=
 =?us-ascii?Q?wLK1XSVMJHfRqWX2G7IN2TeUg0F6EVQMJdxlDqas3y2MQgkOVxwuFVEh15/U?=
 =?us-ascii?Q?LD6Tpzs3PeGVkAQJnywk0MDuPp+MrE0IlbgcmBCXJ3gUBd5z2EhgV8DKpvyK?=
 =?us-ascii?Q?PKkwBTRQZG/GtRR84HjUd//K+MMkMaJ7tUkRnTt4WTB1xcjosX22Dn4st0DN?=
 =?us-ascii?Q?oG2h0dydiLU8Z8mNNNyJ/O3ZmIVW5gWjj7rkErzavnq/mQBM5Xtkn1zKHQxZ?=
 =?us-ascii?Q?EbQpsevqyqOCF8RLpXMUvd/l5u/zgwua2rljXCfVDZDLLV/h+wZI3vhKlXep?=
 =?us-ascii?Q?cYQ/uWuoHrSjosj0YpHQ/FWcPyojYvz0fG1+QJ+EOeXLWN+spT0rC0D4iQao?=
 =?us-ascii?Q?7kHYVBHXVHG/pWSpHSPoW42/6r19aakTV7wosFj7dkzvQu4qU7xb6MGQpCv0?=
 =?us-ascii?Q?tcNf/bez5KiFC/9nDKQtwuy76xC53ZX0UwOXZJC/ciRhdmUpDZS/NRAfTtjp?=
 =?us-ascii?Q?ObB6iQp2?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ac8eb-9759-4d37-8a7c-08d8c191e171
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:32:36.7729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EvMcn6J52Eq1JU1WnWuf7uz4xQgSZXUYH2105iYiVv9IWey6OdR2/gB+NiLfiS4ijv7DA8Xgw2BUSWKB+Jp+MSYGvUcsy+fsCHIqPAzUJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0862
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> 
> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Return 0 instead of -ENODEV.
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d..ee27b3670a51 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
> 
> +	if (hv_root_partition)
> +		return 0;
> +
>  	init_completion(&probe_event);
> 
>  	/*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
