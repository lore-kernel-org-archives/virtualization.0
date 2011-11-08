From: Miche Baker-Harvey <miche@google.com>
Subject: [PATCH v3 1/3] virtio_console:  Fix locking of vtermno.
Date: Tue, 08 Nov 2011 13:44:58 -0800
Message-ID: <20111108214458.28884.86759.stgit__22251.2953951538$1321323131$gmane$org@miche.sea.corp.google.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Eric Northrup <digitaleric@google.com>
List-Id: virtualization@lists.linuxfoundation.org

Some modifications of vtermno were not done under the spinlock.

Moved assignment from vtermno and increment of vtermno together,
putting both under the spinlock.  Revert vtermno on failure.

Signed-off-by: Miche Baker-Harvey <miche@google.com>
---
 drivers/char/virtio_console.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8e3c46d..9722e76 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -987,18 +987,21 @@ int init_port_console(struct port *port)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->cons.vtermno = pdrvdata.next_vtermno;
+	spin_lock_irq(&pdrvdata_lock);
+	port->cons.vtermno = pdrvdata.next_vtermno++;
+	spin_unlock_irq(&pdrvdata_lock);
 
 	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
+	spin_lock_irq(&pdrvdata_lock);
 	if (IS_ERR(port->cons.hvc)) {
 		ret = PTR_ERR(port->cons.hvc);
 		dev_err(port->dev,
 			"error %d allocating hvc for port\n", ret);
 		port->cons.hvc = NULL;
+		port->cons.vtermno = pdrvdata.next_vtermno--;
+		spin_unlock_irq(&pdrvdata_lock);
 		return ret;
 	}
-	spin_lock_irq(&pdrvdata_lock);
-	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
