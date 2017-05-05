From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v9 2/5] virtio-balloon:
	VIRTIO_BALLOON_F_BALLOON_CHUNKS
Date: Sat, 6 May 2017 01:25:32 +0300
Message-ID: <20170506012322-mutt-send-email-mst__36508.5977748551$1494023144$gmane$org@kernel.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
	<58F08A60.2020407@intel.com>
	<20170415000934-mutt-send-email-mst@kernel.org>
	<58F43801.7060004@intel.com>
	<286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
	<20170426192753-mutt-send-email-mst@kernel.org>
	<59019055.3040708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59019055.3040708@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 27, 2017 at 02:31:49PM +0800, Wei Wang wrote:
> On 04/27/2017 07:20 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 26, 2017 at 11:03:34AM +0000, Wang, Wei W wrote:
> > > Hi Michael, could you please give some feedback?
> > I'm sorry, I'm not sure feedback on what you are requesting.
> Oh, just some trivial things (e.g. use a field in the
> header, hdr->chunks to indicate the number of chunks
> in the payload) that wasn't confirmed.
> 
> I will prepare the new version with fixing the agreed issues,
> and we can continue to discuss those parts if you still find
> them improper.
> 
> 
> > 
> > The interface looks reasonable now, even though there's
> > a way to make it even simpler if we can limit chunk size
> > to 2G (in fact 4G - 1). Do you think we can live with this
> > limitation?
> Yes, I think we can. So, is it good to change to use the
> previous 64-bit chunk format (52-bit base + 12-bit size)?

This isn't what I meant. virtio ring has descriptors with
a 64 bit address and 32 bit size.

If size < 4g is not a significant limitation, why not just
use that to pass address/size in a standard s/g list,
possibly using INDIRECT?

> 
> > 
> > But the code still needs some cleanup.
> > 
> 
> OK. We'll also still to discuss your comments in the patch 05.
> 
> Best,
> Wei
