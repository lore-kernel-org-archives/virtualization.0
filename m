From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 9 Jul 2007 18:33:19 +0200
Message-ID: <200707091833.19520.arnd@arndb.de>
References: <20070706124200.988637662@arndb.de>
	<200707091624.57725.arnd@arndb.de> <46924C95.8010002@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46924C95.8010002@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 09 July 2007, Avi Kivity wrote:
> Arnd Bergmann wrote:
> >
> > But you can always have one more event than you have space in the queue,
> > so the host _still_ needs to do its own queuing of these events.
> 
> It's probably enough to keep a flag that the guest is not up-to-date, 
> and have a reconfiguration message include the entire configuration 
> (e.g. don't send deltas).

Probably, but the important point is that this is a decision that can
be made per driver. For some drivers, it can make sense to have
partial updates, e.g. for the virtbus you only care about added and
removed devices instead of passing a complete list for every update,
while for other drivers, it may be easier to pass a single data structure
with all the configuration every time.

> > [interesting side effect: you can have a PCI device that actually
> > is a virtbus bridge device, as the parent for other hcall based
> > virtio devices, along with other PCI devices, some of which are
> > a virtio device by themselves.]
> >   
> That still doesn't help with older Linuces and closed-source OSes, which 
> are the main motivation for PCI.  Newer Linux should be pure virtbus IMO.

Since anything regarding virtio is about paravirtualization, you will
always need additional drivers to run them, and the interesting part
that remains is to that _something_ exist that you need a driver for.
Once you have the driver for the virtio bridge, the OS will know that
there is more that can be probed through another mechanism, similar
to how you can start probing USB devices as soon as you know what
the USB host controller on the PCI bus does.

An interesting argument made by hpa during OLS is that there is some
value in designing the PCI device in a way that it can operate just
by using standard PCI functionality like MMIO access. I think now that
this can be done without significant overhead compared to a pure hcall
inteface. With this, I think we can get a good compromise by implementing
* PCI based virtbus, hypervisor independent,
* Xen based virtbus,
* hcall based virtbus, shared between kvm and lguest, potentially others,
  and
* virtqueue based virtbus bridge, for probing hcall based devices
  through PCI.

	Arnd <><
