From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] Minor virtio-balloon fix.
Date: Mon, 09 Jul 2012 09:10:40 +0930
Message-ID: <874nph4y9z.fsf@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 02edf6abe01610a5fb379df442de3c837ad99467:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac (2012-06-18 13:34:25 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git tags/virtio-for-linus

for you to fetch changes up to 9c378abc5c0c6fc8e3acf5968924d274503819b3:

  virtio-balloon: fix add/get API use (2012-07-09 09:07:22 +0930)

----------------------------------------------------------------
Theoretical fix, which greatly simplifies upcoming balloon patches which will go in via some vm tree.

----------------------------------------------------------------
Michael S. Tsirkin (1):
      virtio-balloon: fix add/get API use

 drivers/virtio/virtio_balloon.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)
