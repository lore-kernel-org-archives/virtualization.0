From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Clean up x86 control register and MSR macros
Date: Tue, 10 Apr 2007 10:31:10 -0700
Message-ID: <461BC9DE.5030009__2251.30260591886$1176255990$gmane$org@zytor.com>
References: <200704101648.l3AGmT5e027601@tazenda.hos.anvin.org>
	<461BC350.4040403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461BC350.4040403@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> =

> Is having separate bit numbers and masks useful?  If so, is it worth
> doing for the others?
> =


I presume it's useful, or at least *used* in the current code, since =

that was there already.  If deemed useful, it's something we could add =

to the other bitmasks.

	-hpa
