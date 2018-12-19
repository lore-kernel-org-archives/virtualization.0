From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio fix
Date: Wed, 19 Dec 2018 18:29:58 -0500
Message-ID: <20181219182958-mutt-send-email-mst__22422.7707171396$1545262418$gmane$org@kernel.org>
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
Cc: netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Sorry about the last-minute pull req.
But it does seem very very safe and also the tests
aren't automatically built right now so the 0 day
infrastructure won't help anyway.

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c5c08bed843c2b2c048c16d1296d7631d7c1620e:

  virtio: fix test build after uio.h change (2018-12-19 18:23:49 -0500)

----------------------------------------------------------------
virtio fix

A last-minute fix for a test build.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

 tools/virtio/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)
