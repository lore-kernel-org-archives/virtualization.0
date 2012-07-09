From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: add back VIRTIO_BLK_F_FLUSH
Date: Mon, 09 Jul 2012 09:41:50 +0930
Message-ID: <87k3yd3i9l.fsf__19076.2202292264$1341794420$gmane$org@rustcorp.com.au>
References: <1341482902-13318-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1341482902-13318-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: levinsasha928@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  5 Jul 2012 12:08:22 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The old name is part of the userspace API, add it back for compatibility.
> 
> Reported-by: Sasha Levin <levinsasha928@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/linux/virtio_blk.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
> index 18a1027..83a3116 100644
> --- a/include/linux/virtio_blk.h
> +++ b/include/linux/virtio_blk.h
> @@ -41,6 +41,9 @@
>  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
>  #define VIRTIO_BLK_F_CONFIG_WCE	11	/* Writeback mode available in config */
>  
> +/* Backwards-compatibility #defines for renamed features.  */
> +#define VIRTIO_BLK_F_FLUSH	VIRTIO_BLK_F_WCE

Please #ifndef __KERNEL__?

Thanks,
Rusty.
