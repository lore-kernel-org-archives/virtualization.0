From: David Hildenbrand <david@redhat.com>
Subject: Re: [vhost:vhost 8/22] drivers/virtio/virtio_mem.c:1375:20: error:
 implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
Date: Tue, 5 May 2020 18:22:51 +0200
Message-ID: <e607a850-ba5c-6033-93fc-144639b125b8@redhat.com>
References: <202005052221.83QerHmG%lkp@intel.com>
 <7dea2810-85cf-0892-20a8-bba3e3a2c133@redhat.com>
 <20200505114433-mutt-send-email-mst@kernel.org>
 <3eaebd8d-750a-d046-15f5-706fb00a196e@redhat.com>
 <20200505121732-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200505121732-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05.05.20 18:20, Michael S. Tsirkin wrote:
> On Tue, May 05, 2020 at 05:46:44PM +0200, David Hildenbrand wrote:
>> On 05.05.20 17:44, Michael S. Tsirkin wrote:
>>> On Tue, May 05, 2020 at 04:50:13PM +0200, David Hildenbrand wrote:
>>>> On 05.05.20 16:15, kbuild test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
>>>>> head:   da1742791d8c0c0a8e5471f181549c4726a5c5f9
>>>>> commit: 7527631e900d464ed2d533f799cb0da2b29cc6f0 [8/22] virtio-mem: Paravirtualized memory hotplug
>>>>> config: x86_64-randconfig-b002-20200505 (attached as .config)
>>>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>>>> reproduce:
>>>>>         git checkout 7527631e900d464ed2d533f799cb0da2b29cc6f0
>>>>>         # save the attached .config to linux build tree
>>>>>         make ARCH=x86_64 
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>
>>>>> All error/warnings (new ones prefixed by >>):
>>>>>
>>>>>    drivers/virtio/virtio_mem.c: In function 'virtio_mem_probe':
>>>>>>> drivers/virtio/virtio_mem.c:1375:20: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
>>>>>      vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
>>>>>                        ^~~~~~~
>>>>>                        vzalloc
>>>>>>> drivers/virtio/virtio_mem.c:1375:18: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>>>>>      vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
>>>>>                      ^
>>>>>>> drivers/virtio/virtio_mem.c:1419:2: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
>>>>>      kfree(vm);
>>>>>      ^~~~~
>>>>>      vfree
>>>>>    cc1: some warnings being treated as errors
>>>>>
>>>>> vim +1375 drivers/virtio/virtio_mem.c
>>>>
>>>> Guess we simply need
>>>>
>>>>  #include <linux/slab.h>
>>>>
>>>> to make it work for that config.
>>>
>>>
>>> OK I added that in the 1st commit that introduced virtio-mem.
>>
>> Thanks. I have some addon-patches ready, what's the best way to continue
>> with these?
> 
> If these are bugfixes, just respin the series (including this fix).

There are two really minor bugfixes for corner-case error handling and
one simplification. I can squash them and resend, makes things easier.

The other stuff I have are extensions, I will send as add-on.

Thanks!


-- 
Thanks,

David / dhildenb
