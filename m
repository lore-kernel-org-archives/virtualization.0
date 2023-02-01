Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D228C05027
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 18:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7298610A0;
	Wed,  1 Feb 2023 18:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7298610A0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=awnW1ULs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnfvLNn2CRuM; Wed,  1 Feb 2023 18:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 533FD6107E;
	Wed,  1 Feb 2023 18:32:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 533FD6107E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CA1CC0033;
	Wed,  1 Feb 2023 18:32:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7791BC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 18:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5016D4087C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 18:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5016D4087C
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=microsoft.com header.i=@microsoft.com
 header.a=rsa-sha256 header.s=selector2 header.b=awnW1ULs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-3Wc81hyHo1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 18:32:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B2544067F
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::72e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B2544067F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 18:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntdJLe83+aXAhZLVdVI53VJEXDA/TTiLWZBe0sq8na9KVUl8EL5EZP60PNPUqGjRiqCvYTiYyKfVZ/B+bWhOG1SX4/hvtUWkmkh6LkyV6jet9Ek0ol4VkOVBvPJ+N2RO5PBl/4WAXW62Q5wluIF/+nr3q0J4csAmslS2tOyeKeIfkmzLD/VT214hSXkVOFheNYjw2E5hhSMjJ5TYKKWx6b3KzURV1IdWB8c5k7RtyKSSpN+3RDd7NA21VM/xK5CN3sRqGmk+fi7ysGXmK+crKLntzryRwoaG2U4YaCkF6ZAbg62RNzbS6kDe6Qy5B3mH0z9Ve2Rxr4sB51ctKsQLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnjsJlUdn4TISImb3mwTDhecC4ATi+uo1fUsu7+ifBc=;
 b=XVSTs0nASy7cvc2wDaLg0XSKR0lodu49DDPoSTF4z4ad0z4ooPk2tuoYz3IpzqcxlwoulQgbVKbMSsjuu/qQAHovLR052jXj7wMbaMZwrgsnyV2dCJ95NNRe5+XRfoStDvew1bKdNZn3XzQUtINZjiUV8cnTTF4HR72pc3zW/cMnCo/pAK6KUGPJ3jcUNxgFyGR4lNjlskRMMHkDJcK8HFg7sqbikCmUEZ2Y4d3h5JaF75b0zG1hPGQyL9XQxpFrGYfwbpnnLFqYdsfH/ROQLdHDe5Mk++jKmruLxbhaDqbTA2pN7Sz8NZIPlT16G8U+Ytusr28UilF5bgAXVlzRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnjsJlUdn4TISImb3mwTDhecC4ATi+uo1fUsu7+ifBc=;
 b=awnW1ULsuZQ0nTxxX7y40+Rgc4YdH0IGr1GZNBpLCFr0k04csIQUload2lIpPWyajzojcpncXL8UtVqE6irb+ZHXCR8oaMWCIrshsRiTCzLx1P1K4rHFAXjfkZUNu70wAyf1Nz18vfWI5XQaOvYNMfbkdLq/0YczXfprwYZfWNg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3516.namprd21.prod.outlook.com (2603:10b6:930:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Wed, 1 Feb
 2023 18:32:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Wed, 1 Feb 2023
 18:32:29 +0000
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
 <krzysztof.kozlowski+dt@linaro.org>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v2 3/6] Drivers: hv: vmbus: Convert acpi_device to
 platform_device
Thread-Topic: [PATCH v2 3/6] Drivers: hv: vmbus: Convert acpi_device to
 platform_device
