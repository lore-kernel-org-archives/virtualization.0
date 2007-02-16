From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd cache
Date: Fri, 16 Feb 2007 20:19:52 +1100
Message-ID: <45D57738.9030907@yahoo.com.au>
References: <20070216022449.739760547@goop.org>	 <20070216022531.047039320@goop.org> <84144f020702160039y11fb1f4dl7b77d4358cc189ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423459AbXBPJUb@vger.kernel.org>
In-Reply-To: <84144f020702160039y11fb1f4dl7b77d4358cc189ee@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Pekka Enberg wrote:
> On 2/16/07, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
>> Remove the ctor for the pgd cache.  There's no point in having the
>> cache machinery do this via an indirect call when all pgd are freed in
>> the one place anyway.
> 
> 
> The reason we have slab constructors and destructors is to _avoid_
> reinitializing every time we allocate an object. AFAICT your changing
> the code now to do _more_ work than before, so is there some other
> reason why you want to do this than avoiding an indirect call?

Sometimes  it is better for the caches to initialise an object
immediately, but in this case I think it is better to use the
slab ctor because it is very unlikely to use many cachelines
immediately anyway.

It would be nice to put the "why" in the changelogs, rather than
"what". Not everyone wants to go through the whole patchset to
decipher why Xen possibly needs something.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
