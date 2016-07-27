From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 repost 3/7] mm: add a function to get the max pfn
Date: Wed, 27 Jul 2016 15:52:06 -0700
Message-ID: <57993B16.5010703__46250.1615671956$1469899261$gmane$org@intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-4-git-send-email-liang.z.li@intel.com>
	<20160728010729-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728010729-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Liang Li <liang.z.li@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/27/2016 03:08 PM, Michael S. Tsirkin wrote:
>> > +unsigned long get_max_pfn(void)
>> > +{
>> > +	return max_pfn;
>> > +}
>> > +EXPORT_SYMBOL(get_max_pfn);
>> > +
> 
> This needs a coment that this can change at any time.
> So it's only good as a hint e.g. for sizing data structures.

Or, if we limit the batches to 1GB like you suggested earlier, then we
might not even need this exported.  It would mean that in the worst
case, we temporarily waste 28k out of the 32k allocation for a small VM
that had <128MB of memory.

That seems like a small price to pay for not having to track max_pfn
anywhere.
