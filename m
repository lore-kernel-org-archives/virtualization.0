From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 19:12:49 +0300
Message-ID: <20130529161249.GA1771@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com> <8761y1q3aw.fsf@codemonkey.ws>
	<20130529143053.GB10462@redhat.com> <87k3mhkf7o.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k3mhkf7o.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 09:55:55AM -0500, Anthony Liguori wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, May 29, 2013 at 09:16:39AM -0500, Anthony Liguori wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> > I'm guessing any compiler that decides to waste memory in this way
> >> > will quickly get dropped by users and then we won't worry
> >> > about building QEMU with it.
> >> 
> >> There are other responses in the thread here and I don't really care to
> >> bikeshed on this issue.
> >
> > Great. Let's make the bikeshed blue then?
> 
> It's fun to argue about stuff like this and I certainly have an opinion,
> but I honestly don't care all that much about the offsetof thing.
> However...
> 
> 
> >
> >> >> Well, given that virtio is widely deployed today, I would think the 1.0
> >> >> standard should strictly reflect what's deployed today, no?
> >> >> Any new config layout would be 2.0 material, right?
> >> >
> >> > Not as it's currently planned. Devices can choose
> >> > to support a legacy layout in addition to the new one,
> >> > and if you look at the patch you will see that that
> >> > is exactly what it does.
> >> 
> >> Adding a new BAR most certainly requires bumping the revision ID or
> >> changing the device ID, no?
> >
> > No, why would it?
> 
> If we change the programming interface for a device in a way that is
> incompatible, we are required to change the revision ID and/or device
> ID.

It's compatible.


> > If a device dropped BAR0, that would be a good reason
> > to bump revision ID.
> > We don't do this yet.
> 
> But we have to drop BAR0 to put it behind a PCI express bus, right?

No, no.

The PCIe spec states that failure to allocate an I/O BAR should still
allow the device to function.

That's *guest* allocating an I/O BAR.


> If that's the case, then device that's exposed on the PCI express bus
> must use a different device ID and/or revision ID.
> 
> That means a new driver is needed in the guest.
> 
> >> Didn't we run into this problem with the virtio-win drivers with just
> >> the BAR size changing? 
> >
> > Because they had a bug: they validated BAR0 size. AFAIK they don't care
> > what happens with other bars.
> 
> I think there's a grey area with respect to the assumptions a device can
> make about the programming interface.
> 
> But very concretely, we cannot expose virtio-pci-net via PCI express
> with BAR0 disabled because that will result in existing virtio-pci Linux
> drivers breaking.
> 
> > Not we. The BIOS can disable IO BAR: it can do this already
> > but the device won't be functional.
> 
> But the only way to expose the device over PCI express is to disable the
> IO BAR, right?
> 
> Regards,
> 
> Anthony Liguori

No :)
