From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 2/4] Introduce a new fields "gtime" and
	"cgtime" in task_struct and signal_struct
Date: Mon, 20 Aug 2007 15:52:57 +0200
Message-ID: <200708201552.57617.borntraeger__15321.7690218755$1187619107$gmane$org@de.ibm.com>
References: <46C99392.3050205@bull.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C99392.3050205@bull.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, 20. August 2007 schrieb Laurent Vivier:
> Index: kvm/fs/proc/array.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kvm.orig/fs/proc/array.c=A0=A0=A0=A02007-08-20 11:11:30.000000000 +=
0200
> +++ kvm/fs/proc/array.c=A02007-08-20 13:04:03.000000000 +0200

Just a heads up, this patch collides with this fix in mm:
http://marc.info/?l=3Dlinux-mm-commits&m=3D118737949222362&w=3D2

If Ingo accepts this fix, your patch should be adopted in array.c to use=20
cputime_t for gtime as well. Lets see what Ingo thinks.


Christian
