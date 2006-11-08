From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Wed, 08 Nov 2006 23:17:15 +0000
Message-ID: <C17815FB.403A%Keir.Fraser@cl.cam.ac.uk>
References: <45523B85.1080004@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45523B85.1080004@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/11/06 8:18 pm, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

>> Do you mean the tlb entry gets invalidated as part of raising the
>> fault?
>>   =

> =

> Specifically, does it simply invalidate the TLB at that point, or does
> it re-walk the page table and populate it with the new PTE?

It invalidates the TLB entry, to avoid a fault loop, but it will then #PF
rather than walk the page tables in hardware. I believe this is to speed up
the fairly common CoW fault path. I don't know whether it is actually
documented anywhere: the x86 'architecture' seems to be defined by the
behaviour of the various hardware implementations. I discovered this
particular factoid from talking to one of the Intel hardware guys. Another
factoid I discovered at the same meeting is that the CPU may cache partial
page walks. So, for example, just because you 'detach' a page table from a
page-directory entry, doesn't mean that page table won't be accessed on
future hardware TLB fills. I confirmed both these factoids by constructing
simple test cases: IIRC both AMD and Intel CPUs exhibit both behaviours.

 -- Keir
