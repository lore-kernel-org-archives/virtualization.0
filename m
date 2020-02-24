From: Harpreet Singh Anand <hanand@xilinx.com>
Subject: RE: [PATCH V4 3/5] vDPA: introduce vDPA bus
Date: Mon, 24 Feb 2020 06:14:11 +0000
Message-ID: <BY5PR02MB63714A03B7135F8C4054C1E8BBEC0@BY5PR02MB6371.namprd02.prod.outlook.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220061141.29390-4-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "jgg@mellanox.com" <jgg@mellanox.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, "parav@mellanox.com" <parav@mellanox.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, aadam@r
List-Id: virtualization@lists.linuxfoundation.org

Is there a plan to add an API in vDPA_config_ops for getting the notificati=
on area from the VDPA device (something similar to get_notify_area in the V=
DPA DPDK case)? This will make the notifications from the guest  (vhost_vdp=
a use case) to the VDPA device more efficient - at least for virtio 1.0+ dr=
ivers in the VM.

I believe this would require enhancement to the vhost ioctl (something simi=
lar to the  VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG).


Regards,
Harpreet
