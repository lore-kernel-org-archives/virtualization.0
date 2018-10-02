From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Date: Tue, 2 Oct 2018 13:43:28 +0200
Message-ID: <20181002114328.kltyrjlojzrhzwgl__25719.797894317$1538480518$gmane$org@sirius.home.kraxel.org>
References: <20180926160031.15721-1-willy@infradead.org>
	<20180926160031.15721-5-willy@infradead.org>
	<20180926160455.GA20337@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180926160455.GA20337@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 26, 2018 at 09:04:55AM -0700, Matthew Wilcox wrote:
> On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> > @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
> >  
> >  	if (handle < 0)
> >  		return handle;
> > +	handle++;
> >  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
> >  	return handle;
> >  }
> 
> Uh.  This line is missing.
> 
> -       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
> +       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);
> 
> It'll be there in v2 ;-)

I've touched the resource/object id handling too, see my "drm/virtio:
rework ttm resource handling" patch series
(https://patchwork.freedesktop.org/series/50382/).  Which still needs a
review btw.

I think that series obsoletes patch 3/4 (object id fixes) of your
series.  The other patches should rebase without too much trouble, you
could do that as well when preparing v2 ...

cheers,
  Gerd
