From: Andrew Biggadike <biggadike@vmware.com>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Wed, 15 Oct 2008 08:00:51 -0700
Message-ID: <20081015150051.GB19554@vmware.com>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
	<48F4E1F3.3050606@codemonkey.ws>
	<20081015125837.GQ11435@redhat.com>
	<20081015141852.GA19554@vmware.com>
	<20081015143029.GR11435@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081015143029.GR11435@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Anupam Chanda <anupamc@vmware.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Gleb Natapov <gleb@redhat.com> wrote:
> On Wed, Oct 15, 2008 at 07:18:52AM -0700, Andrew Biggadike wrote:
> > Gleb Natapov <gleb@redhat.com> wrote:
> > > > Of course, you should also take a look at VMware's VMCI.  If we're going
> > > > to have a socket interface, if we can have a compatible userspace
> > > > interface, that would probably be a good thing.
> > >
> > > I looked at what I could find about VMCI (http://pubs.vmware.com/vmci-sdk/index.html).
>
> > I believe Anthony intended for you to look at the sockets interface to
> > VMCI: http://www.vmware.com/pdf/ws65_s2_vmci_sockets.pdf.
> >
> Thanks for the link! Are you going to push this interface into upstream kernel?

Pushing it upstream is definitely something we want to do, since it
will make our development easier and allow us to clean up some
unnecessary code in the module.  That said, before we can start that
effort we have some issues to resolve internally (for example, getting
our upgrade story straight in this model and ensuring our
infrastructure / installer can handle it) so we don't have an estimate
for when this will happen just yet.  There are people here whose jobs
are to resolve these things and they are working on it, so I am
confident this will happen even if slower than we'd all like.

> > The link you referenced was experimental and is actually now
> > deprecated in favor of the sockets interface.
> You should influence google somehow to drop old link. That the first
> search result for "vmci vmware" ;)
 
You know, we talked a while ago about putting a notice at the top of
that page stating what I said and redirecting to the VMCI Sockets
programming guide, but somehow that seems to have not gotten done.
