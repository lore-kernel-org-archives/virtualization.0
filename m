From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Wed, 11 Jan 2012 12:27:00 -0500
Message-ID: <20120111172700.GA4449__17158.0532486134$1326303944$gmane$org@phenom.dumpdata.com>
References: <4F0B8D06.8050501@goop.org>
	<8e643150-6be5-44ba-aba3-a987b22fc82b@zmail13.collab.prod.int.phx2.redhat.com>
	<20120111161911.GB18203@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120111161911.GB18203@andromeda.dapyr.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Andrew Jones <drjones@redhat.com>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 12:19:11PM -0400, Konrad Rzeszutek Wilk wrote:
> > > If the root complaint is that "customers think that anything set in
> > > .config is a supported feature", then the solutions are to support
> > > all
> > > the features in .config, re-educate the customers that they're wrong,
> > > or
> > > maintain a local patch to do this stuff.
> > 
> > If only re-educating people was free, like preempting questions is.
> > Local patches are of course always an option, and perhaps in this
> > case it's the best one. However, I think we already made a case for
> > better xen configurability for the driver domains, so I'm not 100%
> 
> Could you repost those backend patches please? At this point I am not
> sure which one we have discarded?

hm, I was thinking in terms of the XenBus ones. We had somewhere in this
converstion something about seperating the backend's from depending on
CONFIG_XEN_DOM0 as they can be run in any domain nowadays.

> 
> > convinced my initial patch (making dom0 configurable) isn't worthy
> > of upstream. Also, I didn't see any comments on my v2[*] of that
> > patch, which I believe satisfies the menu complexity issue and
> > brings in more configurability. That said, I'm about to reply to
> > that patch myself, since there's an issue with it.
> > 
> > Drew
> > 
> > [*] http://article.gmane.org/gmane.linux.kernel.virtualization/14635
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xensource.com
> > http://lists.xensource.com/xen-devel
