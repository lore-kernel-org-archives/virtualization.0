From: Chris Lalancette <clalance@redhat.com>
Subject: [Fwd: [PATCH]: Fix silly output for virtio devices in
	/proc/interrupts]
Date: Wed, 21 May 2008 15:13:05 +0200
Message-ID: <48341FE1.4070305@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040708000001020808090105"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------040708000001020808090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

(sent to the kvm list erroneously)

--------------040708000001020808090105
Content-Type: message/rfc822;
 name="[PATCH]: Fix silly output for virtio devices in /proc/interrupts.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="[PATCH]: Fix silly output for virtio devices in /proc/interr";
 filename*1="upts.eml"

Return-Path: <kvm-owner@vger.kernel.org>
Received: from pobox.corp.redhat.com ([unix socket])
	 by pobox.corp.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-8.1.RHEL4) with LMTPA;
	 Wed, 21 May 2008 08:53:09 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCr9pa007833;
	Wed, 21 May 2008 08:53:09 -0400
Received: from mx3.redhat.com (mx3.redhat.com [172.16.48.32])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCr86u022734;
	Wed, 21 May 2008 08:53:08 -0400
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mx3.redhat.com (8.13.8/8.13.8) with ESMTP id m4LCqckW008405;
	Wed, 21 May 2008 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbYEUMwy (ORCPT <rfc822;mtosatti@redhat.com> + 6 others);
	Wed, 21 May 2008 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbYEUMwy
	(ORCPT <rfc822;kvm-outgoing>); Wed, 21 May 2008 08:52:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbYEUMwx (ORCPT <rfc822;kvm@vger.kernel.org>);
	Wed, 21 May 2008 08:52:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4LCqqGC000655
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:52:52 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCqpNC022234
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:52:51 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCqnXX007705
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:52:51 -0400
Message-ID: <48341AE1.5000803@redhat.com>
Date: Wed, 21 May 2008 14:51:45 +0200
From: Chris Lalancette <clalance@redhat.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To: kvm@vger.kernel.org
Subject: [PATCH]: Fix silly output for virtio devices in /proc/interrupts
Content-Type: multipart/mixed;
 boundary="------------070404080508030207080503"
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
X-Scanned-By: MIMEDefang 2.63 on 172.16.48.32
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: kvm-owner@vger.kernel.org
Precedence: bulk
List-ID: <kvm.vger.kernel.org>
X-Mailing-List: kvm@vger.kernel.org
X-RedHat-Spam-Score: -2.001 

This is a multi-part message in MIME format.
--------------070404080508030207080503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

register_virtio_device() is doing something silly by overwriting what the caller
put into .bus_id.  This causes the interrupt line for all virtio devices to show
up as "0", "1", etc. in /proc/interrupts.  The attached patch fixes it.

Signed-off-by: Chris Lalancette <clalance@redhat.com>

--------------070404080508030207080503
Content-Type: text/x-patch;
 name="virtio-blk-fix-proc-interrupts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtio-blk-fix-proc-interrupts.patch"

commit cb97605728fc1d7a15ddc6ab689e8bcd23871133
Author: Chris Lalancette <clalance@redhat.com>
Date:   Thu May 15 09:04:55 2008 -0400

    register_virtio_device was doing something silly, in that it was overwriting
    what the calling driver stuck into .bus_id" for the name.  This caused
    problems in the output of /proc/interrupts, since when you request_irq(),
    it doesn't actually copy the devname you pass in but just stores a pointer
    to the data.  The fix is to just not have register_virtio_device do anything
    with the bus_id, and assume the higher level driver set it up properly.

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 138a7f0..1556ac2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -128,7 +128,6 @@ int register_virtio_device(struct virtio_device *dev)
 	int err;
 
 	dev->dev.bus = &virtio_bus;
-	sprintf(dev->dev.bus_id, "%u", dev->index);
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */

--------------070404080508030207080503--
--
To unsubscribe from this list: send the line "unsubscribe kvm" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------040708000001020808090105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------040708000001020808090105--
