From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [PATCH/RFC 3/4]Introduce "account modifiers" mechanism
Date: Fri, 17 Aug 2007 09:35:20 +0200
Message-ID: <46C54FB8.7050504__48691.4024375894$1187336278$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>	
	<46C4725A.4070607@bull.net> <46C4740F.2050701@bull.net>
	<1187303955.6449.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4604680663410427227=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187303955.6449.7.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4604680663410427227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig68B7E5EE8B48CA38480FE25A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68B7E5EE8B48CA38480FE25A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rusty Russell wrote:
> On Thu, 2007-08-16 at 17:58 +0200, Laurent Vivier wrote:
>> [PATCH 3/3] introduce "account modifiers" mechanism in the kernel allo=
wing a
>> module to modify the collected accounting for a given task. This imple=
mentation
>> is based on the "preempt_notifier". "account_system_time()" and
>> "account_user_time()" can call functions registered by a module to mod=
ify the
>> cputime value.
>>
>> Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
>=20
>=20
> Hi Laurent,

Hi Rusty,
how are your puppies ?
And thank you for your comment.

> 	This seems a little like overkill.  Why not just add an
> "account_guest_time" which subtracts the given amount of time from
> system time (if available) and adds it to guest time?  Then kvm (and
> lguest) should just need to call this at the right times.

We can. I did something like this before.
By doing like that, I think there is a major issue: system time can be
decreasing (as we substract a value from it), and thus we can have negati=
ve
value in a tool like top. It's why I play with the cputime to add to syst=
em time
and not directly with the system time.

BUT I'm very open, my only goal is be able to compute guest time, "how" i=
s not
very important...

what we can do:

- keep PATCHES 1 and 2, because we need to store guest time for cpu and t=
asks.
It is very generic.

- remove PATCH 3, and add in task_struct a "ktime vtime" where we accumul=
ate
guest time (by calling something like guest_enter() and guest_exit() from=
 the
virtualization engine), and when in account_system_time() we have cputime=
 >
vtime we substrate vtime from cputime and add vtime to user time and gues=
t time.
But doing like this we freeze in kernel/sched.c the link between system t=
ime,
user time and guest time (i.e. system time =3D system time - vtime, user =
time =3D
user time + vtime and guest time =3D guest time + vtime).

- modify PATCH 4 to use new PATCH 3.

Do you agree ? Anybody doesn't agree ?

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enig68B7E5EE8B48CA38480FE25A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGxU+89Kffa9pFVzwRAh/bAKCa7ICgQDN6sPkpvUvtDHQaC3sXmQCglg5B
usAST6mne8Zo5tYtvkRGuvU=
=xswk
-----END PGP SIGNATURE-----

--------------enig68B7E5EE8B48CA38480FE25A--

--===============4604680663410427227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4604680663410427227==--
