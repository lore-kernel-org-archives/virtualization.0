From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] Add virtio gpu driver.
Date: Thu, 26 Mar 2015 12:38:43 +0100
Message-ID: <1427369923.9779.18.camel__43703.5958785147$1427369952$gmane$org@nilsson.home.kraxel.org>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324171255-mutt-send-email-mst@redhat.com>
	<1427295121.23304.5.camel@nilsson.home.kraxel.org>
	<20150325162246-mutt-send-email-mst@redhat.com>
	<1427297836.23304.29.camel@nilsson.home.kraxel.org>
	<20150325180721-mutt-send-email-mst@redhat.com>
	<1427353959.9779.2.camel@nilsson.home.kraxel.org>
	<20150326091545-mutt-send-email-mst@redhat.com>
	<1427359367.9779.9.camel@nilsson.home.kraxel.org>
	<20150326095736-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150326095736-mutt-send-email-mst@redhat.com>
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

> Absolutely, it's pretty common to mix regions in a BAR.
> For example, we have virtio kick (ioeventfd backed,
> handled in kernel) in same BAR as common and device
> specific configuration.

> We did the same thing you are now doing with the
> virtio BAR, and now we have to maintain two code
> bases, virtio pci config was designed to be future proof
> so why not use it?

It's not about virtio at all.  It's about vga compatibility, so we have
a simple framebuffer as boot display.  Only used when virtio is *not*
enabled.

> This is mostly just making sure we don't paint ourselves into a corner.

It's a simple memory bar.  vga cards have that since pci was invented
(standalone ones, chipset graphics aside), and there havn't been
fundamental changes ...

cheers,
  Gerd
