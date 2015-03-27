From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] Add virtio gpu driver.
Date: Fri, 27 Mar 2015 09:08:26 +0100
Message-ID: <1427443706.22166.10.camel__2896.0277945318$1427443767$gmane$org@nilsson.home.kraxel.org>
References: <20150325162246-mutt-send-email-mst@redhat.com>
	<1427297836.23304.29.camel@nilsson.home.kraxel.org>
	<20150325180721-mutt-send-email-mst@redhat.com>
	<1427353959.9779.2.camel@nilsson.home.kraxel.org>
	<20150326091545-mutt-send-email-mst@redhat.com>
	<1427359367.9779.9.camel@nilsson.home.kraxel.org>
	<20150326095736-mutt-send-email-mst@redhat.com>
	<1427369923.9779.18.camel@nilsson.home.kraxel.org>
	<20150326124751-mutt-send-email-mst@redhat.com>
	<1427382436.8786.15.camel@nilsson.home.kraxel.org>
	<20150326174401-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150326174401-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, David Airlie <airlied@linux.ie>, "open
	list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
	list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO
	CORE, NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > 
> > Completely different thing crossing my mind:  I think we can make
> > virtio-vga fully compatible with stdvga.  stdvga has two bars, memory
> > (#0) and mmio (#2).  We can make the mmio bar larger and place all the
> > virtio regions there.
> > 
> 
> Full compatibility with some standard sounds like a better motivation,
> yes.

Ok, I'll look into it.

> > I think in any case I'll go split off the vga compatibility bits to a
> > different patch (and possible a separate patch series).
> > 
> > cheers,
> >   Gerd
> 
> Will you still need me to change core to claim specific memory only?

That would be great, yes.  The resource conflict with vesafb/efifb will
stay no matter how we design the pci resource layout of virtio-vga.

cheers,
  Gerd
