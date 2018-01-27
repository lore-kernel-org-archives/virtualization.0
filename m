From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v24 1/2] mm: support reporting free page blocks
Date: Sat, 27 Jan 2018 13:13:05 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393ED398__8970.24176451868$1517058714$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com>
	<1516790562-37889-2-git-send-email-wei.w.wang@intel.com>
	<20180125152933-mutt-send-email-mst@kernel.org>
	<5A6AA08B.2080508@intel.com>
	<20180126155224-mutt-send-email-mst@kernel.org>
	<20180126233950-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180126233950-mutt-send-email-mst@kernel.org>
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
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday, January 27, 2018 5:44 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 26, 2018 at 05:00:09PM +0200, Michael S. Tsirkin wrote:
> > On Fri, Jan 26, 2018 at 11:29:15AM +0800, Wei Wang wrote:
> > > On 01/25/2018 09:41 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Jan 24, 2018 at 06:42:41PM +0800, Wei Wang wrote:
> > > 2) If worse, all the blocks have been split into smaller blocks and
> > > used after the caller comes back.
> > >
> > > where could we continue?
> >
> > I'm not sure. But an alternative appears to be to hold a lock and just
> > block whoever wanted to use any pages.  Yes we are sending hints
> > faster but apparently something wanted these pages, and holding the
> > lock is interfering with this something.
> 
> I've been thinking about it. How about the following scheme:
> 1. register balloon to get a (new) callback when free list runs empty 2. take
> pages off the free list, add them to the balloon specific list 3. report to host 4.
> readd to free list at tail 5. if callback triggers, interrupt balloon reporting to
> host,
>    and readd to free list at tail

So in step 2, when we walk through the free page list, take each block, and add them to the balloon specific list, is this performed under the mm lock? If it is still under the lock, then what would be the difference compared to walking through the free list, and add each block to virtqueue? 

Best,
Wei
