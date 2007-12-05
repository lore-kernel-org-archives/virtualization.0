From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 13:19:58 +0000
Message-ID: <4756A57E.7050108@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
	<4755B158.3030008@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060802040709000409030906"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4755B158.3030008@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060802040709000409030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gerd,

Can you try the attached patch against linux-2.6.18-xen.hg?

I think the problem was that the gntdev VMA is not marked as being 
VM_PFNMAP, therefore it tries to get a struct page_struct for each 
granted page when it is unmapped (and maybe sometimes succeeds 
(incorrectly), which could be why I haven't seen the bug). With this 
flag, vm_normal_page will return NULL in zap_pte_range, and so the code 
that decrements that reference count will not be executed.

Regards,

Derek.

--------------060802040709000409030906
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
Set gntdev VMA to be VM_PFNMAP.

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

--------------060802040709000409030906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------060802040709000409030906--
