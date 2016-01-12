From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Tue, 12 Jan 2016 10:43:36 +0200
Message-ID: <20160112103913-mutt-send-email-mst__30383.1741832711$1452588250$gmane$org@redhat.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
	<56945366.2090504@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56945366.2090504@imgtec.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Joe Perches <joe@per>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:
> On 01/10/2016 06:18 AM, Michael S. Tsirkin wrote:
> >On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> >smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> >the asm-generic variants exactly. Drop the local definitions and pull in
> >asm-generic/barrier.h instead.
> >
> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/
> 
> - Leonid.

Fine, but it matches what current code is doing.  Since that
MIPS_LIGHTWEIGHT_SYNC patch didn't go into linux-next yet, do
you see a problem reworking it on top of this patchset?

-- 
MST
