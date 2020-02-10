From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 4/5] virtio: introduce a vDPA based transport
Date: Mon, 10 Feb 2020 09:34:42 -0400
Message-ID: <20200210133442.GS23346@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200210035608.10002-5-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, mhabets@solarflare.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com, haotian.wang@sifive.com, shahafs@mellanox.com, parav@mellanox.com, jiri@mellanox.com, xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, netdev@vger.kernel.org, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 10, 2020 at 11:56:07AM +0800, Jason Wang wrote:
> This patch introduces a vDPA transport for virtio. This is used to
> use kernel virtio driver to drive the mediated device that is capable
> of populating virtqueue directly.

Is this comment still right? Is there a mediated device still?

Jason
