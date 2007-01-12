From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Fri, 12 Jan 2007 09:31:19 +0100
Message-ID: <45A74757.5030101@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A65B7C.6050503@suse.de>
	<1168570436.31891.16.camel@localhost.localdomain>
	<20070112042343.GZ10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070112042343.GZ10475@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> diff -r e1974f36aa13 arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c	Wed Jan 10 18:19:52 2007 -0800
> +++ b/arch/i386/kernel/setup.c	Thu Jan 11 18:32:22 2007 -0800
[ ... ]
> @@ -643,7 +646,7 @@ void __init setup_arch(char **cmdline_p)
>  =

>  #ifdef CONFIG_VT
>  #if defined(CONFIG_VGA_CONSOLE)
> -	if (!efi_enabled || (efi_mem_type(0xa0000) !=3D EFI_CONVENTIONAL_MEMORY=
))
> +	if (vgacon_enabled && (!efi_enabled || (efi_mem_type(0xa0000) !=3D EFI_=
CONVENTIONAL_MEMORY)))
>  		conswitchp =3D &vga_con;
>  #elif defined(CONFIG_DUMMY_CONSOLE)
>  	conswitchp =3D &dummy_con;
[ ... ]

Approach looks fine to me, please put into the paravirt patch queue.

Well, maybe we can make the efi stuff just set vgacon_disabled too to
make the whole thing more readable.

Hmm, one more thing:  I think we should set conswitchp to dummy_con in
case vgacon is disabled.  Otherwise the vt subsystem isn't initialized
at all and we'll have problems making fbcon+pvfb work later on ...

cheers,

  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
