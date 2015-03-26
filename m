From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Thu, 26 Mar 2015 08:12:39 +0100
Message-ID: <1427353959.9779.2.camel__21612.0710749694$1427353989$gmane$org@nilsson.home.kraxel.org>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324171255-mutt-send-email-mst@redhat.com>
	<1427295121.23304.5.camel@nilsson.home.kraxel.org>
	<20150325162246-mutt-send-email-mst@redhat.com>
	<1427297836.23304.29.camel@nilsson.home.kraxel.org>
	<20150325180721-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150325180721-mutt-send-email-mst@redhat.com>
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

On Mi, 2015-03-25 at 18:09 +0100, Michael S. Tsirkin wrote:
> On Wed, Mar 25, 2015 at 04:37:16PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > BTW can we teach virtio-gpu to look for framebuffer using
> > > virtio pci caps?
> > 
> > The virtio-gpu driver doesn't matter much here, it doesn't use it
> > anyway.
> > 
> > >  Or are there limitations such as only
> > > using IO port BARs, or compatibility with
> > > BIOS code etc that limit us to specific BARs anyway?
> > 
> > Yes, vgabios code needs to know.  Currently it has bar #2 for the vga
> > framebuffer bar hardcoded.  It's 16bit code.  I don't feel like making
> > the probing more complicated ...
> > 
> > cheers,
> >   Gerd
> 
> OK - you are saying all VGA cards use bar #2 for this
> functionality, so we are just following
> established practice here?

vgabios checks pci ids to figure.  qxl+stdvga use bar #0, vmware-vga bar
#1, virtio-vga bar #2.

cheers,
  Gerd
