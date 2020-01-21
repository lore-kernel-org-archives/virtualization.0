From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Tue, 21 Jan 2020 14:05:04 +0000
Message-ID: <20200121140456.GA12330@mellanox.com>
References: <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
 <20200121004047-mutt-send-email-mst@kernel.org>
 <b9ad744e-c4cd-82f9-f56a-1ecc185e9cd7@redhat.com>
 <20200121031506-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121031506-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-ID: <D0177E206524614887B01CF5999DBC5C@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>, Rob Miller <rob.miller@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@m>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 21, 2020 at 03:15:43AM -0500, Michael S. Tsirkin wrote:
> > This sounds more flexible e.g driver may choose to implement static map=
ping
> > one through commit. But a question here, it looks to me this still requ=
ires
> > the DMA to be synced with at least commit here. Otherwise device may ge=
t DMA
> > fault? Or device is expected to be paused DMA during begin?
> >=20
> > Thanks
>=20
> For example, commit might switch one set of tables for another,
> without need to pause DMA.

I'm not aware of any hardware that can do something like this
completely atomically..

Any mapping change API has to be based around add/remove regions
without any active DMA (ie active DMA is a guest error the guest can
be crashed if it does this)

Jason
