From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Wed, 30 Nov 2011 18:15:56 +0200
Message-ID: <20111130161555.GB25812@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151607.GE30966@redhat.com>
	<CAK=WgbZK+k4uuyMPHUfr_PMyrR5ceRTvuDRpmhXfgwpSUOPw0g@mail.gmail.com>
	<20111130145958.GE21413@redhat.com>
	<CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbYyFdLftE_kp2_JOThVhn-FzGsDqVqKn0Jwm2teQyZBNA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 30, 2011 at 06:04:56PM +0200, Ohad Ben-Cohen wrote:
> On Wed, Nov 30, 2011 at 4:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I see. And this happens because the ARM processor reorders
> > memory writes
> 
> Yes.
> 
> > And in an SMP configuration, writes are somehow not reordered?
> 
> They are, but then the smp memory barriers are enough to control these
> effects. It's not enough to control reordering as seen by a device
> (which is what our AMP processors are) though.
> 
> (btw, the difference between an SMP processor and a device here lies
> in how the memory is mapped: normal memory vs. device memory
> attributes. it's an ARM thingy).

How are the rings mapped? normal memory, right?
We allocate them with plan alloc_pages_exact in virtio_pci.c ...

> > Just checking that this is not a bug in the smp_wmb implementation
> > for the specific platform.
> 
> No, it's not.
> 
> ARM's smp memory barriers use ARM's DMB instruction, which is enough
> to control SMP effects, whereas ARM's mandatory memory barriers use
> ARM's DSB instruction, which is required to ensure the ordering
> between Device and Normal memory accesses.
> 
> Thanks,
> Ohad.

Yes wmb() is required to ensure ordering for MMIO.
But here both accesses: index and ring - are for
memory, not MMIO.

I could understand ring kick bypassing index write, maybe ...
But you described an index write bypassing descriptor write.
Is this something you see in practice?


-- 
MST
