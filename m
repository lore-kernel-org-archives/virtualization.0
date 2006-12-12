From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 12:11:46 -0800
Message-ID: <457F0D02.3040000@goop.org>
References: <457E0460.4030107@goop.org> <200612120827.56363.ak@suse.de>
	<457E830D.6010801@goop.org> <200612121301.08444.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200612121301.08444.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> I don't think being incompatible to old binaries is a sensible default. T=
hat
> is why I changed the wrong default. If paravirt ops cannot supply
> a compatible vdso it has to do without one.

Do you know what glibc2.1 actually needs from the vdso?  Does it
actually interpret as an elf file, or just it just jump into it to
perform syscalls?  I wonder if we could use a fault in the vdso memory
range to act as a syscall, or something like that?

    J
