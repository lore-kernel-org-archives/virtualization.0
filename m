From: Zachary Amsden <zach@vmware.com>
Subject: Re: pv_ops smp support
Date: Thu, 19 Oct 2006 21:48:27 -0700
Message-ID: <4538551B.9080009@vmware.com>
References: <453805BF.80301@goop.org> <45380B6A.3030104@vmware.com>
	<45380EDD.2070809@goop.org> <4538121E.7090607@vmware.com>
	<45384BAA.5070303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45384BAA.5070303@goop.org>
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

Jeremy Fitzhardinge wrote:
>
>> I think you might want to optimize this a bit more, however, since in =

>> some cases you will issue implicit shootdown IPIs during a pte update =

>> hypercall.
>
> Not that I've seen, at least none that doesn't also exist in baseline.

But if Xen uses direct page tables, the update to a page table through a =

hypercall can cause other CPUs with that direct page table loaded to =

require an invalidation.  <Pauses>.  Never mind, I see that you don't =

require an immediate invalidation.  Instead, you use page type =

enforcement to guarantee that page remappings can not be used to subvert =

hypervisor protection, and would either disallow or issue TLB =

invalidations on page type changes from PT to writable pages.  In that =

case, the guest must use TLB shootdown to guarantee correctness, but no =

extra TLB shootdowns are required to guarantee hypervisor security, as I =

had feared.

>
>> This seems much cleaner than designing the shootdown semantic =

>> directly into such PTE updates, which is I believe what some of the =

>> older Xen patches did, although I could have misread them.
>
> I was starting on SMP with the idea that it would be relatively =

> isolated and simple, but it seems I should probably do the MMU stuff =

> first to see what impact it has on SMP.

I think I was imagining some complications which really don't exist, but =

it certainly doesn't hurt to consider the Xen MMU interfaces as you iron =

out the SMP issues.

So perhaps SMP will be more straightforward than I expected.

Zach
