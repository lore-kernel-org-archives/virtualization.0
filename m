From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 18:36:40 +0200
Message-ID: <20070815163640.GJ3406__4669.3260352642$1187192813$gmane$org@bingen.suse.de>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46C31736.2050001@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, shai@scalemp.com, kiran@scalemp.com, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 15, 2007 at 12:09:42PM -0300, Glauber de Oliveira Costa wrote:
> Again, this is the code of such function:
> 
> static inline int raw_irqs_disabled_flags(unsigned long flags)
> {
>         return !(flags & X86_EFLAGS_IF);
> }
> so all it is doing is getting a parameter (flags), and bitmasking it. It 
> is not talking to any hypervisor. I can't see your point. Unless you are
> arguing that it _should_ be talking to a hypervisor. Is that your point?

vSMP is a hypervisor based architecture. For some reason that is not
100% clear to me, but Kiran or Shai can probably explain, it needs this 
additional bit in EFLAGS when interrupts are disabled. That gives
it some hints and then it goes somehow faster. That is clearly
paravirtualization.

Since paravirtops is designed to handle such hooks cleanly I request
that you move vSMP over to it or work with the vSMP maintainers to 
do that. Otherwise we have two different ways to do paravirtualization 
which is wrong.

-Andi
