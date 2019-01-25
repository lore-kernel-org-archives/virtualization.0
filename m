From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 19/26] drm/qxl: Use drm_fb_helper_fill_info
Date: Fri, 25 Jan 2019 09:52:50 +0100
Message-ID: <20190125085250.GC3271__23996.8732859538$1548442048$gmane$org@phenom.ffwll.local>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
	<20190124165831.16427-20-daniel.vetter@ffwll.ch>
	<20190125063926.hdgfq7ouggqgjkoa@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190125063926.hdgfq7ouggqgjkoa@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 25, 2019 at 07:39:26AM +0100, Gerd Hoffmann wrote:
> On Thu, Jan 24, 2019 at 05:58:24PM +0100, Daniel Vetter wrote:
> > This should not result in any changes.
> 
> I'd love to merge https://patchwork.freedesktop.org/series/53951/
> instead (which will -- among other things -- switch qxl over to the
> generic fbdev emulation and remove the code you are patching here).

Ah yes very happy to drop my patch in favour of yours.

> Anyone willing to review?  Dave?

Noralf might be a good choice too, with you cross-reviewing some of his
in-flight work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
