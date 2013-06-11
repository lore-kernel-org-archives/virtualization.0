From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Tue, 11 Jun 2013 11:03:50 +0300
Message-ID: <20130611080350.GF4725@redhat.com>
References: <87fvwwmdmf.fsf@codemonkey.ws> <51AFB3DD.1050902@zytor.com>
	<874ndcb47i.fsf@codemonkey.ws> <51AFC4A6.6070607@zytor.com>
	<877gi8nk9e.fsf@codemonkey.ws> <20130606063432.GQ4725@redhat.com>
	<871u8fp9jd.fsf@codemonkey.ws> <20130611071047.GC31474@redhat.com>
	<20130611075348.GE4725@redhat.com>
	<20130611080226.GH31474@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130611080226.GH31474@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 11, 2013 at 11:02:26AM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 11, 2013 at 10:53:48AM +0300, Gleb Natapov wrote:
> > On Tue, Jun 11, 2013 at 10:10:47AM +0300, Michael S. Tsirkin wrote:
> > > On Thu, Jun 06, 2013 at 10:02:14AM -0500, Anthony Liguori wrote:
> > > > Gleb Natapov <gleb@redhat.com> writes:
> > > > 
> > > > > On Wed, Jun 05, 2013 at 07:41:17PM -0500, Anthony Liguori wrote:
> > > > >> "H. Peter Anvin" <hpa@zytor.com> writes:
> > > > >> 
> > > > >> > On 06/05/2013 03:08 PM, Anthony Liguori wrote:
> > > > >> >>>
> > > > >> >>> Definitely an option.  However, we want to be able to boot from native
> > > > >> >>> devices, too, so having an I/O BAR (which would not be used by the OS
> > > > >> >>> driver) should still at the very least be an option.
> > > > >> >> 
> > > > >> >> What makes it so difficult to work with an MMIO bar for PCI-e?
> > > > >> >> 
> > > > >> >> With legacy PCI, tracking allocation of MMIO vs. PIO is pretty straight
> > > > >> >> forward.  Is there something special about PCI-e here?
> > > > >> >> 
> > > > >> >
> > > > >> > It's not tracking allocation.  It is that accessing memory above 1 MiB
> > > > >> > is incredibly painful in the BIOS environment, which basically means
> > > > >> > MMIO is inaccessible.
> > > > >> 
> > > > >> Oh, you mean in real mode.
> > > > >> 
> > > > >> SeaBIOS runs the virtio code in 32-bit mode with a flat memory layout.
> > > > >> There are loads of ASSERT32FLAT()s in the code to make sure of this.
> > > > >> 
> > > > > Well, not exactly. Initialization is done in 32bit, but disk
> > > > > reads/writes are done in 16bit mode since it should work from int13
> > > > > interrupt handler. The only way I know to access MMIO bars from 16 bit
> > > > > is to use SMM which we do not have in KVM.
> > > > 
> > > > Ah, if it's just the dataplane operations then there's another solution.
> > > > 
> > > > We can introduce a virtqueue flag that asks the backend to poll for new
> > > > requests.  Then SeaBIOS can add the request to the queue and not worry
> > > > about kicking or reading the ISR.
> > > 
> > > This will pin a host CPU.
> > > If we do something timer based it will likely
> > > both increase host CPU utilization and slow device down.
> > > 
> > > If we didn't care about performance at all we could
> > > do config cycles for signalling, which is much
> > > more elegant than polling in host, but I don't think
> > > that's the case.
> > > 
> > I wouldn't call BIOS int13 interface performance critical.
> 
> So the plan always was to
> - add an MMIO BAR
> - add a register for pci-config based access to devices
> 
> hpa felt performance does matter there but didn't clarify why ...
> 
You do not what to make it too slow obviously, this is interface that is
used to load OS during boot.

> > > > 
> > > > SeaBIOS is polling for completion anyway.
> > > 
> > > I think that's different because a disk will normally respond
> > > quickly. So it polls a bit, but then it stops as
> > > there are no outstanding requests.
> > > 
> > > -- 
> > > MST
> > 
> > --
> > 			Gleb.

--
			Gleb.
