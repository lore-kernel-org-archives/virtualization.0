From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach}
	calls.
Date: Thu, 18 Oct 2018 09:00:04 +0200
Message-ID: <20181018070004.mplea3ozamph6uzu__1288.14187269217$1539845889$gmane$org@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
	<20181001103222.11924-8-kraxel@redhat.com>
	<CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
	<20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
	<CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> > > This to me feels more like a bind/unbind operation rather than a
> > > populate/unpopulate operation,
> > >
> > > bind is " Bind the backend pages into the aperture in the location"
> > >
> > > whereas populate is
> > >
> > > allocate pages for a ttm.
> >
> > I ran into that trap too ;)
> >
> > My first attempt was to map this to bind/unbind.  But this is not
> > correct and therefore didn't work very well.
> >
> > virtio_gpu_object_attach() will send a scatter list of the pages
> > allocated for the object to the host (so the host knows where to
> > copy from/to when processing the transfer_from/to calls).  So IMO
> > it should be done on population not when binding.
> 
> Well bind on AGP is the same thing, we'd fill the AGP GART table on
> bind, so that the AGP GPU could access the pages.

> So I'm interested in why using bind/unbind failed if you have some more info?

Need to try again to be sure, but IIRC I saw multiple bind/unbind calls
for the same object.  ttm probably does it to not waste AGB GART address
space for objects not in use.  But for virtio it is pointless overhead.
But maybe it is just a matter of taking a reference and keeping it for
the whole lifetime of the object to make the binding permanent ...

cheers,
  Gerd
