From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Mon, 12 Jun 2017 13:54:36 -0700
Message-ID: <d0811862-6633-a43c-90a5-629fe9b6d150__24676.9224446782$1497300884$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<20170612181354-mutt-send-email-mst@kernel.org>
	<9d0900f3-9df5-ac63-4069-2d796f2a5bc7@intel.com>
	<20170612194438-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170612194438-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 06/12/2017 01:34 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 12, 2017 at 09:42:36AM -0700, Dave Hansen wrote:
>> On 06/12/2017 09:28 AM, Michael S. Tsirkin wrote:
>>>
>>>> The hypervisor is going to throw away the contents of these pages,
>>>> right?
>>> It should be careful and only throw away contents that was there before
>>> report_unused_page_block was invoked.  Hypervisor is responsible for not
>>> corrupting guest memory.  But that's not something an mm patch should
>>> worry about.
>>
>> That makes sense.  I'm struggling to imagine how the hypervisor makes
>> use of this information, though.  Does it make the pages read-only
>> before this, and then it knows if there has not been a write *and* it
>> gets notified via this new mechanism that it can throw the page away?
> 
> Yes, and specifically, this is how it works for migration.  Normally you
> start by migrating all of memory, then send updates incrementally if
> pages have been modified.  This mechanism allows skipping some pages in
> the 1st stage, if they get changed they will be migrated in the 2nd
> stage.

OK, so the migration starts and marks everything read-only.  All the
pages now have read-only valuable data, or read-only worthless data in
the case that the page is in the free lists.  In order for a page to
become non-worthless, it has to have a write done to it, which the
hypervisor obviously knows about.

With this mechanism, the hypervisor knows it can discard pages which
have not had a write since they were known to have worthless contents.

Correct?

That also seems like pretty good information to include in the
changelog.  Otherwise, folks are going to be left wondering what good
the mechanism is.  It's pretty non-trivial to figure out. :)
