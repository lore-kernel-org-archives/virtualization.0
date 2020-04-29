From: Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are rele
Date: Wed, 29 Apr 2020 09:12:46 +0300
Message-ID: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
References: <20200421084300.zggroiptwbrblzqy () sirius ! home ! kraxel ! org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200421084300.zggroiptwbrblzqy () sirius ! home ! kraxel ! org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Caicai <caizhaopeng@uniontech.com>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>, Zhangyueqian <zhangyueqian@uniontech.com>, "Denis V. Lunev" <den@virtuozzo.com>
List-Id: virtualization@lists.linuxfoundation.org



On 4/21/20 11:43 AM, Gerd Hoffmann wrote:
> On Sat, Apr 18, 2020 at 02:39:17PM +0800, Caicai wrote:
>> When a qxl resource is released, the list that needs to be released is
>> fetched from the linked list ring and cleared. When you empty the list,
>> instead of trying to determine whether the ttm buffer object for each
>> qxl in the list is locked, you release the qxl object and remove the
>> element from the list until the list is empty. It was found that the
>> linked list was cleared first, and that the lock on the corresponding
>> ttm Bo for the QXL had not been released, so that the new qxl could not
>> be locked when it used the TTM.
> 
> So the dma_resv_reserve_shared() call in qxl_release_validate_bo() is
> unbalanced?  Because the dma_resv_unlock() call in
> qxl_release_fence_buffer_objects() never happens due to
> qxl_release_free_list() clearing the list beforehand?  Is that correct?

we observe similar issue: RHEL7 guests crashes in 
qxl_draw_opaque_fb()
 qxl_release_fence_buffer_objects() 

crashdump investigation shows that qlx_object was freed and reused,
so its original content was re-written.

At the same time qxl_device have empty release_idr,
ant there are no allocated qxl_bo_list entries.
i.e. qxl_release_free was really called.

> The only way I see for this to happen is that the guest is preempted
> between qxl_push_{cursor,command}_ring_release() and
> qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
> command then, signal the guest, and the IRQ handler calls
> qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.

We think the same: qxl_release was freed by garbage collector before
original thread had called qxl_release_fence_buffer_objects().

> Looking through the code I think it should be safe to simply swap the
> qxl_release_fence_buffer_objects() +
> qxl_push_{cursor,command}_ring_release() calls to close that race
> window.  Can you try that and see if it fixes the bug for you?

I'm going to prepare and test such patch but I have one question here:
qxl_push_*_ring_release can be called with  interruptible=true and fail
How to correctly handle this case? Is the hunk below correct from your POV?

--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -261,12 +261,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
                        apply_surf_reloc(qdev, &reloc_info[i]);
        }
 
+       qxl_release_fence_buffer_objects(release);
        ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
-       if (ret)
-               qxl_release_backoff_reserve_list(release);  <<<< ????
-       else
-               qxl_release_fence_buffer_objects(release);
-
 out_free_bos:
 out_free_release:


Thank you,
	Vasily Averin
