From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Mon, 12 Dec 2011 09:27:27 +1100
Message-ID: <1323642447.19891.8.camel@pasglop>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<1322867384.11728.20.camel@pasglop> <87hb1iqls3.fsf@rustcorp.com.au>
	<20111211122544.GC11504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111211122544.GC11504@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2011-12-11 at 14:25 +0200, Michael S. Tsirkin wrote:

> Forwarding some results by Amos, who run multiple netperf streams in
> parallel, from an external box to the guest.  TCP_STREAM results were
> noisy.  This could be due to buffering done by TCP, where packet size
> varies even as message size is constant.
> 
> TCP_RR results were consistent. In this benchmark, after switching
> to mandatory barriers, CPU utilization increased by up to 35% while
> throughput went down by up to 14%. the normalized throughput/cpu
> regressed consistently, between 7 and 35%
> 
> The "fix" applied was simply this:

What machine & processor was this  ?

Cheers,
Ben.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 3198f2e..fdccb77 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -23,7 +23,7 @@
>  
>  /* virtio guest is communicating with a virtual "device" that actually runs on
>   * a host processor.  Memory barriers are used to control SMP effects. */
> -#ifdef CONFIG_SMP
> +#if 0
>  /* Where possible, use SMP barriers which are more lightweight than mandatory
>   * barriers, because mandatory barriers control MMIO effects on accesses
>   * through relaxed memory I/O windows (which virtio does not use). */
> 
> 
> 
