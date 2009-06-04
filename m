From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: TODO list for qemu+KVM networking performance v2
Date: Thu, 04 Jun 2009 13:50:20 -0400
Message-ID: <4A28095C.2090002__43047.4679255441$1244147603$gmane$org@gmail.com>
References: <20090604164320.GB14592@redhat.com> <4A280155.2060100@gmail.com>
	<20090604172934.GA16012@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8357874711940650079=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090604172934.GA16012@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, virtualization@lists.linux-foundation.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, Yaron Haviv <yaronh@voltaire.com>, Shahar Klein <shahark@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8357874711940650079==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEEC40D78D9ED954A01A33A52"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEC40D78D9ED954A01A33A52
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2009 at 01:16:05PM -0400, Gregory Haskins wrote:
>  =20
>> Michael S. Tsirkin wrote:
>>    =20
>>> As I'm new to qemu/kvm, to figure out how networking performance can =
be improved, I
>>> went over the code and took some notes.  As I did this, I tried to re=
cord ideas
>>> from recent discussions and ideas that came up on improving performan=
ce. Thus
>>> this list.
>>>
>>> This includes a partial overview of networking code in a virtual envi=
ronment, with
>>> focus on performance: I'm only interested in sending and receiving pa=
ckets,
>>> ignoring configuration etc.
>>>
>>> I have likely missed a ton of clever ideas and older discussions, and=
 probably
>>> misunderstood some code. Please pipe up with corrections, additions, =
etc. And
>>> please don't take offence if I didn't attribute the idea correctly - =
most of
>>> them are marked mst by I don't claim they are original. Just let me k=
now.
>>>
>>> And there are a couple of trivial questions on the code - I'll
>>> add answers here as they become available.
>>>
>>> I out up a copy at http://www.linux-kvm.org/page/Networking_Performan=
ce as
>>> well, and intend to dump updates there from time to time.
>>>  =20
>>>      =20
>> Hi Michael,
>>   Not sure if you have seen this, but I've already started to work on
>> the code for in-kernel devices and have a (currently non-virtio based)=

>> proof-of-concept network device which you can for comparative data.  Y=
ou
>> can find details here:
>>
>> http://lkml.org/lkml/2009/4/21/408
>>
>> <snip>
>>    =20
>
> Thanks
>
>  =20
>> (Will look at your list later, to see if I can add anything)
>>    =20
>>> ---
>>>
>>> Short term plans: I plan to start out with trying out the following i=
deas:
>>>
>>> save a copy in qemu on RX side in case of a single nic in vlan
>>> implement virtio-host kernel module
>>>
>>> *detail on virtio-host-net kernel module project*
>>>
>>> virtio-host-net is a simple character device which gets memory layout=
 information
>>> from qemu, and uses this to convert between virtio descriptors to skb=
s.
>>> The skbs are then passed to/from raw socket (or we could bind virtio-=
host
>>> to physical device like raw socket does TBD).
>>>
>>> Interrupts will be reported to eventfd descriptors, and device will p=
oll
>>> eventfd descriptors to get kicks from guest.
>>>
>>>  =20
>>>      =20
>> I currently have a virtio transport for vbus implemented, but it still=

>> needs a virtio-net device-model backend written.
>>    =20
>
> You mean virtio-ring implementation?
>  =20

Right.

> I intended to basically start by reusing the code from
> Documentation/lguest/lguest.c
> Isn't this all there is to it?
>  =20

Not sure.  I reused the ring code already in the kernel.

>  =20
>>  If you are interested,
>> we can work on this together to implement your idea.  Its on my "todo"=

>> list for vbus anyway, but I am currently distracted with the
>> irqfd/iosignalfd projects which are prereqs for vbus to be considered
>> for merge.
>>
>> Basically vbus is a framework for declaring in-kernel devices (not kvm=

>> specific, per se) with a full security/containment model, a
>> hot-pluggable configuration engine, and a dynamically loadable=20
>> device-model.  The framework takes care of the details of signal-path
>> and memory routing for you so that something like a virtio-net model c=
an
>> be implemented once and work in a variety of environments such as kvm,=

>> lguest, etc.
>>
>> Interested?
>> -Greg
>>
>>    =20
>
> It seems that a character device with a couple of ioctls would be simpl=
er
> for an initial prototype.
>  =20

Suit yourself, but I suspect that by the time you build the prototype
you will either end up re-solving all the same problems anyway, or have
diminished functionality (or both).  Its actually very simple to declare
a new virtio-vbus device, but the choice is yours.  I can crank out a
skeleton for you, if you like.

-Greg



--------------enigEEC40D78D9ED954A01A33A52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkooCWAACgkQP5K2CMvXmqFsMACZAViX4jeWw/3055m2jE4PVMx0
84gAn2SXst5D1pxYMnG0qpuhugcAV79X
=ayRt
-----END PGP SIGNATURE-----

--------------enigEEC40D78D9ED954A01A33A52--

--===============8357874711940650079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============8357874711940650079==--
