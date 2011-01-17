From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: remove virtio-pci root device
Date: Mon, 17 Jan 2011 11:03:51 +1030
Message-ID: <201101171103.51778.rusty__8276.31426877833$1295224489$gmane$org@rustcorp.com.au>
References: <20110105191711.GA27489@redhat.com>
	<20110110171046.GB27292@redhat.com>
	<20110110171904.GA30058@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110110171904.GA30058@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Jamie Lokier <jamie@shareable.org>, Thomas Weber <swirl@gmx.li>, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 11 Jan 2011 03:49:04 am Michael S. Tsirkin wrote:
> On Mon, Jan 10, 2011 at 07:10:46PM +0200, Gleb Natapov wrote:
> > On Fri, Jan 07, 2011 at 02:55:06AM -0600, Milton Miller wrote:
> > > We sometimes need to map between the virtio device and
> > > the given pci device. One such use is OS installer that
> > > gets the boot pci device from BIOS and needs to
> > > find the relevant block device. Since it can't,
> > > installation fails.
> > > 
> > > Instead of creating a top-level devices/virtio-pci
> > > directory, create each device under the corresponding
> > > pci device node.  Symlinks to all virtio-pci
> > > devices can be found under the pci driver link in
> > > bus/pci/drivers/virtio-pci/devices, and all virtio
> > > devices under drivers/bus/virtio/devices.
> > > 
> > > Signed-off-by: Milton Miller <miltonm@bga.com>
> > Acked-by: Gleb Natapov <gleb@redhat.com>
> 
> Rusty, any comments?
> We are going to tell the installer guys that this
> is the interface, would be nice to know that the
> patch is queued before we do.

Yep, I've applied it.  Sorry, took a week off to work on my linux.conf.au
talk...

Cheers,
Rusty.
