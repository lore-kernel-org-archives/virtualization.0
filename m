From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
Date: Wed, 26 Jun 2019 11:15:31 +0200
Message-ID: <20190626091531.35da5c2dsz6fuz5w__3438.47556957684$1561540557$gmane$org@sirius.home.kraxel.org>
References: <20190405044602.2334-1-kraxel@redhat.com>
	<20190626095146.2731a2dc.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190626095146.2731a2dc.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, jcmvbkbc@gmail.com, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 26, 2019 at 09:51:46AM +0200, Cornelia Huck wrote:
> On Fri,  5 Apr 2019 06:46:02 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > drm_connector_update_edid_property can sleep, we must not
> > call it while holding a spinlock.  Move the callsize.
> 
> s/callsize/callsite/

Fixed on commit.

> This gets rid of the sleeping while atomic traces I've been seeing with
> an s390x guest (both virtio-gpu-pci and virtio-gpu-ccw).
> 
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> 
> I have also looked at the code a bit, but don't feel confident enough
> to give an R-b.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks.  Pushed to drm-misc-fixes.

cheers,
  Gerd
