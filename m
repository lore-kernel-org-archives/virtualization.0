From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
Date: Wed, 19 Jun 2013 12:25:47 +0930
Message-ID: <87wqpqn70s.fsf@rustcorp.com.au>
References: <20120909113650.GA2775@redhat.com>
	<20121112170308.GB18220@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121112170308.GB18220@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Sun, Sep 09, 2012 at 02:36:50PM +0300, Michael S. Tsirkin wrote:
>> Drivers treat MUST_TELL_HOST as optional: windows drivers do not ack it
>> and expect this means they can tell host *after* deflate.  This was not
>> the intent but the documentation was not very clear on this point.
>> 
>> Luckily hyprevisors did not implement this feature yet so to provide
>> guidance for future devices make spec match drivers expectations, and
>> clarify that this feature only has effect if negotiated.
>> This is needed as recent developments in kvm (memory
>> region rework and the addition of vfio) finally make
>> it practical to implement this in devices.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> ping

OK, I just s/set/negotiated:

--- virtio-spec.txt.old	2013-06-17 16:03:51.875066122 +0930
+++ virtio-spec.txt	2013-06-17 16:07:42.291063924 +0930
@@ -2411,9 +2411,9 @@
     it has previously given to the balloon, as described above. 
     This descriptor is added to the deflateq.
 
-  (b) If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the 
-    guest may not use these requested pages until that descriptor 
-    in the deflateq has been used by the device.
+  (b) If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is 
+    negotiated, the guest may not use these requested pages until 
+    that descriptor in the deflateq has been used by the device.
 
   (c) Otherwise, the guest may begin to re-use pages previously 
     given to the balloon before the device has acknowledged their 

I'm think we get rid of the output queue for balloon in future.

Cheers,
Rusty.
