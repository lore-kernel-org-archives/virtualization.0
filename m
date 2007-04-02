From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable
	entries
Date: Sun, 01 Apr 2007 23:48:31 -0700
Message-ID: <4610A73F.4030807@goop.org>
References: <20070402055652.610711908@goop.org>
	<20070402055704.278590661@goop.org> <200704020812.18320.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704020812.18320.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> What do the benchmarks say with CONFIG_PARAVIRT on native hardware
> compared to !CONFIG_PARAVIRT. e.g. does lmbench suffer? =

>   =


I haven't measured it, but I'll do some experiments.

    J
