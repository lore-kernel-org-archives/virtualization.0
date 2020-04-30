From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Thu, 30 Apr 2020 11:20:08 -0400
Message-ID: <20200430152008.GB872@char.us.oracle.com>
References: <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200429061621-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, will@kernel.org, jan.kiszka@siemens.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, christoffer.dall@arm.com, pratikp@codeaurora.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 29, 2020 at 06:20:48AM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > That would still not work I think where swiotlb is used for pass-thr devices
> > (when private memory is fine) as well as virtio devices (when shared memory is
> > required).
> 
> So that is a separate question. When there are multiple untrusted
> devices, at the moment it looks like a single bounce buffer is used.
> 
> Which to me seems like a security problem, I think we should protect
> untrusted devices from each other.

There are two DMA pools code in Linux already - the TTM one for graphics
and the mm/dmapool.c - could those be used instead? Or augmented at least?
