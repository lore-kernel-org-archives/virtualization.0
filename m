From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Fri, 02 Dec 2011 10:56:33 +1030
Message-ID: <8762hzsts6.fsf@rustcorp.com.au>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151958.GA31789@redhat.com>
	<CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
	<20111130145004.GD21413@redhat.com>
	<CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
	<20111130231306.GD30031@redhat.com>
	<87zkfdrpn8.fsf@rustcorp.com.au> <20111201081236.GB5479@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111201081236.GB5479@redhat.com>
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
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 1 Dec 2011 10:12:37 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Dec 01, 2011 at 12:58:59PM +1030, Rusty Russell wrote:
> > On Thu, 1 Dec 2011 01:13:07 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > For x86, stores into memory are ordered. So I think that yes, smp_XXX
> > > can be selected at compile time.
> > > 
> > > So let's forget the virtio strangeness for a minute,
> > 
> > Hmm, we got away with light barriers because we knew we were not
> > *really* talking to a device.  But now with virtio-mmio, turns out we
> > are :)
> 
> You think virtio-mmio this issue too?  It's reported on remoteproc...

I think any non-virtual, non-PCI device has to worry about it.  Perhaps
all virtio-mmio are virtual (at this point).

I'm tempted to say we want permission from the device to do relaxed
barriers (so I don't have to worry about it!)

> > I'm really tempted to revert d57ed95 for 3.2, and we can revisit this
> > optimization later if it proves worthwhile.
> 
> Generally it does seem the best we can do for 3.2.
> 
> Given it's rc3, I'd be a bit wary of introducing regressions - I'll try
> to find some real setups (as in - not my laptop) to run some benchmarks
> on, to verify there's no major problem.
> I hope I can report on this in about a week from now - want to hold onto this meanwhile?

Yep, no huge hurry.  Thanks!

Cheers,
Rusty.
