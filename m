From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Date: Tue, 2 Oct 2018 05:55:37 -0700
Message-ID: <20181002125537.GA15740@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
	<20180926160031.15721-5-willy@infradead.org>
	<20180926160455.GA20337@bombadil.infradead.org>
	<20181002114328.kltyrjlojzrhzwgl@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181002114328.kltyrjlojzrhzwgl@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 02, 2018 at 01:43:28PM +0200, Gerd Hoffmann wrote:
> On Wed, Sep 26, 2018 at 09:04:55AM -0700, Matthew Wilcox wrote:
> > On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> > > @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
> > >  
> > >  	if (handle < 0)
> > >  		return handle;
> > > +	handle++;
> > >  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
> > >  	return handle;
> > >  }
> > 
> > Uh.  This line is missing.
> > 
> > -       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
> > +       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
> > 
> > It'll be there in v2 ;-)
> 
> I've touched the resource/object id handling too, see my "drm/virtio:
> rework ttm resource handling" patch series
> (https://patchwork.freedesktop.org/series/50382/).  Which still needs a
> review btw.

Um, according to patchwork, you only posted it yesterday.  Does DRM
normally expect a review within 24 hours?

> I think that series obsoletes patch 3/4 (object id fixes) of your
> series.  The other patches should rebase without too much trouble, you
> could do that as well when preparing v2 ...

It seems a little odd to me to expect a drive-by contributor (ie me) to
rebase their patches on top of a patch series which wasn't even posted
at the time they contributed their original patch.  If it was already
in -next, that'd be a reasonable request.
