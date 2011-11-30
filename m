From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Wed, 30 Nov 2011 16:50:04 +0200
Message-ID: <20111130145004.GD21413@redhat.com>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<20111129131110.GC19157@redhat.com>
	<CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
	<20111129151958.GA31789@redhat.com>
	<CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
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

On Wed, Nov 30, 2011 at 01:55:53PM +0200, Ohad Ben-Cohen wrote:
> On Tue, Nov 29, 2011 at 5:19 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Nov 29, 2011 at 03:57:19PM +0200, Ohad Ben-Cohen wrote:
> >> > Is an extra branch faster or slower than reverting d57ed95?
> >>
> >> Sorry, unfortunately I have no way to measure this, as I don't have
> >> any virtualization/x86 setup. I'm developing on ARM SoCs, where
> >> virtualization hardware is coming, but not here yet.
> >
> > You can try using the micro-benchmark in tools/virtio/.
> 
> Hmm, care to show me exactly what do you mean ?

make headers_install
make -C tools/virtio/
(you'll need an empty stub for tools/virtio/linux/module.h,
 I just sent a patch to add that)
sudo insmod tools/virtio/vhost_test/vhost_test.ko
./tools/virtio/virtio_test

> Though I somewhat suspect that any micro-benchmarking I'll do with my
> random ARM SoC will not have much value to real virtualization/x86
> workloads.
> 
> Thanks,
> Ohad.

Real virtualization/x86 can keep using current smp_XX barriers, right?
We can have some config for your kind of setup.

-- 
MST
