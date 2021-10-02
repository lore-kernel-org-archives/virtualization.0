Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A3C433FE
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 18:41:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254E061B3F
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 18:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 254E061B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB75C6081D;
	Sat,  2 Oct 2021 18:41:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngOKd2EkHocg; Sat,  2 Oct 2021 18:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68E816061A;
	Sat,  2 Oct 2021 18:41:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3969CC000F;
	Sat,  2 Oct 2021 18:41:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CA2C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11076844C5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDLXifSr7KUl
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46D3E844C0
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633200064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ST0KR7EU4N0YWDaDZLrBL4QmpL0x0hJwSn6j1QI0rBo=;
 b=WFcS156LyoF6LU39OH2UscFA4SumAoQCbj5BeH3OAsEiu5ZeyqIhWWLSY2qcxPuLBMH5Wp
 D/66XOvgXqYB3o5UWKIil99XS5MCFoSlRHHSbtbySYVijEUkpZ4H2Ewc/Kg9qCoK9SJy5j
 5g7SpcoSjsClczL0sKyK6kGkHt1Ur6M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-1pmUf6YLP42jEfC_v9kQfg-1; Sat, 02 Oct 2021 14:41:03 -0400
X-MC-Unique: 1pmUf6YLP42jEfC_v9kQfg-1
Received: by mail-ed1-f72.google.com with SMTP id
 y15-20020a50ce0f000000b003dab997cf7dso9748677edi.9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 02 Oct 2021 11:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ST0KR7EU4N0YWDaDZLrBL4QmpL0x0hJwSn6j1QI0rBo=;
 b=DU3HtM1dhS0oY6u3dyVPi0uEmr6HITkDJ47yhM9VkgApSD9mpjW65Xj9uUZyKstilz
 sO4qJDsjKxE8FS4Bfi+Uxjjy4e/3tUq5/+cyGnvIDYGpmMOe/pKEAEP8w42VW9z7xEtW
 2SZysIbty6tb8ByRlqlA0IcQkjAbLhkTq7r6q4iaNS0v4o4dUaOG6W1NddRkWwzB2kv/
 2otO3G6bTq+0/YVajiky1hbtzRI28H6DEet17et/JgFDhxP2spG6KoSGnJuOLJEda6TZ
 iT8Ghm/eD0oc9VqbCuQrPzYcwrMxrY1c7VwfIDFyG2INDZcat+FfI3K9Hv9Oz3RywMCz
 vvmA==
X-Gm-Message-State: AOAM530xq3JT7oWxBymhbVg4PvjVFHMkK0VUPkWMrudgGLSMXkGjQu8v
 eejtL6G9W0Ba/8Aqr9bUcsf58NLrPnzoHbqFhEJuizTrFUXYpqqayxKRcMOk/z70aGLLfqGcO74
 KvEnqMFUv81ooEQtrv9Aj2k5EfdmMBkB+LZqOpYLVoQ==
X-Received: by 2002:a50:da8d:: with SMTP id q13mr5838532edj.198.1633200062592; 
 Sat, 02 Oct 2021 11:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGpM5OHPmCsSpi/pPXyOIbm5UqYLz0NOB9b8PBSBu07W665C9nUJCeC1Y0L2Zy/zB57lHbAA==
X-Received: by 2002:a50:da8d:: with SMTP id q13mr5838496edj.198.1633200062359; 
 Sat, 02 Oct 2021 11:41:02 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id a23sm4866108edv.33.2021.10.02.11.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 11:41:01 -0700 (PDT)
Date: Sat, 2 Oct 2021 14:40:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20211002142138-mutt-send-email-mst@kernel.org>
References: <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org>
 <YVg/F10PCFNOtCnL@kroah.com>
 <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Reshetova,
 Elena" <elena.reshetova@intel.com>
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

On Sat, Oct 02, 2021 at 07:20:22AM -0700, Andi Kleen wrote:
> 
> On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> > On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> > > > >    Do you have a list of specific drivers and kernel options that you
> > > > > feel you now "trust"?
> > > > For TDX it's currently only virtio net/block/console
> > > > 
> > > > But we expect this list to grow slightly over time, but not at a high rate
> > > > (so hopefully <10)
> > > Well there are already >10 virtio drivers and I think it's reasonable
> > > that all of these will be used with encrypted guests. The list will
> > > grow.
> > What is keeping "all" drivers from being on this list?
> 
> It would be too much work to harden them all, and it would be pointless
> because all these drivers are never legitimately needed in a virtualized
> environment which only virtualize a very small number of devices.
> 
> >   How exactly are
> > you determining what should, and should not, be allowed?
> 
> Everything that has had reasonable effort at hardening can be added. But if
> someone proposes to add a driver that should trigger additional scrutiny in
> code review. We should also request them to do some fuzzing.

Looks like out of tree modules get a free pass then.
Which is exactly the reverse of what it should be,
people who spent the time to get their drivers into the kernel
expect that if kernel decides to change some API their
driver is automatically updated. This was always the social
contract, was it not?

> It's a bit similar to someone trying to add a new syscall interface. That
> also triggers much additional scrutiny for good reasons and people start
> fuzzing it.
> 
> 
> >    How can
> > drivers move on, or off, of it over time?
> 
> Adding something is submitting a patch to the allow list.
> 
> I'm not sure the "off" case would happen, unless the driver is completely
> removed, or maybe it has some unfixable security problem. But that is all
> rather unlikely.
> 
> 
> > 
> > And why not just put all of that into userspace and have it pick and
> > choose?  That should be the end-goal here, you don't want to encode
> > policy like this in the kernel, right?
> 
> How would user space know what drivers have been hardened? This is really
> something that the kernel needs to determine. I don't think we can outsource
> it to anyone else.

IIUC userspace is the distro. It can also do more than a binary on/off,
e.g. it can decide "only virtio", "no out of tree drivers".
A distro can also ship configs with a specific features
enabled/disabled. E.g. I can see where some GPU drivers will be
included by some distros since they are so useful, and excluded
by others since they are so big and hard to audit.
I don't see how the kernel can reasonably make a stand here.
Is "some audit and some fuzzing" a good policy? How much is enough?

> Also BTW of course user space can still override it, but really the defaults
> should be a kernel policy.

Well if userspace sets the policy then I'm not sure we also want
a kernel one ... but if yes I'd like it to be in a central
place so whoever is building the kernel can tweak it easily
and rebuild, without poking at individual drivers.

> There's also the additional problem that one of the goals of confidential
> guest is to just move existing guest virtual images into them without much
> changes. So it's better for such a case if as much as possible of the policy
> is in the kernel.

If it's e.g. the kernel command line then we can set that
when building the kernel right? No need for a dedicated interface
just for this ...

> But that's more a secondary consideration, the first point
> is really the important part.
> 
> 
> -Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
