From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 19:35:03 +0100
Message-ID: <1156271703.27114.32.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<200608221550.57603.ak@muc.de> <20060822142519.GX11651@stusta.de>
	<200608221654.10558.ak@muc.de>  <44EB40A3.50700@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44EB40A3.50700@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

Ar Maw, 2006-08-22 am 10:36 -0700, ysgrifennodd Zachary Amsden:
> Write protection is great as a debug option to find accidental memory =

> corruptions.  It is useless as a technique to prevent subversion.  Um =

> hello, you're already at CPL-0.  Just rewrite the page tables already.

That depends upon how clever you are.  However if you want to load a
hypervisor under a running kernel and from it then you need an updatable
paravirt_ops.

Alan
