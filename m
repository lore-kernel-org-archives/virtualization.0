From: Harpreet Singh Anand <hanand@xilinx.com>
Subject: RE: [PATCH V4 5/5] vdpasim: vDPA device simulator
Date: Fri, 21 Feb 2020 08:33:36 +0000
Message-ID: <BY5PR02MB637195ECE0879F5F7CB72CE3BB120@BY5PR02MB6371.namprd02.prod.outlook.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220061141.29390-6-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "jgg@mellanox.com" <jgg@mellanox.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, "parav@mellanox.com" <parav@mellanox.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, aadam@r
List-Id: virtualization@lists.linuxfoundation.org

+       ret =3D device_register(&vdpasim->dev);
+       if (ret)
+               goto err_init;
+
+       vdpasim->vdpa =3D vdpa_alloc_device(dev, dev, &vdpasim_net_config_o=
ps);
+       if (ret)
+               goto err_vdpa;

[HSA] Incorrect checking of the return value of vdpa_alloc_device.
