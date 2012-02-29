From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio: balloon: leak / fill balloon across S4
Date: Thu, 01 Mar 2012 09:33:45 +1030
Message-ID: <877gz52qem.fsf@rustcorp.com.au>
References: <2d3cb82e72219287db72e20901237a1058246915.1330517514.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2d3cb82e72219287db72e20901237a1058246915.1330517514.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

 + 65e65f9...847ce6c for-linus -> for-linus (forced update)
The following changes since commit 5ffca28a4ac7abb8a254fafe6bd03b2f83667df7:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs (2012-02-27 07:59:33 -0800)

are available in the git repository at:

  git://github.com/rustyrussell/linux.git master

Amit Shah (1):
      virtio: balloon: leak / fill balloon across S4

 drivers/virtio/virtio_balloon.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)
