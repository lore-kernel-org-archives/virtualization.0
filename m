From: Hans de Goede <hdegoede@redhat.com>
Subject: PATCH: virtio_console: Fix poll blocking even though there is data
	to read (version 2)
Date: Wed, 15 Sep 2010 17:18:23 +0200
Message-ID: <4C90E3BF.4000408__41394.4909502336$1284570810$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090706050007060400080403"
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
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, spice-devel@lists.freedesktop.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090706050007060400080403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I found this while working on a Linux agent for spice, the symptom I was
seeing was select blocking on the spice vdagent virtio serial port even
though there were messages queued up there.

I found this while working on a Linux agent for spice, the symptom I was
seeing was select blocking on the spice vdagent virtio serial port even
though there were messages queued up there.

virtio_console's port_fops_poll checks port->inbuf != NULL to determine if
read won't block. However if an application reads enough bytes from inbuf
through port_fops_read, to empty the current port->inbuf, port->inbuf
will be NULL even though there may be buffers left in the virtqueue.

This causes poll() to block even though there is data ready to be read, this
patch fixes this by using port_has_data(port) instead of the
port->inbuf != NULL check.

Signed-off-By: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


--------------090706050007060400080403
Content-Type: text/plain;
 name="linux-2.6.35.4-virtio_console-fix-poll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-2.6.35.4-virtio_console-fix-poll.patch"

Subject: virtio_console: Fix poll blocking even though there is data to read (version 2)
From: Hans de Goede <hdegoede@redhat.com>

I found this while working on a Linux agent for spice, the symptom I was
seeing was select blocking on the spice vdagent virtio serial port even
though there were messages queued up there.

virtio_console's port_fops_poll checks port->inbuf != NULL to determine if
read won't block. However if an application reads enough bytes from inbuf
through port_fops_read, to empty the current port->inbuf, port->inbuf
will be NULL even though there may be buffers left in the virtqueue.

This causes poll() to block even though there is data ready to be read, this
patch fixes this by using port_has_data(port) instead of the
port->inbuf != NULL check.

Signed-off-By: Hans de Goede <hdegoede@redhat.com>
diff -up linux-2.6.35.x86_64/drivers/char/virtio_console.c~ linux-2.6.35.x86_64/drivers/char/virtio_console.c
--- linux-2.6.35.x86_64/drivers/char/virtio_console.c~	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.35.x86_64/drivers/char/virtio_console.c	2010-09-15 13:39:29.043505000 +0200
@@ -642,7 +642,7 @@ static unsigned int port_fops_poll(struc
 	poll_wait(filp, &port->waitqueue, wait);
 
 	ret = 0;
-	if (port->inbuf)
+	if (port_has_data(port))
 		ret |= POLLIN | POLLRDNORM;
 	if (!will_write_block(port))
 		ret |= POLLOUT;

--------------090706050007060400080403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------090706050007060400080403--
