From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [patch 3/3 -next] tcm_vhost: call kfree() on an error path
Date: Thu, 12 Jul 2012 14:49:22 -0700
Message-ID: <1342129762.18004.101.camel__27147.8760907941$1342129771$gmane$org@haakon2.linux-iscsi.org>
References: <20120712144852.GF24202@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120712144852.GF24202@elgon.mountain>
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
Cc: target-devel <target-devel@vger.kernel.org>, virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-07-12 at 17:48 +0300, Dan Carpenter wrote:
> There is a memory leak here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 57d39c5..29850cb 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -1420,6 +1420,7 @@ static struct se_wwn *tcm_vhost_make_tport(
>  
>  	pr_err("Unable to locate prefix for emulated Target Port:"
>  			" %s\n", name);
> +	kfree(tport);
>  	return ERR_PTR(-EINVAL);
>  
>  check_len:

Applied to for-next-merge, and folding the series into the initial merge
commit now..

Thank you!

--nab
