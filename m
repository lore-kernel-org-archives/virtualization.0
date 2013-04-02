From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Use ACCESS_ONCE for vs->vs_tpg[target] access
Date: Tue, 2 Apr 2013 18:39:33 +0300
Message-ID: <20130402153933.GA27410__12873.5794489787$1364917158$gmane$org@redhat.com>
References: <1364916697-13212-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364916697-13212-1-git-send-email-asias@redhat.com>
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

On Tue, Apr 02, 2013 at 11:31:37PM +0800, Asias He wrote:
> In vhost_scsi_handle_vq:
> 
>       tv_tpg = vs->vs_tpg[target];
>       if (!tv_tpg) {
>               ....
>               return
>       }
> 
>       tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
> 
> 1) vs->vs_tpg[target] might change after the NULL check and 2) the above
> line might access tv_tpg from vs->vs_tpg[target]. To prevent 2), use
> ACCESS_ONCE. Thanks mst for catching this up!
> 
> Signed-off-by: Asias He <asias@redhat.com>

OK this might be ok for 3.9.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Nicholas can you pick this up pls?

For 3.10 I still think it's best to get rid of it
and stick vs->vs_tpg in vq->private_data.

> ---
>  drivers/vhost/tcm_vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 0524267..32d95e3 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -668,7 +668,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  
>  		/* Extract the tpgt */
>  		target = v_req.lun[1];
> -		tv_tpg = vs->vs_tpg[target];
> +		tv_tpg = ACCESS_ONCE(vs->vs_tpg[target]);
>  
>  		/* Target does not exist, fail the request */
>  		if (unlikely(!tv_tpg)) {
> -- 
> 1.8.1.4
