From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Tue, 5 Dec 2017 14:41:49 -0800
Message-ID: <20171205144149.126eba97__8930.95847354761$1512563232$gmane$org@xeon-e3>
References: <20171128112722.00003716@intel.com>
	<0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
	<CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
	<20171130155612-mutt-send-email-mst@kernel.org>
	<780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
	<20171203065759-mutt-send-email-mst@kernel.org>
	<CAEHy93+yhRtTQub0xk5W1jKRNisrcRBtNexcwRfWdSKPm5a4Gw@mail.gmail.com>
	<20171203093524.26491cd0@xeon-e3>
	<CAEHy93LEr5h81KGfJBr5Z4ZKaeWEWwQL1LYfZNXoVF_HB6TQGw@mail.gmail.com>
	<CAKgT0Uf5gta+CNM3ReybV3qNMJXqoT9BHvMjKRbd=PYOPQrQaA@mail.gmail.com>
	<CAEHy93Kw-GePsraaAkVZNbOwt=rDPMVjmwuU22004LHCAoSSFA@mail.gmail.com>
	<20171205142928.00f5a51a@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171205142928.00f5a51a@cakuba.netronome.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jakub Kicinski <kubakici@wp.pl>
Cc: Hannes Frederic Sowa <hannes@redhat.com>, achiad shochat <achiad.mellanox@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Shannon Nelson <shannon.nelson@oracle.com>, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, netdev <netdev@vger.kernel.org>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 5 Dec 2017 14:29:28 -0800
Jakub Kicinski <kubakici@wp.pl> wrote:

> On Tue, 5 Dec 2017 11:59:17 +0200, achiad shochat wrote:
> > >>>> I second Jacob - having a netdev of one device driver enslave a netdev
> > >>>> of another device driver is an awkward a-symmetric model.
> > >>>> Regardless of whether they share the same backend device.
> > >>>> Only I am not sure the Linux Bond is the right choice.
> > >>>> e.g one may well want to use the virtio device also when the
> > >>>> pass-through device is available, e.g for multicasts, east-west
> > >>>> traffic, etc.
> > >>>> I'm not sure the Linux Bond fits that functionality.
> > >>>> And, as I hear in this thread, it is hard to make it work out of the box.
> > >>>> So I think the right thing would be to write a new dedicated module
> > >>>> for this purpose.    
> > >
> > > This part I can sort of agree with. What if we were to look at
> > > providing a way to somehow advertise that the two devices were meant
> > > to be boded for virtualization purposes? For now lets call it a
> > > "virt-bond". Basically we could look at providing a means for virtio
> > > and VF drivers to advertise that they want this sort of bond. Then it
> > > would just be a matter of providing some sort of side channel to
> > > indicate where you want things like multicast/broadcast/east-west
> > > traffic to go.  
> > 
> > I like this approach.  
> 
> +1 on a separate driver, just enslaving devices to virtio may break
> existing setups.  If people are bonding from user space today, if they
> update their kernel it may surprise them how things get auto-mangled.
> 
> Is what Alex is suggesting a separate PV device that says "I would
> like to be a bond of those two interfaces"?  That would make the HV
> intent explicit and kernel decisions more understandable.

So far, in my experience it still works.
As long as the kernel slaving happens first, it will work.
The attempt to bond an already slaved device will fail and no scripts seem
to check the error return.
