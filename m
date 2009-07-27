From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 27 Jul 2009 21:32:14 +0100
Message-ID: <20090727203214.GG15020__32069.6562099785$1248726905$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A6E0C9E.10908@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 27, 2009 at 03:22:54PM -0500, Anthony Liguori wrote:
> Amit Shah wrote:
> >Hello all,
> >
> >This are the latest version of the patches.
> >
> >Lots of things have changed since the last submission. A few of
> >which I remember:
> >- VNC copy / paste works* (* conditions apply)
> >  - client vnc copies get propagated to guest port 3 (/dev/vmch3)
> >  - guest writes to port 3 (/dev/vmch3) go straight to client's clipboard
> >  
> 
> Why 3?
> 
> Where's the guest application that drives the copy/paste?
> 
> I expect the first problem you'll run into is that copy/paste daemon has 
> to run as an unprivileged user but /dev/vmch3 is going to be owned by 
> root.  You could set udev rules for /dev/vmch3 but that's pretty 
> terrible IMHO.

I don't think that's not too bad, for example, with fast-user-switching 
between multiple X servers and/or text consoles, there's already support
code that deals with chown'ing things like /dev/snd/* devices to match 
the active console session. Doing the same with the /dev/vmch3 device so
that it is only ever accessible to the current logged in user actually
fits in to that scheme quite well.

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
