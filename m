From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 23:33:38 -0800
Message-ID: <20061117073338.GM1397@sequoia.sous-sol.org>
References: <20061027145650.GA37582@muc.de> <200611162046.04264.ak@suse.de>
	<20061116202429.GG1397@sequoia.sous-sol.org>
	<200611170547.22192.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200611170547.22192.ak@suse.de>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@suse.de) wrote:
> On Thursday 16 November 2006 21:24, Chris Wright wrote:
> > Looks like the VDSO issue, paravirt is not compatible if COMPAT_VDSO.
> =

> So you're not planning to support old user land with paravirt? =

> Wouldn't it be better to just disable the vDSO completely then? At least
> all old binaries would work then.

Oh, it can be disabled by runtime (/proc/sys/kernel/vdso_enabled) or boot
time (vdso=3D0) option already.  And it should be only an interim timeslice
that is broken, since earlier glibc could only do int 0x80 and newer glibc
can cope with non fixed vDSO.  So most users can just leave it enabled.

thanks,
-chris
