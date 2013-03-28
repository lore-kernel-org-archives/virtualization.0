From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/2] virtio: console: add locking around control out-vq
Date: Thu, 28 Mar 2013 16:58:31 +0530
Message-ID: <cover.1364469955.git.amit.shah@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The in-vq operations were protected by a lock, but the out-vq
operations were not.  This caused panics / errors as described in
patch 2.  Fix that.

The first patch renames the existing cvq_lock to c_ivq_lock to match
c_ivq.  The second patch introduces the c_ovq_lock for the c_ovq.

Please apply.  I also believe this is a candidate for stable.


Amit Shah (2):
  virtio: console: rename cvq_lock to c_ivq_lock
  virtio: console: add locking around c_ovq operations

 drivers/char/virtio_console.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
1.8.1.4
