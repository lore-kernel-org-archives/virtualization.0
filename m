From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 08 Mar 2007 12:18:59 -0800
Message-ID: <45F06FB3.105@goop.org>
References: <1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com>
	<1173313373.24738.937.camel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
	<20070308182456.GH19575@sequoia.sous-sol.org>
	<45F06720.8080901@goop.org>
	<20070308194740.GJ10574@sequoia.sous-sol.org>
	<45F06989.8030207@goop.org>
	<20070308201033.GK10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070308201033.GK10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, tglx@linutronix.de, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   =

>> Chris Wright wrote:
>>     =

>>> I agree with that, but I think that's esp. for things like create and l=
aunch
>>> new vcpu.  The IPI bit I'm not as clear on, nor running this all on nat=
ive
>>> as well.
>>>   =

>>>       =

>> Well, native would fall back to using the existing arch/i386 versions of
>> those functions, so that's reasonably straightforward.
>>     =

>
> It's the fact that we need to leave code in the kernel to run on native,
> but also do something dynamically with that same code when running
> paravirt that I'm referring to.

Why would it be any different to all the other code we've got behind
native pvops?

The ideal simplified case is that we rename
smp_send_stop/send_reschedule/prepare_cpus/etc to native_* versions.  In
the !PARAVIRT case we just call the native_* version directly; in
PARAVIRT we call via the native pv_ops structure.  Under Xen, all these
would implemented independently from the native versions.

> No, it's not the IPI itself, it's the way it's often accessed by the rest=
 of
> the kernel (which is intertwined with genapic).  I'm happy to avoid apic
> altogether since it's effectively worthless for Xen other than
> integrating into the existing infrastructure.
>   =


I guess by "rest of the kernel" you mean other stuff in arch/i386.  Yes,
that's a concern, but maybe we can tease it apart in a sensible way.

    J
