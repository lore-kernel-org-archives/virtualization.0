From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 15/21] Xen-paravirt: Add Xen interface header files
Date: Wed, 14 Feb 2007 13:45:52 -0700
Message-ID: <m1k5ykpiwv.fsf@ebiederm.dsl.xmission.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.619562494@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070213221830.619562494@goop.org> (Jeremy Fitzhardinge's
	message of "Tue, 13 Feb 2007 14:17:44 -0800")
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
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Add Xen interface header files. These are taken fairly directly from
> the Xen tree and hence the style is not entirely in accordance with
> Linux guidelines. There is a tension between fitting with Linux coding
> rules and ease of maintenance.
>
> Define macros and inline functions for doing hypercalls into the
> hypervisor.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
>
>
> --
>  include/asm-i386/hypercall.h          |  416 +++++++++++++++++++++++++++=
++
>  include/asm-i386/hypervisor.h         |   72 +++++

Are hypercall.h and hypervisor.h generic or are they Xen specific.
If they are Xen specific (as it appears) then are inappropriately
named.

>  include/xen/interface/arch-x86_32.h   |  187 +++++++++++++
Why isn't this file include-asm-i386/xen/arch-x86_32.h ?

>  include/xen/interface/elfnote.h       |  133 +++++++++
>  include/xen/interface/event_channel.h |  195 ++++++++++++++
>  include/xen/interface/features.h      |   43 +++
>  include/xen/interface/grant_table.h   |  301 +++++++++++++++++++++
>  include/xen/interface/io/blkif.h      |   96 ++++++
>  include/xen/interface/io/console.h    |   23 +
>  include/xen/interface/io/netif.h      |  152 ++++++++++
>  include/xen/interface/io/ring.h       |  260 ++++++++++++++++++
>  include/xen/interface/io/xenbus.h     |   42 +++
>  include/xen/interface/io/xs_wire.h    |   87 ++++++
>  include/xen/interface/memory.h        |  145 ++++++++++
>  include/xen/interface/physdev.h       |   61 ++++
>  include/xen/interface/sched.h         |   77 +++++
>  include/xen/interface/vcpu.h          |  109 +++++++
>  include/xen/interface/version.h       |   60 ++++
>  include/xen/interface/xen.h           |  445 +++++++++++++++++++++++++++=
+++++
>  19 files changed, 2904 insertions(+)

Eric
