From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/3] virtio: console: async notifications for host connect /
	disconnect
Date: Thu,  2 Sep 2010 18:47:51 +0530
Message-ID: <cover.1283433264.git.amit.shah@redhat.com>
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

Hey Rusty,

This patchset is on top of the previous one.

It sends a SIGIO signal to apps that request signals for host
activity. SIGIO is sent on host connect, disconnect as well as
hot-unplug (which can be seen as a special case of host disconnect).

Tested using several testcases in the test-virtserial repo:
http://fedorapeople.org/gitweb?p=amitshah/public_git/test-virtserial.git

Please apply.

Thanks,
Amit.

Amit Shah (3):
  virtio: console: Send SIGIO to processes that request it for host
    events
  virtio: console: Send SIGIO on new data arrival on ports
  virtio: console: Send SIGIO in case of port unplug

 drivers/char/virtio_console.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

-- 
1.7.2.2
