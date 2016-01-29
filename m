From: "Maciej W. Rozycki" <macro@imgtec.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Fri, 29 Jan 2016 13:38:59 +0000
Message-ID: <alpine.DEB.2.00.1601291333130.5958__30420.3350017362$1454179707$gmane$org@tp.orcam.me.uk>
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
	<20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
	<20160114203430.GC3818@linux.vnet.ibm.com>
	<56980C91.1010403@imgtec.com>
	<20160114212913.GF3818@linux.vnet.ibm.com>
	<569814F2.50801@imgtec.com> <20160114225510.GJ3818@linux.vnet.ibm.com>
	<56983054.4070807@imgtec.com>
	<20160115004753.GN3818@linux.vnet.ibm.com>
	<56984642.3090106@imgtec.com>
	<alpine.DEB.2.00.1601271116520.5958@tp.orcam.me.uk>
	<56A9656D.3080707@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56A9656D.3080707@imgtec.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-me
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 28 Jan 2016, Leonid Yegoshin wrote:

> In http://patchwork.linux-mips.org/patch/10505/ the very last mesg exchange
> is:
[...]
> ... and that stops forever...

 Thanks for the reminder -- last June was very hectic, I travelled a lot 
and I lost the discussion from my radar.  Apologies for that.  I replied 
in that thread now with my results.  I hope this helps.

  Maciej
