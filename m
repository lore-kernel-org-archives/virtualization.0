From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: fix a memory leak bug
Date: Tue, 20 Aug 2019 08:57:24 +0200
Message-ID: <20190820065724.mc3anvne2sf356x3__47854.0773897961$1566284255$gmane$org@sirius.home.kraxel.org>
References: <1566238098-3962-1-git-send-email-wenwen@cs.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1566238098-3962-1-git-send-email-wenwen@cs.uga.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 19, 2019 at 01:08:18PM -0500, Wenwen Wang wrote:
> In qxl_bo_create(), the temporary 'bo' is allocated through kzalloc().
> However, it is not deallocated in the following execution if ttm_bo_init()
> fails, leading to a memory leak bug. To fix this issue, free 'bo' before
> returning the error.

No.  ttm_bo_init() calls the destroy callback (qxl_ttm_bo_destroy for
qxl) on failure, which will properly cleanup 'bo' and also free it.

cheers,
  Gerd
