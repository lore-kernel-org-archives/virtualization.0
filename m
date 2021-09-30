Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62781C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:49:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BC961A3B
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13BC961A3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA80C4034A;
	Thu, 30 Sep 2021 14:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mB1hv6scJ8ow; Thu, 30 Sep 2021 14:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E400E401D2;
	Thu, 30 Sep 2021 14:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2B85C000F;
	Thu, 30 Sep 2021 14:49:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E953C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1508840354
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xx1-XE2wV6Zv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3C3D401D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633013349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugADMhcG12DXi90Mi9xu4IZCB4uc/XgW9seUM0TOKhE=;
 b=aKd6/l291AITv7l/jpOIjnoteVXW6wBJBsvgIK53GBBqRShDZMNCD0q6esvcqS0OLA4pFN
 X4s1/CPYIDoRR4hs/1iX2WbzFZE7T+Oq55ta772v/pTbFQDburzeslsBDoKzEd4Kokhqap
 cHaTtZvOQ4fVMEmgC+EjRFME9ycZo9A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Wl_Mv2LGMb6a_gdxBtLDYQ-1; Thu, 30 Sep 2021 10:49:08 -0400
X-MC-Unique: Wl_Mv2LGMb6a_gdxBtLDYQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 t2-20020adf97c2000000b001608326aa2fso1011499wrb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 07:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ugADMhcG12DXi90Mi9xu4IZCB4uc/XgW9seUM0TOKhE=;
 b=USDIgBgzmYcEJ0nt1D3M5I9pEI7LTLA+Qy7dQIsIbjNHgbq1o41jyQ5e7WZBrrkzZ8
 lkKmMSGMSzn9EVU6W/P3cTSPhEIh7p+fRejRJdPpmuz5VjoKSS3jVmKyIWt9BPD+cILx
 pgD3Y5jxYgst0AXC69XUE5JrZb0snQhmVzKU6jAGAqJCShWuy6d7EUzl9YO8DMqFf8R8
 9Lutvs84AsCZMpRhfGy4G1xSycWpTs3bV+WmYZ2bW4j2VID1VCkwGOQK7dAKuj4C6xAi
 vhtyFbSReFHs6EXS5fOu34c/LTftmpQqXoMKAW9Cam1u7zLPhqxniRySKwuPWZ+zSvnk
 U6Ug==
X-Gm-Message-State: AOAM533vhudzqDX3o7nSMdZKLaBbDxiuWBAVmIP6+d2+oE3xUzjTaia3
 Zw9uwtzzQAnP7rE/HdK2pXn4b2X2kG8zu0zDWy0rDjEiWV7vScm9okW4/0mokOH4RTBAK88Ij8a
 7qClCpbocPl0NxDbtPJ+swQIKLha5Ohd/B3Ylwe/yhA==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr1750468wrc.218.1633013345167; 
 Thu, 30 Sep 2021 07:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOLlTkV6NaPrivI76QGEXMY+sb/gYn7NFiwzA/bHBOUf/+W/Njis05LJ+J8I0brEkffd7nQQ==
X-Received: by 2002:adf:9bd2:: with SMTP id e18mr1750088wrc.218.1633013340064; 
 Thu, 30 Sep 2021 07:49:00 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id n68sm4975961wmn.13.2021.09.30.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 07:48:59 -0700 (PDT)
Date: Thu, 30 Sep 2021 10:48:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930104640-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
MIME-Version: 1.0
In-Reply-To: <20210930144305.GA464826@rowland.harvard.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > While the common case for device-authorization is to skip probe of
> > > > unauthorized devices, some buses may still want to emit a message on
> > > > probe failure (Thunderbolt), or base probe failures on the
> > > > authorization status of a related device like a parent (USB). So add
> > > > an option (has_probe_authorization) in struct bus_type for the bus
> > > > driver to own probe authorization policy.
> > > > 
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > 
> > > 
> > > So what e.g. the PCI patch
> > > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > > actually proposes is a list of
> > > allowed drivers, not devices. Doing it at the device level
> > > has disadvantages, for example some devices might have a legacy
> > > unsafe driver, or an out of tree driver. It also does not
> > > address drivers that poke at hardware during init.
> > 
> > Doing it at a device level is the only sane way to do this.
> > 
> > A user needs to say "this device is allowed to be controlled by this
> > driver".  This is the trust model that USB has had for over a decade and
> > what thunderbolt also has.
> > 
> > > Accordingly, I think the right thing to do is to skip
> > > driver init for disallowed drivers, not skip probe
> > > for specific devices.
> > 
> > What do you mean by "driver init"?  module_init()?
> > 
> > No driver should be touching hardware in their module init call.  They
> > should only be touching it in the probe callback as that is the only
> > time they are ever allowed to talk to hardware.  Specifically the device
> > that has been handed to them.
> > 
> > If there are in-kernel PCI drivers that do not do this, they need to be
> > fixed today.
> > 
> > We don't care about out-of-tree drivers for obvious reasons that we have
> > no control over them.
> 
> I don't see any point in talking about "untrusted drivers".  If a 
> driver isn't trusted then it doesn't belong in your kernel.  Period.  
> When you load a driver into your kernel, you are implicitly trusting 
> it (aside from limitations imposed by security modules).  The code 
> it contains, the module_init code in particular, runs with full 
> superuser permissions.
> 
> What use is there in loading a driver but telling the kernel "I don't 
> trust this driver, so don't allow it to probe any devices"?  Why not 
> just blacklist it so that it never gets modprobed in the first place?
> 
> Alan Stern

When the driver is built-in, it seems useful to be able to block it
without rebuilding the kernel. This is just flipping it around
and using an allow-list for cases where you want to severly
limit the available functionality.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
