From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to
	binary modules
Date: Mon, 23 Apr 2007 10:24:05 +1000
Message-ID: <1177287845.17026.27.camel@localhost.localdomain>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<46293266.9020306@vmware.com>
	<1177285027.17026.0.camel@localhost.localdomain>
	<200704230149.44137.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704230149.44137.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Petr Vandrovec <petr@vmware.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-04-23 at 01:49 +0200, Andi Kleen wrote:
> > Less exports good.  Consistency with all config options isn't a hard
> > requirement: I'd be tempted not to export the pte functions.
> 
> Yes paravirt_ops should be probably split into two for internal and external
> available functions. Any takers? 

Hi Andi!

	I'm a little uncomfortable with cutting the struct this way: I always
thought it'd be a function split if we did one.

	With the new patch code we could simply shuffle all the exportables to
the front and fail to patch calls past this point (then fail the module
load).

I'll see what I can come up with...
Rusty.
