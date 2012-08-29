From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Wed, 29 Aug 2012 14:07:48 +0300
Message-ID: <20120829110748.GB5970@redhat.com>
References: <1346159043-16446-1-git-send-email-levinsasha928@gmail.com>
	<1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120828132032.GB2039@redhat.com> <503CC904.3050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <503CC904.3050207@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: avi@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 28, 2012 at 03:35:00PM +0200, Sasha Levin wrote:
> On 08/28/2012 03:20 PM, Michael S. Tsirkin wrote:
> > On Tue, Aug 28, 2012 at 03:04:03PM +0200, Sasha Levin wrote:
> >> Currently if VIRTIO_RING_F_INDIRECT_DESC is enabled we will
> >> use indirect descriptors and allocate them using a simple
> >> kmalloc().
> >>
> >> This patch adds a cache which will allow indirect buffers under
> >> a configurable size to be allocated from that cache instead.
> >>
> >> Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
> > 
> > I imagine this helps performance? Any numbers?
> 
> I ran benchmarks on the original RFC, I've re-tested it now and got similar
> numbers to the original ones (virtio-net using vhost-net, thresh=16):
> 
> Before:
> 	Recv   Send    Send
> 	Socket Socket  Message  Elapsed
> 	Size   Size    Size     Time     Throughput
> 	bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 	 87380  16384  16384    10.00    4512.12
> 
> After:
> 	Recv   Send    Send
> 	Socket Socket  Message  Elapsed
> 	Size   Size    Size     Time     Throughput
> 	bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 	 87380  16384  16384    10.00    5399.18
> 
> 
> Thanks,
> Sasha

This is with both patches 1 + 2?
Sorry could you please also test what happens if you apply
- just patch 1
- just patch 2

Thanks!
