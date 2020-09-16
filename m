Return-Path: <SRS0=0f46=CZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07647C433E2
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 22:54:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E902080C
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 22:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jf/puGxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E902080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 007AB877C2;
	Wed, 16 Sep 2020 22:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x92xWSYHhdgJ; Wed, 16 Sep 2020 22:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 57289877C1;
	Wed, 16 Sep 2020 22:54:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 282C6C0859;
	Wed, 16 Sep 2020 22:54:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67489C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 22:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5677786F33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 22:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwuEmDfYt-_E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 22:54:09 +0000 (UTC)
X-Greylist: delayed 01:04:23 by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28DB186F23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 22:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4BRRiinITmlfbQyIdNfvCDyEdDG/XNWYMPMqb7VbcU/AlxH2TvyypJrrVgeBrdAq4nvntxpoGm5buxLiznSb9euUPUbjg8k7ZZKfBIom+CRAnKvBKzyOCV064ZZAz08gZt4TVl+7IoBaaGaWlNH3pMn0untLZdZ+FnQrJD8yoUXfwemUtKZSnPt8BCbQnS/Ko0qz1gwPHDC0+dAmeEsUYR2lv0CdT9HVUzzJ0FlvS65swGe5vpStNSHnJtECeBdYLVswzB+5Ao504Y9KZUPke5pKr1RZScX0fJpgo4ijshpZOaqz3gTjuu2mm2AoHNPFvjbLvqMv4wHrN+YrsX0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHTW9WJ2D2UKkNPTvRPzDcy+ewHUPYevi3aGDo4ukrs=;
 b=Zldvm1eOkCyURa1tzLgzOlVDKvjtINf2/WOyjlsIKPNVCTUGFzZDBb0nClvG83CkzkVww3sphddj5K9lnsyEI02KO3TDXQxK9vJvE9W8TEyZ5P6aSwYRdNSEtm9eFHv6PqD9w9LwnJcR/K8LwOU/+M42FnDeMJnTarGEqmTD39S7Ionoe2bvdg3xAovM/Ya1xNCvE+gvID7ea9Ft2kSbuwa0GoUc/4s3Cc2ZdsyQjnpV9VZWdlUnIxhT8FInEo8I3X4mPYPJqTlBOJ2nspecVXtKaC3LcejpEqhSg1Cmjehns7CVSqb8f1JQrjlew8//R7if0bt3QNjjo+wY9+VIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHTW9WJ2D2UKkNPTvRPzDcy+ewHUPYevi3aGDo4ukrs=;
 b=jf/puGxzDzX7MpWQZDm+wHcjivYX47Vr73cjUSPFruxX90o50LrCPQ+H4y08vFjQs0R/3ClGMk9Hn2JVcrWE7QwKda6lyHNj88oKY6jNgsxitCU/k7jBrmU5Q37JXYdsBMerOmJh3YPZtBdCC4WNpGO5TFeVSTZpUAfjXi0BpHk=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1854.namprd21.prod.outlook.com
 (2603:10b6:805:9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.1; Wed, 16 Sep
 2020 21:34:58 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953%9]) with mapi id 15.20.3412.003; Wed, 16 Sep 2020
 21:34:58 +0000
To: Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH RFC v1 08/18] x86/hyperv: handling
 hypercall page setup for root
Thread-Topic: [EXTERNAL] Re: [PATCH RFC v1 08/18] x86/hyperv: handling
 hypercall page setup for root
Thread-Index: AQHWi0uJDiA8iBMLkEafMqtOkreLY6lpgb0AgAJJU9A=
Date: Wed, 16 Sep 2020 21:34:58 +0000
Message-ID: <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
 <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
