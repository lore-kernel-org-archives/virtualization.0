From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 0/7] Modify lguest32 to make room for lguest64
Date: Mon, 13 Aug 2007 11:50:43 +0200
Message-ID: <46C02973.6030709@sgi.com>
References: <20070809003211.373543702@goodmis.org>
	<1186803724.30899.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186803724.30899.62.camel@localhost.localdomain>
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
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Yeah, after some more thought I've not applied most of this.  We really
> don't want to move everything then move it back; I prefer Jes' more
> cautious approach of moving a little bit at a time.
> 
> We really have three parts: (1) bits that are generic, (2) bits that
> should be generic but my implementation is naive, (3) bits that really
> are i386-specific.

I have actually been using Steven's patchset to do my work, but in a
way it's a tool. Moving things out of the way in bulk and see whats
missing kinda helps for that :)

> Patches which move 2 to 1 are gratefully accepted: I realize a mass move
> is easier and this requires thought, but that's what we need.
> 
> Since I can't build a module over two directories, that seems to destroy
> the idea of an i386/ subdir.  Instead I've done a patch which renames
> the *clearly* i386-specific things to i386_<name>, which at least works.
> I've pushed it into the repository http://lguest.ozlabs.org/patches/

That works - alternatively we could build two modules, lg and lg_<arch>
and just have lg pull in the arch one as well? I'm not really biased,
but I think it will get messy later once we add ia64 and x86_64 to the
directory.

Cheers,
Jes
