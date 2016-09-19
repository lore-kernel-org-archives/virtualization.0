From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/2] Fix recursive Kconfig depedency issue
Date: Mon, 19 Sep 2016 10:34:18 +0100
Message-ID: <1474277660-5196-1-git-send-email-peter.griffin@linaro.org>
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
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, airlied@linux.ie, kraxel@redhat.com, vinod.koul@intel.com, sfr@canb.auug.org.au, bjorn.andersson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This series fixes a Kconfig recurssive depedency issue and also some
trivial white space. This was found when developing the fdma dmaegine
series [1], which has now been applied by Vinod.

These patchs were originally included as part of the fdma series [1],
but I've now sent it separately as requested by Vinod [2], and also
privately by Emil. 

FYI not having this patch applied causes kbuild error emails [3].

[1] https://lkml.org/lkml/2016/9/13/191

[2] https://lkml.org/lkml/2016/9/15/562

[3] https://lkml.org/lkml/2016/9/15/850

Peter Griffin (2):
  drm/virtio: kconfig: Fix recursive dependency issue.
  drm/virtio: kconfig: Fixup white space.

 drivers/gpu/drm/virtio/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.9.1
