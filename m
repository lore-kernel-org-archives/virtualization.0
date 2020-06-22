From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Date: Mon, 22 Jun 2020 12:44:17 +0200
Message-ID: <CAJaqyWdo1J-EoGUj3e2jM6USo0SEOM3xydoaYMhta0Y_YPyS_g@mail.gmail.com>
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com> <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
 <CAJaqyWdwgy0fmReOgLfL4dAv-E+5k_7z3d9M+vHqt0aO2SmOFg@mail.gmail.com> <b6347dad-89e8-61f6-6394-65c301f91dd7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b6347dad-89e8-61f6-6394-65c301f91dd7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 22, 2020 at 11:07 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/20 =E4=B8=8A=E5=8D=882:07, Eugenio Perez Martin wrote:
> > On Mon, Jun 15, 2020 at 2:28 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> >> On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
> >> <konrad.wilk@oracle.com> wrote:
> >>> On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> >>>> As testing shows no performance change, switch to that now.
> >>> What kind of testing? 100GiB? Low latency?
> >>>
> >> Hi Konrad.
> >>
> >> I tested this version of the patch:
> >> https://lkml.org/lkml/2019/10/13/42
> >>
> >> It was tested for throughput with DPDK's testpmd (as described in
> >> http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
> >> and kernel pktgen. No latency tests were performed by me. Maybe it is
> >> interesting to perform a latency test or just a different set of tests
> >> over a recent version.
> >>
> >> Thanks!
> > I have repeated the tests with v9, and results are a little bit differe=
nt:
> > * If I test opening it with testpmd, I see no change between versions
> > * If I forward packets between two vhost-net interfaces in the guest
> > using a linux bridge in the host:
> >    - netperf UDP_STREAM shows a performance increase of 1.8, almost
> > doubling performance. This gets lower as frame size increase.
> >    - rests of the test goes noticeably worse: UDP_RR goes from ~6347
> > transactions/sec to 5830
> >    - TCP_STREAM goes from ~10.7 gbps to ~7Gbps
>
>
> Which direction did you mean here? Guest TX or RX?

Hi Jason.

For both I created a linux bridge in the host, attach two guest
interfaces with vhost-net, and make the netperf run on them.

>
>
> >    - TCP_RR from 6223.64 transactions/sec to 5739.44
>
>
> Perf diff might help. I think we can start from the RR result which
> should be easier. Maybe you can test it for each patch then you may see
> which patch is the source of the regression.
>

Ok, I will look for differences.

Thanks!

> Thanks
>
