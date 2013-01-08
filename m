From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: (unknown)
Date: Tue, 8 Jan 2013 08:52:54 +0200
Message-ID: <20130108065254.GG11305@redhat.com>
References: <1357454173-5973-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1357454173-5973-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 06, 2013 at 02:36:13PM +0800, Asias He wrote:
> This drops the cmd completion list spin lock and makes the cmd
> completion queue lock-less.
> 
> Signed-off-by: Asias He <asias@redhat.com>


Nicholas, any feedback?

> ---
>  drivers/vhost/tcm_vhost.c | 46 +++++++++++++---------------------------------
>  drivers/vhost/tcm_vhost.h |  2 +-
>  2 files changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index b20df5c..3720604 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -47,6 +47,7 @@
>  #include <linux/vhost.h>
>  #include <linux/virtio_net.h> /* TODO vhost.h currently depends on this */
>  #include <linux/virtio_scsi.h>
> +#include <linux/llist.h>
>  
>  #include "vhost.c"
>  #include "vhost.h"
> @@ -64,8 +65,7 @@ struct vhost_scsi {
>  	struct vhost_virtqueue vqs[3];
>  
>  	struct vhost_work vs_completion_work; /* cmd completion work item */
> -	struct list_head vs_completion_list;  /* cmd completion queue */
> -	spinlock_t vs_completion_lock;        /* protects s_completion_list */
> +	struct llist_head vs_completion_list; /* cmd completion queue */
>  };
>  
>  /* Local pointer to allocated TCM configfs fabric module */
> @@ -301,9 +301,7 @@ static void vhost_scsi_complete_cmd(struct tcm_vhost_cmd *tv_cmd)
>  {
>  	struct vhost_scsi *vs = tv_cmd->tvc_vhost;
>  
> -	spin_lock_bh(&vs->vs_completion_lock);
> -	list_add_tail(&tv_cmd->tvc_completion_list, &vs->vs_completion_list);
> -	spin_unlock_bh(&vs->vs_completion_lock);
> +	llist_add(&tv_cmd->tvc_completion_list, &vs->vs_completion_list);
>  
>  	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
>  }
> @@ -347,27 +345,6 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
>  	kfree(tv_cmd);
>  }
>  
> -/* Dequeue a command from the completion list */
> -static struct tcm_vhost_cmd *vhost_scsi_get_cmd_from_completion(
> -	struct vhost_scsi *vs)
> -{
> -	struct tcm_vhost_cmd *tv_cmd = NULL;
> -
> -	spin_lock_bh(&vs->vs_completion_lock);
> -	if (list_empty(&vs->vs_completion_list)) {
> -		spin_unlock_bh(&vs->vs_completion_lock);
> -		return NULL;
> -	}
> -
> -	list_for_each_entry(tv_cmd, &vs->vs_completion_list,
> -			    tvc_completion_list) {
> -		list_del(&tv_cmd->tvc_completion_list);
> -		break;
> -	}
> -	spin_unlock_bh(&vs->vs_completion_lock);
> -	return tv_cmd;
> -}
> -
>  /* Fill in status and signal that we are done processing this command
>   *
>   * This is scheduled in the vhost work queue so we are called with the owner
> @@ -377,12 +354,18 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  {
>  	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
>  					vs_completion_work);
> +	struct virtio_scsi_cmd_resp v_rsp;
>  	struct tcm_vhost_cmd *tv_cmd;
> +	struct llist_node *llnode;
> +	struct se_cmd *se_cmd;
> +	int ret;
>  
> -	while ((tv_cmd = vhost_scsi_get_cmd_from_completion(vs))) {
> -		struct virtio_scsi_cmd_resp v_rsp;
> -		struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> -		int ret;
> +	llnode = llist_del_all(&vs->vs_completion_list);
> +	while (llnode) {
> +		tv_cmd = llist_entry(llnode, struct tcm_vhost_cmd,
> +				     tvc_completion_list);
> +		llnode = llist_next(llnode);
> +		se_cmd = &tv_cmd->tvc_se_cmd;
>  
>  		pr_debug("%s tv_cmd %p resid %u status %#02x\n", __func__,
>  			tv_cmd, se_cmd->residual_count, se_cmd->scsi_status);
> @@ -426,7 +409,6 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
>  		pr_err("Unable to allocate struct tcm_vhost_cmd\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	INIT_LIST_HEAD(&tv_cmd->tvc_completion_list);
>  	tv_cmd->tvc_tag = v_req->tag;
>  	tv_cmd->tvc_task_attr = v_req->task_attr;
>  	tv_cmd->tvc_exp_data_len = exp_data_len;
> @@ -859,8 +841,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  		return -ENOMEM;
>  
>  	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
> -	INIT_LIST_HEAD(&s->vs_completion_list);
> -	spin_lock_init(&s->vs_completion_lock);
>  
>  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
>  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> index 7e87c63..47ee80b 100644
> --- a/drivers/vhost/tcm_vhost.h
> +++ b/drivers/vhost/tcm_vhost.h
> @@ -34,7 +34,7 @@ struct tcm_vhost_cmd {
>  	/* Sense buffer that will be mapped into outgoing status */
>  	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
>  	/* Completed commands list, serviced from vhost worker thread */
> -	struct list_head tvc_completion_list;
> +	struct llist_node tvc_completion_list;
>  };
>  
>  struct tcm_vhost_nexus {
> -- 
> 1.7.11.7
