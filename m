From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/5] lguest feedback tidyups
Date: Fri, 11 May 2007 11:17:26 +1000
Message-ID: <1178846246.23513.21.camel__37557.776438962$1178846324$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Pekka J Enberg <penberg@cs.helsinki.fi>, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	Gratefully-received recent feedback from CC'd was applied to excellent
effect (and the advice from Matt Mackall about my personal appearance is
best unrequited).

	The patch is split in 5 parts to correspond with the 9 parts Andrew
sent out before, but here's the summary:

1) Sparse (thanks Christoph Hellwig):
    - lguest_const can be static now
    - lguest.c should include "lguest_bus.h" for lguest_devices declaration.
    - page_tables.c unnecessary initialization
    - But the cost was high: lots of __force casts 8(
2) Jeff Garzik
    - Use netdev_priv instead of dev->priv.
    - Check for ioremap failure
    - iounmap on failure.
    - Wrap SEND_DMA and BIND_DMA calls
    - Don't set NETIF_F_SG unless we set NETIF_F_NO_CSUM
    - Use SET_NETDEV_DEV()
    - Don't set dev->irq, mem_start & mem_end (deprecated)
3) Sam Ravnborg
    - lg-objs is deprecated, use lg-y.

Cheers,
Rusty.
