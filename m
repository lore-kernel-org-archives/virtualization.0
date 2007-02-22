From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 14:43:23 +1100
Message-ID: <1172115803.13378.63.camel@localhost.localdomain>
References: <45DCFB6E.2010806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45DCFB6E.2010806@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-02-21 at 18:09 -0800, Jeremy Fitzhardinge wrote:
> Here's the new patching patch.  It compiles, but it doesn't, you know,
> boot, as such.

OK, there are several separate things here.
(1) Get rid of the PARAVIRT_IRQ_DISABLE etc constants in favour of
offsetof within the structure.
(2) Change (almost) all the paravirt hooks to be patchable.
(3) Genericise the infrastructure to table-driven.

These should probably become separate patches, in fact.

I'm sold on the first two, not on the last one.  Perhaps the difference
is as simple as using an explicit fn pointer rather than an enum, and
exposing functions like "paravirt_nop_patch", "paravirt_no_patch",
paravirt_jmp_patch, paravirt_call_patch, and indeed,
paravirt_default_patch (which would call jmp or call) and even
paravirt_native_patch.

BTW, here are the top 10 paravirt functions on native after a kernel
compile on my setup (patched-out functions not included):

64895231: make_pte
39780056: set_pte_at
29604260: pgd_val
24518952: flush_tlb_kernel
23992028: set_pte
11385663: pte_val
8221901: read_cr2
7106629: read_tsc
6093958: nop
1858134: save_fl (presumably before patching)

Cheers!
Rusty.
