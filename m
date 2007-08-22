From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 11:18:00 +0200
Message-ID: <200708221118.00990.borntraeger__33776.33726127$1187774435$gmane$org@de.ibm.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
	<1187753365.6174.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187753365.6174.26.camel@localhost.localdomain>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 22. August 2007 schrieb Rusty Russell:
> +struct desc_pages
> +{
> +	/* Page of descriptors. */
> +	struct lguest_desc desc[NUM_DESCS];
> +
> +	/* Next page: how we tell other side what buffers are available. */
> +	unsigned int avail_idx;
> +	unsigned int available[NUM_DESCS];
> +	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
> +
> +	/* Third page: how other side tells us what's used. */
> +	unsigned int used_idx;
> +	struct lguest_used used[NUM_DESCS];
> +};

Please consider to add this patch to make this data structure work on 64 =
bit=20
to make the second page, really page aligned. On 32 bit this should be a=20
no-op.

Signed-Off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/lguest/lguest_virtio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: lguest/drivers/lguest/lguest_virtio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- lguest.orig/drivers/lguest/lguest_virtio.c
+++ lguest/drivers/lguest/lguest_virtio.c
@@ -33,11 +33,12 @@ struct desc_pages
 {
 	/* Page of descriptors. */
 	struct lguest_desc desc[NUM_DESCS];
+	char pad0[PAGE_SIZE - NUM_DESCS * sizeof(struct lguest_desc)];
=20
 	/* Next page: how we tell other side what buffers are available. */
 	unsigned int avail_idx;
 	unsigned int available[NUM_DESCS];
-	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
+	char pad1[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
=20
 	/* Third page: how other side tells us what's used. */
 	unsigned int used_idx;


--=20
IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Herbert Kircher=20
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
