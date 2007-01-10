From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 12:06:55 -0800
Message-ID: <45A5475F.7090501@goop.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A4C014.9030909@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> quick and dirty sledge hammer fix:
>
> --- paravirt-2.6.20-rc4-hg691.orig/arch/i386/paravirt-xen/enlighten.c
> +++ paravirt-2.6.20-rc4-hg691/arch/i386/paravirt-xen/enlighten.c
> @@ -522,6 +522,7 @@ static fastcall void xen_alloc_pd(u32 pf
>  static fastcall void xen_release_pd(u32 pfn)
>  {
>         make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
> +       memset(__va(PFN_PHYS(pfn)), 0, PAGE_SIZE);
>  }
>
>  static fastcall void xen_release_pt(u32 pfn)
>   =

Ah, OK.

    J
