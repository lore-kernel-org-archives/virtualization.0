From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] vhost: Don't use defined in VHOST_ARCH_CAN_ACCEL_UACCESS
	definition
Date: Thu, 6 Jun 2019 13:06:23 -0700
Message-ID: <20190606200623.GA12580__43756.2157794432$1563994880$gmane$org@archlinux-epyc>
References: <20190606161223.67979-1-natechancellor@gmail.com>
	<20190606142606-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190606142606-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, clang-built-linux@googlegroups.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 06, 2019 at 02:28:55PM -0400, Michael S. Tsirkin wrote:
> I'd prefer just changing the definition.
> ifdefs have a disadvantage that it's easy to get
> wrong code if you forget to include a header.
> 
> I queued the below - pls confirm it works for you.

Fine by me, I figured that might be preferred (since clang will warn if
VHOST_ARCH_CAN_ACCEL_UACCESS is not defined so you'd know if the header
was forgotten). Thank you for the fix :)

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> 
> 
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index c5d950cf7627..819296332913 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -95,8 +95,11 @@ struct vhost_uaddr {
>  	bool write;
>  };
>  
> -#define VHOST_ARCH_CAN_ACCEL_UACCESS defined(CONFIG_MMU_NOTIFIER) && \
> -	ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE == 0
> +#if defined(CONFIG_MMU_NOTIFIER) && ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE == 0
> +#define VHOST_ARCH_CAN_ACCEL_UACCESS 1
> +#else
> +#define VHOST_ARCH_CAN_ACCEL_UACCESS 0
> +#endif
>  
>  /* The virtqueue structure describes a queue attached to a device. */
>  struct vhost_virtqueue {
