From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:20:10 -0500
Message-ID: <1177777210.3688.50.camel@mulgrave.il.steeleye.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<1177775271.3688.30.camel@mulgrave.il.steeleye.com>
	<m1zm4sebc2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1zm4sebc2.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-04-28 at 10:02 -0600, Eric W. Biederman wrote:
> Reasonable.  I think we would have fewer people to yell at if we
> restructured things a bit. 

Sure ... propose a restructure and I'll see if I can fit into it.  All
voyager really needs is to subvert the entirey of the SMP layer (not
being APIC based it needs a complete rewrite of most smp_ function)  It
also needs some minor things in setup (like catbus config probes and
memory setup).

> The fact that we have prominent people deliberately ignoring voyager
> during development I find disturbing. 

Heh, I just got used to that ...

> In this case I just happened to stumble onto the problem while I was
> looking at something else, and decided it wasn't worth doing
> development on code that was broken to start with.

James
