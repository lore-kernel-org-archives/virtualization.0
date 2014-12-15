From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] fix up vringh/mic sparse errors
Date: Mon, 15 Dec 2014 23:13:59 +0200
Message-ID: <1418678019-31629-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This fixes remaining sparse warnings in vringh and mic by using
virtio 1.0 compliant wrappers.

This also needs by get_user patches to avoid getting warnings
from these calls.

Tested by running vringh_test.

Rusty, I prefer fixing all these warnings for 3.19, any objections?

Michael S. Tsirkin (3):
  vringh: 64 bit features
  vringh: initial virtio 1.0 support
  mic/host: initial virtio 1.0 support

 include/linux/vringh.h              |  37 ++++++++++-
 drivers/misc/mic/host/mic_debugfs.c |  18 ++++--
 drivers/vhost/vringh.c              | 125 ++++++++++++++++++++++--------------
 3 files changed, 123 insertions(+), 57 deletions(-)

-- 
MST
