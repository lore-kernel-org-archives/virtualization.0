From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/24] smp x86 consolidation
Date: Fri, 09 Nov 2007 16:29:27 -0800
Message-ID: <4734FB67.8080500__27385.0802368999$1194654718$gmane$org@goop.org>
References: <11946337851964-git-send-email-gcosta@redhat.com>	<11946337933104-git-send-email-gcosta@redhat.com>	<11946337991750-git-send-email-gcosta@redhat.com>	<11946338053158-git-send-email-gcosta@redhat.com>	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1194633815833-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> This patch consolidates part of the pieces of smp for both architectures.
> (i386 and x86_64). It makes part the calls go through smp_ops, and shares
> code for those functions in smpcommon.c
>
> There's more room for code sharing here, but it is left as an exercise to
> the reader ;-)
>   

I'm getting link errors in 32-bit:

arch/x86/kernel/built-in.o: In function `native_smp_send_reschedule':
/home/jeremy/hg/xen/paravirt/linux/arch/x86/kernel/smpcommon.c:262: undefined reference to `genapic'
arch/x86/kernel/built-in.o: In function `native_smp_call_function_mask':
/home/jeremy/hg/xen/paravirt/linux/arch/x86/kernel/smpcommon.c:113: undefined reference to `genapic'


    J
