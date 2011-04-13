From: Greg KH <gregkh@suse.de>
Subject: Re: irq allocation for pci drivers
Date: Tue, 12 Apr 2011 20:40:43 -0700
Message-ID: <20110413034043.GA813@suse.de>
References: <6E21E5352C11B742B20C142EB499E0481CB17E@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481CB17E@TK5EX14MBXC126.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 12, 2011 at 11:57:22PM +0000, KY Srinivasan wrote:
> Greg,
>=20
> =20
>=20
> Has something changed in the PCI code in the Linux-next tree =E2=80=93=
 2.6.39-rc1-12
> with
>=20
> regards to irq allocation? Earlier (a few weeks ago), the vmbus drive=
r would
> get the irq allocated as part
>=20
> of it being now a pci driver. Currently, however the system is settin=
g pdev->
> irq to
>=20
> 0 and needless to say, request_irq() is failing.

{sigh}  Please fix your email client...

Anyway, I have no idea, please use 'git bisect' to track down the
problem commit that causes this.

thanks,

greg k-h
