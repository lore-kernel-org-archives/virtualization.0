From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [patch] vhost: NULL vs ERR_PTR bug
Date: Wed, 15 Jul 2015 14:28:46 +0300
Message-ID: <20150715142420-mutt-send-email-mst__8900.54101259938$1436959745$gmane$org@redhat.com>
References: <20150715111659.GA22854@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150715111659.GA22854@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>, kernel-janitors@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2015 at 02:16:59PM +0300, Dan Carpenter wrote:
> There is only one caller for vhost_kvzalloc() and it expects NULL on
> allocation failure.  Most people would probably expect that so let's
> change ERR_PTR(-ENOMEM) to NULL.
> 
> Fixes: 4de7255f7d2b ('vhost: extend memory regions allocation to vmalloc')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ouch. Thanks a lot for noticing this, and it's a good thing
you did before Linus merged it.
I'll squash this into Igor's patch and redo my pull request.

> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a9fe859..99d613b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -686,7 +686,7 @@ static void *vhost_kvzalloc(unsigned long size)
>  	if (!n) {
>  		n = vzalloc(size);
>  		if (!n)
> -			return ERR_PTR(-ENOMEM);
> +			return NULL;
>  	}
>  	return n;
>  }
