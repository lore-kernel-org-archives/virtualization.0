From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv9 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 10 Nov 2009 13:49:09 +1030
Message-ID: <200911101349.09783.rusty__10736.1023351134$1257823225$gmane$org@rustcorp.com.au>
References: <cover.1257786516.git.mst@redhat.com>
	<20091109172230.GD4724@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091109172230.GD4724@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

One fix:

vhost: fix TUN=m VHOST_NET=y

	drivers/built-in.o: In function `get_tun_socket':
	net.c:(.text+0x15436e): undefined reference to `tun_get_socket'

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/vhost/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -1,6 +1,6 @@
 config VHOST_NET
 	tristate "Host kernel accelerator for virtio net (EXPERIMENTAL)"
-	depends on NET && EVENTFD && EXPERIMENTAL
+	depends on NET && EVENTFD && TUN && EXPERIMENTAL
 	---help---
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest networking with virtio_net. Not to be confused with virtio_net
