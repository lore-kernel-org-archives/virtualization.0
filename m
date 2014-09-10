From: Amos Kong <akong@redhat.com>
Subject: [PATCH v3 0/2] virtio-rng: fix hotunplug
Date: Wed, 10 Sep 2014 14:11:35 +0800
Message-ID: <1410329497-14349-1-git-send-email-akong@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, stable@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1121540

When we try to hot-unplugging a busy virtio-rng device, the device
can't be removed. And the reading process in guest gets stuck.

Those two patches fixed this issue by completing have_data completion
and preventing invalid reading.

Thanks for the help of Amit.

Cc: stable@vger.kernel.org

V2: reset data_avail (Amit)
    adjust unregister order
V3: split patch, update commitlog

Amos Kong (2):
  virtio-rng: fix stuck of hot-unplugging busy device
  virtio-rng: skip reading when we start to remove the device

 drivers/char/hw_random/virtio-rng.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.9.3
