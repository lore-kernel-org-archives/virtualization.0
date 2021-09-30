Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED2C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:38:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162E961A08
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 162E961A08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1D5C60686;
	Thu, 30 Sep 2021 14:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jejekYPbyHyv; Thu, 30 Sep 2021 14:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E39460667;
	Thu, 30 Sep 2021 14:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41D19C000F;
	Thu, 30 Sep 2021 14:38:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B110C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CA96840E2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fo4Op6A1FOVa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D9F283F0C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633012729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fj331J8gANBz1gR6zaAgnFZdzxi9a1lUWPYZsgHCyYI=;
 b=NPTK6uGC+tk9Ziuexcd+AsM2IXdYOi30kHFeytqbaDMLWuYXOI6KEL6Mvw9bbtviw7mwCh
 I024+7ZQgKfYskNpOOWHOLzDayr42Cb6g1FPj22JGOs5iaM6p80KEmNxcJ4+ODw5MNyZXV
 tAo+ngQCR7oTcEG8utpzMMS9tAXHONM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-zug_ffXMNIy86sqLKJBMgA-1; Thu, 30 Sep 2021 10:38:48 -0400
X-MC-Unique: zug_ffXMNIy86sqLKJBMgA-1
Received: by mail-ed1-f71.google.com with SMTP id
 z6-20020a50cd06000000b003d2c2e38f1fso6572987edi.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 07:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fj331J8gANBz1gR6zaAgnFZdzxi9a1lUWPYZsgHCyYI=;
 b=yWJQF0wpCldNkYgPyEsu/3wu/saztWc8TVrfcQu1EmMDaV43O5AWQHYMqi84Am7fSc
 Yxjfpd88hnOvdgK0FvcRLeOG16UBHGdwtnB5FS5lgrxBcDnGHEx5R/AGGgmtrHHJBTkm
 w+kXgGkRuhqBq9koHFLS/z1ru7lLvMBvWPUfTlquOPLFeZsuPzFgiHncfIFAsy2Ncftl
 xZZOQIz/cZZHdHXAYrrjhcbPuCxCZ3ln5HIxViqao8lI6qIXnTQSFgHW2LHz8DovIk+R
 IeNh7VYvKMtYMsidgEpX8kwKbtnnjc95RzQszbIWfnInip1nJDBfD0MP0MEPTvKpQUil
 fEzA==
X-Gm-Message-State: AOAM5323HF9Cq/q4wYyuq3YxIUYlyE5omHUJjhWgQ9l7FaTA4pNyjLW9
 2uu7fKxIVIJAgE0ypI6g6C0qCXiB0x6NrK21wanp9N9cDrrnTvJJPJ4vdEdQ6NvThctu13nKKW3
 ijgm1yKswSl8v+dBd3vZ9Iv3j02sZkUqEehq+XNt6iQ==
X-Received: by 2002:a50:cfcb:: with SMTP id i11mr7532212edk.347.1633012727152; 
 Thu, 30 Sep 2021 07:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyoY8MlHma3/meQa/alF0eoOEaUHfr4CeWPL4UOFREXT8lK5GBMJpzF9t0MEPSKJxLdjYaGA==
X-Received: by 2002:a50:cfcb:: with SMTP id i11mr7532190edk.347.1633012726972; 
 Thu, 30 Sep 2021 07:38:46 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id u18sm1575656ejc.26.2021.09.30.07.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 07:38:46 -0700 (PDT)
Date: Thu, 30 Sep 2021 10:38:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930103537-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YVXBNJ431YIWwZdQ@kroah.com>
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

On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > While the common case for device-authorization is to skip probe of
> > > unauthorized devices, some buses may still want to emit a message on
> > > probe failure (Thunderbolt), or base probe failures on the
> > > authorization status of a related device like a parent (USB). So add
> > > an option (has_probe_authorization) in struct bus_type for the bus
> > > driver to own probe authorization policy.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > 
> > 
> > So what e.g. the PCI patch
> > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > actually proposes is a list of
> > allowed drivers, not devices. Doing it at the device level
> > has disadvantages, for example some devices might have a legacy
> > unsafe driver, or an out of tree driver. It also does not
> > address drivers that poke at hardware during init.
> 
> Doing it at a device level is the only sane way to do this.
> 
> A user needs to say "this device is allowed to be controlled by this
> driver".  This is the trust model that USB has had for over a decade and
> what thunderbolt also has.
> 
> > Accordingly, I think the right thing to do is to skip
> > driver init for disallowed drivers, not skip probe
> > for specific devices.
> 
> What do you mean by "driver init"?  module_init()?
> 
> No driver should be touching hardware in their module init call.  They
> should only be touching it in the probe callback as that is the only
> time they are ever allowed to talk to hardware.  Specifically the device
> that has been handed to them.
> 
> If there are in-kernel PCI drivers that do not do this, they need to be
> fixed today.
> 
> We don't care about out-of-tree drivers for obvious reasons that we have
> no control over them.
> 
> thanks,
> 
> greg k-h

Well talk to Andi about it pls :)
https://lore.kernel.org/r/ad1e41d1-3f4e-8982-16ea-18a3b2c04019%40linux.intel.com

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
