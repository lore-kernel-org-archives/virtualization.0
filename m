From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/16] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Thu, 01 Nov 2007 14:13:55 -0200
Message-ID: <4729FB43.1010904__35035.3849739351$1193933782$gmane$org@redhat.com>
References: <C34FAA4C.17CA9%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <C34FAA4C.17CA9%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: akpm@linux-foundation.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, ak@suse.de, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, lguest@ozlabs.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Keir Fraser escreveu:
> On 1/11/07 15:30, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
> 
>> Glauber de Oliveira Costa wrote:
>>> I in fact have seen bugs with mixed reads and writes to the same cr,
>>> (cr4), but adding the volatile
>>> flag to the read function seemed to fix it.
>> Well, volatile will make a read be repeated rather than caching the
>> previous value, but it has no effect on ordering.
> 
> volatile prevents the asm from being 'moved significantly', according to the
> gcc manual. I take that to mean that reordering is not allowed.
> 
According to a gcc developer to whom I asked this question, volatile
prevents the code
to be removed, but does not prevent it to be moved (pun indented). In
practice, it should force
a re-read, but not influence the ordering decisions from the compiler.
Besides , 'significantly'
sounds like a significantly unprecise word, whose specific meaning may
be implementation dependant.

So I agree that adding a memory location reference is probably the best
alternative.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHKftDjYI8LaFUWXMRAiLTAKDqf/M8umNYw6u7r9ONozTEUVy8SwCgygma
jWNKQmxmLpyPxr00KbQy9Vg=
=JM4K
-----END PGP SIGNATURE-----
