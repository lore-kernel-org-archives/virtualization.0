From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Tue, 4 Feb 2020 01:01:48 -0500
Message-ID: <20200204005306-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
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
Cc: kvm@vger.kernel.org, mhabets@solarflare.com, virtualization@lists.linux-foundation.org, jgg@mellanox.com, rob.miller@broadcom.com, lulu@redhat.com, maxime.coquelin@redhat.com, hch@infradead.org, eperezma@redhat.com, haotian.wang@sifive.com, shahafs@mellanox.com, parav@mellanox.com, jiri@mellanox.com, zhihong.wang@intel.com, netdev@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, hanand@xilinx.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> 5) generate diffs of memory table and using IOMMU API to setup the dma
> mapping in this method

Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?

-- 
MST
