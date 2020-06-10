From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] vdpa: introduce virtio pci driver
Date: Wed, 10 Jun 2020 00:47:23 -0400
Message-ID: <20200610004641-mutt-send-email-mst@kernel.org>
References: <20200610035920.12078-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200610035920.12078-1-jasowang@redhat.com>
Content-Disposition: inline
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
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2020 at 11:59:20AM +0800, Jason Wang wrote:
> This patch introduce a vDPA driver for virtio-pci device. It bridges
> the virtio-pci control command to the vDPA bus. This will be used for
> developing new features for both software vDPA framework and hardware
> vDPA feature.

The mail headers are mailformed here:

Content-Type: text/plain; charset=a

so git am can't parse it:

error: cannot convert from a to UTF-8
fatal: could not parse patch

-- 
MST
