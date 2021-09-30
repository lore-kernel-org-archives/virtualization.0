Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E9861411
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58E9861411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BBEC425AC;
	Thu, 30 Sep 2021 15:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw4XWkna7_Yf; Thu, 30 Sep 2021 15:52:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9CAFA422AD;
	Thu, 30 Sep 2021 15:52:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF27C0011;
	Thu, 30 Sep 2021 15:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7CFFC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B44B8840C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uahha4fiW1-v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 670FA840C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633017141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVmoSKlXkLAYB9YWRq2HT/6NKIMmAUGmQq1ySxlsNKU=;
 b=I8XKNzCInjF59ispHwIXxsifPo0CMeWdEj392d3QJWmaWeWJ83z/LLT01v2QcCOY35s1AN
 W2Mxk0yfwziQ8qekdtD9kO0ynRjNV2HKWf6kWjh0h9vO25ny2xjwKX5+FXtQYS82ai2w+s
 Ydn4dV++UMK87CsgIaexpDdKmjPEJ9A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-gUD3Ryv1Ndigo5D3793gFQ-1; Thu, 30 Sep 2021 11:52:19 -0400
X-MC-Unique: gUD3Ryv1Ndigo5D3793gFQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 m9-20020a05600c4f4900b003057c761567so4537325wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NVmoSKlXkLAYB9YWRq2HT/6NKIMmAUGmQq1ySxlsNKU=;
 b=O0nug9s3Tojf/gHjK8UCDIJXa3LDQRolX8PE8qNXeTBw6Wp6ssMC7QUubWsEEgPbnF
 F926GeWUfgiZeEAsYPAgXKqDWwVtxKBDJPeWCJFIb8S0KRwyLEYRshy+264vONbjBfD3
 CWgjlk6Hs3IZbcYwEivjkfB+96xvDFsEgpbv9JP5+zvWMSasT4BABBJor69G+Ew5VxJ4
 wTrkqu1Y5+W2mYibONcMOv2drTbIjYlUOCV/vfLTxOZkpN0Kyd2CNsU9T8QRNOBVozJJ
 66Na1IyNC7ghvaL3rI9GYPY5Wm6RFReUaT6YGqa7ghEaLVFvGQFnLBO06itPktShqgoF
 YSxg==
X-Gm-Message-State: AOAM533q+4Wr1MhMDFdbCybyDFNFzzk+KKdFjGhmz2Ozf99Z3Cxp1xEG
 i4BFkz4NG+4DcnQg2WnkKUIBX1B+OcbBQJbQk0DKkeeWEpGjfMqAAuWKqjUKA9KZrWK8hODT7MA
 UrkBiFvg9R1FMJ8Jz5pwOi/ff3uCDDB+fwWm1rOID6Q==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr7186936wrj.66.1633017138813;
 Thu, 30 Sep 2021 08:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvZVp74K6IQg5vdKu27+JG9+WUQkfW9TKM4Z4S4rEE1CdnJHLUxb+4aAUPcwK1d944tYc9pA==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr7186902wrj.66.1633017138595;
 Thu, 30 Sep 2021 08:52:18 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id o7sm4045187wro.45.2021.09.30.08.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 08:52:18 -0700 (PDT)
Date: Thu, 30 Sep 2021 11:52:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930115159-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104640-mutt-send-email-mst@kernel.org>
 <20210930153241.GE464826@rowland.harvard.edu>
MIME-Version: 1.0
In-Reply-To: <20210930153241.GE464826@rowland.harvard.edu>
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

On Thu, Sep 30, 2021 at 11:32:41AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 10:48:54AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > > I don't see any point in talking about "untrusted drivers".  If a 
> > > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > > When you load a driver into your kernel, you are implicitly trusting 
> > > it (aside from limitations imposed by security modules).  The code 
> > > it contains, the module_init code in particular, runs with full 
> > > superuser permissions.
> > > 
> > > What use is there in loading a driver but telling the kernel "I don't 
> > > trust this driver, so don't allow it to probe any devices"?  Why not 
> > > just blacklist it so that it never gets modprobed in the first place?
> > > 
> > > Alan Stern
> > 
> > When the driver is built-in, it seems useful to be able to block it
> > without rebuilding the kernel. This is just flipping it around
> > and using an allow-list for cases where you want to severly
> > limit the available functionality.
> 
> Does this make sense?
> 
> The only way to tell the kernel to block a built-in driver is by 
> using some boot-command-line option.  Otherwise the driver's init 
> code will run before you have a chance to tell the kernel anything at 
> all.
> 
> So if you change your mind about whether a driver should be blocked, 
> all you have to do is remove the blocking option from the command 
> line and reboot.  No kernel rebuild is necessary.
> 
> Alan Stern

Right.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
