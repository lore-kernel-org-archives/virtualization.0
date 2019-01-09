From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio:linux:kernel:NULL check after kmalloc is  needed
Date: Wed, 9 Jan 2019 09:30:37 -0500
Message-ID: <20190109093026-mutt-send-email-mst__22100.5918960602$1547044121$gmane$org@kernel.org>
References: <1546926033-31684-1-git-send-email-wang.yi59@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1546926033-31684-1-git-send-email-wang.yi59@zte.com.cn>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yi Wang <wang.yi59@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xue.zhihong@zte.com.cn, "huang.zijiang" <huang.zijiang@zte.com.cn>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2019 at 01:40:33PM +0800, Yi Wang wrote:
> From: "huang.zijiang" <huang.zijiang@zte.com.cn>
> 
> NULL check is needed because kmalloc maybe return NULL.
> 
> Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>

Can't hurt I will queue it.

> ---
>  tools/virtio/linux/kernel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 7ef45a4..2afcad8 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -65,6 +65,8 @@ static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
>  	void *p = kmalloc(s, gfp);
>  
> +	if (!p)
> +		return -ENOMEM;
>  	memset(p, 0, s);
>  	return p;
>  }
> -- 
> 1.8.3.1
