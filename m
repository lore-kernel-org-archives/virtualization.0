From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: What do we need to do to hit 2.6.19?
Date: Fri, 4 Aug 2006 16:50:04 -0700
Message-ID: <20060804235004.GQ2654@sequoia.sous-sol.org>
References: <44D39351.9070405@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44D39351.9070405@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris said, and I agree, that we should try to get the basic PV-ops =

> infrastructure stuff into 2.6.19.  To me this means being able to run a =

> kernel native with CONFIG_PARAVIRT, and see little or no functional or =

> performance degradation.  What do we need to do to get there:
> =

>    * fix the slowdown bug, which seems to be something to do with
>      rdmsr/wrmsr on SMP systems

I believe this is fixed now, at least it's booting fine on my smp box now.

 #define wrmsr_safe(msr,a,b) ({                                \
-      u64 _l =3D ((u64)(a) << 32) | (b);                        \
+      u64 _l =3D ((u64)(b) << 32) | (a);                        \
       paravirt_ops.write_msr((msr),_l);                       \
 })

thanks,
-chris
