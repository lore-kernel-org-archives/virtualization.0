From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Wed, 25 Mar 2015 16:19:00 +0100
Message-ID: <1427296740.23304.21.camel__45736.9913849563$1427296774$gmane$org@nilsson.home.kraxel.org>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<CAPj87rN4pXHukDRD-e=ZrO1hcts04cSz1Hr9TNAgicGVWE5_-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPj87rN4pXHukDRD-e=ZrO1hcts04cSz1Hr9TNAgicGVWE5_-Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
	list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO
	CORE, NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Di, 2015-03-24 at 22:50 +0000, Daniel Stone wrote:
> Hi,
> 
> On 24 March 2015 at 16:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > +static int virtio_gpu_crtc_page_flip(struct drm_crtc *crtc,
> > +                                    struct drm_framebuffer *fb,
> > +                                    struct drm_pending_vblank_event *event,
> > +                                    uint32_t flags)
> > +{
> > +       return -EINVAL;
> > +}
> 
> I'm not going to lie, I was really hoping the 5th (?) GPU option for
> Qemu would support pageflipping.

As Dave already pointed out there is a WIP patch for that, it'll be
there.

While being at it:
 - bochsdrm (qemu -vga std driver) supports pageflip since 3.19.
 - cirrus is more or less a lost case, we mimic existing hardware
   from the 90ies here and it simply isn't up to todays needs for
   many reasons.  Just stop using it.
 - qxl -- hmm, not sure, there is this "primary surface" concept in
   the virtual hardware design, which doesn't mix very well with
   pageflip I suspect.

> Daniel's comment about conversion to
> atomic is relevant, but: do you have a mechanism which allows you to
> post updates (e.g. 'start displaying this buffer now please') that
> allows you to get events back when they have actually been displayed?

It's possible to fence the framebuffer update requests, so you'll be
notified when the update has reached the qemu ui code.  Typically the ui
code has queued the update at that point.  So with a local display (sdl,
gtk) showing up on the screen should be just a pageflip (on the host)
away.  With a remote display (vnc) it will take a little longer until
the user will actually see the update.

cheers,
  Gerd
