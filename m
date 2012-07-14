From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [patch -next] tcm_vhost: another strlen() off by one
Date: Sat, 14 Jul 2012 15:21:59 -0700
Message-ID: <1342304519.18004.230.camel@haakon2.linux-iscsi.org>
References: <20120713104547.GA31435@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120713104547.GA31435@elgon.mountain>
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

On Fri, 2012-07-13 at 13:45 +0300, Dan Carpenter wrote:
> strlen() doesn't count the NUL terminator.  I missed this one in the
> patches I sent yesterday.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 29850cb..ea72198 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -1424,7 +1424,7 @@ static struct se_wwn *tcm_vhost_make_tport(
>  	return ERR_PTR(-EINVAL);
>  
>  check_len:
> -	if (strlen(name) > TCM_VHOST_NAMELEN) {
> +	if (strlen(name) >= TCM_VHOST_NAMELEN) {
>  		pr_err("Emulated %s Address: %s, exceeds"
>  			" max: %d\n", name, tcm_vhost_dump_proto_id(tport),
>  			TCM_VHOST_NAMELEN);

Applied + squashed into the initial merge commit in for-next-merge.

Thanks DanC!

--nab
