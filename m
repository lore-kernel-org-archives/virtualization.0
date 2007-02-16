From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
 implementation for paravirt_ops interface
Date: Fri, 16 Feb 2007 13:48:43 -0800
Message-ID: <45D626BB.20007@vmware.com>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> On Fri, 16 Feb 2007, Zachary Amsden wrote:
>
>   
>> For the most part, it doesn't disturb VMware or KVM.  Xen does need some
>> additional functionality in paravirt-ops because they took a different design
>> choice - direct page tables instead of shadow page tables.  This is where all
>> the requirements for the new Xen paravirt-ops hooks come from.
>>     
>
> It still seems to be implemented for Xen and not to support a variety of 
> page table methods in paravirt ops.
>   

Yes, but that is just because the Xen hooks happens to be near the last 
part of the merge.  VMI required some special hooks, as do both Xen and 
lhype (I think ... Rusty can correct me if lhype's puppy's have 
precluded the addition of new hooks).  Xen page table handling is very 
different, mostly it is trap and emulate so writable page tables can 
work, which means they don't always issue hypercalls for PTE updates, 
although they do have that option, should the hypervisor MMU model 
change, or performance concerns prompt a different model (or perhaps, 
migration?)

Zach
