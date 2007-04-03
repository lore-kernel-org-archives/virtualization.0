From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 03 Apr 2007 13:03:15 -0700
Message-ID: <4612B303.5000109@zytor.com>
References: <4611652F.700@zytor.com> <200704031951.00544.arnd@arndb.de>
	<4612A5F0.2080609@goop.org> <200704032142.51976.arnd@arndb.de>
	<4612B123.2040105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4612B123.2040105@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Arnd Bergmann <arnd@arndb.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> =

> Yes, and that's the core of the Xen netfront.  But is there really much
> code which can be shared between different hypervisors?  When you get
> down to it, all the real code is hypervisor-specific stuff for setting
> up ringbuffers and dealing with interrupts.  Like all the other network
> drivers.
> =


One thing, Jeremy, which I think is being a bit misleading here: you're =

focusing on big, performance-critical stuff.  Those things are going to =

be the ones which has the most win to implement in hypervisor-specific =

ways.  Although we can offer models for some hypervisors (and G-d knows =

there are enough implementations out there of virtual disk which are =

almost identical), they're clearly not going to be universal.

However, there are other things; console is some, or my original =

example, which was random number generation.  For those, the benefit of =

unification is proportionally greater, simply because the win of =

anything hypervisor-specific is much smaller.

	-hpa
