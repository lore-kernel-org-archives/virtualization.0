From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Tue, 20 Jun 2017 18:49:33 +0200
Message-ID: <7b626551-6d1b-c8d5-4ef7-e357399e78dc__4272.92670724473$1497977433$gmane$org@redhat.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497977049.20270.100.camel@redhat.com>
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
To: Rik van Riel <riel@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 20.06.2017 18:44, Rik van Riel wrote:
> On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:
> 
>> The hypervisor is going to throw away the contents of these pages,
>> right?  As soon as the spinlock is released, someone can allocate a
>> page, and put good data in it.  What keeps the hypervisor from
>> throwing
>> away good data?
> 
> That looks like it may be the wrong API, then?
> 
> We already have hooks called arch_free_page and
> arch_alloc_page in the VM, which are called when
> pages are freed, and allocated, respectively.
> 
> Nitesh Lal (on the CC list) is working on a way
> to efficiently batch recently freed pages for
> free page hinting to the hypervisor.
> 
> If that is done efficiently enough (eg. with
> MADV_FREE on the hypervisor side for lazy freeing,
> and lazy later re-use of the pages), do we still
> need the harder to use batch interface from this
> patch?
> 
David's opinion incoming:

No, I think proper free page hinting would be the optimum solution, if
done right. This would avoid the batch interface and even turn
virtio-balloon in some sense useless.

-- 

Thanks,

David
