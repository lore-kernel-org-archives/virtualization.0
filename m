From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 3/5] vDPA: introduce vDPA bus
Date: Mon, 24 Feb 2020 14:48:48 +0800
Message-ID: <d6ea5dcb-3933-920b-523e-a494d323ef8a@redhat.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-4-jasowang@redhat.com>
 <BY5PR02MB63714A03B7135F8C4054C1E8BBEC0@BY5PR02MB6371.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <BY5PR02MB63714A03B7135F8C4054C1E8BBEC0@BY5PR02MB6371.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Harpreet Singh Anand <hanand@xilinx.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "jgg@mellanox.com" <jgg@mellanox.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, "parav@mellanox.com" <parav@mellanox.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, aadam@r
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/24 =E4=B8=8B=E5=8D=882:14, Harpreet Singh Anand wrote:
> Is there a plan to add an API in vDPA_config_ops for getting the notifi=
cation area from the VDPA device (something similar to get_notify_area in=
 the VDPA DPDK case)? This will make the notifications from the guest  (v=
host_vdpa use case) to the VDPA device more efficient - at least for virt=
io 1.0+ drivers in the VM.
>
> I believe this would require enhancement to the vhost ioctl (something =
similar to the  VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG).


Yes, we plan to add that on top. Basically, here's what we plan to do:=20
(sorted by urgency)

1) direct doorbell mapping as you asked here
2) direct interrupt injection (when platform support, e.g through posted=20
interrupt)
3) control virtqueue support

Thanks


>
>
> Regards,
> Harpreet
>
