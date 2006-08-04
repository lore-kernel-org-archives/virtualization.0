From: Andi Kleen <ak@suse.de>
Subject: Re: What do we need to do to hit 2.6.19?
Date: Sat, 5 Aug 2006 00:14:17 +0200
Message-ID: <200608050014.17061.ak@suse.de>
References: <44D39351.9070405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D39351.9070405@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 04 August 2006 20:34, Jeremy Fitzhardinge wrote:
> Chris said, and I agree, that we should try to get the basic PV-ops =

> infrastructure stuff into 2.6.19.  To me this means being able to run a =

> kernel native with CONFIG_PARAVIRT, and see little or no functional or =

> performance degradation.  What do we need to do to get there:
> =

>     * fix the slowdown bug, which seems to be something to do with
>       rdmsr/wrmsr on SMP systems
>     * work out how to handle all the low-level system interfaces, like
>       ACPI, PnP BIOS, APM
>     * what else?

You're already too late for most of this. The merge window will
open in the forseeable future and you don't have had significant
-mm* or x86_64-* testing yet and in general stuff is still
very fresh.

Maybe we can get some basic "obvious" stuff like a few =

macro substitutions in (if you submit them properly), but probably not =

the full support.

-Andi
