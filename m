From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Need information on type 2 IOMMU
Date: Sun, 9 Apr 2017 22:19:45 -0600
Message-ID: <20170409221945.2a7180d6__14236.1763086685$1491797995$gmane$org@t450s.home>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<1b48daab-c9e1-84d1-78a9-84d3e2001f32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1b48daab-c9e1-84d1-78a9-84d3e2001f32@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: valmiki <valmikibow@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, marc.zyngier@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 10 Apr 2017 08:00:45 +0530
valmiki <valmikibow@gmail.com> wrote:

> Hi All,
> 
> We have drivers/vfio/vfio_iommu_type1.c. what is type1 iommu? Is it 
> w.r.t vfio layer it is being referred?
> 
> Is there type 2 IOMMU w.r.t vfio? If so what is it?

type1 is the 1st type.  It's an arbitrary name.  There is no type2, yet.
