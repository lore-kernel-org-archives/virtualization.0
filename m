From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are rele
Date: Wed, 29 Apr 2020 10:28:37 +0200
Message-ID: <20200429082837.uedcapxmennuc5a2@sirius.home.kraxel.org>
References: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, David Airlie <airlied@linux.ie>, "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zhangyueqian <zhangyueqian@uniontech.com>, Dave Airlie <airlied@redhat.com>, Caicai <caizhaopeng@uniontech.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > The only way I see for this to happen is that the guest is preempted
> > between qxl_push_{cursor,command}_ring_release() and
> > qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
> > command then, signal the guest, and the IRQ handler calls
> > qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.
> 
> We think the same: qxl_release was freed by garbage collector before
> original thread had called qxl_release_fence_buffer_objects().

Ok, nice, I think we can consider the issue being analyzed then ;)

> > Looking through the code I think it should be safe to simply swap the
> > qxl_release_fence_buffer_objects() +
> > qxl_push_{cursor,command}_ring_release() calls to close that race
> > window.  Can you try that and see if it fixes the bug for you?
> 
> I'm going to prepare and test such patch but I have one question here:
> qxl_push_*_ring_release can be called with  interruptible=true and fail
> How to correctly handle this case? Is the hunk below correct from your POV?

Oh, right, the error code path will be quite different, checking ...

> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -261,12 +261,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
>                         apply_surf_reloc(qdev, &reloc_info[i]);
>         }
>  
> +       qxl_release_fence_buffer_objects(release);
>         ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
> -       if (ret)
> -               qxl_release_backoff_reserve_list(release);  <<<< ????
> -       else
> -               qxl_release_fence_buffer_objects(release);
> -
>  out_free_bos:
>  out_free_release:
	if (ret)
		qxl_release_free(qdev, release);

[ code context added ]

qxl_release_free() checks whenever a release is fenced and signals the
fence in case it is so it doesn't wait for the signal forever.  So, yes,
I think qxl_release_free() should cleanup the release properly in any
case and the patch chunk should be correct.

take care,
  Gerd
