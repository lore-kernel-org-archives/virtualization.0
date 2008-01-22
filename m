From: Eduardo Pereira Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/4] paravirt_ops-64 compile fixes
Date: Tue, 22 Jan 2008 10:34:50 -0200
Message-ID: <20080122123450.GU7338__42827.8043320917$1201005622$gmane$org@blackpad>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
	<20080122120207.GA30271@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080122120207.GA30271@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 22, 2008 at 01:02:07PM +0100, Ingo Molnar wrote:
> 
> * Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > This series contain fixes to make the paravirt_ops code compile and 
> > boot on x86_64.
> > 
> > This is a follow-up for the previous series from Glauber.
> 
> thanks Eduardo, i've applied your fixes.
> 
> could you perhaps send the missing bits that add the missing 64-bit 
> Kconfig entries? Even if the 64-bit side is not functional yet as a real 
> guest, it would help us find the build bugs and any runtime regressions 
> PARAVIRT might cause on the native 64-bit side of the kernel.
> 
> Or is it now just a matter of removing all the depends-on X86_32 bits in 
> arch/x86/Kconfig?

Removing the depends won't be enough because CONFIG_PARAVIRT won't be
selected unless one of Xen, VMI, or lguest is selected. (PARAVIRT is
not visible on menuconfig, only PARAVIRT_GUEST, that doesn't enable any
code).

When hacking, I remove the 32-bit depends and add "select PARAVIRT" to
"menuconfig PARAVIRT_GUEST".

I think neither of the three guest implementations are ready for 64-bit
yet. I am working on Xen and it is far from being ready for inclusion. I
don't know about VMI and lguest.

If this is desirable for broader testing, we can make config PARAVIRT
visible and selectable on menuconfig, even when there is no guest
implementation being enabled. Should I do it?

Maybe should this force-paravirt mode be a kernel debugging option?

-- 
Eduardo
