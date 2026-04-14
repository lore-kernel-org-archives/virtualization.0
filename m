Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C3383C9D
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210212; cv=none; b=cPNyW7nv9yU8ZIRiX1Z++mr5YoitrltA82iR9DIsobmXFp2hbizFeKHGEGMFKF9R6nTcyjjG6oOHpcyxxiqOV4rJQy4+ZKKs2V68Z4fQfMQA2CqMMiqDaKSbUKaeWRc65UWEO+DTs4CiFA7m3gj3ZZtbAaT9iJUJxtnlVr2DB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210212; c=relaxed/simple;
	bh=Miu0g9DjTMkZ+zTPXVsdPrcxAWHOAxr2mijCOzBROWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR70UURcyGIcBig5HtSUut3LN+i3u697jZdYO1L8ghIhSLOaFZq/d7IxZQPAYrYHjww0um7NltVy/MczNdPCcsdUiskqBHY1fs4AF2ceTEkzIyehOPFVaDr+JWgv2fpfTrG2Q/ygoeKzz8qNkoQqU7ydznm11eolkC+Od65jdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id B2ECE20B7128; Tue, 14 Apr 2026 16:43:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2ECE20B7128
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	niuxuewei.nxw@antgroup.com,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ben Hillis <Ben.Hillis@microsoft.com>,
	Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH net] hv_sock: Report EOF instead of -EIO for FIN
Date: Tue, 14 Apr 2026 16:43:16 -0700
Message-ID: <20260414234316.711578-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
and the final read syscall gets an error rather than 0.

Ideally, we would want to fix hvs_channel_readable_payload() so that it
could return 0 in the FIN scenario, but it's not good for the hv_sock
driver to use the VMBus ringbuffer's cached priv_read_index, which is
internal data in the VMBus driver.

Fix the regression in hv_sock by returning 0 rather than -EIO.

Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
Cc: stable@vger.kernel.org
Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
Reported-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..63d3549125be 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -703,8 +703,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
 		need_refill = !hvs->recv_desc;
-		if (!need_refill)
-			return -EIO;
+		if (!need_refill) {
+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
+			 * be NULL unless it points to the 0-byte-payload FIN
+			 * packet: see hvs_update_recv_data().
+			 *
+			 * Here all the payload has been dequeued, but
+			 * hvs_channel_readable_payload() still returns 1,
+			 * because the VMBus ringbuffer's read_index is not
+			 * updated for the FIN packet: hvs_stream_dequeue() ->
+			 * hv_pkt_iter_next() updates the cached priv_read_index
+			 * but has no opportunity to update the read_index in
+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
+			 * 0 for the FIN packet, so it won't get dequeued.
+			 */
+			return 0;
+		}
 
 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
 		if (!hvs->recv_desc)
-- 
2.49.0

