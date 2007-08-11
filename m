From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/7] Modify lguest32 to make room for lguest64
Date: Sat, 11 Aug 2007 13:42:04 +1000
Message-ID: <1186803724.30899.62.camel__46495.753786485$1186803868$gmane$org@localhost.localdomain>
References: <20070809003211.373543702@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003211.373543702@goodmis.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-08-08 at 20:32 -0400, Steven Rostedt wrote:
> Hi all,
> 
> I've been working on lguest64 and in order to do this, I had to move
> a lot of the i386 specific out of the way.  Well, the lguest64 port
> is still not ready to display, but before Rusty makes too many changes
> I would like this in upstream so I don't have to keep repeating my
> changes :-)
> 
> 
> So this patch series moves lguest32 out of the way for other archs.

Yeah, after some more thought I've not applied most of this.  We really
don't want to move everything then move it back; I prefer Jes' more
cautious approach of moving a little bit at a time.

We really have three parts: (1) bits that are generic, (2) bits that
should be generic but my implementation is naive, (3) bits that really
are i386-specific.

Patches which move 2 to 1 are gratefully accepted: I realize a mass move
is easier and this requires thought, but that's what we need.

Since I can't build a module over two directories, that seems to destroy
the idea of an i386/ subdir.  Instead I've done a patch which renames
the *clearly* i386-specific things to i386_<name>, which at least works.
I've pushed it into the repository http://lguest.ozlabs.org/patches/

Cheers,
Rusty.
