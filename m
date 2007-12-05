From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 18:15:49 +0000
Message-ID: <4756EAD5.9050407@cl.cam.ac.uk>
References: <C37C979D.19732%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010706080902020106070903"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C37C979D.19732%Keir.Fraser@cl.cam.ac.uk>
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
--------------010706080902020106070903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keir Fraser wrote:
> Yes, this would work okay I suspect. Good enough as a stop-gap measure? Are
> there any other responsibilities that you acquire if you make use of
> VM_FOREIGN (in particular, how would this affect get_user_pages)?

VM_FOREIGN is already set for the gntdev VMA (mostly because it's 
directly based on the blktap code). That means that it has the array of 
page_structs in its vm_private_data, which can be used to fulfill a 
get_user_pages call. I've attached a patch based on this fix.

Regards,

Derek.

--------------010706080902020106070903
Content-Type: text/x-patch;
 name="gntdev_vm_foreign.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gntdev_vm_foreign.patch"

# HG changeset patch
# User dgm36@ise.cl.cam.ac.uk
# Date 1196878124 0
# Node ID df7d0555ec3847bd5915063d8ee79123d6ebc67a
# Parent  ba918cb2cf7520604dee724dd80dad5ce4bee8a1
Changed vm_normal_page to return NULL when presented with a VMA marked
as being VM_FOREIGN.

Signed-off-by: Derek Murray <Derek.Murray@cl.cam.ac.uk>

diff -r ba918cb2cf75 -r df7d0555ec38 mm/memory.c
--- a/mm/memory.c	Tue Dec 04 11:54:22 2007 +0000
+++ b/mm/memory.c	Wed Dec 05 18:08:44 2007 +0000
@@ -395,6 +395,9 @@ struct page *vm_normal_page(struct vm_ar
 		if (!is_cow_mapping(vma->vm_flags))
 			return NULL;
 	}
+
+	if (unlikely(vma->vm_flags & VM_FOREIGN))
+		return NULL;
 
 	/*
 	 * Add some anal sanity checks for now. Eventually,

--------------010706080902020106070903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------010706080902020106070903--
