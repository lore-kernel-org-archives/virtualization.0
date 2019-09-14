From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: a last minute revert
Date: Sat, 14 Sep 2019 15:38:59 -0400
Message-ID: <20190914153859-mutt-send-email-mst__36634.7820776113$1568489956$gmane$org@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

So I made a mess of it. Sent a pull before making sure it works on 32
bit too. Hope it's not too late to revert. Will teach me to be way more
careful in the near future.

The following changes since commit 060423bfdee3f8bc6e2c1bac97de24d5415e2bc4:

  vhost: make sure log_num < in_num (2019-09-11 15:15:26 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0d4a3f2abbef73b9e5bb5f12213c275565473588:

  Revert "vhost: block speculation of translated descriptors" (2019-09-14 15:21:51 -0400)

----------------------------------------------------------------
virtio: a last minute revert

32 bit build got broken by the latest defence in depth patch.
Revert and we'll try again in the next cycle.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      Revert "vhost: block speculation of translated descriptors"

 drivers/vhost/vhost.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
