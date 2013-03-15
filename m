From: Erwan Yvin <erwan.yvin@stericsson.com>
Subject: [PATCH 0/2] remoteproc : support for host virtio
Date: Fri, 15 Mar 2013 10:29:54 +0100
Message-ID: <1363339796-14591-1-git-send-email-erwan.yvin__7882.31818373806$1363646977$gmane$org@stericsson.com>
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
To: Ohad Ben-Cohen <ohad@wizery.com>, Rusty Russel <rusty@ruscorp.com.au>, Ido Yariv <ido@wizery.com>
Cc: lkml <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Linus Walleij <linus.walleij@stericsson.com>, Erwan Yvin <erwan.yvin@stericsson.com>, Sjur Braendeland <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Erwan Yvin <erwan.yvin@stericsson.com>

This driver depends on Rusty's new host virtio ring implementation,
so this patch-set is based on the vringh branch in Rusty's git.
with the vringh wrapper patch on top. They do not apply cleanly on top of the
remoteproc virtio config patches from Sjur, but it merges fine.

CAIF will use this new host virtio ring implementation.
Ido, Ohad , Please could you review these patchs ?
            
	    Best regards

Erwan YVIN (1):
  remoteproc: refactor find_vqs to prepare for vringh

Erwan Yvin (1):
  remoteproc: Add support for host virtio rings (vringh)

 drivers/remoteproc/remoteproc_virtio.c |  237 +++++++++++++++++++++++++-------
 include/linux/remoteproc.h             |   22 +++
 2 files changed, 208 insertions(+), 51 deletions(-)

-- 
1.7.9.2
