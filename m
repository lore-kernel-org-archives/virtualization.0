From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-devel] [PATCH 1/3] virtio interface
Date: Tue, 25 Sep 2007 08:36:28 +0200
Message-ID: <200709250836.29451.arnd__47290.1973910213$1190702821$gmane$org@arndb.de>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<200709250018.12705.arnd@arndb.de>
	<1190677058.27805.225.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190677058.27805.225.camel@localhost.localdomain>
Content-Disposition: inline
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
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 September 2007, Rusty Russell wrote:
> On Tue, 2007-09-25 at 00:18 +0200, Arnd Bergmann wrote:
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
> 
> > Also, I would not mix the two in a single source file. Instead, I think
> > every driver that can provide virtio devices (pci, lguest, ...) should
> > be responsible for setting the parent appropriately.
> 
> I don't mind: we could expose it.

What I mean with setting the parent appropriately is not to have a global
device that is used by the hv-specific probing code, but to make sure
that each of them provides their own one. The bus_type should either be
global or provide the wrappers for device_register and driver_register
that you have, but the host bridge device belongs with the code that
probes it. E.g. when all virtio devices are behind PCI bridges, there
does not need to be an empty /virtio or /lguest device node at all.

	Arnd <><
