From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: [PATCH net] Revert "drivers/net: Disable UFO through virtio"
	in macvtap and tun
Date: Thu, 13 Nov 2014 13:00:38 +0100
Message-ID: <54649D66.5090108__16975.7098927677$1415898099$gmane$org@powercraft.nl>
References: <20141111105849.GA8482@stefanha-thinkpad.redhat.com>
	<1415708246.3398.88.camel@decadent.org.uk>
	<20141111155750.GA17418@redhat.com>
	<1415725978.3398.101.camel@decadent.org.uk>
	<20141112190238.GA13138@stefanha-thinkpad.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141112190238.GA13138@stefanha-thinkpad.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Ben Hutchings <ben@decadent.org.uk>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/14 20:02, Stefan Hajnoczi wrote:
> On Tue, Nov 11, 2014 at 05:12:58PM +0000, Ben Hutchings wrote:
>> This reverts commit 88e0e0e5aa722b193c8758c8b45d041de5316924 for 
>> the tap drivers, but leaves UFO disabled in virtio_net.
>> 
>> libvirt at least assumes that tap features will never be dropped 
>> in new kernel versions, and doing so prevents migration of VMs
>> to the never kernel version while they are running with virtio
>> net devices.
>> 
>> Fixes: 88e0e0e5aa7a ("drivers/net: Disable UFO through virtio") 
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk> --- 
>> Compile-tested only.
> 
> Jelle, care to test this and reply with "Tested-by: Jelle de Jong 
> <jelledejong@powercraft.nl>" if it solves the live migration
> problem you reported?
> 
> It requires applying the patch to the host kernel on your virt01
> host.

If someone can provide an x86_64 kernel package for debian wheezy (or
put it in wheezy-backports I would be willing to test it and report (I
cant set-up a cross-build building system right now). I'm currently
planning on taking four virtualisation platform down this weekend to
reboot all systems and guests to work around the issue that already
hit production.

Many thanks for picking up the problem and working on a solution.

Kind regards,

Jelle de Jong
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iJwEAQECAAYFAlRknWIACgkQ1WclBW9j5HlBLwP/aMoJy9Jgs6M6nuQXtWOPZZ12
N30le4kj+s6AP7Bt5j9vDjJf1/B0bdKbykEvUFlW0xbrD7YGFZm0HflM0lqwZ6lZ
lql9mqrcooumYZuDt/CxBHsUlRIbiR/Bzd4qdkCkpxHo7aXLRk0HyPsK4XG6OulN
4MVHRR8W8Yk87FBDLCw=
=DwU5
-----END PGP SIGNATURE-----
