From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v6 1/2] sparc: fix a building error reported by kbuild
Date: Fri, 9 Dec 2016 22:58:51 +0100
Message-ID: <20161209215851.GA7717__33006.2706176706$1481320756$gmane$org@ravnborg.org>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>
Cc: xuquan8@huawei.com, weidong.huang@huawei.com, mst@redhat.com, qemu-devel@nongnu.org, wanzongshun@huawei.com, virtualization@lists.linux-foundation.org, jianjay.zhou@huawei.com, sparclinux@vger.kernel.org, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, herbert@gondor.apana.org.au, hanweidong@huawei.com, longpeng2@huawei.com, luonengjun@huawei.com, stefanha@redhat.com, claudio.fontana@huawei.com, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, davem@davemloft.net, wu.wubin@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Gonglei.

On Thu, Dec 08, 2016 at 12:37:08PM +0800, Gonglei wrote:
> >> arch/sparc/include/asm/topology_64.h:44:44:
> error: implicit declaration of function 'cpu_data'
> [-Werror=implicit-function-declaration]
> 
>  #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
>                                                ^
> Let's include cpudata.h in topology_64.h.
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  arch/sparc/include/asm/topology_64.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
> index 7b4898a..2255430 100644
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h
> @@ -4,6 +4,7 @@
>  #ifdef CONFIG_NUMA
>  
>  #include <asm/mmzone.h>
> +#include <asm/cpudata.h>

Nitpick - if you are going to resend this patch, then please
order the two includes in alphabetic order.

For two includes this looks like bikeshedding, but when we add
more having them in a defined arder prevents merge conflicts.
And makes it readable too.

We also sometimes order the includes with the longest lines topmost,
and lines with the ame length are ordered alphabetically.
But this is not seen so often.

	Sam
