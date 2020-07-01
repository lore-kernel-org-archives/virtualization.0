From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Date: Wed, 1 Jul 2020 15:04:38 +0200
Message-ID: <CAJaqyWedEg9TBkH1MxGP1AecYHD-e-=ugJ6XUN+CWb=rQGf49g@mail.gmail.com>
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com> <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
 <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com>
 <20200622114622-mutt-send-email-mst@kernel.org> <CAJaqyWfrf94Gc-DMaXO+f=xC8eD3DVCD9i+x1dOm5W2vUwOcGQ@mail.gmail.com>
 <20200622122546-mutt-send-email-mst@kernel.org> <CAJaqyWfbouY4kEXkc6sYsbdCAEk0UNsS5xjqEdHTD7bcTn40Ow@mail.gmail.com>
 <CAJaqyWefMHPguj8ZGCuccTn0uyKxF9ZTEi2ASLtDSjGNb1Vwsg@mail.gmail.com> <419cc689-adae-7ba4-fe22-577b3986688c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <419cc689-adae-7ba4-fe22-577b3986688c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 1, 2020 at 2:40 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/1 =E4=B8=8B=E5=8D=886:43, Eugenio Perez Martin wrote:
> > On Tue, Jun 23, 2020 at 6:15 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> >> On Mon, Jun 22, 2020 at 6:29 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> >>> On Mon, Jun 22, 2020 at 06:11:21PM +0200, Eugenio Perez Martin wrote:
> >>>> On Mon, Jun 22, 2020 at 5:55 PM Michael S. Tsirkin <mst@redhat.com> =
wrote:
> >>>>> On Fri, Jun 19, 2020 at 08:07:57PM +0200, Eugenio Perez Martin wrot=
e:
> >>>>>> On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
> >>>>>> <eperezma@redhat.com> wrote:
> >>>>>>> On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> >>>>>>> <konrad.wilk@oracle.com> wrote:
> >>>>>>>> On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wro=
te:
> >>>>>>>>> As testing shows no performance change, switch to that now.
> >>>>>>>> What kind of testing? 100GiB? Low latency?
> >>>>>>>>
> >>>>>>> Hi Konrad.
> >>>>>>>
> >>>>>>> I tested this version of the patch:
> >>>>>>> https://lkml.org/lkml/2019/10/13/42
> >>>>>>>
> >>>>>>> It was tested for throughput with DPDK's testpmd (as described in
> >>>>>>> http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.=
html)
> >>>>>>> and kernel pktgen. No latency tests were performed by me. Maybe i=
t is
> >>>>>>> interesting to perform a latency test or just a different set of =
tests
> >>>>>>> over a recent version.
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>> I have repeated the tests with v9, and results are a little bit di=
fferent:
> >>>>>> * If I test opening it with testpmd, I see no change between versi=
ons
> >>>>>
> >>>>> OK that is testpmd on guest, right? And vhost-net on the host?
> >>>>>
> >>>> Hi Michael.
> >>>>
> >>>> No, sorry, as described in
> >>>> http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.htm=
l.
> >>>> But I could add to test it in the guest too.
> >>>>
> >>>> These kinds of raw packets "bursts" do not show performance
> >>>> differences, but I could test deeper if you think it would be worth
> >>>> it.
> >>> Oh ok, so this is without guest, with virtio-user.
> >>> It might be worth checking dpdk within guest too just
> >>> as another data point.
> >>>
> >> Ok, I will do it!
> >>
> >>>>>> * If I forward packets between two vhost-net interfaces in the gue=
st
> >>>>>> using a linux bridge in the host:
> >>>>> And here I guess you mean virtio-net in the guest kernel?
> >>>> Yes, sorry: Two virtio-net interfaces connected with a linux bridge =
in
> >>>> the host. More precisely:
> >>>> * Adding one of the interfaces to another namespace, assigning it an
> >>>> IP, and starting netserver there.
> >>>> * Assign another IP in the range manually to the other virtual net
> >>>> interface, and start the desired test there.
> >>>>
> >>>> If you think it would be better to perform then differently please l=
et me know.
> >>>
> >>> Not sure why you bother with namespaces since you said you are
> >>> using L2 bridging. I guess it's unimportant.
> >>>
> >> Sorry, I think I should have provided more context about that.
> >>
> >> The only reason to use namespaces is to force the traffic of these
> >> netperf tests to go through the external bridge. To test netperf
> >> different possibilities than the testpmd (or pktgen or others "blast
> >> of frames unconditionally" tests).
> >>
> >> This way, I make sure that is the same version of everything in the
> >> guest, and is a little bit easier to manage cpu affinity, start and
> >> stop testing...
> >>
> >> I could use a different VM for sending and receiving, but I find this
> >> way a faster one and it should not introduce a lot of noise. I can
> >> test with two VM if you think that this use of network namespace
> >> introduces too much noise.
> >>
> >> Thanks!
> >>
> >>>>>>    - netperf UDP_STREAM shows a performance increase of 1.8, almos=
t
> >>>>>> doubling performance. This gets lower as frame size increase.
> > Regarding UDP_STREAM:
> > * with event_idx=3Don: The performance difference is reduced a lot if
> > applied affinity properly (manually assigning CPU on host/guest and
> > setting IRQs on guest), making them perform equally with and without
> > the patch again. Maybe the batching makes the scheduler perform
> > better.
>
>
> Note that for UDP_STREAM, the result is pretty trick to be analyzed. E.g
> setting a sndbuf for TAP may help for the performance (reduce the drop).
>

Ok, will add that to the test. Thanks!

>
> >
> >>>>>>    - rests of the test goes noticeably worse: UDP_RR goes from ~63=
47
> >>>>>> transactions/sec to 5830
> > * Regarding UDP_RR, TCP_STREAM, and TCP_RR, proper CPU pinning makes
> > them perform similarly again, only a very small performance drop
> > observed. It could be just noise.
> > ** All of them perform better than vanilla if event_idx=3Doff, not sure
> > why. I can try to repeat them if you suspect that can be a test
> > failure.
> >
> > * With testpmd and event_idx=3Doff, if I send from the VM to host, I se=
e
> > a performance increment especially in small packets. The buf api also
> > increases performance compared with only batching: Sending the minimum
> > packet size in testpmd makes pps go from 356kpps to 473 kpps.
>
>
> What's your setup for this. The number looks rather low. I'd expected
> 1-2 Mpps at least.
>

Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz, 2 NUMA nodes of 16G memory
each, and no device assigned to the NUMA node I'm testing in. Too low
for testpmd AF_PACKET driver too?

>
> > Sending
> > 1024 length UDP-PDU makes it go from 570kpps to 64 kpps.
> >
> > Something strange I observe in these tests: I get more pps the bigger
> > the transmitted buffer size is. Not sure why.
> >
> > ** Sending from the host to the VM does not make a big change with the
> > patches in small packets scenario (minimum, 64 bytes, about 645
> > without the patch, ~625 with batch and batch+buf api). If the packets
> > are bigger, I can see a performance increase: with 256 bits,
>
>
> I think you meant bytes?
>

Yes, sorry.

>
> >   it goes
> > from 590kpps to about 600kpps, and in case of 1500 bytes payload it
> > gets from 348kpps to 528kpps, so it is clearly an improvement.
> >
> > * with testpmd and event_idx=3Don, batching+buf api perform similarly i=
n
> > both directions.
> >
> > All of testpmd tests were performed with no linux bridge, just a
> > host's tap interface (<interface type=3D'ethernet'> in xml),
>
>
> What DPDK driver did you use in the test (AF_PACKET?).
>

Yes, both testpmd are using AF_PACKET driver.

>
> > with a
> > testpmd txonly and another in rxonly forward mode, and using the
> > receiving side packets/bytes data. Guest's rps, xps and interrupts,
> > and host's vhost threads affinity were also tuned in each test to
> > schedule both testpmd and vhost in different processors.
>
>
> My feeling is that if we start from simple setup, it would be more
> easier as a start. E.g start without an VM.
>
> 1) TX: testpmd(txonly) -> virtio-user -> vhost_net -> XDP_DROP on TAP
> 2) RX: pkgetn -> TAP -> vhost_net -> testpmd(rxonly)
>

Got it. Is there a reason to prefer pktgen over testpmd?

> Thanks
>
>
> >
> > I will send the v10 RFC with the small changes requested by Stefan and =
Jason.
> >
> > Thanks!
> >
> >
> >
> >
> >
> >
> >
> >>>>> OK so it seems plausible that we still have a bug where an interrup=
t
> >>>>> is delayed. That is the main difference between pmd and virtio.
> >>>>> Let's try disabling event index, and see what happens - that's
> >>>>> the trickiest part of interrupts.
> >>>>>
> >>>> Got it, will get back with the results.
> >>>>
> >>>> Thank you very much!
> >>>>
> >>>>>
> >>>>>>    - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
> >>>>>>    - TCP_RR from 6223.64 transactions/sec to 5739.44
>
