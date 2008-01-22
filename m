From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/4] paravirt_ops-64 compile fixes
Date: Tue, 22 Jan 2008 13:02:07 +0100
Message-ID: <20080122120207.GA30271__29892.2687572942$1201003477$gmane$org@elte.hu>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Eduardo Habkost <ehabkost@redhat.com> wrote:

> This series contain fixes to make the paravirt_ops code compile and 
> boot on x86_64.
> 
> This is a follow-up for the previous series from Glauber.

thanks Eduardo, i've applied your fixes.

could you perhaps send the missing bits that add the missing 64-bit 
Kconfig entries? Even if the 64-bit side is not functional yet as a real 
guest, it would help us find the build bugs and any runtime regressions 
PARAVIRT might cause on the native 64-bit side of the kernel.

Or is it now just a matter of removing all the depends-on X86_32 bits in 
arch/x86/Kconfig?

	Ingo
