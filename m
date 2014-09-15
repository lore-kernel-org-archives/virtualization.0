From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-gpu/2d: add hardware spec include file
Date: Mon, 15 Sep 2014 13:55:06 +0300
Message-ID: <20140915105506.GA10190@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
	<5411BD74.80608@redhat.com>
	<1410518696.30411.9.camel@nilsson.home.kraxel.org>
	<20140914134622.GB27315@redhat.com>
	<1410777607.30598.7.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410777607.30598.7.camel@nilsson.home.kraxel.org>
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

On Mon, Sep 15, 2014 at 12:40:07PM +0200, Gerd Hoffmann wrote:
> > > > > +
> > > > > +enum virtgpu_ctrl_type {
> > > > > +        VIRTGPU_UNDEFINED = 0,
> > > > > +
> > > > > +        /* 2d commands */
> > > > > +        VIRTGPU_CMD_GET_DISPLAY_INFO = 0x0100,
> > > > 
> > > > Please consider also adding:
> > 
> > VIRTIO_GPU_ everywhere to make it consistent with other
> > virtio headers?
> 
> The names are already pretty long as-is, especially considering the
> 80cols rule in our codestyle.  I'd prefer to keep them the way they are
> now.
> 
> cheers,
>   Gerd
> 

VIRTIO_GPU_ is not longer than VIRTIO_NET_ is it?

VIRTGRU seems too generic.

-- 
MST
