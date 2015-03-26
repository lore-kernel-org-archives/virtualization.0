From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] Add virtio gpu driver.
Date: Thu, 26 Mar 2015 16:07:16 +0100
Message-ID: <1427382436.8786.15.camel__2428.83833493597$1427382469$gmane$org@nilsson.home.kraxel.org>
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
	<20150326124751-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150326124751-mutt-send-email-mst@redhat.com>
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

> I don't know. This seems exactly like the kind of thing
> we had in mind when we added the virtio pci capability.
> For example, we have text in spec that requires drivers
> to skip unknown capabilities.
> 
> And yes, if bios pokes at a specific bar then we do
> need to list this info in the virtio spec so this makes
> it an issue that is virtio related.

Hmm, virtio-vga is a two-in-one device basically.  When virtio is
enabled it behaves like virtio-gpu-pci, otherwise it behaves very
simliar to stdvga.  So you need to know nothing about virtio to handle
the vga side, and I want keep it that way.

When no vga compatibility is needed there always is the option to just
use virtio-gpu-pci instead.

> Yes, it's not about what we put there now. It's about being able
> to move things about in the future without breaking guests.

We don't have that today for stdvga, and I still fail to see what this
buys us.


Completely different thing crossing my mind:  I think we can make
virtio-vga fully compatible with stdvga.  stdvga has two bars, memory
(#0) and mmio (#2).  We can make the mmio bar larger and place all the
virtio regions there.


I think in any case I'll go split off the vga compatibility bits to a
different patch (and possible a separate patch series).

cheers,
  Gerd
