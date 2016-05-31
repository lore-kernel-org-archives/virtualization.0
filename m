From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Tue, 31 May 2016 08:55:17 +0200
Message-ID: <CAKMK7uEK867bF+cdvoA=FyFo-zw7UwK9Bzi2boVFLQ0R4wSh3w__5036.20283348045$1464677731$gmane$org@mail.gmail.com>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427718227.3372.33.camel@nilsson.home.kraxel.org>
	<20150330144927.GN23521@phenom.ffwll.local>
	<CAKMK7uFUNT193f5djZD6T8cgRxxnZL73yrqbupPHOd2P-+Y=pQ@mail.gmail.com>
	<1464335302.10663.10.camel@redhat.com>
	<20160527090313.GX27098@phenom.ffwll.local>
	<1464616236.5179.41.camel@redhat.com>
	<20160530144755.GK27098@phenom.ffwll.local>
	<1464676160.5978.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464676160.5978.24.camel@redhat.com>
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
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 31, 2016 at 8:29 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>  but it also means that
>> atomic userspace can't use hotspots before we add properties to fbs. And
>> doing that is a bit tricky since drm_framebuffer objects are meant to be
>> invariant - this assumption is deeply in-grained into the code all over
>> the place, everything just compares pointers when semantically it means to
>> compare the entire fb (including backing storage pointer/offsets and
>> everything).
>
> Hmm, the hotspot location for a given cursor image is invariant too, so
> I don't think that would be a big issue.
>
> I'd expect userspace define a bunch of cursors, then switch between them
> (instead of defining a single cursor, then constantly updating it).

Agreed, conceptually it would be a really nice fit to put the hotspot
into the invariant drm_framebuffer. I just meant to say that you need
to add a bit of new uapi to make it happen, since we can't reuse our
existing get/set_prop functions (since those only change props after
the object is created). And we also can't use our existing ioctls to
enumerate properties of an object (since chicken-egg: you want the
list of properties before creating a new framebuffer, so can't use
that framebuffer to enumerate them).

But really not a big concern.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
