From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: pv_ops smp support
Date: Thu, 19 Oct 2006 21:08:10 -0700
Message-ID: <45384BAA.5070303@goop.org>
References: <453805BF.80301@goop.org> <45380B6A.3030104@vmware.com>
	<45380EDD.2070809@goop.org> <4538121E.7090607@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4538121E.7090607@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> No, I don't mean the Linux PDA - how do you access the Xen PDA?  Or =

> have they conjoined somehow?

You could put it that way I guess.  There's a generic Linux PDA; a =

paravirt patch adds a union for pv use, and a Xen patch adds a =

Xen-specific element to that union.  That's how it has been from the =

start, so there wasn't really anything to conjoin (there was never a Xen =

PDA per se).

> So your invalidate "IPI" is actually a hypercall, and you can use the =

> existing flush_tlb interface for the most part.  You just need a =

> paravirt-op then for the IPI itself, which takes a CPU mask - and this =

> seems to match nicely onto your hypercall.
Yep.  There are calls for flushing the whole tlb, and for just a page; =

both take CPU masks.

> I think you might want to optimize this a bit more, however, since in =

> some cases you will issue implicit shootdown IPIs during a pte update =

> hypercall.

Not that I've seen, at least none that doesn't also exist in baseline.

> This seems much cleaner than designing the shootdown semantic directly =

> into such PTE updates, which is I believe what some of the older Xen =

> patches did, although I could have misread them.

I was starting on SMP with the idea that it would be relatively isolated =

and simple, but it seems I should probably do the MMU stuff first to see =

what impact it has on SMP.

    J
