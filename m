From: Amit Shah <amit.shah@redhat.com>
Subject: [PULL] virtio console fixes, abi change
Date: Wed, 14 Apr 2010 11:05:57 +0530
Message-ID: <20100414053557.GA4442@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Juan Quintela <quintela@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

To avoid sending the same patches again, this time I'm trying a git pull
request.

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/amit/vs-kernel.git for-rusty

to get the patches that I've sent to the list previously, with a couple
of fixes:

- Create a console port when not using multiport (fix was sent as a
  reply to prev. series)

- Add hunk that got inadvertently reverted during git rebase operations
  (thanks Juan).

The diff to the v6 version is attached below:

diff --git a/drivers/char/virtio_console.c
b/drivers/char/virtio_console.c
index b06a0e5..a64558f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1083,6 +1083,8 @@ free_cdev:
 free_port:
        kfree(port);
 fail:
+       /* The host might want to notify management sw about port add
failure */
+       send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 0);
        return err;
 }
@@ -1407,17 +1513,14 @@ static int __devinit virtcons_probe(struct
virtio_device *vdev)
                        err = -ENOMEM;
                        goto free_vqs;
                }
+       } else {
+               /*
+                * For backward compatibility: Create a console port
+                * if we're running on older host.
+                */
+               add_port(portdev, 0);
        }

Thanks,
		Amit
