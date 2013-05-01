From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add vhost_scsi as an alias for tcm_vhost
Date: Wed, 1 May 2013 09:42:22 +0300
Message-ID: <20130501064222.GA15084@redhat.com>
References: <1367034129-31214-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1367034129-31214-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 27, 2013 at 11:42:09AM +0800, Asias He wrote:
> Signed-off-by: Asias He <asias@redhat.com>


Nicholas, thoughts?
How about we move tcm_vhost.c to scsi.c
call module vhost_scsi and add tcm_vhost as an alias?
If not - want this alias in?

> ---
>  drivers/vhost/tcm_vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 1677238..bddc39a 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -1928,5 +1928,6 @@ static void tcm_vhost_exit(void)
>  
>  MODULE_DESCRIPTION("TCM_VHOST series fabric driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("vhost_scsi");
>  module_init(tcm_vhost_init);
>  module_exit(tcm_vhost_exit);
> -- 
> 1.8.1.4
