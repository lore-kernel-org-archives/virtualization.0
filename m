From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Spice-devel] [PATCH 4/4] drm/qxl: add drm_driver.release
 callback.
Date: Fri, 20 Dec 2019 14:00:25 +0100
Message-ID: <20191220130025.maasx7xfb7rtadgd__34308.3373548993$1576846871$gmane$org@sirius.home.kraxel.org>
References: <20191220115935.15152-1-kraxel@redhat.com>
 <20191220115935.15152-5-kraxel@redhat.com>
 <57755373.16738363.1576843760950.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <57755373.16738363.1576843760950.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 20, 2019 at 07:09:20AM -0500, Frediano Ziglio wrote:
> > 
> > Move final cleanups to qxl_drm_release() callback.
> 
> Can you explain in the commit why this is better or preferable?

It gets called when the drm device refcount goes down to zero.
It's needed for a proper cleanup in the correct order.

> > Add drm_atomic_helper_shutdown() call to qxl_pci_remove().
> 
> I suppose this is to replace the former manual cleanup calls,
> which were moved to qxl_drm_release, I think this could be
> added in the commit message ("why"), I don't see much value
> in describing "how" this was done.

The call is part of the shutdown sequence for atomic drm drivers
and wasn't present in qxl for some reason.

> > Reorder calls in qxl_device_fini().  Cleaning up gem & ttm
> > might trigger qxl commands, so we should do that before
> > releaseing command rings.
> 
> Typo: releaseing -> releasing
> Why not putting this in a separate commit? Was this behaviour
> changed? It does not seem so to me.

Yes, I can make that a separate commit.

No, behavior didn't change.  qxl_device_fini() is simply broken
without this.

cheers,
  Gerd
