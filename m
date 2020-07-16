From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
Date: Thu, 16 Jul 2020 16:13:21 +0800
Message-ID: <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716072327.5359-10-eli@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午3:23, Eli Cohen wrote:
> Add code to support registering guest's memory region for the device.


It would be better to use "userspace" memory here since vhost-vDPA could 
be used by e.g dpdk application on the host in the future.

Thanks
