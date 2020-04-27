From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 0/3] vdpa: Support config interrupt in vhost_vdpa
Date: Mon, 27 Apr 2020 11:31:05 +0800
Message-ID: <ff2471ae-254e-7697-72b7-6601a561c3d9@redhat.com>
References: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/26 =E4=B8=8B=E5=8D=887:43, Zhu Lingshan wrote:
> This series includes two patches, one introduced
> config interrupt support in VDPA core, the other
> one implemented config interrupt in IFCVF.
>
> changes from V3:
> move changes in driver/vhost/vhost.c to a
> separated patch.
>
> changes from V2:
> move VHOST_FILE_UNBIND to the uapi header.
>
> changes from V1:
> vdpa: more efficient code to handle eventfd unbind.
> ifcvf: add VIRTIO_NET_F_STATUS feature bit.


5.8 material I think.

Acked-by: Jason Wang <jasowang@redhat.com>


>
> Zhu Lingshan (3):
>    vdpa: Support config interrupt in vhost_vdpa
>    vhost: replace -1 with  VHOST_FILE_UNBIND in iotcls
>    vdpa: implement config interrupt in IFCVF
>
>   drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
>   drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
>   drivers/vdpa/ifcvf/ifcvf_main.c | 22 ++++++++++++++++++-
>   drivers/vhost/vdpa.c            | 47 ++++++++++++++++++++++++++++++++=
+++++++++
>   drivers/vhost/vhost.c           |  8 +++----
>   include/uapi/linux/vhost.h      |  4 ++++
>   6 files changed, 82 insertions(+), 5 deletions(-)
>
