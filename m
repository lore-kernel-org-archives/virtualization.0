From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH v5] vhost: introduce mdev based hardware backend
Date: Wed, 6 Nov 2019 22:39:07 +0800
Message-ID: <20191106143907.GA10776__994.049692393162$1573051116$gmane$org@___>
References: <20191105115332.11026-1-tiwei.bie@intel.com>
	<20191106075733-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191106075733-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zhihong.wang@intel.com, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, netdev@vger.kernel.org, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 06, 2019 at 07:59:02AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 05, 2019 at 07:53:32PM +0800, Tiwei Bie wrote:
> > This patch introduces a mdev based hardware vhost backend.
> > This backend is built on top of the same abstraction used
> > in virtio-mdev and provides a generic vhost interface for
> > userspace to accelerate the virtio devices in guest.
> > 
> > This backend is implemented as a mdev device driver on top
> > of the same mdev device ops used in virtio-mdev but using
> > a different mdev class id, and it will register the device
> > as a VFIO device for userspace to use. Userspace can setup
> > the IOMMU with the existing VFIO container/group APIs and
> > then get the device fd with the device name. After getting
> > the device fd, userspace can use vhost ioctls on top of it
> > to setup the backend.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> So at this point, looks like the only thing missing is IFC, and then all
> these patches can go in.
> But as IFC is still being worked on anyway, it makes sense to
> address the minor comments manwhile so we don't need
> patches on top.
> Right?

Yeah, of course.

Thanks,
Tiwei
