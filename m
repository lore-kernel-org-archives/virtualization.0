From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] virtio_blk: fix race at module removal
Date: Fri, 24 Oct 2014 10:13:01 +0800
Message-ID: <CACVXFVMP9yLfUhwh6MH=q6a11Z8AeJ8aso7R+LNb-QoDfD5UVw@mail.gmail.com>
References: <1414080703-4547-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1414080703-4547-1-git-send-email-mst@redhat.com>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 24, 2014 at 12:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> If a device appears while module is being removed,
> driver will get a callback after we've given up
> on the major number.
>
> In theory this means this major number can get reused
> by something else, resulting in a conflict.

Yes, there is a tiny race window.

>
> To fix, cleanup in reverse order of initialization.

Reviewed-by: Ming Lei <ming.lei@canonical.com>

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 56aadbc..adfba9f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -883,8 +883,8 @@ out_destroy_workqueue:
>
>  static void __exit fini(void)
>  {
> -       unregister_blkdev(major, "virtblk");
>         unregister_virtio_driver(&virtio_blk);
> +       unregister_blkdev(major, "virtblk");
>         destroy_workqueue(virtblk_wq);
>  }
>  module_init(init);

Thanks,
-- 
Ming Lei
