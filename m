From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 3/4] xen kconfig: add dom0 support help text
Date: Fri, 6 Jan 2012 10:07:01 -0500
Message-ID: <20120106150701.GC5855@phenom.dumpdata.com>
References: <alpine.DEB.2.00.1201061231150.3150@kaball-desktop>
	<c802fb58-5067-4075-80b3-ca8004005364@zmail13.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c802fb58-5067-4075-80b3-ca8004005364@zmail13.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Ian Campbell <Ian.Campbell@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

> > The reason to remove is easy: it is already a silent option and
> > disabling it saves almost nothing.
> > I think that removing it should be easy enough but if you don't
> > feel confident doing it, I can come up with a patch.
> > 
> 
> I'll write the patch. It's not the patch I thought would be hard to
> do (although I'll only be posting it compile tested, as I don't
> have an environment where I can test it set up). What I thought would

Um.. Fedora Core 16?

> be difficult is the justification. However, considering you're
> advocating it, I guess I'm good there too.

We don't bite :-)
