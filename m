From: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
Date: Thu, 16 Jul 2020 11:28:40 +0300
Message-ID: <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
 <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 16, 2020 at 04:13:21PM +0800, Jason Wang wrote:
> 
> On 2020/7/16 下午3:23, Eli Cohen wrote:
> >Add code to support registering guest's memory region for the device.
> 
> 
> It would be better to use "userspace" memory here since vhost-vDPA
> could be used by e.g dpdk application on the host in the future.
> 

How about replaciing "guest's memory" with "address space". It is more
general and aligns with the with the fact that virio driver can run in
the guest's kernel.
