From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH] drm/virtio: Add window server support
Date: Tue, 9 Jan 2018 13:56:53 +0100
Message-ID: <CAAObsKBqWEgaPRgM6a=QwY1sqeL8DsBGG+_=S5ObhOV-S8d_Eg__77.2337582477078$1515502554$gmane$org@mail.gmail.com>
References: <20171228115333.12289-1-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171228115333.12289-1-tomeu.vizoso@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Zach Reizner <zachr@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On 28 December 2017 at 12:53, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> This is to allow clients running within VMs to be able to communicate
> with a compositor in the host. Clients will use the communication
> protocol that the compositor supports, and virtio-gpu will assist with
> making buffers available in both sides, and copying content as needed.

Here is the qemu side, a bit hackier atm:

https://gitlab.collabora.com/tomeu/qemu/commits/winsrv-wip

Regards,

Tomeu

> It is expected that a service in the guest will act as a proxy,
> interacting with virtio-gpu to support unmodified clients. For some
> features of the protocol, the hypervisor might have to intervene and
> also parse the protocol data to properly bridge resources. The following
> IOCTLs have been added to this effect:
>
> *_WINSRV_CONNECT: Opens a connection to the compositor in the host,
> returns a FD that represents this connection and on which the following
> IOCTLs can be used. Callers are expected to poll this FD for new
> messages from the compositor.
>
> *_WINSRV_TX: Asks the hypervisor to forward a message to the compositor
>
> *_WINSRV_RX: Returns all queued messages
>
> Alongside protocol data that is opaque to the kernel, the client can
> send file descriptors that reference GEM buffers allocated by
> virtio-gpu. The guest proxy is expected to figure out when a client is
> passing a FD that refers to shared memory in the guest and allocate a
> virtio-gpu buffer of the same size with DRM_VIRTGPU_RESOURCE_CREATE.
>
> When the client notifies the compositor that it can read from that buffer,
> the proxy should copy the contents from the SHM region to the virtio-gpu
> resource and call DRM_VIRTGPU_TRANSFER_TO_HOST.
>
> This has been tested with Wayland clients that make use of wl_shm to
> pass buffers to the compositor, but is expected to work similarly for X
> clients that make use of MIT-SHM with FD passing.
>
> v2: * Add padding to two virtio command structs
>     * Properly cast two __user pointers (kbuild test robot)
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Zach Reizner <zachr@google.com>
>
> ---
>
> Hi,
>
> this work is based on the virtio_wl driver in the ChromeOS kernel by
> Zach Reizner, currently at:
>
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/virtio/virtio_wl.c
>
> There's two features missing in this patch when compared with virtio_wl:
>
> * Allow the guest access directly host memory, without having to resort
> to TRANSFER_TO_HOST
>
> * Pass FDs from host to guest (Wayland specifies that the compositor
> shares keyboard data with the guest via a shared buffer)
>
> I plan to work on this next, but I would like to get some comments on
> the general approach so I can better choose which patch to follow.
>
> Thanks,
>
> Tomeu
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  39 ++++-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 168 +++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   |  58 +++++--
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 285 ++++++++++++++++++++++++++++++++-
>  include/uapi/drm/virtgpu_drm.h         |  29 ++++
>  include/uapi/linux/virtio_gpu.h        |  41 +++++
>  6 files changed, 605 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index da2fb585fea4..268b386e1232 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -178,6 +178,8 @@ struct virtio_gpu_device {
>
>         struct virtio_gpu_queue ctrlq;
>         struct virtio_gpu_queue cursorq;
> +       struct virtio_gpu_queue winsrv_rxq;
> +       struct virtio_gpu_queue winsrv_txq;
>         struct kmem_cache *vbufs;
>         bool vqs_ready;
>
> @@ -205,10 +207,32 @@ struct virtio_gpu_device {
>
>  struct virtio_gpu_fpriv {
>         uint32_t ctx_id;
> +
> +       struct list_head winsrv_conns; /* list of virtio_gpu_winsrv_conn */
> +       spinlock_t winsrv_lock;
> +};
> +
> +struct virtio_gpu_winsrv_rx_qentry {
> +       struct virtio_gpu_winsrv_rx *cmd;
> +       struct list_head next;
> +};
> +
> +struct virtio_gpu_winsrv_conn {
> +       struct virtio_gpu_device *vgdev;
> +
> +       spinlock_t lock;
> +
> +       int fd;
> +       struct drm_file *drm_file;
> +
> +       struct list_head cmdq; /* queue of virtio_gpu_winsrv_rx_qentry */
> +       wait_queue_head_t cmdwq;
> +
> +       struct list_head next;
>  };
>
>  /* virtio_ioctl.c */
> -#define DRM_VIRTIO_NUM_IOCTLS 10
> +#define DRM_VIRTIO_NUM_IOCTLS 11
>  extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
>
>  /* virtio_kms.c */
> @@ -318,9 +342,22 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>  void virtio_gpu_ctrl_ack(struct virtqueue *vq);
>  void virtio_gpu_cursor_ack(struct virtqueue *vq);
>  void virtio_gpu_fence_ack(struct virtqueue *vq);
> +void virtio_gpu_winsrv_tx_ack(struct virtqueue *vq);
> +void virtio_gpu_winsrv_rx_read(struct virtqueue *vq);
>  void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
>  void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
> +void virtio_gpu_dequeue_winsrv_rx_func(struct work_struct *work);
> +void virtio_gpu_dequeue_winsrv_tx_func(struct work_struct *work);
>  void virtio_gpu_dequeue_fence_func(struct work_struct *work);
> +void virtio_gpu_fill_winsrv_rx(struct virtio_gpu_device *vgdev);
> +void virtio_gpu_queue_winsrv_rx_in(struct virtio_gpu_device *vgdev,
> +                                  struct virtio_gpu_winsrv_rx *cmd);
> +int virtio_gpu_cmd_winsrv_connect(struct virtio_gpu_device *vgdev, int fd);
> +void virtio_gpu_cmd_winsrv_disconnect(struct virtio_gpu_device *vgdev, int fd);
> +int virtio_gpu_cmd_winsrv_tx(struct virtio_gpu_device *vgdev,
> +                            const char __user *buffer, u32 len,
> +                            int *fds, struct virtio_gpu_winsrv_conn *conn,
> +                            bool nonblock);
>
>  /* virtio_gpu_display.c */
>  int virtio_gpu_framebuffer_init(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0528edb4a2bf..630ed16d5f74 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -25,6 +25,9 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
> +#include <linux/anon_inodes.h>
> +#include <linux/syscalls.h>
> +
>  #include <drm/drmP.h>
>  #include <drm/virtgpu_drm.h>
>  #include <drm/ttm/ttm_execbuf_util.h>
> @@ -527,6 +530,168 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>         return 0;
>  }
>
> +static unsigned int winsrv_poll(struct file *filp,
> +                               struct poll_table_struct *wait)
> +{
> +       struct virtio_gpu_winsrv_conn *conn = filp->private_data;
> +       unsigned int mask = 0;
> +
> +       spin_lock(&conn->lock);
> +       poll_wait(filp, &conn->cmdwq, wait);
> +       if (!list_empty(&conn->cmdq))
> +               mask |= POLLIN | POLLRDNORM;
> +       spin_unlock(&conn->lock);
> +
> +       return mask;
> +}
> +
> +static int winsrv_ioctl_rx(struct virtio_gpu_device *vgdev,
> +                          struct virtio_gpu_winsrv_conn *conn,
> +                          struct drm_virtgpu_winsrv *cmd)
> +{
> +       struct virtio_gpu_winsrv_rx_qentry *qentry, *tmp;
> +       struct virtio_gpu_winsrv_rx *virtio_cmd;
> +       int available_len = cmd->len;
> +       int read_count = 0;
> +
> +       list_for_each_entry_safe(qentry, tmp, &conn->cmdq, next) {
> +               virtio_cmd = qentry->cmd;
> +               if (virtio_cmd->len > available_len)
> +                       return 0;
> +
> +               if (copy_to_user((void __user *)cmd->data + read_count,
> +                                virtio_cmd->data,
> +                                virtio_cmd->len)) {
> +                       /* return error unless we have some data to return */
> +                       if (read_count == 0)
> +                               return -EFAULT;
> +               }
> +
> +               /*
> +                * here we could export resource IDs to FDs, but no protocol
> +                * as of today requires it
> +                */
> +
> +               available_len -= virtio_cmd->len;
> +               read_count += virtio_cmd->len;
> +
> +               virtio_gpu_queue_winsrv_rx_in(vgdev, virtio_cmd);
> +
> +               list_del(&qentry->next);
> +               kfree(qentry);
> +       }
> +
> +       cmd->len = read_count;
> +
> +       return 0;
> +}
> +
> +static long winsrv_ioctl(struct file *filp, unsigned int cmd,
> +                        unsigned long arg)
> +{
> +       struct virtio_gpu_winsrv_conn *conn = filp->private_data;
> +       struct virtio_gpu_device *vgdev = conn->vgdev;
> +       struct drm_virtgpu_winsrv winsrv_cmd;
> +       int ret;
> +
> +       if (_IOC_SIZE(cmd) > sizeof(winsrv_cmd))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&winsrv_cmd, (void __user *)arg,
> +                          _IOC_SIZE(cmd)) != 0)
> +               return -EFAULT;
> +
> +       switch (cmd) {
> +       case DRM_IOCTL_VIRTGPU_WINSRV_RX:
> +               ret = winsrv_ioctl_rx(vgdev, conn, &winsrv_cmd);
> +               if (copy_to_user((void __user *)arg, &winsrv_cmd,
> +                                _IOC_SIZE(cmd)) != 0)
> +                       return -EFAULT;
> +
> +               break;
> +
> +       case DRM_IOCTL_VIRTGPU_WINSRV_TX:
> +               ret = virtio_gpu_cmd_winsrv_tx(vgdev,
> +                               u64_to_user_ptr(winsrv_cmd.data),
> +                               winsrv_cmd.len,
> +                               winsrv_cmd.fds,
> +                               conn,
> +                               filp->f_flags & O_NONBLOCK);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int winsrv_release(struct inode *inodep, struct file *filp)
> +{
> +       struct virtio_gpu_winsrv_conn *conn = filp->private_data;
> +       struct virtio_gpu_device *vgdev = conn->vgdev;
> +
> +       virtio_gpu_cmd_winsrv_disconnect(vgdev, conn->fd);
> +
> +       list_del(&conn->next);
> +       kfree(conn);
> +
> +       return 0;
> +}
> +
> +static const struct file_operations winsrv_fops = {
> +
> +       .poll = winsrv_poll,
> +       .unlocked_ioctl = winsrv_ioctl,
> +       .release = winsrv_release,
> +};
> +
> +static int virtio_gpu_winsrv_connect(struct drm_device *dev, void *data,
> +                                    struct drm_file *file)
> +{
> +       struct virtio_gpu_device *vgdev = dev->dev_private;
> +       struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> +       struct drm_virtgpu_winsrv_connect *args = data;
> +       struct virtio_gpu_winsrv_conn *conn;
> +       int ret;
> +
> +       conn = kzalloc(sizeof(*conn), GFP_KERNEL);
> +       if (!conn)
> +               return -ENOMEM;
> +
> +       conn->vgdev = vgdev;
> +       conn->drm_file = file;
> +       spin_lock_init(&conn->lock);
> +       INIT_LIST_HEAD(&conn->cmdq);
> +       init_waitqueue_head(&conn->cmdwq);
> +
> +       ret = anon_inode_getfd("[virtgpu_winsrv]", &winsrv_fops, conn,
> +                              O_CLOEXEC | O_RDWR);
> +       if (ret < 0)
> +               goto free_conn;
> +
> +       conn->fd = ret;
> +
> +       ret = virtio_gpu_cmd_winsrv_connect(vgdev, conn->fd);
> +       if (ret < 0)
> +               goto close_fd;
> +
> +       spin_lock(&vfpriv->winsrv_lock);
> +       list_add_tail(&conn->next, &vfpriv->winsrv_conns);
> +       spin_unlock(&vfpriv->winsrv_lock);
> +
> +       args->fd = conn->fd;
> +
> +       return 0;
> +
> +close_fd:
> +       sys_close(conn->fd);
> +
> +free_conn:
> +       kfree(conn);
> +
> +       return ret;
> +}
> +
>  struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
>         DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
>                           DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
> @@ -558,4 +723,7 @@ struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
>                           DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_WINSRV_CONNECT, virtio_gpu_winsrv_connect,
> +                         DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
>  };
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 6400506a06b0..ad7872037982 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -128,13 +128,15 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>  int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  {
>         static vq_callback_t *callbacks[] = {
> -               virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack
> +               virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack,
> +               virtio_gpu_winsrv_rx_read, virtio_gpu_winsrv_tx_ack
>         };
> -       static const char * const names[] = { "control", "cursor" };
> +       static const char * const names[] = { "control", "cursor",
> +                                             "winsrv-rx", "winsrv-tx" };
>
>         struct virtio_gpu_device *vgdev;
>         /* this will expand later */
> -       struct virtqueue *vqs[2];
> +       struct virtqueue *vqs[4];
>         u32 num_scanouts, num_capsets;
>         int ret;
>
> @@ -158,6 +160,10 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>         init_waitqueue_head(&vgdev->resp_wq);
>         virtio_gpu_init_vq(&vgdev->ctrlq, virtio_gpu_dequeue_ctrl_func);
>         virtio_gpu_init_vq(&vgdev->cursorq, virtio_gpu_dequeue_cursor_func);
> +       virtio_gpu_init_vq(&vgdev->winsrv_rxq,
> +                          virtio_gpu_dequeue_winsrv_rx_func);
> +       virtio_gpu_init_vq(&vgdev->winsrv_txq,
> +                          virtio_gpu_dequeue_winsrv_tx_func);
>
>         vgdev->fence_drv.context = dma_fence_context_alloc(1);
>         spin_lock_init(&vgdev->fence_drv.lock);
> @@ -175,13 +181,15 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>         DRM_INFO("virgl 3d acceleration not supported by guest\n");
>  #endif
>
> -       ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
> +       ret = virtio_find_vqs(vgdev->vdev, 4, vqs, callbacks, names, NULL);
>         if (ret) {
>                 DRM_ERROR("failed to find virt queues\n");
>                 goto err_vqs;
>         }
>         vgdev->ctrlq.vq = vqs[0];
>         vgdev->cursorq.vq = vqs[1];
> +       vgdev->winsrv_rxq.vq = vqs[2];
> +       vgdev->winsrv_txq.vq = vqs[3];
>         ret = virtio_gpu_alloc_vbufs(vgdev);
>         if (ret) {
>                 DRM_ERROR("failed to alloc vbufs\n");
> @@ -215,6 +223,9 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>                 goto err_modeset;
>
>         virtio_device_ready(vgdev->vdev);
> +
> +       virtio_gpu_fill_winsrv_rx(vgdev);
> +
>         vgdev->vqs_ready = true;
>
>         if (num_capsets)
> @@ -256,6 +267,8 @@ void virtio_gpu_driver_unload(struct drm_device *dev)
>         vgdev->vqs_ready = false;
>         flush_work(&vgdev->ctrlq.dequeue_work);
>         flush_work(&vgdev->cursorq.dequeue_work);
> +       flush_work(&vgdev->winsrv_rxq.dequeue_work);
> +       flush_work(&vgdev->winsrv_txq.dequeue_work);
>         flush_work(&vgdev->config_changed_work);
>         vgdev->vdev->config->del_vqs(vgdev->vdev);
>
> @@ -274,25 +287,43 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
>         uint32_t id;
>         char dbgname[64], tmpname[TASK_COMM_LEN];
>
> -       /* can't create contexts without 3d renderer */
> -       if (!vgdev->has_virgl_3d)
> -               return 0;
> -
> -       get_task_comm(tmpname, current);
> -       snprintf(dbgname, sizeof(dbgname), "%s", tmpname);
> -       dbgname[63] = 0;
>         /* allocate a virt GPU context for this opener */
>         vfpriv = kzalloc(sizeof(*vfpriv), GFP_KERNEL);
>         if (!vfpriv)
>                 return -ENOMEM;
>
> -       virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname, &id);
> +       /* can't create contexts without 3d renderer */
> +       if (vgdev->has_virgl_3d) {
> +               get_task_comm(tmpname, current);
> +               snprintf(dbgname, sizeof(dbgname), "%s", tmpname);
> +               dbgname[63] = 0;
> +
> +               virtio_gpu_context_create(vgdev, strlen(dbgname), dbgname, &id);
> +
> +               vfpriv->ctx_id = id;
> +       }
> +
> +       spin_lock_init(&vfpriv->winsrv_lock);
> +       INIT_LIST_HEAD(&vfpriv->winsrv_conns);
>
> -       vfpriv->ctx_id = id;
>         file->driver_priv = vfpriv;
> +
>         return 0;
>  }
>
> +static void virtio_gpu_cleanup_conns(struct virtio_gpu_fpriv *vfpriv)
> +{
> +       struct virtio_gpu_winsrv_conn *conn, *tmp;
> +       struct virtio_gpu_winsrv_rx_qentry *qentry, *tmp2;
> +
> +       list_for_each_entry_safe(conn, tmp, &vfpriv->winsrv_conns, next) {
> +               list_for_each_entry_safe(qentry, tmp2, &conn->cmdq, next) {
> +                       kfree(qentry);
> +               }
> +               kfree(conn);
> +       }
> +}
> +
>  void virtio_gpu_driver_postclose(struct drm_device *dev, struct drm_file *file)
>  {
>         struct virtio_gpu_device *vgdev = dev->dev_private;
> @@ -303,6 +334,7 @@ void virtio_gpu_driver_postclose(struct drm_device *dev, struct drm_file *file)
>
>         vfpriv = file->driver_priv;
>
> +       virtio_gpu_cleanup_conns(vfpriv);
>         virtio_gpu_context_destroy(vgdev, vfpriv->ctx_id);
>         kfree(vfpriv);
>         file->driver_priv = NULL;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9eb96fb2c147..ea5f9352d364 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -32,7 +32,7 @@
>  #include <linux/virtio_config.h>
>  #include <linux/virtio_ring.h>
>
> -#define MAX_INLINE_CMD_SIZE   96
> +#define MAX_INLINE_CMD_SIZE   144
>  #define MAX_INLINE_RESP_SIZE  24
>  #define VBUFFER_SIZE          (sizeof(struct virtio_gpu_vbuffer) \
>                                + MAX_INLINE_CMD_SIZE             \
> @@ -72,6 +72,67 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
>         schedule_work(&vgdev->cursorq.dequeue_work);
>  }
>
> +void virtio_gpu_winsrv_rx_read(struct virtqueue *vq)
> +{
> +       struct drm_device *dev = vq->vdev->priv;
> +       struct virtio_gpu_device *vgdev = dev->dev_private;
> +
> +       schedule_work(&vgdev->winsrv_rxq.dequeue_work);
> +}
> +
> +void virtio_gpu_winsrv_tx_ack(struct virtqueue *vq)
> +{
> +       struct drm_device *dev = vq->vdev->priv;
> +       struct virtio_gpu_device *vgdev = dev->dev_private;
> +
> +       schedule_work(&vgdev->winsrv_txq.dequeue_work);
> +}
> +
> +void virtio_gpu_queue_winsrv_rx_in(struct virtio_gpu_device *vgdev,
> +                                  struct virtio_gpu_winsrv_rx *cmd)
> +{
> +       struct virtqueue *vq = vgdev->winsrv_rxq.vq;
> +       struct scatterlist sg[1];
> +       int ret;
> +
> +       sg_init_one(sg, cmd, sizeof(*cmd));
> +
> +       spin_lock(&vgdev->winsrv_rxq.qlock);
> +retry:
> +       ret = virtqueue_add_inbuf(vq, sg, 1, cmd, GFP_KERNEL);
> +       if (ret == -ENOSPC) {
> +               spin_unlock(&vgdev->winsrv_rxq.qlock);
> +               wait_event(vgdev->winsrv_rxq.ack_queue, vq->num_free);
> +               spin_lock(&vgdev->winsrv_rxq.qlock);
> +               goto retry;
> +       }
> +       virtqueue_kick(vq);
> +       spin_unlock(&vgdev->winsrv_rxq.qlock);
> +}
> +
> +void virtio_gpu_fill_winsrv_rx(struct virtio_gpu_device *vgdev)
> +{
> +       struct virtqueue *vq = vgdev->winsrv_rxq.vq;
> +       struct virtio_gpu_winsrv_rx *cmd;
> +       int ret = 0;
> +
> +       while (vq->num_free > 0) {
> +               cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
> +               if (!cmd) {
> +                       ret = -ENOMEM;
> +                       goto clear_queue;
> +               }
> +
> +               virtio_gpu_queue_winsrv_rx_in(vgdev, cmd);
> +       }
> +
> +       return;
> +
> +clear_queue:
> +       while ((cmd = virtqueue_detach_unused_buf(vq)))
> +               kfree(cmd);
> +}
> +
>  int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
>  {
>         vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
> @@ -258,6 +319,96 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
>         wake_up(&vgdev->cursorq.ack_queue);
>  }
>
> +void virtio_gpu_dequeue_winsrv_tx_func(struct work_struct *work)
> +{
> +       struct virtio_gpu_device *vgdev =
> +               container_of(work, struct virtio_gpu_device,
> +                            winsrv_txq.dequeue_work);
> +       struct virtio_gpu_vbuffer *vbuf;
> +       int len;
> +
> +       spin_lock(&vgdev->winsrv_txq.qlock);
> +       do {
> +               while ((vbuf = virtqueue_get_buf(vgdev->winsrv_txq.vq, &len)))
> +                       free_vbuf(vgdev, vbuf);
> +       } while (!virtqueue_enable_cb(vgdev->winsrv_txq.vq));
> +       spin_unlock(&vgdev->winsrv_txq.qlock);
> +
> +       wake_up(&vgdev->winsrv_txq.ack_queue);
> +}
> +
> +static struct virtio_gpu_winsrv_conn *find_conn(struct virtio_gpu_device *vgdev,
> +                                               int fd)
> +{
> +       struct virtio_gpu_winsrv_conn *conn;
> +       struct drm_device *ddev = vgdev->ddev;
> +       struct drm_file *file;
> +       struct virtio_gpu_fpriv *vfpriv;
> +
> +       mutex_lock(&ddev->filelist_mutex);
> +       list_for_each_entry(file, &ddev->filelist, lhead) {
> +               vfpriv = file->driver_priv;
> +               spin_lock(&vfpriv->winsrv_lock);
> +               list_for_each_entry(conn, &vfpriv->winsrv_conns, next) {
> +                       if (conn->fd == fd) {
> +                               spin_lock(&conn->lock);
> +                               spin_unlock(&vfpriv->winsrv_lock);
> +                               mutex_unlock(&ddev->filelist_mutex);
> +                               return conn;
> +                       }
> +               }
> +               spin_unlock(&vfpriv->winsrv_lock);
> +       }
> +       mutex_unlock(&ddev->filelist_mutex);
> +
> +       return NULL;
> +}
> +
> +static void handle_rx_cmd(struct virtio_gpu_device *vgdev,
> +                         struct virtio_gpu_winsrv_rx *cmd)
> +{
> +       struct virtio_gpu_winsrv_conn *conn;
> +       struct virtio_gpu_winsrv_rx_qentry *qentry;
> +
> +       conn = find_conn(vgdev, cmd->client_fd);
> +       if (!conn) {
> +               DRM_DEBUG("recv for unknown client fd %u\n", cmd->client_fd);
> +               return;
> +       }
> +
> +       qentry = kzalloc(sizeof(*qentry), GFP_KERNEL);
> +       if (!qentry) {
> +               spin_unlock(&conn->lock);
> +               DRM_DEBUG("failed to allocate qentry for winsrv connection\n");
> +               return;
> +       }
> +
> +       qentry->cmd = cmd;
> +
> +       list_add_tail(&qentry->next, &conn->cmdq);
> +       wake_up_interruptible(&conn->cmdwq);
> +       spin_unlock(&conn->lock);
> +}
> +
> +void virtio_gpu_dequeue_winsrv_rx_func(struct work_struct *work)
> +{
> +       struct virtio_gpu_device *vgdev =
> +               container_of(work, struct virtio_gpu_device,
> +                            winsrv_rxq.dequeue_work);
> +       struct virtio_gpu_winsrv_rx *cmd;
> +       unsigned int len;
> +
> +       spin_lock(&vgdev->winsrv_rxq.qlock);
> +       while ((cmd = virtqueue_get_buf(vgdev->winsrv_rxq.vq, &len)) != NULL) {
> +               spin_unlock(&vgdev->winsrv_rxq.qlock);
> +               handle_rx_cmd(vgdev, cmd);
> +               spin_lock(&vgdev->winsrv_rxq.qlock);
> +       }
> +       spin_unlock(&vgdev->winsrv_rxq.qlock);
> +
> +       virtqueue_kick(vgdev->winsrv_rxq.vq);
> +}
> +
>  static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                                                struct virtio_gpu_vbuffer *vbuf)
>                 __releases(&vgdev->ctrlq.qlock)
> @@ -380,6 +531,41 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>         return ret;
>  }
>
> +static int virtio_gpu_queue_winsrv_tx(struct virtio_gpu_device *vgdev,
> +                                     struct virtio_gpu_vbuffer *vbuf)
> +{
> +       struct virtqueue *vq = vgdev->winsrv_txq.vq;
> +       struct scatterlist *sgs[2], vcmd, vout;
> +       int ret;
> +
> +       if (!vgdev->vqs_ready)
> +               return -ENODEV;
> +
> +       sg_init_one(&vcmd, vbuf->buf, vbuf->size);
> +       sgs[0] = &vcmd;
> +
> +       sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
> +       sgs[1] = &vout;
> +
> +       spin_lock(&vgdev->winsrv_txq.qlock);
> +retry:
> +       ret = virtqueue_add_sgs(vq, sgs, 2, 0, vbuf, GFP_ATOMIC);
> +       if (ret == -ENOSPC) {
> +               spin_unlock(&vgdev->winsrv_txq.qlock);
> +               wait_event(vgdev->winsrv_txq.ack_queue, vq->num_free);
> +               spin_lock(&vgdev->winsrv_txq.qlock);
> +               goto retry;
> +       }
> +
> +       virtqueue_kick(vq);
> +
> +       spin_unlock(&vgdev->winsrv_txq.qlock);
> +
> +       if (!ret)
> +               ret = vq->num_free;
> +       return ret;
> +}
> +
>  /* just create gem objects for userspace and long lived objects,
>     just use dma_alloced pages for the queue objects? */
>
> @@ -890,3 +1076,100 @@ void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
>         memcpy(cur_p, &output->cursor, sizeof(output->cursor));
>         virtio_gpu_queue_cursor(vgdev, vbuf);
>  }
> +
> +int virtio_gpu_cmd_winsrv_connect(struct virtio_gpu_device *vgdev, int fd)
> +{
> +       struct virtio_gpu_winsrv_connect *cmd_p;
> +       struct virtio_gpu_vbuffer *vbuf;
> +
> +       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
> +       memset(cmd_p, 0, sizeof(*cmd_p));
> +
> +       cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_WINSRV_CONNECT);
> +       cmd_p->client_fd = cpu_to_le32(fd);
> +       return virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +}
> +
> +void virtio_gpu_cmd_winsrv_disconnect(struct virtio_gpu_device *vgdev, int fd)
> +{
> +       struct virtio_gpu_winsrv_disconnect *cmd_p;
> +       struct virtio_gpu_vbuffer *vbuf;
> +
> +       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
> +       memset(cmd_p, 0, sizeof(*cmd_p));
> +
> +       cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_WINSRV_DISCONNECT);
> +       cmd_p->client_fd = cpu_to_le32(fd);
> +       virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +}
> +
> +int virtio_gpu_cmd_winsrv_tx(struct virtio_gpu_device *vgdev,
> +                            const char __user *buffer, u32 len,
> +                            int *fds, struct virtio_gpu_winsrv_conn *conn,
> +                            bool nonblock)
> +{
> +       int client_fd = conn->fd;
> +       struct drm_file *file = conn->drm_file;
> +       struct virtio_gpu_winsrv_tx *cmd_p;
> +       struct virtio_gpu_vbuffer *vbuf;
> +       uint32_t gem_handle;
> +       struct drm_gem_object *gobj = NULL;
> +       struct virtio_gpu_object *qobj = NULL;
> +       int ret, i, fd;
> +
> +       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
> +       memset(cmd_p, 0, sizeof(*cmd_p));
> +
> +       cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_WINSRV_TX);
> +
> +       for (i = 0; i < VIRTIO_GPU_WINSRV_MAX_ALLOCS; i++) {
> +               cmd_p->resource_ids[i] = -1;
> +
> +               fd = fds[i];
> +               if (fd < 0)
> +                       break;
> +
> +               ret = drm_gem_prime_fd_to_handle(vgdev->ddev, file, fd,
> +                                                &gem_handle);
> +               if (ret != 0)
> +                       goto err_free_vbuf;
> +
> +               gobj = drm_gem_object_lookup(file, gem_handle);
> +               if (gobj == NULL) {
> +                       ret = -ENOENT;
> +                       goto err_free_vbuf;
> +               }
> +
> +               qobj = gem_to_virtio_gpu_obj(gobj);
> +               cmd_p->resource_ids[i] = qobj->hw_res_handle;
> +       }
> +
> +       cmd_p->client_fd = client_fd;
> +       cmd_p->len = cpu_to_le32(len);
> +
> +       /* gets freed when the ring has consumed it */
> +       vbuf->data_buf = kmalloc(cmd_p->len, GFP_KERNEL);
> +       if (!vbuf->data_buf) {
> +               DRM_ERROR("failed to allocate winsrv tx buffer\n");
> +               ret = -ENOMEM;
> +               goto err_free_vbuf;
> +       }
> +
> +       vbuf->data_size = cmd_p->len;
> +
> +       if (copy_from_user(vbuf->data_buf, buffer, cmd_p->len)) {
> +               ret = -EFAULT;
> +               goto err_free_databuf;
> +       }
> +
> +       virtio_gpu_queue_winsrv_tx(vgdev, vbuf);
> +
> +       return 0;
> +
> +err_free_databuf:
> +       kfree(vbuf->data_buf);
> +err_free_vbuf:
> +       free_vbuf(vgdev, vbuf);
> +
> +       return ret;
> +}
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 91a31ffed828..89b0a1a707a7 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -46,6 +46,11 @@ extern "C" {
>  #define DRM_VIRTGPU_TRANSFER_TO_HOST 0x07
>  #define DRM_VIRTGPU_WAIT     0x08
>  #define DRM_VIRTGPU_GET_CAPS  0x09
> +#define DRM_VIRTGPU_WINSRV_CONNECT  0x0a
> +#define DRM_VIRTGPU_WINSRV_TX  0x0b
> +#define DRM_VIRTGPU_WINSRV_RX  0x0c
> +
> +#define VIRTGPU_WINSRV_MAX_ALLOCS 28
>
>  struct drm_virtgpu_map {
>         __u64 offset; /* use for mmap system call */
> @@ -132,6 +137,18 @@ struct drm_virtgpu_get_caps {
>         __u32 pad;
>  };
>
> +struct drm_virtgpu_winsrv {
> +       __s32 fds[VIRTGPU_WINSRV_MAX_ALLOCS];
> +       __u64 data;
> +       __u32 len;
> +       __u32 pad;
> +};
> +
> +struct drm_virtgpu_winsrv_connect {
> +       __u32 fd;   /* returned by kernel */
> +       __u32 pad;
> +};
> +
>  #define DRM_IOCTL_VIRTGPU_MAP \
>         DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
>
> @@ -167,6 +184,18 @@ struct drm_virtgpu_get_caps {
>         DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_GET_CAPS, \
>         struct drm_virtgpu_get_caps)
>
> +#define DRM_IOCTL_VIRTGPU_WINSRV_CONNECT \
> +       DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_WINSRV_CONNECT, \
> +               struct drm_virtgpu_winsrv_connect)
> +
> +#define DRM_IOCTL_VIRTGPU_WINSRV_TX \
> +       DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_WINSRV_TX, \
> +               struct drm_virtgpu_winsrv)
> +
> +#define DRM_IOCTL_VIRTGPU_WINSRV_RX \
> +       DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_WINSRV_RX, \
> +               struct drm_virtgpu_winsrv)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 4b04ead26cd9..afe830bb8d00 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -71,6 +71,12 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
>         VIRTIO_GPU_CMD_MOVE_CURSOR,
>
> +       /* window server commands */
> +       VIRTIO_GPU_CMD_WINSRV_CONNECT = 0x0400,
> +       VIRTIO_GPU_CMD_WINSRV_DISCONNECT,
> +       VIRTIO_GPU_CMD_WINSRV_TX,
> +       VIRTIO_GPU_CMD_WINSRV_RX,
> +
>         /* success responses */
>         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
>         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
> @@ -290,6 +296,41 @@ struct virtio_gpu_resp_capset {
>         __u8 capset_data[];
>  };
>
> +/* VIRTIO_GPU_CMD_WINSRV_CONNECT */
> +struct virtio_gpu_winsrv_connect {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 client_fd;
> +       __le32 padding;
> +};
> +
> +/* VIRTIO_GPU_CMD_WINSRV_DISCONNECT */
> +struct virtio_gpu_winsrv_disconnect {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 client_fd;
> +       __le32 padding;
> +};
> +
> +#define VIRTIO_GPU_WINSRV_MAX_ALLOCS 28
> +#define VIRTIO_GPU_WINSRV_TX_MAX_DATA 4096
> +
> +/* VIRTIO_GPU_CMD_WINSRV_TX */
> +/* these commands are followed in the queue descriptor by protocol buffers */
> +struct virtio_gpu_winsrv_tx {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 client_fd;
> +       __le32 len;
> +       __le32 resource_ids[VIRTIO_GPU_WINSRV_MAX_ALLOCS];
> +};
> +
> +/* VIRTIO_GPU_CMD_WINSRV_RX */
> +struct virtio_gpu_winsrv_rx {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 client_fd;
> +       __u8 data[VIRTIO_GPU_WINSRV_TX_MAX_DATA];
> +       __le32 len;
> +       __le32 resource_ids[VIRTIO_GPU_WINSRV_MAX_ALLOCS];
> +};
> +
>  #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
>
>  struct virtio_gpu_config {
> --
> 2.14.3
>
