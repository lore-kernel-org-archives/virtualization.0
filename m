From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH v2 33/34] xenbus: use virt_xxx barriers
Date: Mon, 4 Jan 2016 12:03:11 +0000
Message-ID: <alpine.DEB.2.02.1601041201120.19710__268.891049972986$1451909059$gmane$org@kaball.uk.xensource.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-34-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451572003-2440-34-git-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, linuxp
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 31 Dec 2015, Michael S. Tsirkin wrote:
> drivers/xen/xenbus/xenbus_comms.c uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Are you also going to take care of

drivers/xen/grant-table.c
drivers/xen/evtchn.c
drivers/xen/events/events_fifo.c
drivers/xen/xen-scsiback.c
drivers/xen/tmem.c
drivers/xen/xen-pciback/pci_stub.c
drivers/xen/xen-pciback/pciback_ops.c

?


>  drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index fdb0f33..ecdecce 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must write data /after/ reading the consumer index. */
> -		mb();
> +		virt_mb();
>  
>  		memcpy(dst, data, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see new producer until data is there. */
> -		wmb();
> +		virt_wmb();
>  		intf->req_prod += avail;
>  
>  		/* Implies mb(): other side will see the updated producer. */
> @@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must read data /after/ reading the producer index. */
> -		rmb();
> +		virt_rmb();
>  
>  		memcpy(data, src, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see free space until we've copied out */
> -		mb();
> +		virt_mb();
>  		intf->rsp_cons += avail;
>  
>  		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
> -- 
> MST
> 
