Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422FC433E0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:23:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76201229C5
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76201229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2BD2885F46;
	Tue,  5 Jan 2021 13:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpGCXP9fLnAx; Tue,  5 Jan 2021 13:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D41985D97;
	Tue,  5 Jan 2021 13:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10F8CC0891;
	Tue,  5 Jan 2021 13:23:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFF7C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78DEE8712F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XXdTV-cE7LgD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 053F68619F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609853014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYjuB5/l6vhggwtbdmp7b5rhdExSXPtz8f4X5n5pZWE=;
 b=ZXvrA+DBOePYx7gxVusrq+sk8OQm0jTgw2Ps79ePcC39m5cqYbEz6Au9HCi7E6mW364vJ9
 OzL1fZOqbpppKJYCF/zFMXMnIPdc7mbQOaJuT+xYMkKt20GjqdiNdKL2nIV2iZnTDSZXH2
 bw1PWp5OEZO9XrlkVHe4vJvuxBvyft0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-11YljKYDM_-SsUyJOalh-A-1; Tue, 05 Jan 2021 08:23:33 -0500
X-MC-Unique: 11YljKYDM_-SsUyJOalh-A-1
Received: by mail-wr1-f71.google.com with SMTP id w8so14816345wrv.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 05:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qYjuB5/l6vhggwtbdmp7b5rhdExSXPtz8f4X5n5pZWE=;
 b=CYss2+gNnDw9aLhaTiSWlmA4/zw6OLEIoo7V/0gnurf3U97L+79LNKKyJa2BASQsGF
 okwV4DylNS0MYQP80Qyo0PMr+kK7627O5iBl9ui/2nPdD7GKkkkkpoVw/Sz1iTj7fVwv
 Frr43lniIul4d5nbdFRR/UsOOiCwUWLTvULNI3q1gikHTQ6krIN+t1UbnByEfRUeaqHJ
 Ptd6pZzt4urWueCMCtcr/Y9idjqqqs6M3U5+mTTHqsQmmFbe6mZx8hudEOmcqgGTlRjk
 Z/xJIgBZtxvwLKVlXyaR7f0FWooVEM2WOddHWHJvCB6Ovuw52Bg4jQ2zHYhgi54SupeI
 RfVA==
X-Gm-Message-State: AOAM531SxZ2vl9lLCqa4RhEoWUj3ZLtpwOr+C72twwrNoBlD6PJ0jOo+
 FFi6aRt62VQAKBnyMO4goMOy72zqQsnG7PCTxy/8+hXSUirj2PRcucHcTzvcP6Lf+FYHUglU2Qz
 G4WIZz0R7N/FKsXfx4bF5I4JZUx6zQAKEI7Z2KBHeQQ==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr3548019wmj.115.1609853011789; 
 Tue, 05 Jan 2021 05:23:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwP/0VjP00CAUsHLAsVLH2Av4b3D3yARUrqUVa8Fi5s1bbgwnRZ15/RvJVKZX/IWW534zbedw==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr3548012wmj.115.1609853011656; 
 Tue, 05 Jan 2021 05:23:31 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id s6sm105436561wro.79.2021.01.05.05.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 05:23:31 -0800 (PST)
Date: Tue, 5 Jan 2021 08:23:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Message-ID: <20210105082243-mutt-send-email-mst@kernel.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

On Tue, Jan 05, 2021 at 12:30:15PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 5, 2021 5:45 PM
> > 
> > On Tue, Jan 05, 2021 at 12:02:33PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 5, 2021 5:19 PM
> > > >
> > > > On Tue, Jan 05, 2021 at 12:32:03PM +0200, Parav Pandit wrote:
> > > > > Enable user to create vdpasim net simulate devices.
> > > > >
> > > > >
> > >
> > > > > $ vdpa dev add mgmtdev vdpasim_net name foo2
> > > > >
> > > > > Show the newly created vdpa device by its name:
> > > > > $ vdpa dev show foo2
> > > > > foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2
> > > > > max_vq_size 256
> > > > >
> > > > > $ vdpa dev show foo2 -jp
> > > > > {
> > > > >     "dev": {
> > > > >         "foo2": {
> > > > >             "type": "network",
> > > > >             "mgmtdev": "vdpasim_net",
> > > > >             "vendor_id": 0,
> > > > >             "max_vqs": 2,
> > > > >             "max_vq_size": 256
> > > > >         }
> > > > >     }
> > > > > }
> > > >
> > > >
> > > > I'd like an example of how do device specific (e.g. net specific)
> > > > interfaces tie in to this.
> > > Not sure I follow your question.
> > > Do you mean how to set mac address or mtu of this vdpa device of type
> > net?
> > > If so, dev add command will be extended shortly in subsequent series to
> > set this net specific attributes.
> > > (I did mention in the next steps in cover letter).
> > >
> > > > > +static int __init vdpasim_net_init(void) {
> > > > > +	int ret;
> > > > > +
> > > > > +	if (macaddr) {
> > > > > +		mac_pton(macaddr, macaddr_buf);
> > > > > +		if (!is_valid_ether_addr(macaddr_buf))
> > > > > +			return -EADDRNOTAVAIL;
> > > > > +	} else {
> > > > > +		eth_random_addr(macaddr_buf);
> > > > >  	}
> > > >
> > > > Hmm so all devices start out with the same MAC until changed? And
> > > > how is the change effected?
> > > Post this patchset and post we have iproute2 vdpa in the tree, will add the
> > mac address as the input attribute during "vdpa dev add" command.
> > > So that each different vdpa device can have user specified (different) mac
> > address.
> > 
> > For now maybe just avoid VIRTIO_NET_F_MAC then for new devices then?
> 
> That would require book keeping existing net vdpa_sim devices created to avoid setting VIRTIO_NET_F_MAC.
> Such book keeping code will be short lived anyway.
> Not sure if its worth it.
> Until now only one device was created. So not sure two vdpa devices with same mac address will be a real issue.
> 
> When we add mac address attribute in add command, at that point also remove the module parameter macaddr.

Will that be mandatory? I'm not to happy with a UAPI we intend to break
straight away ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
