From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 09:01:31 +0100
Message-ID: <20070308080131.GB9295@elte.hu>
References: <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org>
	<1173300032.24738.750.camel@localhost.localdomain>
	<45EF2991.1020204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EF2991.1020204@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > Your implementation is almost the perfect prototype, if you move the =

> > 128 bit hackery into the hypervisor and hide it away from the kernel =

> > :)
> =

> The point is to use the tsc to avoid making any hypercalls, so dealing =

> with the tsc->ns conversion has to happen on the guest side somehow.

you are obsessed with avoiding a hypercall, but why? Granted it's slow =

especially on things like SVN/VMX, but it's not fundamentally slow. We =

definitely do not want to design our whole APIs and abstractions around =

the temporary notion that 'hypercalls are slow'. I'd expect hypercalls =

to be put into silicon just as much as SYSENTER was put into silicon. =

Anyway, in terms of guest time code, a /big/ amount of design junk can =

be avoided by not trying to do sillynesses like 'virtual time'. The TSC =

is awfully unreliable.

really, it's a bit as if Linus looked at his 386DX CPU when he bought it =

16 years ago and decided that: "this CPU executes 16-bit code much =

faster than 32-bit code, so lets base this new toy OS on 16-bit code. =

Sure, it's a bit of a pain to use, compared to 32-bit code, but users =

demand performance!".

/THIS/ is the kind of junk we are trying to protect Linux against. =

Basically hypervisors are a way to prolong hardware legacies, and =

because unlike real hardware software ABIs dont actually burn out with =

time, and people are stubborn about using them, their effects are alot =

worse and alot longer than that of legacy hardware.

	Ingo
