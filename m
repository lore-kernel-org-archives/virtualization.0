From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v9 5/5] virtio-balloon: VIRTIO_BALLOON_F_MISC_VQ
Date: Sun, 7 May 2017 04:20:51 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7391FFBCB__29724.7262941257$1494130864$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-6-git-send-email-wei.w.wang@intel.com>
	<20170413194732-mutt-send-email-mst@kernel.org>
	<590190C8.6030609@intel.com>
	<20170506011928-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170506011928-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 05/06/2017 06:21 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 27, 2017 at 02:33:44PM +0800, Wei Wang wrote:
> > On 04/14/2017 01:08 AM, Michael S. Tsirkin wrote:
> > > On Thu, Apr 13, 2017 at 05:35:08PM +0800, Wei Wang wrote:
> > > > Add a new vq, miscq, to handle miscellaneous requests between the
> > > > device and the driver.
> > > >
> > > > This patch implemnts the
> VIRTIO_BALLOON_MISCQ_INQUIRE_UNUSED_PAGES
> > > implements
> > >
> > > > request sent from the device.
> > > Commands are sent from host and handled on guest.
> > > In fact how is this so different from stats?
> > > How about reusing the stats vq then? You can use one buffer for
> > > stats and one buffer for commands.
> > >
> >
> > The meaning of the two vqs is a little different. statq is used for
> > reporting statistics, while miscq is intended to be used to handle
> > miscellaneous requests from the guest or host
> 
> misc just means "anything goes". If you want it to mean "commands" name it so.

Ok, will change it.

> > (I think it can
> > also be used the other way around in the future when other new
> > features are added which need the guest to send requests and the host
> > to provide responses).
> >
> > I would prefer to have them separate, because:
> > If we plan to combine them, we need to put the previous statq related
> > implementation under miscq with a new command (I think we can't
> > combine them without using commands to distinguish the two features).
> 
> Right.

> > In this way, an old driver won't work with a new QEMU or a new driver
> > won't work with an old QEMU. Would this be considered as an issue
> > here?
> 
> Compatibility is and should always be handled using feature flags.  There's a
> feature flag for this, isn't it?

The negotiation of the existing feature flag, VIRTIO_BALLOON_F_STATS_VQ
only indicates the support of the old statq implementation. To move the statq
implementation under cmdq, I think we would need a new feature flag for the
new statq implementation:
#define VIRTIO_BALLOON_F_CMDQ_STATS      5

What do you think?

Best,
Wei
