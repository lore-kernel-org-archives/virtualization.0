From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 0/1] s390/virtio update
Date: Mon, 18 Dec 2017 17:21:22 +0100
Message-ID: <20171218162123.963-1-cohuck__35182.980183936$1513614014$gmane$org@redhat.com>
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
To: mst@redhat.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 20677394b78ed4c4baa09c9a1bcfdf24d2b09fe4:

  Merge branch 'vhost' into vhost-next (2017-12-18 08:21:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20171218-v2

for you to fetch changes up to 352d303fa99330e5d197afcc28b5270734e5c541:

  virtio/s390: implement PM operations for virtio_ccw (2017-12-18 10:23:47 +0100)

----------------------------------------------------------------
Hibernation support for virtio-ccw.

----------------------------------------------------------------

Christian Borntraeger (1):
  virtio/s390: implement PM operations for virtio_ccw

 drivers/s390/virtio/virtio_ccw.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.13.6
