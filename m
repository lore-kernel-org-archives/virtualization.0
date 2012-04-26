From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/3] virtio: balloon: cleanups and a fix
Date: Fri, 27 Apr 2012 00:45:54 +0530
Message-ID: <cover.1335467427.git.amit.shah@redhat.com>
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
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

The main fix is to update the host with the current balloon value on
module removal after deflating the balloon.  Without the fix, the host
has the wrong idea of the ballooned memory in the guest.  This is
patch 2.

Patches 1 and 3 are cleanups with no effective code change.

Please apply,

Amit Shah (3):
  virtio: balloon: drop restore_common()
  virtio: balloon: let host know of updated balloon size before module
    removal
  virtio: balloon: separate out common code between remove and freeze
    functions

 drivers/virtio/virtio_balloon.c |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

-- 
1.7.7.6
