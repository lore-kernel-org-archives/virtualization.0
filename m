From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lguest] [RFC PATCH 1/5] lguest: mmap backing file
Date: Fri, 21 Mar 2008 11:29:03 +1100
Message-ID: <200803211129.03820.rusty__17548.7446868376$1206059680$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<1206000960.6873.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206000960.6873.124.camel@localhost.localdomain>
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
To: echo@echoreply.us
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 20 March 2008 19:16:00 Tim Post wrote:
> On Thu, 2008-03-20 at 17:05 +1100, Rusty Russell wrote:
> > +       snprintf(memfile_path, PATH_MAX, "%s/.lguest",
> > getenv("HOME") ?: "");
>
> Hi Rusty,
>
> Is that safe if being run via setuid/gid or shared root? It might be
> better to just look it up in /etc/passwd against the real UID,
> considering that anyone can change (or null) that env string.

Hi Tim,

    Fair point: it is bogus in this usage case.  Of course, setuid-ing lguest 
is dumb anyway, since you could use --block= to read and write any file in 
the filesystem.  The mid-term goal is to allow non-root to run lguest, which 
fixes this problem (we don't allow that at the moment, as the guest can pin 
memory).

Cheers,
Rusty.
