From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v30 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 5 Apr 2018 17:03:40 +0300
Message-ID: <20180405170248-mutt-send-email-mst__22823.5911847607$1522936910$gmane$org@kernel.org>
References: <1522771805-78927-1-git-send-email-wei.w.wang@intel.com>
	<1522771805-78927-3-git-send-email-wei.w.wang@intel.com>
	<20180403214147-mutt-send-email-mst@kernel.org>
	<5AC43377.2070607@intel.com>
	<20180404155907-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7394A6E96@shsmsx102.ccr.corp.intel.com>
	<20180405040900-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7394A7F3B@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7394A7F3B@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "huangzhichao@huawei.com" <huangzhichao@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 05, 2018 at 02:05:03AM +0000, Wang, Wei W wrote:
> On Thursday, April 5, 2018 9:12 AM, Michael S. Tsirkin wrote:
> > On Thu, Apr 05, 2018 at 12:30:27AM +0000, Wang, Wei W wrote:
> > > On Wednesday, April 4, 2018 10:08 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Apr 04, 2018 at 10:07:51AM +0800, Wei Wang wrote:
> > > > > On 04/04/2018 02:47 AM, Michael S. Tsirkin wrote:
> > > > > > On Wed, Apr 04, 2018 at 12:10:03AM +0800, Wei Wang wrote:
> > > I'm afraid the driver couldn't be aware if the added hints are stale
> > > or not,
> > 
> > 
> > No - I mean that driver has code that compares two values and stops
> > reporting. Can one of the values be stale?
> 
> The driver compares "vb->cmd_id_use != vb->cmd_id_received" to decide if it needs to stop reporting hints, and cmd_id_received is what the driver reads from host (host notifies the driver to read for the latest value). If host sends a new cmd id, it will notify the guest to read again. I'm not sure how that could be a stale cmd id (or maybe I misunderstood your point here?)
> 
> Best,
> Wei

The comparison is done in one thread, the update in another one.

-- 
MST
