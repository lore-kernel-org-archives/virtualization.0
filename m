From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-net: fix a typo
Date: Mon, 17 Jan 2011 11:42:29 +0200
Message-ID: <20110117094228.GE23479__10120.8016662442$1295257740$gmane$org@redhat.com>
References: <1295252059-27438-1-git-send-email-aurelien@aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1295252059-27438-1-git-send-email-aurelien@aurel32.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 17, 2011 at 09:14:19AM +0100, Aurelien Jarno wrote:
> fitler -> filter
> 
> Cc: netdev@vger.kernel.org
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Acked-by: Michael S. Tsirkin <mst@redhat.com>
obviously.

Cc:
virtualization@lists.linux-foundation.org
rusty@rustcorp.com.au
as well.

BTW Rusty, ./scripts/get_maintainer.pl doesn't work
for most of virtio since there is no entry in MAINTAINERS for virtio
net/block/core.  Adding it will help people know whom to contact
with issues/patches. It will also help if
I am Cc'd on patches as this way I won't forget to
review them.

--->
Add MAINTAINERS entry for virtio core, net, block

Patches should keep coming through Rusty but it
helps if I'm Cc'd as well.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----

Comments?

diff --git a/MAINTAINERS b/MAINTAINERS
index 23d0436..7de75ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6439,6 +6439,16 @@ S:	Maintained
 F:	drivers/char/virtio_console.c
 F:	include/linux/virtio_console.h
 
+VIRTIO CORE, NET AND BLOCK DRIVERS
+M:	Rusty Russell <rusty@rustcorp.com.au>
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/
+F:	drivers/net/virtio_net.c
+F:	drivers/block/virtio_blk.c
+F:	include/linux/virtio_*.h
+
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
