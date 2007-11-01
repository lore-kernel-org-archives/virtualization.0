From: Zachary Amsden <zach@vmware.com>
Subject: Re: [Lguest] [PATCH 3/16] read/write_crX, clts and wbinvd for
	64-bit paravirt
Date: Thu, 01 Nov 2007 09:55:13 -0700
Message-ID: <1193936113.29447.56.camel__16311.0359492295$1193965448$gmane$org@bodhitayantram.eng.vmware.com>
References: <C34FAA4C.17CA9%Keir.Fraser@cl.cam.ac.uk>
	<472A0FBF.6040907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <472A0FBF.6040907@goop.org>
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
Cc: lguest@ozlabs.org, akpm@linux-foundation.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, anthony@codemonkey.ws, mingo@elte.hu, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-11-01 at 10:41 -0700, Jeremy Fitzhardinge wrote:
> Keir Fraser wrote:
> > volatile prevents the asm from being 'moved significantly', according to the
> > gcc manual. I take that to mean that reordering is not allowed.
> >   

I understood it as reordering was permitted, but no re-ordering across
another volatile load, store, or asm was permitted.  And of course, as
long as input and output constraints are written properly, the
re-ordering should not be vulnerable to pathological movement causing
the code to malfunction.

It seems that CPU state side effects which can't be expressed in C need
special care - FPU is certainly one example.

Also, memory clobber on a volatile asm should stop invalid movement
across TLB flushes and other problems areas.  Even memory fences should
have memory clobber in order to stop movement of loads and stores across
the fence by the compiler.

Zach
