From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/16] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Thu, 01 Nov 2007 10:41:19 -0700
Message-ID: <472A0FBF.6040907__16072.581758681$1193939105$gmane$org@goop.org>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, ak@suse.de, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> volatile prevents the asm from being 'moved significantly', according to the
> gcc manual. I take that to mean that reordering is not allowed.
>   

That phrase doesn't appear in the gcc manual; in fact, it specifically
says that reordering can happen:

    The `volatile' keyword indicates that the instruction has important
    side-effects.  GCC will not delete a volatile `asm' if it is reachable.
    (The instruction can still be deleted if GCC can prove that
    control-flow will never reach the location of the instruction.)  Note
    that even a volatile `asm' instruction can be moved relative to other
    code, including across jump instructions.  For example, on many targets
    there is a system register which can be set to control the rounding
    mode of floating point operations.  You might try setting it with a
    volatile `asm', like this PowerPC example:

                asm volatile("mtfsf 255,%0" : : "f" (fpenv));
                sum = x + y;

    This will not work reliably, as the compiler may move the addition back
    before the volatile `asm'.  To make it work you need to add an
    artificial dependency to the `asm' referencing a variable in the code
    you don't want moved, for example:

             asm volatile ("mtfsf 255,%1" : "=X"(sum): "f"(fpenv));
             sum = x + y;

I take from this that it is not a good idea to assume "asm volatile" has
any ordering effects at all.

    J
