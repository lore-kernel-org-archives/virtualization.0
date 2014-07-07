From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/11] qspinlock: Paravirt support
Date: Mon, 7 Jul 2014 17:27:34 +0200
Message-ID: <20140707152734.GX6758__8738.74369212917$1404746879$gmane$org@twins.programming.kicks-ass.net>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.213923590@chello.nl>
	<20140620134608.GA11545@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3420588308047088117=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140620134608.GA11545@laptop.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org


--===============3420588308047088117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B1+FeH9/zg1Fgdnk"
Content-Disposition: inline


--B1+FeH9/zg1Fgdnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 09:46:08AM -0400, Konrad Rzeszutek Wilk wrote:
> I dug in the code and I have some comments about it, but before
> I post them I was wondering if you have any plans to run any performance
> tests against the PV ticketlock with normal and over-committed scenarios?

I can barely boot a guest.. I'm not sure I can make them do anything
much at all yet. All this virt crap is totally painful.


--B1+FeH9/zg1Fgdnk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTurxmAAoJEHZH4aRLwOS6V8kP/2/wBt9lbzbfHPE65HZV/Gk0
vSJ6u+u0ZL3rqRqBkVCRF/YTeg7bE+LSMcR6ZuWwouWvjpzoJyWoNCwUNk62RUr+
pITOJhkQ5ZWOsnjsaA7M6WAJyjQBf8MKK2aquNVO5MxOFShiRmjw5COz/MkBGs9Y
25KKiNaoO+3+/FSUiTPD56XaatUf6tcepG1W0vD08lswZk07HAlGEYX13NZlxMo/
+4YoSxzrcjouShTzSJuLn/WYcVTETVnq9RBmnpBzpEhhAd1ZsQAT9uv1WaUc/f25
bCAvv3rFCnj+UxZkuE8RNp4bPAoxq1VBcFyF+rPnZD13Kxs7CiLI9kxRvNWM2u8x
bQi952q1tUVMSfskl6SrOZ9i16r42f42YkVJMOhDolDBCadknTrczBOQkvC59EkJ
fGI35n0qPfvmhH4cw08lQ4WYAmdIX+snpmIswSJWjWgpHYqldTIHMKIRAfOgQvRa
TVqvzdKNc+Oe28dxDZFsXCGMM8kW8Kx2zPst6+jpzjMQ6k6MVBy+9Iwtr9yChhYy
QsWzTvHOvBC3C5buow3ohOukxedIgG/vckhYRqzkgYPfjXtx+WuycqykYKIb68Lt
+zvmGb76j8VZaVsCWylllEaQ81EL+esw5E9Wlw1lIY2yv9j9uItjWpIgeSqfUUXV
mDvqdGIcLtsltap+YBdV
=00/v
-----END PGP SIGNATURE-----

--B1+FeH9/zg1Fgdnk--

--===============3420588308047088117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3420588308047088117==--
