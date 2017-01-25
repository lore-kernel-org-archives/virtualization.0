From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] virtio_net: fix PAGE_SIZE > 64k
Date: Tue, 24 Jan 2017 20:07:40 -0800
Message-ID: <CAADnVQ+ioJ7kgsFeFoSV9Nqnq9CkRGMmqS5QM66gsJG01-Rojw__4189.90076655081$1485632678$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: John Fastabend <john.fastabend@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 24, 2017 at 7:48 PM, John Fastabend
<john.fastabend@gmail.com> wrote:
>
> It is a concern on my side. I want XDP and Linux stack to work
> reasonably well together.

btw the micro benchmarks showed that page per packet approach
that xdp took in mlx4 should be 10% slower vs normal operation
for tcp/ip stack. We thought that for our LB use case
it will be an acceptable slowdown, but turned out that overall we
got a performance boost, since xdp model simplified user space
and got data path faster, so we magically got extra free cpu
that is used for other apps on the same host and overall
perf win despite extra overhead in tcp/ip.
Not all use cases are the same and not everyone will be as lucky,
so I'd like to see performance of xdp_pass improving too, though
it turned out to be not as high priority as I initially estimated.
