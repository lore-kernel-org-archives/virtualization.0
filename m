Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB8C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:13:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7FB64DFA
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7FB64DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B69D486CD7;
	Thu,  4 Feb 2021 17:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCefYPtKkVih; Thu,  4 Feb 2021 17:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6526186CC7;
	Thu,  4 Feb 2021 17:13:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EB3C0174;
	Thu,  4 Feb 2021 17:13:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63D72C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5B34886CC7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RicbX8U02SdT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:13:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 42C0186CC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clEtMrXbov7M1Y87q/2whjYgF2nniwnp+oZnYzyS+8MvGK/pQlOKWhoy/WKSx2OAtm29V2ukgyRkxg198i9sX186+hRs9dAKnBkE3pePZs24bbPo7sRkcvPoTyTFTFgAN8BegShdpCRH6bd+1jJ5Z8FT0Z+oPDZ8u+ebtmaALPD5bps201ZMM/h0wVIaxIVDdCIev/7kDv3C2JBeN0ddRZbYSI5g0zYZZ5Uy+2wD+h9vlnB5OrqH5m46IkzNdGA313cwk22LyK3eCOqTCbg4y14FeXluafAsJCjEqFeKIzgWf0szdzUfPZ10peo4VXN4lpy2eitiM8G7s7HdSP14ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg8OWryhcbm5PPDTzpUpiV7uwXF+JTuCGfX9xgE+sIU=;
 b=PEtihQDc6g5Y0CR5BLN2/7F7ItwCja4EFdLFoGflB8dgQT5AA+z7FcoVP+5I65mbVhN1izV53rFpugV3GtnI0gpXuPvFGbaecGOhHrjDz+1Xl+7OmeLmRpM+RyPfowA8960Gz88AhlP2wTrr67+CfX//pe00QWs2LBkrIkAloiU1+CBmLmWMAwTGkvgsDf3+8Y+U2gEe0iXJMg5eFwUwOhab1x96G6vS/BkGut98UsHcjjEnYi6s1Cm3vQzRxFe84uoTTXebb5z+Lh+35OMEJah9TTF0eGpqRrJSyE3XU5p/6WnujNf+D+d96GyOfQeqftRP6POHI1xuA+zqdtjAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg8OWryhcbm5PPDTzpUpiV7uwXF+JTuCGfX9xgE+sIU=;
 b=KBLRVrN9B+CkviZRMj1My1YvPgkBVaPAI7i6ZRyGK82sILhWJHTvYRKS4siSbEPC7mwYQS10axkecdPhe5PkbdgqVckBTPmysVjGICCKSA930KwOCEgzBVLEInETIf4AUoRPbWTNVDV4hHj476MfhUhQ0lK9fjoDGGJpofWFRKQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 17:13:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:13:30 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Topic: [PATCH v6 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Index: AQHW+j3uULlbgWjr406sbgkChiWFS6pIPA1Q
Date: Thu, 4 Feb 2021 17:13:30 +0000
Message-ID: <MWHPR21MB1593E317A4D6B24A7B9BAB75D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-10-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-10-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:13:28Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4588920b-1c53-49ac-b87f-40a865c55e7d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86a5f865-d5ff-45cc-c7c8-08d8c930320b
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1873E8705C9956CC17697F86D7B39@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LftyXfomziHgK4RsjPwuL+WqjkQlRb4C4caAS3+n483+96khC/7AVovxBmCPJUnxMdMSOxKfronhuJI+5Twsq5CjeNZbECnrv8hzPNqI4UdXV68N2l8QzlQ/aplWT0DxZPhGdb8CHQTk+HuJV+rCbs9KdGhJObbPEnnEvopMmmWG5PASCo4dvphb8N4mpUXv6OltJh7rErLklJ7JcUskGxxxcvUJQUEM/SKvxrkasRoqnw2ukPLiE+Q6a6Y7nL92iXPnhl6kzNXYeGS1XSFKX9C9O+hIsGxyCQCigA96vz0oqMjoXLSTR8U5jzJDaAsVcHqqoaeezPCsY0YTekOl89b3HqwomR0xR8NXsxYf7d9IKpazSWZ4zpaswRjCDtJw13DLmHp/W+j8fetLYSnRXp9eABFHFdWkHju8jNRgp4RUwbCaglbDWar5M+kN5auf7PhkFKi8bktAA64CN+RP2MjitAuqNrf32vCJTEDSa4EqhbR2pHHG6eBGjJsyhojc2+/Tny79k0EQizAy1fZNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8990500004)(7696005)(26005)(8936002)(8676002)(64756008)(66556008)(82960400001)(4326008)(54906003)(316002)(33656002)(110136005)(76116006)(66946007)(5660300002)(2906002)(55016002)(10290500003)(82950400001)(478600001)(186003)(7416002)(52536014)(9686003)(6506007)(71200400001)(66476007)(86362001)(66446008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6Gxn64uwdUnPS8g1h2s48DhVz6W1H7Foj1N5bAsV7U4dGpZsS3K67WllmBD8uLhozTGhP4glXf5i9xcIpX0b6cefO+DNyWQ14JdRavOdgGmyURQwGDXIqt96DY0LumjeNy0A0ot15y+fshl0ACoDxu62x04Z28a9BZTshmSTn/OCPswqEG45GbU8xtPJ8NRrmTU3TVajSssNHznJiEbPGbJo1BHlfgpNEiIkNrLdhXznaTkz6naQEOEYcWAf083RIpA2oMo7YftzjE/ozy0UHkWWO0yXzK+sNATyNe2hbU00XsiIDKy+7Tv4cbJIAgLVqV4Z81EoOgyZprZccr3QCVUuYaz1pzBGoS8moHbRT4pMDUgY4gih21pECf/LNZ0sBTaRLdertGEg5XwB5auNbCjphBTYy5VrI5Z3wyx3neSVWQdMlSxVGe+fyp8dXigUHcacXUMT5HyvUcrmexigZJCHtqoB0A1qMY7uqnhrBUGr19COKZ2cdVcjsRuBrlsTIz3+p+lZ/KHuRUug0pmkGbrMuZFQBQJJKTn3pHzFfT+JIgDH4SrFVZUTumkjCx8tfuKA8if7FD8S+j454ZmqFLOR1wP8/XubhOlx6gp7O2yZ4Fpf/66IK/H+e2Incsd5Jf1/FeO37qHfEEvxlMTecfHEGo552L12Urd4JRDbHLlXweg3fch9Qsrd962Dy5z5xbTNrINQLWRG/FqppaFjjExAQMNJVTJJtQxtVoKKZ8M=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a5f865-d5ff-45cc-c7c8-08d8c930320b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:13:30.6062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEWLTLBHjuKweXvV7UWq0a4uYFzDbrRGYK/YGmmjDI2d+fKN++Am9U/STAgfbZiO8U3qM1SO431YEZ3LlW3xwJZy6iBA0NTD9IfkApH/7fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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
> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
> 
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Address Michael's comments.
> 
> v4: Fix compilation issue when CONFIG_ACPI_NUMA is not set.
> 
> v3:
> 1. Add __packed to structures.
> 2. Drop unnecessary exports.
> 
> v2:
> 1. Adapt to hypervisor side changes
> 2. Address Vitaly's comments
> 
> use u64 status
> 
> pages
> 
> major comments
> 
> minor comments
> 
> rely on acpi code
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 219 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  67 +++++++++
>  4 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/hv_proc.c
> 

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
