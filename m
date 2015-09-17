From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Fix memory leaks in virtio & remoteproc cores
Date: Wed, 16 Sep 2015 19:29:16 -0500
Message-ID: <1442449758-14594-1-git-send-email-s-anna@ti.com>
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
To: Ohad Ben-Cohen <ohad@wizery.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

The following patches fix couple of memory leaks in the virtio and
remoteproc cores when using these as modules, and going through a
cycle of insmod and rmmod with at least a device registered with
the corresponding cores in between. I ran into this on our downstream
product kernels on both 3.14 and 4.1 based kernels, and should apply
to the latest kernel as well.

Patches can be picked up independently through the respective trees.

regards
Suman

Suman Anna (2):
  virtio: fix memory leak of virtio ida cache layers
  remoteproc: fix memory leak of remoteproc ida cache layers

 drivers/remoteproc/remoteproc_core.c | 2 ++
 drivers/virtio/virtio.c              | 1 +
 2 files changed, 3 insertions(+)

-- 
2.5.0
