From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 0/7] Modify lguest32 to make room for lguest64
Date: Mon, 13 Aug 2007 17:01:22 +0200
Message-ID: <46C07242.1000504@sgi.com>
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
Cc: lguest <lguest@ozlabs.org>, Carsten Otte <cotte@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Since I can't build a module over two directories, that seems to destroy
> the idea of an i386/ subdir.  Instead I've done a patch which renames
> the *clearly* i386-specific things to i386_<name>, which at least works.
> I've pushed it into the repository http://lguest.ozlabs.org/patches/

Rusty,

Looking at your patches, I am trying to figure out what they are
against. There's a diff that includes a diff in that and I cannot see
exactly whats in upstream and whats not.

Any chance you could post a set of seperate patches that are in the
queue for Linus so one can quilt apply it or something like that?

Cheers,
Jes
