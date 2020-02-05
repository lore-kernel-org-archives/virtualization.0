From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 11:11:08 +0800
Message-ID: <ad1707a0-7884-1329-52c6-8139230a930c@redhat.com>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200205020247.GA368700@___>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/5 =E4=B8=8A=E5=8D=8810:02, Tiwei Bie wrote:
>> Before trying to do this it looks to me we need the following during t=
he
>> probe
>>
>> 1) if set_map() is not supported by the vDPA device probe the IOMMU th=
at is
>> supported by the vDPA device
>> 2) allocate IOMMU domain
>>
>> And then:
>>
>> 3) pin pages through GUP and do proper accounting
>> 4) store GPA->HPA mapping in the umem
>> 5) generate diffs of memory table and using IOMMU API to setup the dma
>> mapping in this method
>>
>> For 1), I'm not sure parent is sufficient for to doing this or need to
>> introduce new API like iommu_device in mdev.
> Agree. We may also need to introduce something like
> the iommu_device.
>

Right, this is what I plan to do in next version.

Thanks
