Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83C1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 11:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 516C440383;
	Tue, 23 Nov 2021 11:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkaMYUSR4PRJ; Tue, 23 Nov 2021 11:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4DD3340373;
	Tue, 23 Nov 2021 11:05:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31D3DC001E;
	Tue, 23 Nov 2021 11:05:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFAFC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F60D401E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pK0ulL6dZIVM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:05:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1094A4018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637665549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2pF2xlsDfDRvXe40093H51IzqjgOI072FHOrB5mwiw=;
 b=C9FCvrcHQ3j/th8biXBTON2RfK2VEFshiYVmbLWjELTNAM5hzgXG9rr5hal1Xxp2ISsDih
 IMZDhqXZNhTcJCKttjSSbI0mtH+1A2K6Ft8lmYuv6p1/17a0FvYYR7StfYKokYbX6ilIEA
 5hfA+X84gU4VDvKHjC+jOYI+N+tD7aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-FMyKGEkRMq-M3PlwRKWXgw-1; Tue, 23 Nov 2021 06:05:47 -0500
X-MC-Unique: FMyKGEkRMq-M3PlwRKWXgw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l6-20020a05600c4f0600b0033321934a39so1327138wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J2pF2xlsDfDRvXe40093H51IzqjgOI072FHOrB5mwiw=;
 b=V6jI32MRYlrjb/AoiMZQfcxf+PUX12WmL8QQPD4KlH4iLP6znQRDAlcXIPzTYuwPwI
 VqbugAJBQUhWSsVLlfaI3iWSGJtSKjfIS13WVKi8wE5xYzh6EHw5FoECiNXTIxH9Nctn
 UTR63C4KSbU1Alt6Xdd5JjXUVEL4YF5sV5pfHd18YMLXpXaMTUFC89oVWcqWRJLFZwJ3
 Wpnfm12EbaD9Yg2h98sRJfVNkpBQ8oVHQc8t/jzRFWFdqF2h0FG8tkF5HfcUJ1ha+xSm
 3iGDDULdhGWEMaUwYXhoXQn3TcBAinuseyakATpFMldTo+MRibl52JhDiBRyPl8i22Gp
 aMCw==
X-Gm-Message-State: AOAM533RQK9cLvbEozIid6SS82mfe99z5PT+mS20pl1obUsc04bbcfHf
 9uiLt1BhPUwSGOeK9Q9O39/HaEVtsbckO5Xuw432I1Gh7U8vLpcXceVL36jBitmhJRxJyMJlzgn
 eMaDdEV3dqGI11HdBNq57GU/FStKfJv+HDrBwF+RLzw==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5996805wrs.81.1637665546259; 
 Tue, 23 Nov 2021 03:05:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZvNK6RUtZqSW4AaPPqR0sfacFsPcXF+7OGnDvQsAeun5lKv75/Is6lcDnTi7n+0Q0I8rkew==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5996705wrs.81.1637665545555; 
 Tue, 23 Nov 2021 03:05:45 -0800 (PST)
Received: from redhat.com ([45.15.16.143])
 by smtp.gmail.com with ESMTPSA id o5sm11507325wrx.83.2021.11.23.03.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 03:05:44 -0800 (PST)
Date: Tue, 23 Nov 2021 06:05:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211123055906-mutt-send-email-mst@kernel.org>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Mon, 22 Nov 2021 14:25:26 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > I think the fixes are:
> > >
> > > 1) fixing the vhost vsock
> > > 2) use suppress_used_validation=true to let vsock driver to validate
> > > the in buffer length
> > > 3) probably a new feature so the driver can only enable the validation
> > > when the feature is enabled.
> >
> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> > feature. Frankly the set of such bugs is device implementation
> > specific and it makes little sense to specify a feature bit
> > that says the device implementation claims to adhere to some
> > aspect of the specification. Also what would be the semantic
> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> 
> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> especially considering the driver should not care about the used
> length for tx.
> 
> >
> > On the other hand I see no other way to keep the validation
> > permanently enabled for fixed implementations, and get around the problem
> > with broken implementations. So we could have something like
> > VHOST_USED_LEN_STRICT.
> 
> It's more about a choice of the driver's knowledge. For vsock TX it
> should be fine. If we introduce a parameter and disable it by default,
> it won't be very useful.
> 
> >
> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> > 'warn' and alter behavior. Or maybe even not having such checks on in
> > production, but only when testing.
> 
> I think there's an agreement that virtio drivers need more hardening,
> that's why a lot of patches were merged. Especially considering the
> new requirements came from confidential computing, smart NIC and
> VDUSE. For virtio drivers, enabling the validation may help to
> 
> 1) protect the driver from the buggy and malicious device
> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> 3) force the have a smart driver that can do the validation itself
> then we can finally remove the validation in the core
> 
> So I'd like to keep it enabled.
> 
> Thanks

Let's see how far we can get. But yes, maybe we were too aggressive in
breaking things by default, a warning might be a better choice for a
couple of cycles.

> >
> > Regards,
> > Halil
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
