From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix per-vq MSI-X request logic
Date: Thu, 22 Oct 2009 14:17:18 -0200
Message-ID: <20091022161718.GA3876__19013.357620179$1256228479$gmane$org@amt.cnet>
References: <20091022130606.GA6923@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091022130606.GA6923@redhat.com>
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
Cc: xma@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 22, 2009 at 03:06:06PM +0200, Michael S. Tsirkin wrote:
> Commit f68d24082e22ccee3077d11aeb6dc5354f0ca7f1
> in 2.6.32-rc1 broke requesting IRQs for per-VQ MSI-X vectors:
> - vector number was used instead of the vector itself
> - we try to request an IRQ for VQ which does not
>   have a callback handler
> 
> This is a regression that causes warnings in kernel log,
> potentially lower performance as we need to scan vq list,
> and might cause system failure if the interrupt
> requested is in fact needed by another system.
> 
> This was not noticed earlier because in most cases
> we were falling back on shared interrupt for all vqs.

Works for me. Thanks Michael.

Tested-by: Marcelo Tosatti <mtosatti@redhat.com>
