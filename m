From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Tue, 03 Nov 2009 14:50:37 -0500
Message-ID: <4AF0898D.5000704__45124.4172327735$1257277908$gmane$org@gmail.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com> <4AF0708B.4020406@gmail.com>
	<4AF07199.2020601@gmail.com> <4AF072EE.9020202@gmail.com>
	<4AF07BB7.1020802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6500404531030717288=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AF07BB7.1020802@gmail.com>
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
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6500404531030717288==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE35B5FA56BFEDFC91950F1D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE35B5FA56BFEDFC91950F1D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> Gregory Haskins a =E9crit :
>> Gregory Haskins wrote:
>>> Eric Dumazet wrote:
>>>> Michael S. Tsirkin a =E9crit :

>>>> using rcu_dereference() and mutex_lock() at the same time seems wron=
g, I suspect
>>>> that your use of RCU is not correct.
>>>>
>>>> 1) rcu_dereference() should be done inside a read_rcu_lock() section=
, and
>>>>    we are not allowed to sleep in such a section.
>>>>    (Quoting Documentation/RCU/whatisRCU.txt :
>>>>      It is illegal to block while in an RCU read-side critical secti=
on, )
>>>>
>>>> 2) mutex_lock() can sleep (ie block)
>>>>
>>> Michael,
>>>   I warned you that this needed better documentation ;)
>>>
>>> Eric,
>>>   I think I flagged this once before, but Michael convinced me that i=
t
>>> was indeed "ok", if but perhaps a bit unconventional.  I will try to
>>> find the thread.
>>>
>>> Kind Regards,
>>> -Greg
>>>
>> Here it is:
>>
>> http://lkml.org/lkml/2009/8/12/173
>>
>=20
> Yes, this doesnt convince me at all, and could be a precedent for a wro=
ng RCU use.
> People wanting to use RCU do a grep on kernel sources to find how to co=
rrectly
> use RCU.
>=20
> Michael, please use existing locking/barrier mechanisms, and not preten=
d to use RCU.

Yes, I would tend to agree with you.  In fact, I think I suggested that
a normal barrier should be used instead of abusing rcu_dereference().

But as far as his code is concerned, I think it technically works
properly, and that was my main point.  Also note that the usage
rcu_dereference+mutex_lock() are not necessarily broken, per se:  it
could be an srcu-based critical section created by the caller, for
instance.  It would be perfectly legal to sleep on the mutex if that
were the case.

To me, the bigger issue is that the rcu_dereference() without any
apparent hint of a corresponding RSCS is simply confusing as a reviewer.
 smp_rmb() (or whatever is proper in this case) is probably more
appropriate.

Kind Regards,
-Greg



--------------enigEE35B5FA56BFEDFC91950F1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrwiY4ACgkQP5K2CMvXmqE4kACggLbxMKmUbWxvGmiXUR8MiQ7N
rO4AnRYDdV3qH7rc0Roiavyzg1QagQTY
=ZPHq
-----END PGP SIGNATURE-----

--------------enigEE35B5FA56BFEDFC91950F1D--

--===============6500404531030717288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============6500404531030717288==--
