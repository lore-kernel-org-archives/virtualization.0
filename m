From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 12:38:32 +0800
Message-ID: <3cae9db3-05b4-acc4-a542-cdb086cb6a02@linux.intel.com>
References: <1587722659-1300-1-git-send-email-lingshan.zhu@intel.com>
 <1587722659-1300-2-git-send-email-lingshan.zhu@intel.com>
 <cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8405369353829348359=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com>
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
--===============8405369353829348359==
Content-Type: multipart/alternative;
 boundary="------------989E9BFF669BDF4FE1FA53C6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------989E9BFF669BDF4FE1FA53C6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/26/2020 11:07 AM, Jason Wang wrote:
>
> On 2020/4/24 下午6:04, Zhu Lingshan wrote:
>> This commit implements config interrupt support in
>> vhost_vdpa layer.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>
>
> One should be sufficient.
>
>
>> ---
>>   drivers/vhost/vdpa.c             | 53 
>> ++++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vhost.h       |  2 ++
>>   include/uapi/linux/vhost_types.h |  2 ++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 421f02a..f1f69bf 100644
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
>> @@ -288,6 +301,42 @@ static long vhost_vdpa_get_vring_num(struct 
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
>> +    vhost_config_file file;
>> +    struct eventfd_ctx *ctx;
>> +
>> +    cb.callback = vhost_vdpa_config_cb;
>> +    cb.private = v->vdpa;
>> +    if (copy_from_user(&file, argp, sizeof(file)))
>> +        return  -EFAULT;
>> +
>> +    if (file.fd == -1) {
>> +        vhost_vdpa_config_put(v);
>> +        v->config_ctx = NULL;
>> +        return PTR_ERR(v->config_ctx);
>> +    }
>> +
>> +    ctx = eventfd_ctx_fdget(file.fd);
>
>
> You may simply did ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
>
> Then there's no need for the specialized action for -1 above.

OK

>
>
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
>> @@ -398,6 +447,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file 
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
>> @@ -734,6 +786,7 @@ static int vhost_vdpa_release(struct inode 
>> *inode, struct file *filep)
>>       vhost_dev_stop(&v->vdev);
>>       vhost_vdpa_iotlb_free(v);
>>       vhost_vdpa_free_domain(v);
>> +    vhost_vdpa_config_put(v);
>>       vhost_dev_cleanup(&v->vdev);
>>       kfree(v->vdev.vqs);
>>       mutex_unlock(&d->mutex);
>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> index 9fe72e4..c474a35 100644
>> --- a/include/uapi/linux/vhost.h
>> +++ b/include/uapi/linux/vhost.h
>> @@ -140,4 +140,6 @@
>>   /* Get the max ring size. */
>>   #define VHOST_VDPA_GET_VRING_NUM _IOR(VHOST_VIRTIO, 0x76, __u16)
>>   +/* Set event fd for config interrupt*/
>> +#define VHOST_VDPA_SET_CONFIG_CALL _IOW(VHOST_VIRTIO, 0x77, 
>> vhost_config_file)
>>   #endif
>> diff --git a/include/uapi/linux/vhost_types.h 
>> b/include/uapi/linux/vhost_types.h
>> index 669457c..6759aefb 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -27,6 +27,8 @@ struct vhost_vring_file {
>>     };
>>   +typedef struct vhost_vring_file vhost_config_file;
>> +
>
>
> I wonder maybe this is the best approach. Maybe it's better to use 
> vhost_vring_file or just use a int (but need document the -1 action).
>
> Thanks
>
>
OK, I used a typedef to avoid confusion of placing a vhost_vring_file in the device struct than in a vring. I will use an u32 in next version and
add a macro VHOST_FILE_UNBIND to document itself.

Thanks,
Zhu Lingshan

