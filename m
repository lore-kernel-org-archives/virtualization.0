From: Ingo Molnar <mingo@elte.hu>
Subject: Re: hardwired VMI crap
Date: Thu, 8 Mar 2007 22:34:58 +0100
Message-ID: <20070308213458.GA24634@elte.hu>
References: <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
	<45EFE010.7080108@vmware.com>
	<1173352154.24738.1023.camel@localhost.localdomain>
	<45F0761C.6060107@vmware.com> <45F07D07.5090003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F07D07.5090003@goop.org>
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
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, tglx@linutronix.de, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Zachary Amsden wrote:
> > We faithfully emulate lapic, io_apic, the pit, pic, and a normal
> > interrupt subsystem.
> =

> Can you not just use the apic clock driver directly then?  Do you need =

> to do anything special?

exactly. There are only two variants Linux wants to care about:

 - native hardware ABIs. If a hypervisor (like KVM) happens to do its
   stuff based on those, more power to them - we dont (and cannot) care.

 - /One/ _intelligent_ higher-level virtualization API/ABI. Xen's API is =

   quite advanced on this front. This would be shared by /all/ =

   hypervisors and could occasionally be reused by other hardware =

   platforms as well. It can be morphed via small wrappers into some
   'hypervisor personality' kind of hypervisor backends, but no
   fundamental transformation happens.

what we do _NOT_ want is some mixture of 'simplified' and 'hardwired' =

native hardware access mixed with hypercalls that somehow ends up =

creating a Frankenstein mixture of 'virtual silicon', which is specified =

nowhere else but in VMWare's proprietary hypervisor source code that we =

have no way to fix and no way to even see!

it's hard enough to get native silicon support right.

	Ingo
