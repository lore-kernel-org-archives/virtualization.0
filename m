From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v2 0/2] Add cleanup for virtio_mmio driver
Date: Tue, 5 Dec 2017 19:56:49 +0800
Message-ID: <cover.1512445595.git.zhangweiping@didichuxing.com>
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
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

this patchset try to add cleanup for virtio_mmio driver, include
virtio_mmio_probe and virtio_mmio_remove

weiping zhang (2):
  virtio_mmio: add cleanup for virtio_mmio_probe
  virtio_mmio: add cleanup for virtio_mmio_remove

 drivers/virtio/virtio_mmio.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

-- 
2.9.4
