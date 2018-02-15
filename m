From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: cleanups and fixes
Date: Thu, 15 Feb 2018 20:27:44 +0200
Message-ID: <20180215202744-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, groug@kaod.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit d25cc43c6775bff6b8e3dad97c747954b805e421:

  vhost: don't hold onto file pointer for VHOST_SET_LOG_FD (2018-02-01 16:26:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to fa08a3b4eba59429cf7e241a7af089103e79160f:

  virtio/s390: implement PM operations for virtio_ccw (2018-02-14 14:34:09 +0200)

----------------------------------------------------------------
virtio: bugfixes

This includes a bugfix for virtio 9p fs.
It also fixes hybernation for s390 guests with virtio devices.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christian Borntraeger (1):
      virtio/s390: implement PM operations for virtio_ccw

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

 drivers/s390/virtio/virtio_ccw.c | 29 +++++++++++++++++++++++++++++
 net/9p/trans_virtio.c            |  3 ++-
 2 files changed, 31 insertions(+), 1 deletion(-)
