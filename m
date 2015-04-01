From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 4/4] Add virtio-vga bits.
Date: Wed, 01 Apr 2015 15:42:58 +0200
Message-ID: <1427895778.6445.13.camel@nilsson.home.kraxel.org>
References: <1427894130-14228-1-git-send-email-kraxel@redhat.com>
	<1427894130-14228-5-git-send-email-kraxel@redhat.com>
	<20150401152535-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150401152535-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, airlied@redhat.com, airlied@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Mi, 2015-04-01 at 15:26 +0200, Michael S. Tsirkin wrote:
> On Wed, Apr 01, 2015 at 03:15:30PM +0200, Gerd Hoffmann wrote:
> > +static void virtio_pci_kick_out_firmware_fb(struct pci_dev *pci_dev)
> > +{
> > +	struct apertures_struct *ap;
> > +	bool primary;
> > +
> > +	ap = alloc_apertures(1);
> > +	if (!ap)
> > +		return;
> > +
> > +	ap->ranges[0].base = pci_resource_start(pci_dev, 2);
> > +	ap->ranges[0].size = pci_resource_len(pci_dev, 2);
> 
> I thought you mentioned it's better to switch to a different BAR
> to be compatible with stdvga?

Indeed, thats why the cover letter lists this as todo item, because it
isn't sorted yet.

Need to figure a sane way to handle this on the host side.  Current plan
is trying to make virtio_pci_device_plugged() configurable without
making things too messy.

cheers,
  Gerd
