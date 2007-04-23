From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC,
	PATCH 0/5] Paravirt: fix export of paravirt-ops to binary modules
Date: Mon, 23 Apr 2007 02:49:29 +0200
Message-ID: <200704230249.29473.ak@suse.de>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<200704230149.44137.ak@suse.de>
	<1177287845.17026.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177287845.17026.27.camel@localhost.localdomain>
Content-Disposition: inline
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

On Monday 23 April 2007 02:24:05 Rusty Russell wrote:
> On Mon, 2007-04-23 at 01:49 +0200, Andi Kleen wrote:
> > > Less exports good.  Consistency with all config options isn't a hard
> > > requirement: I'd be tempted not to export the pte functions.
> > 
> > Yes paravirt_ops should be probably split into two for internal and external
> > available functions. Any takers? 
> 
> Hi Andi!
> 
> 	I'm a little uncomfortable with cutting the struct this way: I always
> thought it'd be a function split if we did one.

It's a functional split, isn't it? arch/mm internal and "exported" to other
users

> 	With the new patch code we could simply shuffle all the exportables to
> the front and fail to patch calls past this point (then fail the module
> load).

Two structures would seem cleaner to me than such hacks.

-Andi
