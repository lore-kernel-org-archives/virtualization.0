From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Date: Mon, 15 Jun 2020 14:28:03 +0200
Message-ID: <CAJaqyWdwXMX0JGhmz6soH2ZLNdaH6HEdpBM8ozZzX9WUu8jGoQ@mail.gmail.com>
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <20200611152257.GA1798@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200611152257.GA1798@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 5:22 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Thu, Jun 11, 2020 at 07:34:19AM -0400, Michael S. Tsirkin wrote:
> > As testing shows no performance change, switch to that now.
>
> What kind of testing? 100GiB? Low latency?
>

Hi Konrad.

I tested this version of the patch:
https://lkml.org/lkml/2019/10/13/42

It was tested for throughput with DPDK's testpmd (as described in
http://doc.dpdk.org/guides/howto/virtio_user_as_exceptional_path.html)
and kernel pktgen. No latency tests were performed by me. Maybe it is
interesting to perform a latency test or just a different set of tests
over a recent version.

Thanks!
