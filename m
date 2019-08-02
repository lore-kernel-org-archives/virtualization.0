From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: kick vq outside of the vq lock
Date: Fri, 2 Aug 2019 10:02:45 +0200
Message-ID: <20190802080245.za2n5rgx763xvhpd__4021.43022963486$1564732985$gmane$org@sirius.home.kraxel.org>
References: <20190711022937.166015-1-olvaffe@gmail.com>
	<20190711023959.170158-1-olvaffe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190711023959.170158-1-olvaffe@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> @@ -291,11 +291,9 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>  		trace_virtio_gpu_cmd_queue(vq,
>  			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>  
> -		virtqueue_kick(vq);
> +		ret = virtqueue_kick_prepare(vq);
>  	}
>  
> -	if (!ret)
> -		ret = vq->num_free;

Hmm.  Change looks unrelated.

On a closer look it seems this is basically dead code.
virtio_gpu_queue_ctrl_buffer_locked is called by
virtio_gpu_queue_ctrl_buffer and virtio_gpu_queue_fenced_ctrl_buffer.
The call sites for these two functions all ignore the return value.

So it is a valid change, but it should go to a separate patch.  And
while being at it virtio_gpu_queue_ctrl_buffer and
virtio_gpu_queue_fenced_ctrl_buffer can be changed to return void.

Otherwise the patch looks fine.  Nice analysis btw.

cheers,
  Gerd
