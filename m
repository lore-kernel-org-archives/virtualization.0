From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 12/32] x86/um: reuse asm-generic/barrier.h
Date: Wed, 6 Jan 2016 00:12:42 +0100
Message-ID: <568C4DEA.5070601__48988.1049878479$1452123130$gmane$org@nod.at>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-13-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451572003-2440-13-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Jeff Dike <jdike@addtoit.com>, adi-buildroot-devel@lists.sourceforge.net, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

Am 31.12.2015 um 20:07 schrieb Michael S. Tsirkin:
> On x86/um CONFIG_SMP is never defined.  As a result, several macros
> match the asm-generic variant exactly. Drop the local definitions and
> pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
