From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio
Date: Mon, 22 Mar 2010 16:34:25 +0200
Message-ID: <20100322143425.GA19370__49073.7759312198$1269268793$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Linus,
Please pull a couple of virtio-console fixes by Amit.

The following changes since commit 220bf991b0366cc50a94feede3d7341fa5710ee4:

  Linux 2.6.34-rc2 (2010-03-19 18:17:57 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for-linus

Amit Shah (2):
      virtio: console: Generate a kobject CHANGE event on adding 'name' attribute
      virtio: console: Check if port is valid in resize_console

 drivers/char/virtio_console.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)
