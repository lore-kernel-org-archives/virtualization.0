From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 19/26] drm/qxl: Use drm_fb_helper_fill_info
Date: Fri, 25 Jan 2019 07:39:26 +0100
Message-ID: <20190125063926.hdgfq7ouggqgjkoa__46372.066477646$1548442031$gmane$org@sirius.home.kraxel.org>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
	<20190124165831.16427-20-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190124165831.16427-20-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 24, 2019 at 05:58:24PM +0100, Daniel Vetter wrote:
> This should not result in any changes.

I'd love to merge https://patchwork.freedesktop.org/series/53951/
instead (which will -- among other things -- switch qxl over to the
generic fbdev emulation and remove the code you are patching here).

Anyone willing to review?  Dave?

thanks,
  Gerd
