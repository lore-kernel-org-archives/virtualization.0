From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Tue, 31 May 2016 08:29:20 +0200
Message-ID: <1464676160.5978.24.camel__37282.9164182351$1464676175$gmane$org@redhat.com>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427718227.3372.33.camel@nilsson.home.kraxel.org>
	<20150330144927.GN23521@phenom.ffwll.local>
	<CAKMK7uFUNT193f5djZD6T8cgRxxnZL73yrqbupPHOd2P-+Y=pQ@mail.gmail.com>
	<1464335302.10663.10.camel@redhat.com>
	<20160527090313.GX27098@phenom.ffwll.local>
	<1464616236.5179.41.camel@redhat.com>
	<20160530144755.GK27098@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160530144755.GK27098@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
	list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO
	CORE, NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > Why attach the hotspot to the plane?  Wouldn't it make more sense to
> > make it a framebuffer property?
> 
> We don't have properties on the framebuffer. I guess you /could/ just add
> it internally to struct drm_framebuffer, and not bother exposing to
> userspace. I guess that would be a lot simpler,

Yes.  I can simply stick the hotspot into drm_framebuffer in
drm_mode_cursor_universal() and pick up the values in the driver's plane
update function.

>  but it also means that
> atomic userspace can't use hotspots before we add properties to fbs. And
> doing that is a bit tricky since drm_framebuffer objects are meant to be
> invariant - this assumption is deeply in-grained into the code all over
> the place, everything just compares pointers when semantically it means to
> compare the entire fb (including backing storage pointer/offsets and
> everything).

Hmm, the hotspot location for a given cursor image is invariant too, so
I don't think that would be a big issue.

I'd expect userspace define a bunch of cursors, then switch between them
(instead of defining a single cursor, then constantly updating it).

cheers,
  Gerd
