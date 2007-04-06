From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Thu, 05 Apr 2007 17:29:52 -0700
Message-ID: <46159480.20108@zytor.com>
References: <1174533374.2713.104.camel@localhost.localdomain>
	<46159256.1040705@zytor.com> <461592AA.4060103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461592AA.4060103@goop.org>
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
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> =

> That patch got dropped, and replaced by one which pulled all the flags
> definitions out of <asm/processor.h>
> =


Saw that a little too late :)

In general, it would be nice if the various CPU constants were all =

defined in one place, so I'd rather suggest protecting the appropriate =

parts of asm/processor.h with #ifndef __ASSEMBLY__.

	-hpa
