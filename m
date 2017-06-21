From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
	on the free list
Date: Wed, 21 Jun 2017 16:38:23 +0800
Message-ID: <594A307F.1090108__15698.902300983$1498034178$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>	<1497977049.20270.100.camel@redhat.com>	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497979740.20270.102.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/21/2017 01:29 AM, Rik van Riel wrote:
> On Tue, 2017-06-20 at 18:49 +0200, David Hildenbrand wrote:
>> On 20.06.2017 18:44, Rik van Riel wrote:
>>> Nitesh Lal (on the CC list) is working on a way
>>> to efficiently batch recently freed pages for
>>> free page hinting to the hypervisor.
>>>
>>> If that is done efficiently enough (eg. with
>>> MADV_FREE on the hypervisor side for lazy freeing,
>>> and lazy later re-use of the pages), do we still
>>> need the harder to use batch interface from this
>>> patch?
>>>
>> David's opinion incoming:
>>
>> No, I think proper free page hinting would be the optimum solution,
>> if
>> done right. This would avoid the batch interface and even turn
>> virtio-balloon in some sense useless.
> I agree with that.  Let me go into some more detail of
> what Nitesh is implementing:
>
> 1) In arch_free_page, the being-freed page is added
>     to a per-cpu set of freed pages.

I got some questions here:

1. Are the pages managed one by one on the per-CPU set?
For example, when there are 2 adjacent pages, are they still
put as two nodes on the per-CPU list? or the buddy algorithm
will be re-implemented on the per-CPU list as well?

2. Looks like this will be added to the common free function.
Normally, people may not need the free page hint, do they
need to carry the added burden?


> 2) Once that set is full, arch_free_pages goes into a
>     slow path, which:
>     2a) Iterates over the set of freed pages, and
>     2b) Checks whether they are still free, and

The pages that have been double checked as "free"
pages here and added to the list for the hypervisor can
also be immediately used.


>     2c) Adds the still free pages to a list that is
>         to be passed to the hypervisor, to be MADV_FREEd.
>     2d) Makes that hypercall.
>
> Meanwhile all arch_alloc_pages has to do is make sure it
> does not allocate a page while it is currently being
> MADV_FREEd on the hypervisor side.

Is this proposed to replace the balloon driver?

>
> The code Wei is working on looks like it could be
> suitable for steps (2c) and (2d) above. Nitesh already
> has code for steps 1 through 2b.
>

May I know the advantages of the added steps? Thanks.

Best,
Wei
