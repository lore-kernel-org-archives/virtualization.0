From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are released.
Date: Tue, 21 Apr 2020 10:43:00 +0200
Message-ID: <20200421084300.zggroiptwbrblzqy@sirius.home.kraxel.org>
References: <20200418063917.26278-1-caizhaopeng@uniontech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200418063917.26278-1-caizhaopeng@uniontech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caicai <caizhaopeng@uniontech.com>
Cc: Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Zhangyueqian <zhangyueqian@uniontech.com>, Zhangshuang <zhangshuang@uniontech.com>, Zhangshiwen <zhangshiwen@uniontech.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 18, 2020 at 02:39:17PM +0800, Caicai wrote:
> When a qxl resource is released, the list that needs to be released is
> fetched from the linked list ring and cleared. When you empty the list,
> instead of trying to determine whether the ttm buffer object for each
> qxl in the list is locked, you release the qxl object and remove the
> element from the list until the list is empty. It was found that the
> linked list was cleared first, and that the lock on the corresponding
> ttm Bo for the QXL had not been released, so that the new qxl could not
> be locked when it used the TTM.

So the dma_resv_reserve_shared() call in qxl_release_validate_bo() is
unbalanced?  Because the dma_resv_unlock() call in
qxl_release_fence_buffer_objects() never happens due to
qxl_release_free_list() clearing the list beforehand?  Is that correct?

The only way I see for this to happen is that the guest is preempted
between qxl_push_{cursor,command}_ring_release() and
qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
command then, signal the guest, and the IRQ handler calls
qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.

Looking through the code I think it should be safe to simply swap the
qxl_release_fence_buffer_objects() +
qxl_push_{cursor,command}_ring_release() calls to close that race
window.  Can you try that and see if it fixes the bug for you?

>  		if (flush)
> -			flush_work(&qdev->gc_work);
> +			//can't flush work, it may lead to deadlock
> +			usleep_range(500, 1000);
> +

The commit message doesn't explain this chunk.

take care,
  Gerd
