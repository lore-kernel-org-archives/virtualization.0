From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH dontapply 0/2] tools/virtio updates for API testing
Date: Mon, 25 Feb 2013 00:18:58 +0200
Message-ID: <cover.1361743821.git.mst@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Here's a patchset to update tools/virtio with
changes in 3.8, as well as the proposed API extension.

Useful to see whether the extra level of indirection
adds measureable overhead.

I will upstream at least patch 1 soon.

Michael S. Tsirkin (2):
  tools/virtio: fix build for 3.8
  tools/virtio: update for the new virtio API

 drivers/vhost/test.c        |  4 +++-
 tools/virtio/Makefile       |  2 +-
 tools/virtio/linux/virtio.h | 52 ++++++++++++++++++++++++++++++++++++++-------
 tools/virtio/virtio_test.c  |  3 ++-
 4 files changed, 50 insertions(+), 11 deletions(-)

-- 
MST
