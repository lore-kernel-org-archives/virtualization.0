From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/2] virtio_blk header fixes
Date: Sun, 1 Mar 2015 08:39:09 +0100
Message-ID: <1425192883-5930-1-git-send-email-mst__23609.6492888921$1425195569$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Now that QEmu reuses linux virtio headers, we noticed
a typo in the exported virtio block header. Fix it up.

I'd like these merged for 4.0 so that Qemu 2.3 can
alredy get it right.

Michael S. Tsirkin (2):
  virtio_blk: typo fix
  virtio_blk: fix comment for virtio 1.0

 include/uapi/linux/virtio_blk.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
MST
