From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
	address space
Date: Fri, 27 Oct 2006 21:33:08 -0700
Message-ID: <4542DD84.3070006@goop.org>
References: <1161920325.17807.29.camel@localhost.localdomain>	<1161920535.17807.33.camel@localhost.localdomain>	<20061027113001.GB8095@elf.ucw.cz>	<45427ABD.6070407@goop.org>
	<20061027144157.f23fcf89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061027144157.f23fcf89.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> It'd be better to use include/linux/uaccess.h:probe_kernel_address() for
> this operation.
>   =

Ah, yes, that was the precedent I was thinking of,  but I guess it would =

be better to just use it directly.  It's a relatively new interface, =

isn't it?

    J
