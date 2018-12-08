From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC 0/3] virtio_ring: define flags as shifts consistently
Date: Sat, 8 Dec 2018 21:26:57 +0800
Message-ID: <20181208132656.GA29772__44152.987903408$1544275611$gmane$org@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
	<20181207131058-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181207131058-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 07, 2018 at 01:11:42PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:39PM +0800, Tiwei Bie wrote:
> > This is a follow up of the discussion in this thread:
> > https://patchwork.ozlabs.org/patch/1001015/#2042353
> 
> How was this tested? I'd suggest building virtio
> before and after the changes, stripped binary
> should be exactly the same.

Sure, I will do the test with scripts/objdiff.

> 
> 
> > Tiwei Bie (3):
> >   virtio_ring: define flags as shifts consistently
> >   virtio_ring: add VIRTIO_RING_NO_LEGACY
> >   virtio_ring: use new vring flags
> > 
> >  drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
> >  include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
> >  2 files changed, 103 insertions(+), 58 deletions(-)
> > 
> > -- 
> > 2.17.1
