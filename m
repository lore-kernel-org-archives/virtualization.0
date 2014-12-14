From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/6] virtio 1.0: tools update
Date: Mon, 15 Dec 2014 00:04:12 +0200
Message-ID: <1418594542-22623-1-git-send-email-mst@redhat.com>
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
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio test support for virtio 1.0.
Probably a good idea to include for 3.19.

Michael S. Tsirkin (6):
  tools/virtio: more stubs
  tools/virtio: fix vringh test
  tools/virtio: 64 bit features
  tools/virtio: enable -Werror
  tools/virtio: add virtio 1.0 in virtio_test
  tools/virtio: add virtio 1.0 in vringh_test

 tools/virtio/linux/virtio.h            |  1 +
 tools/virtio/linux/virtio_byteorder.h  |  8 ++++++++
 tools/virtio/linux/virtio_config.h     | 25 +++++++++++++++++++++++--
 tools/virtio/uapi/linux/virtio_types.h |  1 +
 tools/virtio/virtio_test.c             | 14 +++++++++++++-
 tools/virtio/vringh_test.c             |  5 ++++-
 tools/virtio/Makefile                  |  2 +-
 7 files changed, 51 insertions(+), 5 deletions(-)
 create mode 100644 tools/virtio/linux/virtio_byteorder.h
 create mode 100644 tools/virtio/uapi/linux/virtio_types.h

-- 
MST
