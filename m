From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] virtio-ringtest: more enablement
Date: Mon, 19 Sep 2016 17:06:54 +0200
Message-ID: <20160919150656.6194-1-cornelia.huck__49303.1928352595$1474297668$gmane$org@de.ibm.com>
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
Cc: pasic@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

here are two patches by Halil so that we can get ringtest going on
our platform as well.

Question: Do you have an idea on how realistic the timings are
supposed to be? The s390 path is, well, 'tweak me'...

Halil Pasic (2):
  tools/virtio/ringtest: fix run-on-all.sh for offline cpus
  tools/virtio/ringtest: tweaks for s390

 tools/virtio/ringtest/main.h        | 12 ++++++++++++
 tools/virtio/ringtest/run-on-all.sh |  5 +++--
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.8.4
