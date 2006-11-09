From: Zachary Amsden <zach@vmware.com>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Thu, 09 Nov 2006 01:15:49 -0800
Message-ID: <4552F1C5.9060800@vmware.com>
References: <C178974F.4076%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <C178974F.4076%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> On 8/11/06 11:25 pm, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
>
>   =

>> Keir Fraser wrote:
>>     =

>>> Another
>>> factoid I discovered at the same meeting is that the CPU may cache part=
ial
>>> page walks. So, for example, just because you 'detach' a page table fro=
m a
>>> page-directory entry, doesn't mean that page table won't be accessed on
>>> future hardware TLB fills.
>>>       =


Yes.  The rule is, if you change a mapping at any level, your results of =

using any descendants of that mapping for memory access are undefined =

unless you have flushed the mappings you are trying to use.

>> Do you know if these intermediate TLB entries are level-sensitive?  Ie,
>> if you have a linear pagetable mapping where the pagetable points back
>> to itself, will that result in multiple TLB entries for the pmd pages
>> (pmd as pmd, and pmd as pte)?
>>     =

>
> I think so. I can't think why the CPU would bother to disallow this. It d=
oes
> mean you have to be careful when changing page-directory entries that your
> linear mapping (if you have one) doesn't go stale.
>   =


No, as long as the pmd is only mapped in one linear address, there is =

only one TLB entry for it.  You can't mix large pages and circular =

pagetables, so you can't have a pmd as pmd level TLB mapping in addition =

to a pmd as pte level mapping.  Thinking of it as pmd as pmd  / pmd as =

pte level mapping is confusing.  It is better to think of it in terms of =

physical page walks during TLB fills and virtual walks during circular =

mapping access.

You do need to issue appropriate page invalidations after changing =

page-directory level mappings for the page tables.  If you update PDEs =

and you use a circular mapping of page tables, then you may need to =

issue invlpg's for the page tables that may have been disconnected or =

changed.  This is for your consistency, not the TLB consistency.  The =

TLB will fetch new mappings from physical space, and knows nothing about =

your circular mapping.  So a PDE update to an entire 4M/2M range could =

require multiple flushes - one or more to invalidate mappings of =

underlying PTEs that have changed, and one to invalidate the mapping of =

the circularly mapped page table itself.

Of course, depending on the context and your consistency requirements, =

some or all of these flushes may be redundant or subsumed by subsequent =

flushes.

Zach
