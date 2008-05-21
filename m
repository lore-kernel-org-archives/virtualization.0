From: Chris Lalancette <clalance@redhat.com>
Subject: [Fwd: [PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ;
	modprobe]
Date: Wed, 21 May 2008 15:12:39 +0200
Message-ID: <48341FC7.4060600@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050102030801060303070404"
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
--------------050102030801060303070404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

(sent to the kvm mailing list erroneously first)

--------------050102030801060303070404
Content-Type: message/rfc822;
 name="[PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ; modprobe.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="[PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ; m";
 filename*1="odprobe.eml"

Return-Path: <kvm-owner@vger.kernel.org>
Received: from pobox.corp.redhat.com ([unix socket])
	 by pobox.corp.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-8.1.RHEL4) with LMTPA;
	 Wed, 21 May 2008 08:47:09 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCl9AG006117;
	Wed, 21 May 2008 08:47:09 -0400
Received: from mx3.redhat.com (mx3.redhat.com [172.16.48.32])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCl8E7017738;
	Wed, 21 May 2008 08:47:09 -0400
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mx3.redhat.com (8.13.8/8.13.8) with ESMTP id m4LCYXDb027619;
	Wed, 21 May 2008 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761347AbYEUMqj (ORCPT <rfc822;mtosatti@redhat.com> + 6 others);
	Wed, 21 May 2008 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762565AbYEUMqi
	(ORCPT <rfc822;kvm-outgoing>); Wed, 21 May 2008 08:46:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761347AbYEUMqi (ORCPT <rfc822;kvm@vger.kernel.org>);
	Wed, 21 May 2008 08:46:38 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4LCkb8F030197
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:46:37 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCkaLg017421
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:46:36 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4LCka5R006074
	for <kvm@vger.kernel.org>; Wed, 21 May 2008 08:46:36 -0400
Message-ID: <4834196B.3010704@redhat.com>
Date: Wed, 21 May 2008 14:45:31 +0200
From: Chris Lalancette <clalance@redhat.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To: kvm@vger.kernel.org
Subject: [PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ; modprobe
Content-Type: multipart/mixed;
 boundary="------------000406090401050809080102"
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
X-Scanned-By: MIMEDefang 2.63 on 172.16.48.32
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: kvm-owner@vger.kernel.org
Precedence: bulk
List-ID: <kvm.vger.kernel.org>
X-Mailing-List: kvm@vger.kernel.org
X-RedHat-Spam-Score: -1.997 

This is a multi-part message in MIME format.
--------------000406090401050809080102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix a modprobe virtio_blk ; rmmod virtio_blk ; modprobe virtio_blk crash; this
was basically because we weren't doing "del_gendisk()" in the remove path.

Signed-off-by: Chris Lalancette <clalance@redhat.com>

--------------000406090401050809080102
Content-Type: text/x-patch;
 name="virtio-blk-rmmod-crash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtio-blk-rmmod-crash.patch"

commit 9ae82ccb26be0155ad81b2630090e85639a0dc56
Author: Chris Lalancette <clalance@redhat.com>
Date:   Fri May 16 15:31:06 2008 -0400

    Fix a modprobe virtio_blk ; rmmod virtio_blk ; modprobe virtio_blk crash;
    this was basically because we weren't doing "del_gendisk()" in the remove
    path.

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4962e62..c678ac5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -294,6 +294,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	vdev->config->reset(vdev);
 
 	blk_cleanup_queue(vblk->disk->queue);
+	del_gendisk(vblk->disk);
 	put_disk(vblk->disk);
 	unregister_blkdev(major, "virtblk");
 	mempool_destroy(vblk->pool);

--------------000406090401050809080102--
--
To unsubscribe from this list: send the line "unsubscribe kvm" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------050102030801060303070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------050102030801060303070404--