Thread-Index: AQHZNZ9JXlHKvekU3Uq/tjJS/YXUy666YDpw
Date: Wed, 1 Feb 2023 18:32:29 +0000
Message-ID: <BYAPR21MB1688C6978F68D904ABC00911D7D19@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-4-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-4-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3634d1b2-429d-4775-a498-0848d232c942;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-01T17:50:56Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3516:EE_
x-ms-office365-filtering-correlation-id: a35106e2-31a6-44b8-7d46-08db0482ad01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFqKdxKMH6QbrDSMCXmezU/1dYTRWHU0wNT8mUHfOUezmXIN5AQir3sDSpfX2e26cOPvxBGDgYHHyseOcWnMTDcbdjIGiKdI7U6G2iK7eFUUrDG2aZQsmyqPUT5oR/IeB4L/hM7F5qO0Z5bKiu/HCTnQ+ftOmApPLMZc/4glcaNn3Cq+kM3zdVqxy/VMplG1JRU9gwHUHYcHKfl1qorc0LnAfJ/ZcGopY3HZjTL9wPYy3aPK91ddu2U7uC65Xi/ru44/Aok5wUl9S44ao5fUsnqo+uJH4QeDxsQCc5Qvql5xR4rkAsWCc7s42bXvMzuAHjQizuELY8D7qxtjfHBeWKpy+cM6n3yaB+oOAICg2pkutvkSP6zTYiJTpoBzZzAdf2yoJ2cW0LEDiucZ76XMKC2vKNPQ4xfY1yy+XZ2gU9sT7SY/5Hj+xSXa1CtPVcRq9ctOOBWMcizN6X6FHvx7jqhBnazHT/IkfvyGZ8mYduf5hN8v2trkZEVntWn5ic1Mki4vQvp5FPq056pgk/3AsUn0NQEbIK5OocvwghYE4Ojo1g3MdaMvKR9KaqcriT+5qMCFsKwl/G923hyE7RKHMSmW7Kq5qRew+AAHRmEX3pkVFaHTyUQFCQskvB8agMcdDJ5e9xRlkFBsWx2HePGSVS8e4MSrM/lmzVFO81gS8SC/WPouV+WJlP6OkPgp1ngP3pKgcsvQcPGPzScDnE7qd/SH4aVKEJZwK5k76WUM8oWiXtMFx1qkpYdQo6MfABTt/j7iq6+38ezPdl+if/adbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR21MB1688.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199018)(8990500004)(478600001)(122000001)(186003)(66946007)(71200400001)(2906002)(26005)(7696005)(10290500003)(8676002)(6506007)(41300700001)(52536014)(8936002)(64756008)(76116006)(66476007)(6636002)(110136005)(38070700005)(316002)(83380400001)(921005)(82950400001)(86362001)(66446008)(82960400001)(66556008)(38100700002)(55016003)(33656002)(5660300002)(9686003)(66899018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8z0zjA5PCc1i7scjcNuqGzB2CsJrK7K5Wvyo/8zoJRwmHFp4vaOZNbJWkJC6?=
 =?us-ascii?Q?Kg6O+ceM+wZy5wwupCtvH/YjkC7KDhgXQNCKjYwGc6jAtaSFro+9ZHPeN/Ee?=
 =?us-ascii?Q?5gNK5WzPwj9Bm14zIls+jjLAZSPL28bWb5OrVIcDu+gCqQH2ngaxUL+yHub8?=
 =?us-ascii?Q?sP+rktybT9pzJRLKvlEb5wFIQKblGE6ZxVKI/w4QY1ApkP64Yt5QQi6XC+HP?=
 =?us-ascii?Q?2jRTT9h1mOyeWDQcDh/PjedIVMDYygOR/q8fhwVG9TLMMeRVxNpyh44fF26I?=
 =?us-ascii?Q?IBZ2TVpoY6yYBRwsEMt2VA+5rH7XLVnasfEdo5mQxOKGRBx5WYEnA1GSroeQ?=
 =?us-ascii?Q?QSsAY5D3BU/oIshSEglllYDcV5E6hkKA9fwmtEeTqaGoDBjzA0z85JTnczyf?=
 =?us-ascii?Q?v4MY2GG+e52zXSr63Yy58f5f3tmkQbabgXM0rhJNhiuwOTiJ7Wi1XSB4T3Gm?=
 =?us-ascii?Q?ZW0ONKSUjVfCRvlonatjUcEFAkODeS6dUjY41xL7py2t1iM0pVFRZZ/a3/hb?=
 =?us-ascii?Q?rl79ptxk6flUU8c/Nfdd6vGZqpAWC1p690gOnskmK4uzT0etkcWfSlgYYOqY?=
 =?us-ascii?Q?sFz0Hdk/o13t972kQVsCMgs2v1zVIf5gveV74N3UPRhBMh0NmjNGUwv3q9sf?=
 =?us-ascii?Q?Cbsubsk861Dirpgw/YdwfkorYuFzU/P7nY6kc/iUCSeW/fBqcfzE5YlQ+tuL?=
 =?us-ascii?Q?oLu4g8jJvY0uDiaCkPa3kiHTfVuDm00pvoYxRxjW/VNButle3DnwpSdUSTYi?=
 =?us-ascii?Q?gJIrJ3mDHZhXh9Qdg0kz81wAbbV+xTCqVBQzyfczgUVae9CPyJp6jKkTaSfA?=
 =?us-ascii?Q?Ef0nf4Al7wywMGq+3h6SFN/Nx4xXzWiWWT6pTSCp1TNU+81mU4+VFcJtGj/z?=
 =?us-ascii?Q?Rsv6Q2koJB6s7iZQrIkFFlV3YVll74vRegyf2y2Fx7H01GMVvEAcW+/5ySLW?=
 =?us-ascii?Q?LtXg/uC/KOqjwgV45A+/rTL/OEtGktInIDD2DlFrhaAx6tSvmzGO6XgWq+C1?=
 =?us-ascii?Q?pT5Zcv7A0RM6L6A92H3PycjpucV4l1dgUAquYxUCqd0yZiv5rYkLOimyXIY7?=
 =?us-ascii?Q?Dv9kf7Nfu3a+3ElQWiz/l+OwjvrY8O0Dn1tJxYpKHRbtabVRnzw+MzpmKhtt?=
 =?us-ascii?Q?jDzNmg6Q0tzM6V0bGMbDj9zSEXy6M7vjxNMuSrx/F5UajnvSyvUy90nSXx2P?=
 =?us-ascii?Q?MMftWf45AAuOfflBCANY+lK8RjuYRyZuXU7yLyEO1Cx35VTuhX8CsX4Y+n6S?=
 =?us-ascii?Q?3c4kFk1lzkTCcLCuCld0LJ3kDw4xNidrDqIb3p7a2HFhHOESdQb5M1i1fbuj?=
 =?us-ascii?Q?pkex9kmDyC/gw2v5DGmLQg644qiMIoWt8xKLVLTIAL8wztG4FGKm2BqZJpjy?=
 =?us-ascii?Q?XUTehhODrF4e+AkppQG6x76iEDPnS+rBj13bsLMqSiW7B42+dAove60MLOAu?=
 =?us-ascii?Q?fULyY4iq6i0sHmIck2C2opkaavT1uTtgZ4PwWzF557V8DgT4/EsHiiKAOSKy?=
 =?us-ascii?Q?kUhkkttSEE9553Um+bMNa1QdP6VXaLcVYc1FNc9We74FcoGC9rct6b4STPkx?=
 =?us-ascii?Q?hEqkxLsg/jf4Dlw0HCAGWflIj67CYbBTfn9bCx0C1RCjsi3UBNULkKhS7KEU?=
 =?us-ascii?Q?Xg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35106e2-31a6-44b8-7d46-08db0482ad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 18:32:29.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyjO+Ynq7ekst3sFWnCsBkx8WqRS04nXRTR84et/PRXyw1yHQVQLrgxCrRUnJ0oJYEQlxI2O8wnWgr2zHdVfKOfijpvY67+TkZcQuklo/yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3516
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
From: "Michael Kelley \(LINUX\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, January 31, 2023 10:10 AM
> 
> Use more generic platform device instead of acpi device. Also rename the
> function vmbus_acpi_remove to more generic name vmbus_mmio_remove.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 78 +++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d24dd65b33d4..49030e756b9f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/sysctl.h>
>  #include <linux/slab.h>
> @@ -44,7 +45,7 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
> 
> -static struct acpi_device  *hv_acpi_dev;
> +static struct platform_device  *hv_dev;
> 
>  static int hyperv_cpuhp_online;
> 
> @@ -143,7 +144,7 @@ static DEFINE_MUTEX(hyperv_mmio_lock);
> 
>  static int vmbus_exists(void)
>  {
> -	if (hv_acpi_dev == NULL)
> +	if (hv_dev == NULL)
>  		return -ENODEV;
> 
>  	return 0;
> @@ -932,7 +933,7 @@ static int vmbus_dma_configure(struct device *child_device)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
> +		device_get_dma_attr(&hv_dev->dev) == DEV_DMA_COHERENT);
>  	return 0;
>  }
> 
> @@ -2090,7 +2091,7 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
> 
>  	child_device_obj->device.bus = &hv_bus;
> -	child_device_obj->device.parent = &hv_acpi_dev->dev;
> +	child_device_obj->device.parent = &hv_dev->dev;
>  	child_device_obj->device.release = vmbus_device_release;
> 
>  	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> @@ -2262,7 +2263,7 @@ static acpi_status vmbus_walk_resources(struct
> acpi_resource *res, void *ctx)
>  	return AE_OK;
>  }
> 
> -static void vmbus_acpi_remove(struct acpi_device *device)
> +static void vmbus_mmio_remove(void)
>  {
>  	struct resource *cur_res;
>  	struct resource *next_res;
> @@ -2441,13 +2442,15 @@ void vmbus_free_mmio(resource_size_t start,
> resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
> 
> -static int vmbus_acpi_add(struct acpi_device *device)
> +static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>  	acpi_status result;
>  	int ret_val = -ENODEV;
> -	struct acpi_device *ancestor;
> +	struct platform_device *ancestor;
> +	struct acpi_device *adev = to_acpi_device(&pdev->dev);

This doesn't work.  The argument to vmbus_acpi_add() is a struct
platform_device, which has a struct device embedded in it (not a
pointer).   to_acpi_device() takes a struct device as an argument,
assuming that the struct device is embedded in a struct
acpi_device, which is not the case here.  The resulting local
variable adev is actually pointing to some (perhaps negative)
offset within the struct platform_device, and uses of adev are
getting unknown random data from within (or before) the
struct platform_device.

> 
> -	hv_acpi_dev = device;
> +	hv_dev = pdev;
> +	adev->fwnode.dev = &pdev->dev;
> 
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2456,15 +2459,16 @@ static int vmbus_acpi_add(struct acpi_device *device)
>  	 * up the ACPI device to behave as if _CCA is present and indicates
>  	 * hardware coherence.
>  	 */
> -	ACPI_COMPANION_SET(&device->dev, device);
> +	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pdev->dev));

