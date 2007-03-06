From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 13:34:20 +0100
Message-ID: <45ED5FCC.3000608@suse.de>
References: <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de> <20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de> <20070306102658.GA7478@elte.hu> <45ED4AD8.6020504@suse.de> <20070306115937.GA25313@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932089AbXCFMe1@vger.kernel.org>
In-Reply-To: <20070306115937.GA25313@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> legacy support has to be ensured, but it does not hugely matter in terms 
> of the designing our future. What matters is that once we change some 
> fundamental aspect of Linux, we can adopt lguest/KVM immediately. With 
> 'external' hypervisors there is no such compulsory forward motion, and 
> my fear is that by giving them ABI interfaces to the innards of the 
> Linux guest they will just stick with those ABIs - and worse, drag Linux 
> along with them. (because distros will be forced by the legacy 
> assumptions to carry those ABIs along.)

I don't share your fear when it comes to Xen.

The Xen ABI did involve too, there are a few hypercalls with old and new
versions, just like different linux syscall versions exist.  Guests then
can choose to either fallback to the slow, old version in case the new
hypercall returns -ENOSYS or raise the minimum required xen version to
the one with the new hypercall and leave out the legacy cruft.

The current xen hypercall ABI isn't set in stone, it can and will evolve
too ...

> but there is no danger of KVM 
> staying in legacy land forever. With Xen and VMWare i see no guarantee 
> at all that Linux wont be hindered by their legacies (or by any plain 
> diverging approaches) forever.

I don't expect that being a problem with Xen.

> so for example, if we change some fundamental thing that can be 
> implemented via the legacy ABI but only slowly, that's not a problem 
> because new-lguest/new-KVM will use the new approach, so there's a 
> straightforward technology-based migratory path out of the legacy.

See above, that path exists with Xen too.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
