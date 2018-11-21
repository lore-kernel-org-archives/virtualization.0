From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 2/2] drm/virtio: add edid support
Date: Wed, 21 Nov 2018 09:54:22 +0100
Message-ID: <20181121085422.mk4ob6vhwbnufqzl__7913.90260351381$1542790358$gmane$org@sirius.home.kraxel.org>
References: <20181030063206.19528-1-kraxel@redhat.com>
	<20181030063206.19528-3-kraxel@redhat.com>
	<20181030093804.GQ21967@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181030093804.GQ21967@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 30, 2018 at 10:38:04AM +0100, Daniel Vetter wrote:
> On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> > linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Like with bochs, I think drm_do_get_edid() here is overkill and fairly
> pointless.

Like with bochs it makes sense to use drm_do_get_edid(), because it
handles edid override and other common stuff.  Not that this should
actually be needed for virtual devices, but I think it still makes sense
for consistency with other drivers, and it might be handy for testing
too.

cheers,
  Gerd
