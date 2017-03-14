From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm: qxl: add missing return check
Date: Tue, 14 Mar 2017 10:54:10 +0300
Message-ID: <20170314075410.GB5984__40655.9265255511$1489478099$gmane$org@mwanda>
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
To: Dave Airlie <airlied@redhat.com>, Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

My static checker complains that "release" is uninitialized if
qxl_alloc_release_reserved() fails, so let's add a check for that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 9548bb58d3bc..058340a002c2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -572,6 +572,8 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 	ret = qxl_alloc_release_reserved(qdev, sizeof(*cmd),
 					 QXL_RELEASE_CURSOR_CMD,
 					 &release, NULL);
+	if (ret)
+		return;
 
 	cmd = (struct qxl_cursor_cmd *) qxl_release_map(qdev, release);
