From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/5] Boot protocol changes
Date: Thu, 04 Oct 2007 20:47:23 +1000
Message-ID: <1191494843.8268.157.camel@localhost.localdomain>
References: <1191491231.5950.7.camel@feisty>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1191491231.5950.7.camel@feisty>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Malley <mail@chrismalley.co.uk>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-10-04 at 10:47 +0100, Chris Malley wrote:
> Hi guys
> 
> I gave these patches a try (on top of 2.6.23-rc9 plus the previously
> submitted 2.6.24 patch set).
> 
> The last two seem to cause Badness on my system, whereby if I start a
> guest (using the same bzImage as the host, as before) it seems to boot
> OK, and the host system still superficially looks stable (my X session
> is OK and I can interact with existing processes) but if I attempt to
> launch any new process on the host (even typing "ls" into a terminal
> window) I get a Segmentation fault.

I think this might actually be caused by a nasty bug in one of the
previous patches (patch 27).  I found it because every second time I
launched a guest it failed.  Strange, huh?

These lines in drivers/lguest/page_tables.c:

+               pte_t ro_gpte = gpte;
+               pte_wrprotect(ro_gpte);

Should be:

+               pte_t ro_gpte = pte_wrprotct(gpte);

That's the only "break the host" issue I know of...

Thanks!
Rusty.
