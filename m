From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
Date: Thu, 16 Jul 2020 17:32:38 +0800
Message-ID: <ad3c6157-2224-8e1f-7afb-deb9b45f568e@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
 <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
 <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午4:28, Eli Cohen wrote:
> On Thu, Jul 16, 2020 at 04:13:21PM +0800, Jason Wang wrote:
>> On 2020/7/16 下午3:23, Eli Cohen wrote:
>>> Add code to support registering guest's memory region for the device.
>>
>> It would be better to use "userspace" memory here since vhost-vDPA
>> could be used by e.g dpdk application on the host in the future.
>>
> How about replaciing "guest's memory" with "address space". It is more
> general and aligns with the with the fact that virio driver can run in
> the guest's kernel.


Probably but note that guest driver is not the only user for this. It 
could be either:

1) Guest virtio driver
2) Userspace virtio driver on the host
3) Kernel virtio driver on the host.

Thanks


>