>>   struct vhost_vring_addr {
>>       unsigned int index;
>>       /* Option flags. */
>

--------------989E9BFF669BDF4FE1FA53C6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><tt><br>
      </tt></p>
    <div class="moz-cite-prefix"><tt>On 4/26/2020 11:07 AM, Jason Wang
        wrote:</tt><tt><br>
      </tt></div>
    <blockquote type="cite"
      cite="mid:cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com">
      <tt><br>
      </tt><tt>On 2020/4/24 下午6:04, Zhu Lingshan wrote:
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
        </tt>
        <tt><br>
        </tt><tt>Signed-off-by: Zhu Lingshan
          <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>One should be sufficient.
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt>
      <tt><br>
      </tt>
      <blockquote type="cite"><tt>---
        </tt><tt><br>
        </tt><tt>  drivers/vhost/vdpa.c             | 53
          ++++++++++++++++++++++++++++++++++++++++
        </tt><tt><br>
        </tt><tt>  include/uapi/linux/vhost.h       |  2 ++
        </tt><tt><br>
        </tt><tt>  include/uapi/linux/vhost_types.h |  2 ++
        </tt><tt><br>
        </tt><tt>  3 files changed, 57 insertions(+)
        </tt><tt><br>
        </tt>
        <tt><br>
        </tt><tt>diff --git a/drivers/vhost/vdpa.c
          b/drivers/vhost/vdpa.c
        </tt><tt><br>
        </tt><tt>index 421f02a..f1f69bf 100644
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
        </tt><tt>@@ -288,6 +301,42 @@ static long
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
        </tt><tt>+    vhost_config_file file;
        </tt><tt><br>
        </tt><tt>+    struct eventfd_ctx *ctx;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    cb.callback = vhost_vdpa_config_cb;
        </tt><tt><br>
        </tt><tt>+    cb.private = v-&gt;vdpa;
        </tt><tt><br>
        </tt><tt>+    if (copy_from_user(&amp;file, argp, sizeof(file)))
        </tt><tt><br>
        </tt><tt>+        return  -EFAULT;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    if (file.fd == -1) {
        </tt><tt><br>
        </tt><tt>+        vhost_vdpa_config_put(v);
        </tt><tt><br>
        </tt><tt>+        v-&gt;config_ctx = NULL;
        </tt><tt><br>
        </tt><tt>+        return PTR_ERR(v-&gt;config_ctx);
        </tt><tt><br>
        </tt><tt>+    }
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    ctx = eventfd_ctx_fdget(file.fd);
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>You may simply did ctx = f.fd == -1 ? NULL :
        eventfd_ctx_fdget(f.fd);
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>Then there's no need for the specialized action for -1
        above.
      </tt><tt><br>
      </tt></blockquote>
    <pre>OK
</pre>
    <blockquote type="cite"
      cite="mid:cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com">
      <tt><br>
      </tt>
      <tt><br>
      </tt>
      <blockquote type="cite"><tt>+    swap(ctx, v-&gt;config_ctx);
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
        </tt><tt>@@ -398,6 +447,9 @@ static long
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
        </tt><tt>@@ -734,6 +786,7 @@ static int
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
        </tt><tt>diff --git a/include/uapi/linux/vhost.h
          b/include/uapi/linux/vhost.h
        </tt><tt><br>
        </tt><tt>index 9fe72e4..c474a35 100644
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
          _IOW(VHOST_VIRTIO, 0x77, vhost_config_file)
        </tt><tt><br>
        </tt><tt>  #endif
        </tt><tt><br>
        </tt><tt>diff --git a/include/uapi/linux/vhost_types.h
          b/include/uapi/linux/vhost_types.h
        </tt><tt><br>
        </tt><tt>index 669457c..6759aefb 100644
        </tt><tt><br>
        </tt><tt>--- a/include/uapi/linux/vhost_types.h
        </tt><tt><br>
        </tt><tt>+++ b/include/uapi/linux/vhost_types.h
        </tt><tt><br>
        </tt><tt>@@ -27,6 +27,8 @@ struct vhost_vring_file {
        </tt><tt><br>
        </tt><tt>    };
        </tt><tt><br>
        </tt><tt>  +typedef struct vhost_vring_file vhost_config_file;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>I wonder maybe this is the best approach. Maybe it's
        better to use vhost_vring_file or just use a int (but need
        document the -1 action).
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>Thanks
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt>
      <tt><br>
      </tt></blockquote>
    <pre>OK, I used a typedef to avoid confusion of placing a vhost_vring_file in the device struct than in a vring. I will use an u32 in next version and
add a macro VHOST_FILE_UNBIND to document itself.

Thanks,
Zhu Lingshan
</pre>
    <blockquote type="cite"
      cite="mid:cb656c27-22a8-3a18-9e3a-68fa0c3ff06b@redhat.com">
      <blockquote type="cite"><tt>  struct vhost_vring_addr {
        </tt><tt><br>
        </tt><tt>      unsigned int index;
        </tt><tt><br>
        </tt><tt>      /* Option flags. */
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
    </blockquote>
  </body>
</html>

--------------989E9BFF669BDF4FE1FA53C6--

--===============8405369353829348359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8405369353829348359==--
