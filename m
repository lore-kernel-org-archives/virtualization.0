From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: drop vring dependency on iotlb
Date: Thu, 2 Apr 2020 22:59:49 +0800
Message-ID: <4ba378d7-ce02-a085-dbd7-0c1cbe2d5bab@redhat.com>
References: <20200402141207.32628-1-mst@redhat.com>
 <afe230b9-708f-02a1-c3af-51e9d4fdd212@redhat.com>
 <20200402103551-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200402103551-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/2 =E4=B8=8B=E5=8D=8810:36, Michael S. Tsirkin wrote:
> On Thu, Apr 02, 2020 at 10:28:28PM +0800, Jason Wang wrote:
>> On 2020/4/2 =E4=B8=8B=E5=8D=8810:12, Michael S. Tsirkin wrote:
>>> vringh can now be built without IOTLB.
>>> Select IOTLB directly where it's used.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>
>>> This is on top of my previous patch (in vhost tree now).
>>>
>>>    drivers/vdpa/Kconfig  | 1 +
>>>    drivers/vhost/Kconfig | 1 -
>>>    2 files changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>>> index 7db1460104b7..08b615f2da39 100644
>>> --- a/drivers/vdpa/Kconfig
>>> +++ b/drivers/vdpa/Kconfig
>>> @@ -17,6 +17,7 @@ config VDPA_SIM
>>>    	depends on RUNTIME_TESTING_MENU
>>>    	select VDPA
>>>    	select VHOST_RING
>>> +	select VHOST_IOTLB
>>>    	default n
>>>    	help
>>>    	  vDPA networking device simulator which loop TX traffic back
>>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>>> index 21feea0d69c9..bdd270fede26 100644
>>> --- a/drivers/vhost/Kconfig
>>> +++ b/drivers/vhost/Kconfig
>>> @@ -6,7 +6,6 @@ config VHOST_IOTLB
>>>    config VHOST_RING
>>>    	tristate
>>> -	select VHOST_IOTLB
>>>    	help
>>>    	  This option is selected by any driver which needs to access
>>>    	  the host side of a virtio ring.
>>
>> Do we need to mention driver need to select VHOST_IOTLB by itself here=
?
>>
>> Thanks
>>
> OK but I guess it's best to do it near where VHOST_IOTLB is defined.
> Like this?
>
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index bdd270fede26..ce51126f51e7 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -3,6 +3,8 @@ config VHOST_IOTLB
>   	tristate
>   	help
>   	  Generic IOTLB implementation for vhost and vringh.
> +	  This option is selected by any driver which needs to support
> +	  an IOMMU in software.
>  =20
>   config VHOST_RING
>   	tristate
>

Yes, probably.

Thanks
