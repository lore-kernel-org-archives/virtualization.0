From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Mon, 4 Dec 2017 15:25:48 +0200
Message-ID: <20171204152548-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: mhocko@suse.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, zhangweiping@didichuxing.com, marcandre.lureau@redhat.com, jstancek@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit c1d0c3f623ada808904dec676da0126f5b800630:

  fw_cfg: fix the command line module name (2017-11-14 23:57:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d9e427f6ab8142d6868eb719e6a7851aafea56b6:

  virtio_balloon: fix increment of vb->num_pfns in fill_balloon() (2017-12-=
01 16:55:45 +0200)

----------------------------------------------------------------
virtio,qemu: bugfixes

A couple of bugfixes that just became ready.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jan Stancek (1):
      virtio_balloon: fix increment of vb->num_pfns in fill_balloon()

Marc-Andr=E9 Lureau (1):
      fw_cfg: fix driver remove

weiping zhang (1):
      virtio: release virtio index when fail to device_register

 drivers/firmware/qemu_fw_cfg.c  | 3 ++-
 drivers/virtio/virtio.c         | 2 ++
 drivers/virtio/virtio_balloon.c | 3 +--
 3 files changed, 5 insertions(+), 3 deletions(-)
