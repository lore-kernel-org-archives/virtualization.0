From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH V2 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 15:03:00 +0800
Message-ID: <136f9109-7959-f38c-dcaa-66d4d707aa56@linux.intel.com>
References: <1587881384-2133-1-git-send-email-lingshan.zhu@intel.com>
 <1587881384-2133-2-git-send-email-lingshan.zhu@intel.com>
 <055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6103548127723686993=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============6103548127723686993==
Content-Type: multipart/alternative;
 boundary="------------E7BC73C0A315DC055B338C07"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E7BC73C0A315DC055B338C07
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/26/2020 2:58 PM, Jason Wang wrote:
>
> On 2020/4/26 下午2:09, Zhu Lingshan wrote:
>> This commit implements config interrupt support in
>> vhost_vdpa layer.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vhost/vdpa.c       | 47 
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/vhost/vhost.c      |  2 +-
>>   drivers/vhost/vhost.h      |  2 ++
>>   include/uapi/linux/vhost.h |  2 ++
>>   4 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 421f02a..b94e349 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/nospec.h>
>>   #include <linux/vhost.h>
>>   #include <linux/virtio_net.h>
>> +#include <linux/kernel.h>
>>     #include "vhost.h"
>>   @@ -70,6 +71,7 @@ struct vhost_vdpa {
>>       int nvqs;
>>       int virtio_id;
>>       int minor;
>> +    struct eventfd_ctx *config_ctx;
>>   };
>>     static DEFINE_IDA(vhost_vdpa_ida);
>> @@ -101,6 +103,17 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void 
>> *private)
>>       return IRQ_HANDLED;
>>   }
>>   +static irqreturn_t vhost_vdpa_config_cb(void *private)
>> +{
>> +    struct vhost_vdpa *v = private;
>> +    struct eventfd_ctx *config_ctx = v->config_ctx;
>> +
>> +    if (config_ctx)
>> +        eventfd_signal(config_ctx, 1);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>>   static void vhost_vdpa_reset(struct vhost_vdpa *v)
>>   {
>>       struct vdpa_device *vdpa = v->vdpa;
>> @@ -288,6 +301,36 @@ static long vhost_vdpa_get_vring_num(struct 
>> vhost_vdpa *v, u16 __user *argp)
>>       return 0;
>>   }
>>   +static void vhost_vdpa_config_put(struct vhost_vdpa *v)
>> +{
>> +    if (v->config_ctx)
>> +        eventfd_ctx_put(v->config_ctx);
>> +}
>> +
>> +static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 
>> __user *argp)
>> +{
>> +    struct vdpa_callback cb;
>> +    u32 fd;
>> +    struct eventfd_ctx *ctx;
>> +
>> +    cb.callback = vhost_vdpa_config_cb;
>> +    cb.private = v->vdpa;
>> +    if (copy_from_user(&fd, argp, sizeof(fd)))
>> +        return  -EFAULT;
>> +
>> +    ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
>> +    swap(ctx, v->config_ctx);
>> +
>> +    if (!IS_ERR_OR_NULL(ctx))
>> +        eventfd_ctx_put(ctx);
>> +
>> +    if (IS_ERR(v->config_ctx))
>> +        return PTR_ERR(v->config_ctx);
>> +
>> + v->vdpa->config->set_config_cb(v->vdpa, &cb);
>> +
>> +    return 0;
>> +}
>>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned 
>> int cmd,
>>                      void __user *argp)
>>   {
>> @@ -398,6 +441,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file 
>> *filep,
>>       case VHOST_SET_LOG_FD:
>>           r = -ENOIOCTLCMD;
>>           break;
>> +    case VHOST_VDPA_SET_CONFIG_CALL:
>> +        r = vhost_vdpa_set_config_call(v, argp);
>> +        break;
>>       default:
>>           r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>>           if (r == -ENOIOCTLCMD)
>> @@ -734,6 +780,7 @@ static int vhost_vdpa_release(struct inode 
>> *inode, struct file *filep)
>>       vhost_dev_stop(&v->vdev);
>>       vhost_vdpa_iotlb_free(v);
>>       vhost_vdpa_free_domain(v);
>> +    vhost_vdpa_config_put(v);
>>       vhost_dev_cleanup(&v->vdev);
>>       kfree(v->vdev.vqs);
>>       mutex_unlock(&d->mutex);
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index d450e16..e8f5b20 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1590,7 +1590,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, 
>> unsigned int ioctl, void __user *arg
>>               r = -EFAULT;
>>               break;
>>           }
>> -        ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
>> +        ctx = f.fd == VHOST_FILE_UNBIND ? NULL : 
>> eventfd_ctx_fdget(f.fd);
>>           if (IS_ERR(ctx)) {
>>               r = PTR_ERR(ctx);
>>               break;
>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>> index 1813821..8663139 100644
>> --- a/drivers/vhost/vhost.h
>> +++ b/drivers/vhost/vhost.h
>> @@ -18,6 +18,8 @@
>>   typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>>     #define VHOST_WORK_QUEUED 1
>> +#define VHOST_FILE_UNBIND -1
>
>
> I think it's better to document this in uapi.

OK, will define this in uapi header.

>
>
>> +
>>   struct vhost_work {
>>       struct llist_node      node;
>>       vhost_work_fn_t          fn;
>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> index 9fe72e4..345acb3 100644
>> --- a/include/uapi/linux/vhost.h
>> +++ b/include/uapi/linux/vhost.h
>> @@ -140,4 +140,6 @@
>>   /* Get the max ring size. */
>>   #define VHOST_VDPA_GET_VRING_NUM _IOR(VHOST_VIRTIO, 0x76, __u16)
>>   +/* Set event fd for config interrupt*/
>> +#define VHOST_VDPA_SET_CONFIG_CALL _IOW(VHOST_VIRTIO, 0x77, u32)
>>   #endif
>
>
> Should be "int" instead of "u32".

Oh, right, it could be -1

>
> Thanks
>

--------------E7BC73C0A315DC055B338C07
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><tt><br>
      </tt></p>
    <div class="moz-cite-prefix"><tt>On 4/26/2020 2:58 PM, Jason Wang
        wrote:</tt><tt><br>
      </tt></div>
    <blockquote type="cite"
      cite="mid:055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com">
      <tt><br>
      </tt><tt>On 2020/4/26 下午2:09, Zhu Lingshan wrote:
      </tt><tt><br>
      </tt>
      <blockquote type="cite"><tt>This commit implements config
          interrupt support in
        </tt><tt><br>
        </tt><tt>vhost_vdpa layer.
        </tt><tt><br>
        </tt>
        <tt><br>
        </tt><tt>Signed-off-by: Zhu Lingshan
          <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
        </tt><tt><br>
        </tt><tt>---
        </tt><tt><br>
        </tt><tt>  drivers/vhost/vdpa.c       | 47
          ++++++++++++++++++++++++++++++++++++++++++++++
        </tt><tt><br>
        </tt><tt>  drivers/vhost/vhost.c      |  2 +-
        </tt><tt><br>
        </tt><tt>  drivers/vhost/vhost.h      |  2 ++
        </tt><tt><br>
        </tt><tt>  include/uapi/linux/vhost.h |  2 ++
        </tt><tt><br>
        </tt><tt>  4 files changed, 52 insertions(+), 1 deletion(-)
        </tt><tt><br>
        </tt>
        <tt><br>
        </tt><tt>diff --git a/drivers/vhost/vdpa.c
          b/drivers/vhost/vdpa.c
        </tt><tt><br>
        </tt><tt>index 421f02a..b94e349 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vhost/vdpa.c
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vhost/vdpa.c
        </tt><tt><br>
        </tt><tt>@@ -21,6 +21,7 @@
        </tt><tt><br>
        </tt><tt>  #include &lt;linux/nospec.h&gt;
        </tt><tt><br>
        </tt><tt>  #include &lt;linux/vhost.h&gt;
        </tt><tt><br>
        </tt><tt>  #include &lt;linux/virtio_net.h&gt;
        </tt><tt><br>
        </tt><tt>+#include &lt;linux/kernel.h&gt;
        </tt><tt><br>
        </tt><tt>    #include "vhost.h"
        </tt><tt><br>
        </tt><tt>  @@ -70,6 +71,7 @@ struct vhost_vdpa {
        </tt><tt><br>
        </tt><tt>      int nvqs;
        </tt><tt><br>
        </tt><tt>      int virtio_id;
        </tt><tt><br>
        </tt><tt>      int minor;
        </tt><tt><br>
        </tt><tt>+    struct eventfd_ctx *config_ctx;
        </tt><tt><br>
        </tt><tt>  };
        </tt><tt><br>
        </tt><tt>    static DEFINE_IDA(vhost_vdpa_ida);
        </tt><tt><br>
        </tt><tt>@@ -101,6 +103,17 @@ static irqreturn_t
          vhost_vdpa_virtqueue_cb(void *private)
        </tt><tt><br>
        </tt><tt>      return IRQ_HANDLED;
        </tt><tt><br>
        </tt><tt>  }
        </tt><tt><br>
        </tt><tt>  +static irqreturn_t vhost_vdpa_config_cb(void
          *private)
        </tt><tt><br>
        </tt><tt>+{
        </tt><tt><br>
        </tt><tt>+    struct vhost_vdpa *v = private;
        </tt><tt><br>
        </tt><tt>+    struct eventfd_ctx *config_ctx = v-&gt;config_ctx;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    if (config_ctx)
        </tt><tt><br>
        </tt><tt>+        eventfd_signal(config_ctx, 1);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    return IRQ_HANDLED;
        </tt><tt><br>
        </tt><tt>+}
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>  static void vhost_vdpa_reset(struct vhost_vdpa *v)
        </tt><tt><br>
        </tt><tt>  {
        </tt><tt><br>
        </tt><tt>      struct vdpa_device *vdpa = v-&gt;vdpa;
        </tt><tt><br>
        </tt><tt>@@ -288,6 +301,36 @@ static long
          vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user
          *argp)
        </tt><tt><br>
        </tt><tt>      return 0;
        </tt><tt><br>
        </tt><tt>  }
        </tt><tt><br>
        </tt><tt>  +static void vhost_vdpa_config_put(struct vhost_vdpa
          *v)
        </tt><tt><br>
        </tt><tt>+{
        </tt><tt><br>
        </tt><tt>+    if (v-&gt;config_ctx)
        </tt><tt><br>
        </tt><tt>+        eventfd_ctx_put(v-&gt;config_ctx);
        </tt><tt><br>
        </tt><tt>+}
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+static long vhost_vdpa_set_config_call(struct
          vhost_vdpa *v, u32 __user *argp)
        </tt><tt><br>
        </tt><tt>+{
        </tt><tt><br>
        </tt><tt>+    struct vdpa_callback cb;
        </tt><tt><br>
        </tt><tt>+    u32 fd;
        </tt><tt><br>
        </tt><tt>+    struct eventfd_ctx *ctx;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    cb.callback = vhost_vdpa_config_cb;
        </tt><tt><br>
        </tt><tt>+    cb.private = v-&gt;vdpa;
        </tt><tt><br>
        </tt><tt>+    if (copy_from_user(&amp;fd, argp, sizeof(fd)))
        </tt><tt><br>
        </tt><tt>+        return  -EFAULT;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    ctx = fd == VHOST_FILE_UNBIND ? NULL :
          eventfd_ctx_fdget(fd);
        </tt><tt><br>
        </tt><tt>+    swap(ctx, v-&gt;config_ctx);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    if (!IS_ERR_OR_NULL(ctx))
        </tt><tt><br>
        </tt><tt>+        eventfd_ctx_put(ctx);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    if (IS_ERR(v-&gt;config_ctx))
        </tt><tt><br>
        </tt><tt>+        return PTR_ERR(v-&gt;config_ctx);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+   
          v-&gt;vdpa-&gt;config-&gt;set_config_cb(v-&gt;vdpa, &amp;cb);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    return 0;
        </tt><tt><br>
        </tt><tt>+}
        </tt><tt><br>
        </tt><tt>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa
          *v, unsigned int cmd,
        </tt><tt><br>
        </tt><tt>                     void __user *argp)
        </tt><tt><br>
        </tt><tt>  {
        </tt><tt><br>
        </tt><tt>@@ -398,6 +441,9 @@ static long
          vhost_vdpa_unlocked_ioctl(struct file *filep,
        </tt><tt><br>
        </tt><tt>      case VHOST_SET_LOG_FD:
        </tt><tt><br>
        </tt><tt>          r = -ENOIOCTLCMD;
        </tt><tt><br>
        </tt><tt>          break;
        </tt><tt><br>
        </tt><tt>+    case VHOST_VDPA_SET_CONFIG_CALL:
        </tt><tt><br>
        </tt><tt>+        r = vhost_vdpa_set_config_call(v, argp);
        </tt><tt><br>
        </tt><tt>+        break;
        </tt><tt><br>
        </tt><tt>      default:
        </tt><tt><br>
        </tt><tt>          r = vhost_dev_ioctl(&amp;v-&gt;vdev, cmd,
          argp);
        </tt><tt><br>
        </tt><tt>          if (r == -ENOIOCTLCMD)
        </tt><tt><br>
        </tt><tt>@@ -734,6 +780,7 @@ static int
          vhost_vdpa_release(struct inode *inode, struct file *filep)
        </tt><tt><br>
        </tt><tt>      vhost_dev_stop(&amp;v-&gt;vdev);
        </tt><tt><br>
        </tt><tt>      vhost_vdpa_iotlb_free(v);
        </tt><tt><br>
        </tt><tt>      vhost_vdpa_free_domain(v);
        </tt><tt><br>
        </tt><tt>+    vhost_vdpa_config_put(v);
        </tt><tt><br>
        </tt><tt>      vhost_dev_cleanup(&amp;v-&gt;vdev);
        </tt><tt><br>
        </tt><tt>      kfree(v-&gt;vdev.vqs);
        </tt><tt><br>
        </tt><tt>      mutex_unlock(&amp;d-&gt;mutex);
        </tt><tt><br>
        </tt><tt>diff --git a/drivers/vhost/vhost.c
          b/drivers/vhost/vhost.c
        </tt><tt><br>
        </tt><tt>index d450e16..e8f5b20 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vhost/vhost.c
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vhost/vhost.c
        </tt><tt><br>
        </tt><tt>@@ -1590,7 +1590,7 @@ long vhost_vring_ioctl(struct
          vhost_dev *d, unsigned int ioctl, void __user *arg
        </tt><tt><br>
        </tt><tt>              r = -EFAULT;
        </tt><tt><br>
        </tt><tt>              break;
        </tt><tt><br>
        </tt><tt>          }
        </tt><tt><br>
        </tt><tt>-        ctx = f.fd == -1 ? NULL :
          eventfd_ctx_fdget(f.fd);
        </tt><tt><br>
        </tt><tt>+        ctx = f.fd == VHOST_FILE_UNBIND ? NULL :
          eventfd_ctx_fdget(f.fd);
        </tt><tt><br>
        </tt><tt>          if (IS_ERR(ctx)) {
        </tt><tt><br>
        </tt><tt>              r = PTR_ERR(ctx);
        </tt><tt><br>
        </tt><tt>              break;
        </tt><tt><br>
        </tt><tt>diff --git a/drivers/vhost/vhost.h
          b/drivers/vhost/vhost.h
        </tt><tt><br>
        </tt><tt>index 1813821..8663139 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vhost/vhost.h
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vhost/vhost.h
        </tt><tt><br>
        </tt><tt>@@ -18,6 +18,8 @@
        </tt><tt><br>
        </tt><tt>  typedef void (*vhost_work_fn_t)(struct vhost_work
          *work);
        </tt><tt><br>
        </tt><tt>    #define VHOST_WORK_QUEUED 1
        </tt><tt><br>
        </tt><tt>+#define VHOST_FILE_UNBIND -1
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>I think it's better to document this in uapi.
      </tt><tt><br>
      </tt></blockquote>
    <pre>OK, will define this in uapi header.
</pre>
    <blockquote type="cite"
      cite="mid:055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com">
      <tt><br>
      </tt>
      <tt><br>
      </tt>
      <blockquote type="cite"><tt>+
        </tt><tt><br>
        </tt><tt>  struct vhost_work {
        </tt><tt><br>
        </tt><tt>      struct llist_node      node;
        </tt><tt><br>
        </tt><tt>      vhost_work_fn_t          fn;
        </tt><tt><br>
        </tt><tt>diff --git a/include/uapi/linux/vhost.h
          b/include/uapi/linux/vhost.h
        </tt><tt><br>
        </tt><tt>index 9fe72e4..345acb3 100644
        </tt><tt><br>
        </tt><tt>--- a/include/uapi/linux/vhost.h
        </tt><tt><br>
        </tt><tt>+++ b/include/uapi/linux/vhost.h
        </tt><tt><br>
        </tt><tt>@@ -140,4 +140,6 @@
        </tt><tt><br>
        </tt><tt>  /* Get the max ring size. */
        </tt><tt><br>
        </tt><tt>  #define VHOST_VDPA_GET_VRING_NUM   
          _IOR(VHOST_VIRTIO, 0x76, __u16)
        </tt><tt><br>
        </tt><tt>  +/* Set event fd for config interrupt*/
        </tt><tt><br>
        </tt><tt>+#define VHOST_VDPA_SET_CONFIG_CALL   
          _IOW(VHOST_VIRTIO, 0x77, u32)
        </tt><tt><br>
        </tt><tt>  #endif
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>Should be "int" instead of "u32".
      </tt><tt><br>
      </tt></blockquote>
    <pre>Oh, right, it could be -1
</pre>
    <blockquote type="cite"
      cite="mid:055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com">
      <tt><br>
      </tt><tt>Thanks
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt>
    </blockquote>
  </body>
</html>

--------------E7BC73C0A315DC055B338C07--

--===============6103548127723686993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6103548127723686993==--
