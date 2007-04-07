From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 07/20] Allow paravirt backend to choose kernel PMD sharing
Date: Fri, 06 Apr 2007 17:40:13 -0700
Message-ID: <4616E86D.30904@goop.org>
References: <20070404191151.009821039@goop.org>	<20070404191205.392155702@goop.org>	<20070406164139.08cd343b.akpm@linux-foundation.org>	<4616DFB2.4020802@goop.org>
	<20070406172844.12f7b8e7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070406172844.12f7b8e7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> Something like that.  I don't want to redo my patch if we're going to cha=
nge
> your patch ;)
>   =


OK.  I won't specifically redo it on top of your patches, but I'll
rework it to remove the inline function and add the if() statement.  Do
you want an incremental update or a complete replacement?

    J
