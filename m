From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Mon, 08 Jun 2015 06:09:08 +0200
Message-ID: <55751564.20609@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430391243-7112-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ping?

Anything missing from my side?

On 04/30/2015 12:53 PM, Juergen Gross wrote:
> Paravirtualized spinlocks produce some overhead even if the kernel is
> running on bare metal. The main reason are the more complex locking
> and unlocking functions. Especially unlocking is no longer just one
> instruction but so complex that it is no longer inlined.
>
> This patch series addresses this issue by adding two more pvops
> functions to reduce the size of the inlined spinlock functions. When
> running on bare metal unlocking is again basically one instruction.
>
> Compile tested with CONFIG_PARAVIRT_SPINLOCKS on and off, 32 and 64
> bits.
>
> Functional testing on bare metal and as Xen dom0.
>
> Correct patching verified by disassembly of active kernel.
>
> Juergen Gross (6):
>    x86: use macro instead of "0" for setting TICKET_SLOWPATH_FLAG
>    x86: move decision about clearing slowpath flag into arch_spin_lock()
>    x86: introduce new pvops function clear_slowpath
>    x86: introduce new pvops function spin_unlock
>    x86: switch config from UNINLINE_SPIN_UNLOCK to INLINE_SPIN_UNLOCK
>    x86: remove no longer needed paravirt_ticketlocks_enabled
>
>   arch/x86/Kconfig                      |  1 -
>   arch/x86/include/asm/paravirt.h       | 13 +++++++++
>   arch/x86/include/asm/paravirt_types.h | 12 ++++++++
>   arch/x86/include/asm/spinlock.h       | 53 ++++++++++++-----------------------
>   arch/x86/include/asm/spinlock_types.h |  3 +-
>   arch/x86/kernel/kvm.c                 | 14 +--------
>   arch/x86/kernel/paravirt-spinlocks.c  | 42 +++++++++++++++++++++++++--
>   arch/x86/kernel/paravirt.c            | 12 ++++++++
>   arch/x86/kernel/paravirt_patch_32.c   | 25 +++++++++++++++++
>   arch/x86/kernel/paravirt_patch_64.c   | 24 ++++++++++++++++
>   arch/x86/xen/spinlock.c               | 23 +--------------
>   include/linux/spinlock_api_smp.h      |  2 +-
>   kernel/Kconfig.locks                  |  7 +++--
>   kernel/Kconfig.preempt                |  3 +-
>   kernel/locking/spinlock.c             |  2 +-
>   lib/Kconfig.debug                     |  1 -
>   16 files changed, 154 insertions(+), 83 deletions(-)
