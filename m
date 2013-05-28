From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 16:06:02 +0200
Message-ID: <51A4B9CA.50506@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
	<51A381D9.5010800@redhat.com> <20130527160437.GA18270@redhat.com>
	<51A38552.9050808@redhat.com> <20130527170259.GA18800@redhat.com>
	<51A46D0B.9080508@redhat.com> <20130528104503.GD5467@redhat.com>
	<51A4913F.5050206@redhat.com> <20130528114402.GA21107@redhat.com>
	<51A49D33.8090008@redhat.com> <20130528133256.GC4889@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528133256.GC4889@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 28/05/2013 15:32, Michael S. Tsirkin ha scritto:
> At this point I am confused. I think there are two changes in your patch:
> 
> 1. Handling of VIRTIO_F_GUEST_MUST_TELL_HOST
>  Is this functionally identical to what I proposed?
>  If yes, I am fine with either change being applied.

Yes.

> 2. New SILENT_DEFLATE feature
>  Since guest can get same functionality by not acking
>  TELL_HOST, I still don't see what good it does:
>  Historically a host with no features supports silent
>  deflate and guest with no features can do silent deflate.
>  I conclude silent deflate is the default behaviour for
>  both host and guest, and we can't change default without
>  breaking compatibility.

You're right that for correctness the existing feature is enough:
if it is not negotiated by the guest, the host ensures correctness by
only giving the guest a fake balloon.

However, the new feature is about optimization, not correctness.
In fact, VIRTIO_BALLOON_F_SILENT_DEFLATE is the optimization
feature that VIRTIO_BALLOON_F_MUST_TELL_HOST was meant to be.

What I'm interested in, is drivers that can _optionally_ use silent 
deflation (as an optimization).  These should not get a fake balloon!

With the new feature bit, these drivers should propose both
VIRTIO_BALLOON_F_GUEST_TELLS_HOST and VIRTIO_BALLOON_F_SILENT_DEFLATE.
The driver can then use silent  deflation if and only if the host
has negotiated  VIRTIO_BALLOON_F_SILENT_DEFLATE too.  Like this:

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index bd3ae32..05fe948 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -186,12 +186,8 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
 		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
-	/*
-	 * Note that if
-	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
-	 * is true, we *have* to do it in this order
-	 */
-	tell_host(vb, vb->deflate_vq);
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_SILENT_DEFLATE)
+		tell_host(vb, vb->deflate_vq);
 	mutex_unlock(&vb->balloon_lock);
 	release_pages_by_pfn(vb->pfns, vb->num_pfns);
 }
@@ -543,6 +539,7 @@ static int virtballoon_restore(struct virtio_device *vdev)
 static unsigned int features[] = {
 	VIRTIO_BALLOON_F_MUST_TELL_HOST,
 	VIRTIO_BALLOON_F_STATS_VQ,
+	VIRTIO_BALLOON_F_SILENT_DEFLATE,
 };
 
 static struct virtio_driver virtio_balloon_driver = {


Of course with the current implementation of the balloon it does not
matter much.  But for example, with Luiz's work, releasing pages as soon
as the shrinker is called will increase effectiveness of the shrinker.
At the same time, not all is lost if the guest prefers not to allow
silent deflation (e.g. because there is an assigned device).

On old hosts, a guest that can optionally use silent deflation will
not use it.  That's the same as for any other feature bit.

> How about splitting the patches so we can discuss them separately?

I can do that, but I hope the above clarifies it.

Paolo
