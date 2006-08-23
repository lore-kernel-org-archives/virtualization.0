From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 0/5] Update ELFNOTEs and use them in Xen header.
Date: Wed, 23 Aug 2006 09:20:30 -0700
Message-ID: <20060823162030.GG10348@sequoia.sous-sol.org>
References: <1156345759.12949.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1156345759.12949.120.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ian Campbell <Ian.Campbell@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Ian Campbell (Ian.Campbell@xensource.com) wrote:
> Hi,
> =

> I've just committed ELF notes support to Xen unstable. It should become
> public once changeset 11239:58b5141c8309 passes through regression
> testing and into the public tree.

Great, I'll give it a spin.

> The patches which follow update the paravirt tree to define the notes.
> Some of them should be merged with existing patches others are
> completely new. I've made a note in the intro to the individual patches.
> =

> There is one caveat which is that shadow mode for paravirt guests seems
> to be a little broken at the current tip of xen-unstable so you may want
> to stick where you are for now and not apply patch #4 (the one which
> removes __xen_guest from the header). The rest of the series is fine to
> apply whether you update or not.

Alright, I'll merge those in.  We can put #4 off for a bit then.

> Sorry for the lack of References: from the patches to this mail, I'm
> doing this manually. If anyone has any pointers to a decent patchbomb
> script I'm all ears ;-)

I find quilt to work quite well for patchbombing.

thanks,
-chris
