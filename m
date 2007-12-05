From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 14:30:37 +0000
Message-ID: <4756B60D.7030205@cl.cam.ac.uk>
References: <C37C6497.196D6%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060500050106050507060306"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C37C6497.196D6%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060500050106050507060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keir Fraser wrote:
> Is this patch to go into linux-2.6.18-xen.hg then?

Yes, even if it doesn't fix the exact bug we're seeing here, I think it 
should go in. I've attached a version with my signed-off-by and a better 
commit comment.

Cheers,

Derek.

--------------060500050106050507060306
Content-Type: text/x-patch;
 name="gntdev_vm_pfnmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gntdev_vm_pfnmap.patch"

# HG changeset patch
# User dgm36@ise.cl.cam.ac.uk
# Date 1196860382 0
# Node ID af26b3dd23822190acbec1872a47259e1fed88b8
# Parent  b2768401db943e66af9d64bd610ffa225f560c0b
Add VM_PFNMAP flag to gntdev-mmaped VM areas. This prevents an attempt in
zap_pte_range to decrement the reverse-mapping count of the non-existant
(but occasionally spuriously present) page_struct associated with the
granted PFN.

Signed-off-by: Derek Murray <Derek.Murray@cl.cam.ac.uk>

diff -r b2768401db94 -r af26b3dd2382 drivers/xen/gntdev/gntdev.c
--- a/drivers/xen/gntdev/gntdev.c	Mon Dec 03 08:50:12 2007 +0000
+++ b/drivers/xen/gntdev/gntdev.c	Wed Dec 05 13:13:02 2007 +0000
@@ -501,6 +501,17 @@ static int gntdev_mmap (struct file *fli
     
 	/* The VM area contains pages from another VM. */
 	vma->vm_flags |= VM_FOREIGN;
+
+	/* The VM area contains pages that are not backed by page_structs in
+	 * this domain's memory map.
+	 *
+	 * TODO/FIXME?: We should probably use the VM_FOREIGN workaround as
+	 *              used by get_user_pages() to provide access to the
+	 *              page_structs for each page, but I'm not sure if that's
+	 *              necessary.
+	 */
+	vma->vm_flags |= VM_PFNMAP;
+
 	vma->vm_private_data = kzalloc(size * sizeof(struct page_struct *), 
 				       GFP_KERNEL);
 	if (vma->vm_private_data == NULL) {

--------------060500050106050507060306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------060500050106050507060306--
