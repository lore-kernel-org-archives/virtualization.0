From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/8] (v4) virtio: console: Fixes, new way of discovering ports
Date: Tue, 23 Mar 2010 18:23:08 +0530
Message-ID: <1269348796-8660-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1142548487464199321=="
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
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============1142548487464199321==
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o2NCsqRt011075

Hello,

This version addresses comments by Gerd and Michael:
- instead of returning -EPIPE if host is not connected in the write
  case, just block the write if it's a blocking file and return -EAGAIN
  if it's non-blocking.

- Removes early_console_printk after the first console is found

- Adds early_put_chars fix by Fran=C3=A7ois Diakhat=C3=A9. It still needs=
 a
  sign-off by him.

Standard message: Since the ABI is being reworked, it's essential to
push this to 2.6.34 so that we're not left supporting the older
interface.

Amit Shah (7):
  MAINTAINERS: Put the virtio-console entry in correct alphabetical
    order
  virtio: console: Remove config work handler
  virtio: console: Add a __send_control_msg() that can send messages
    without a valid port
  virtio: console: Move code around for future patches
  virtio: console: Use a control message to add ports
  virtio: console: Don't always create a port 0 if using multiport
  virtio: console: Add partial blocking/non-blocking support to write()

Fran=C3=A7ois Diakhat=C3=A9 (1):
  virtio: console: Fix early_put_chars usage

 MAINTAINERS                    |   13 +-
 drivers/char/virtio_console.c  |  447 ++++++++++++++++++----------------=
------
 include/linux/virtio_console.h |   18 +-
 3 files changed, 215 insertions(+), 263 deletions(-)


--===============1142548487464199321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============1142548487464199321==--
