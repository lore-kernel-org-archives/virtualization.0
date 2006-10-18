From: Zachary Amsden <zach@vmware.com>
Subject: Re: Handling PCI/ROM space
Date: Wed, 18 Oct 2006 15:14:12 -0700
Message-ID: <4536A734.7030904@vmware.com>
References: <45369FD4.3030303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45369FD4.3030303@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I'm seeing oopses in probe_roms() and pci_find_bios(), apparently =

> because those pages are not mapped under Xen.  I'm not sure why I'm =

> seeing this now and not before, but I suspect its because I enabled =

> CONFIG_DEBUG_PAGEALLOC.  Anyway, I've got these patches to deal with =

> these cases:

Probably a config file difference - GOBIOS vs GODIRECT.

These patches look fine, although is there a more general solution?  =

Like bypassing the whole PCI ROM probing entirely?  We don't really want =

to use the PCI ROM here either, although we have a slightly worse =

problem - the pages are mapped and do have a PCI ROM.  Perhaps =

paravirt-ops should be able to flip a global switch to disable this =

(perhaps already there?).

Zach
