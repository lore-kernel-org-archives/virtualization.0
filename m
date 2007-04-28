From: Andi Kleen <ak@suse.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 19:23:47 +0200
Message-ID: <20070428172347.GD29316@bingen.suse.de>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<1177775271.3688.30.camel@mulgrave.il.steeleye.com>
	<m1zm4sebc2.fsf@ebiederm.dsl.xmission.com>
	<1177777210.3688.50.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177777210.3688.50.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 28, 2007 at 11:20:10AM -0500, James Bottomley wrote:
> On Sat, 2007-04-28 at 10:02 -0600, Eric W. Biederman wrote:
> > Reasonable.  I think we would have fewer people to yell at if we
> > restructured things a bit. 
> 
> Sure ... propose a restructure and I'll see if I can fit into it.  All
> voyager really needs is to subvert the entirey of the SMP layer (not
> being APIC based it needs a complete rewrite of most smp_ function)  It

Xen needs essentially the same and J. did smp_ops for this so in theory
it should work for you.

-Andi
