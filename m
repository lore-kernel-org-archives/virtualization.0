From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 27 Jul 2009 21:46:27 +0100
Message-ID: <20090727204627.GA32432__25559.345415286$1248727634$gmane$org@shareable.org>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090727203214.GG15020@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Daniel P. Berrange wrote:
> > I expect the first problem you'll run into is that copy/paste daemon has 
> > to run as an unprivileged user but /dev/vmch3 is going to be owned by 
> > root.  You could set udev rules for /dev/vmch3 but that's pretty 
> > terrible IMHO.
> 
> I don't think that's not too bad, for example, with fast-user-switching 
> between multiple X servers and/or text consoles, there's already support
> code that deals with chown'ing things like /dev/snd/* devices to match 
> the active console session. Doing the same with the /dev/vmch3 device so
> that it is only ever accessible to the current logged in user actually
> fits in to that scheme quite well.

With multiple X servers, there can be more than one currently logged in user.

Same with multiple text consoles - that's more familiar.

Which one owns /dev/vmch3?

-- Jamie