This statement seems tautological.  If ACPI_COMPANION(&pdev->dev)
returns a valid result,  why would the ACPI companion for &pdev->dev
need to be set?  The original code was setting the ACPI companion for the
embedded struct device to be the struct acpi_device.   I forget why this
wasn't already done for the VMBus device when it was originally parsed
from the ACPI DSDT ... 

>  	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
> -	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
> +	    device_get_dma_attr(&pdev->dev) == DEV_DMA_NOT_SUPPORTED) {
> +		struct acpi_device *adev_node = ACPI_COMPANION(&pdev->dev);

If earlier code in this function can get a correct pointer to the struct acpi_device,
then this statement shouldn't be necessary.  You already have it.

>  		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
> -		device->flags.cca_seen = true;
> -		device->flags.coherent_dma = true;
> +		adev_node->flags.cca_seen = true;
> +		adev_node->flags.coherent_dma = true;
>  	}
> 
> -	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +	result = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), METHOD_NAME__CRS,

Again, if you have a correct pointer to the struct acpi_device, then adev->handle
(like the original code) should be simpler than looking it up again with ACPI_HANDLE().  

>  					vmbus_walk_resources, NULL);
> 
>  	if (ACPI_FAILURE(result))
> @@ -2473,9 +2477,9 @@ static int vmbus_acpi_add(struct acpi_device *device)
>  	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
>  	 * firmware) is the VMOD that has the mmio ranges. Get that.
>  	 */
> -	for (ancestor = acpi_dev_parent(device); ancestor;
> -	     ancestor = acpi_dev_parent(ancestor)) {
> -		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
> +	for (ancestor = to_platform_device(pdev->dev.parent); ancestor;
> +	     ancestor = to_platform_device(ancestor->dev.parent)) {
> +		result = acpi_walk_resources(ACPI_HANDLE(&ancestor->dev), METHOD_NAME__CRS,

Similarly, if you get a correct pointer to the struct acpi_device, does the above
code need any changes?  I'm hoping not.

>  					     vmbus_walk_resources, NULL);
> 
>  		if (ACPI_FAILURE(result))
> @@ -2489,10 +2493,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
> 
>  acpi_walk_err:
>  	if (ret_val)
> -		vmbus_acpi_remove(device);
> +		vmbus_mmio_remove();
>  	return ret_val;
>  }
> 
> +static int vmbus_platform_driver_probe(struct platform_device *pdev)
> +{
> +	return vmbus_acpi_add(pdev);
> +}
> +
> +static int vmbus_platform_driver_remove(struct platform_device *pdev)
> +{
> +	vmbus_mmio_remove();
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int vmbus_bus_suspend(struct device *dev)
>  {
> @@ -2658,15 +2673,15 @@ static const struct dev_pm_ops vmbus_bus_pm = {
>  	.restore_noirq	= vmbus_bus_resume
>  };
> 
> -static struct acpi_driver vmbus_acpi_driver = {
> -	.name = "vmbus",
> -	.ids = vmbus_acpi_device_ids,
> -	.ops = {
> -		.add = vmbus_acpi_add,
> -		.remove = vmbus_acpi_remove,
> -	},
> -	.drv.pm = &vmbus_bus_pm,
> -	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +static struct platform_driver vmbus_platform_driver = {
> +	.probe = vmbus_platform_driver_probe,
> +	.remove = vmbus_platform_driver_remove,
> +	.driver = {
> +		.name = "vmbus",
> +		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> +		.pm = &vmbus_bus_pm,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +	}
>  };
> 
>  static void hv_kexec_handler(void)
> @@ -2750,12 +2765,11 @@ static int __init hv_acpi_init(void)
>  	/*
>  	 * Get ACPI resources first.
>  	 */
> -	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
> -
> +	ret = platform_driver_register(&vmbus_platform_driver);
>  	if (ret)
>  		return ret;
> 
> -	if (!hv_acpi_dev) {
> +	if (!hv_dev) {
>  		ret = -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2785,8 +2799,8 @@ static int __init hv_acpi_init(void)
>  	return 0;
> 
>  cleanup:
> -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> -	hv_acpi_dev = NULL;
> +	platform_driver_unregister(&vmbus_platform_driver);
> +	hv_dev = NULL;
>  	return ret;
>  }
> 
> @@ -2839,7 +2853,7 @@ static void __exit vmbus_exit(void)
> 
>  	cpuhp_remove_state(hyperv_cpuhp_online);
>  	hv_synic_free();
> -	acpi_bus_unregister_driver(&vmbus_acpi_driver);
> +	platform_driver_unregister(&vmbus_platform_driver);
>  }
> 
> 
> --
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
