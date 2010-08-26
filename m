From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/4] virtio: console: fixes, SIGIO
Date: Thu, 26 Aug 2010 10:34:04 +0530
Message-ID: <cover.1282798831.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

The main thing in these patches is the introduction of injecting SIGIO
on host-side connect/disconnect events and when new data is available
for ports.

The first two patches fix bugs that I haven't seen, but look like the
right thing to do.

These have been tested extensively using the test-virtserial test
suite.

Please apply,
		Amit.

Amit Shah (4):
  virtio: console: Un-block reads on chardev close
  virtio: console: Annotate virtcons_remove with __devexit_p
  virtio: console: Send SIGIO to processes that request it for host
    events
  virtio: console: Send SIGIO on new data arrival on ports

 drivers/char/virtio_console.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.7.2.2
