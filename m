From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH 2/2] xen: Add alias to autoload backend
	drivers
Date: Mon, 27 Jun 2011 13:34:47 -0400
Message-ID: <20110627173447.GD2430__25195.4712359749$1309196245$gmane$org@dumpdata.com>
References: <20110624215155.GB4735@wavehammer.waldi.eu.org>
	<20110627161327.GO6978@dumpdata.com>
	<20110627163728.GA23028@wavehammer.waldi.eu.org>
	<20110627165109.GB13335@dumpdata.com>
	<20110627165711.GA2201@dumpdata.com>
	<20110627172305.GC23028@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110627172305.GC23028@wavehammer.waldi.eu.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bastian Blank <waldi@debian.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 27, 2011 at 07:23:05PM +0200, Bastian Blank wrote:
> On Mon, Jun 27, 2011 at 12:57:11PM -0400, Konrad Rzeszutek Wilk wrote:
> > Ugh actually no I can't.
> 
> Why? It does not actually change things.
> 
> > Can you re-submit these two patches (and stick on Acked-by Ian on them) and
> > split the "xen: Add alias to autoload backend driver" in three patches:
> >  1) the xen-netback (and copy David Miller)
> >  2) the xen-blkback (and copy Jens Axboe)
> >  3) the xenbus one
> 
> That is silly.

Please do it.

> 
> > That should be five patches total.
> 
> No, 2+2 is 4, not five.

Right. Got my math wrong.
