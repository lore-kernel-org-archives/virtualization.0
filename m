From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Tue, 15 Oct 2019 17:19:08 -0400
Message-ID: <20191015171908-mutt-send-email-mst__35284.7524265357$1571174372$gmane$org@kernel.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jan.kiszka@web.de
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 245cdd9fbd396483d501db83047116e2530f245f:

  vhost/test: stop device before reset (2019-10-13 09:38:27 -0400)

----------------------------------------------------------------
virtio: fixes

Some minor bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (3):
      tools/virtio: more stubs
      tools/virtio: xen stub
      vhost/test: stop device before reset

 drivers/vhost/test.c             | 2 ++
 tools/virtio/crypto/hash.h       | 0
 tools/virtio/linux/dma-mapping.h | 2 ++
 tools/virtio/xen/xen.h           | 6 ++++++
 4 files changed, 10 insertions(+)
 create mode 100644 tools/virtio/crypto/hash.h
 create mode 100644 tools/virtio/xen/xen.h
