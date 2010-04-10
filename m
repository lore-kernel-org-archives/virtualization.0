From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 09/11] virtio: console: Don't always create a port 0 if
	using multiport
Date: Sat, 10 Apr 2010 12:49:55 +0530
Message-ID: <20100410071955.GF27134@amit-x200.redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-2-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-3-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-4-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-5-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-6-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-7-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-8-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-9-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-10-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1270738180-21170-10-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Apr 08 2010 [20:19:38], Amit Shah wrote:
> If we're using multiport, there's no point in always creating a console
> port. Create the console port only if the host doesn't support
> multiport.

Er, please use the version below. It adds a console port if multiport is
turned off.

> @@ -1409,15 +1410,6 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
>  		}
>  	}
>  
> -	/*
> -	 * For backward compatibility: if we're running on an older
> -	 * host, we always want to create a console port.
> -	 */
> -	add_port(portdev, 0);
> -
> -	/* Start using the new console output. */
> -	early_put_chars = NULL;
> -

From ac3c3b09e88e8547a01ff71e516ec75e9d34916b Mon Sep 17 00:00:00 2001
From: Amit Shah <amit.shah@redhat.com>
Date: Tue, 23 Mar 2010 10:27:00 +0530
Subject: [PATCH 09/11] virtio: console: Don't always create a port 0 if using multiport

If we're using multiport, there's no point in always creating a console
port. Create the console port only if the host doesn't support
multiport.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4087248..7d45fcc 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -784,6 +784,13 @@ int init_port_console(struct port *port)
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
 
+	/*
+	 * Start using the new console output if this is the first
+	 * console to come up.
+	 */
+	if (early_put_chars)
+		early_put_chars = NULL;
+
 	/* Notify host of port being opened */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -1056,14 +1063,8 @@ static void handle_control_message(struct ports_device *portdev,
 	switch (cpkt->event) {
 	case VIRTIO_CONSOLE_PORT_ADD:
 		if (port) {
-			/*
-			 * This can happen for port 0: we have to
-			 * create a console port during probe() as was
-			 * the behaviour before the MULTIPORT feature.
-			 * On a newer host, when the host tells us
-			 * that a port 0 is available, we should just
-			 * say we have the port all set up.
-			 */
+			dev_dbg(&portdev->vdev->dev,
+				"Port %u already added\n", port->id);
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 			break;
 		}
@@ -1407,17 +1408,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 			err = -ENOMEM;
 			goto free_vqs;
 		}
+	} else {
+		/*
+		 * For backward compatibility: Create a console port
+		 * if we're running on older host.
+		 */
+		add_port(portdev, 0);
 	}
 
-	/*
-	 * For backward compatibility: if we're running on an older
-	 * host, we always want to create a console port.
-	 */
-	add_port(portdev, 0);
-
-	/* Start using the new console output. */
-	early_put_chars = NULL;
-
 	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
 			   VIRTIO_CONSOLE_DEVICE_READY, 1);
 	return 0;
-- 
1.6.2.5
