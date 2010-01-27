From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2] virtio: use smp_XX barriers on SMP
Date: Thu, 28 Jan 2010 10:01:09 +1030
Message-ID: <201001281001.09999.rusty@rustcorp.com.au>
References: <20100127224222.GA31545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100127224222.GA31545@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 28 Jan 2010 09:12:23 am Michael S. Tsirkin wrote:
> virtio is communicating with a virtual "device" that actually runs on
> another host processor. Thus SMP barriers can be used to control
> memory access ordering.
> 
> Where possible, we should use SMP barriers which are more lightweight than
> mandatory barriers, because mandatory barriers also control MMIO effects on
> accesses through relaxed memory I/O windows (which virtio does not use)
> (compare specifically smp_rmb and rmb on x86_64).

Xen had a similar issue, in that UP guests running on SMP hosts need to issue
SMP barriers.  Is this not also a requirement for virtio?

But I'm not sure what came out of the discussion: Jeremy?

Cheers,
Rusty.
