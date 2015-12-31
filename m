From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 07/32] sparc: reuse asm-generic/barrier.h
Date: Thu, 31 Dec 2015 14:43:47 -0500 (EST)
Message-ID: <20151231.144347.54643465516219979.davem__10330.0180323005$1451591054$gmane$org@davemloft.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-8-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451572003-2440-8-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, x86@kernel.org, xen-devel@lists.xenproject.org, mingo@elte.hu, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, stefano.stabellini@eu.citrix.com, andreyknvl@google.com, adi-buildroot-devel@lists.sourceforge.net, tglx@linutronix.de, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Dec 2015 21:06:38 +0200

> On sparc 64 bit dma_rmb, dma_wmb, smp_store_mb, smp_mb, smp_rmb,
> smp_wmb, read_barrier_depends and smp_read_barrier_depends match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> nop uses __asm__ __volatile but is otherwise identical to
> the generic version, drop that as well.
> 
> This is in preparation to refactoring this code area.
> 
> Note: nop() was in processor.h and not in barrier.h as on other
> architectures. Nothing seems to depend on it being there though.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
