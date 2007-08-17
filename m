From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [kvm-devel] [PATCH/RFC 3/4]Introduce "account
	modifiers"	mechanism
Date: Fri, 17 Aug 2007 15:08:22 +0200
Message-ID: <46C59DC6.4020308__5018.15019310943$1187356316$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net>
	<46C4720F.7030304@bull.net>		<46C4725A.4070607@bull.net>
	<46C4740F.2050701@bull.net>		<1187303955.6449.7.camel@localhost.localdomain>	<46C54FB8.7050504@bull.net>	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C59AB1.6070505@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2966750882296282817=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C59AB1.6070505@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2966750882296282817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC98261892A620E153949C8D1"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC98261892A620E153949C8D1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> Laurent Vivier wrote:
>>>    =20
>>>> - remove PATCH 3, and add in task_struct a "ktime vtime" where we ac=
cumulate
>>>> guest time (by calling something like guest_enter() and guest_exit()=
 from the
>>>> virtualization engine), and when in account_system_time() we have cp=
utime >
>>>> vtime we substrate vtime from cputime and add vtime to user time and=
 guest time.
>>>> But doing like this we freeze in kernel/sched.c the link between sys=
tem time,
>>>> user time and guest time (i.e. system time =3D system time - vtime, =
user time =3D
>>>> user time + vtime and guest time =3D guest time + vtime).
>>>>      =20
>>> Actually, I think we can set a per-cpu "in_guest" flag for the schedu=
ler
>>> code, which then knows to add the tick to the guest time.  That seems=

>>> the simplest possible solution.
>>>
>>> lguest or kvm would set the flag before running the guest (which is d=
one
>>> with preempt disabled or using preemption hooks), and reset it
>>> afterwards.
>>>
>>> Thoughts?
>>>    =20
>> It was my first attempt (except I didn't have a per-cpu flag, but a pe=
r-task
>> flag), it's not visible but I love simplicity... ;-)
>>
>> A KVM VCPU is stopped by preemption, so when we enter in scheduler we =
have
>> exited from VCPU and thus this flags is off (so we account 0 to the gu=
est). What
>> I did then is "set the flag on when we enter in the VCPU, and
>> "account_system_time()" sets the flag off when it adds this timeslice =
to cpustat
>> (and compute correctly guest, user, system time). But I didn't like th=
is idea
>> because all code executed after we entered in the VCPU is accounted to=
 the guest
>> until we have an account_system_time() and I suppose we can have real =
system
>> time in this part. And I guess a VCPU can be less than 1 ms (unit of c=
putime) in
>> a timeslice.
>>
>> So ? What's best ?
>>  =20
>=20
> The normal user/system accounting has the same issue, no?  Whereever we=

> happen to land (kernel or user) gets the whole tick.

Yes... but perhaps I should rewrite this too ;-)

> So I think it is okay to have the same limitation for guest time.

OK, so we can go back to my first patch.
Who can decide to introduce this into the kernel ?

Laurent
--=20
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth


--------------enigC98261892A620E153949C8D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFGxZ3K9Kffa9pFVzwRAl6PAJsE/Bag1XNvPKoWeGjMkyLcj0SoxgCdFpuN
zR2Hs/1xmBRSnIkYmDleA18=
=WW4B
-----END PGP SIGNATURE-----

--------------enigC98261892A620E153949C8D1--

--===============2966750882296282817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2966750882296282817==--
