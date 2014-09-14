From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-gpu/2d: add hardware spec include file
Date: Sun, 14 Sep 2014 16:46:22 +0300
Message-ID: <20140914134622.GB27315@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<5411BD74.80608@redhat.com>
	<1410518696.30411.9.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410518696.30411.9.camel@nilsson.home.kraxel.org>
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
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 12, 2014 at 12:44:56PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > @@ -0,0 +1,158 @@
> > > +#ifndef VIRTGPU_HW_H
> > > +#define VIRTGPU_HW_H
> > 
> > Non-trivial file, deserves a copyright and license notice.
> 
> Added.

Pls remember to make it consistent with other virtio headers,
which are 3-clause BSD, prefixed with this reminder:

 This header is BSD licensed so anyone can use the definitions to
 implement compatible drivers/servers.



> > > +
> > > +enum virtgpu_ctrl_type {
> > > +        VIRTGPU_UNDEFINED = 0,
> > > +
> > > +        /* 2d commands */
> > > +        VIRTGPU_CMD_GET_DISPLAY_INFO = 0x0100,
> > 
> > Please consider also adding:

VIRTIO_GPU_ everywhere to make it consistent with other
virtio headers?


> > 
> > #define VIRTGPU_CMD_GET_DISPLAY_INFO VIRTGPU_CMD_GET_DISPLAY_INFO
> > 
> > and friends.  It makes it MUCH nicer for application software to probe
> > for later extensions if every member of the enum is also associated with
> > a preprocessor macro.
> 
> I don't think this will ever be shipped as library header for external
> users ...
> 
> > > +struct virtgpu_ctrl_hdr {
> > > +        uint32_t type;
> > > +        uint32_t flags;
> > > +        uint64_t fence_id;
> > > +        uint32_t ctx_id;
> > > +        uint32_t padding;
> > > +};
> > > +
> > 
> > Is the padding to ensure that this is aligned regardless of 32-bit or
> > 64-bit hosts?
> 
> Yes.
> 
> > Is it worth adding a compile-time assertion about the
> > size of the struct to ensure the compiler doesn't add any additional
> > padding?
> 
> Makes sense.  What is the usual trick to do that?
> 
> thanks,
>   Gerd

BUILD_BUG_ON in linux, QEMU_BUILD_BUG_ON in QEMU.
You have to stick it in a C file though, so it
won't be visible in this patch.

-- 
MST
