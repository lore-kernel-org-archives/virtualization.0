From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] vhost: remove unneeded linux/miscdevice.h include
Date: Sat, 20 Apr 2019 20:05:22 +0200
Message-ID: <20190420180522.GC19319__12136.3966771$1555783601$gmane$org@Red>
References: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 18, 2017 at 06:58:54PM +0200, Corentin Labbe wrote:
> drivers/vhost/vhost.c does not use any miscdevice, so this patch
> remove this unnecessary inclusion.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/vhost/vhost.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 33ac2b186b85..33ab839696f9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -16,7 +16,6 @@
>  #include <linux/uio.h>
>  #include <linux/mm.h>
>  #include <linux/mmu_context.h>
> -#include <linux/miscdevice.h>
>  #include <linux/mutex.h>
>  #include <linux/poll.h>
>  #include <linux/file.h>
> -- 
> 2.13.5
> 

Hello

gentle ping

Regards
