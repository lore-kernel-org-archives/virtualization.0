From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 16:25:19 +0200
Message-ID: <20060822142519.GX11651@stusta.de>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<1156254965.27114.17.camel@localhost.localdomain>
	<1156254322.2976.55.camel@laptopd505.fenrus.org>
	<200608221550.57603.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608221550.57603.ak@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 22, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
> =

> > this would need a "const after boot" section; which is really not hard
> > to make and probably useful for a lot more things.... todo++
> =

> except for anything that needs tlb entries in user space. And it only giv=
es you
> false sense of security. --todo

What's the alternative?

Change it from a struct to a compile time choice?
This should address both the security concerns and your tlb issues at =

the price of runtime flexibility.

> -Andi

cu
Adrian

-- =


    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli
