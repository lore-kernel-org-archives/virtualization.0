From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to	binary
 modules
Date: Sun, 22 Apr 2007 18:00:17 -0700
Message-ID: <462C0521.6000800@goop.org>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>	
	<46293266.9020306@vmware.com>	
	<1177285027.17026.0.camel@localhost.localdomain>	
	<200704230149.44137.ak@suse.de>
	<1177287845.17026.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177287845.17026.27.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Petr Vandrovec <petr@vmware.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 2007-04-23 at 01:49 +0200, Andi Kleen wrote:
>   
>>> Less exports good.  Consistency with all config options isn't a hard
>>> requirement: I'd be tempted not to export the pte functions.
>>>       
>> Yes paravirt_ops should be probably split into two for internal and external
>> available functions. Any takers? 
>>     
>
> Hi Andi!
>
> 	I'm a little uncomfortable with cutting the struct this way: I always
> thought it'd be a function split if we did one.
>
> 	With the new patch code we could simply shuffle all the exportables to
> the front and fail to patch calls past this point (then fail the module
> load).
>
> I'll see what I can come up with...

There was some discussion about hybrid paravirt/fully virt hypervisor
models at the Xen summit.  There are definitely some interesting things
you can do by having a mostly paravirtualized guest running within an
hvm container.

One of the things I was considering as a result was splitting the
privileged instruction ops (all the cr?, msr, segment stuff) into a
cpu_ops, and putting the pagetable stuff into pagetable_ops.  That would
make a broad split of shadow vs direct pagetables and hvm vs non-hvm
models pretty straightforward, and probably sharing more interfaces than
they might otherwise.

    J
