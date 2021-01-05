Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30FC433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:15:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2AB2229C
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2AB2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4616086FA2;
	Tue,  5 Jan 2021 12:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ohRsX8a1jJl; Tue,  5 Jan 2021 12:15:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9B92686F73;
	Tue,  5 Jan 2021 12:15:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F477C088B;
	Tue,  5 Jan 2021 12:15:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB414C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 984BB85692
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePr2Jd-cWZ1e
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1470A815EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609848903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzsOsVwoB44yWUjZKrE3hGQLq4CO80CE1lp9CnWnymQ=;
 b=eJ8ubEoyU921mH3bIvBjpgXsVoVoEyTD7BBzgPQt3iILHU/MUsA81XxrwR3WH35DOtmAPL
 Wy17LRC8y7713XRniXcI4HSPSzlSMbVmI2sLTvhhu5eaxBfaOdlpTDieoCUFxsi4TyoF8b
 HRI+YFg0NOl9vyh5Ehbr2/x/YsWsmDs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-dHAipEwyPxW7WIaFsQAkvQ-1; Tue, 05 Jan 2021 07:15:02 -0500
X-MC-Unique: dHAipEwyPxW7WIaFsQAkvQ-1
Received: by mail-wm1-f71.google.com with SMTP id 137so251790wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 04:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GzsOsVwoB44yWUjZKrE3hGQLq4CO80CE1lp9CnWnymQ=;
 b=GZWz3DDVZvxnDbpOfE6pWvW2pNa1oMcSPO1VWbzO5nMw1jJfvYCSYVTNo9zqU6ZWes
 vrElXRj4RJUboqT5bWy7O+y6soXBC8Yzd+w1TfY7FHcBuzcEQo/Ut9YH/vL6T67WrCp0
 twWryEBQ+FhcBAbXF33dEQikoDcAJEkNrOqKwJu43zBwW5NIUBFapqUCoz7FQO1c2xhh
 QiKojPYvJZnpRVESNmHEBEkH+/UxB23fe4l3z6xOwhSJM67bFmi39AEOI+/S/WdT6vUE
 wWhc+7f0ZNpKYE5d2dXalHowx2pOL4x14+1fOx9vZKxtHzezwEC93zfPqIWc0EeX/uzU
 NVTg==
X-Gm-Message-State: AOAM532YTevDT/1WKDdu38i6tktKAnMFZcJWBQGJck3n0h8hiZvZIXH6
 rW6zDuKbsH79E2b2Au4xsahX0JwRFxBexrAYA5gs8pkvubNqsqAYVf74zF6Ah0hp/vOTsSSR0bk
 mAxCLtUKjka1k8S0dMphQoldg1Tg7DOr9uRGp6T+xUA==
X-Received: by 2002:a1c:e083:: with SMTP id x125mr3377043wmg.0.1609848901055; 
 Tue, 05 Jan 2021 04:15:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5tY2rNfqYCNDGjnQqFotIxEadv9niP5oP+t2XfwMjWrLkhpl0wfHyjjmDWhZlA2s5E9RVwA==
X-Received: by 2002:a1c:e083:: with SMTP id x125mr3377034wmg.0.1609848900907; 
 Tue, 05 Jan 2021 04:15:00 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id a17sm99413423wrs.20.2021.01.05.04.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 04:15:00 -0800 (PST)
Date: Tue, 5 Jan 2021 07:14:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Message-ID: <20210105071101-mutt-send-email-mst@kernel.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
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

On Tue, Jan 05, 2021 at 12:02:33PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 5, 2021 5:19 PM
> > 
> > On Tue, Jan 05, 2021 at 12:32:03PM +0200, Parav Pandit wrote:
> > > Enable user to create vdpasim net simulate devices.
> > >
> > >
> 
> > > $ vdpa dev add mgmtdev vdpasim_net name foo2
> > >
> > > Show the newly created vdpa device by its name:
> > > $ vdpa dev show foo2
> > > foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2
> > > max_vq_size 256
> > >
> > > $ vdpa dev show foo2 -jp
> > > {
> > >     "dev": {
> > >         "foo2": {
> > >             "type": "network",
> > >             "mgmtdev": "vdpasim_net",
> > >             "vendor_id": 0,
> > >             "max_vqs": 2,
> > >             "max_vq_size": 256
> > >         }
> > >     }
> > > }
> > 
> > 
> > I'd like an example of how do device specific (e.g. net specific) interfaces tie
> > in to this.
> Not sure I follow your question.
> Do you mean how to set mac address or mtu of this vdpa device of type net?
> If so, dev add command will be extended shortly in subsequent series to set this net specific attributes.
> (I did mention in the next steps in cover letter).
> 
> > > +static int __init vdpasim_net_init(void) {
> > > +	int ret;
> > > +
> > > +	if (macaddr) {
> > > +		mac_pton(macaddr, macaddr_buf);
> > > +		if (!is_valid_ether_addr(macaddr_buf))
> > > +			return -EADDRNOTAVAIL;
> > > +	} else {
> > > +		eth_random_addr(macaddr_buf);
> > >  	}
> > 
> > Hmm so all devices start out with the same MAC until changed? And how is
> > the change effected?
> Post this patchset and post we have iproute2 vdpa in the tree, will add the mac address as the input attribute during "vdpa dev add" command.
> So that each different vdpa device can have user specified (different) mac address.

For now maybe just avoid VIRTIO_NET_F_MAC then for new devices then?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
