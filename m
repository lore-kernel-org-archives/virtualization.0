From: Gonglei <arei.gonglei@huawei.com>
Subject: Re: [PATCH] vhost-scsi: introduce an ioctl to get the minimum tpgt
Date: Fri, 30 Jan 2015 20:19:52 +0800
Message-ID: <54CB76E8.9000300__16921.2917368442$1422660844$gmane$org@huawei.com>
References: <1422277998-6308-1-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1422277998-6308-1-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "Subo (A)" <subo7@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2015/1/26 21:13, Gonglei (Arei) wrote:

> From: Gonglei <arei.gonglei@huawei.com>
> 
> In order to support to assign a boot order for
> vhost-scsi device, we should get the tpgt for
> user level (such as Qemu). and at present, we
> only support the minimum tpgt can boot.
> 

Ping...

> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Bo Su <subo7@huawei.com>
> ---
>  drivers/vhost/scsi.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index d695b16..12e79b9 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1522,6 +1522,38 @@ err_dev:
>  	return ret;
>  }
>  
> +static int vhost_scsi_get_first_tpgt(
> +		struct vhost_scsi *vs,
> +		struct vhost_scsi_target *t)
> +{
> +	struct tcm_vhost_tpg *tv_tpg;
> +	struct tcm_vhost_tport *tv_tport;
> +	int tpgt = -1;
> +
> +	mutex_lock(&tcm_vhost_mutex);
> +	mutex_lock(&vs->dev.mutex);
> +
> +	list_for_each_entry(tv_tpg, &tcm_vhost_list, tv_tpg_list) {
> +		tv_tport = tv_tpg->tport;
> +
> +		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
> +			if (tpgt < 0)
> +				tpgt = tv_tpg->tport_tpgt;
> +			else if (tpgt > tv_tpg->tport_tpgt)
> +				tpgt = tv_tpg->tport_tpgt;
> +		}
> +	}
> +
> +	mutex_unlock(&vs->dev.mutex);
> +	mutex_unlock(&tcm_vhost_mutex);
> +
> +	if (tpgt < 0)
> +		return -ENXIO;
> +
> +	t->vhost_tpgt = tpgt;
> +	return 0;
> +}
> +
>  static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
>  {
>  	struct vhost_virtqueue *vq;
> @@ -1657,6 +1689,15 @@ vhost_scsi_ioctl(struct file *f,
>  		if (put_user(events_missed, eventsp))
>  			return -EFAULT;
>  		return 0;
> +	case VHOST_SCSI_GET_TPGT:
> +		if (copy_from_user(&backend, argp, sizeof(backend)))
> +			return -EFAULT;
> +		r = vhost_scsi_get_first_tpgt(vs, &backend);
> +		if (r < 0)
> +			return r;
> +		if (copy_to_user(argp, &backend, sizeof(backend)))
> +			return -EFAULT;
> +		return 0;
>  	case VHOST_GET_FEATURES:
>  		features = VHOST_SCSI_FEATURES;
>  		if (copy_to_user(featurep, &features, sizeof features))
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index bb6a5b4..5d350f7 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -155,4 +155,6 @@ struct vhost_scsi_target {
>  #define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, __u32)
>  #define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, __u32)
>  
> +#define VHOST_SCSI_GET_TPGT _IOW(VHOST_VIRTIO, 0x45, struct vhost_scsi_target)
> +
>  #endif
