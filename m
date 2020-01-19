From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Sun, 19 Jan 2020 04:59:20 -0500
Message-ID: <20200119045849-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Shahaf Shuler <shahafs@mellanox.com>
Cc: Rob Miller <rob.miller@broadcom.com>, Jason Wang <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mel>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 19, 2020 at 09:07:09AM +0000, Shahaf Shuler wrote:
> >Technically, we can keep the incremental API 
> >here and let the vendor vDPA drivers to record the full mapping 
> >internally which may slightly increase the complexity of vendor driver. 
> 
> What will be the trigger for the driver to know it received the last mapping on this series and it can now push it to the on-chip IOMMU?

Some kind of invalidate API?

-- 
MST
