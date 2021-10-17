Return-Path: <SRS0=jOBa=PF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C95CC433F5
	for <virtualization@archiver.kernel.org>; Sun, 17 Oct 2021 22:17:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D6E61002
	for <virtualization@archiver.kernel.org>; Sun, 17 Oct 2021 22:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09D6E61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B318940331;
	Sun, 17 Oct 2021 22:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_u-fI5x8g0t; Sun, 17 Oct 2021 22:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0C3740150;
	Sun, 17 Oct 2021 22:17:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7831C000F;
	Sun, 17 Oct 2021 22:17:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD46FC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 22:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC05781815
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 22:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARHg3jnoKOKy
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 22:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E67D817FF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634509037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC0sWKuJ5MpDbY6DXl9zvz5o696+GJBNvO+SxKY2kO8=;
 b=g9kt0xnEzAVlN5hY9eXJmdupNUnPN84Rd/qXJCJ6KhgMgb7G6bpPHELDBzVGS5XI4Jq64V
 0EjYA1sGw6xwy9HH18vQO6lMMHj3fS8Y/lzyimrSt5WtWy0M4neSgT2nKB+0Srs1Wi1pru
 /B+YtkWzvYD7PDiXL+1//jMBUYSCO3k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-eQ7sWGVpNb2XcDH9sNUrbA-1; Sun, 17 Oct 2021 18:17:15 -0400
X-MC-Unique: eQ7sWGVpNb2XcDH9sNUrbA-1
Received: by mail-ed1-f70.google.com with SMTP id
 v2-20020a50f082000000b003db24e28d59so12525797edl.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 15:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VC0sWKuJ5MpDbY6DXl9zvz5o696+GJBNvO+SxKY2kO8=;
 b=5NSiQkP4bLphaaW6AZiVCC0kGam4aEgofZ5rDyRTljssJm1EfuYyUTAEABLr+nm8j2
 gxWbMO7hrkJI+t3yKGeeMFNJiXwoitHYl5085m4U87sqtK2G6DcViJ84xJNZy5kLd8Re
 5MDd0cDnh7SaFgiGi3CYTsIwuD+SYqmTJlBsLMBdufh7cA2TWGkoD6YOwYwt8drETXyo
 YOaoF4hVb6kQvln60og54M6XvYPIILs7m7vdcUjEX2FHt+Z5tF1wM2U0TWqFGQVg69Oz
 sROo9GLsdJS7YsrFMHYNKef/LApPH26POc6zJMbBgOqtV5TFSFlnAH66gES2JrG5cncM
 rZmg==
X-Gm-Message-State: AOAM533FGBUkPa7liDetZ3Be6mnfZkmje+C19IziQnBQ58V97afvkGHm
 nP5RkLoRgRa/SezWZMjil7Ri8RmYsUuTc/dIjn1QpskdgyacM/E5ddS+2Q4XAnq7SLPu26sDhsM
 q7lhuE3+rf5V7616kSij+GtQWqH/nyOwao3nB/zW/ww==
X-Received: by 2002:a17:906:38db:: with SMTP id
 r27mr24705883ejd.338.1634509034121; 
 Sun, 17 Oct 2021 15:17:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx51KnpBX8SOErBYIGNeXUSpnLaZGw8M8o8nNtAQZwgmzpfpG+8uY45Z6g2dYvFNl1kABYCEw==
X-Received: by 2002:a17:906:38db:: with SMTP id
 r27mr24705846ejd.338.1634509033862; 
 Sun, 17 Oct 2021 15:17:13 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
 by smtp.gmail.com with ESMTPSA id kw5sm7937099ejc.110.2021.10.17.15.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Oct 2021 15:17:12 -0700 (PDT)
Date: Sun, 17 Oct 2021 18:17:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211017180950-mutt-send-email-mst@kernel.org>
References: <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014025514-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57500B2D821E8AAF93EB66CEE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211014052605-mutt-send-email-mst@kernel.org>
 <DM8PR11MB57505AAA1E1209F7FCA69C11E7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR11MB57505AAA1E1209F7FCA69C11E7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, "Lutomirski, Andy" <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "David S . Miller" <davem@davemloft.net>,
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

On Thu, Oct 14, 2021 at 12:33:49PM +0000, Reshetova, Elena wrote:
> > On Thu, Oct 14, 2021 at 07:27:42AM +0000, Reshetova, Elena wrote:
> > > > On Thu, Oct 14, 2021 at 06:32:32AM +0000, Reshetova, Elena wrote:
> > > > > > On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > > > > > > The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> > > > > > > > others) in init functions that also register drivers (thanks Elena for
> > > > > > > > the number)
> > > > > > >
> > > > > > > To provide more numbers on this. What I can see so far from a smatch-
> > based
> > > > > > > analysis, we have 409 __init style functions (.probe & builtin/module_
> > > > > > > _platform_driver_probe excluded) for 5.15 with allyesconfig.
> > > > > >
> > > > > > I don't think we care about allyesconfig at all though.
> > > > > > Just don't do that.
> > > > > > How about allmodconfig? This is closer to what distros actually do.
> > > > >
> > > > > It does not make any difference really for the content of the /drivers/*:
> > > > > gives 408 __init style functions doing IO (.probe & builtin/module_
> > > > > > > _platform_driver_probe excluded) for 5.15 with allmodconfig:
> > > > >
> > > > > ['doc200x_ident_chip',
> > > > > 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> > > > > 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> > > > > 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> > > > > 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> > > > > 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> > > > > 'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
> > > > > 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',
> > > >
> > > > Um. ARM? Which architecture is this build for?
> > >
> > > The list of smatch IO findings is built for x86, but the smatch cross function
> > > database covers all archs, so when queried for all potential function callers,
> > > it would show non x86 arch call chains also.
> > >
> > > Here is the original x86 finding and call chain for the 'arm_v7s_do_selftests':
> > >
> > >   Detected low-level IO from arm_v7s_do_selftests in fun
> > > __iommu_queue_command_sync
> > >
> > > drivers/iommu/amd/iommu.c:1025 __iommu_queue_command_sync() error:
> > > {15002074744551330002}
> > >     'check_host_input' read from the host using function 'readl' to a
> > > member of the structure 'iommu->cmd_buf_head';
> > >
> > > __iommu_queue_command_sync()
> > >   iommu_completion_wait()
> > >     amd_iommu_domain_flush_complete()
> > >       iommu_v1_map_page()
> > >         arm_v7s_do_selftests()
> > >
> > > So, the results can be further filtered if you want a specified arch.
> > 
> > So what is it just for x86? Could you tell?
> 
> I can probably figure out how to do additional filtering here, but does
> it really matter for the case that is being discussed here? Andi's point was
> that there quite many existing places in the kernel when low-level IO
> happens before the probe stage. So I brought these numbers here.
> What do you plan to do with the pure x86 results? 

If the list is short - just suggest securing that ;)


> And here are the full results for allyesconfig, if anyone is interested (just got permission to create
> the repository today):
> https://github.com/intel/ccc-linux-guest-hardening/tree/master/audit/sample_output/5.15-rc1
> We will be pushing to this repo all the scripts and fuzzing setups we use as part of
> our Linux guest hardening effort for confidential cloud computing, but it is going to take
> some time to get all the approvals collected.  
> 
> Best Regards,
> Elena.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
