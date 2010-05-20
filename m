From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Thu, 20 May 2010 13:04:47 +0300
Message-ID: <20100520100447.GC5717__18609.7273290672$1274350180$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com>
	<201005191709.16401.rusty@rustcorp.com.au>
	<4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005201431.51142.rusty@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 20, 2010 at 02:31:50PM +0930, Rusty Russell wrote:
> Can we do better?  The obvious idea is to try to get rid of last_used and
> used, and use the ring itself.  We would use an invalid entry to mark the
> head of the ring.
> 
> Any other thoughts?
> Rusty.

We also need a way to avoid interrupts at least while we are
processing the ring.

-- 
MST
