From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Virtualization + CPU w/crypto acceleration instructions
Date: Mon, 12 Mar 2007 12:44:45 -0700
Message-ID: <45F5ADAD.2030902@goop.org>
References: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: virtualization@lists.osdl.org, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Molle Bestefich wrote:
> In a virtualized environment running Xen or VMware, can the guest
> operating systems utilize hardware crypto acceleration such as the
> "PadLock" AES acceleration built into VIA CPUs?
>   =


If they're unprivileged instructions, then they should just work.  If
its done via MSRs or some other ring0 mechanism, it might be more tricky.

    J
