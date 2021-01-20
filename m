Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D90AC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:05:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E5023109
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5023109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F890866B9;
	Wed, 20 Jan 2021 03:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIMfvPDjCZ+2; Wed, 20 Jan 2021 03:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 390A38627E;
	Wed, 20 Jan 2021 03:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18FB8C08A1;
	Wed, 20 Jan 2021 03:05:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27C1CC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 158028666F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtUGCgz206-6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2C11B8627E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:05:54 +0000 (UTC)
IronPort-SDR: o2hRptASjdZhhHsPbvc3/VCbN7caI8cf2Nm6s99CflEcjGeIIdwpNgGvMaT7MxxgPFdr7ytAub
 UseQ65stT51A==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="197758423"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="197758423"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 19:05:53 -0800
IronPort-SDR: yMpEmLYr7TBrm/LTR9M91SNSkQo4kj7cL5aBXSR40kaxrFsyBppxfnUeldDAY5GPHw1lRJC/4W
 smVdq8fEZGgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="402593046"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2021 19:05:53 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 19:05:53 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 19:05:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 19:05:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 19:05:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY1kkvecw4oMuzzIASIlkXTUAs/EO2hrLwEP5/OEaYmXiVVgRU4YzNjW7aM3b2Fxbk834TBtI4xp4VbOhn138EoJ2XTDdg1VychWPW8SpxKhskmjyCXihi07sPt4ahMJmNDfxKyjsQ52rDfHD0qMx95aN59v0ZuQqlH/Qc0sTWjy3+ktg/loL/oV5zXbkKn3sz+mdtQLwJnBUhTZdsQRyD7yTlmCOCGEpvSqbedsdmxB/YcrOBEn1vK61GmFNEWoztDRaFQFAObF7jJZrTMRFhsAm9mp0sTXv4WdMmu5t2FYREn4L5wT0N6eXId8q972QHEnflAL4+AlNufe0JtmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZZ2Fa3D3Iy5T1sOM3oDaEp+RUqIEW6+sLhAWUUJq2k=;
 b=L/lCyBlJJHKqVMd+8Ojlvaq8yYLkYSG3ZqpS7BIbeYZhhT8ala/syYByOYMlkpHEOxnNWm5JOxbPJ3SY0kcNRYY2kOMlUIHzZtKPiT4ZeICxe5h6vEBv3EumuziVbq/LoGk4DBZ03FVOvcVmUFFUFz0ghO/Yfjy5X/FnuRvUcKHs2Qb0RuhtyRH7RmD4s9gA/9E2AYR403+jS+Do5zNxBrswAt2mhZdDH3mCbPH5WicElr0AF434s4NJdL6+bhL9uP/dzADtqtCS+pQjDe4IIUWTb8K45vTTXfW3bFYoyyBK477BMcnqUWcz20XWr4SFx8IRCzLE7DOIhgMAzgRpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZZ2Fa3D3Iy5T1sOM3oDaEp+RUqIEW6+sLhAWUUJq2k=;
 b=ul24oj+OoPILfJOdsGwm1LWma1swaZ8s3c86wDnhJ4jE6GO8Ck/DrlzgW6KC0Rs4CFUChjkkgcWhu+KV4meDyRir+k4aidgPiieqb4ROZNum/TFzRjweJ37+sxjHggRwG1cTTiNXxNfxKxyteupbqtyStkOZAVh8xH1TD1eEtfE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1344.namprd11.prod.outlook.com (2603:10b6:300:23::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Wed, 20 Jan
 2021 03:05:49 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:05:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>
Subject: RE: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Thread-Topic: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Thread-Index: AQHW7j6n2dtPZhPdVEGDgX7y9ymEe6ovFi6AgACP3ICAAAoZgIAAJAtA
Date: Wed, 20 Jan 2021 03:05:49 +0000
Message-ID: <MWHPR11MB1886CC23DA5EF4695506AB308CA20@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210119082812.822291-1-vivek.kasireddy@intel.com>
 <20210119082812.822291-4-vivek.kasireddy@intel.com>
 <20210119083955.1cc9eae3@omen.home.shazbot.org>
 <b4a93e926d424ff199ab91ff88399087@intel.com>
 <20210119175057.5768b26b@x1.home.shazbot.org>
In-Reply-To: <20210119175057.5768b26b@x1.home.shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c86081e-6a3b-4fac-e49d-08d8bcf04a42
x-ms-traffictypediagnostic: MWHPR11MB1344:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB134456D9FAF7067A24901FE88CA20@MWHPR11MB1344.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBWGsI19u94LApMl+ToH0A0NEewP2hrgrUdRtOgEtOORclIIj1cOW80B2VrywDYj+4Pz588k8RBWK0HmRhaeqvI+WO8fWgvxh69N4QYTwUKSBGUEFIlgPOxDl3++iiIxw1uqIKZVBAUGhql47wqqvCij2FW6AZZGWVGG68vbUHUPqF0bWHvG7nCWP4jLO8BEqkAW7Qhk7nXuukQaF9L8oAE1HDpBLGc/5cv1FVmtUIdu5Qab2P8c5/PC4f3NEHcqVcOo1VC2t7ATbM3+fo9s7pUnAaYhgm9BrUmZR7L3EmVtgI4JG2oF923jGPuJ02lj5UxD7kXeFW3WfoZ+9bQmq7iq3QXQ7rlM2QaC4lJcELrk4Rn3OcLyehskaWA/FWFgDRVBUwpLkn6oLMpUqXE2rQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(110136005)(52536014)(9686003)(478600001)(26005)(107886003)(83380400001)(76116006)(7696005)(54906003)(33656002)(66556008)(5660300002)(8936002)(71200400001)(66946007)(8676002)(66476007)(86362001)(186003)(6506007)(2906002)(4326008)(6636002)(55016002)(66446008)(64756008)(53546011)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iHP79DLV6fMuSErlFRKU2mLAxqb7JM3o64b+nwqC5J2BytoPY2GF3wTYDvDQ?=
 =?us-ascii?Q?SXgT9Oq3igoPQVHQAbnxkp07FaVHatln9skaicMJ/HbsvhSfeCVhRchGCRIJ?=
 =?us-ascii?Q?yx2aCJtTyJIW4PLGgE8o6gL+z3okYny7LsnGcOaa9xuyU92qJiI/szzgGBCr?=
 =?us-ascii?Q?IYEozV9n3CDSUamadE6rjNiwZfWv/Rcqukvh1TSbTS78dcx1JOhKR9pHZtWv?=
 =?us-ascii?Q?Ia/YmkuSp0gjc2fN1MCrc7ei289yQME+kklWGsJKKsHH9KHDSeuXlkvQMfYu?=
 =?us-ascii?Q?CO2gctGQZ37/yqg7hJBKQeNjyRdNKeetYvy6hMGU/MdP6lD0HvyKgstzo6vJ?=
 =?us-ascii?Q?bzO0EGej//KtjnUilRirgufaxGtsxScoGP2jV5KK62Zr54ZNiwG2Fes7qV3U?=
 =?us-ascii?Q?hUCSGtEGljSb59GRdBgvWmVsso6BaCL4rIbTpXytskGjxiRBmlxyH50F8s8z?=
 =?us-ascii?Q?ZI8EEXFFELDHu4ydh9v7VgQTk8gA21zDQSR9W1Dx6AvO+Wr30D/Vro8Q2Ehj?=
 =?us-ascii?Q?BWaKXU4U1iPENnkuai3ehT9G/sICpnzOXuHVH7yOCNX1hPVnoUwNMXKCyv5d?=
 =?us-ascii?Q?7/KWntXHpSqMIZ0h1Kpq9MY569ai1K/Oww4UhC+naPMfwu/WW/YENrof6HeL?=
 =?us-ascii?Q?D6AJyLJZvKzdPyqbMKByChPa20eV6IVl8yjfzemqnbhLcA1SreF8/A/Wf2uM?=
 =?us-ascii?Q?PHsnIzM4IIOrH3UwYDg8Q57CwWr3kfyYIXqPnHJufFW9AtTizsx3WxbD5PA5?=
 =?us-ascii?Q?ywAZailxXx3tpLgDWVj7JNncUyPMON4nYQX1mkO00Nkfty4xfYfeR78oMgCD?=
 =?us-ascii?Q?ln0xAgp3b6p6l7SuCTzGooCXBq5UePH2fryZsIuVCxe5DSUZVJrcZ34gW01I?=
 =?us-ascii?Q?7vv9slrRPptN3prQyzfDvl+TZRuqg3k4HZ6q2H6MhDNsBajjvZ533BRHoqiO?=
 =?us-ascii?Q?5noJrY3vL5CRSIQiCVVNoltt/U45wiJmk4aM5OKpHZ8=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c86081e-6a3b-4fac-e49d-08d8bcf04a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 03:05:49.5591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV75pWmMIRS9+ii/d/oxPSuIkK3YKcONlHKTxArOFwoPeLEhmU+rNz+mZvdEB30qkqw7iz0UgAEU48cdHgFGDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1344
X-OriginatorOrg: intel.com
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> From: Alex Williamson
> Sent: Wednesday, January 20, 2021 8:51 AM
> 
> On Wed, 20 Jan 2021 00:14:49 +0000
> "Kasireddy, Vivek" <vivek.kasireddy@intel.com> wrote:
> 
> > Hi Alex,
> >
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Tuesday, January 19, 2021 7:40 AM
> > > To: Kasireddy, Vivek <vivek.kasireddy@intel.com>
> > > Cc: virtualization@lists.linux-foundation.org; Kim, Dongwon
> <dongwon.kim@intel.com>
> > > Subject: Re: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
> > >
> > > On Tue, 19 Jan 2021 00:28:12 -0800
> > > Vivek Kasireddy <vivek.kasireddy@intel.com> wrote:
> > >
> > > > Getting a copy of the KVM instance is necessary for mapping Guest
> > > > pages in the Host.
> > > >
> > > > TODO: Instead of invoking the symbol directly, there needs to be a
> > > > better way of getting a copy of the KVM instance probably by using
> > > > other notifiers. However, currently, KVM shares its instance only
> > > > with VFIO and therefore we are compelled to bind the passthrough'd
> > > > device to vfio-pci.
> > >
> > > Yeah, this is a bad solution, sorry, vfio is not going to gratuitously
> > > call out to vhost to share a kvm pointer.  I'd prefer to get rid of
> > > vfio having any knowledge or visibility of the kvm pointer.  Thanks,
> >
> > [Kasireddy, Vivek] I agree that this is definitely not ideal as I recognize it
> > in the TODO. However, it looks like VFIO also gets a copy of the KVM
> > pointer in a similar manner:
> >
> > virt/kvm/vfio.c
> >
> > static void kvm_vfio_group_set_kvm(struct vfio_group *group, struct kvm
> *kvm)
> > {
> >         void (*fn)(struct vfio_group *, struct kvm *);
> >
> >         fn = symbol_get(vfio_group_set_kvm);
> >         if (!fn)
> >                 return;
> >
> >         fn(group, kvm);
> >
> >         symbol_put(vfio_group_set_kvm);
> > }
> 
> You're equating the mechanism with the architecture.  We use symbols
> here to avoid module dependencies between kvm and vfio, but this is
> just propagating data that userspace is specifically registering
> between kvm and vfio.  vhost doesn't get to piggyback on that channel.
> 
> > With this patch, I am not suggesting that this is a precedent that should be
> followed
> > but it appears there doesn't seem to be an alternative way of getting a copy
> of the KVM
> > pointer that is clean and elegant -- unless I have not looked hard enough. I
> guess we
> > could create a notifier chain with callbacks for VFIO and Vhost that KVM
> would call
> > but this would mean modifying KVM.
> >
> > Also, if I understand correctly, if VFIO does not want to share the KVM
> pointer with
> > VFIO groups, then I think it would break stuff like mdev which counts on it.
> 
> Only kvmgt requires the kvm pointer and the use case there is pretty
> questionable, I wonder if it actually still exists now that we have the
> DMA r/w interface through vfio.  Thanks,
> 

IIRC, kvmgt still needs the kvm pointer to use kvm page tracking interface 
for write-protecting guest pgtable.

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
