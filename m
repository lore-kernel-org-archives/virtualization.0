From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: hardwired VMI crap
Date: Fri, 09 Mar 2007 01:04:50 +0100
Message-ID: <1173398690.24738.1108.camel@localhost.localdomain>
References: <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
	<45EFE010.7080108@vmware.com>
	<1173352154.24738.1023.camel@localhost.localdomain>
	<45F0761C.6060107@vmware.com> <45F07D07.5090003@goop.org>
	<20070308213458.GA24634@elte.hu>  <45F09EAE.6090908@goop.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F09EAE.6090908@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 15:39 -0800, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> >  - /One/ _intelligent_ higher-level virtualization API/ABI. Xen's API i=
s =

> >    quite advanced on this front.
> =

> At last!  Some love!
> =

> The Xen approach has always been to prefer high-level interfaces over
> lower-level ones, so that guests can meaningfully participate in their
> own virtualization.  There are some necessarily low-level things, but
> conceptually simple things like "create a new vcpu" should have simple
> interfaces.  There's no point in going to the effort of emulating a
> whole pile of real hardware if Xen can present an interface which is a
> close match to an existing high-level interface within the operating syst=
em.

Once you are there, you are near the point where you created a virtual
architecture, which could run on any real architecture which gets
supported by a hypervisor backend.

I'd love that :)

I know it is tricky to combine this with the upcoming hardware
virtualization support. But it's at least a worthwhile thought
experiment.

	tglx
