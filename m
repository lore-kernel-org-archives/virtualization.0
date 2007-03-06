From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 10:34:36 +0100
Message-ID: <20070306093436.GA30239@elte.hu>
References: <1173101297.26165.39.camel@localhost.localdomain> <1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030456AbXCFJfW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45ED3121.8090308@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Gerd Hoffmann <kraxel@suse.de> wrote:

> Oh, and btw: What was the reason why kvm paravirtualization doesn't 
> use the vmi interface?

cleanliness and performance: KVM doesnt need any artificial indirection. 
IMO the GPL-ed ROM portion of VMI was a bad idea to begin with. Also, 
lguest and KVM is Linux-internal, so there's a natural match between the 
guest and the host APIs.

> > yes, just like we have thousands of separate PC boards to support. 
> > But as long as the basic ABI is the same, the QA effort on the Linux 
> > kernel side is alot more focused.
> 
> xen and vmware are still two very different hypervisors from the 
> memory mangement point of view.  I doubt moving the abstraction line 
> within the linux kernel from paravirt_ops to vmi makes QA easier.

well, the VMI patches got into Linux with the claim that it's also 
useful for Xen. So that claim was ... not actually true?

	Ingo
