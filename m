From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Subject: Re: [PATCH 2/2] vdpa: implement config interrupt in IFCVF
Date: Sun, 26 Apr 2020 13:32:01 +0800
Message-ID: <de47fa9a-9ce4-05b0-fb92-da0255aad56c@linux.intel.com>
References: <1587722659-1300-1-git-send-email-lingshan.zhu@intel.com>
 <1587722659-1300-3-git-send-email-lingshan.zhu@intel.com>
 <bb909a20-3f14-427d-ee40-129a1844486b@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6519809511090633527=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <bb909a20-3f14-427d-ee40-129a1844486b@redhat.com>
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
--===============6519809511090633527==
Content-Type: multipart/alternative;
 boundary="------------90CF6495DE8CED2B4E58E175"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------90CF6495DE8CED2B4E58E175
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/26/2020 11:25 AM, Jason Wang wrote:
>
> On 2020/4/24 下午6:04, Zhu Lingshan wrote:
>> This commit implements config interrupt support
>> in IFC VF
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
>>   drivers/vdpa/ifcvf/ifcvf_base.h |  2 ++
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 22 +++++++++++++++++++++-
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c 
>> b/drivers/vdpa/ifcvf/ifcvf_base.c
>> index b61b06e..c825d99 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
>> @@ -185,6 +185,9 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 
>> status)
>>     void ifcvf_reset(struct ifcvf_hw *hw)
>>   {
>> +    hw->config_cb.callback = NULL;
>> +    hw->config_cb.private = NULL;
>> +
>>       ifcvf_set_status(hw, 0);
>>       /* flush set_status, make sure VF is stopped, reset */
>>       ifcvf_get_status(hw);
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h 
>> b/drivers/vdpa/ifcvf/ifcvf_base.h
>> index e803070..76928b0 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
>> @@ -81,6 +81,8 @@ struct ifcvf_hw {
>>       void __iomem *net_cfg;
>>       struct vring_info vring[IFCVF_MAX_QUEUE_PAIRS * 2];
>>       void __iomem * const *base;
>> +    char config_msix_name[256];
>> +    struct vdpa_callback config_cb;
>>   };
>>     struct ifcvf_adapter {
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c 
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 8d54dc5..f7baeca 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -18,6 +18,16 @@
>>   #define DRIVER_AUTHOR   "Intel Corporation"
>>   #define IFCVF_DRIVER_NAME       "ifcvf"
>>   +static irqreturn_t ifcvf_config_changed(int irq, void *arg)
>> +{
>> +    struct ifcvf_hw *vf = arg;
>> +
>> +    if (vf->config_cb.callback)
>> +        return vf->config_cb.callback(vf->config_cb.private);
>> +
>> +    return IRQ_HANDLED;
>
>
> So it looks to me the current support of VIRTIO_NET_F_STATUS is broken 
> without this patch.
>
> We probably need to patch to disable it.
>
> Thanks

Hi Jason, We don't have VIRTIO_NET_F_STATUS in driver feature bits for 
now, you just reminded me I should add it along with this series. 
Thanks, BR Zhu Lingshan

>
>
>> +}
>> +
>>   static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
>>   {
>>       struct vring_info *vring = arg;
>> @@ -256,7 +266,10 @@ static void ifcvf_vdpa_set_config(struct 
>> vdpa_device *vdpa_dev,
>>   static void ifcvf_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
>>                        struct vdpa_callback *cb)
>>   {
>> -    /* We don't support config interrupt */
>> +    struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>> +
>> +    vf->config_cb.callback = cb->callback;
>> +    vf->config_cb.private = cb->private;
>>   }
>>     /*
>> @@ -292,6 +305,13 @@ static int ifcvf_request_irq(struct 
>> ifcvf_adapter *adapter)
>>       struct ifcvf_hw *vf = &adapter->vf;
>>       int vector, i, ret, irq;
>>   +    snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
>> +        pci_name(pdev));
>> +    vector = 0;
>> +    irq = pci_irq_vector(pdev, vector);
>> +    ret = devm_request_irq(&pdev->dev, irq,
>> +                   ifcvf_config_changed, 0,
>> +                   vf->config_msix_name, vf);
>>         for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
>>           snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

--------------90CF6495DE8CED2B4E58E175
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><tt><br>
      </tt></p>
    <div class="moz-cite-prefix"><tt>On 4/26/2020 11:25 AM, Jason Wang
        wrote:</tt><tt><br>
      </tt></div>
    <blockquote type="cite"
      cite="mid:bb909a20-3f14-427d-ee40-129a1844486b@redhat.com">
      <tt><br>
      </tt><tt>On 2020/4/24 下午6:04, Zhu Lingshan wrote:
      </tt><tt><br>
      </tt>
      <blockquote type="cite"><tt>This commit implements config
          interrupt support
        </tt><tt><br>
        </tt><tt>in IFC VF
        </tt><tt><br>
        </tt>
        <tt><br>
        </tt><tt>Signed-off-by: Zhu Lingshan
          <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
        </tt><tt><br>
        </tt><tt>---
        </tt><tt><br>
        </tt><tt>  drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
        </tt><tt><br>
        </tt><tt>  drivers/vdpa/ifcvf/ifcvf_base.h |  2 ++
        </tt><tt><br>
        </tt><tt>  drivers/vdpa/ifcvf/ifcvf_main.c | 22
          +++++++++++++++++++++-
        </tt><tt><br>
        </tt><tt>  3 files changed, 26 insertions(+), 1 deletion(-)
        </tt><tt><br>
        </tt>
        <tt><br>
        </tt><tt>diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c
          b/drivers/vdpa/ifcvf/ifcvf_base.c
        </tt><tt><br>
        </tt><tt>index b61b06e..c825d99 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vdpa/ifcvf/ifcvf_base.c
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
        </tt><tt><br>
        </tt><tt>@@ -185,6 +185,9 @@ void ifcvf_set_status(struct
          ifcvf_hw *hw, u8 status)
        </tt><tt><br>
        </tt><tt>    void ifcvf_reset(struct ifcvf_hw *hw)
        </tt><tt><br>
        </tt><tt>  {
        </tt><tt><br>
        </tt><tt>+    hw-&gt;config_cb.callback = NULL;
        </tt><tt><br>
        </tt><tt>+    hw-&gt;config_cb.private = NULL;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>      ifcvf_set_status(hw, 0);
        </tt><tt><br>
        </tt><tt>      /* flush set_status, make sure VF is stopped,
          reset */
        </tt><tt><br>
        </tt><tt>      ifcvf_get_status(hw);
        </tt><tt><br>
        </tt><tt>diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h
          b/drivers/vdpa/ifcvf/ifcvf_base.h
        </tt><tt><br>
        </tt><tt>index e803070..76928b0 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vdpa/ifcvf/ifcvf_base.h
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
        </tt><tt><br>
        </tt><tt>@@ -81,6 +81,8 @@ struct ifcvf_hw {
        </tt><tt><br>
        </tt><tt>      void __iomem *net_cfg;
        </tt><tt><br>
        </tt><tt>      struct vring_info vring[IFCVF_MAX_QUEUE_PAIRS *
          2];
        </tt><tt><br>
        </tt><tt>      void __iomem * const *base;
        </tt><tt><br>
        </tt><tt>+    char config_msix_name[256];
        </tt><tt><br>
        </tt><tt>+    struct vdpa_callback config_cb;
        </tt><tt><br>
        </tt><tt>  };
        </tt><tt><br>
        </tt><tt>    struct ifcvf_adapter {
        </tt><tt><br>
        </tt><tt>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
          b/drivers/vdpa/ifcvf/ifcvf_main.c
        </tt><tt><br>
        </tt><tt>index 8d54dc5..f7baeca 100644
        </tt><tt><br>
        </tt><tt>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
        </tt><tt><br>
        </tt><tt>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
        </tt><tt><br>
        </tt><tt>@@ -18,6 +18,16 @@
        </tt><tt><br>
        </tt><tt>  #define DRIVER_AUTHOR   "Intel Corporation"
        </tt><tt><br>
        </tt><tt>  #define IFCVF_DRIVER_NAME       "ifcvf"
        </tt><tt><br>
        </tt><tt>  +static irqreturn_t ifcvf_config_changed(int irq,
          void *arg)
        </tt><tt><br>
        </tt><tt>+{
        </tt><tt><br>
        </tt><tt>+    struct ifcvf_hw *vf = arg;
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    if (vf-&gt;config_cb.callback)
        </tt><tt><br>
        </tt><tt>+        return
          vf-&gt;config_cb.callback(vf-&gt;config_cb.private);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    return IRQ_HANDLED;
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt>
      <tt><br>
      </tt><tt>So it looks to me the current support of
        VIRTIO_NET_F_STATUS is broken without this patch.
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>We probably need to patch to disable it.
      </tt><tt><br>
      </tt>
      <tt><br>
      </tt><tt>Thanks
      </tt><tt><br>
      </tt></blockquote>
    <pre><tt>Hi Jason,

We don't have </tt><span style="font-size: 11pt;">VIRTIO_NET_F_STATUS in driver feature bits for now, you just
reminded me I should add it along with this series.

Thanks,
BR
Zhu Lingshan</span></pre>
    <blockquote type="cite"
      cite="mid:bb909a20-3f14-427d-ee40-129a1844486b@redhat.com">
      <tt><br>
      </tt>
      <tt><br>
      </tt>
      <blockquote type="cite"><tt>+}
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>  static irqreturn_t ifcvf_intr_handler(int irq, void
          *arg)
        </tt><tt><br>
        </tt><tt>  {
        </tt><tt><br>
        </tt><tt>      struct vring_info *vring = arg;
        </tt><tt><br>
        </tt><tt>@@ -256,7 +266,10 @@ static void
          ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
        </tt><tt><br>
        </tt><tt>  static void ifcvf_vdpa_set_config_cb(struct
          vdpa_device *vdpa_dev,
        </tt><tt><br>
        </tt><tt>                       struct vdpa_callback *cb)
        </tt><tt><br>
        </tt><tt>  {
        </tt><tt><br>
        </tt><tt>-    /* We don't support config interrupt */
        </tt><tt><br>
        </tt><tt>+    struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
        </tt><tt><br>
        </tt><tt>+
        </tt><tt><br>
        </tt><tt>+    vf-&gt;config_cb.callback = cb-&gt;callback;
        </tt><tt><br>
        </tt><tt>+    vf-&gt;config_cb.private = cb-&gt;private;
        </tt><tt><br>
        </tt><tt>  }
        </tt><tt><br>
        </tt><tt>    /*
        </tt><tt><br>
        </tt><tt>@@ -292,6 +305,13 @@ static int
          ifcvf_request_irq(struct ifcvf_adapter *adapter)
        </tt><tt><br>
        </tt><tt>      struct ifcvf_hw *vf = &amp;adapter-&gt;vf;
        </tt><tt><br>
        </tt><tt>      int vector, i, ret, irq;
        </tt><tt><br>
        </tt><tt>  +    snprintf(vf-&gt;config_msix_name, 256,
          "ifcvf[%s]-config\n",
        </tt><tt><br>
        </tt><tt>+        pci_name(pdev));
        </tt><tt><br>
        </tt><tt>+    vector = 0;
        </tt><tt><br>
        </tt><tt>+    irq = pci_irq_vector(pdev, vector);
        </tt><tt><br>
        </tt><tt>+    ret = devm_request_irq(&amp;pdev-&gt;dev, irq,
        </tt><tt><br>
        </tt><tt>+                   ifcvf_config_changed, 0,
        </tt><tt><br>
        </tt><tt>+                   vf-&gt;config_msix_name, vf);
        </tt><tt><br>
        </tt><tt>        for (i = 0; i &lt; IFCVF_MAX_QUEUE_PAIRS * 2;
          i++) {
        </tt><tt><br>
        </tt><tt>          snprintf(vf-&gt;vring[i].msix_name, 256,
          "ifcvf[%s]-%d\n",
        </tt><tt><br>
        </tt></blockquote>
      <tt><br>
      </tt><tt>_______________________________________________
      </tt><tt><br>
      </tt><tt>Virtualization mailing list
      </tt><tt><br>
      </tt><tt><a class="moz-txt-link-abbreviated" href="mailto:Virtualization@lists.linux-foundation.org">Virtualization@lists.linux-foundation.org</a>
      </tt><tt><br>
      </tt><tt><a class="moz-txt-link-freetext" href="https://lists.linuxfoundation.org/mailman/listinfo/virtualization">https://lists.linuxfoundation.org/mailman/listinfo/virtualization</a></tt><tt><br>
      </tt>
    </blockquote>
  </body>
</html>

--------------90CF6495DE8CED2B4E58E175--

--===============6519809511090633527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6519809511090633527==--
