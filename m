Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79FEC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:14:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4831422CE3
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F2A5E864D7;
	Wed, 20 Jan 2021 00:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q8Q55m9ANTEH; Wed, 20 Jan 2021 00:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D409F864D4;
	Wed, 20 Jan 2021 00:14:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B56CCC08A1;
	Wed, 20 Jan 2021 00:14:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE714C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C3B3E86F8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Awfbfcg3V1W0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D5D0886F8D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:14:52 +0000 (UTC)
IronPort-SDR: ++x2X5yQKTHmqYHuLM75uFsBqYqGuP/TV3h5lhlKKH22ePIZ1+gS0lsbkI5hJrNWydGCEL9C0+
 kzQZBrzwHzAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="176447470"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="176447470"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 16:14:50 -0800
IronPort-SDR: jgFWRhZEtk36yrNAm0zdpaObTL6Ej/nLYui9dA2xZSEVMV7qUN0wNLfNzTF+4uPqhkoV2RTEQy
 F1EOwuF2+0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; d="scan'208";a="353963107"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga006.jf.intel.com with ESMTP; 19 Jan 2021 16:14:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 16:14:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 16:14:49 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Tue, 19 Jan 2021 16:14:49 -0800
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Thread-Topic: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Thread-Index: AQHW7j6Sb7QSbmMgzEq63xXMOAt6Q6ovnEqA///v1aA=
Date: Wed, 20 Jan 2021 00:14:49 +0000
Message-ID: <b4a93e926d424ff199ab91ff88399087@intel.com>
References: <20210119082812.822291-1-vivek.kasireddy@intel.com>
 <20210119082812.822291-4-vivek.kasireddy@intel.com>
 <20210119083955.1cc9eae3@omen.home.shazbot.org>
In-Reply-To: <20210119083955.1cc9eae3@omen.home.shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.132]
MIME-Version: 1.0
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
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

Hi Alex,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Tuesday, January 19, 2021 7:40 AM
> To: Kasireddy, Vivek <vivek.kasireddy@intel.com>
> Cc: virtualization@lists.linux-foundation.org; Kim, Dongwon <dongwon.kim@intel.com>
> Subject: Re: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
> 
> On Tue, 19 Jan 2021 00:28:12 -0800
> Vivek Kasireddy <vivek.kasireddy@intel.com> wrote:
> 
> > Getting a copy of the KVM instance is necessary for mapping Guest
> > pages in the Host.
> >
> > TODO: Instead of invoking the symbol directly, there needs to be a
> > better way of getting a copy of the KVM instance probably by using
> > other notifiers. However, currently, KVM shares its instance only
> > with VFIO and therefore we are compelled to bind the passthrough'd
> > device to vfio-pci.
> 
> Yeah, this is a bad solution, sorry, vfio is not going to gratuitously
> call out to vhost to share a kvm pointer.  I'd prefer to get rid of
> vfio having any knowledge or visibility of the kvm pointer.  Thanks,

[Kasireddy, Vivek] I agree that this is definitely not ideal as I recognize it
in the TODO. However, it looks like VFIO also gets a copy of the KVM 
pointer in a similar manner:

virt/kvm/vfio.c

static void kvm_vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
{
        void (*fn)(struct vfio_group *, struct kvm *);

        fn = symbol_get(vfio_group_set_kvm);
        if (!fn)
                return;

        fn(group, kvm);

        symbol_put(vfio_group_set_kvm);
}

With this patch, I am not suggesting that this is a precedent that should be followed 
but it appears there doesn't seem to be an alternative way of getting a copy of the KVM 
pointer that is clean and elegant -- unless I have not looked hard enough. I guess we
could create a notifier chain with callbacks for VFIO and Vhost that KVM would call 
but this would mean modifying KVM.

Also, if I understand correctly, if VFIO does not want to share the KVM pointer with
VFIO groups, then I think it would break stuff like mdev which counts on it. 

Thanks,
Vivek

> Alex
> 
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >  drivers/vfio/vfio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > index 4ad8a35667a7..9fb11b1ad3cd 100644
> > --- a/drivers/vfio/vfio.c
> > +++ b/drivers/vfio/vfio.c
> > @@ -2213,11 +2213,20 @@ static int vfio_unregister_iommu_notifier(struct vfio_group
> *group,
> >  	return ret;
> >  }
> >
> > +extern void vhost_vdmabuf_get_kvm(unsigned long action, void *data);
> >  void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> >  {
> > +	void (*fn)(unsigned long, void *);
> > +
> >  	group->kvm = kvm;
> >  	blocking_notifier_call_chain(&group->notifier,
> >  				VFIO_GROUP_NOTIFY_SET_KVM, kvm);
> > +
> > +	fn = symbol_get(vhost_vdmabuf_get_kvm);
> > +	if (fn) {
> > +		fn(VFIO_GROUP_NOTIFY_SET_KVM, kvm);
> > +		symbol_put(vhost_vdmabuf_get_kvm);
> > +	}
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_group_set_kvm);
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
