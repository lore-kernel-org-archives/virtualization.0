From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Wed, 20 Sep 2006 09:00:17 +0200
Message-ID: <200609200900.17193.ak@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<450FA6FB.9020100@goop.org>
	<1158710822.2480.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158710822.2480.14.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


> Seems that we can't assume boot CPU =3D=3D 0.  I think I've removed the t=
wo
> places where I assumed that, but will need testing.

boot CPU =3D=3D 0 should be true. You just can't assume anything about its
APIC ID, but we decouple APIC ID and logical processor id anyways.

Another issue is that with CPU hotunplug CPU #0 might disappear at some
point later.

-Andi
