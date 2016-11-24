From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] virtio/vringh: kill off ACCESS_ONCE()
Date: Thu, 24 Nov 2016 10:25:11 +0000
Message-ID: <1479983114-17190-1-git-send-email-mark.rutland__34569.8911151432$1480112002$gmane$org@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, dave@stgolabs.net, kvm@vger.kernel.org, dbueso@suse.de, netdev@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, dvyukov@google.com
List-Id: virtualization@lists.linuxfoundation.org

For several reasons, it would be beneficial to kill off ACCESS_ONCE()
tree-wide, in favour of {READ,WRITE}_ONCE(). These work with aggregate types,
more obviously document their intended behaviour, and are necessary for tools
like KTSAN to work correctly (as otherwise reads and writes cannot be
instrumented separately).

While it's possible to script the bulk of this tree-wide conversion, some cases
such as the virtio code, require some manual intervention. This series moves
the virtio and vringh code over to {READ,WRITE}_ONCE(), in the process fixing a
bug in the virtio headers.

Thanks,
Mark.

Mark Rutland (3):
  tools/virtio: fix READ_ONCE()
  vringh: kill off ACCESS_ONCE()
  tools/virtio: use {READ,WRITE}_ONCE() in uaccess.h

 drivers/vhost/vringh.c        | 5 +++--
 tools/virtio/linux/compiler.h | 2 +-
 tools/virtio/linux/uaccess.h  | 9 +++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.7.4
