From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 0/6] i386 gdt and percpu cleanups
Date: Sat, 31 Mar 2007 12:56:01 +1000
Message-ID: <1175309761.12230.422.camel@localhost.localdomain>
References: <20070331020042.003398870@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070331020042.003398870@goop.org>
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

>  - some improvements to asm-i386/percpu.h to make asm access to percpu
>    variables easy

One nitpick: I'd really like PER_CPU() renamed to PER_CPU_ADDR().
That's a separate patch, but I think would be far clearer.

Thanks,
Rusty.
