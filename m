From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] tools/virtio: virtio_test tool
Date: Mon, 6 Dec 2010 15:23:02 +1030
Message-ID: <201012061523.03108.rusty__45349.7399030768$1291611250$gmane$org@rustcorp.com.au>
References: <20101129170431.GA4027@redhat.com>
	<20101129171637.GC4027@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101129171637.GC4027@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 30 Nov 2010 03:46:37 am Michael S. Tsirkin wrote:
> This is the userspace part of the tool: it includes a bunch of stubs for
> linux APIs, somewhat simular to linuxsched. This makes it possible to
> recompile the ring code in userspace.
> 
> A small test example is implemented combining this with vhost_test
> module.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi Michael,

  I'm not sure what the point is of this work?  You'll still need to
benchmark on real systems, but it's not low-level enough to measure
things like cache misses.

I'm assuming you're thinking of playing with layout to measure cache
behaviour.  I was thinking of a complete userspace implementation where
either it was run under cachegrind, or each access was wrapped to allow
tracking of cachelines to give an exact measure of cache movement under
various scenarios (esp. ring mostly empty, ring in steady state, ring
mostly full).

Cheers,
Rusty.
