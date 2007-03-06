From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 10:26:36 +0100
Message-ID: <20070306092636.GC26073@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2F53.2040101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED2F53.2040101@goop.org>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> You could come up with some shim layer which makes the two interfaces =

> appear similar, and you could spell the name of that shim "VMI".  Or =

> you could call it "paravirt_ops", which is the name we chose.  And you =

> could implement the interface to that layer as a binary ABI, or you =

> could make it a normal source-level Linux kernel interface, which is =

> what we chose to do.

i think you are missing my point.

paravirt_ops is a Linux-internal abstraction that tries to make our life =

easier but it has no relevance whatsoever to an external hypervisor - be =

that Xen, VMWare/ESX or Windows/Longhorn.

What matters is the /ABI/ that the hypervisor uses to talk to a Linux =

guest. In the VMWare/ESX case that's VMI. In the Xen case that's the =

hypercall page call-table ABI or the legacy int $0x82 ABI.

My suggestion would be for Linux to make only a /single/ external ABI =

promise: VMI. (and we can extend it with higher-level paravirt ops, =

etc.)

paravirt_ops has ZERO relevance here... Anyone who suggests that =

paravirt_ops somehow magically hides the ABIs that are behind it (and =

its effects on Linux) is smoking something real funny ;-)

	Ingo
