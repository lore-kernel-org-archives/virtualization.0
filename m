From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt build fix
Date: Wed, 01 Nov 2006 14:40:36 -0800
Message-ID: <45492264.4040009@goop.org>
References: <Pine.LNX.4.44.0611011724300.31378-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0611011724300.31378-100000@redline.boston.redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> Currently, 020-paravirt-xen.patch contains inconsistent declarations for =
a =

> bunch of native_read/write functions.  This patch updates the declaration=
s =

> to use unsigned long for register values.
>
> Signed-off-by: James Morris <jmorris@redhat.com>
>   =

Thanks.  I'd already gone through and fixed those up locally, and was =

about to push them out.

    J
