From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [Xen-devel] [PATCH 2/10] linux 2.6.18: COMPAT_VDSO
Date: Tue, 06 Mar 2007 07:52:47 +0000
Message-ID: <45ED2BDF.76E4.0078.0@novell.com>
References: <45EC098D.76E4.0078.0@novell.com> <45EC787B.2020807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EC787B.2020807@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, xen-devel@lists.xensource.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

>Ingo just raised this as an issue for paravirt_ops as well.  I don't
>quite follow what's going on there.   My understanding is that there are
>some old versions of glibc (which were unreleased CVS snapshots shipped
>by some vendors) which don't use the vdso's ELF header, but instead have
>their own canned one which built into the library itself.

Perhaps you meanwhile saw the similar question from Keir regarding this
(and my answer), but in short: plain glibc 2.3.2 (at least) supports AT_SYS=
INFO
but not AT_SYSINFO_HDR. In this scenario, moving the vDSO around is fine,
but glibc-internal (arguably broken) consistency checks prevent the vDSO fr=
om
being accepted when not using COMPAT_VDSO.

Jan
