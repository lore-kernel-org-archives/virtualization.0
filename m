From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: pv_ops smp support
Date: Thu, 19 Oct 2006 16:48:45 -0700
Message-ID: <45380EDD.2070809@goop.org>
References: <453805BF.80301@goop.org> <45380B6A.3030104@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45380B6A.3030104@vmware.com>
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
> 1) What do you plan to do to address per-cpu data structures?

Er, what's there at the moment, more or less.  The main thing is that =

the secondary CPU get the PDA set up (init gdt and %gs) before anyone =

wants to use it (which is generally the first use of smp_processor_id() =

or current). At some point we'll probably fold the PDA and PER_CPU =

together.  Xen can more or less completely initialize the VCPU state =

before it is brought up, so there's little or no need for any kind of =

bootstrap code.

> 2) What is your remote TLB shootdown model?

Xen has a hypercall to shoot down a set of CPU's TLBs, so it doesn't =

need to do an IPI (we'll need to extend the flush_tlb interface to make =

good use of this).  It will still need IPIs for reschedule and remote =

function calls or course.

> Both of these could have major impacts on how you want to carve up =

> smp.c and smpboot.c.
