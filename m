From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/virtio: fix vq wait_event condition
Date: Mon, 23 Apr 2018 11:24:53 +1000
Message-ID: <CAPM=9tw6jK2QrjjGnH8JqhV-Z0VMngySLyFvayn98otw3efOPg__23692.5315963619$1524446594$gmane$org@mail.gmail.com>
References: <20180403095904.11152-1-kraxel@redhat.com>
	<20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, amagloire@blackberry.com
List-Id: virtualization@lists.linuxfoundation.org

On 20 April 2018 at 17:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:
>> Wait until we have enough space in the virt queue to actually queue up
>> our request.  Avoids the guest spinning in case we have a non-zero
>> amount of free entries but not enough for the request.
>
> Ping airlied, can you please either pick it up or review so I can commit
> myself?

Just in case it got lost from my phone,

Reviewed-by: Dave Airlie <airlied@redhat.com>

>
> thanks,
>   Gerd
>
>> Cc: stable@vger.kernel.org
>> Reported-by: Alain Magloire <amagloire@blackberry.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> index 48e4f1df6e..020070d483 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>>       ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
>>       if (ret == -ENOSPC) {
>>               spin_unlock(&vgdev->ctrlq.qlock);
>> -             wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
>> +             wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
>>               spin_lock(&vgdev->ctrlq.qlock);
>>               goto retry;
>>       } else {
>> @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>>       ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>       if (ret == -ENOSPC) {
>>               spin_unlock(&vgdev->cursorq.qlock);
>> -             wait_event(vgdev->cursorq.ack_queue, vq->num_free);
>> +             wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>>               spin_lock(&vgdev->cursorq.qlock);
>>               goto retry;
>>       } else {
>> --
>> 2.9.3
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
