From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 2/2] drm/virtio: add edid support
Date: Wed, 21 Nov 2018 10:34:14 +0100
Message-ID: <20181121093414.GK4266__31933.02433142$1542792737$gmane$org@phenom.ffwll.local>
References: <20181030063206.19528-1-kraxel@redhat.com>
	<20181030063206.19528-3-kraxel@redhat.com>
	<20181030093804.GQ21967@phenom.ffwll.local>
	<20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, virtio-dev@lists.oasis-open.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 21, 2018 at 09:54:22AM +0100, Gerd Hoffmann wrote:
> On Tue, Oct 30, 2018 at 10:38:04AM +0100, Daniel Vetter wrote:
> > On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> > > linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Like with bochs, I think drm_do_get_edid() here is overkill and fairly
> > pointless.
> 
> Like with bochs it makes sense to use drm_do_get_edid(), because it
> handles edid override and other common stuff.  Not that this should
> actually be needed for virtual devices, but I think it still makes sense
> for consistency with other drivers, and it might be handy for testing
> too.

Yeah Jani corrected me here, I forgot that we reworked all this quite a
bit. I checked the kerneldoc, it's up-to-date, so all good. Ack: me fwiw.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
