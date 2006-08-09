From: Andrew Theurer <habanero@us.ibm.com>
Subject: Re: turn off writable page tables
Date: Wed, 09 Aug 2006 16:15:09 -0500
Message-ID: <44DA505D.2080209@us.ibm.com>
References: <44CA8369.9080200@vmware.com> <200607290105.46208.ak@suse.de>
	<44CA9974.9030804@vmware.com>
	<ea3c8cf85efac33049bfe90a034611ea@cl.cam.ac.uk>
	<44CDCE1C.1000302@vmware.com>
	<07059add50c2b7826e967218da89c140@cl.cam.ac.uk>
	<44CE6055.3000902@vmware.com>
	<f645c5d8d45744f91cdc02f66600ac6d@cl.cam.ac.uk>
	<44CE86D3.8060108@vmware.com>
	<b697aac4e14fc79768904261be24e5a5@cl.cam.ac.uk>
	<20060803204205.GA29014@mdday.raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20060803204205.GA29014@mdday.raleigh.ibm.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Zachary Amsden <zach@vmware.com>, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>, xen-devel@lists.xensource.com, Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Mike D. Day wrote:
> On 02/08/06 10:21 +0100, Keir Fraser wrote:
>
>> I wonder how it will interact with our late-pin/early-unpin model 
>> where we can directly write to pagetables before they are first used 
>> and also while they are being finally destroyed. It may be that if we 
>> use explicit batching and turn off that pinning logic we will not 
>> affect performance much, but we'll need to do some performance analysis.
>
> Where are we on Andrew's Patch now? I think Andrew's Patch is a good
> solution for the time being until we can get batching, which may be
> too disruptive for 3.03.
> Mike
I would agree :) Honestly, there's does not appear to be any evidence 
that batching of PTE updates, on typical applications, appear to have 
any performance advantage, but the current batching implementation does 
hurt scalability, and what really worries me, keeping it means keeping 
around a lot of code in xen mm that has to catch coherency issues (all 
the cleanup_writable_pagetable() calls and similar checks). I rather 
have writable PTs removed completely now (and assume they don't come 
back), then add explicit batching/multi-calls to specific parts of the 
guests' kernels (which should not require extra code in Xen mm like the 
coherency checks for writable PTs) -and only if they show to benefit 
from it.

-Andrew
