From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: fix connector leak at unload
Date: Mon, 14 Jan 2019 08:38:22 +0100
Message-ID: <20190114073822.3jzujq47cwfoizgh__7736.85783283344$1547693228$gmane$org@sirius.home.kraxel.org>
References: <20190111140242.29002-1-robdclark@gmail.com>
	<20190111220620.GF21184@phenom.ffwll.local>
	<20190111221638.GG21184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190111221638.GG21184@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, Rob Clark <rclark@redhat.com>, Daniel Stone <daniels@collabora.com>, David Airlie <airlied@linux.ie>, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Thierry Reding <treding@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2019 at 11:16:38PM +0100, Daniel Vetter wrote:
> On Fri, Jan 11, 2019 at 11:06:20PM +0100, Daniel Vetter wrote:
> > On Fri, Jan 11, 2019 at 09:02:34AM -0500, Rob Clark wrote:
> > > This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.
> > > 
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > Similar case to the issue that was fixed recently in drm/ast
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Actually I just pushed a patch to drm-misc-next to rename this function to
> drm_helper_force_disable_all(), so you need to respin ... My r-b still
> holds.

Fixed and queued up.

thanks,
  Gerd
