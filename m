From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 1/2] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 15:38:42 +0800
Message-ID: <b34df002-344c-f011-dce0-fee882f62af2@redhat.com>
References: <1587881384-2133-1-git-send-email-lingshan.zhu@intel.com>
 <1587881384-2133-2-git-send-email-lingshan.zhu@intel.com>
 <055fb826-895d-881b-719c-228d0cc9a7bf@redhat.com>
 <e345cc85-aa9d-1173-8308-f0a301fca2b2@redhat.com>
 <fb51aa36-9a58-fd50-a4fa-4cc887357367@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <fb51aa36-9a58-fd50-a4fa-4cc887357367@linux.intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/26 =E4=B8=8B=E5=8D=883:24, Zhu Lingshan wrote:
>
>
> On 4/26/2020 3:03 PM, Jason Wang wrote:
>>
>> On 2020/4/26 =E4=B8=8B=E5=8D=882:58, Jason Wang wrote:
>>>>
>>>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>>>> index 1813821..8663139 100644
>>>> --- a/drivers/vhost/vhost.h
>>>> +++ b/drivers/vhost/vhost.h
>>>> @@ -18,6 +18,8 @@
>>>> =C2=A0 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>>>> =C2=A0 =C2=A0 #define VHOST_WORK_QUEUED 1
>>>> +#define VHOST_FILE_UNBIND -1
>>>
>>>
>>> I think it's better to document this in uapi.=20
>>
>>
>> I meant e.g in vhost_vring_file, we had a comment of unbinding:
>>
>> struct vhost_vring_file {
>> =C2=A0=C2=A0=C2=A0 unsigned int index;
>> =C2=A0=C2=A0=C2=A0 int fd; /* Pass -1 to unbind from file. */
>>
>> };
> I think it is better to use an int fd than vhost_vring_file, to avoid t=
he confusions,
> so if we add#define VHOST_FILE_UNBIND -1 in the uapi header, can it doc=
ument itself?
> Thanks


I think so.

Thanks


>>
>> Thanks
>>
