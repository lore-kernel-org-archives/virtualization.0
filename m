Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181F5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:00:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08FF61A07
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C08FF61A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E87F613FC;
	Thu, 30 Sep 2021 15:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmHbomg0YiX6; Thu, 30 Sep 2021 15:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 229106071F;
	Thu, 30 Sep 2021 15:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC06C000F;
	Thu, 30 Sep 2021 15:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28DF1C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1802942529
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLgQSzj-Lt1s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:00:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AF38403F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633014015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Uhm+QYM76Q/NUVbbvm//7rv1aKv+wtBYWvx/Vlkg4E=;
 b=SucXab1gQHa/Umh2MgoDVgzG1AhGw+EfI0kz421wbzXrJWInvhzsbL41RH7OlQ4oDVK/iP
 qt7On/M8ibIU5ucS45aNMLALZ1Pxrjxj07H8YNexME27WVKIzIo0Ob6gYB5HWy30LHAfuD
 SUq6s7oybrFwysJH8XMfkYxfpdJNQeU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-mWlW5AUkP-y47xOuSvkdpA-1; Thu, 30 Sep 2021 11:00:14 -0400
X-MC-Unique: mWlW5AUkP-y47xOuSvkdpA-1
Received: by mail-ed1-f72.google.com with SMTP id
 y15-20020a50ce0f000000b003dab997cf7dso3052854edi.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0Uhm+QYM76Q/NUVbbvm//7rv1aKv+wtBYWvx/Vlkg4E=;
 b=Zz+EHHgDk3blfE9vSr06xBXQDPpYloo9OdkCYG3vMUTmxjqLNYy2+s3KuoUdHra765
 NG/NlsTnqbfRecQ/ezM1y9bRwNzS2CgCab1kJ41lH8arhPFl0yKBboBsyL1bcjgzuQ/u
 6PCRAdRkGszdhMOKO/PUgnAY26mUIQ92IxGNY3E5dxsz9hP18AuqxaqsOxU7L2dHaLAI
 D3bR0BEQRy/PlX5hnKqE4h/tRAs2vkjSnT2kycUpzpcUSyi3omgfDwKCDxGaLBSGo2py
 3SUK0WOM8jPtn6WkmL2jSJSwWy3gGYuOw8IAL9bkW4CVL2FNPaUBuH6yyDA8P+cTETwd
 RS0Q==
X-Gm-Message-State: AOAM531vUD2swCq4dJvj98Ssp6viXYTvYXFZPJ7Qe0tA9Px+KIQMRblh
 oesaSAPsH8yAGQX2G9gK6qk79bUhXD/HE4e2tPqOtnBkxmV9kvfYtOMq6157rHtajTpzi/ydhKT
 deouQSH+WOM7/W+we6yLW5h1gNHqjzsLQ4GXZmv2vQQ==
X-Received: by 2002:a17:906:1b08:: with SMTP id
 o8mr7415467ejg.21.1633014012973; 
 Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz5aESHhTZJzzyTWIqcWelf63OI2y13i3Gz90wHayn2gr4CKl6nhaZlq4TjwGKZXxkJMK2Wg==
X-Received: by 2002:a17:906:1b08:: with SMTP id
 o8mr7415439ejg.21.1633014012775; 
 Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id l10sm1630936edr.14.2021.09.30.08.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 08:00:12 -0700 (PDT)
Date: Thu, 30 Sep 2021 11:00:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930105852-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930103537-mutt-send-email-mst@kernel.org>
 <YVXOc3IbcHsVXUxr@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YVXOc3IbcHsVXUxr@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

On Thu, Sep 30, 2021 at 04:49:23PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 10:38:42AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > > While the common case for device-authorization is to skip probe of
> > > > > unauthorized devices, some buses may still want to emit a message on
> > > > > probe failure (Thunderbolt), or base probe failures on the
> > > > > authorization status of a related device like a parent (USB). So add
> > > > > an option (has_probe_authorization) in struct bus_type for the bus
> > > > > driver to own probe authorization policy.
> > > > > 
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > 
> > > > 
> > > > So what e.g. the PCI patch
> > > > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > > > actually proposes is a list of
> > > > allowed drivers, not devices. Doing it at the device level
> > > > has disadvantages, for example some devices might have a legacy
> > > > unsafe driver, or an out of tree driver. It also does not
> > > > address drivers that poke at hardware during init.
> > > 
> > > Doing it at a device level is the only sane way to do this.
> > > 
> > > A user needs to say "this device is allowed to be controlled by this
> > > driver".  This is the trust model that USB has had for over a decade and
> > > what thunderbolt also has.
> > > 
> > > > Accordingly, I think the right thing to do is to skip
> > > > driver init for disallowed drivers, not skip probe
> > > > for specific devices.
> > > 
> > > What do you mean by "driver init"?  module_init()?
> > > 
> > > No driver should be touching hardware in their module init call.  They
> > > should only be touching it in the probe callback as that is the only
> > > time they are ever allowed to talk to hardware.  Specifically the device
> > > that has been handed to them.
> > > 
> > > If there are in-kernel PCI drivers that do not do this, they need to be
> > > fixed today.
> > > 
> > > We don't care about out-of-tree drivers for obvious reasons that we have
> > > no control over them.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Well talk to Andi about it pls :)
> > https://lore.kernel.org/r/ad1e41d1-3f4e-8982-16ea-18a3b2c04019%40linux.intel.com
> 
> As Alan said, the minute you allow any driver to get into your kernel,
> it can do anything it wants to.
> 
> So just don't allow drivers to be added to your kernel if you care about
> these things.  The system owner has that mechanism today.
> 
> thanks,
> 
> greg k-h

The "it" that I referred to is the claim that no driver should be
touching hardware in their module init call. Andi seems to think
such drivers are worth working around with a special remap API.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
