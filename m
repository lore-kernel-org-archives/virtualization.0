From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 1/3] virtio interface
Date: Tue, 25 Sep 2007 10:18:06 +0200
Message-ID: <20070925101806.3aa6d3d2__14212.8123472959$1190708467$gmane$org@gondolin.boeblingen.de.ibm.com>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<200709250018.12705.arnd@arndb.de>
	<1190677058.27805.225.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190677058.27805.225.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Sep 2007 09:37:38 +1000,
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue, 2007-09-25 at 00:18 +0200, Arnd Bergmann wrote:
> > On Monday 24 September 2007, Rusty Russell wrote:
> > > +
> > > +struct virtio_bus {
> > > +	struct bus_type bus;
> > > +	struct device dev;
> > > +};
> > > +
> > > +static struct virtio_bus virtio_bus = {
> > > +	.bus = {
> > > +		.name  = "virtio",
> > > +		.match = virtio_dev_match,
> > > +		.dev_attrs = virtio_dev_attrs,
> > > +	},
> > > +	.dev = {
> > > +		/* Can override this if you have a real bus behind it. */
> > > +		.parent = NULL,
> > > +		.bus_id = "virtio",
> > > +	}
> > > +};
> > 
> > This is a pattern I've seen a few times before, but could never understand
> > what it's good for. What is your reason for defining a new data structure
> > that is used only once, instead of just
> > 
> > static struct bus_type virtio_bus_type;
> > static struct device virtio_root_dev;
> 
> It's copied from the lguest bus which was copied from somewhere else.
> Creating a struct like this is a quiet complaint about the requirements
> to do so: it's not clear to me why I need to create a fake device,
> rather than making the bus the parent of the device if it needs one.

You may want to have different busses, all having their own root
device, which share the same bus type.

Or you may want to embed the root device into a more complex structure.
