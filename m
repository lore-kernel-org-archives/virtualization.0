From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
Date: Thu, 27 Dec 2018 13:17:20 +0100
Message-ID: <e79b5c3d-aa89-6b99-00b1-c92c85fe214c__7364.06252622164$1545912932$gmane$org@de.ibm.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
	<0661b05a-d9d0-d374-44e8-2583463e94c2@de.ibm.com>
	<de167161-b586-6aee-d6a5-a90d47bbe1d4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <de167161-b586-6aee-d6a5-a90d47bbe1d4@de.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, pbonzini@redhat.com, nilal@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 27.12.2018 12:59, Christian Borntraeger wrote:
> On 27.12.2018 12:31, Christian Borntraeger wrote:
>> This patch triggers random crashes in the guest kernel on s390 early during boot.
>> No migration and no setting of the balloon is involved.
>>
> 
> Adding Conny and Halil,
> 
> As the QEMU provides no PAGE_HINT feature yet, this quick hack makes the
> guest boot fine again:
> 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 728ecd1eea305..aa2e1864c5736 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -492,7 +492,7 @@ static int init_vqs(struct virtio_balloon *vb)
>                 callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>         }
>  
> -       err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
> +       err = vb->vdev->config->find_vqs(vb->vdev, 3, //VIRTIO_BALLOON_VQ_MAX,
>                                          vqs, callbacks, names, NULL, NULL);
>         if (err)
>                 return err;
> 
> 
> To me it looks like that virtio_ccw_find_vqs will abort if any of the virtqueues 
> that it is been asked for does not exist (including the earlier ones).
> 

This "hack" makes the random crashes go away, but the balloon interface itself
does not work. (setting the value to anything will hang the guest). 
As patch 1 also modifies the main path, there seem to be additional issues, maybe
endianess

Looking at things like

+		vb->cmd_id_received = VIRTIO_BALLOON_CMD_ID_STOP;
+		vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
+						  VIRTIO_BALLOON_CMD_ID_STOP);
+		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
+						  VIRTIO_BALLOON_CMD_ID_STOP);


Why is cmd_id_received not using cpu_to_virtio32?
