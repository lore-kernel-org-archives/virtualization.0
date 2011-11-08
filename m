From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-pci new configuration proposal
Date: Tue, 08 Nov 2011 20:51:38 +1030
Message-ID: <87vcqurk25.fsf@rustcorp.com.au>
References: <20111104135113.GA24452@redhat.com>
	<1320414804.3334.13.camel@lappy>
	<20111104142338.GB24452@redhat.com>
	<1320418385.3334.25.camel@lappy> <20111106073007.GA7146@redhat.com>
	<1320611097.3299.10.camel@lappy>
	<20111106213849.GA14292@redhat.com>
	<871utktsuw.fsf@rustcorp.com.au>
	<20111107211413.GA11577@redhat.com>
	<87aa87sd4y.fsf@rustcorp.com.au>
	<20111108063249.GB11577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111108063249.GB11577@redhat.com>
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
Cc: Anthony Liguori <anthony@codemonkey.ws>, virtualization <virtualization@lists.linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, kvm <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 8 Nov 2011 08:32:50 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Nov 08, 2011 at 10:23:33AM +1030, Rusty Russell wrote:
> > Even so, should we just use the PCI cap list, and have each
> > cap entry just contain a BIR & offset?
> > 
> > Thanks,
> > Rusty.
> 
> And size :)
> I say, Rusty, did you see my patch? That's what it's doing,
> I also addressed the issue that with KVM on x86, PIO is faster
> than MMIO so we need to use it for notifications/isr.

Faster?  Really?  Why?  Were the ppc guys right that's it's obsolescent?

Because PIO is going to be ugly AFAICT for every non-x86 platform.

Cheers,
Rusty.
