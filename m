From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] tools/virtio: more stubs
Date: Fri, 19 Dec 2014 11:58:59 +1030
Message-ID: <87ppbgsa04.fsf@rustcorp.com.au>
References: <1418594542-22623-1-git-send-email-mst@redhat.com>
	<1418594542-22623-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418594542-22623-2-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> As usual, add more stubs to fix test build after main
> codebase changes.

This doesn't apply, since:

> diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
> index dafe1c9..806d683 100644
> --- a/tools/virtio/linux/virtio_config.h
> +++ b/tools/virtio/linux/virtio_config.h
> @@ -1,8 +1,7 @@
>  #include <linux/virtio_byteorder.h>
>  #include <linux/virtio.h>
> +#include <uapi/linux/virtio_config.h>
>  
> -#define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		32
>  /*

Version in master has no headers in this file.

What's this based on?

Thanks,
Rusty.
