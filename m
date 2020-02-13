From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Thu, 13 Feb 2020 11:34:10 +0800
Message-ID: <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200212125108.GS4271@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/12 =E4=B8=8B=E5=8D=888:51, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2020 at 03:55:31PM +0800, Jason Wang wrote:
>>> The ida_simple_remove should probably be part of the class release
>>> function to make everything work right
>> It looks to me bus instead of class is the correct abstraction here si=
nce
>> the devices share a set of programming interface but not the semantics=
.
> device_release() doesn't call the bus release?


What it did is:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->release)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev->release(dev);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (dev->type && dev->ty=
pe->release)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev->type->release(dev);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (dev->class && dev->c=
lass->dev_release)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev->class->dev_release(dev);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 WARN(1, KERN_ERR "Device '%s' does not have a release(=
)=20
function, it is broken and must be fixed. See Documentation/kobject.txt.\=
n",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_na=
me(dev));

So it looks not.


>   You have dev, type or
> class to choose from. Type is rarely used and doesn't seem to be used
> by vdpa, so class seems the right choice
>
> Jason


Yes, but my understanding is class and bus are mutually exclusive. So we=20
can't add a class to a device which is already attached on a bus.

Thanks
