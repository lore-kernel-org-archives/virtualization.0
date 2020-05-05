From: David Hildenbrand <david@redhat.com>
Subject: Re: [vhost:vhost 8/22] drivers/virtio/virtio_mem.c:1375:20: error:
 implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
Date: Tue, 5 May 2020 17:46:44 +0200
Message-ID: <3eaebd8d-750a-d046-15f5-706fb00a196e@redhat.com>
References: <202005052221.83QerHmG%lkp@intel.com>
 <7dea2810-85cf-0892-20a8-bba3e3a2c133@redhat.com>
 <20200505114433-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200505114433-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05.05.20 17:44, Michael S. Tsirkin wrote:
> On Tue, May 05, 2020 at 04:50:13PM +0200, David Hildenbrand wrote:
>> On 05.05.20 16:15, kbuild test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
>>> head:   da1742791d8c0c0a8e5471f181549c4726a5c5f9
>>> commit: 7527631e900d464ed2d533f799cb0da2b29cc6f0 [8/22] virtio-mem: Paravirtualized memory hotplug
>>> config: x86_64-randconfig-b002-20200505 (attached as .config)
>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>> reproduce:
>>>         git checkout 7527631e900d464ed2d533f799cb0da2b29cc6f0
>>>         # save the attached .config to linux build tree
>>>         make ARCH=x86_64 
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>    drivers/virtio/virtio_mem.c: In function 'virtio_mem_probe':
>>>>> drivers/virtio/virtio_mem.c:1375:20: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
>>>      vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
>>>                        ^~~~~~~
>>>                        vzalloc
>>>>> drivers/virtio/virtio_mem.c:1375:18: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>>>      vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
>>>                      ^
>>>>> drivers/virtio/virtio_mem.c:1419:2: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
>>>      kfree(vm);
>>>      ^~~~~
>>>      vfree
>>>    cc1: some warnings being treated as errors
>>>
>>> vim +1375 drivers/virtio/virtio_mem.c
>>
>> Guess we simply need
>>
>>  #include <linux/slab.h>
>>
>> to make it work for that config.
> 
> 
> OK I added that in the 1st commit that introduced virtio-mem.

Thanks. I have some addon-patches ready, what's the best way to continue
with these?


-- 
Thanks,

David / dhildenb
