From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Wed, 19 May 2010 11:06:42 +0300
Message-ID: <4BF39C12.7090407@redhat.com>
References: <20100505205814.GA7090@redhat.com>
	<201005071253.53393.rusty@rustcorp.com.au>
	<4BE9AF9A.8080005@redhat.com>
	<201005191709.16401.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201005191709.16401.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/19/2010 10:39 AM, Rusty Russell wrote:
>
> I think we're talking about the last 2 entries of the avail ring.  That means
> the worst case is 1 false bounce every time around the ring.

It's low, but why introduce an inefficiency when you can avoid doing it 
for the same effort?

> I think that's
> why we're debating it instead of measuring it :)
>    

Measure before optimize is good for code but not for protocols.  
Protocols have to be robust against future changes.  Virtio is warty 
enough already, we can't keep doing local optimizations.

> Note that this is a exclusive->shared->exclusive bounce only, too.
>    

A bounce is a bounce.

Virtio is already way too bouncy due to the indirection between the 
avail/used rings and the descriptor pool.  A device with out of order 
completion (like virtio-blk) will quickly randomize the unused 
descriptor indexes, so every descriptor fetch will require a bounce.

In contrast, if the rings hold the descriptors themselves instead of 
pointers, we bounce (sizeof(descriptor)/cache_line_size) cache lines for 
every descriptor, amortized.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
