From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Thu, 12 Jan 2012 05:53:16 -0500 (EST)
Message-ID: <2498642a-56c9-497e-84f1-be06a7a5aa26@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120111172700.GA4449@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111172700.GA4449@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Wed, Jan 11, 2012 at 12:19:11PM -0400, Konrad Rzeszutek Wilk
> wrote:
> > > > If the root complaint is that "customers think that anything
> > > > set in
> > > > .config is a supported feature", then the solutions are to
> > > > support
> > > > all
> > > > the features in .config, re-educate the customers that they're
> > > > wrong,
> > > > or
> > > > maintain a local patch to do this stuff.
> > > 
> > > If only re-educating people was free, like preempting questions
> > > is.
> > > Local patches are of course always an option, and perhaps in this
> > > case it's the best one. However, I think we already made a case
> > > for
> > > better xen configurability for the driver domains, so I'm not
> > > 100%
> > 
> > Could you repost those backend patches please? At this point I am
> > not
> > sure which one we have discarded?
> 
> hm, I was thinking in terms of the XenBus ones. We had somewhere in
> this
> converstion something about seperating the backend's from depending
> on
> CONFIG_XEN_DOM0 as they can be run in any domain nowadays.
> 

Ah, I still haven't posted anything like that. So nothing got lost :-)
It's a good idea, but it's probably best done and tested by someone
working with driver domains, or even with the backends at all, which
I'm not.

Drew

> > 
> > > convinced my initial patch (making dom0 configurable) isn't
> > > worthy
> > > of upstream. Also, I didn't see any comments on my v2[*] of that
> > > patch, which I believe satisfies the menu complexity issue and
> > > brings in more configurability. That said, I'm about to reply to
> > > that patch myself, since there's an issue with it.
> > > 
> > > Drew
> > > 
> > > [*]
> > > http://article.gmane.org/gmane.linux.kernel.virtualization/14635
> > > 
> > > _______________________________________________
> > > Xen-devel mailing list
> > > Xen-devel@lists.xensource.com
> > > http://lists.xensource.com/xen-devel
> 
