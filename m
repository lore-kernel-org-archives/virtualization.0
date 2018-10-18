From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach}
	calls.
Date: Thu, 18 Oct 2018 08:10:59 +0200
Message-ID: <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
	<20181001103222.11924-8-kraxel@redhat.com>
	<CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
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

On Thu, Oct 18, 2018 at 11:41:52AM +1000, Dave Airlie wrote:
> On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
> > callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
> > is the correct place to handle this.
> >
> > The new ttm_tt_{populate,unpopulate} callbacks call the
> > ttm_pool_populate()/unpopulate() functions (which are the default
> > implementation in case the callbacks not present) for the actual ttm
> > work.  Additionally virtio_gpu_object_{attach,detach} is called to
> > update the state on the host.
> 
> This to me feels more like a bind/unbind operation rather than a
> populate/unpopulate operation,
> 
> bind is " Bind the backend pages into the aperture in the location"
> 
> whereas populate is
> 
> allocate pages for a ttm.

I ran into that trap too ;)

My first attempt was to map this to bind/unbind.  But this is not
correct and therefore didn't work very well.

virtio_gpu_object_attach() will send a scatter list of the pages
allocated for the object to the host (so the host knows where to
copy from/to when processing the transfer_from/to calls).  So IMO
it should be done on population not when binding.

cheers,
  Gerd
