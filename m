From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [patch 18/24] Xen-paravirt_ops: Some generic early printk & boot
 console fixups
Date: Thu, 22 Feb 2007 09:33:02 +0100
Message-ID: <45DD553E.4000301@suse.de>
References: <20070221205254.169835700@goop.org>	<20070221205323.842917348@goop.org> <20070221191047.8d21acaa.akpm@linux-foundation.org> <45DD2E9E.5030601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751388AbXBVIdQ@vger.kernel.org>
In-Reply-To: <45DD2E9E.5030601@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Andrew Morton wrote:
>> hm, this patch series seems to have gone out of its way to cause problems.
>>
>> This particular (pathetically changelogged) patch is already in my tree,
>> only in a later, much more comprehensive form.  Similarly the HVC changes
>> were already in Rusty's stuff and were supposed to be merged by Paulus, but
>> haven't been yet.
>>
>> Can we just drop this one?  Does the Xen work actually depend on it?

Yes.  The other which made it into -mm via lkml is a more recent version
of the same patch (+documentation, +!x86 arch updates).

On the hvm_console.c changes: there is just a small change needed to
make it build on !ppc, that should be identical identical in my (xen)
and rusty (lguest) patch series.  Patching it only once is fine for
obvious reasons ;)

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
