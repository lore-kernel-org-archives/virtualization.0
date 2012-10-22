From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] virtio: 9p: correctly pass physical address to
	userspace for high pages
Date: Mon, 22 Oct 2012 15:05:30 -0700
Message-ID: <20121022150530.99caaecf.akpm@linux-foundation.org>
References: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
	<1350651813-8694-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350651813-8694-2-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Marc.Zyngier@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, ericvh@gmail.com, levinsasha928@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 19 Oct 2012 14:03:32 +0100
Will Deacon <will.deacon@arm.com> wrote:

> When using a virtio transport, the 9p net device may pass the physical
> address of a kernel buffer to userspace via a scatterlist inside a
> virtqueue. If the kernel buffer is mapped outside of the linear mapping
> (e.g. highmem), then virt_to_page will return a bogus value and we will
> populate the scatterlist with junk.
> 
> This patch uses kmap_to_page when populating the page array for a kernel
> buffer.
> 
> ...
>
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -39,6 +39,7 @@
>  #include <linux/inet.h>
>  #include <linux/idr.h>
>  #include <linux/file.h>
> +#include <linux/highmem.h>
>  #include <linux/slab.h>
>  #include <net/9p/9p.h>
>  #include <linux/parser.h>
> @@ -325,7 +326,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
>  		int count = nr_pages;
>  		while (nr_pages) {
>  			s = rest_of_page(data);
> -			pages[index++] = virt_to_page(data);
> +			pages[index++] = kmap_to_page(data);
>  			data += s;
>  			nr_pages--;

I am suspecting that this code has been busted for a while on x86
highmem, but nobody noticed.  True or false?  If "true" then I expect
that a -stable backport is appropriate?
