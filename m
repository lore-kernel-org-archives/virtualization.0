From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Tue, 4 Feb 2020 14:46:16 +0800
Message-ID: <cf485e7f-46e3-20d3-8452-e3058b885d0a@redhat.com>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200204005306-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200204005306-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/4 =E4=B8=8B=E5=8D=882:01, Michael S. Tsirkin wrote:
> On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
>> 5) generate diffs of memory table and using IOMMU API to setup the dma
>> mapping in this method
> Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?
>

Sure, so that basically VHOST_IOTLB_UPDATE/INVALIDATE I think?

Thanks
