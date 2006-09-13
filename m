From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Wed, 13 Sep 2006 16:59:03 +0200
Message-ID: <1158159543.2560.29.camel@localhost>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	<45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
	<1158137786.2560.3.camel@localhost> <4507F453.1040809@watson.ibm.com>
	<1158151535.2560.20.camel@localhost> <45080262.8050009@watson.ibm.com>
	<4508198E.10707@redhat.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4508198E.10707@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rik van Riel <riel@redhat.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, Hubertus Franke <frankeh@watson.ibm.com>, rhim@cc.gatech.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-09-13 at 10:45 -0400, Rik van Riel wrote:
> > But another trouble you have not mentioned is what happens to pages
> > with pending make-volatile that need to and/or have been made stable
> > in the meantime. They too need to be removed from this pending list.
> =

> At the time where you walk the set of pages (pagevec?) to make
> volatile, you can check whether the page flags are still right.

A make volatile can be done anytime as long as the page is in page
cache. Before a page can be made stable the caller needs to make sure
that one of the conditions that prevent a make volatile becomes true.
So a page in the pending make-volatile array does not have to be removed
because a make stable has been done. It only has to be removed if it
gets freed.

> A page that was set to be marked volatile with the hypervisor,
> but later turned stable again would have that indicated in its
> page flags, right?

Several page flag bits and some other conditions like "has a mapping"
and "reference count is map count + 1". Most of the checks that need to
be done for make volatile are on page flags.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