In-Reply-To: <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:6d60:30f5:6f33:54d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93eb277c-c9a3-4700-e4de-08d85a885c8e
x-ms-traffictypediagnostic: SN6PR2101MB1854:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB185462FA4B00539298A1C3A5C0210@SN6PR2101MB1854.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3OeSaKuZZh/9T7vDlzFEFJ5Ba4ftJyD4rdTihrZ/YdUVKHwK332cI/K4xtss04pElJ/SaGW/OlyA3bTI+0ABGkYo2uibliGd+mXMi6ckCJobAyRj47mO7LRFgg8qGltz+LP0m25clmj68wAqIGp4Ga1ud8ZIVKlxiEDH/3StfApahySGle5P6WOPcmpokg4KpEF5HF+AnXfFvUNztSriorj2d7UXbPu9BdZAu0o0UuGtoiecq3GQctWB7pdCVfW14UhqOb0iqDGYwGk4I3aYITopKuPMlfnS97dSXApQp3KRIjN7oTfKjrMG2w1B0UTxWJM08EVYDiJTDhev7R2jkb8psZ4x2e5FcKLxMw/bDexh6+Hods5HDv8o0zwJ8dG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(86362001)(7696005)(5660300002)(4326008)(8936002)(82960400001)(2906002)(82950400001)(8990500004)(55016002)(54906003)(110136005)(7416002)(6506007)(76116006)(33656002)(9686003)(316002)(64756008)(8676002)(66556008)(478600001)(66476007)(10290500003)(71200400001)(4744005)(66446008)(186003)(52536014)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Nq/d/PQsCmkBbyi5Kdkcvdo4g31/5Ag+F1bW6B225MjfAqildb9/X2xKYhGY8aAbdadbRqp4RdDWvT+NuXkUGaSCur66pLkhaVDs+lqIaUTZDerpSqit4JJKx//I5al/8ft1Qlaa4cLhMhvBX4Z8A2aTINXPY5uRQZP+cbRLVzySdauN6xchukxEyakD2Y41fm/+iCAa+3NLmx77bbOhcp604IzpzBLnZZJzRm1G0GYg1ODslYKQrdGBDzaAGeprcVZbfF7ZGN/6K30GmIBYbrXw0vEJK15mE7drD+PqAKQqciVbuGQBgeOS7J3zSvr4/uTueYuFP4Q2PS7pBn2oPhBrXZ789Cn9NdcnIVM2Udu7A/Dgau+s2uVAmIoWFyXhNTiziRuGWg9d4dcVZknk7LyMvOAFrjnIZXeLUeYGLABGSpe25R4q102BLVqc03YY9xS8bvdH1AhPr1813Na9aqyQn7hmPRV74BnhkZsHUKC2/wOBfTboJhN3okLgxn0Lm7ISgf2v3K3eENv7s5v1717eF9AvVqKDcdpYt56dFMr/X8oBPFwW2bdR400WTRe8FsPOfOhEDfpmqygGdzt7XGPCfAyCBqVovnQIrZck+Mxs/Gzoy6CKkD4P9XR48hhNqQ8BDpMdxOObedXAIzBTMw4FuUwpS4UhvgK9lp1HBVFH05S3A9enBq1v8xDdC1xjMDRbTN/z9HMFbYHITWUbwQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eb277c-c9a3-4700-e4de-08d85a885c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 21:34:58.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHj12QD3KuuoOmb9RGjokM24dSTx+XM9MRKV7qUQYMmYixe6Nc4TNXCEVhbdXiy2Q0b1Zy05nA7UTY7FfI3qVBvsDxZt8ZsU354aKtKd0Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1854
X-OriginatorOrg: microsoft.com
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>, "maintainer:X86
 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nuno Das Neves <Nuno.Das@microsoft.com>,
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
From: Sunil Muthuswamy via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> 
> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
> > Wei Liu <wei.liu@kernel.org> writes:
> >
> > > When Linux is running as the root partition, the hypercall page will
> > > have already been setup by Hyper-V. Copy the content over to the
> > > allocated page.
> >
> > And we can't setup a new hypercall page by writing something different
> > to HV_X64_MSR_HYPERCALL, right?
> >
> 
> My understanding is that we can't, but Sunil can maybe correct me.

That is correct. For root partition, the hypervisor has already allocated the
hypercall page. The root is required to query the page, map it in its address
space and wrmsr to enable it. It cannot change the location of the page. For
guest, it can allocate and assign the hypercall page. This is covered a bit in the
hypervisor TLFS (section 3.13 in TLFS v6), for the guest side. The root side is 
not covered there, yet.
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
