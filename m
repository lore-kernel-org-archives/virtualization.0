From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec
	include file
Date: Fri, 12 Sep 2014 12:44:56 +0200
Message-ID: <1410518696.30411.9.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<5411BD74.80608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5411BD74.80608@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Blake <eblake@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > @@ -0,0 +1,158 @@
> > +#ifndef VIRTGPU_HW_H
> > +#define VIRTGPU_HW_H
> 
> Non-trivial file, deserves a copyright and license notice.

Added.

> > +
> > +enum virtgpu_ctrl_type {
> > +        VIRTGPU_UNDEFINED = 0,
> > +
> > +        /* 2d commands */
> > +        VIRTGPU_CMD_GET_DISPLAY_INFO = 0x0100,
> 
> Please consider also adding:
> 
> #define VIRTGPU_CMD_GET_DISPLAY_INFO VIRTGPU_CMD_GET_DISPLAY_INFO
> 
> and friends.  It makes it MUCH nicer for application software to probe
> for later extensions if every member of the enum is also associated with
> a preprocessor macro.

I don't think this will ever be shipped as library header for external
users ...

> > +struct virtgpu_ctrl_hdr {
> > +        uint32_t type;
> > +        uint32_t flags;
> > +        uint64_t fence_id;
> > +        uint32_t ctx_id;
> > +        uint32_t padding;
> > +};
> > +
> 
> Is the padding to ensure that this is aligned regardless of 32-bit or
> 64-bit hosts?

Yes.

> Is it worth adding a compile-time assertion about the
> size of the struct to ensure the compiler doesn't add any additional
> padding?

Makes sense.  What is the usual trick to do that?

thanks,
  Gerd
