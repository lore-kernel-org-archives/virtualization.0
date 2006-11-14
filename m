From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm2: warnings in MODPOST and later
Date: Tue, 14 Nov 2006 15:09:02 -0800
Message-ID: <20061114150902.f772c75c.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114225622.GO22565@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061114225622.GO22565@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Nov 2006 23:56:22 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Since people were recently complaining about too many warnings:
> Here is a list of the warnings I'm getting in MODPOST and later.
> =

> Since the warnings by far exceed the 100kB limit of linux-kernel (sic), =

> I had to attach them compressed.
> =

> With the exception of the "drivers/ide/pci/atiixp:FFFF05", none of these =

> warnings is present in Linus' tree.

yes, lots of new section mismatch warnings.

A large number of them are due to the paravirt patches:

WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458470) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458478) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458480) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458488) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458490) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc0458498) and '__=
stop_parainstructions'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .parains=
tructions between '__start_parainstructions' (at offset 0xc04584a0) and '__=
stop_parainstructions'
WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.t=
ext: from .parainstructions after '' (at offset 0x18)
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.t=
ext: from .parainstructions after '' (at offset 0x20)
WARNING: drivers/ata/pata_legacy.o - Section mismatch: reference to .init.t=
ext: from .parainstructions after '' (at offset 0x28)
WARNING: drivers/ata/pata_qdi.o - Section mismatch: reference to .init.text=
: from .parainstructions after '' (at offset 0x0)
WARNING: drivers/ata/pata_qdi.o - Section mismatch: reference to .init.text=
: from .parainstructions after '' (at offset 0x8)

but there are others too.
