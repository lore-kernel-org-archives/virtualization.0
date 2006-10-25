From: Zachary Amsden <zach@vmware.com>
Subject: Re: RFC: const_udelay in 018-delay functions patch
Date: Tue, 24 Oct 2006 23:21:50 -0700
Message-ID: <453F027E.2020704@vmware.com>
References: <453EF1EE.2000503@vmware.com>
	<1161756217.15099.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1161756217.15099.52.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 2006-10-24 at 22:11 -0700, Zachary Amsden wrote:
>   =

>> So I implemented udelay and ndelay through a single paravirt_op, =

>> const_udelay, instead of having either two separate paravirt-ops for =

>> udelay or ndelay, or a redundant const_udelay paravirt_op.  Anybody have =

>> any objection to reworking the patch this way?
>>     =

>
> Seems saner, but I'm not sure why x86 has an I/O delay separate from
> udelay to start with?
>   =


I/O delay is for slow hardware that needs a couple bus cycles to settle, =

but doesn't have specified latency requirements - like many old floppy =

drive controllers.  Using the jmp 1f; thing doesn't seem very future =

proof, and the port I/O guarantees a bus access, which makes these =

fuggly older controllers work better.

> Comments: =

>
>   =

>> +#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_IO)
>> +#include <asm/paravirt.h>
>> +#else =

>>     =

>
> USE_REAL_IO? Is this defined anywhere?  Or just future-proofing?
>   =


It has to be used for SMP bootstrapping - IPI acceptance requires real =

time cross-processor delay, even in a VM - and also can be added by a =

top-level define to kernel compiles for driver domains for Xen to give =

real time device delays.

Zach
