From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Date: Thu, 14 May 2020 14:28:51 +0200
Message-ID: <20200514122851.GO206103@phenom.ffwll.local>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6d9gdZegTGad6thKdHv5b+qOZnkCv5VcWo9AcHifR9uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=HUj6d9gdZegTGad6thKdHv5b+qOZnkCv5VcWo9AcHifR9uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Stevens <stevensd@chromium.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Tomasz Figa <tfiga@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 14, 2020 at 11:08:52AM +0900, David Stevens wrote:
> On Thu, May 14, 2020 at 12:45 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Mar 11, 2020 at 12:20 PM David Stevens <stevensd@chromium.org> wrote:
> > >
> > > This change adds a new dma-buf operation that allows dma-bufs to be used
> > > by virtio drivers to share exported objects. The new operation allows
> > > the importing driver to query the exporting driver for the UUID which
> > > identifies the underlying exported object.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> >
> > Adding Tomasz Figa, I've discussed this with him at elce last year I
> > think. Just to make sure.
> >
> > Bunch of things:
> > - obviously we need the users of this in a few drivers, can't really
> > review anything stand-alone
> 
> Here is a link to the usage of this feature by the currently under
> development virtio-video driver:
> https://markmail.org/thread/j4xlqaaim266qpks
> 
> > - adding very specific ops to the generic interface is rather awkward,
> > eventually everyone wants that and we end up in a mess. I think the
> > best solution here would be if we create a struct virtio_dma_buf which
> > subclasses dma-buf, add a (hopefully safe) runtime upcasting
> > functions, and then a virtio_dma_buf_get_uuid() function. Just storing
> > the uuid should be doable (assuming this doesn't change during the
> > lifetime of the buffer), so no need for a callback.
> 
> So you would prefer a solution similar to the original version of this
> patchset? https://markmail.org/message/z7if4u56q5fmaok4

yup.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
