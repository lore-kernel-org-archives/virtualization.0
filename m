Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F79C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:54:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D076A64E0F
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D076A64E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FD7587239;
	Thu,  4 Feb 2021 17:54:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzEVRPNGlk09; Thu,  4 Feb 2021 17:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7262487202;
	Thu,  4 Feb 2021 17:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52EB2C07FD;
	Thu,  4 Feb 2021 17:54:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A462C013A;
 Thu,  4 Feb 2021 17:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3CCF8685E;
 Thu,  4 Feb 2021 17:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6zJuv9oNO5RI; Thu,  4 Feb 2021 17:53:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 99A958685B;
 Thu,  4 Feb 2021 17:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzkTqxjUGoR5kW1t64coOS5sOmoX5ToSYa6uRLcdQcn/5JeKd7IFwQph66g2RTkoCWhgjlZxsb0QYLnUEnZ1F+kxvaHwaJfzXMOTRmeSVRawTTN71baG8KPxJKgzzw3+ISDNlga64YJrc7Rlh+mws7qje02OpSeDpVdA2ZW0Csn8PojG+sGUA5FOyq+Z1XvRjyneJcDoR9hoRJ40ISyNn9UYAGK+/9iMtDAWBRsyHKjE8MXOG0YHO0bt7KvFDhKbQPHK+iQrDNcoDuYOQYfXhsIzEPulmC/SbpMGriJLyGt4NhEcD1e4gzCIohFp47/Qv/kkksiKqMAJrxzvbPi16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a15breN6v7/6RZ8assTbzjyUpkox5g6VCUQvJu3rxI=;
 b=Xfb8fi7XM4sk9PdswCAzVYQr2D/CwphQ8TajTGJQRvoCeAcWyIby6rqIBQDo8W8F/fk+Out6Jl/EHTBqKe0/LOEdLWRbbHnaCGm4Cc0/OP5xvgcJFhfP6c0e/oxaIU7SdxPSNkh6+YBCX0pSEENo9GRDW1xVpqcPXM+ERuf0qgz4QMGEi6J0NGrsv+Cgf3UlZZvkmJ3MBcqIWEQG5+UkE5CQ9h0sTcSOyLUYSaPLiFjCljuaFTD6Fel6Gc8fNBQhfsKNNvEJYm2cwzez5GjNuuT/Ni7CZ8W1Zd3KYxE2SH1SxI/olFXPS9zMlgJsqgmbBFbiJcW/UyelkpbIlhzhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a15breN6v7/6RZ8assTbzjyUpkox5g6VCUQvJu3rxI=;
 b=HAIv6KsykTy+BBqf7BWzhkOCa5jHRLFnehMCcQ+pXbDZsh5bb+BZ1hF4vk5aohgIFsTDL8oUF2/fyTy4mkdcqnOosx5LiCSG/IaYHAGSwK0koFhXB66Sr3e7eW518zxSx6sQpI+vZhpGnmIhU9iO9jLOPceoPIlTcFj/KHfjnXk=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Thu, 4 Feb
 2021 17:53:55 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:53:55 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Thread-Topic: [PATCH v6 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Thread-Index: AQHW+j31sX8XTKaHaEW+K0rkDWqrRapISLLw
Date: Thu, 4 Feb 2021 17:53:55 +0000
Message-ID: <MWHPR21MB159329D4EA13215C208D7828D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-17-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-17-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:53:53Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef2c78a6-f632-4744-a1c1-679068bd2287;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 949aa3eb-507f-490e-508e-08d8c935d74c
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB087360720F5F0F8A1F0C540AD7B39@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eguCWD75ZeKlC1x8rCdqJn75BSg1oU9+ceoFGDP5Ju7lTd38Si02+u46gaQRz2ie551/P6t2rbBAN4KjWv73mXLYQCavJeWRD6+H5ODmvaovjhL56LPFCQTELuNlwJIsvgBxJKz/wupM3uDkJogXaLF7nzafJTZj/MR+QB6QNz5ov2R98Fy8FJ2UOmas1ARKuw11Ft3ec42WMbr5MNrvNUtUURRB6lHbmSdfPpqkh35NBQ5dOMxkKhmiOqPZtZxbpJ5LUwcKCYD/fmi3WUSjNode3ycf/793pFWG3ghDaPRjCVVdIi8l+gQPRbqcmnmEWX9om9mGlr+krD2bsD3CjjH2HdpdgxFG1dtGlUo9BOFjFRqzJvf81lz0f8joD59eRvgE6C2mX9Y2NNSpNzosAzCBI2Bbzvwwq8lfE5tfz9qFZwPETHJhylW8HTx+LsLtA2URJNeswke3TyCApsfFdYe1Pov9a6l8CVwXccqCex9dTeOJYtOvwFIGEtBIsKJcMiwOGBS7UwY1ttkWXvaVBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(6506007)(8676002)(33656002)(66556008)(26005)(82950400001)(8990500004)(66476007)(82960400001)(186003)(86362001)(2906002)(7696005)(10290500003)(4744005)(316002)(66446008)(76116006)(4326008)(110136005)(478600001)(55016002)(52536014)(7416002)(71200400001)(8936002)(64756008)(83380400001)(54906003)(66946007)(9686003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: z1FZG/qVdzvPmsdw0RBb+ElltqpJLNjstJNUsWY9cDuDrHPdgecDMmvQzWwbRHmjh8gTSEVzP7jOZ55k4DH/uQiucvw+Q1fD1bfnEX80ofuCli8cZcOTyaYVLp65MXaKBdRfS/R2Y9l5phQtAPoGtLIMSWHAAQT0VXOOX2TiGoAoALKJd/LsXJ4JLLXslVfV3gIOnpKNSDnsFim2jFMZGjLd5dupqNPssgjn9mlzn1Go1zWc1g3jpXkpblMYpoFAtB3OzBiz1VaipZTBxQJdrYdkXEEJFTJmvGPwgB+EAAL6+xDp6q2D+Glph1y9e0LQVk+0BX+bBhUnqUizT+Dtb43b7YCqaN3RnEk1l8d9+nie2sk02JSgjCSEqPhfPN1JmM8LcF/MhEZJu3uqECpzRdOliinX9lpA7qPNshb63orlcXNXVGN3RZCPlEBZeU4AiRFs1PzgsDsXoatfZcRfoB47Sc9ucRktctxlSbJzdVC+/Z556VI7vmRThRGmq9g+/zMASW1+Ro7HgMLle6w13ymKQOkRFsDVlLqfMuHdWoJDUOlTK6fgfh6RyEN9DXZm5ztYnH2rgUmLebGAgRyEUejB9HKWTzmHfhcbCC80kUFApzT6qE3MpjVcFtwmLy5nH3rE7on7AoW/LQb/OLkiwrp10d7knbFU59xlPcs5GAF8qzSBPId4P5kVSVaIjBSUTLAJks0mugwReKv1X3cWgTpoIT9bwc7KRTqg9MrYGVc=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949aa3eb-507f-490e-508e-08d8c935d74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:53:55.3368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyxcVU5EQHqyF1Nzke/qbyUVZXNeLMmsPIkHC849qCzSS4GCVlIpHf6jYD9Ja6Fq995VazWiXmci5Ovx/ho3AY3ExV3rS1FYJN5JbFe4mkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:05 AM
> 
> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ
> domain to handle mapping and unmapping of IO-APIC interrupts.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Simplify code due to changes in a previous patch.
> ---
>  arch/x86/hyperv/irqdomain.c     |  25 +++++
>  arch/x86/include/asm/mshyperv.h |   4 +
>  drivers/iommu/hyperv-iommu.c    | 177 +++++++++++++++++++++++++++++++-
>  3 files changed, 203 insertions(+), 3 deletions(-)
> 

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
