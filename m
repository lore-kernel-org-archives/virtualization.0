From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: hardwired VMI crap
Date: Thu, 08 Mar 2007 15:39:26 -0800
Message-ID: <45F09EAE.6090908@goop.org>
References: <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
	<45EFE010.7080108@vmware.com>
	<1173352154.24738.1023.camel@localhost.localdomain>
	<45F0761C.6060107@vmware.com> <45F07D07.5090003@goop.org>
	<20070308213458.GA24634@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070308213458.GA24634@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>  - /One/ _intelligent_ higher-level virtualization API/ABI. Xen's API is =

>    quite advanced on this front.

At last!  Some love!

The Xen approach has always been to prefer high-level interfaces over
lower-level ones, so that guests can meaningfully participate in their
own virtualization.  There are some necessarily low-level things, but
conceptually simple things like "create a new vcpu" should have simple
interfaces.  There's no point in going to the effort of emulating a
whole pile of real hardware if Xen can present an interface which is a
close match to an existing high-level interface within the operating system.

>  This would be shared by /all/ =

>    hypervisors and could occasionally be reused by other hardware =

>    platforms as well. It can be morphed via small wrappers into some
>    'hypervisor personality' kind of hypervisor backends, but no
>    fundamental transformation happens.
>   =


Because of both general conceptual cleanliness and Xen's requirements,
the pv_ops interface has tended towards fairly high-level interfaces
where possible and useful.

VMI's design tends towards being a closer match to some approximation of
the real underlying hardware, which I suppose is a reflection of its
origins as an extension of a fully virtualizing hypervisor.  I don't
have any particular problem with that, and I think its a perfectly
reasonable approach if that's the path you want to take.

What this means, however, is that the existing arch/i386 code needs to
be refactored so that VMI can reuse it in a sensible way, so that it can
implement the high-level operations in terms of the existing building
blocks that running on bare hardware has to use anyway.

Things like genirq and genapic should help with that in principle. =

genirq certainly cleaned up Xen's interface to the interrupt subsystem. =

I haven't yet looked at genapic, but from what Zach and Chris Wright
have said, I get the impression that it isn't yet up to meeting our
requirements.

The result of this tension has been a general desire to keep pv_ops a
high-level interface, but for pragmatic reasons it has grown a few
low-level operations (like the apic read and write interfaces) which
better suit VMI's needs.  I would like to see these go away as they get
replaced with high-level interfaces. =


I think this is the natural course we've been following anyway.  Xen has
the advantage of starting from a relatively clean slate here, but
reusing existing entrenched pieces cleanly in new ways always takes
careful thought and hard work.

> what we do _NOT_ want is some mixture of 'simplified' and 'hardwired' =

> native hardware access mixed with hypercalls that somehow ends up =

> creating a Frankenstein mixture of 'virtual silicon', which is specified =

> nowhere else but in VMWare's proprietary hypervisor source code that we =

> have no way to fix and no way to even see!

No, but I'm not prejudiced against virtual hardware.  If we have a piece
of code that thinks its talking to an apic, then I think its OK to use
that code whether its a real apic or a virtual one, _so long as its
being used in a way that's consistent with its intended interface_.  I
have to admit I have not looked at apics - real or virtual - in any
detail, so I won't claim to really understand the details of the
existing arch/i386 code or what VMI's trying to do, but it does seem to
me that it could all be much cleaner.

And clean is good, we all love clean - and so, agreement!

    J
