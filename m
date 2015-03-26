From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] Add virtio gpu driver.
Date: Thu, 26 Mar 2015 12:53:56 +0100
Message-ID: <20150326124751-mutt-send-email-mst__10476.6912329525$1427370872$gmane$org@redhat.com>
References: <20150324171255-mutt-send-email-mst@redhat.com>
	<1427295121.23304.5.camel@nilsson.home.kraxel.org>
	<20150325162246-mutt-send-email-mst@redhat.com>
	<1427297836.23304.29.camel@nilsson.home.kraxel.org>
	<20150325180721-mutt-send-email-mst@redhat.com>
	<1427353959.9779.2.camel@nilsson.home.kraxel.org>
	<20150326091545-mutt-send-email-mst@redhat.com>
	<1427359367.9779.9.camel@nilsson.home.kraxel.org>
	<20150326095736-mutt-send-email-mst@redhat.com>
	<1427369923.9779.18.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427369923.9779.18.camel@nilsson.home.kraxel.org>
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
Cc: virtio-dev@lists.oasis-open.org, David Airlie <airlied@linux.ie>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 26, 2015 at 12:38:43PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > Absolutely, it's pretty common to mix regions in a BAR.
> > For example, we have virtio kick (ioeventfd backed,
> > handled in kernel) in same BAR as common and device
> > specific configuration.
> 
> > We did the same thing you are now doing with the
> > virtio BAR, and now we have to maintain two code
> > bases, virtio pci config was designed to be future proof
> > so why not use it?
> 
> It's not about virtio at all.  It's about vga compatibility, so we have
> a simple framebuffer as boot display.  Only used when virtio is *not*
> enabled.
> 

I don't know. This seems exactly like the kind of thing
we had in mind when we added the virtio pci capability.
For example, we have text in spec that requires drivers
to skip unknown capabilities.

And yes, if bios pokes at a specific bar then we do
need to list this info in the virtio spec so this makes
it an issue that is virtio related.


> > This is mostly just making sure we don't paint ourselves into a corner.
> 
> It's a simple memory bar.  vga cards have that since pci was invented
> (standalone ones, chipset graphics aside), and there havn't been
> fundamental changes ...
> 
> cheers,
>   Gerd
> 

Yes, it's not about what we put there now. It's about being able
to move things about in the future without breaking guests.

-- 
MST
