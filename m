From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Wed, 13 Sep 2006 10:56:26 +0200
Message-ID: <1158137786.2560.3.camel@localhost>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	<45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45075F09.5010708@redhat.com>
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
Cc: akpm@osdl.org, virtualization@lists.osdl.org, Hubertus Franke <frankeh@watson.ibm.com>, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> Note that the transition _to_ volatile can also be batched
> and done somewhat lazily.  For frequently mmaped pages that
> could end up saving us the transition the other way, too...

That would be helpful, only how to do it? We need some sort of list or
array where to store the pages that should be made volatile. The main
problem that I see is that you have to remove a page that is freed from
the list/array again, otherwise you would end up with a non page-cache
page being made volatile. That makes using per-cpu arrays hard since a
page can be freed on another cpu.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
