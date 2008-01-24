From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] Fix compile warnings in virtio_balloon
Date: Thu, 24 Jan 2008 16:14:30 -0600
Message-ID: <47990DC6.6020203@us.ibm.com>
References: <12012049981852-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090602020304030000020307"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12012049981852-git-send-email-aliguori@us.ibm.com>
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
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090602020304030000020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Anthony Liguori wrote:
> On x86_64, min was throwing a warning.  ARRAY_SIZE is unsigned long so let's
> switch to using that for num.
>
> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>   

Okay, that just changed the warning to occur on i386.  Please use the 
attached patch instead which just casts within the min macro.

Regards,

Anthony Liguori


--------------090602020304030000020307
Content-Type: text/x-patch;
 name="virtio:balloon_min.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtio:balloon_min.diff"

Subject: [PATCH] Fix compile warnings in virtio_balloon
Cc: Rusty Russell <rusty@rustcorp.com.au>

On x86_64, min was throwing a warning. Let's explicitly cast to avoid the
warning.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9de85ae..cb7f1df 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -85,7 +85,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
 {
 	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
+	num = min(num, (unsigned int)ARRAY_SIZE(vb->pfns));
 
 	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
 		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
@@ -126,7 +126,7 @@ static void leak_balloon(struct virtio_balloon *vb, unsigned int num)
 	struct page *page;
 
 	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
+	num = min(num, (unsigned int)ARRAY_SIZE(vb->pfns));
 
 	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
 		page = list_first_entry(&vb->pages, struct page, lru);

--------------090602020304030000020307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------090602020304030000020307--
