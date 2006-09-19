From: Andi Kleen <ak@muc.de>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Tue, 19 Sep 2006 10:26:13 +0200
Message-ID: <200609191026.13483.ak@muc.de>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<1158653031.23629.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158653031.23629.1.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 19 September 2006 10:03, Rusty Russell wrote:
> On Tue, 2006-09-19 at 13:13 +1000, Rusty Russell wrote:
> > Hi Jeremy, all,
> > =

> > 	Sorry this took so long, spent last week in Japan at OSDL conf then
> > netconf.  After several false starts, I ended up with a very simple
> > implementation, which clashes significantly with your work since then
> > 8(.  I've pushed the patches anyway, but it's going to be significant
> > work for me to re-merge them, so I wanted your feedback first.
> =

> OK, here's a patch against 2.6.18-rc6-mm2.  Tested on UP and SMP.
> Crashes on hotplugging CPU, but crashes in same way as before the patch
> 8).

The incremental patches are madness and unmergeable. =

Can you please just do fresh patches with PDA stuff dropped first? =


-Andi
