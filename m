From: Waiman Long <waiman.long@hpe.com>
Subject: Re: [PATCH resend] powerpc: enable qspinlock and its virtualization
	support
Date: Thu, 28 Apr 2016 17:07:54 -0400
Message-ID: <57227BAA.7040807__29269.5951684893$1462273109$gmane$org@hpe.com>
References: <5721EC0E.8040506@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5721EC0E.8040506@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Cc: jeremy@goop.org, tglx@linutronix.de, peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, marc.zyngier@arm.com, Paul Mackerras <paulus@samba.org>, akataria@vmware.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, adam.buchbinder@gmail.com, gwshan@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 04/28/2016 06:55 AM, Pan Xinhui wrote:
> From: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
>
> This patch aims to enable qspinlock on PPC. And on pseries platform, it also support
> paravirt qspinlock.
>
> Signed-off-by: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/qspinlock.h               | 37 +++++++++++++++
>   arch/powerpc/include/asm/qspinlock_paravirt.h      | 36 +++++++++++++++
>   .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 ++++++
>   arch/powerpc/include/asm/spinlock.h                | 31 ++++++++-----
>   arch/powerpc/include/asm/spinlock_types.h          |  4 ++
>   arch/powerpc/kernel/paravirt.c                     | 52 ++++++++++++++++++++++
>   arch/powerpc/lib/locks.c                           | 32 +++++++++++++
>   arch/powerpc/platforms/pseries/setup.c             |  5 +++
>   8 files changed, 198 insertions(+), 12 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
>   create mode 100644 arch/powerpc/kernel/paravirt.c
>
>

This is just an enablement patch. You will also need a patch to activate 
qspinlock for, at lease, some PPC configs. Right?

It has dependency on the pv_wait() patch that I sent out extend the 
parameter list. Some performance data on how PPC system will perform 
with and without qspinlock will also be helpful data points.

Cheers,
Longman
