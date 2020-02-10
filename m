From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 2/2] drm/qxl: add drm_driver.release callback.
Date: Mon, 10 Feb 2020 17:59:18 +0100
Message-ID: <8b28f881-ea8e-af70-3ce3-f1d9b4a7f31a@tronnes.org>
References: <20200210113753.5614-1-kraxel@redhat.com>
 <20200210113753.5614-3-kraxel@redhat.com>
 <20200210150633.GS43062@phenom.ffwll.local>
 <f83001ab-8017-0576-69fd-d5f62bda84fd@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f83001ab-8017-0576-69fd-d5f62bda84fd@tronnes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

(adding back Daniel)

Den 10.02.2020 17.57, skrev Noralf Trønnes:
> 
> 
> Den 10.02.2020 16.06, skrev Daniel Vetter:
>> On Mon, Feb 10, 2020 at 12:37:52PM +0100, Gerd Hoffmann wrote:
>>> Move final cleanups to qxl_drm_release() callback.
>>> Add drm_atomic_helper_shutdown() call to qxl_pci_remove().
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++++++++++++++++-------
>>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
>>> index 1d601f57a6ba..4fda3f9b29f4 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>>> @@ -34,6 +34,7 @@
>>>  #include <linux/pci.h>
>>>  
>>>  #include <drm/drm.h>
>>> +#include <drm/drm_atomic_helper.h>
>>>  #include <drm/drm_drv.h>
>>>  #include <drm/drm_file.h>
>>>  #include <drm/drm_modeset_helper.h>
>>> @@ -132,21 +133,30 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  	return ret;
>>>  }
>>>  
>>> +static void qxl_drm_release(struct drm_device *dev)
>>> +{
>>> +	struct qxl_device *qdev = dev->dev_private;
>>> +
>>> +	/*
>>> +	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
>>> +	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
>>> +	 * non-trivial though.
>>> +	 */
>>> +	qxl_modeset_fini(qdev);
>>
>> So the drm_mode_config_cleanup call in here belongs in ->release, but the
>> qxl_destroy_monitors_object feels like should be perfectly fine in the
>> remove hook. You might need to sprinkle a few drm_dev_enter/exit around to
>> protect code paths thought.
>>
>> Aside from this lgtm, for the series
>>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> And up to you whether you want to fix this or not really.
>>
>> Btw for testing all these patches that add a ->release hook I think it'd
>> be good if the drm core checks that drm_device->dev is set to NULL, and
>> that we do this in the remove hook. Since that's guaranteed to be gone at
>> that point, so anything in ->release that still needs the device is
>> broken. Ofc maybe do that check only for drivers which have a ->release
>> hook, and we might need a few fixups.
>>
> 
> We take a ref on the parent device in drm_dev_init() and release it in
> drm_dev_fini(). I added this because of the DRM_DEV_* macros we have, to
> protect access to the device struct after it was unregistered. Setting
> drm_device->dev to NULL in drm_dev_unregister() instead will provide the
> same protection I think.
> 
> commit 56be6503aab2
> drm/drv: Hold ref on parent device during drm_device lifetime
> 
> Noralf.
> 
>> Cheers, Daniel
>>
>>> +	qxl_device_fini(qdev);
>>> +	dev->dev_private = NULL;
>>> +	kfree(qdev);
>>> +}
>>> +
>>>  static void
>>>  qxl_pci_remove(struct pci_dev *pdev)
>>>  {
>>>  	struct drm_device *dev = pci_get_drvdata(pdev);
>>> -	struct qxl_device *qdev = dev->dev_private;
>>>  
>>>  	drm_dev_unregister(dev);
>>> -
>>> -	qxl_modeset_fini(qdev);
>>> -	qxl_device_fini(qdev);
>>> +	drm_atomic_helper_shutdown(dev);
>>>  	if (is_vga(pdev))
>>>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>>> -
>>> -	dev->dev_private = NULL;
>>> -	kfree(qdev);
>>>  	drm_dev_put(dev);
>>>  }
>>>  
>>> @@ -279,6 +289,8 @@ static struct drm_driver qxl_driver = {
>>>  	.major = 0,
>>>  	.minor = 1,
>>>  	.patchlevel = 0,
>>> +
>>> +	.release = qxl_drm_release,
>>>  };
>>>  
>>>  static int __init qxl_init(void)
>>> -- 
>>> 2.18.1
>>>
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
