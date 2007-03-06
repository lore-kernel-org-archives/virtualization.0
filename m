From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 12:04:56 +0100
Message-ID: <45ED4AD8.6020504@suse.de>
References: <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de> <20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de> <20070306102658.GA7478@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964919AbXCFLEu@vger.kernel.org>
In-Reply-To: <20070306102658.GA7478@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>>> IMO the GPL-ed ROM portion of VMI was a bad idea to begin with.
>> So why do you want xen use vmi then?
> 
> due to the other argument i listed:
> 
> || Also, lguest and KVM is Linux-internal, so there's a natural match 
> || between the guest and the host APIs.
>
> It's a basic kernel maintainance issue: lguest/KVM and Linux host and 
> guest will co-evolve foward in a natural way as they are in essence 
> Linux-internal technologies. They /will/ harmonize.

Yes for lguest, that is a linux-only ground for play and research and
that will most likely not change in near future.

It is complete bullshit for kvm.  You can run almost anything as guest
in kvm, and I certainly wouldn't be surprised if we see other operating
systems start using the kvm paravirt interface.

> There is no such 
> guarantee with Xen/VMWare/etc. (which are distinctly separate 
> technologies) - so any ABIs towards them could become (and are already 
> becoming) a drag and distraction.

We'll certainly need some stable ABI for kvm too, so you can mix kernel
versions on host and guest.  I really can't see why do you think kvm is
special in any way (except that it is your favorite toy at the moment).

>> So in the end you would still have two different hypervisor ABI's, the 
>> VMI ROM just hides that.
> 
> oh, but that way i have cleverly pushed the problem out of Linux and 
> into the VMI-ROM's domain ;) Which is all i care about.

Fine, so lets move kvm paravirtualitzation into vmi too (proof of
concept code by Anthony Liguori exists) and kill one more item on the
(linux) QA test matrix?  (just following your arguments, not that I'm
confident it would actually help reducing QA effort).

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
