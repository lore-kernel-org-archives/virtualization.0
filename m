From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vdpa: introduce virtio pci driver
Date: Wed, 10 Jun 2020 13:44:30 +0800
Message-ID: <eaa0739f-4c4b-3ca5-c57d-5962b3c3dbc0@redhat.com>
References: <20200610035920.12078-1-jasowang@redhat.com>
 <20200610004641-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200610004641-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/10 下午12:47, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 11:59:20AM +0800, Jason Wang wrote:
>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>> the virtio-pci control command to the vDPA bus. This will be used for
>> developing new features for both software vDPA framework and hardware
>> vDPA feature.
> The mail headers are mailformed here:
>
> Content-Type: text/plain; charset=a
>
> so git am can't parse it:
>
> error: cannot convert from a to UTF-8
> fatal: could not parse patch


My bad, let me repost.

Thanks
