Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4FBC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:53:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD3D60F9B
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECD3D60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96D9481053;
	Mon, 13 Sep 2021 05:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQ9l42hs_1Cm; Mon, 13 Sep 2021 05:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D10F80E30;
	Mon, 13 Sep 2021 05:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC6FC000F;
	Mon, 13 Sep 2021 05:53:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCA88C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7D9060849
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYqTC9K1IyPw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:53:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E82E607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631512417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmIEdzAE8KtfMvdI7Vd3u1eV+5W/XqJ3cF9Jvl0CpQM=;
 b=hba9LN/K8sGgLov/lZRQ6l3oSQ+7L+pv5G+v2J8/Z0HMbT3DYz02f4jX5DU7by81SqSv1U
 eDyW2pgFe0A3K52vJB8EBdW5sR3IskS8SyW57BuFogt3KmtOeA9Tcb7AMcYJFmk9kG1yZF
 Z7hLO+6Vc2vi5HLduNMSzDXAvW8+cpw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-RNNFLPiUNoO0D9okXGzHjQ-1; Mon, 13 Sep 2021 01:53:36 -0400
X-MC-Unique: RNNFLPiUNoO0D9okXGzHjQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 k29-20020a05600c1c9d00b00304e40495b2so1849233wms.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 22:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lmIEdzAE8KtfMvdI7Vd3u1eV+5W/XqJ3cF9Jvl0CpQM=;
 b=tWOzfTMubGCJvMCwjwGNq3fWYU/J7b56PDyCdnc30O94UOH+qriC2MtB8/gfwXqoY5
 RUY0PYPpePzU9Ny7PFUYE+B9Z7d0JHIAdAzCtIHocm1TXjpimgb7lRG9OZyyMjolAUi6
 5FPGnUblDDhSLXuCjW+FzIcDJzEZ0o00O7NL1Orj4m63REZTB125FEXoDBMY1EC1bPA2
 mI+l9uLk+Bv3RAxRry3kS+Osy5mwTHUVMcEr8A7IHzxWriFi9nkqyT4e96wgBhIgXvaW
 DW4ObaBgowoK917eEcGLpVqK7zp0F/8qp3BZSPJxyaDgjLhPDd7xUmqVCjvco3gjGCTm
 7TPg==
X-Gm-Message-State: AOAM530GTN2u8D8xkG47B6AI8fh1NWj+MO12b9lAMxMQYG6aUOoRr3kN
 VX5MGeydY3lcBYLuL5YfuYKDKVS4KLbJFTcaWwXadGdBVJVElaIfzIrFBr7WTvwPKuBD8yZxNs+
 h49DDU5NXYpFGV5WMzx/IYDj4QtP3G10zJI09i3pcUg==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr9470571wmk.135.1631512415168; 
 Sun, 12 Sep 2021 22:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTQJ4DZD+V1695amUyGJ/+8H3ZLTdwwSERHH6LaZYj9FQdGTZerMCI+h0RgKu+afW5N87HtQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr9470536wmk.135.1631512414954; 
 Sun, 12 Sep 2021 22:53:34 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id k29sm5687574wms.24.2021.09.12.22.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 22:53:33 -0700 (PDT)
Date: Mon, 13 Sep 2021 01:53:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210913013815-mutt-send-email-mst@kernel.org>
References: <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
 <20210911195006-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210911195006-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Sat, Sep 11, 2021 at 07:54:43PM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 10, 2021 at 09:34:45AM -0700, Andi Kleen wrote:
> > > > that's why
> > > > an extra level of defense of ioremap opt-in is useful.
> > > OK even assuming this, why is pci_iomap opt-in useful?
> > > That never happens before probe - there's simply no pci_device then.
> > 
> > 
> > Hmm, yes that's true. I guess we can make it default to opt-in for
> > pci_iomap.
> > 
> > It only really matters for device less ioremaps.
> 
> OK. And same thing for other things with device, such as
> devm_platform_ioremap_resource.
> If we agree on all that, this will basically remove virtio
> changes from the picture ;)


Something else that was pointed out to me:

         fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);
         if (IS_ERR(fs->window_kaddr))
                 return PTR_ERR(fs->window_kaddr);


looks like if we forget to set the shared flag then it will
corrupt the DAX data?


> -- 
> MST
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
