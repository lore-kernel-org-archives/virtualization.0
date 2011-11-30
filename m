From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Thu, 1 Dec 2011 01:13:07 +0200
Message-ID: <20111130231306.GD30031@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151958.GA31789@redhat.com>
	<CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
	<20111130145004.GD21413@redhat.com>
	<CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
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

On Thu, Dec 01, 2011 at 12:43:08AM +0200, Ohad Ben-Cohen wrote:
> On Wed, Nov 30, 2011 at 4:50 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > make headers_install
> > make -C tools/virtio/
> > (you'll need an empty stub for tools/virtio/linux/module.h,
> > =A0I just sent a patch to add that)
> > sudo insmod tools/virtio/vhost_test/vhost_test.ko
> > ./tools/virtio/virtio_test
> =

> Ok, I gave this a spin.
> =

> I've tried to see if reverting d57ed95 has any measurable effect on
> the execution time of virtio_test's run_test(), but I couldn't see any
> (several attempts with and without d57ed95 yielded very similar range
> of execution times).
> =

> YMMV though, especially with real workloads.
> =

> > Real virtualization/x86 can keep using current smp_XX barriers, right?
> =

> Yes, sure. ARM virtualization can too, since smp_XX barriers are
> enough for that scenario.
> =

> > We can have some config for your kind of setup.
> =

> Please note that it can't be a compile-time decision though (unless
> we're willing to effectively revert d57ed95 when this config kicks
> in): it's not unlikely that one would want to have both use cases
> running on the same time.
> =

> Thanks,
> Ohad.

For x86, stores into memory are ordered. So I think that yes, smp_XXX
can be selected at compile time.

So let's forget the virtio strangeness for a minute,

To me it starts looking like we need some new kind of barrier
that handles accesses to DMA coherent memory. dma_Xmb()?
dma_coherent_Xmb()?  For example, on x86, dma_wmb() can be barrier(),
but on your system it needs to do DSB.

We can set the rule that dma barriers are guaranteed stronger
than smp ones, and we can just use dma_ everywhere.
So the strength will be:

smp < dma < mandatory

And now virtio can use DMA barriers and instead of adding
overhead for x86, x86 will actually gain from this,
as we'll drop mandatory barriers on UP systems.

Hmm?

-- =

MST
