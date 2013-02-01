From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Multi-target support
Date: Fri, 01 Feb 2013 11:58:43 +0800
Message-ID: <510B3D73.3010503@redhat.com>
References: <1359617636-20339-1-git-send-email-asias@redhat.com>
	<510A3935.2030604@redhat.com> <20130131111355.GC520@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130131111355.GC520@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/31/2013 07:13 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2013 at 05:28:21PM +0800, Asias He wrote:
>> Hello Nicholas,
>>
>> On 01/31/2013 03:33 PM, Asias He wrote:
>>> In order to take advantages of Paolo's multi-queue virito-scsi, we need
>>> multi-target support in tcm_vhost first. Otherwise all the requests go
>>> to one queue and other queues are idle.
>>>
>>> This patch makes:
>>>
>>> 1. All the targets under the wwpn is seen and can be used by guest.
>>> 2. No need to pass the tpgt number in struct vhost_scsi_target to
>>>    tcm_vhost.ko. Only wwpn is needed.
>>> 3. We can always pass max_target = 255 to guest now, since we abort the
>>>    request who's target id does not exist.
>>>
>>> Signed-off-by: Asias He <asias@redhat.com>
>>> ---
>>>  drivers/vhost/tcm_vhost.c | 115 ++++++++++++++++++++++++++++------------------
>>>  drivers/vhost/tcm_vhost.h |   4 +-
>>>  2 files changed, 74 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
>>> index 218deb6..d50cb95 100644
>>> --- a/drivers/vhost/tcm_vhost.c
>>> +++ b/drivers/vhost/tcm_vhost.c
>>> @@ -59,13 +59,18 @@ enum {
>>>  	VHOST_SCSI_VQ_IO = 2,
>>>  };
>>>  
>>> +#define VHOST_SCSI_MAX_TARGET 256
>>> +
>>>  struct vhost_scsi {
>>> -	struct tcm_vhost_tpg *vs_tpg;	/* Protected by vhost_scsi->dev.mutex */
>>> +	/* Protected by vhost_scsi->dev.mutex */
>>> +	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
>>>  	struct vhost_dev dev;
>>>  	struct vhost_virtqueue vqs[3];
>>>  
>>>  	struct vhost_work vs_completion_work; /* cmd completion work item */
>>>  	struct llist_head vs_completion_list; /* cmd completion queue */
>>> +	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
>>> +	int vs_num_target;
>>>  };
>>>  
>>>  /* Local pointer to allocated TCM configfs fabric module */
>>> @@ -564,13 +569,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
>>>  	u32 exp_data_len, data_first, data_num, data_direction;
>>>  	unsigned out, in, i;
>>>  	int head, ret;
>>> -
>>> -	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
>>> -	tv_tpg = vs->vs_tpg;
>>> -	if (unlikely(!tv_tpg)) {
>>> -		pr_err("%s endpoint not set\n", __func__);
>>> -		return;
>>> -	}
>>> +	u8 target;
>>>  
>>>  	mutex_lock(&vq->mutex);
>>>  	vhost_disable_notify(&vs->dev, vq);
>>> @@ -637,6 +636,35 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
>>>  			break;
>>>  		}
>>>  
>>> +		/* Extract the tpgt */
>>> +		target = v_req.lun[1];
>>> +
>>> +		/* Target does not exit, fail the request */
>>> +		if (unlikely(target >= vs->vs_num_target)) {
>>> +			struct virtio_scsi_cmd_resp __user *resp;
>>> +			struct virtio_scsi_cmd_resp rsp;
>>> +
>>> +			memset(&rsp, 0, sizeof(rsp));
>>> +			rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
>>> +			resp = vq->iov[out].iov_base;
>>> +			ret = copy_to_user(resp, &rsp, sizeof(rsp));
>>> +			if (!ret)
>>> +				vhost_add_used_and_signal(&vs->dev,
>>> +						&vs->vqs[2], head, 0);
>>> +			else
>>> +				pr_err("Faulted on virtio_scsi_cmd_resp\n");
>>> +
>>> +			continue;
>>> +		}
>>> +
>>> +		tv_tpg = vs->vs_tpg[target];
>>> +		if (unlikely(!tv_tpg)) {
>>> +			/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
>>> +			pr_err("endpoint not set, target = %d\n", target);
>>> +			vhost_discard_vq_desc(vq, 1);
>>> +			break;
>>> +		}
>>> +
>>>  		exp_data_len = 0;
>>>  		for (i = 0; i < data_num; i++)
>>>  			exp_data_len += vq->iov[data_first + i].iov_len;
>>> @@ -771,14 +799,11 @@ static int vhost_scsi_set_endpoint(
>>>  		}
>>>  		tv_tport = tv_tpg->tport;
>>>  
>>> -		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn) &&
>>> -		    (tv_tpg->tport_tpgt == t->vhost_tpgt)) {
>>> +		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
>>>  			tv_tpg->tv_tpg_vhost_count++;
>>> -			mutex_unlock(&tv_tpg->tv_tpg_mutex);
>>> -			mutex_unlock(&tcm_vhost_mutex);
>>>  
>>>  			mutex_lock(&vs->dev.mutex);
>>> -			if (vs->vs_tpg) {
>>> +			if (vs->vs_tpg[tv_tpg->tport_tpgt - 1]) {
>>>  				mutex_unlock(&vs->dev.mutex);
>>>  				mutex_lock(&tv_tpg->tv_tpg_mutex);
>>>  				tv_tpg->tv_tpg_vhost_count--;
>>> @@ -786,15 +811,17 @@ static int vhost_scsi_set_endpoint(
>>>  				return -EEXIST;
>>>  			}
>>>  
>>> -			vs->vs_tpg = tv_tpg;
>>> +			vs->vs_tpg[tv_tpg->tport_tpgt - 1] = tv_tpg;
>>
>>
>> tv_tpg->tport_tpgt starts from 0, right? I thought it starts from 1,
>> because I always got it starts from 1 in targetcli.
>>
>> o- vhost
>>    o- naa.6001405bd4e8476d
>>       o- tpg1
>>          o- luns
>>             o- lun0
>>       o- tpg2
>>          o- luns
>>             o- lun0
>>       o- tpg3
>>          o- luns
>>             o- lun0
>>       o- tpg4
>>          o- luns
>>             o- lun0
>>
>> If it is true. I will cook v2 of this patch.
>>
>> Also, the tv_tpg->tport_tpgt can be none-continuous. e.g.
>>
>> o- vhost
>>    o- naa.6001405bd4e8476d
>>       o- tpg1
>>          o- luns
>>             o- lun0
>>       o- tpg2
>>          o- luns
>>             o- lun0
>>       o- tpg4
>>          o- luns
>>             o- lun0
>>
>> I will handle this in v2.
>>
>>
>> And we need to fix another problem mentioned by Paolo.
>> Otherwise we can not use this to tell if a target exists or the endpoint
>> is not setup.
>>
>>    target = v_req.lun[1];
>>    tv_tpg = vs->vs_tpg[target];
>>    if (tv_tpg)
>>       /* target exist */
>>    else
>>       /* target does not exist*/
>>
> 
> Why should there be a difference?

With multi-target, if tv_tpg is NULL, there might be two reasons:
1. backend is not setup
2. this target does not exist.

we need another flag to indicate if the endpoint is setup or not.
Set/Clear it in vhost_scsi_set_endpoint()/vhost_scsi_clear_endpoint(),
Test it in vhost_scsi_handle_vq().

> 
>> """ from paolo
>> Another small bug I found is an ordering problem between
>> VHOST_SET_VRING_KICK and VHOST_SCSI_SET_ENDPOINT.  Starting the vq
>> causes a "vhost_scsi_handle_vq endpoint not set" error in dmesg.
>> Because of this I added the first two patches, which let me do
>> VHOST_SCSI_SET_ENDPOINT before VHOST_SET_VRING_KICK but after setting
>> up the vring.
>> """
>>
>>
>>>  			smp_mb__after_atomic_inc();
>>> +			if (!vs->vs_num_target++)
>>> +				memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
>>> +				       sizeof(vs->vs_vhost_wwpn));
>>>  			mutex_unlock(&vs->dev.mutex);
>>> -			return 0;
>>>  		}
>>>  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
>>>  	}
>>>  	mutex_unlock(&tcm_vhost_mutex);
>>> -	return -EINVAL;
>>> +	return 0;
>>>  }
>>>  
>>>  static int vhost_scsi_clear_endpoint(
>>> @@ -803,7 +830,8 @@ static int vhost_scsi_clear_endpoint(
>>>  {
>>>  	struct tcm_vhost_tport *tv_tport;
>>>  	struct tcm_vhost_tpg *tv_tpg;
>>> -	int index, ret;
>>> +	int index, ret, i;
>>> +	u8 target;
>>>  
>>>  	mutex_lock(&vs->dev.mutex);
>>>  	/* Verify that ring has been setup correctly. */
>>> @@ -813,27 +841,32 @@ static int vhost_scsi_clear_endpoint(
>>>  			goto err;
>>>  		}
>>>  	}
>>> +	for (i = 0; i < vs->vs_num_target; i++) {
>>> +		target = i;
>>>  
>>> -	if (!vs->vs_tpg) {
>>> -		ret = -ENODEV;
>>> -		goto err;
>>> -	}
>>> -	tv_tpg = vs->vs_tpg;
>>> -	tv_tport = tv_tpg->tport;
>>> -
>>> -	if (strcmp(tv_tport->tport_name, t->vhost_wwpn) ||
>>> -	    (tv_tpg->tport_tpgt != t->vhost_tpgt)) {
>>> -		pr_warn("tv_tport->tport_name: %s, tv_tpg->tport_tpgt: %hu"
>>> -			" does not match t->vhost_wwpn: %s, t->vhost_tpgt: %hu\n",
>>> -			tv_tport->tport_name, tv_tpg->tport_tpgt,
>>> -			t->vhost_wwpn, t->vhost_tpgt);
>>> -		ret = -EINVAL;
>>> -		goto err;
>>> +		tv_tpg = vs->vs_tpg[target];
>>> +		if (!tv_tpg) {
>>> +			ret = -ENODEV;
>>> +			goto err;
>>> +		}
>>> +		tv_tport = tv_tpg->tport;
>>> +		if (!tv_tport) {
>>> +			ret = -ENODEV;
>>> +			goto err;
>>> +		}
>>> +
>>> +		if (strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
>>> +			pr_warn("tv_tport->tport_name: %s, tv_tpg->tport_tpgt: %hu"
>>> +				" does not match t->vhost_wwpn: %s, t->vhost_tpgt: %hu\n",
>>> +				tv_tport->tport_name, tv_tpg->tport_tpgt,
>>> +				t->vhost_wwpn, t->vhost_tpgt);
>>> +			ret = -EINVAL;
>>> +			goto err;
>>> +		}
>>> +		tv_tpg->tv_tpg_vhost_count--;
>>> +		vs->vs_tpg[target] = NULL;
>>>  	}
>>> -	tv_tpg->tv_tpg_vhost_count--;
>>> -	vs->vs_tpg = NULL;
>>>  	mutex_unlock(&vs->dev.mutex);
>>> -
>>>  	return 0;
>>>  
>>>  err:
>>> @@ -868,16 +901,10 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>>>  static int vhost_scsi_release(struct inode *inode, struct file *f)
>>>  {
>>>  	struct vhost_scsi *s = f->private_data;
>>> +	struct vhost_scsi_target t;
>>>  
>>> -	if (s->vs_tpg && s->vs_tpg->tport) {
>>> -		struct vhost_scsi_target backend;
>>> -
>>> -		memcpy(backend.vhost_wwpn, s->vs_tpg->tport->tport_name,
>>> -				sizeof(backend.vhost_wwpn));
>>> -		backend.vhost_tpgt = s->vs_tpg->tport_tpgt;
>>> -		vhost_scsi_clear_endpoint(s, &backend);
>>> -	}
>>> -
>>> +	memcpy(t.vhost_wwpn, s->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
>>> +	vhost_scsi_clear_endpoint(s, &t);
>>>  	vhost_dev_stop(&s->dev);
>>>  	vhost_dev_cleanup(&s->dev, false);
>>>  	kfree(s);
>>> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
>>> index 47ee80b..519a550 100644
>>> --- a/drivers/vhost/tcm_vhost.h
>>> +++ b/drivers/vhost/tcm_vhost.h
>>> @@ -93,9 +93,11 @@ struct tcm_vhost_tport {
>>>   *
>>>   * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
>>>   *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
>>> + * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
>>> + *            All the targets under vhost_wwpn can be seen and used by guset.
>>>   */
>>>  
>>> -#define VHOST_SCSI_ABI_VERSION	0
>>> +#define VHOST_SCSI_ABI_VERSION	1
>>>  
>>>  struct vhost_scsi_target {
>>>  	int abi_version;
>>>
>>
>>
>> -- 
>> Asias


-- 
Asias
