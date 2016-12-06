From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Tue, 6 Dec 2016 09:40:47 +0100
Message-ID: <f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, kvm@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, mhocko@suse.com, mst@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, dgilbert@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, kirill.shutemov@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

Am 30.11.2016 um 09:43 schrieb Liang Li:
> This patch set contains two parts of changes to the virtio-balloon.
>
> One is the change for speeding up the inflating & deflating process,
> the main idea of this optimization is to use bitmap to send the page
> information to host instead of the PFNs, to reduce the overhead of
> virtio data transmission, address translation and madvise(). This can
> help to improve the performance by about 85%.

Do you have some statistics/some rough feeling how many consecutive bits 
are usually set in the bitmaps? Is it really just purely random or is 
there some granularity that is usually consecutive?

IOW in real examples, do we have really large consecutive areas or are 
all pages just completely distributed over our memory?

Thanks!

-- 

David
