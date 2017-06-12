From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Mon, 12 Jun 2017 23:34:06 +0300
Message-ID: <20170612194438-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<20170612181354-mutt-send-email-mst@kernel.org>
	<9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 12, 2017 at 09:42:36AM -0700, Dave Hansen wrote:
> On 06/12/2017 09:28 AM, Michael S. Tsirkin wrote:
> > 
> >> The hypervisor is going to throw away the contents of these pages,
> >> right?
> > It should be careful and only throw away contents that was there before
> > report_unused_page_block was invoked.  Hypervisor is responsible for not
> > corrupting guest memory.  But that's not something an mm patch should
> > worry about.
> 
> That makes sense.  I'm struggling to imagine how the hypervisor makes
> use of this information, though.  Does it make the pages read-only
> before this, and then it knows if there has not been a write *and* it
> gets notified via this new mechanism that it can throw the page away?

Yes, and specifically, this is how it works for migration.  Normally you
start by migrating all of memory, then send updates incrementally if
pages have been modified.  This mechanism allows skipping some pages in
the 1st stage, if they get changed they will be migrated in the 2nd
stage.

-- 
MST
