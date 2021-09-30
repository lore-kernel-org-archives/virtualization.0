Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864BEC4332F
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:59:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE2761555
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CE2761555
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB28D60667;
	Thu, 30 Sep 2021 15:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YynLQek3hNJ7; Thu, 30 Sep 2021 15:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 812A6613D3;
	Thu, 30 Sep 2021 15:59:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54B76C0011;
	Thu, 30 Sep 2021 15:59:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0306BC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD9D44076A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5gTY6IZ-XqA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1558E40354
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633017552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9CLOOKqnl6WBTiVh9cnZX+K/sEpCo7/g2qzibCOpSjw=;
 b=WFfJsIce6l1rBp9X4Yi/5B9Dabs2qryT18zWK+ssgoXw+D4TZUV9znp5Ro/UqRq+34UsaZ
 x6pfZUY7Deduxndoqav9/5LW9gP4oUYVFMCOSvsfZ/9dM2H/A336qWiV26cXjFdAOtWSdh
 jHTwrGSXPUOZbp9xpvNbVvi82YDNA5Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-Vrn7VfpLPlCM4_zrAPjfDg-1; Thu, 30 Sep 2021 11:59:11 -0400
X-MC-Unique: Vrn7VfpLPlCM4_zrAPjfDg-1
Received: by mail-wm1-f70.google.com with SMTP id
 n3-20020a7bcbc3000000b0030b68c4de38so2125293wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9CLOOKqnl6WBTiVh9cnZX+K/sEpCo7/g2qzibCOpSjw=;
 b=e/LFKDj6WfRAM1NVmhuDHHVPICyb2WirHQXN6EuDUVd8YE6K/JGRPV7j8D4/EjTNo5
 UKsgR4qmakHtbkfV8RiveIrvwKEIkhn60Nw6d730zuOAAPMcMyV4CnBPnANSYs2IcTOr
 VccVHLbxycDbCkG8sAbZ+b/AmKgctUbEO6S/045A69JXxMX7gWQ4icQpQsD9dUwo8/gi
 kpJiB6Hnir4yT13p7WNWsTL4TjVkGL9nq/C4RgmoCtSDyigDkhd7epFqC6B7Bq62ZcIT
 3O0WeEULObPJgQ4K3zTlEeV6GTVlgE+ssa2n2Ky3eqbfBEyIew91K900jnQgTQ+Zdand
 iJ8g==
X-Gm-Message-State: AOAM530C4khjjQa63gAh7QSAeLLQDB0UsB9+Vf0MxOWyQ0jMWDRoTOsm
 LN7lhLDdru8/ooD8fQyW1uFNEwaTfzahmYm+X4egByHauADqacl83JbxRILOnHePbxzX7gOlALM
 UENe5LXZJsbwFvjEhyAvGpFU8Rrgyntrl476sJI/tvw==
X-Received: by 2002:adf:c7c2:: with SMTP id y2mr6859876wrg.248.1633017550252; 
 Thu, 30 Sep 2021 08:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy42E8my5muvsE8Nz78EmU3Z+uZP9H3yPkno0xob4dMAYSNcsCrkwFOYhLWIW8NasAhP33f4A==
X-Received: by 2002:adf:c7c2:: with SMTP id y2mr6859853wrg.248.1633017550085; 
 Thu, 30 Sep 2021 08:59:10 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id o19sm3590521wrg.60.2021.09.30.08.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 08:59:09 -0700 (PDT)
Date: Thu, 30 Sep 2021 11:59:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930115243-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
MIME-Version: 1.0
In-Reply-To: <20210930153509.GF464826@rowland.harvard.edu>
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

On Thu, Sep 30, 2021 at 11:35:09AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 10:58:07AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > > I don't see any point in talking about "untrusted drivers".  If a 
> > > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > > When you load a driver into your kernel, you are implicitly trusting 
> > > it (aside from limitations imposed by security modules).
> > 
> > Trusting it to do what? Historically a ton of drivers did not
> > validate input from devices they drive. Most still don't.
> 
> Trusting it to behave properly (i.e., not destroy your system, among 
> other things).

I don't think the current mitigations under discussion here are about
keeping the system working. In fact most encrypted VM configs tend to
stop booting as a preferred way to handle security issues.

> The fact that many drivers haven't been trustworthy is beside the 
> point.  By loading them into your kernel, you are trusting them 
> regardless.  In the end, you may regret having done so.  :-(
> 
> Alan Stern



-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
