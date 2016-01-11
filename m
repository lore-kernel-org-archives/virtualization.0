From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v3 39/41] xen/events: use virt_xxx barriers
Date: Mon, 11 Jan 2016 11:12:06 +0000
Message-ID: <56938E06.9050702__41508.0251441852$1452510751$gmane$org@citrix.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
	<1452426622-4471-40-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1452426622-4471-40-git-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wei Liu <wei.liu2@citrix.com>, Konrad Rzeszutek Wilk <konrad.wil>
List-Id: virtualization@lists.linuxfoundation.org

On 10/01/16 14:21, Michael S. Tsirkin wrote:
> drivers/xen/events/events_fifo.c uses rmb() to communicate with the
> other side.
> 
> For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
> rmb() here is only needed if a non-SMP guest runs on an SMP host.
> 
> Switch to the virt_rmb barrier which serves this exact purpose.
> 
> Pull in asm/barrier.h here to make sure the file is self-contained.
> 
> Suggested-by: David Vrabel <david.vrabel@citrix.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
