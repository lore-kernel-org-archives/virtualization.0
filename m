From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PULL] virtio updates
Date: Tue, 5 Feb 2008 13:47:28 +0100
Message-ID: <20080205124728.GA18701__4924.42901381782$1202215794$gmane$org@elte.hu>
References: <200802050008.13834.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802050008.13834.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> Rusty Russell (16):
>       virtio: balloon driver

this change breaks the x86 build, as 'make randconfig' testing found it 
after 2 iterations:

  drivers/virtio/virtio_balloon.c: In function 'fill_balloon':
  drivers/virtio/virtio_balloon.c:98: error: implicit declaration of function 'msleep'

the patch below fixes it.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/virtio/virtio_balloon.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/drivers/virtio/virtio_balloon.c
===================================================================
--- linux.orig/drivers/virtio/virtio_balloon.c
+++ linux/drivers/virtio/virtio_balloon.c
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/delay.h>
 
 struct virtio_balloon
 {
