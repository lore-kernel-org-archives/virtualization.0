From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC/PATCH LGUEST X86_64 00/13] Lguest for the x86_64
Date: Fri, 09 Mar 2007 13:20:33 +0200
Message-ID: <45F14301.9090007@qumranet.com>
References: <1173375492.32170.1.camel@localhost.localdomain>
	<1173399509.32234.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173399509.32234.61.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> To prevent a guest from stealing all the hosts memory pages, we can
>> use these hashes to also limit the number of puds, pmds, and ptes.
>>
>> If the page is not pinned (currently used), we can set up LRU lists,
>> and find those pages that are somewhat stale, and free them.  This
>> can be done safely since we have all the info we need to put them
>> back if the guest needs them again.
>>     =

>
> This is the same issue with 32-bit (one main reason why it's root-only).
> In my case it's not too hard to add a shrinker (it would drop PTE pages
> out of the pagetable of any non-running guest, just needs locking), but
> we also want to avoid pinning in guest (ie. userspace) pages: for this I
> think we really want a per-mm callback when the swapper wants to kick
> something out.
>
> I imagine kvm will have the same or similar issues (they restrict their
> pagetables to 256 pages per guest, which is simultanously too many and
> too few IMHO).
>   =


We have similar issues, but they are easily fixed since at most four =

pages are pinned per vcpu (sixteen with Ingo's cr3 cache).  A per-mm =

swapper callback sounds great, especially when thinking about swapping =

regular guest pages, and even more in the context of nested page tables.

-- =

Do not meddle in the internals of kernels, for they are subtle and quick to=
 panic.
