From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 11:26:59 +0100
Message-ID: <20070306102658.GA7478@elte.hu>
References: <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de>
	<20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de>
	<20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED3F29.6000705@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Gerd Hoffmann <kraxel@suse.de> wrote:

> > cleanliness and performance: KVM doesnt need any artificial =

> > indirection.
> =

> Xen doesn't need it either.
> =

> > IMO the GPL-ed ROM portion of VMI was a bad idea to begin with.
> =

> So why do you want xen use vmi then?

due to the other argument i listed:

|| Also, lguest and KVM is Linux-internal, so there's a natural match =

|| between the guest and the host APIs.

It's a basic kernel maintainance issue: lguest/KVM and Linux host and =

guest will co-evolve foward in a natural way as they are in essence =

Linux-internal technologies. They /will/ harmonize. There is no such =

guarantee with Xen/VMWare/etc. (which are distinctly separate =

technologies) - so any ABIs towards them could become (and are already =

becoming) a drag and distraction.

> > well, the VMI patches got into Linux with the claim that it's also =

> > useful for Xen. So that claim was ... not actually true?
> =

> As mentioned there was a proof-of-concept VMI ROM done by vmware.  As =

> far I know it translated the VMI ROM interface calls into xen =

> hypercalls somehow, Zach probably has more details.
> =

> So in the end you would still have two different hypervisor ABI's, the =

> VMI ROM just hides that.

oh, but that way i have cleverly pushed the problem out of Linux and =

into the VMI-ROM's domain ;) Which is all i care about.

really, one of my jobs as a maintainer is to keep crap out of Linux (we =

are capable of adding enough crap ourselves ;-). Having multiple, =

overlapping, technologically redundant ABIs between /software/, embedded =

into the heart of the kernel (paravirt ops nonwithstanding), for =

perpetuity, is one such type of crap. It is in fact the kind of crap i'm =

/most/ worried about, because it sticks forever.

	Ingo
