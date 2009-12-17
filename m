From: "Leonid Grossman" <Leonid.Grossman@neterion.com>
Subject: RE: Guest bridge setup variations
Date: Thu, 17 Dec 2009 01:18:10 -0500
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD7705FDF0C3@nekter>
References: <78C9135A3D2ECE4B8162EBDCE82CAD7705FDEDCF@nekter>
	<78C9135A3D2ECE4B8162EBDCE82CAD7705FDEEDA@nekter>
	<200912161515.32820.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200912161515.32820.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, December 16, 2009 6:16 AM
> To: virtualization@lists.linux-foundation.org
> Cc: Leonid Grossman; qemu-devel@nongnu.org
> Subject: Re: Guest bridge setup variations
> 
> On Wednesday 16 December 2009, Leonid Grossman wrote:
> > > > 3. Doing the bridging in the NIC using macvlan in passthrough
> > > > mode. This lowers the CPU utilization further compared to 2,
> > > > at the expense of limiting throughput by the performance of
> > > > the PCIe interconnect to the adapter. Whether or not this
> > > > is a win is workload dependent.
> >
> > This is certainly true today for pci-e 1.1 and 2.0 devices, but
> > as NICs move to pci-e 3.0 (while remaining almost exclusively dual
> port
> > 10GbE for a long while),
> > EVB internal bandwidth will significantly exceed external bandwidth.
> > So, #3 can become a win for most inter-guest workloads.
> 
> Right, it's also hardware dependent, but it usually comes down
> to whether it's cheaper to spend CPU cycles or to spend IO bandwidth.
> 
> I would be surprised if all future machines with PCIe 3.0 suddenly
have
> a huge surplus of bandwidth but no CPU to keep up with that.
> 
> > > > Access controls now happen
> > > > in the NIC. Currently, this is not supported yet, due to lack of
> > > > device drivers, but it will be an important scenario in the
> future
> > > > according to some people.
> >
> > Actually, x3100 10GbE drivers support this today via sysfs interface
> to
> > the host driver
> > that can choose to control VEB tables (and therefore MAC addresses,
> vlan
> > memberships, etc. for all passthru interfaces behind the VEB).
> 
> Ok, I didn't know about that.
> 
> > OF course a more generic vendor-independent interface will be
> important
> > in the future.
> 
> Right. I hope we can come up with something soon. I'll have a look at
> what your driver does and see if that can be abstracted in some way.

Sounds good, please let us know if looking at the code/documentation
will suffice or you need a couple cards to go along with the code.

> I expect that if we can find an interface between the kernel and
device
> driver for two or three NIC implementations that it will be good
enough
> to adapt to everyone else as well.

The interface will likely evolve along with EVB standards and other
developments, but 
initial implementation can be pretty basic (and vendor-independent). 
Early IOV NIC deployments can benefit from an interface that sets couple
VF parameters missing in "legacy" NIC interface - things like bandwidth
limit and list of MAC addresses (since setting a NIC in promisc mode
doesn't work well for VEB, it is currently forced to learn the addresses
it is configured for). 
The interface can also include querying IOV NIC capabilities like number
of VFs, support for VEB and/or VEPA mode, etc as well as getting VF
stats and MAC/VLAN tables - all in all, it is not a long list.


> 
> 	Arnd
