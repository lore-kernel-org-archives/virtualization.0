From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 18:54:38 -0600
Message-ID: <45EE0D4E.3060903@codemonkey.ws>
References: <45ED82D9.6050204@codemonkey.ws>	
	<8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>	
	<20070306203712.GC21736@elte.hu>
	<1173228246.4644.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173228246.4644.85.camel@localhost.localdomain>
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
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tue, 2007-03-06 at 21:37 +0100, Ingo Molnar wrote:
>   =

>> maybe i shouldnt call it 'VMI' but 'the paravirt ABI'. I dont mind if =

>> it's the Xen ABI or the VMWare ABI or a mesh of the two - everyone can =

>> map their own internals to that /one/ ABI.
>>     =

>
> I think it's an excellent aim, but it's *HARD*.  I rejected this
> approach earlier because I'm just not smart enough.  (Yet?)
>
> The Linux side is fairly stable.  The hardware side is changing, and the
> hypervisor side is changing.  This means the ABI will churn fairly fast.
> The hypervisors are very different, which means the ABI will be very
> wide.
>
> We could start with VMI and try to support Xen, KVM and lguest.

There is one more here.  We also have Xen HVM which will soon want to be =

paravirtualized too.  We don't want the current xen paravirt_ops for =

that as they have a lot of things that HVM does not need.

Since KVM and Xen HVM have the least requirements in term of guest =

modifications, they are probably the obviously places to start.

Regards,

Anthony Liguori

>   It
> would at least give us a better idea of the scope of the problem.  But
> IMHO it's a *huge* job.
>
> Rusty.
>
>
>
>   =
