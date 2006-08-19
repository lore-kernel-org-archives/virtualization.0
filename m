From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Sat, 19 Aug 2006 03:46:06 +0100
Message-ID: <44E67B6E.10706@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060819012133.GH7813@stusta.de>
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
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Adrian Bunk wrote:
> These are Linux specific operations.
>
> Without an _GPL you are in the grey area where courts have to decide =

> whether a module using this would be a derived work according to =

> copyright law in $country_of_the_court and therefore has to be GPL.
>
> With the _GPL, everything is clear without any lawyers involved.
>   =


Hardly.  The _GPL is a hint as to the intent of the author, but it is no =

more than a hint.

My intent here (and I think the intent of the other authors) is not to =

cause breakage of things which currently work, so the _GPL is not =

appropriate for that reason.  Paravirt_ops is a restatement of many =

interfaces which already exist in Linux in a non-_GPL form, so making =

the structure _GPL is effectively relicensing them.

    J
