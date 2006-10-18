From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Handling PCI/ROM space
Date: Wed, 18 Oct 2006 15:24:38 -0700
Message-ID: <4536A9A6.8040604@goop.org>
References: <45369FD4.3030303@goop.org> <4536A734.7030904@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4536A734.7030904@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Probably a config file difference - GOBIOS vs GODIRECT.
>
> These patches look fine, although is there a more general solution?  =

> Like bypassing the whole PCI ROM probing entirely?  We don't really =

> want to use the PCI ROM here either, although we have a slightly worse =

> problem - the pages are mapped and do have a PCI ROM.  Perhaps =

> paravirt-ops should be able to flip a global switch to disable this =

> (perhaps already there?).

There's a pci_probe variable, which has a bitmask of which PCI access =

methods to use; if you mask out PCI_PROBE_BIOS then it won't bother.  I =

considered doing this, but it wasn't clear to me where this actually get =

set up (it's a bit diffuse), and whether to add a new pv_op hook =

intercept this.

I also thought that we don't necessarily want to unconditionally disable =

PCI access for paravirt guests since even an unprivileged guest may have =

a raw device exported to it, and we don't want to add too many special =

cases when dom0 is migrated to operate in the pv_op world.  So it seemed =

more correct to actually allow the probe but deal with unmapped pci ROM =

space.

    J
