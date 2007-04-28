From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 10:02:37 -0600
Message-ID: <m1zm4sebc2.fsf@ebiederm.dsl.xmission.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<1177775271.3688.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177775271.3688.30.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Sat, 28 Apr 2007 10:47:51 -0500")
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> I got a bit tired of trying to be proactive.  The last time was for the
> %gs per cpu thing, which I saw coming.  The basic problem is that
> there's no well organised git tree I can pull from and bisect to trace
> problems.
>
> My strategy now is to wait for the merge window to close and then go
> around sweeping up the mess and yelling at the offenders ... it's what
> all the non-x86 architectures do, and it's definitely an easier process.

Reasonable.  I think we would have fewer people to yell at if we
restructured things a bit. 

The fact that we have prominent people deliberately ignoring voyager
during development I find disturbing. 

In this case I just happened to stumble onto the problem while I was
looking at something else, and decided it wasn't worth doing
development on code that was broken to start with.

Eric
