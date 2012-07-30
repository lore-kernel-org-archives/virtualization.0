From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V4 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 30 Jul 2012 11:25:51 +0930
Message-ID: <87a9yim2qg.fsf@rustcorp.com.au>
References: <1343442065-15646-1-git-send-email-asias@redhat.com>
	<1343442065-15646-4-git-send-email-asias@redhat.com>
	<20120729111115.GD8977@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120729111115.GD8977@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 29 Jul 2012 14:11:15 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Sat, Jul 28, 2012 at 10:21:05AM +0800, Asias He wrote:
> > This patch introduces bio-based IO path for virtio-blk.
> > 
> > Compared to request-based IO path, bio-based IO path uses driver
> > provided ->make_request_fn() method to bypasses the IO scheduler. It
> > handles the bio to device directly without allocating a request in block
> > layer. This reduces the IO path in guest kernel to achieve high IOPS
> > and lower latency. The downside is that guest can not use the IO
> > scheduler to merge and sort requests. However, this is not a big problem
> > if the backend disk in host side uses faster disk device.
> 
> If this optimization depends on the host, then it
> should be reported to the guest using a feature bit,
> as opposed to being guest driven.

I consider this approach a half-way step.  Quick attempts on my laptop
and I couldn't find a case where the bio path was a loss, but in theory
if the host wasn't doing any reordering and it was a slow device, you'd
want the guest to do so.

I'm not sure if current qemu can be configured to do such a thing?

Cheers,
Rusty.
