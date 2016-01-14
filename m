From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Thu, 14 Jan 2016 11:24:01 +0200
Message-ID: <20160114111632-mutt-send-email-mst__30756.9569595673$1452763479$gmane$org@redhat.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
	<56945366.2090504@imgtec.com>
	<20160112092711.GP6344@twins.programming.kicks-ass.net>
	<20160112102555.GV6373@twins.programming.kicks-ass.net>
	<20160112104012.GW6373@twins.programming.kicks-ass.net>
	<20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
	<20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5696CF08.8080700@imgtec.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.orgl
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 13, 2016 at 02:26:16PM -0800, Leonid Yegoshin wrote:
> And all that is out-of-topic here in my mind. I just want to be sure that
> this patchset still provides a use of a specific lightweight SYNCs on MIPS
> vs bold and heavy generalized "SYNC 0" in any case.
> 
> - Leonid.

Of course it does. All this patchset does is rename smp_mb/rmb/wmb
to __smp_mb()/__smp_rmb()/__smp_wmb()
and then asm-generic does #define smp_mb __smp_mb
or #define smp_mb barrier depending on CONFIG_SMP.

Why is that needed? So we can implement
[PATCH v3 28/41] asm-generic: implement virt_xxx memory barriers

-- 
MST
