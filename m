From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: paravirt & xen & SMP
Date: Wed, 10 Jan 2007 10:48:17 -0800
Message-ID: <45A534F1.90609@goop.org>
References: <45A504EE.5050409@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A504EE.5050409@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Anyone has this working?  Looks like there is a chicken-and-egg issue
> with pda setup:
>
>   * xen_load_gdt() uses multicalls, thus depends on cpu-specific
>     variables (per-cpu mc buffer) which in turn requires pda being
>     setup already.
>   * pda setup can't be done before xen_load_gdt() ...
>   =


Good point.  I haven't done any SMP work yet, so if anything works at
all it is pure luck.

> Next question while looking at xen_load_gdt(): why does it use
> multicalls in the first place?  Seems that function puts only one
> hypercall into the multicall array, so there is no obvious point in
> using multicalls ...
>   =


I think you're right; I probably converted it when I swept through and
did the others without really thinking about the bootstrap consequences.

    J
