From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Wed, 04 Mar 2015 08:02:42 +0000
Message-ID: <54F6CA32020000780006606B@mail.emea.novell.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F587BD.8010606@citrix.com>
	<CAB=NE6WWqP959DHN==XzrOhg5i8+xMZNmHcuBSbuyf-4tcRCtQ@mail.gmail.com>
	<54F68FB0.1040909@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54F68FB0.1040909@suse.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <JGross@suse.com>, Luis Rodriguez <Mcgrof@Suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 04.03.15 at 05:53, <JGross@suse.com> wrote:
> On 03/03/2015 08:20 PM, Luis R. Rodriguez wrote:
>> On Tue, Mar 3, 2015 at 2:06 AM, David Vrabel <david.vrabel@citrix.com> wrote:
>>> On 03/03/15 09:40, Luis R. Rodriguez wrote:
>>>> if X86_64 && SPARSEMEM_VMEMMAP
>>>>
>>>> Now Xen should not have SPARSEMEM_VMEMMAP but PVOPs' goal is to enable
>>>
>>> Why?  Again, this is the first I've heard of this as well.  FWIW, all
>>> the Xen configs we use have SPARSEMEM_VMEMMAP enabled.
>>
>> Interesting... we have config ARCH_SPARSEMEM_ENABLE depend on !XEN at
>> SUSE. Figured this was a generic issue. The SUSE kernels are based on
>> 3.12 though, but anyway with it enabled I do get compile failures
>> because of redefinition of MAX_PHYSMEM_BITS which we provide on Xen
>> set to 43 for some reason (can't find that justification), so it
>> doesn't use the default 46 that would be used otherwise. But another
>> reason seems to be the lack of forward porting yet PAT support for PV
>> domains -- commit 47591df50 upstream which requires us to still have
>> the union on the pte_t, and I suppose we need ca15f20f as well...
>>
>> If there is nothing else I suppose this just requires fixing up at
>> SUSE's end for SPARSEMEM_VMEMMAP...
> 
> The SUSE kernel has several patches renaming/altering Xen-related config
> options. Don't mix that up with upstream/pvops.

Exactly - some of what our kernels do in this regard could be useful
upstream, while others (like this one) won't be. Prior to making claims
against upstream kernels you should tell between these cases.

Jan
