From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Fri, 7 Jun 2013 14:30:23 +0300
Message-ID: <20130607113023.GE15299@redhat.com>
References: <87bo7ktvaw.fsf@codemonkey.ws> <20130605162029.GB26561@redhat.com>
	<51AFA92B.2030203@zytor.com> <87fvwwmdmf.fsf@codemonkey.ws>
	<51AFB3DD.1050902@zytor.com> <874ndcb47i.fsf@codemonkey.ws>
	<51AFC4A6.6070607@zytor.com> <877gi8nk9e.fsf@codemonkey.ws>
	<20130606063432.GQ4725@redhat.com> <871u8fp9jd.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871u8fp9jd.fsf@codemonkey.ws>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 06, 2013 at 10:02:14AM -0500, Anthony Liguori wrote:
> Gleb Natapov <gleb@redhat.com> writes:
> 
> > On Wed, Jun 05, 2013 at 07:41:17PM -0500, Anthony Liguori wrote:
> >> "H. Peter Anvin" <hpa@zytor.com> writes:
> >> 
> >> > On 06/05/2013 03:08 PM, Anthony Liguori wrote:
> >> >>>
> >> >>> Definitely an option.  However, we want to be able to boot from native
> >> >>> devices, too, so having an I/O BAR (which would not be used by the OS
> >> >>> driver) should still at the very least be an option.
> >> >> 
> >> >> What makes it so difficult to work with an MMIO bar for PCI-e?
> >> >> 
> >> >> With legacy PCI, tracking allocation of MMIO vs. PIO is pretty straight
> >> >> forward.  Is there something special about PCI-e here?
> >> >> 
> >> >
> >> > It's not tracking allocation.  It is that accessing memory above 1 MiB
> >> > is incredibly painful in the BIOS environment, which basically means
> >> > MMIO is inaccessible.
> >> 
> >> Oh, you mean in real mode.
> >> 
> >> SeaBIOS runs the virtio code in 32-bit mode with a flat memory layout.
> >> There are loads of ASSERT32FLAT()s in the code to make sure of this.
> >> 
> > Well, not exactly. Initialization is done in 32bit, but disk
> > reads/writes are done in 16bit mode since it should work from int13
> > interrupt handler. The only way I know to access MMIO bars from 16 bit
> > is to use SMM which we do not have in KVM.
> 
> Ah, if it's just the dataplane operations then there's another solution.
> 
> We can introduce a virtqueue flag that asks the backend to poll for new
> requests.  Then SeaBIOS can add the request to the queue and not worry
> about kicking or reading the ISR.
> 
And when backend stops polling? When guest's driver reconfigure it? But
what if this will never happen?

> SeaBIOS is polling for completion anyway.
> 
> Regards,
> 
> Anthony Liguori
> 
> >
> > --
> > 			Gleb.
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
