From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd
	cache
Date: Fri, 16 Feb 2007 09:19:35 -0800
Message-ID: <45D5E7A7.3090400@goop.org>
References: <20070216022449.739760547@goop.org>	
	<20070216022531.047039320@goop.org>
	<84144f020702160039y11fb1f4dl7b77d4358cc189ee@mail.gmail.com>
	<45D57738.9030907@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D57738.9030907@yahoo.com.au>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Nick Piggin wrote:
> Pekka Enberg wrote:
>> On 2/16/07, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>>
>>> Remove the ctor for the pgd cache.  There's no point in having the
>>> cache machinery do this via an indirect call when all pgd are freed in
>>> the one place anyway.
>>
>>
>> The reason we have slab constructors and destructors is to _avoid_
>> reinitializing every time we allocate an object. AFAICT your changing
>> the code now to do _more_ work than before, so is there some other
>> reason why you want to do this than avoiding an indirect call?
>
> Sometimes  it is better for the caches to initialise an object
> immediately, but in this case I think it is better to use the
> slab ctor because it is very unlikely to use many cachelines
> immediately anyway.
>
> It would be nice to put the "why" in the changelogs, rather than
> "what". Not everyone wants to go through the whole patchset to
> decipher why Xen possibly needs something.

Hm, I think I was mislead by looking at kmem_cache_alloc in slob.c
rather than the one that's actually used in slab.c.  There's no
particular Xen reason for this patch, so I can drop it.

    J
