From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Thu, 26 Mar 2015 09:53:49 +0100
Message-ID: <20150326085349.GP1349__41404.3038421825$1427375143$gmane$org@phenom.ffwll.local>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427295189.23304.6.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427295189.23304.6.camel@nilsson.home.kraxel.org>
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 25, 2015 at 03:53:09PM +0100, Gerd Hoffmann wrote:
> > > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Standard request from my side for new drm drivers (especially if they're
> > this simple): Can you please update the drivers to latest drm internal
> > interfaces, i.e. using universal planes and atomic?
> 
> Have a docs / sample code pointer for me?

Picking any of the recently converted drivers or recently merged atomic
drivers should be fairly informative. Overall conversion procedure is
detailed in

http://blog.ffwll.ch/2014/11/atomic-modeset-support-for-kms-drivers.html
http://blog.ffwll.ch/2015/01/update-for-atomic-display-updates.html

And ofc there's the kerneldoc stuff in the drm docbook. If you have
questions probably best to ask them in #dri-devel irc, most of the people
who've done atomic conversions hang out there and can help out.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
