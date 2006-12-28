From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lhype on 2.6.20-rc2: Guest didn't handle trap 6 at c071b594
	(cr2=00000000,err=0)
Date: Thu, 28 Dec 2006 13:23:33 +1100
Message-ID: <1167272613.30506.5.camel@localhost.localdomain>
References: <20061227132520.GA32685@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061227132520.GA32685@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-12-27 at 14:25 +0100, bert hubert wrote:
> Hi everybody,
> =

> Attracted by the puppies, I'm trying to run lhype. The patch applies clea=
nly
> to 2.6.20-rc2, my .config is in accord with lhype.txt, but when I try to
> launch an instance, I get this:
> =

> $ sudo drivers/lhype/lhype_add 64m 0 vmlinux --tunnet=3D192.168.19.1 --bl=
ock=3Dlinux.img root=3D/dev/lhba
> lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or dire=
ctory
> lhype_add: network: no dma buffer!: No such file or directory
> lhype_add: Running guest failed: No such file or directory
> =

> When I subsequently retry, I get the same, but third and following tries
> only give:
> =

> lhype_add: Running guest failed: No such file or directory
> =

> $ dmesg | tail
> lhype: mapped hypervisor at ffc00000
> (...)
> Guest didn't handle trap 6 at c071b594 (cr2=3D00000000,err=3D0)
> Guest 0 dead drivers/lhype/init.c:424

Hi Bert!

	Ah, this is your clue, here: looks like the kernel ran BUG() or
otherwise failed at address 0xc071b594...  can you send your .config and
I can see if I can reproduce?  Your System.map should indicate what's at
that address, to...

	I should really try to read out the BUG info in this case; I'll patch
something up today (I'm chasing James Morris' initrd bug at the moment).

Thanks!
Rusty.
