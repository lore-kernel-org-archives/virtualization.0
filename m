From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/4] x86 paravirt_ops: paravirt_desc.h for native
	descriptor ops.
Date: Mon, 7 Aug 2006 07:40:23 +0200
Message-ID: <200608070740.23840.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<1154925943.21647.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154925943.21647.32.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 06:45, Rusty Russell wrote:
> Unfortunately, due to include cycles, we can't put these in
> paravirt.h: we use a separate header for these.
> =

> The implementation comes from Zach's [RFC, PATCH 10/24] i386 Vmi descript=
or changes:
> =

>   Descriptor and trap table cleanups.  Add cleanly written accessors for
>   IDT and GDT gates so the subarch may override them.  Note that this
>   allows the hypervisor to transparently tweak the DPL of the descriptors
>   as well as the RPL of segments in those descriptors, with no unnecessary
>   kernel code modification.  It also allows the hypervisor implementation
>   of the VMI to tweak the gates, allowing for custom exception frames or
>   extra layers of indirection above the guest fault / IRQ handlers.

Nice cleanup. The old assembly mess was ripe to be killed for a long time.

-Andi
