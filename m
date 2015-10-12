From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] kvm/x86: Hyper-V kvm exit
Date: Mon, 12 Oct 2015 07:42:42 -0600
Message-ID: <561BB8D2.60402@redhat.com>
References: <1444397988-20167-1-git-send-email-den@openvz.org>
	<1444397988-20167-3-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7729609505452612903=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444397988-20167-3-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Andrey Smetanin <asmetanin@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7729609505452612903==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nwA6335TBjWr28xrsQTqLWtii3alMXi4q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwA6335TBjWr28xrsQTqLWtii3alMXi4q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2015 07:39 AM, Denis V. Lunev wrote:
> From: Andrey Smetanin <asmetanin@virtuozzo.com>
>=20
> A new vcpu exit is introduced to notify the userspace of the
> changes in Hyper-V synic configuraion triggered by guest writing to the=


s/configuraion/configuration/
Is 'synic' intended?  Is it short for something (if so, spelling it out
may help)?


> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3331,6 +3331,12 @@ the userspace IOAPIC should process the EOI and =
retrigger the interrupt if
>  it is still asserted.  Vector is the LAPIC interrupt vector for which =
the
>  EOI was received.
> =20
> +		/* KVM_EXIT_HYPERV */
> +                struct kvm_hyperv_exit hyperv;
> +Indicates that the VCPU's exits into userspace to process some tasks

s/VCPU's/VCPU/

> +related with Hyper-V emulation. Currently used to synchronize modified=

> +Hyper-V synic state with userspace.

Again, is 'synic' intended?  Hmm, I see it throughout the patch, so it
looks intentional, but I keep trying to read it as a typo for 'sync'.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nwA6335TBjWr28xrsQTqLWtii3alMXi4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWG7jSAAoJEKeha0olJ0NqW30H/AtW7a1y27hRxHQAesxXoxPX
5I3VKhq0U7KETbyRM2tFv1UhxfIvWimPfElvmJ99yiJr+tiY/UatEVb3HBjR+YI2
LlvWR+8wyrv7NdwaefiEQ//TLxqOg2G7E3DtyufzG/0HHVt3eXoNoOpI3TtyO+a1
Kbi0fXdDvh5pAWKUGb0nCoX0fuZED2Y2kx9XJ7xcUAI7NC/yXIHFQPwkeVQvD0Zd
ablN7eRBQ29NH5Mq08jNa0QJfvEL+x96LneT21ieY2Hi85c+5NVvRgGf59tvZJaB
uwTUziLkG5odFc+qJdaqlY7eUh/YKe40zU3ejBRB6Bw1EQEcteeF9YYDldAVQzs=
=LF9s
-----END PGP SIGNATURE-----

--nwA6335TBjWr28xrsQTqLWtii3alMXi4q--

--===============7729609505452612903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7729609505452612903==--
