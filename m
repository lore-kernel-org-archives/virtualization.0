From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] remoteproc/rpmsg: fix kconfig dependencies for VIRTIO
Date: Tue, 16 Apr 2013 12:24:06 -0500
Message-ID: <1366133046-5369-1-git-send-email-s-anna__49423.4322141439$1366654598$gmane$org@ti.com>
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
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This fixes the Kconfig dependency warnings for VIRTIO when remoteproc
and/or rpmsg are enabled. I have intentionally split the change into
two patches, based on testing by enabling STE-MODEM-RPROC and
OMAP_REMOTEPROC separately. The former selects just REMOTEPROC, while
the latter selects both REMOTEPROC & RPMSG. The split should also
enable the patches to come through remoteproc & rpmsg trees respectively.

regards
Suman

Suman Anna (2):
  remoteproc: fix kconfig dependencies for VIRTIO
  rpmsg: fix kconfig dependencies for VIRTIO

 drivers/remoteproc/Kconfig | 1 +
 drivers/rpmsg/Kconfig      | 1 +
 2 files changed, 2 insertions(+)

-- 
1.8.2
